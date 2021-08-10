Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DF3DB508
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhG3I22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:28:28 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:48737 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbhG3I2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:28:21 -0400
Received: by mail-il1-f197.google.com with SMTP id p6-20020a056e021446b0290205af2e2342so4624029ilo.15
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 01:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GISeRZqB/e3Oljoo9ObPCdPOxhxBhMkqAwYWd8XUGME=;
        b=J4YztPKgvd+fNumuKi9K1SYQH486ubKFj369KBtrbe1/mvi3c6hOiR0kF+3ZPyMjUC
         h8eyVdIl1ZD0FOGbGmFGN1WUQBphNJRBdoj+mo0OXn3+W7dizMm6iJiqKoFiNl2cis4R
         MtpyJjqHJNokWjwfHN3jJronx7TucyiohgFTUTq5mEGKFV8Qj/c6U9wCK6HpY/aL8bln
         XO8l8e70KHVCvugBaZerPicYIHVuCWK+dbgbY+iRv8SEWAdaOf/+P2wPn+qIJns9CTa9
         CAEGgs+9/jU8nmX38N8ysknGavxdzu95wHFq7adOp96SRcTPvMKnThsaiZPJdEWJO00c
         KNfA==
X-Gm-Message-State: AOAM533/fky/c+1qqxCTOsyS5BBGDZ+3Attx7q74cfUmpTYuH3x6RE/x
        nI8ljnnI9WIziUASVwJxh4Benm5zejJOPYHJ9BeXjB95R2OB
X-Google-Smtp-Source: ABdhPJzzjWCRaOM7xD8AfBtQ/XRWqmHCiFjnQk+DT8rgvtzJ38XwWm2r0bULYRZWLY5piamtdzOnQAW+3fef5RiKOzQXmIOvrq59
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2424:: with SMTP id g4mr722705iob.189.1627633697367;
 Fri, 30 Jul 2021 01:28:17 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:28:17 -0700
In-Reply-To: <000000000000458e0c05c6928ee2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b27b805c853007b@google.com>
Subject: Re: [syzbot] possible deadlock in __loop_clr_fd (2)
From:   syzbot <syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, hdanton@sina.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4ccc9e2db7ac Add linux-next specific files for 20210729
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=169b8d7a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75a5bed89b5c0fd2
dashboard link: https://syzkaller.appspot.com/bug?extid=f61766d5763f9e7a118f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b87a8e300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d20adc300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f61766d5763f9e7a118f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
EXT4-fs error (device loop0): ext4_fill_super:4953: inode #2: comm syz-executor258: iget: root inode unallocated
EXT4-fs (loop0): get root inode failed
EXT4-fs (loop0): mount failed
======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc3-next-20210729-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor258/6697 is trying to acquire lock:
ffff88807dbec138 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0xe1/0x1600 kernel/workqueue.c:2784

but task is already holding lock:
ffff88801d535468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0xaf/0x15e0 drivers/block/loop.c:1350

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&lo->lo_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:957 [inline]
       __mutex_lock+0x131/0x1300 kernel/locking/mutex.c:1096
       loop_control_remove drivers/block/loop.c:2449 [inline]
       loop_control_ioctl+0x22f/0x450 drivers/block/loop.c:2494
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:866 [inline]
       __se_sys_ioctl fs/ioctl.c:852 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:852
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #5 (loop_ctl_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:957 [inline]
       __mutex_lock+0x131/0x1300 kernel/locking/mutex.c:1096
       loop_add+0x9c/0x940 drivers/block/loop.c:2314
       loop_probe+0x6a/0x80 drivers/block/loop.c:2426
       blk_request_module+0x111/0x1d0 block/genhd.c:673
       blkdev_get_no_open+0x178/0x1e0 fs/block_dev.c:1298
       blkdev_get_by_dev.part.0+0x23/0xd40 fs/block_dev.c:1362
       blkdev_get_by_dev fs/block_dev.c:1471 [inline]
       blkdev_open+0x295/0x300 fs/block_dev.c:1477
       do_dentry_open+0x4c8/0x11d0 fs/open.c:826
       do_open fs/namei.c:3374 [inline]
       path_openat+0x1c23/0x27f0 fs/namei.c:3507
       do_filp_open+0x1aa/0x400 fs/namei.c:3534
       do_sys_openat2+0x16d/0x420 fs/open.c:1204
       do_sys_open fs/open.c:1220 [inline]
       __do_sys_open fs/open.c:1228 [inline]
       __se_sys_open fs/open.c:1224 [inline]
       __x64_sys_open+0x119/0x1c0 fs/open.c:1224
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #4 (major_names_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:957 [inline]
       __mutex_lock+0x131/0x1300 kernel/locking/mutex.c:1096
       blkdev_show+0x27/0x160 block/genhd.c:197
       devinfo_show+0xc1/0xf0 fs/proc/devices.c:22
       seq_read_iter+0xbb0/0x1240 fs/seq_file.c:272
       proc_reg_read_iter+0x1fb/0x2d0 fs/proc/inode.c:300
       call_read_iter include/linux/fs.h:2146 [inline]
       new_sync_read+0x41e/0x6e0 fs/read_write.c:415
       vfs_read+0x35c/0x570 fs/read_write.c:496
       ksys_read+0x12d/0x250 fs/read_write.c:634
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:957 [inline]
       __mutex_lock+0x131/0x1300 kernel/locking/mutex.c:1096
       seq_read_iter+0xdf/0x1240 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2146 [inline]
       generic_file_splice_read+0x450/0x6c0 fs/splice.c:311
       do_splice_to+0x1bf/0x250 fs/splice.c:796
       splice_direct_to_actor+0x2c2/0x8c0 fs/splice.c:870
       do_splice_direct+0x1b3/0x280 fs/splice.c:979
       do_sendfile+0x9f0/0x1120 fs/read_write.c:1260
       __do_sys_sendfile64 fs/read_write.c:1325 [inline]
       __se_sys_sendfile64 fs/read_write.c:1311 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1311
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #2 (sb_writers#3){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1801 [inline]
       sb_start_write include/linux/fs.h:1871 [inline]
       file_start_write include/linux/fs.h:3080 [inline]
       lo_write_bvec+0x3b6/0x6d0 drivers/block/loop.c:327
       lo_write_simple drivers/block/loop.c:350 [inline]
       do_req_filebacked drivers/block/loop.c:668 [inline]
       loop_handle_cmd drivers/block/loop.c:2202 [inline]
       loop_process_work+0xc60/0x24e0 drivers/block/loop.c:2242
       process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
       process_one_work+0x8fc/0x1630 kernel/workqueue.c:2252
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 ((wq_completion)loop0){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       flush_workqueue+0x110/0x1600 kernel/workqueue.c:2787
       drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2952
       destroy_workqueue+0x71/0x800 kernel/workqueue.c:4389
       __loop_clr_fd+0x212/0x15e0 drivers/block/loop.c:1368
       loop_clr_fd drivers/block/loop.c:1494 [inline]
       lo_ioctl+0x3c3/0x1880 drivers/block/loop.c:1850
       blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:587
       block_ioctl+0xf9/0x140 fs/block_dev.c:1569
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:866 [inline]
       __se_sys_ioctl fs/ioctl.c:852 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:852
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  (wq_completion)loop0 --> loop_ctl_mutex --> &lo->lo_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lo->lo_mutex);
                               lock(loop_ctl_mutex);
                               lock(&lo->lo_mutex);
  lock((wq_completion)loop0);

 *** DEADLOCK ***

1 lock held by syz-executor258/6697:
 #0: ffff88801d535468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0xaf/0x15e0 drivers/block/loop.c:1350

stack backtrace:
CPU: 1 PID: 6697 Comm: syz-executor258 Not tainted 5.14.0-rc3-next-20210729-syzkaller #0
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
 flush_workqueue+0x110/0x1600 kernel/workqueue.c:2787
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2952
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4389
 __loop_clr_fd+0x212/0x15e0 drivers/block/loop.c:1368
 loop_clr_fd drivers/block/loop.c:1494 [inline]
 lo_ioctl+0x3c3/0x1880 drivers/block/loop.c:1850
 blkdev_ioctl+0x2a1/0x6d0 block/ioctl.c:587
 block_ioctl+0xf9/0x140 fs/block_dev.c:1569
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:866 [inline]
 __se_sys_ioctl fs/ioctl.c:852 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:852
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444717
Code: 3c 1c 48 f7 d8 49 39 c4 72 b8 e8 44 3a 02 00 85 c0 78 bd 48 83 c4 08 4c 89 e0 5b 41 5c c3 0f 1f 44 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffab8ca568 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000016232c0 RCX: 0000000000444717
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000007
RBP: 0000000000000075 R08: 00007fffab8ca5c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000200002a8
R13: 0000000000000006 R14: 0000000000000007 R15: 0000000000000007

