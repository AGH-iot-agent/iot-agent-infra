#!/bin/bash

docker build -t iot-agent-maven:3.9-eclipse-temurin-21-alpine -f ./base-images/Dockerfile.maven .
docker build -t iot-agent-eclipse-temurin:21-jre-alpine -f ./base-images/Dockerfile.jre .
docker build -t iot-agent-nginx:alpine -f ./base-images/Dockerfile.nginx .
docker build -t iot-agent-node:20 -f ./base-images/Dockerfile.node .
