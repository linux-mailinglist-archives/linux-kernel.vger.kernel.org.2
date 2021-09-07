Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE640312C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 00:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347019AbhIGWpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 18:45:38 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48114 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhIGWpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 18:45:32 -0400
Received: by mail-il1-f198.google.com with SMTP id j17-20020a926e11000000b0022487646515so173845ilc.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 15:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2RrC34cTaNsUtCpEbC+ymqF0FjuPLB8f0hQoaI7rRcw=;
        b=omGBtEPG71DY6KsFn6ViyKLtf4LRD+y+GTztCQTcu4YF0DRUnAJ9MKoY7GiLZ+RgMz
         H0eUsU1owmZa5ZeAbipMjrrHFWKDLljusq2J/EnweVUxC0Uf/CEnbHe2PUDE13FoGKS0
         qJoahI3ieoRhsIFLbH2xN10NuCJU6ULMHLdTs+1I/upjyz/uK/0TewHe1orrZXaAbb9O
         5XHfPMGlGrga7l+C8K/qrZtPMPX6FJ5GVI+tgiRA0pn04UCy1Xon4RidBvBLJUerPWMw
         gQmjHFHXBQldQgdrvSMsJs/lt0g/19n+6UwlehuLNTTcIt3R+TLEQ2uHjnriA1B+gJeY
         SKOg==
X-Gm-Message-State: AOAM532ztp84XdN0NhMZ3OnwqhvNMSN1B/2QcA69n77Tjhcdm0AX3fWl
        7d4oP9nQ9fQozXKDis7eXAMX8tQpsFFeztxp0mwZc/ybJHJ3
X-Google-Smtp-Source: ABdhPJybYAzEpUyxBUYCR5nO/5OUMhzS+LqO0UwpcP3OMHvQl6tcH2crKgtPlPTgKTj4qIm/oPW8uqIesJAZIYy1vDSA0gOb2xww
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1250:: with SMTP id j16mr409643ilq.215.1631054665227;
 Tue, 07 Sep 2021 15:44:25 -0700 (PDT)
Date:   Tue, 07 Sep 2021 15:44:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee215105cb6f8117@google.com>
Subject: [syzbot] upstream boot error: possible deadlock in blktrans_open
From:   syzbot <syzbot+f676029927929bee165f@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7cca308cfdc0 Merge tag 'powerpc-5.15-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10235915300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8aa56a640db99eb1
dashboard link: https://syzkaller.appspot.com/bug?extid=f676029927929bee165f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f676029927929bee165f@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
5.14.0-syzkaller #0 Not tainted
------------------------------------------------------
systemd-udevd/6382 is trying to acquire lock:
ffffffff8c5db488 (mtd_table_mutex){+.+.}-{3:3}, at: blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:210

but task is already holding lock:
ffff888020ba7118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb60 fs/block_dev.c:1227

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       bd_register_pending_holders+0x2c/0x470 block/holder.c:160
       device_add_disk+0x74c/0xfc0 block/genhd.c:470
       add_mtd_blktrans_dev+0xdae/0x15f0 drivers/mtd/mtd_blkdevs.c:430
       mtdblock_add_mtd+0x1c9/0x260 drivers/mtd/mtdblock.c:325
       blktrans_notify_add drivers/mtd/mtd_blkdevs.c:510 [inline]
       blktrans_notify_add+0x7a/0xc0 drivers/mtd/mtd_blkdevs.c:502
       add_mtd_device+0xa8e/0x1170 drivers/mtd/mtdcore.c:690
       mtd_device_parse_register+0x50c/0x860 drivers/mtd/mtdcore.c:979
       mtdram_init_device+0x291/0x350 drivers/mtd/devices/mtdram.c:146
       init_mtdram+0xe5/0x177 drivers/mtd/devices/mtdram.c:171
       do_one_initcall+0x103/0x650 init/main.c:1287
       do_initcall_level init/main.c:1360 [inline]
       do_initcalls init/main.c:1376 [inline]
       do_basic_setup init/main.c:1396 [inline]
       kernel_init_freeable+0x6b8/0x741 init/main.c:1598
       kernel_init+0x1a/0x1d0 init/main.c:1490
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (mtd_table_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:210
       blkdev_get_whole+0x99/0x2a0 fs/block_dev.c:1079
       blkdev_get_by_dev.part.0+0x354/0xb60 fs/block_dev.c:1234
       blkdev_get_by_dev fs/block_dev.c:1323 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1329
       do_dentry_open+0x4c8/0x11d0 fs/open.c:822
       do_open fs/namei.c:3426 [inline]
       path_openat+0x1c9a/0x2740 fs/namei.c:3559
       do_filp_open+0x1aa/0x400 fs/namei.c:3586
       do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
       do_sys_open fs/open.c:1216 [inline]
       __do_sys_open fs/open.c:1224 [inline]
       __se_sys_open fs/open.c:1220 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1220
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&disk->open_mutex);
                               lock(mtd_table_mutex);
                               lock(&disk->open_mutex);
  lock(mtd_table_mutex);

 *** DEADLOCK ***

1 lock held by systemd-udevd/6382:
 #0: ffff888020ba7118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb60 fs/block_dev.c:1227

stack backtrace:
CPU: 0 PID: 6382 Comm: systemd-udevd Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __mutex_lock_common kernel/locking/mutex.c:596 [inline]
 __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
 blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:210
 blkdev_get_whole+0x99/0x2a0 fs/block_dev.c:1079
 blkdev_get_by_dev.part.0+0x354/0xb60 fs/block_dev.c:1234
 blkdev_get_by_dev fs/block_dev.c:1323 [inline]
 blkdev_open+0x295/0x300 fs/block_dev.c:1329
 do_dentry_open+0x4c8/0x11d0 fs/open.c:822
 do_open fs/namei.c:3426 [inline]
 path_openat+0x1c9a/0x2740 fs/namei.c:3559
 do_filp_open+0x1aa/0x400 fs/namei.c:3586
 do_sys_openat2+0x16d/0x4d0 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_open fs/open.c:1224 [inline]
 __se_sys_open fs/open.c:1220 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1220
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc8603b3840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffe4d0d43b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055da6177ec20 RCX: 00007fc8603b3840
RDX: 000055da60055fe3 RSI: 00000000000a0800 RDI: 000055da61793030
RBP: 00007ffe4d0d4530 R08: 000055da60055670 R09: 0000000000000020
R10: 000055da60055d0c R11: 0000000000000246 R12: 00007ffe4d0d4480
R13: 000055da6178f3f0 R14: 0000000000000003 R15: 000000000000000e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
