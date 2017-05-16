# shadowsocks

## Run

* Server

sample-server.json:
**before release 0.0.3 use**

```
{
    "log_file": "./log/shadowsocks-server.log",
    "log_level": "debug",
    "log_max_days": 3,
	"port_password": {
		"8387": "foobar",
		"8388": "barfoo"
	},
	"method": "aes-128-cfb",
	"timeout": 600
}
```

 **after release 0.0.3 support network flowcontrol**

```
{
    "log_file": "./log/shadowsocks-server.log",
    "log_level": "debug",
    "log_max_days": 3,
	"port_password": {
		"8387":{"password":"foobar", "ratelimit":"100k"},
		"8388":{"password":"barfoo", "ratelimit":"0"},
		"8389":{"password":"test"}
	},
	"method": "aes-128-cfb",
	"timeout": 600
}
```

```
./shadowsocks-server --config sample-server.json
```

**Run with docker**

```
docker run -d --restart always --net host -v /root/server.json:/server.json -v /root/test.log:/log/shadowsocks-server.log shenshouer/shadowsocks:0.0.4 --config /server.json
```

send SIGHUP to shadowsocks-server pid to reload config: `kill -1 [PID of shadowsocks-server]`

* Client 

You can use the client binary file as follow:

edit `sample-client.json` change `127.0.0.1` to specific server IP:

```
{
    "log_file": "./log/shadowsocks-client.log",
    "log_level": "debug",
    "log_max_days": 3,
	"local_port": 1081,
	"server_password": [
		["127.0.0.1:8387", "foobar"],
		["127.0.0.1:8388", "barfoo", "aes-128-cfb"]
	]
}
```

```
./shadowsocks-client --config sample-client.json
```

then change the socket v5 proxy on your conputer network setting to 127.0.0.1:1081

**OR use shadowsocks-gui client**

shadowsocks-gui for mac    
[ShadowsocksX-2.6.3.dmg](https://github.com/shadowsocks/shadowsocks-iOS/releases/download/2.6.3/ShadowsocksX-2.6.3.dmg)    
[ShadowsocksX-NG-1.2.dmg](https://github.com/shadowsocks/ShadowsocksX-NG/releases/download/1.2/ShadowsocksX-NG-1.2.dmg)    
