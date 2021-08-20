Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277983F31B5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhHTQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:48:56 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47679 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbhHTQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:48:55 -0400
Received: by mail-il1-f199.google.com with SMTP id j17-20020a926e11000000b0022487646515so2264597ilc.14
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 09:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AoS2KwbRcXQ9NIRs5h6PWGGfZ4zUglRtWNysjlETQXI=;
        b=teKG8O0fPYGNVCREJqBl9ZfXrovDuQjfnscb7c5ieIz0dvC6SCiX6PfWgLhrsTxGlk
         A4wPmwRMaFhdzdzpCti//q+a+aou7DQ9fIBPsJ3MF3TUG0OcYCcQdzBMtxYv6h+MXwUc
         dEIWTGucYCMI3lP3otqZZSsB8SY0LA/u7mB17u/GfnDikY5twrzor4ZKLNjPe1Kto43I
         TkQmO9ipuJ8ykWjJ4nO0geba919WWWMrG+o/s7KnegZPPpuw4p2B4KWMXv40TBoRROjQ
         Mc2EdTwjLfTSJkkhrs1ojsVgdXN8o+tW/F7facCPdWq6inlzyXw2o+egjx5o48JAE8nb
         V3sg==
X-Gm-Message-State: AOAM530f9vp4rra7/z4H9AXKQ4DZPpmZn3RVN/B18/qQQ8vTyDS4+vSS
        NYBUCp2M3t/WaeVHONhmc/ogF32SjobnY5DAoLdldjMHEiWu
X-Google-Smtp-Source: ABdhPJzEtNk55tbXRjWwSm6Lfcvd34tDCs4MDOsN0KScq45BVMEL9dvKawSfY6vOnEESgF1co11tA3E2x2sdwHYqiIridIfq38zo
MIME-Version: 1.0
X-Received: by 2002:a02:a409:: with SMTP id c9mr18214386jal.138.1629478097608;
 Fri, 20 Aug 2021 09:48:17 -0700 (PDT)
Date:   Fri, 20 Aug 2021 09:48:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d66c805ca006f38@google.com>
Subject: [syzbot] linux-next boot error: possible deadlock in blktrans_open
From:   syzbot <syzbot+a44be5792ded9c017a13@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-next@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    86ed57fd8c93 Add linux-next specific files for 20210820
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1776d189300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64eccb415bd479d
dashboard link: https://syzkaller.appspot.com/bug?extid=a44be5792ded9c017a13
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a44be5792ded9c017a13@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc6-next-20210820-syzkaller #0 Not tainted
------------------------------------------------------
systemd-udevd/4540 is trying to acquire lock:
ffffffff8c5df508 (mtd_table_mutex){+.+.}-{3:3}, at: blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:210

but task is already holding lock:
ffff88801d051918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb60 fs/block_dev.c:1227

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&disk->open_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x135/0x12f0 kernel/locking/mutex.c:729
       bd_register_pending_holders+0x2c/0x470 block/holder.c:153
       register_disk block/genhd.c:456 [inline]
       device_add_disk+0x376/0xcf0 block/genhd.c:551
       add_mtd_blktrans_dev+0xdd1/0x1610 drivers/mtd/mtd_blkdevs.c:430
       mtdblock_add_mtd+0x20f/0x2c0 drivers/mtd/mtdblock.c:329
       blktrans_notify_add drivers/mtd/mtd_blkdevs.c:510 [inline]
       blktrans_notify_add+0x7a/0xc0 drivers/mtd/mtd_blkdevs.c:502
       add_mtd_device+0xa8e/0x1170 drivers/mtd/mtdcore.c:690
       mtd_device_parse_register+0x510/0x870 drivers/mtd/mtdcore.c:979
       mtdram_init_device+0x295/0x350 drivers/mtd/devices/mtdram.c:146
       init_mtdram+0xe5/0x177 drivers/mtd/devices/mtdram.c:171
       do_one_initcall+0x103/0x650 init/main.c:1292
       do_initcall_level init/main.c:1367 [inline]
       do_initcalls init/main.c:1383 [inline]
       do_basic_setup init/main.c:1402 [inline]
       kernel_init_freeable+0x6b4/0x73d init/main.c:1604
       kernel_init+0x1a/0x1d0 init/main.c:1496
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (mtd_table_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a25/0x54e0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x135/0x12f0 kernel/locking/mutex.c:729
       blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:210
       blkdev_get_whole+0x9d/0x2b0 fs/block_dev.c:1079
       blkdev_get_by_dev.part.0+0x354/0xb60 fs/block_dev.c:1234
       blkdev_get_by_dev fs/block_dev.c:1323 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1329
       do_dentry_open+0x4c8/0x11d0 fs/open.c:826
       do_open fs/namei.c:3428 [inline]
       path_openat+0x1cbe/0x28b0 fs/namei.c:3561
       do_filp_open+0x1aa/0x400 fs/namei.c:3588
       do_sys_openat2+0x16d/0x4e0 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_open fs/open.c:1228 [inline]
       __se_sys_open fs/open.c:1224 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1224
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
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

1 lock held by systemd-udevd/4540:
 #0: ffff88801d051918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb60 fs/block_dev.c:1227

stack backtrace:
CPU: 0 PID: 4540 Comm: systemd-udevd Not tainted 5.14.0-rc6-next-20210820-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x262/0x2f0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a25/0x54e0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __mutex_lock_common kernel/locking/mutex.c:596 [inline]
 __mutex_lock+0x135/0x12f0 kernel/locking/mutex.c:729
 blktrans_open+0x69/0x600 drivers/mtd/mtd_blkdevs.c:210
 blkdev_get_whole+0x9d/0x2b0 fs/block_dev.c:1079
 blkdev_get_by_dev.part.0+0x354/0xb60 fs/block_dev.c:1234
 blkdev_get_by_dev fs/block_dev.c:1323 [inline]
 blkdev_open+0x295/0x300 fs/block_dev.c:1329
 do_dentry_open+0x4c8/0x11d0 fs/open.c:826
 do_open fs/namei.c:3428 [inline]
 path_openat+0x1cbe/0x28b0 fs/namei.c:3561
 do_filp_open+0x1aa/0x400 fs/namei.c:3588
 do_sys_openat2+0x16d/0x4e0 fs/open.c:1204
 do_sys_open fs/open.c:1220 [inline]
 __do_sys_open fs/open.c:1228 [inline]
 __se_sys_open fs/open.c:1224 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1224
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7faf61bb2840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffffbf04508 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 000055c752d73830 RCX: 00007faf61bb2840
RDX: 000055c751371fe3 RSI: 00000000000a0800 RDI: 000055c752d64f90
RBP: 00007ffffbf04680 R08: 000055c751371670 R09: 0000000000000020
R10: 000055c751371d0c R11: 0000000000000246 R12: 00007ffffbf045d0
R13: 000055c752d65880 R14: 0000000000000003 R15: 000000000000000e


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
