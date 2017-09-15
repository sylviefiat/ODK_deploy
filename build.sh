#!/bin/sh

NAME=$(basename $PWD | awk '{print tolower($0)}')

# create the build image
docker build -t ${NAME} -f Dockerfile.build $PWD

