#!/bin/bash

rm -rf ~/.rho.conf

export RHO_PASSWORD='Rh0P@ssw0rd'
rho initconfig --log-level=info

SERVERS=servers.csv

for X in `cat $SERVERS`; do
   VHOST=`echo $X | awk -F";" '{print $1}'`
     VIP=`echo $X | awk -F";" '{print $2}'`
   VUSER=`echo $X | awk -F";" '{print $3}'`
   export RHO_AUTH_PASSWORD=`echo $X | awk -F";" '{print $4}'`
   
   echo -e "\n\nHOSTNAME: $VHOST IP: $VIP USER:$VUSER\n"
   
   rho scan --show-fields
   rho scan --range $VIP --username=$VUSER --port 22 --output RHO-Environment_$VHOST.csv --log-level=info
   
   unset RHO_AUTH_PASSWORD

done

rm -rf ~/.rho.conf
unset RHO_PASSWORD
