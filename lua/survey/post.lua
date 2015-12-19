-- Copyright (C) Yichun Zhang (agentzh)

local string = require "string"
local cjson = require "cjson"
local table_new = require "table.new"
local table = require "table"

local table_concat = table.concat
local read_body = ngx.req.read_body
local get_post_args = ngx.req.get_post_args
local quote_sql_str = ngx.quote_sql_str
local resty_mysql = require "resty.mysql"
local str_fmt = string.format
local ngx_time = ngx.time

local _M = {}

local fields = {
    "first_name",
    "last_name",
    "country",
    "city",
    "email",
    "homepage",
    "github",
    "twitter",
    "weibo",
    "company",
    "company_url",
    "job_title",
    "department",
    "logo",
    "typical_uses",
    "dev_count",
    "traffic",
    "prod",
    "fun",
    "extern",
    "intern",
    "show_logo",
    "subscribed",
    "will_tell",
    "client_addr",
    "inserted",
}

local field_list = table_concat(fields, ", ")

local values = table_new(#fields, 0)

local function quote(s)
    if not s or s == "" then
        return "NULL"
    end
    return quote_sql_str(s)
end

local function build_value_list(args)
    local ncols = #fields
    -- no need to call table.clear() here since we a fixed set
    -- of keys
    for i, key in ipairs(fields) do
        if key == 'inserted' then
            values[i] = 'from_unixtime(' .. ngx_time() .. ')'
        else
            values[i] = quote(args[key])
        end
    end
    return table_concat(values, ", ")
end

local function fail(...)
    ngx.log(ngx.ERR, ...)
    ngx.req.set_method(ngx.HTTP_GET)
    ngx.status = 500
    ngx.exec("/survey/fail.html")
end

local function warn(...)
    ngx.log(ngx.WARN, ...)
end

function _M.go()
    -- warn("header: ", ngx.req.raw_header())
    read_body()
    local args = get_post_args(#fields)

    -- warn("body: ", ngx.req.get_body_data())
    -- warn("args: ", cjson.encode(args))

    local first_name = quote(args.first_name)
    local last_name = quote(args.last_name)

    local db, err = resty_mysql:new()
    if not db then
        return fail("failed to create mysql instance: ", err)
    end

    local ok, err, errno, sqlstate = db:connect{
        host = "127.0.0.1",
        port = 3306,
        database = "ngx_test",
        user = "ngx_test",
        password = "ngx_test",
        max_packet_size = 1024
    }

    db:set_timeout(1000) -- 1 sec

    if not ok then
        return fail("failed to connect to mysql: ", err, ": ", errno, " ",
                    sqlstate)
    end

    args.client_addr = ngx.var.remote_addr

    local value_list = build_value_list(args)

    local sql = str_fmt("insert into user_survey (%s) values (%s)",
                        field_list, value_list)

    local res, err, errno, sqlstate = db:query(sql)
    if not res then
        return fail("failed to insert a record into mysql: ",
                     err, ": ", errno, ": ", sqlstate, ".")
    end

    local ok, err = db:set_keepalive(10000, 10)
    if not ok then
        return fail("mysql: failed to set keepalive: ", err)
    end

    ngx.req.set_method(ngx.HTTP_GET)
    return ngx.exec("/survey/success.html")
end

return _M
