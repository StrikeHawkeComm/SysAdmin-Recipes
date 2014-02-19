#!/bin/bash
IFS="$"

cd /home

ls /var/cpanel/users | grep -v "root\|nobody\|mysql" | while read CUSER; do
  CPATH=$(grep "${CUSER}:x:" /etc/passwd | grep -v ':0:0:' | head -1 | cut -d':' -f6 | cut -d':' -f1)
  groupid=$(grep ${CUSER} /etc/passwd|cut -f4 -d":");

  if [ -d ${CPATH}/public_html ]; then
     chown -Rhc ${CUSER} ${CPATH}/public_html/*
  fi
done
