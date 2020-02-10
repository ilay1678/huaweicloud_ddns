# huaweicloud_ddns_ipv6  华为云ddns脚本ipv6版

## 本脚本仅适用于ipv6地址的更新
## 网卡地址获取仅适用于Debian9+/Ubuntu18+（旧版本网卡地址获取请参考old分支）
## 选择网卡获取ipv6地址时，请确认代码第96 98行处sed的行数
## 请确认服务器的地域，并合适选择EndPoint地址

## 安装
ubuntu/debian
```
apt-get update
apt-get install wget curl dnsutils cron -y
wget -N --no-check-certificate https://raw.githubusercontent.com/lllvcs/huaweicloud_ddns/ipv6/huaweicloud_ddns_ipv6.sh
OR
wget -N --no-check-certificate https://gitee.com/lvcs/huaweicloud_ddns/raw/ipv6/huaweicloud_ddns_ipv6.sh
chmod +x ./huaweicloud_ddns_ipv6.sh
```

centos
```
yum install wget curl bind-utils cron -y
wget -N --no-check-certificate https://raw.githubusercontent.com/lllvcs/huaweicloud_ddns/ipv6/huaweicloud_ddns_ipv6.sh
OR
wget -N --no-check-certificate https://gitee.com/lvcs/huaweicloud_ddns/raw/ipv6/huaweicloud_ddns_ipv6.sh
chmod +x ./huaweicloud_ddns_ipv6.sh
```

## 首次操作
第一步，先在DNS管理控制台```https://console.huaweicloud.com/dns/```内添加对应域名解析AAAA记录

第二步，在```huaweicloud_ddns_ipv6.sh```内填写 ```账号信息``` ```域名信息```

第三步，运行```huaweicloud_ddns_ipv6.sh```，设置定时任务

## 设置定时任务
```
crontab -e
* * * * * bash /root/huaweicloud_ddns_ipv6.sh
```
