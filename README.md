
# devops-test

- `minikube` was used to develop this example:
```bash
$ Minikube Version
Minikube Version: V1.9.2
Commit: 93af9c1e43cab9618e301bc9fa720c63d5efa393
```
- Ingress addon needs to be enabled for minikube
```bash
$ minikube addons enable ingress
```
- Get minikube ip:
```bash
$ minikube ip
172.17.0.2
```
And append this line to the end of `/etc/hosts` file:
```172.17.0.2 hello.world.py```
`hello.world.py` is a dummy URL this application would respond on

- Please make sure that your local docker config points to a container registry that is accessible by minikube. For this example, I have used docker hub to push the container image to before kubernetes can pull and run within the Pod

- Run the following on the command line in order to automate the build, publish, and test stages:
```bash
$ ./build-publish-test.sh
```
An output similar to the following should show that the app has deployed and is responding to requests to the url: `http://hello.world.py/`
```bash
$ curl http://hello.world.py/ -i
HTTP/1.1 200 OK
Server: openresty/1.15.8.2
Date: Tue, 07 Apr 2020 19:20:11 GMT
Content-Type: text/html; charset=utf-8
Content-Length: 12
Connection: keep-alive
Hello World!
```
