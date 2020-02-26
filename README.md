# huaweicloud_ddns_ipv6  华为云ddns脚本ipv6版

## 本脚本仅适用于ipv6地址的更新
## 网卡地址获取仅适用于openwrt/padavan

## 首次操作
第一步，先在DNS管理控制台```https://console.huaweicloud.com/dns/```内添加对应域名解析AAAA记录

第二步，在```huaweicloud_ddns_ipv6.sh```内填写 ```账号信息``` ```域名信息```

第三步，运行```huaweicloud_ddns_ipv6.sh```，设置定时任务

## 设置定时任务
```
crontab -e
* * * * * bash /root/huaweicloud_ddns_ipv6.sh
```
