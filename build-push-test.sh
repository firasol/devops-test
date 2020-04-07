#!/bin/sh

if [ -z "$REGISTRY_PATH" ]
then
      echo "\$REGISTRY_PATH is empty"
      exit 1
else
      echo "  >>>>>>> Using [ \$REGISTRY_PATH=$REGISTRY_PATH ] as the container registry path"
fi

# build the container
echo "  >>>>>>> Building container image file"
sudo docker build . -t $REGISTRY_PATH/hello-world-py:latest

# push it to the container registry (docker hub)
echo "  >>>>>>> Pushing container image to [ $REGISTRY_PATH ]"
sudo docker push $REGISTRY_PATH/hello-world-py:latest

# create a deployment file given the container registry path
sed "s/{{REGISTRY_PATH}}/${REGISTRY_PATH}/g" k8s/templates/hello-world-dep.yaml > k8s/hello-world-dep.yaml

echo "  >>>>>>> Removing old k8s resources"
kubectl delete -f k8s/

echo "  >>>>>>> Applying new k8s resources"
kubectl apply -f k8s/

echo "  >>>>>>> Testing endpoint using http://hello.world.py/ endpoint"
export ENDPOINT_URL="http://hello.world.py/"
until $(curl --output /dev/null --silent --head --fail $ENDPOINT_URL); do
    printf '.'
    sleep 1
done
curl $ENDPOINT_URL -i

