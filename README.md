# huaweicloud_ddns  华为云ddns脚本

## 本脚本仅适用于ipv4地址的更新，ipv6版请查看```ipv6```分支
## 网卡地址获取仅适用于openwrt/padavan


## 首次操作
第一步，先在DNS管理控制台```https://console.huaweicloud.com/dns/```内添加对应域名解析记录

第二步，在```huaweicloud_ddns.sh```内填写 ```账号信息``` ```域名信息```

第三步，运行```huaweicloud_ddns.sh```，设置定时任务

## 设置定时任务

### openwrt/lede
将脚本修改后上传到/root

【系统-计划任务】

     * * * * * bash /root/huaweicloud_ddns.sh

### padavan
将脚本修改后上传到/etc/storege

【 系统管理 - 服务 - 计划任务 (Crontab)】

    * * * * * bash /etc/storege/huaweicloud_ddns.sh
    
【 系统管理 - 配置管理 - 保存内部存储到闪存 - 提交】

## 一点说明
华为云目前虽然支持AK/SK调用API进行域名更新，但是在获取```Zone_ID```和```Record_ID```时需要有一个```X-Auth-Token```头的请求，而目前只能通过用户名、账户名和密码三者来获取```X-Auth-Token```，通过AK/SK获取```X-Auth-Token```目前只在华为内部实现，暂不对外开放。
附上获取```Token```的PDF说明文档
