# mesos-router

## Docker

### mesos-router Docker Container
  - Debian Jessie
  - Ngnix OpenResty 1.7.10.2

#### Ports

- 8080 # HTTP

## Development

### DNS response with 2 service containers

    core@ip-10-0-6-107 /var/log/mesos $ curl 10.0.7.126:8123/v1/services/_apache._tcp.marathon.mesos
    [
        {
            "service": "_apache._tcp.marathon.mesos",
            "host": "apache-13596-s4.marathon.mesos.",
            "ip": "10.0.2.252",
            "port": "16754"
        },
        {
            "service": "_apache._tcp.marathon.mesos",
            "host": "apache-63815-s4.marathon.mesos.",
            "ip": "10.0.2.252",
            "port": "14961"
        }
    ]

### DNS response with no service containers

    core@ip-10-0-6-107 /var/log/mesos $ curl -i 10.0.7.126:8123/v1/services/_doesnotexist._tcp.marathon.mesos
    HTTP/1.1 200 OK
    Content-Type: application/json
    Date: Thu, 08 Oct 2015 23:05:19 GMT
    Content-Length: 72

    [
        {
            "service": "",
            "host": "",
            "ip": "",
            "port": ""
        }
    ]
