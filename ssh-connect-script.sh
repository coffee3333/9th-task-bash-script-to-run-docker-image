#!/usr/bin/expect -f

set login [lindex $argv 0]
set addr [lindex $argv 1]
set pass [lindex $argv 2]
set port [lindex $argv 3]

set repo [lindex $argv 4]
set tag [lindex $argv 5]

#Connecting via ssh
spawn ssh -p $port  $login@$addr
expect "assword:"
send "$pass\r"

#When we connected, we starts pull from docker
expect "$ " {
	send "sudo docker pull $repo:$tag\r"
}
#Pass for sudo
expect "$login: " {
	send "$pass\r"
}
#Run our image
expect "$ " {
	send "sudo docker run -d --restart=always -p 8080:8080 $repo:$tag\r"
}
#Stay connected 
interact
