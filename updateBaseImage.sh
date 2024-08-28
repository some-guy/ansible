#!/bin/bash
sudo cp /var/lib/libvirt/images/Rocky-9-GenericCloud-Base.latest.x86_64.qcow2 /var/lib/libvirt/images/test.qcow2

sudo virt-customize \
  -a /var/lib/libvirt/images/test.qcow2 \
  --edit '/etc/default/grub:
    s/^GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="mitigations=off nosplash ipv6.disable=1 edd=off selinux=0 /' \
  --edit '/etc/default/grub:
    s/crashkernel=auto/cashkernel=128M/' \
  --run-command 'grub2-mkconfig --update-bls-cmdline -o /boot/grub2/grub.cfg' \
  --run-command 'dnf config-manager --set-enabled crb' \
  --install epel-release,vim \
  --install btop,htop \
  --run-command 'dnf clean all'

#    --run-command 'dnf update -y --exclude=kernel*' \
#    --run-command 'rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org' \
#    --run-command 'dnf install -y https://www.elrepo.org/elrepo-release-9.el9.elrepo.noarch.rpm' \
#    --run-command 'dnf --enablerepo=elrepo-kernel install -y kernel-ml' \
#    --append-line '/etc/yum.conf:exclude=kernel*' \
