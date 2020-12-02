#!/bin/bash

BASEDIR=$(dirname "${BASH_SOURCE}")
pushd ${BASEDIR}

docker build --rm --tag greenhorn:salt-minion-centos8 --file ../minion/Dockerfile .
docker build --rm --tag greenhorn:salt-minion-centos8 --file ../master/Dockerfile .

popd
