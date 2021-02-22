Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2A3212D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 10:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBVJL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 04:11:28 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:43487 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhBVJGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 04:06:55 -0500
Received: by mail-il1-f197.google.com with SMTP id b4so7170654ilj.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 01:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SnPAfYRAYGtfnVs6B/o8MLHL0hcsdQDCUmNnokrQL7o=;
        b=HR2gx5ft8dZVj6qVN7XgYzlGErEz1MZ7q1cqsX1HVkBI2Gv2k1XhgmtlmocB+HOPWp
         XHmztqx94QW5Pvek1subblPRvDWlUN9+8bei3czn89NnOL33aaLio2IzcksUqrpr5H9s
         O5HcJBeesB0ohvpaMrwH2UaEOzjYa1Bg+7G11PZpfCGQP1+dTixOzbohKUXfUeWIzfpb
         POjfj9QHi1Fpqa7yu2SSExqQ7SSfc7U8T4blP3c6eRK1vn1sWx6WVd4Pp3zx7R972uRg
         xJ4O0aJPmJxtCX5R/1qB1hNOCf/uXbfVNjNbVlsR5/0uevVDMHMoSgrsgcp56J/mgkye
         QPJg==
X-Gm-Message-State: AOAM5317b9cyWmBNo98T+QxQfR3+K9xu3dKfZF6GZzpbgyuFj17Qtw/u
        /lFZ2CfQcpGmH63uoMorCEacjJK1G4OTtAVsCPLMSXOTp6yL
X-Google-Smtp-Source: ABdhPJwmxkJjRFeNvq2UYxQJReoERu+QZLrYkYc09f0SI6K1RXT5HU/mr/PVvn51bznq8aJQtYH2OmmxLM11pvYMTnZlvAAQNXfy
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d8a:: with SMTP id l10mr21309377jaj.2.1613984774045;
 Mon, 22 Feb 2021 01:06:14 -0800 (PST)
Date:   Mon, 22 Feb 2021 01:06:14 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002142f605bbe91dc8@google.com>
Subject: memory leak in iget_locked
From:   syzbot <syzbot+739e5b9d4646ff8618a9@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e1a434d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5528e8db7fc481ae
dashboard link: https://syzkaller.appspot.com/bug?extid=739e5b9d4646ff8618a9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10aeddd2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+739e5b9d4646ff8618a9@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810ffd32e0 (size 608):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 32 bytes):
    80 80 0c 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000159405a6>] alloc_inode+0xbe/0x100 fs/inode.c:235
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111bd1ab0 (size 24):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 24 bytes):
    18 34 fd 0f 81 88 ff ff 90 e3 09 82 ff ff ff ff  .4..............
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000c34be1ab>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<00000000c34be1ab>] lsm_inode_alloc security/security.c:590 [inline]
    [<00000000c34be1ab>] security_inode_alloc+0x2a/0xb0 security/security.c:973
    [<00000000682cda2f>] inode_init_always+0x10c/0x250 fs/inode.c:170
    [<00000000b63896fb>] alloc_inode+0x44/0x100 fs/inode.c:240
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ffd8ce0 (size 608):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 32 bytes):
    a4 81 0c 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
  backtrace:
    [<00000000159405a6>] alloc_inode+0xbe/0x100 fs/inode.c:235
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88810ed17e28 (size 24):
  comm "systemd", pid 1, jiffies 4294966945 (age 26.710s)
  hex dump (first 24 bytes):
    18 8e fd 0f 81 88 ff ff 90 e3 09 82 ff ff ff ff  ................
    00 00 00 00 00 00 00 00                          ........
  backtrace:
    [<00000000c34be1ab>] kmem_cache_zalloc include/linux/slab.h:672 [inline]
    [<00000000c34be1ab>] lsm_inode_alloc security/security.c:590 [inline]
    [<00000000c34be1ab>] security_inode_alloc+0x2a/0xb0 security/security.c:973
    [<00000000682cda2f>] inode_init_always+0x10c/0x250 fs/inode.c:170
    [<00000000b63896fb>] alloc_inode+0x44/0x100 fs/inode.c:240
    [<00000000a1ba61ba>] iget_locked+0x126/0x340 fs/inode.c:1192
    [<0000000058bf69d6>] kernfs_get_inode+0x20/0x190 fs/kernfs/inode.c:252
    [<0000000038d3c844>] kernfs_iop_lookup+0xa0/0xe0 fs/kernfs/dir.c:1100
    [<00000000f316b4af>] lookup_open fs/namei.c:3085 [inline]
    [<00000000f316b4af>] open_last_lookups fs/namei.c:3180 [inline]
    [<00000000f316b4af>] path_openat+0x95d/0x1b00 fs/namei.c:3368
    [<00000000952158a9>] do_filp_open+0xa0/0x190 fs/namei.c:3398
    [<00000000ca8d298d>] do_sys_openat2+0xed/0x230 fs/open.c:1172
    [<00000000be6807df>] do_sys_open fs/open.c:1188 [inline]
    [<00000000be6807df>] __do_sys_open fs/open.c:1196 [inline]
    [<00000000be6807df>] __se_sys_open fs/open.c:1192 [inline]
    [<00000000be6807df>] __x64_sys_open+0x7d/0xe0 fs/open.c:1192
    [<00000000ea2012e0>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000e7253572>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  323.608401][  


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
