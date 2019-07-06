#!/bin/sh

IPADDR=`ifconfig eth1 | grep -i Mask | awk '{print $2}'| cut -f2 -d:`
sudo cat /etc/kubernetes/admin.conf|sed -E "s/(server: https:\/\/).+(:.+)$/\1$IPADDR\2/" > /vagrant/config
echo "kubectl config copied to config file; add this to ~/.kube/config or run kubectl --kubeconfig config get nodes"


STATUS=""
while [ "$STATUS" != "NotReady" ]
do
    echo "Waiting to connect to vagrant node"...
    sleep 10s
    STATUS=`kubectl get nodes|grep vagrant|awk '{ print $2; }'`
done
echo "Connected to vagrant node"

echo "Installing pod network add-on"
kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')
echo "Pod network add-on installed"

echo "Untainting master node to allow workloads to run on master node"
kubectl taint nodes --all node-role.kubernetes.io/master-
echo "Master node untainted"

STATUS=""
while [ "$STATUS" != "Ready" ]
do
    echo "Waiting for vagrant node to be Ready"...
    sleep 10s
    STATUS=`kubectl get nodes|grep vagrant|awk '{ print $2; }'`
done
echo "Vagrant node ready"

echo "Setting up kubernetes admin dashboard"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl create serviceaccount cluster-admin-dashboard-sa
kubectl create clusterrolebinding cluster-admin-dashboard-sa --clusterrole=cluster-admin --serviceaccount=default:cluster-admin-dashboard-sa

kubectl describe secret `kubectl get secret | grep cluster-admin-dashboard-sa|awk '{ print $1; }'`|grep -E 'token:' > /vagrant/token
echo "Kubernetes dashboard installed. To access run kubectl proxy and navigate to http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"
echo "It can take a few minutes before dashboard is available (you might get HTTP 503 at first)"
echo "Use token in /vagrant/token:"
cat /vagrant/token
echo "Setup complete."
