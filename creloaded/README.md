# Creating logrotate for CRE Loaded debug folders #
This source infers **PHP DSO** compile for **Apache2**

Place these two files in your cpanel user root location. /home/yourcpanelusername
In cPanel(tm) filemanager, make logrotate.sh executable with file permission value **0755**
Create an empty file called logrotate.status

Next, create a **CRON** entry via cpanel to run the logrotate.sh file once per day and add your email to be notified of the results.
