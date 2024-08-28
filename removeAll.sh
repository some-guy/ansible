#!/bin/bash
set -e
set -x

for i in $(virsh list | grep k8s | awk '{print $2}') ; do 
  virsh destroy $i
  virsh undefine $i --remove-all-storage
done

