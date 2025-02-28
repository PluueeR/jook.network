#!/bin/bash
# -------------------------------------------------------------------
#  Synopsis    : Update DNS record using Hosting.nl's API
#  Description : This scripts checks if the public IP address has
#                been changed by comparing it to the dns record in
#                $DNS_RECORD. If so, the dns record gets updated
#                using Hosting.nl's API.
#  Created by  : Joran Kok
#  Created on  : 13-08-2024
#  Version     : 1.0
#  File        : update_dns_record.sh
# -------------------------------------------------------------------
#  Parameters : 1. database name
# -------------------------------------------------------------------
#  Remarks    : none
# -------------------------------------------------------------------
#  Rev  User             Revision date  Comment
#  ---  -------------    -------------  -----------------------------
#  1.0  Joran Kok        23-12-2014     Initial creation.
# -------------------------------------------------------------------

# Set variables
SCRIPT_PATH="/root/"

DNS_RECORD="vpn.jook.network"
DNS_VALUE=$(getent hosts $DNS_RECORD | awk '{ print $1 }')
LOG_FILE=update_dns_record.log
PUBLIC_IP=$(curl ipinfo.io/ip)
TOKEN="b7ea198274eae7282f49d660c7ec3d91cd249f48d521a49fb18a45fc59d8bf5c"

# Check if $DNS_VALUE is still equal to $PUBLIC_IP
if [ $DNS_VALUE != $PUBLIC_IP ]
then
    echo "$(date +'%b %d %Y %T') $HOSTNAME: Public IP address seems to be changed. DNS_VALUE: $DNS_VALUE. PUBLIC_IP: $PUBLIC_IP. Updating." >> $LOG_FILE

    curl -X PUT "https://api.hosting.nl/domains/jook.network/dns" -H "accept: */*" -H "API-TOKEN: $TOKEN" -H "Content-Type: application/json" -H "X-CSRF-TOKEN: " -d "[{\"id\":1005343,\"name\":\"$DNS_RECORD\",\"type\":\"A\",\"content\":\"$PUBLIC_IP\",\"ttl\":300,\"prio\":0}]"
fi