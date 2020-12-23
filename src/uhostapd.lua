#!/usr/bin/env lua

require "ubus"
require "uloop"
local json = require "luci.jsonc"

local function get_wifi_interfaces(ctx)
    local status = ctx:call("network.wireless", "status", {})
    local interfaces = {}

    for _, dev_table in pairs(status) do
        for _, intf in ipairs(dev_table['interfaces']) do
        table.insert(interfaces, intf['ifname'])
        end
    end

    return interfaces
end

local function subscribe_interfaces(ctx)
    for _, ifname in ipairs(get_wifi_interfaces(ctx)) do
        print("Subscribing to " .. ifname)
        local sub = {
            notify = function(msg, method)
                local ifname = ifname,
                print(method)
                print(json.stringify(msg))
            end,
        }
        ctx:subscribe("hostapd." .. ifname, sub)
    end
end

uloop.init()
local ctx = ubus.connect()

if not ctx then
	error("Failed to connect to ubus")
end

subscribe_interfaces(ctx)

uloop.run()
