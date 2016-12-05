#!/bin/bash
#
#############################################
#
#iptables by Wahdi
#
#############################################
#
#
#
#memperbolehkan koneksi 2 arah
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#memperbolehkan akses ssh hanya ip address 10.10.1.80
iptables -A INPUT -s 10.10.1.80 -p tcp --dport 22 -j ACCEPT

#memperbolehkan akses protokol http
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

#membiarkan semua trafik loopback
iptables -A INPUT -i lo -j ACCEPT

#ijinkan ping 
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT

#iptables default drop
iptables -P INPUT DROP

IPTABLES -A INPUT -p tcp --tcp-flags SYN,ACK SYN,ACK -m state --state NEW -j DROP
IPTABLES -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

IPTABLES -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
IPTABLES -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
IPTABLES -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j DROP

IPTABLES -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j DROP
IPTABLES -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j DROP
IPTABLES -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j DROP
IPTABLES -A INPUT -p tcp --tcp-flags ACK,URG URG -j DROP

iptables -A INPUT -p tcp --dport 80 -m state --state NEW -m limit --limit 250/second --limit-burst 300 -j ACCEPT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -m limit --limit 250/second --limit-burst 250 -j ACCEPT
