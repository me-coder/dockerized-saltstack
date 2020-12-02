#!/bin/bash

# Set locale
# [[ $(dnf -q list glibc-langpack-en >/dev/null) ]] || dnf -q -y install glibc-langpack-en
# export LANG=en_US.utf-8
# export LC_ALL=en_US.utf-8

function install_minion {
    dnf install -y --nogpgcheck epel-release && \
        dnf install -y --nogpgcheck https://repo.saltstack.com/py3/redhat/salt-py3-repo-3002.el8.noarch.rpm && \
        dnf update -y && \
        dnf install -y salt-minion && \
        dnf clean all && \
        rm -rf /var/cache/dnf

    mkdir -p {"/var/log/salt/","/etc/salt/minion.d/"} && echo "master: salt-master" |tee /etc/salt/minion.d/dockerized-salt-minion.conf
}

function install_master {
    dnf install -y --nogpgcheck epel-release && \
        dnf install -y --nogpgcheck https://repo.saltstack.com/py3/redhat/salt-py3-repo-3002.el8.noarch.rpm && \
        dnf update -y && \
        dnf install -y salt-master && \
        dnf clean all && \
        rm -rf /var/cache/dnf

    mkdir -p {"/var/log/salt/","/etc/salt/master.d/"} && echo "auto_accept: True" |tee /etc/salt/master.d/dockerized-salt-master.conf
    hostnamectl set-hostname salt-master
}

function usage {
    echo "Usage: bootstrap.sh [--minion] [--master] [--help]"
    exit 2
}


args=$(getopt --name "$0" --options h -l help,minion,master -- "$@")
[[ "$#" -eq "0" ]] && ( usage; exit 1 )
eval set -- $args

while true; do
    case "$1" in
        --master )  install_master
                    shift
                    ;;
        --minion )  install_minion
                    shift
                    ;;
        -h | --help )    usage
                    break
                    ;;
        -- )        shift
                    break
                    ;;
        *)          echo "Invalid option: $1"
                    usage
                    exit 1
                    ;;
    esac
done
