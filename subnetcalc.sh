#!/bin/bash

# Parameter verification
if [ -z "$1" ]; then
    echo "Usage: $0 <IP/CIDR>"
    exit 1
fi

# Input variables
ip_cidr=$1
ip=$(echo "$ip_cidr" | cut -d'/' -f1)
cidr=$(echo "$ip_cidr" | cut -d'/' -f2)

# Calculate subnet mask and addresses using sipcalc
network=$(sipcalc "$ip_cidr" | grep -i "Network address" | awk '{print $4}')
broadcast=$(sipcalc "$ip_cidr" | grep -i "Broadcast address" | awk '{print $4}')
host_min=$(sipcalc "$ip_cidr" | grep -i "Usable range" | awk '{print $4}')
host_max=$(sipcalc "$ip_cidr" | grep -i "Usable range" | awk '{print $6}')
total_hosts=$(( 2 ** (32 - cidr) - 2 ))

# Function to determine the IP class
ip_class() {
    IFS='.' read -r octet1 _ <<< "$ip"
    if (( octet1 >= 1 && octet1 <= 126 )); then echo "Class A"
    elif (( octet1 >= 128 && octet1 <= 191 )); then echo "Class B"
    elif (( octet1 >= 192 && octet1 <= 223 )); then echo "Class C"
    elif (( octet1 >= 224 && octet1 <= 239 )); then echo "Class D (Multicast)"
    else echo "Class E (Experimental)"
    fi
}

# Determine if the IP is private
is_private() {
    case "$ip" in
        10.*|192.168.*|172.16.*|172.17.*|172.18.*|172.19.*|172.2[0-9].*|172.3[0-1].*)
            echo "Private"
            ;;
        *)
            echo "Public"
            ;;
    esac
}

# Results
echo "Network ID      : $network"
echo "Broadcast       : $broadcast"
echo "Total Hosts     : $total_hosts"
echo "Host Range      : $host_min - $host_max"
echo "IP Class        : $(ip_class)"
echo "IP Type         : $(is_private)"
