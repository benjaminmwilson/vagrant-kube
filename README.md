
# vagrant-kube

Builds a ready-to-use network bridged Kubernetes VM using vagrant

Based on <https://medium.com/@lizrice/kubernetes-in-vagrant-with-kubeadm-21979ded6c63>

## Before You Begin

Both [vagrant](https://www.vagrantup.com/) and a supported virtual
machine environment must be installed; typically
[virtualbox](https://www.virtualbox.org/) is used.

Suggest installing `kubectl` if you want to be able to access your
kubernetes environment without `vagrant ssh`

    brew install kubernetes-cli

...if using brew.


## Setup

From the repo's root directory:

    vagrant up

This will build and start the Kubernetes VM. It can take about 10 minutes.

If using virtualbox, you may need to:

    sudo "/Library/Application Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh" restart

... if receive error `Failed to create the host-only adapter` according to <https://stackoverflow.com/questions/21069908/vboxmanage-error-failed-to-create-the-host-only-adapter>

After the VM has been successfully created:

    vagrant ssh
    vagrant/setup.sh

This will install kubernetes dashboard and save a `config` file that
can be used to connect to the instance via `kubectl`. This is based
on <https://docs.giantswarm.io/guides/install-kubernetes-dashboard/>


## Accessing via kubectl

From the repo's root directory:

    kubectl --kubeconfig config get nodes

This should show:

    NAME      STATUS   ROLES    AGE   VERSION
    vagrant   Ready    master   20m   v1.15.0

...or similar.

The `config` file can be added to `~/.kube/config` to avoid passing
in `--kubeconfig`.


## Accessing via dashboard


From the repo's root directory:

    kubectl --kubeconfig config proxy

...and then access <http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/>

The login token is displayed after `setup.sh` completes and is also
available in the file `token`
