#!/bin/bash

# sip_status.sh  - generate sipstatus.html to include in zabbix screen

# place that wherever you want
HTMLFILE='/var/www/html/sipstatus.html'
FONT="<font color=black face='verdana, arial, helvetica, sans-serif' size='2' />"

/bin/echo "<html><body><table>" > $HTMLFILE
/usr/sbin/asterisk -rx "sip show peers" | \
/bin/grep -E -v --text -i 'trunk-|sip peers|Forcerport' | \
/bin/gawk '{print $1,$8}' | \
/bin/sed 's/\/.* / /' | \
while LINE= read -r line; do
        SIPNUMBER=`/bin/echo $line | /bin/gawk '{print $1}'`
        SIPNAME=`/usr/sbin/asterisk -rx "database show" | /bin/grep AMPUSER | /bin/grep cidname | /bin/grep $SIPNUMBER | /usr/bin/tr '/' ' ' | /bin/sed 's/AMPUSER.* ://'`
        SIPSTATUS=`/bin/echo $line | /bin/gawk '{if ($2 == "OK") print "ONLINE"; else print "OFFLINE"}'`
        if [ $SIPSTATUS == 'OFFLINE' ]; then
                COLOR='#FFBBBB'
        fi
        if [ $SIPSTATUS == 'ONLINE' ]; then
                COLOR='BBFFBB'
        fi

        /bin/echo "<tr><td bgcolor=$COLOR>" $FONT $SIPNUMBER "</td><td bgcolor=$COLOR>" $FONT $SIPNAME "</td><td bgcolor=$COLOR>" $FONT $SIPSTATUS "</td></tr>" >> $HTMLFILE
done
/bin/echo "</table></body></html>" >> $HTMLFILE
