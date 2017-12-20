#!/bin/bash

source .env

docker-compose up -d
docker run --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/rancher:/var/lib/rancher rancher/agent:v1.2.6 http://staging.teco.edu:8080/v1/scripts/$TOKEN



