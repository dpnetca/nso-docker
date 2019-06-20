# NSO Docker File

Credit to: https://github.com/NSO-developer/container-examples/tree/master/nso-docker which was used as a starting point for this project

## Creating Docker Image
The Steps below are tested for creating and running the container on a Ubutnu host, if using a different OS your syntax and results my vary
1. Download DockerFile, and run-nso.sh files (and optionally build.sh)
2. Download NSO install files for linux: https://developer.cisco.com/docs/nso/#!getting-nso/downloads
3. extract the download (so you get the nso-5.1.0.1.linux.x86_64.installer.bin file)
4. make sure your dockerfile, nso installer.bin file, and run-nso.sh file are all in the same directory
5. Do either of the following:
    * build docker image: `docker build --build-arg NSOVER=5.1.0.1 -t dpnetca/nso-base:latest .` note make sure NSOVER matches the NSO version you downloaded, was 5.1.0.1 for me. and make sure your Tag uses your information not mine (i.e. replace dpnetca with your name)
    * edit version number and container name as approrpirate in build.sh file and run `sh build.sh`
6. run docker image `docker run -p 8080:8080 dpnetca/nso-base:latest` again, repalce the container name with the name you used in the build

Once the Docker container loads you can access the webpage from your host machine at http://localhost:8080  default credentials are admin/admin

if you wish to access the console of the container, from a new terminal window run `docker ps -a` to get the container ID, now run `docker exec -it <container-id> bash` to be placed into the contaienr bash shell

There are some HTML and PDF administration documents on docker container in the NSO install directory at /root/nso/doc/  to copy these to your local machine, with the docker container running, from the host machine use the command `docker cp <container-id>:/root/nso/doc .`