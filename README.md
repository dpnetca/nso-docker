# NSO Docker File

Credit to: https://github.com/NSO-developer/container-examples/tree/master/nso-docker which was used as a starting point for this project

See https://dpnet.ca/2019/06/21/lab-nso-with-docker-container/ for a more thorough walkthrough of creating and using this docker image

## Creating Docker Image
The Steps below are tested for creating and running the container on a Ubutnu host, if using a different OS your syntax and results my vary
1. Download DockerFile, and run-nso.sh files (and optionally build.sh)
2. Download NSO install files for linux: https://developer.cisco.com/docs/nso/#!getting-nso/downloads
3. extract the download (so you get the nso-5.1.0.1.linux.x86_64.installer.bin file)
4. make sure your dockerfile, nso installer.bin file, and run-nso.sh file are all in the same directory
5. Do either of the following:
    * build docker image: `docker build --build-arg NSOVER=5.1.0.1 -t dpnetca/nso-base:latest .` 
        * make sure NSOVER matches the NSO version you downloaded, this was 5.1.0.1 for me. 
        * make sure your Tag (after hte -t) uses your information not mine (i.e. replace dpnetca with your name)
    * edit version number and container name as approrpirate in build.sh file and run `sh build.sh`
6. run docker image `docker run -d -p 2022:2022 -p 2024:2024 -p 8080:8080 dpnetca/nso-base:latest` again, replace the container name with the name you used in the build.
    * Alternatively if you run `docker run -d -P dpnetca/nso-base:latest` these ports will automatically be mapped to random high port numbers which can be seen using `docker ps`

Once the Docker container loads you can access the webpage from your host machine at http://localhost:8080  default credentials are admin/admin

PORT USAGE:
* 8080 is used for http webui as well as REST and RESTCONF
* 2022 is used for NETCONF SSH
* 2024 is used for SSH access to NSO
* 8088 (not mapped) is disabled by default, but can be used for HTTPS
* 2023 (not mapped) is disabled by default but can be used for NETCONF TCP



if you wish to access the console of the container, from a terminal window run `docker ps` to get the container ID, now run `docker exec -it <container-id> bash` to be placed into the container bash shell

There are some HTML and PDF administration documents on docker container in the NSO install directory at /root/nso/doc/  to copy these to your local machine, with the docker container running, from the host machine use the command `docker cp <container-id>:/root/nso/doc .`