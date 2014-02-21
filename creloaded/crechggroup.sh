#!/bin/bash

# Only useful IF you run PHP DSO in cPanel/Apache2

if [ "$#" -lt "1" ];then
echo "Must specify user"
exit;
fi

USER=$@

for user in $USER
do

HOMEDIR=$(grep $user /etc/passwd | cut -d: -f6)

if [ ! -f /var/cpanel/users/$user ]; then
echo "$user user file missing, likely an invalid user"

elif [ "$HOMEDIR" == "" ];then
echo "Couldn't determine home directory for $user"

else

echo "Setting ownership and permissions for user $user"
chown -R $user.$user $HOMEDIR/public_html/*.*
chown -R $user.nobody $HOMEDIR/public_html/cache $HOMEDIR/public_html/debug $HOMEDIR/public_html/temp $HOMEDIR/public_html/tmp $HOMEDIR/public_html/images
chown -R $user.nobody $HOMEDIR/public_html/admin/backups $HOMEDIR/public_html/admin/feeds $HOMEDIR/public_html/admin/images/graphs
chown $user.nobody $HOMEDIR/public_html/includes/header_tags.php
chown $user.nobody $HOMEDIR/public_html/includes/key
chown $user.nobody $HOMEDIR/public_html/includes/key/*.php
chown $user.nobody $HOMEDIR/public_html/includes/header_tags.php
chown $user.nobody $HOMEDIR/public_html/includes/languages/english/contact_us.php
chown $user.nobody $HOMEDIR/public_html/includes/languages/english/mainpage.php
chown $user.nobody $HOMEDIR/public_html/includes/languages/english/header_tags.php

chmod 0664 $HOMEDIR/public_html/includes/header_tags.php
chmod 0664 $HOMEDIR/public_html/includes/languages/english/contact_us.php
chmod 0664 $HOMEDIR/public_html/includes/languages/english/mainpage.php
chmod 0664 $HOMEDIR/public_html/includes/languages/english/header_tags.php
chmod 0664 $HOMEDIR/public_html/includes/header_tags.php
chmod 0664 $HOMEDIR/public_html/debug/*.txt
chmod 0664 $HOMEDIR/public_html/temp/*.txt
chmod 0664 $HOMEDIR/public_html/admin/backups/*.*
chmod 0664 $HOMEDIR/public_html/admin/feeds/*.*
chmod 0775 $HOMEDIR/public_html/cache $HOMEDIR/public_html/debug $HOMEDIR/public_html/temp $HOMEDIR/public_html/tmp $HOMEDIR/public_html/images $HOMEDIR/public_html/admin/backups $HOMEDIR/public_html/admin/feeds

find $HOMEDIR/public_html/images/ -type f -exec chmod 0664 {} \; -print
find $HOMEDIR/public_html -name ".htaccess" -exec chown $user.$user {} \; -print
find $HOMEDIR/public_html -name ".htaccess" -exec chmod 0644 {} \; -print
fi
done
