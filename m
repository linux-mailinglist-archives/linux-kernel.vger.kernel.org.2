Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD116410E80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 04:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhITCu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 22:50:29 -0400
Received: from mout.gmx.net ([212.227.15.18]:43705 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhITCu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 22:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632106127;
        bh=KMLnea5aci8Y8IY4Y1sbD0p+Sn32uceBooCaIN0Oz7Q=;
        h=X-UI-Sender-Class:From:To:In-reply-to:Subject:Reply-to:References:
         Date;
        b=C8Sw2itXFruDKTdn++BNH/fCqLxbaJnZxskgWPV7GcL9ME40gJW08tQ4u+eHMe2Mj
         AzwGbYNi2qTsMNFowDLU79th8IiK7rmE6XzF3dLcotitPqkqIyr1NAKchCxNkwYkAp
         d4BD8cnYbdNMZ16zrtVEP3BGZNcUxdsX5xJKmbSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIdeR-1mdv4t1m21-00Eg7h; Mon, 20 Sep 2021 04:48:47 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id 9E053899858; Sun, 19 Sep 2021 19:48:24 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-reply-to: <20210907214034.11676-1-schaecsn@gmx.net> (message from Stefan
        Schaeckeler on Tue, 7 Sep 2021 14:40:33 -0700)
Subject: Re: [PATCH 0/1] ubifs: ubifs to export filesystem error counters
Content-Type: text/plain
Reply-to: schaecsn@gmx.net
References:  <20210907214034.11676-1-schaecsn@gmx.net>
Message-Id: <20210920024824.9E053899858@corona.crabdance.com>
Date:   Sun, 19 Sep 2021 19:48:24 -0700 (PDT)
X-Provags-ID: V03:K1:A+HJ1Exsqfbdh8TZcVdFKoj+vS2M/SEbkZgLLaux8ICLBGzDZfB
 SvjZfBTJwj7XpI1FqHMqnABRQRbdZn52skTV7ndSbO2jmAr6XPljQ2LPqS04t4Lg1g+9P1R
 2ju99cHtxOaQKbKO1P/DELgR9Oj8uQrNSSJEZPHjQYUoj4XwHZw2OboV84NlA43hyFMR4v9
 7wgwYD3/3ircBv+tAOs0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T3/jcaRE0WU=:5w8jbEQ1y7ISxAoIeGQdiG
 uHDO5jrlcQd8IquaRKuwgF21MaKtXuTiloYD/8CyMMeDBLaa4YXPzqtaRo+SMFBF0KRLRSumt
 qfLH6xrVIcyA4Sn3aYgRE8dY3RPupX5vHkeAovouY/XLbN8ahF4AL/KrD3rAbi5b4JEdGGCRu
 C21I7p6NJTCDW8Q6NcQ575qeFUhSlhl7nYz6i/6ndSx48X7xQ86eyc/uHD+DJwEwZmcBDV6QN
 gCcdCSSRPHnZqzb6+E9GcCx25Z6Hxze3H4kc4gbwA0bis1jzqwTo83FS0Cl8A7fwEYl1mrRAH
 bBbfwY53NqW9PqIf4SEUGloq6RHZF6g9+Cl62N5DIozzOY8aRnqviFSZxZcraRjzadR6KkY0v
 /MrqJKNlYwttPZwPSJFdF3sO4FTaKiDGqAadLlZzmQTtRSIfP4KDLmccqXlkKn5IT6iFaw3xR
 gi8zqF2GjBt7QqEyFSIm+pqlBeU1ROYsFPqyDmsB7I8NzTh3ZRZIsRYIsUyCJQz2grVUkhv+W
 TyO6+4COI0n1yK+Ix7tEGt5rppjX589lPAT6dO5hwIa4SGu18kYD1BLbpNsMIzeNVljwLvKqT
 emNnV5bOw0f/aVJXu7+IBRhj6RMjYybpu3zDfgHf5fog21l3O1lmF/hZsOc2Z/+6y971t08Yj
 Hwo+Cm861eMjLjR+krpEmMbS9lptZ+XL37Eq0BdmkZ01qgIxvXXAQnEO7Zf4u6+Toirq2LbZS
 PXpezRpSx5tSNJ8sma75doXskw6C28XOZ/d6cdzHY9Hj4d1m5lN0mcU/vfXDvCjjSnsvLZ5DN
 rILzSydo9nGRfVMgZFKqEstChixu9nLiBq3f9w/X95B/4z4XVHut2M2l/O7R0HcXhASzNMbwp
 U2QXaZs35Wd26w+4PxuObWkEgBXLcPP7+wmV6pWGjtHRsAEXfxY8/2avKWptsFGmnk7+SU27R
 EQzsMgLwefPfo3yBG/a+K6G0npTOJVsn3wpFzvutDhqUGHEfxHsPPlpy9UqmLx/mwf3+r0jeI
 uQOb+YMuq9AkohdXRVsZ2hyv0XgIp2yeRUBj0gzX7X1TYj6XEp5FN7l0aSUOiyafbGG56DcjJ
 60nh4aQTv92DN4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello mtd/ubifs,

I just want to check back on what you think about having a sysfs for ubifs=
 and
starting with these three callbacks

/sys/fs/ubifs/ubiX_Y/errors_magic
/sys/fs/ubifs/ubiX_Y/errors_node
/sys/fs/ubifs/ubiX_Y/errors_crc

 Stefan

> From: Stefan Schaeckeler <schaecsn@gmx.net>
>
> Not all ubifs filesystem errors are propagated to userspace, here is one
> that is not propagaged to ls:
>
> [node0_RP0_CPU0:~]$ls -la /mnt/mtd0
> [562009.111309] UBIFS error (ubi0:0 pid 21670): ubifs_check_node [ubifs]=
: bad CRC: calculated 0x1b205ba3, read 0xb6eff0d9
> [562009.123231] UBIFS error (ubi0:0 pid 21670): ubifs_check_node [ubifs]=
: bad node at LEB 112:29768
> [562009.133042] magic          0x6101831
> [562009.137312] crc            0xb6eff0d9
> [562009.141678] node_type      2 (direntry node)
> [562009.146706] group_type     1 (in node group)
> [562009.151734] sqnum          334966
> [562009.155709] len            82
> [562009.159304] key            (1, direntry, 0xe933a79)
> [562009.164999] inum           546
> [562009.168687] type           0
> [562009.172186] nlen           25
> [562009.175779] name           inventor\xffffffff\xffffffff\xffffffff\xf=
fffffffcal_log_4.txt
> [562009.185308] CPU: 1 PID: 21670 Comm: ls Tainted: G           O    4.8=
.28-WR9.0.0.20_cgl #1
> [562009.185309] Hardware name: Insyde Harrisonville/Type2 - Board Produc=
t Name1, BIOS 00.01.017 10/26/2018
> [562009.185312]  0000000000000286 00000000f877ad2e ffffbb5b8e357c50 ffff=
ffff9b3cfaab
> [562009.185316]  00000000ffffff8b 0000000000007448 ffffbb5b8e357c90 ffff=
ffffc022c0dd
> [562009.185320]  00000000687aa008 0000000000007448 0000000000000070 0000=
000000000052
> [562009.185324] Call Trace:
> [562009.185332]  [<ffffffff9b3cfaab>] dump_stack+0x63/0x88
> [562009.185345]  [<ffffffffc022c0dd>] ubifs_check_node+0xbd/0x270 [ubifs=
]
> [562009.185357]  [<ffffffffc022db25>] ubifs_read_node+0x285/0x300 [ubifs=
]
> [562009.185370]  [<ffffffffc024dfc7>] ubifs_tnc_read_node+0x127/0x1c0 [u=
bifs]
> [562009.185382]  [<ffffffffc0230115>] ? matches_name+0x45/0xf0 [ubifs]
> [562009.185394]  [<ffffffffc022ed9a>] tnc_read_node_nm+0xfa/0x220 [ubifs=
]
> [562009.185407]  [<ffffffffc02330a4>] ubifs_tnc_next_ent+0x1f4/0x2a0 [ub=
ifs]
> [562009.185411]  [<ffffffff9b1f405e>] ? filldir+0xce/0x150
> [562009.185422]  [<ffffffffc02244f8>] ubifs_readdir+0x188/0x4d0 [ubifs]
> [562009.185425]  [<ffffffff9b1f3e62>] iterate_dir+0x172/0x190
> [562009.185429]  [<ffffffff9b124e4a>] ? __audit_syscall_entry+0xba/0x100
> [562009.185432]  [<ffffffff9b1f4399>] SyS_getdents+0x99/0x120
> [562009.185434]  [<ffffffff9b1f3f90>] ? fillonedir+0x110/0x110
> [562009.185437]  [<ffffffff9b002b76>] do_syscall_64+0x66/0x180
> [562009.185441]  [<ffffffff9b8b9fce>] entry_SYSCALL_64_after_swapgs+0x58=
/0xc6
> [562009.185454] UBIFS error (ubi0:0 pid 21670): ubifs_read_node [ubifs]:=
 expected node type 2
> [562009.194705] UBIFS error (ubi0:0 pid 21670): ubifs_readdir [ubifs]: c=
annot find next direntry, error -117
> total 1080
> drwxr-xr-x. 2 root root   3728 Jul  3 10:36 .
> drwxrwxrwt. 5 root root    120 Jul  3 10:36 ..
> -rw-rw-rw-. 1 root root   5413 May 24 10:59 alarm_0_PM1_remote_log_1.txt
> -rw-rw-rw-. 1 root root      1 Sep 19  2020 alarm_banner.txt
> -rw-rw-rw-. 1 root root  65465 Nov  5  2020 alarm_local_log_29.txt
> -rw-rw-rw-. 1 root root  55441 Dec 18  2020 alarm_local_log_30.txt
> -rw-rw-rw-. 1 root root  64826 Sep 20  2020 alarm_local_log_31.txt
> -rw-rw-rw-. 1 root root  65019 Oct 25  2020 alarm_local_log_32.txt
> -rw-rw-rw-. 1 root root  65880 Oct 26  2020 alarm_local_log_33.txt
> -rw-rw-rw-. 1 root root  66296 Apr 17 10:35 alarm_local_log_34.txt
> -rw-rw-rw-. 1 root test  64734 May  5 20:35 alarm_local_log_35.txt
> -rw-rw-rw-. 1 root root  64924 Jun  4 07:39 alarm_local_log_36.txt
> -rw-rw-rw-. 1 root root  50830 Jul  8 13:21 alarm_local_log_37.txt
> -rw-rw-rw-. 1 root root      1 Sep 21  2020 fpd_banner.txt
> -rw-rw-rw-. 1 root root  28518 Jul  2 23:19 fpd_local_log_2.txt
> -rw-rw-rw-. 1 root root     96 Jul  9 22:37 int_uptime_dashboard.dat
> -rw-rw-rw-. 1 root iosxr   540 Jun  8 00:06 inventory_local_log_1.txt
> -rw-rw-rw-. 1 root iosxr   540 Jul  2 23:26 inventory_local_log_2.txt
> -rw-rw-rw-. 1 root root  79293 Jul  3 10:37 inventory_local_log_3.txt
> -rw-rw-rw-. 1 root test      4 Apr 17 10:33 obfl_data_version.dat
> -rw-rw-rw-. 1 root root    364 Sep 19  2020 temperature_banner.txt
> -rw-rw-rw-. 1 root root  19567 Dec 18  2020 temperature_local_log_3.txt
> -rw-rw-rw-. 1 root root  65607 Sep 20  2020 temperature_local_log_4.txt
> -rw-rw-rw-. 1 root root  66410 Apr 17 10:34 temperature_local_log_5.txt
> -rw-rw-rw-. 1 root test  65607 Jun  1 21:26 temperature_local_log_6.txt
> -rw-rw-rw-. 1 root root  54097 Jul  3 10:37 temperature_local_log_7.txt
> -rw-rw-rw-. 1 root root  65160 Jun 25 23:56 voltage_local_log_10.txt
> -rw-rw-rw-. 1 root root  28236 Jul  3 10:37 voltage_local_log_11.txt
> [node0_RP0_CPU0:~]$echo $?
> 0
>
> A direntry node got corrupted. The filename inventory_local_log_4.txt go=
t
> corrupted to inventor\xffffffff\xffffffff\xffffffff\xffffffffcal_log_4.t=
xt
> and is not passed down to ls. ls exits with a clean exit code of 0.
>
> We can't really detect this corruption from user space. This is required=
 to
> take action such as for a fresh start with re-creating the filesystem.
>
> Every access to the mounted filesystem results in a kernel backtrace. Th=
is
> trashes the dmesg buffer and the systemd journal over time.
>
>
> This patch introduces a sysfs filesystem for ubifs. The first three sysf=
s
> nodes are error counters:
>
>  /sys/fs/ubifs/ubiX_Y/errors_magic
>  /sys/fs/ubifs/ubiX_Y/errors_node
>  /sys/fs/ubifs/ubiX_Y/errors_crc
>
> This allows userspace to notice filesystem corruption. Over time, more
> sysfs nodes can be added.
>
> Stefan Schaeckeler (1):
>   ubifs: ubifs to export filesystem error counters
>
>  fs/ubifs/Makefile |   2 +-
>  fs/ubifs/io.c     |   6 ++
>  fs/ubifs/super.c  |  17 ++++-
>  fs/ubifs/sysfs.c  | 187 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ubifs/sysfs.h  |  39 ++++++++++
>  fs/ubifs/ubifs.h  |  11 +++
>  6 files changed, 260 insertions(+), 2 deletions(-)
>  create mode 100644 fs/ubifs/sysfs.c
>  create mode 100644 fs/ubifs/sysfs.h
>
> --
> 2.32.0
