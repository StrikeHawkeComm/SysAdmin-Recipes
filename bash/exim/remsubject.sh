#!/bin/bash

if [ "$#" -lt "1" ];then
echo "Must specify Subject"
exit;
fi
grep -lr 'Delivery not authorized' /var/spool/exim/input/ | sed -e 's/^.*\/\([a-zA-Z0-9-]*\)-[DH]$/\1/g' | xargs exim -Mrm
