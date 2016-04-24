#!/bin/bash

echo "You need to run vagrant for the first time"

echo "to take the invertory file created, and fix it"
PWD=$(pwd)
INV_VAGRANT="$PWD/.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory"
INV_DEST="$PWD/provisioning/hosts.tmp"
grep front $INV_VAGRANT > $INV_DEST
echo "" >> $INV_DEST
echo '[backend]' >> $INV_DEST
grep back $INV_VAGRANT >> $INV_DEST


echo "Beacuse Vagrant has still some issues to create proper ansible inventories"
echo "Or I can't figure it out right now"

ansible-playbook --connection=ssh --timeout=30 --limit=all --inventory-file=$INV_DEST --sudo provisioning/back/playbook.yml
