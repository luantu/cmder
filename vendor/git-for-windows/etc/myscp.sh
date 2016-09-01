#!/bin/sh

FILE=$1

if [ $# -ne 1 ];then
    echo "choose file which you want to copy to server"
    exit
fi


scp ${FILE} wangxiaoyang@172.24.130.5:/wxy/odl_test/
