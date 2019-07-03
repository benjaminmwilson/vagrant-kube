Based on <https://medium.com/@lizrice/kubernetes-in-vagrant-with-kubeadm-21979ded6c63>
with changes:

- Set VM memory to 6Gb
- Select bridge network instead of NAT

May need to:

	sudo "/Library/Application Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh" restart

... if receive error `Failed to create the host-only adapter` according to <https://stackoverflow.com/questions/21069908/vboxmanage-error-failed-to-create-the-host-only-adapter>

## Installing Kubernetes Dashboard

See <https://docs.giantswarm.io/guides/install-kubernetes-dashboard/>



