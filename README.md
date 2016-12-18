Name
====

openresty-survey - OpenResty Web App for OpenResty User Survey

Table of Contents
=================

* [Name](#name)
* [Initialize the MySQL database](#initialize-the-mysql-database)
* [Run This App with OpenResty](#run-this-app-with-openresty)
* [Author](#author)
* [Copyright and License](#copyright-and-license)

Description
===========

This is the source code for the OpenResty User Survey app built upon OpenResty.

See the sites alive below:

* https://openresty.org/survey/  (English version)
* https://openresty.org/survey/cn  (Chinese version)

Initialize the MySQL database
=============================

Ensure you have the following lines added under the `[mysqld]` group in your `my.cnf` configuration
file for your MySQL server (usually being `/etc/my.cnf`):

```
character-set-server=utf8
collation-server=utf8_general_ci
```

such that your MySQL server uses the UTF-8 character encoding by default. Remember to restart
your MySQL server after this change.

Below we create a MySQL database named `ngx_test` as well as a MySQL user account named
`ngx_test` with the password `ngx_test`.

```console
$ mysql -u root
mysql> create database ngx_test;
mysql> create user 'ngx_test'@'localhost' identified by 'ngx_test';
mysql> grant all privileges on ngx_test.* to 'ngx_test'@'localhost' with grant option;
```

```console
$ cd /path/to/openresty-survey/
$ mysql -u ngx_test ngx_test -p < init/mysql.sql
(type the password "ngx_test")
```

Run This App with OpenResty
===========================

```bash
cd /path/to/openresty-survey/
# update conf/nginx.conf as needed
/usr/local/openresty/nginx/sbin/nginx -p $PWD/ -c conf/nginx.conf
```

Here we assume you installed OpenResty with its default prefix, `/usr/local/openresty`.

Author
======

Yichun Zhang (agentzh) &lt;agentzh@gmail.com&gt;

[Back to TOC](#table-of-contents)

Copyright and License
=====================

This module is licensed under the BSD license.

Copyright (C) 2015-2017, by Yichun "agentzh" Zhang (章亦春) &lt;agentzh@gmail.com&gt;, OpenResty Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[Back to TOC](#table-of-contents)

