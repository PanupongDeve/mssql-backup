#!/bin/sh

REGISTRY_HOST=
REGISTRY_URL=
USERNAME=
PAT=

sudo docker login $REGISTRY_HOST -u $USERNAME  -p $PAT
sudo docker push $REGISTRY_URL