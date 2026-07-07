#!/bin/bash
set -e

folders=(
"/srv/nfs/SwinceOMatik"
"/srv/nfs/minecraft"
"/srv/nfs/soundboard"
"/srv/nfs/tasks"
)


for f in "${folders[@]}"; do
  # Create folder if missing
  mkdir -p "$f"

  # Set permissions
  chown -R nobody:nogroup "$f"
  chmod 777 "$f"

  # Add export entry if missing
  if ! grep -qE "^$f " /etc/exports; then
    echo "$f *(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
    echo "Added export for $f"
  else
    echo "Export for $f already exists"
  fi
done

# Reload export table without restarting NFS server
exportfs -ra

echo "Folders created, permissions set, exports updated."
