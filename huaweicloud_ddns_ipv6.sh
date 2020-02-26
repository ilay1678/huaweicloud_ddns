#!/bin/bash
# Author LVCS
# https://github.com/lllvcs/huaweicloud_ddns
# https://gitee.com/lvcs/huaweicloud_ddns
# 在运行此脚本之前，请先在DNS管理控制台内添加对应域名AAAA记录！
# Please add the corresponding domain name record in the DNS management console before running this shell script!
# 一般来说用户名和账户名相同

#用户名
username=""
#账户名
accountname=""
#密码
password=""

#域名
domain="example.com"
#主机名
host="ipv6"

#获取ip地址网址
GETIPURL="v6.ip.zxinc.org/getip"
#GETIPURL="https://v6.yinghualuo.cn"
#GETIPURL="https://ip.lsy.cn/getip"
#GETIPURL="https://www.ipqi.co"

#从外网api获取ip地址(开启1/关闭0 默认开启)
REMOTE_RESOLVE=0

#从网卡获取ip地址(填写网卡名 如eth0 ens3 he-ipv6)
#并请根据实际情况填写sed行数(第96 98行处)
INTERFACE=""

TARGET_IP=""

#End Point 终端地址 请根据地域选择
iam="iam.myhuaweicloud.com"
#iam="iam.ap-southeast-1.myhuaweicloud.com"
#iam="iam.ap-southeast-3.myhuaweicloud.com"

dns="dns.myhuaweicloud.com"
#dns="dns.ap-southeast-1.myhuaweicloud.com"
#dns="dns.ap-southeast-3.myhuaweicloud.com"


token_X="$(
    curl -L -k -s -D - -X POST \
        "https://$iam/v3/auth/tokens" \
        -H 'content-type: application/json' \
        -d '{
    "auth": {
        "identity": {
            "methods": ["password"],
            "password": {
                "user": {
                    "name": "'$username'",
                    "password": "'$password'",
                    "domain": {
                        "name": "'$accountname'"
                    }
                }
            }
        },
        "scope": {
            "domain": {
                "name": "'$accountname'"
            }
        }
    }
  }' | grep X-Subject-Token
)"

token="$(echo $token_X | awk -F ' ' '{print $2}')"

recordsets="$(
    curl -L -k -s -D - \
        "https://$dns/v2/recordsets?name=$host.$domain." \
        -H 'content-type: application/json' \
        -H 'X-Auth-Token: '$token | grep -o "id\":\"[0-9a-z]*\"" | awk -F : '{print $2}' | grep -o "[a-z0-9]*"
)"

RECORDSET_ID=$( echo $recordsets | cut -d ' ' -f 1)
ZONE_ID=$(echo $recordsets | cut -d ' ' -f 2 | cut -d ' ' -f 2)

if [ -z $TARGET_IP ]; then
    if [ $REMOTE_RESOLVE -eq 1 ]; then
        if [ $INTERFACE ]; then
            TARGET_IP=$(curl -s -6 --interface $INTERFACE $GETIPURL)
        else
            TARGET_IP=$(curl -s -6 $GETIPURL)
        fi
    else
        if [ $INTERFACE ]; then
            TARGET_IP=$(ip -6 address show "$INTERFACE" | grep inet6 | awk '{print $2}' | cut -d'/' -f1 | head -n 1 | grep -v "^$" | sort -u)
        else
            TARGET_IP=$(ip -6 address show | grep inet6 | awk '{print $2}' | cut -d'/' -f1 | head -n 1 | grep -v "^$" | sort -u)
        fi
    fi
fi

curl -X PUT -L -k -s \
    "https://$dns/v2/zones/$ZONE_ID/recordsets/$RECORDSET_ID" \
    -H "Content-Type: application/json" \
    -H "X-Auth-Token: $token" \
    -d "{\"records\": [\"$TARGET_IP\"],\"ttl\": 1}"
logger -t "【更新dns地址解析】" "完成"
