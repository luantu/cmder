#!/usr/bin/expect -f  
  
set port 22  
set user wangxiaoyang  
set host 172.24.130.5  
set password wangxiaoyang  
set timeout -1  
  
spawn ssh -D $port $user@$host  
expect "*assword:*"  
  
send "$password\r"  
expect eof  

