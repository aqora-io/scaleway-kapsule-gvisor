#!/bin/sh

cp config.toml /k8s-node
cp runsc.toml /k8s-node
cp install-gvisor.sh /k8s-node

/usr/bin/nsenter -m/proc/1/ns/mnt -- chmod u+x /tmp/gvisor/install-gvisor.sh
/usr/bin/nsenter -m/proc/1/ns/mnt /tmp/gvisor/install-gvisor.sh

echo "[$(date +"%Y-%m-%d %H:%M:%S")] Successfully installed gvisor and restarted containerd on node ${NODE_NAME} if needed."

sleep infinity
