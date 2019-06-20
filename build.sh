#!/bin/sh

VER="5.1.0.1"  # Set to match your NSO version
CONT=dpnetca/nso-base # Set to match your desired container name

# docker rmi $CONT:$VER
docker rmi $CONT:latest
docker build --build-arg NSOVER=$VER -t $CONT:latest .
# docker tag $CONT:latest $CONT:$VER
# docker push $CONT:$VER
# docker push $CONT:latest