require("luci.sys")

m = Map("ddns", translate("PoDdns"), translate("Simple Dnspod-CN DDNS client, only support IPv4."))

s = m:section(TypedSection, "poddns", "Common")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
token = s:option(Value, "token", translate("Token"))

s = m:section(TypedSection, "domain", "Domain")
s.addremove = false
s.anonymous = true

iface = s:option(Value, "iface", translate("Interface"))
sub_domain = s:option(Value, "sub_domain", translate("Sub Domain"))
main_domain = s:option(Value, "main_domain", translate("Main Domain"))
domain_id = s:option(Value, "domain_id", translate("Domain ID"))
record_id = s:option(Value, "record_id", translate("Record ID"))
record_line = s:option(Value, "record_line", translate("Record Line"))


return m
