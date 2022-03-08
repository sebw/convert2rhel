#!/bin/bash

# If needed fix your CentOS repo first
# sed -i 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
# sed -i 's|#baseurl=http://mirror.centos.org|baseurl=https://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

if [ ! -x /usr/bin/curl ]; then
    dnf -y install curl
fi

echo "What's your Red Hat username? "
read USERNAME

echo "What's your Red Hat password? "
read -s PASSWORD 

curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt

curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem

curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/8/convert2rhel.repo

yum -y install convert2rhel

convert2rhel --auto-attach --username=$USERNAME --password=$PASSWORD

exit 0

