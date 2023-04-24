#!/bin/bash

# enable cgroup
sudo mount -t tmpfs -o uid=0,gid=0,mode=0755 cgroup /sys/fs/cgroup

# start docker
sudo dockerd --iptables=false &
