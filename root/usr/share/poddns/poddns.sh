#!/bin/sh

[ $(uci -q get poddns.config.enable) = 1 ] || exit 0
token=$(uci -q get poddns.config.token)
sub_domain=$(uci -q get poddns.domain.sub_domain)
main_domain=$(uci -q get poddns.domain.main_domain)
logger -t poddns "Start update DDNS for $sub_domain.$main_domain"
record=$(curl -4 -X POST https://dnsapi.cn/Record.List -d "login_token=$token&domain=$main_domain&sub_domain=$sub_domain&format=json" | jsonfilter -e "@.records[0]")
record_id=$(echo $record | jsonfilter -e "@.id")
line_id=$(echo $record | jsonfilter -e "@.line_id")
local_ip=$(ifstatus wan | jsonfilter -e '@["ipv4-address"][0].address')
curl -4 -X POST https://dnsapi.cn/Record.Ddns -d "login_token=$token&format=json&domain=$main_domain&record_id=$record_id&record_line_id=$line_id&sub_domain=$sub_domain&value=$local_ip" | jq | logger -t poddns
