#!/bin/bash

namespace=$1
projectName=$2
environment=$3
resourceType=$(echo "$4" | sed y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/)
deployName=$(rancher kubectl -n $namespace get $resourceType -l "app.kubernetes.io/name=$projectName,app.kubernetes.io/instance=$resourceType,app.kubernetes.io/environment=$environment" -o name)
if [ -z "$deployName" ]; then
    echo "$4 for project $projectName in namespace $namespace and environment $environment not found!"
    exit 1
fi
rancher kubectl -n $namespace patch $deployName -p "{ \"spec\": { \"template\": { \"metadata\": { \"labels\": { \"ci-cd-update\": \"`date +'%s'`\" } } } } }"
