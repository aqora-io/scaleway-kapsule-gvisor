# scaleway-kapsule-gvisor

To allow customers managing by themselves gVisor version and config on Kapsule, we don't provide anymore gVisor installed by default on Kapsule nodes.

This repository, inspired from this [method](https://github.com/neumanndaniel/kubernetes/tree/master/gvisor) allow adding back gVisor on specific nodes.

## Pre-requisite

Target nodes must be in Node pools with this specific tags `gvisor=enabled` and `taint=gvisor=enabled:NoSchedule` to be labeled and tainted correctly. See [the docs on Scaleway](https://www.scaleway.com/en/docs/kubernetes/api-cli/managing-tags/) for more information.

## Installation

Install the helm chart

```bash
helm repo add scaleway-kapsule-gvisor https://aqora-io.github.io/scaleway-kapsule-gvisor
helm install install-gvisor scaleway-kapsule-gvisor/install-gvisor --namespace kube-system
```

You can run a test with the following

```bash
kubectl apply -f test.yaml
```

## Warning

This method will install gVisor on selected nodes using a Daemonset. The associated pod execute a restart of containerd if needed which may affect other pods on the nodes.

Also, the containerd original `config.toml` file is overwritten with the one provided. This config is valid at the current time but may not take into account future parameters added by the Kapsule team. In any case, the config file now leverage `version = 2` to be able to use the `ConfigPath` option which is not the case for the original configuration.

gVisor will leverage systemd-cgroups using the experimental flag provided in `runsc.toml`

## Support

This method is provided as-is and nodes with configuration modified fall outside of the responsability matrix of Scaleway managed Kubernetes. To use it, you need to understand the inner working of containerd runtimes with kubernetes to be able to debug any problem.

Tested on v1.30.2 nodes.
