Based on <https://medium.com/@lizrice/kubernetes-in-vagrant-with-kubeadm-21979ded6c63>
with changes:

- Set VM memory to 6Gb
- Select bridge network instead of NAT

May need to:

	sudo "/Library/Application Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh" restart

... if receive error `Failed to create the host-only adapter` according to <https://stackoverflow.com/questions/21069908/vboxmanage-error-failed-to-create-the-host-only-adapter>

## Installing Kubernetes Dashboard

See <https://docs.giantswarm.io/guides/install-kubernetes-dashboard/>



    3  kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')
    4  kubectl taint nodes --all node-role.kubernetes.io/master-
    5  cat /etc/kubernetes/admin.conf
    6  sudo cat /etc/kubernetes/admin.conf
    7  exit
    8  ping 10.32.0.5
    9  curl
   10  curl http://10.32.0.5
   11  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended/kubernetes-dashboard.yaml

9167  kubectl create serviceaccount cluster-admin-dashboard-sa
 9168  kubectl create clusterrolebinding cluster-admin-dashboard-sa   --clusterrole=cluster-admin \
 9169  kubectl create clusterrolebinding cluster-admin-dashboard-sa --clusterrole=cluster-admin --serviceaccount=default:cluster-admin-dashboard-sa
 9170  kubectl get secret | grep cluster-admin-dashboard-sa
 9171  kubectl describe secret cluster-admin-dashboard-sa-token-ncfk4
 9172  kubectl proxy