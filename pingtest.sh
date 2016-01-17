#!/bin/bash
#--------------------------------------
# Made By Fahad Ahammed (fahad.space)
#
echo "This script will sort the best servers according to ping test."
echo "--------------------------------------"
echo "Please keep patience......"
echo "--------------------------------------"
# Server List
#-------------------
cat <<EOF >> /tmp/serverlist.txt
198.57.47.4 SecureDragon(Portland,OR)
162.211.65.4 SecureDragon(LosAngeles,CA)
162.253.177.4 SecureDragon(Phoenix,AZ)
198.57.46.4 SecureDragon(Denver,CO)
162.211.66.4 SecureDragon(Chicago,IL)
162.253.178.4 SecureDragon(Dallas,TX)
199.167.31.4 SecureDragon(Tampa,FL)
162.211.67.4 SecureDragon(Lenoir,NC)
162.253.176.4 SecureDragon(iscataway,NJ)
107.191.96.26 Ramnode(NewYork)
23.226.229.4 Ramnode(Seattle)
107.191.101.180 Ramnode(Atlanta)
168.235.72.22 Ramnode(LosAngeles)
176.56.238.3 RamNode(Netherlands)
104.244.76.191 BuyVM(ROOST,Luxemberg)
209.141.56.135 BuyVM(LasVegas)
198.98.53.31 BuyVM(NewJersey)
192.121.166.10 VPSDime(Maidenhead,UK)
107.181.148.10 VPSDime(Piscataway,NEWJERSEY)
23.227.167.10 VPSDime(Dallas)
23.92.53.100 VPSDime(LosAngeles)
23.227.163.10 VPSDime(Seattle)
speedtest-sfo1.digitalocean.com DigitalOcean(SanFrancisco)
speedtest-sgp1.digitalocean.com DigitalOcean(Singapore)
speedtest-lon1.digitalocean.com DigitalOcean(London)
speedtest-fra1.digitalocean.com DigitalOcean(France)
speedtest-nyc1.digitalocean.com DigitalOcean(NewYork1)
speedtest-nyc2.digitalocean.com DigitalOcean(NewYork2)
speedtest-nyc3.digitalocean.com DigitalOcean(NewYork3)
speedtest-tor1.digitalocean.com DigitalOcean(Toronto)
speedtest-ams1.digitalocean.com DigitalOcean(Amsterdam1)
speedtest-ams2.digitalocean.com DigitalOcean(Amsterdam2)
speedtest-ams3.digitalocean.com DigitalOcean(Amsterdam3)
fra-de-ping.vultr.com Vultr(Frankfurt,DE)
par-fr-ping.vultr.com Vultr(Paris,France)
ams-nl-ping.vultr.com Vultr(Amsterdam,Netherlands)
lon-gb-ping.vultr.com Vultr(London,UK)
nj-us-ping.vultr.com Vultr(NewYork,USA)
il-us-ping.vultr.com Vultr(Chicago,USA)
ga-us-ping.vultr.com Vultr(Atlanta,USA)
fl-us-ping.vultr.com Vultr(Florida,USA)
hnd-jp-ping.vultr.com Vultr(Tokyo,Japan)
tx-us-ping.vultr.com Vultr(Dallas,USA)
wa-us-ping.vultr.com Vultr(Seattle,USA)
sjo-ca-us-ping.vultr.com Vultr(SiliconValley,USA)
lax-ca-us-ping.vultr.com Vultr(LosAngeles)
syd-au-ping.vultr.com Vultr(Sydney,Australia)
EOF

awk '{print $1}' < /tmp/serverlist.txt | while read ip; do
    if ping -c1 $ip >/dev/null 2>&1; then
        #echo $ip is up.
        avgping=$(ping -c 5 $ip | tail -1| awk '{print $4}' | cut -d '/' -f 2)
        echo "$ip $avgping" >> /tmp/iplatency.txt
    else
        echo $ip IS DOWN
    fi
done


onlylatency=$(cat /tmp/iplatency.txt | awk '{print $2}' | sort -h)
for word in $onlylatency; do
    match1=$(grep "$word" /tmp/iplatency.txt | awk '{print $1}')
    match2=$(grep "$word" /tmp/iplatency.txt | awk '{print $2}')
    match3=$(grep "$match1" /tmp/serverlist.txt)
    echo The Latency of $match3 is "$match2"ms.
    echo -e "\n"
done > /tmp/finaltest.txt

echo "--------------------------------------"
echo "Sorting the Servers by best latency."
echo "--------------------------------------"
cat /tmp/finaltest.txt
echo "--------------------------------------"
echo "Thank You."
echo "--------------------------------------"
# Deleting Junks
#----------------
rm /tmp/serverlist.txt
rm /tmp/iplatency.txt
rm /tmp/finaltest.txt
rm /tmp/pingtest.sh
