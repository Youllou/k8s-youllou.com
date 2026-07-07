#!/bin/bash
set -e

# Install NFS server if not already installed
if ! command -v exportfs &> /dev/null; then
  apt update
  apt install -y nfs-kernel-server
fi

# Enable and start NFS server
systemctl enable nfs-kernel-server
systemctl start nfs-kernel-server

echo "NFS server installed and running."
