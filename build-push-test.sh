#!/bin/sh

# build the container
sudo docker build . -t fabughazaleh/hello-world-py:latest

# push it to the container registry (docker hub)
sudo docker push fabughazaleh/hello-world-py:latest

echo ">>>>>>> Removing old k8s resources"
kubectl delete -f k8s/

echo ">>>>>>> Applying new k8s resources"
kubectl apply -f k8s/

echo ">>>>>>> Sleeping 10seconds"
sleep 10

echo ">>>>>>> Testing endpoint using http://hello.world.py/ endpoint"
curl http://hello.world.py/ -i