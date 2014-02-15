# Windows autologon

##Overview

Setting up autologon for selected user.

##Module Description

Puppet is not providing any extended features for windows and usualy is not able to execute in current user context. This module adds ability to set autologon
 for windows and all puppet scripts will execute in current user context. Handy!

##Setup

###Install

Git: `git clone git@github.com:noma4i/puppet-windows_autologon.git windows_autologon`
> <font color='red'>**Make sure this module folder is named windows_autologon**</font>

##Usage

To set `Administrator` account as autologon:

    auto_login { 'Administrator':
      password => 'TRICKY_PASSWORD',
      count => '10',
    }


Param `count` will set autologon count and will disable automatic logon feature after N times. If you skip it user will be not limited for autologon sessions.

##License

[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)


