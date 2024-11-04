# SubNetCalc

SubNetCalc is a Bash script that calculates detailed subnet information based on an IP address in CIDR notation (e.g., `192.168.1.0/24`). Using `sipcalc`, the script provides key information about the subnet, including Network ID, broadcast address, usable host range, total usable hosts, IP class, and whether the IP is public or private.

## Features

- **Network ID**: Displays the Network ID of the subnet.
- **Broadcast Address**: Shows the broadcast address for the subnet.
- **Host Range**: Displays the range of usable IP addresses for hosts in the subnet.
- **Total Hosts**: Calculates the number of usable hosts (excluding Network ID and broadcast address).
- **IP Class**: Determines if the IP is Class A, B, C, etc.
- **Public or Private IP**: Indicates if the IP address is in a private or public range.

## Requirements

This script requires `sipcalc` to compute subnet information. You can install `sipcalc` on Debian-based systems with:

```bash
sudo apt-get install sipcalc
```

## Usage

Run the script by providing an IP address in CIDR format as a parameter:

```bash
./subnetcalc.sh <IP/CIDR>
```

## Example

```bash
./subnetcalc.sh 192.168.1.0/24
```

## Output Example

```
Network ID      : 192.168.1.0
Broadcast       : 192.168.1.255
Total Hosts     : 254
Host Range      : 192.168.1.1 - 192.168.1.254
IP Class        : Class C
IP Type         : Private
```
