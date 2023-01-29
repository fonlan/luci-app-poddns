#!/bin/sh

[ $(uci -q get poddns.config.enable) = 1 ] || exit 0
token=$(uci -q get poddns.config.token)
sub_domain=$(uci -q get poddns.domain.sub_domain)
main_domain=$(uci -q get poddns.domain.main_domain)
iface=$(uci -q get poddns.domain.iface)
domain_id=$(uci -q get poddns.domain.domain_id)
record_id=$(uci -q get poddns.domain.record_id)
record_line=$(uci -q get poddns.domain.record_line)
local_ip=`ip addr show dev $iface | grep "inet " | awk '{print $2}'`
curl -4 -X POST https://dnsapi.cn/Record.Ddns -d "login_token=$token&format=json&domain_id=$domain_id&record_id=$record_id&record_line=$record_line&sub_domain=$sub_domain&value=$local_ip" | jq | logger -t poddns