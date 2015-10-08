local cjson = require "cjson"

-- Get subdomain from host
for string in string.gmatch(ngx.var.host, "([^.]+)") do
    subdomain = string
    break
end

-- Call Mesos DNS for services where subdomain = service name
resp = ngx.location.capture("/__mesos_dns/v1/services/_" .. subdomain .. "._tcp.marathon.mesos")
backends = cjson.decode(resp.body)

-- No backends, return 503 Service Unavailable
if ( #backends < 1 or backends[1].service == '' ) then
    ngx.exit(ngx.HTTP_SERVICE_UNAVAILABLE)
end

-- Seed the random number generator and choose a random backend
math.randomseed(os.time())
backend = backends[ math.random( 1, #backends ) ]

-- Set Nginx target to backend
ngx.var.target = "http://" .. backend.ip .. ':' .. backend.port
