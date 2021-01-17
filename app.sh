#/bin/sh

set -x 

kubectl apply -f application.yaml

NAME=config-sample
NAMESPACE=kubesphere-springcloud-sample

name=( config-sample department-sample employee-sample gateway-sample organization-sample proxy-sample eureka-sample )
for i in "${name[@]}";do
  sh -x inject.sh $NAMESPACE $i
  sh -x inject.sh $NAMESPACE $i sts

  kubectl -n $NAMESPACE label deploy/$i app.kubernetes.io/name=springcloud-microservice app.kubernetes.io/version=v1 --overwrite

  kubectl -n $NAMESPACE label sts/$i app.kubernetes.io/name=springcloud-microservice app.kubernetes.io/version=v1 --overwrite

  kubectl -n $NAMESPACE label svc/$i app.kubernetes.io/name=springcloud-microservice app.kubernetes.io/version=v1 --overwrite

  kubectl -n $NAMESPACE annotate svc/$i servicemesh.kubesphere.io/enabled="true"
  kubectl -n $NAMESPACE annotate deploy/$i servicemesh.kubesphere.io/enabled="true"
  kubectl -n $NAMESPACE annotate sts/$i servicemesh.kubesphere.io/enabled="true"

done



