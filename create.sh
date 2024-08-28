#!/bin/bash
set -e
set -x

[[ -z $1 ]] && echo "need hostname" && exit 1

qemu-img create -b /var/lib/libvirt/images/test.qcow2 -f qcow2 -F qcow2 /var/lib/libvirt/images/$1.img 10G

cat << EOF > meta-data
instance-id: $1
local-hostname: $1
EOF

genisoimage -output /var/lib/libvirt/images/$1-cidata.iso -V cidata -r -J user-data meta-data

virt-install \
  --name=$1 \
  --ram=8096 \
  --vcpus=4 \
  --import --disk path=/var/lib/libvirt/images/$1.img,format=qcow2 \
  --disk path=/var/lib/libvirt/images/$1-cidata.iso,device=cdrom \
  --os-variant=rocky9 \
  --network bridge=br0,model=virtio \
  --graphics spice,listen=0.0.0.0 \
  --noautoconsole

rm meta-data
