#!/bin/sh

set -e

# create jenkins namespace
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: jenkins
EOF

# set kubectl namespace
kubectl config set-context --current --namespace=jenkins

# deploy jenkins
kubectl apply -f https://raw.githubusercontent.com/digitalocean/marketplace-kubernetes/master/stacks/jenkins/yaml/jenkins.yaml

# ensure services are running
kubectl rollout status deployment/jenkins
