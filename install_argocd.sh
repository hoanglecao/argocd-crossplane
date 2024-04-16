#!/bin/bash

# Set Namespace variable
NAMESPACE="argocd"
NAMESPACE_EXISTS=$(kubectl get ns | grep $NAMESPACE | wc -l)

# Create Argo CD namespace if it doesn't exist
if [ $NAMESPACE_EXISTS -eq 0 ]; then
  kubectl create namespace $NAMESPACE
fi

# Install Argo CD
kubectl apply -n $NAMESPACE -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Optional: Wait for Argo CD to be fully deployed
echo "Waiting for Argo CD components to be deployed..."
kubectl wait --for=condition=available --timeout=600s deployment --all -n $NAMESPACE

echo "Argo CD has been successfully installed in namespace $NAMESPACE"
