Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC53D089D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 08:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhGUF2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 01:28:49 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:42657 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhGUF2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:28:44 -0400
Received: by mail-io1-f71.google.com with SMTP id v21-20020a5d90550000b0290439ea50822eso885303ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 23:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QQkMC3K8A9rfr74Kj/zOKclGrPLkuhcSjYggHAqCIxw=;
        b=YBr+fLyg1MQjEqMwMd+baccfaL7PzPu1E7+/Yer4jZFxMsniy3pZ+H2DGulUgNyUAL
         kdRgOA9P2sSFr5grWtQ6NE2CsB7JYP6e5QoWb/QrKBPf335bnyqCmZq5FPRoIjYkN/ds
         5nK3Ajfqt7G53D3tN7ptAAg0xFWt8AfT+H1BSpdwRaRuLgdDhsQQI9MrZZDOZFBd3zFv
         WGOPlcC5Ig/TwLoCPSg8G+32V5gZQ5IgNx2bqY6XklqwKajK7UXjkRSitq6tNUIlF7yc
         oD3fUyLRU7JS6gId0DTqjY7VjIOrjM03WI3qBNNDpQb3KpRA9xzw2xgEZnutI4rg2/ke
         cBgw==
X-Gm-Message-State: AOAM530vdplY1fzQ3Y88bNP5L0+HIER821XkTq0iqaueW06a6PBiqYFV
        frOWrLX1MCeE4f9Bf060BbB2SuGR3kgk80FV8S2OYfRgvvOw
X-Google-Smtp-Source: ABdhPJyNfwovT8sP9iG79JJ8M+dlVT+1/GGGkDgz7Any26A5YWuzXPD46jcttgC93YRQsaRuqv6NL47OLZc4saW+i6TuTD624nru
MIME-Version: 1.0
X-Received: by 2002:a92:d210:: with SMTP id y16mr24005236ily.295.1626847760333;
 Tue, 20 Jul 2021 23:09:20 -0700 (PDT)
Date:   Tue, 20 Jul 2021 23:09:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dbc9e605c79c0214@google.com>
Subject: [syzbot] WARNING in alloc_workqueue
From:   syzbot <syzbot+1e80b07ec236d945017f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1d67c8d993ba Merge tag 'soc-fixes-5.14-1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11766c5a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4743a765b066cc1c
dashboard link: https://syzkaller.appspot.com/bug?extid=1e80b07ec236d945017f

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e80b07ec236d945017f@syzkaller.appspotmail.com

RBP: 0000000000000005 R08: 0000000000000000 R09: ffffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000004 R14: 0000000020000300 R15: 0000000000000000
------------[ cut here ]------------
WARNING: CPU: 0 PID: 13508 at kernel/locking/lockdep.c:6305 lockdep_unregister_key+0x19a/0x250 kernel/locking/lockdep.c:6305
Modules linked in:
CPU: 0 PID: 13508 Comm: syz-executor.0 Not tainted 5.14.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:lockdep_unregister_key+0x19a/0x250 kernel/locking/lockdep.c:6305
Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8f 00 00 00 4d 89 7d 08 48 b8 22 01 00 00 00 00 ad de 48 89 43 08 eb 02 <0f> 0b 4c 89 f7 ba 01 00 00 00 48 89 ee e8 44 fd ff ff 4c 89 f7 e8
RSP: 0018:ffffc90001bc78e0 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffffffff1ad8795
RDX: 1ffffffff1fcb30e RSI: 0000000000000004 RDI: ffffffff8fe59870
RBP: ffff88801db52928 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000378f12 R11: 0000000000000000 R12: 0000000000000246
R13: dffffc0000000000 R14: ffffffff8fcd0868 R15: ffff88801db52820
FS:  00007f7d4ceaa700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7d4cea9f78 CR3: 0000000078c46000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 wq_unregister_lockdep kernel/workqueue.c:3468 [inline]
 alloc_workqueue+0xb31/0xef0 kernel/workqueue.c:4337
 loop_configure+0x4d8/0x1580 drivers/block/loop.c:1199
 lo_ioctl+0x403/0x1600 drivers/block/loop.c:1773
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:585
 block_ioctl+0xf9/0x140 fs/block_dev.c:1602
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x466397
Code: 3c 1c 48 f7 d8 49 39 c4 72 b8 e8 a4 48 02 00 85 c0 78 bd 48 83 c4 08 4c 89 e0 5b 41 5c c3 0f 1f 44 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7d4cea9f48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004afcc0 RCX: 0000000000466397
RDX: 0000000000000004 RSI: 0000000000004c00 RDI: 0000000000000005
RBP: 0000000000000005 R08: 0000000000000000 R09: ffffffffffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 0000000000000004 R14: 0000000020000300 R15: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
