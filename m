Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685C43BF390
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhGHBaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:30:00 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35495 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhGHBaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:30:00 -0400
Received: by mail-io1-f69.google.com with SMTP id n13-20020a5ed90d0000b02904f43c8bffc4so2920374iop.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 18:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8s0bDf+KPrMbYmkycEdBxjIcn7Sd5i5LDNldt0xz9SU=;
        b=fZJqZbnGOvBUm8H4hsuEYbhjQ7cSC6uhi2DQJjilthxUY6geerEh5VfAoxfckJFrRM
         W1eCGxcmLa9cNjwpN78xgCpWCG1DjJbWN3V+W5tr/Qz64SBxkDCTB3o29ha40unU64lu
         u53s+OkINV/cFZhngz1Q2bMSvzvBjauqW9tsjBjBjPSXfdpyUQ6obscnsZ31rs7K93A/
         w5vR/6N7lgoWETRzZkj5tDFp2YbsA4MhvJEU63nZ0PLpfGarTXq+ITJOsQYg1S8tSn1b
         qiR7ovmLNUPc2Kei+f8KdY7423S6izhHtXzoGEP4PrLPP6GHTKobCf3/f5Unh7WyWEzR
         hI4Q==
X-Gm-Message-State: AOAM532uBYctqlLnCEIyEcSEah7OBH9IA6/sknK9GQFg4xAs1C0MsZjD
        44i0A8nYpNVuEsMSfTMZRv5FKrgK3gMW5UEgV4wcuYdGnirI
X-Google-Smtp-Source: ABdhPJwTGKMqGhxiwp9jxOg8RZMC8TbW1tqhMuFScE6m2rvoP0i4bLAiXuTZMX+IGYzGAsxg/8IgniwsXTuvgwDhkisVDvt1CXVk
MIME-Version: 1.0
X-Received: by 2002:a02:2a07:: with SMTP id w7mr24520742jaw.96.1625707637999;
 Wed, 07 Jul 2021 18:27:17 -0700 (PDT)
Date:   Wed, 07 Jul 2021 18:27:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000458e0c05c6928ee2@google.com>
Subject: [syzbot] possible deadlock in __loop_clr_fd (2)
From:   syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121231c4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=f61766d5763f9e7a118f

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.13.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.4/28137 is trying to acquire lock:
ffff88801fddc138 ((wq_completion)loop7){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x1600 kernel/workqueue.c:2784

but task is already holding lock:
ffff88801e95b468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x95/0x1550 drivers/block/loop.c:1286

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       loop_control_ioctl drivers/block/loop.c:2427 [inline]
       loop_control_ioctl+0x20f/0x480 drivers/block/loop.c:2403
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:1069 [inline]
       __se_sys_ioctl fs/ioctl.c:1055 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (loop_ctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       loop_probe+0xc7/0x150 drivers/block/loop.c:2397
       blk_request_module+0x111/0x1d0 block/genhd.c:660
       blkdev_get_no_open+0x1d5/0x250 fs/block_dev.c:1332
       blkdev_get_by_dev.part.0+0x25/0xdd0 fs/block_dev.c:1395
       blkdev_get_by_dev+0x6b/0x80 fs/block_dev.c:1448
       swsusp_check+0x4d/0x270 kernel/power/swap.c:1525
       software_resume.part.0+0x102/0x1f0 kernel/power/hibernate.c:974
       software_resume kernel/power/hibernate.c:84 [inline]
       resume_store+0x147/0x170 kernel/power/hibernate.c:1176
       kobj_attr_store+0x50/0x80 lib/kobject.c:856
       sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
       kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
       call_write_iter include/linux/fs.h:2114 [inline]
       new_sync_write+0x426/0x650 fs/read_write.c:518
       vfs_write+0x796/0xa30 fs/read_write.c:605
       ksys_write+0x12d/0x250 fs/read_write.c:658
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (major_names_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       blkdev_show+0x27/0x160 block/genhd.c:179
       devinfo_show+0xc1/0xf0 fs/proc/devices.c:22
       seq_read_iter+0xb58/0x11e0 fs/seq_file.c:269
       proc_reg_read_iter+0x1fb/0x2d0 fs/proc/inode.c:300
       call_read_iter include/linux/fs.h:2108 [inline]
       new_sync_read+0x41e/0x6e0 fs/read_write.c:415
       vfs_read+0x35c/0x570 fs/read_write.c:496
       ksys_read+0x12d/0x250 fs/read_write.c:634
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       seq_read_iter+0xdf/0x11e0 fs/seq_file.c:179
       proc_reg_read_iter+0x1fb/0x2d0 fs/proc/inode.c:300
       call_read_iter include/linux/fs.h:2108 [inline]
       generic_file_splice_read+0x450/0x6c0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0x9f0/0x1110 fs/read_write.c:1260
       __do_sys_sendfile64 fs/read_write.c:1325 [inline]
       __se_sys_sendfile64 fs/read_write.c:1311 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1763 [inline]
       sb_start_write include/linux/fs.h:1833 [inline]
       file_start_write include/linux/fs.h:3034 [inline]
       lo_write_bvec+0x3ed/0x6c0 drivers/block/loop.c:286
       lo_write_simple drivers/block/loop.c:309 [inline]
       do_req_filebacked drivers/block/loop.c:627 [inline]
       loop_handle_cmd drivers/block/loop.c:2140 [inline]
       loop_process_work+0xc60/0x24e0 drivers/block/loop.c:2180
       process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x8fc/0x1630 kernel/workqueue.c:2252
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 ((wq_completion)loop7){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       flush_workqueue+0x110/0x1600 kernel/workqueue.c:2787
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2952
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4383
       __loop_clr_fd+0x1f8/0x1550 drivers/block/loop.c:1304
       loop_clr_fd drivers/block/loop.c:1430 [inline]
       lo_ioctl+0x3c3/0x1600 drivers/block/loop.c:1788
       blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:585
       block_ioctl+0xf9/0x140 fs/block_dev.c:1602
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:1069 [inline]
       __se_sys_ioctl fs/ioctl.c:1055 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop7 --> loop_ctl_mutex --> &lo->lo_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lo->lo_mutex);
                               lock(loop_ctl_mutex);
                               lock(&lo->lo_mutex);
  lock((wq_completion)loop7);

 *** DEADLOCK ***

1 lock held by syz-executor.4/28137:
 #0: ffff88801e95b468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x95/0x1550 drivers/block/loop.c:1286

stack backtrace:
CPU: 0 PID: 28137 Comm: syz-executor.4 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 flush_workqueue+0x110/0x1600 kernel/workqueue.c:2787
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2952
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4383
 __loop_clr_fd+0x1f8/0x1550 drivers/block/loop.c:1304
 loop_clr_fd drivers/block/loop.c:1430 [inline]
 lo_ioctl+0x3c3/0x1600 drivers/block/loop.c:1788
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:585
 block_ioctl+0xf9/0x140 fs/block_dev.c:1602
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc7e175f188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056c0f0 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c0f0
R13: 0000000000a9fb1f R14: 00007fc7e175f300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
