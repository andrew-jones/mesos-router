local cjson = require "cjson"

local subdomain = ngx.var.host

for string in string.gmatch(ngx.var.host, "([^.]+)") do
    subdomain = string
    break
end

resp = ngx.location.capture("/__mesos_dns/v1/services/_" .. subdomain .. "._tcp.marathon.mesos")

backends = cjson.decode(resp.body)

math.randomseed(os.time())
backend = backends[ math.random( 1, #backends ) ]

ngx.var.target = "http://" .. backend.ip .. ':' .. backend.port
