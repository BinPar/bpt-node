#!/bin/bash

environments=$1
cd ./k8s/templates
for environment in $environments
do
  rancher kubectl apply -f ../compiled/$environment.yml
done
