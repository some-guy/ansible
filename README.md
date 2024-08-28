just a place to store random stuff for mike's homelab k8s cluster

hosts are libvirt based VMs
create hosts as follows:

run createk8s.sh, which basically just runs
for i in control worker1 worker2 ; do ./create.sh k8s-$i ; done


once k8s-* hosts exist

configure k8s cluster:

`ansible-playbook -i hosts.yml config.yml -l k8s`

this will run the k8s role against the cluster and will init cluster on the control machine and join the workers to the cluster.
