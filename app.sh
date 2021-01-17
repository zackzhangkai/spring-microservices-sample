#/bin/sh

# Usage: sh app.sh 
# Description: 
# 1. create application
# 2. inject sidecar
# 3. label the resources which belongs to the application

set -x 

if [ -z $1 ]; then 
  for i in `ls | grep -service`;do ls $i/*yaml; sed 's/$BUILD_NUMBER/1/g' $i/*yaml | kubectl apply -f - ;done
fi 

# Create Application
kubectl apply -f application.yaml

NAME=config-sample
NAMESPACE=kubesphere-springcloud-sample

deploy_name=( config-sample department-sample employee-sample gateway-sample organization-sample proxy-sample eureka-sample )
for i in "${deploy_name[@]}";do
  sh -x inject.sh $NAMESPACE $i

  kubectl -n $NAMESPACE label deploy/$i app.kubernetes.io/name=springcloud-microservice app.kubernetes.io/version=v1 --overwrite

  kubectl -n $NAMESPACE label svc/$i app.kubernetes.io/name=springcloud-microservice app.kubernetes.io/version=v1 --overwrite

  kubectl -n $NAMESPACE annotate svc/$i servicemesh.kubesphere.io/enabled="true"
  kubectl -n $NAMESPACE annotate deploy/$i servicemesh.kubesphere.io/enabled="true"

done

sts_name=( eureka-sample )
for i in "${sts_name[@]}";do
  sh -x inject.sh $NAMESPACE $i sts
  kubectl -n $NAMESPACE annotate sts/$i servicemesh.kubesphere.io/enabled="true"
  kubectl -n $NAMESPACE label sts/$i app.kubernetes.io/name=springcloud-microservice app.kubernetes.io/version=v1 --overwrite
  kubectl -n $NAMESPACE label svc/$i app.kubernetes.io/name=springcloud-microservice app.kubernetes.io/version=v1 --overwrite
done
