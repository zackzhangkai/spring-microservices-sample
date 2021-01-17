#!/bin/sh
# Description: inject sidecar automatically
# Require: Download istioctl firstly, and set it to PATH

set -x 
set -e 

if [ -z $1 ] || [ -z $2 ]; then echo "Usage: sh -x $0 <namespace> <deployment>"; exit -1;fi

NS=$1
WORKLOAD=$2
TYPE=$3

if [ -z $3 ]; then TYPE=deployment; fi

INJ_SRC_FILE=/tmp/deploment.yaml
INJ_DST_FILE=/tmp/dst_deployment.yaml

kubectl -n $NS get $TYPE $WORKLOAD -oyaml > $INJ_SRC_FILE

# Capture cluster configuration for later use with kube-inject
kubectl -n istio-system get cm istio-sidecar-injector-1-6-10  -o jsonpath="{.data.config}" > /tmp/inj-template.tmpl
kubectl -n istio-system get cm istio-1-6-10 -o jsonpath="{.data.mesh}" > /tmp/mesh.yaml
kubectl -n istio-system get cm istio-sidecar-injector-1-6-10 -o jsonpath="{.data.values}" > /tmp/values.json

# Use kube-inject based on captured configuration
istioctl kube-inject -f $INJ_SRC_FILE \
        --injectConfigFile /tmp/inj-template.tmpl \
        --meshConfigFile /tmp/mesh.yaml \
        --valuesFile /tmp/values.json > $INJ_DST_FILE

kubectl -n $NS replace -f $INJ_DST_FILE

