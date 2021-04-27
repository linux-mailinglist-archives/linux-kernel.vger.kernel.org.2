Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB136C887
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhD0PTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 11:19:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48031 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbhD0PTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 11:19:12 -0400
Received: by mail-io1-f69.google.com with SMTP id f14-20020a056602038eb02903efc2bddb33so22232527iov.14
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 08:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lOCvQXUP2FZjpSakgoznwOBKG26ZOJ5qTvKsc6LWHMM=;
        b=WG6b8QrU+ou689RWyQAin7ovI3+EfKo9qWkkbfZvjNsZbIXZeWUNjRf33S76bmh72r
         21mLlg/gxT2IkMaKRZXaMTMZtrM1I86hkplFDC/Ent6/nxO5Gyy4xbaDRz2GE0p4CVxF
         D0cmINrkDMyO7zX9MC8qpqI8jMxuBwT3Jn7mvYhC60JJKtE8KVL5jtvIsvcUMeaD+tQh
         mLVgZzWzwvnMIu5DX9ImBciMyg7t8N7qxljY+v+T20vwpqB7pPNkUv1ISrcqtM6rT4oa
         67G2tuiM09e/nDpbvhFuSoEmWIuabGBRBth6Bk8aEmkEeGz4LjHeOv18SgIl1R43IUA7
         umhw==
X-Gm-Message-State: AOAM5311/LFlXd3arCoh+fTMUE22LPWdxya5+E/jP5/MTEctkjx6eIEx
        yTdnLNQWjvWJmJVoVY08OGLjDCGUk9zsKJoNqRzxW5mIMZo3
X-Google-Smtp-Source: ABdhPJxVMZ3SeXcJbP+R4qZ54UOVvC9yw2L49cR+YHEhdWRCEXdjBlICVnCay0EUVQbVt4C9nzNoMcLzSVXLFtgCmf2Dl31jGol0
MIME-Version: 1.0
X-Received: by 2002:a6b:ea10:: with SMTP id m16mr19553449ioc.124.1619536706879;
 Tue, 27 Apr 2021 08:18:26 -0700 (PDT)
Date:   Tue, 27 Apr 2021 08:18:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d43ac05c0f5c6a0@google.com>
Subject: [syzbot] possible deadlock in __queue_work
From:   syzbot <syzbot+6beae4000559d41d80f8@syzkaller.appspotmail.com>
To:     bristot@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        valentin.schneider@arm.com, zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7af08140 Revert "gcov: clang: fix clang-11+ build"
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107d2ee5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76c0382ceab56d34
dashboard link: https://syzkaller.appspot.com/bug?extid=6beae4000559d41d80f8

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6beae4000559d41d80f8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.12.0-rc8-syzkaller #0 Not tainted
------------------------------------------------------
migration/0/16 is trying to acquire lock:
ffff88802ca34a58 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x366/0xf00 kernel/workqueue.c:1454

but task is already holding lock:
ffffffff8bf8fec8 (tk_core.seq.seqcount){----}-{0:0}, at: multi_cpu_stop+0x15f/0x430 kernel/stop_machine.c:240

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (tk_core.seq.seqcount){----}-{0:0}:
       seqcount_lockdep_reader_access include/linux/seqlock.h:103 [inline]
       ktime_get+0x7c/0x470 kernel/time/timekeeping.c:827
       ktime_get_ns include/linux/timekeeping.h:153 [inline]
       delayacct_end kernel/delayacct.c:48 [inline]
       __delayacct_blkio_end+0x8a/0x190 kernel/delayacct.c:82
       delayacct_blkio_end include/linux/delayacct.h:125 [inline]
       try_to_wake_up+0xc31/0x14a0 kernel/sched/core.c:3452
       wake_page_function+0x22e/0x480 mm/filemap.c:1081
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:108
       wake_up_page_bit+0x11e/0x320 mm/filemap.c:1114
       unlock_page+0x177/0x240 mm/filemap.c:1431
       end_buffer_async_read+0x5d3/0x7d0 fs/buffer.c:290
       end_buffer_async_read_io+0xe0/0x300 fs/buffer.c:335
       end_bio_bh_io_sync+0xe2/0x140 fs/buffer.c:3006
       bio_endio+0x40f/0x810 block/bio.c:1451
       req_bio_endio block/blk-core.c:265 [inline]
       blk_update_request+0x68b/0x1480 block/blk-core.c:1456
       scsi_end_request+0x7a/0x800 drivers/scsi/scsi_lib.c:570
       scsi_io_completion+0x1df/0x1170 drivers/scsi/scsi_lib.c:970
       scsi_softirq_done+0x12f/0x270 drivers/scsi/scsi_lib.c:1450
       blk_complete_reqs+0x9d/0xd0 block/blk-mq.c:576
       __do_softirq+0x29b/0x9f6 kernel/softirq.c:345
       run_ksoftirqd kernel/softirq.c:652 [inline]
       run_ksoftirqd+0x2d/0x60 kernel/softirq.c:644
       smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
       try_to_wake_up+0x98/0x14a0 kernel/sched/core.c:3345
       create_worker+0x4e4/0x6d0 kernel/workqueue.c:1950
       workqueue_init+0x5e4/0x8bf kernel/workqueue.c:6046
       kernel_init_freeable+0x386/0x6c2 init/main.c:1521
       kernel_init+0xd/0x1b8 init/main.c:1424
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:2937 [inline]
       check_prevs_add kernel/locking/lockdep.c:3060 [inline]
       validate_chain kernel/locking/lockdep.c:3675 [inline]
       __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4901
       lock_acquire kernel/locking/lockdep.c:5511 [inline]
       lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5476
       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
       __queue_work+0x366/0xf00 kernel/workqueue.c:1454
       queue_work_on+0xee/0x110 kernel/workqueue.c:1524
       queue_work include/linux/workqueue.h:507 [inline]
       pvclock_gtod_notify arch/x86/kvm/x86.c:7980 [inline]
       pvclock_gtod_notify+0x4a4/0x590 arch/x86/kvm/x86.c:7967
       notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
       update_pvclock_gtod kernel/time/timekeeping.c:653 [inline]
       timekeeping_update+0x2b3/0x4c0 kernel/time/timekeeping.c:749
       change_clocksource+0x1ad/0x290 kernel/time/timekeeping.c:1454
       multi_cpu_stop+0x15f/0x430 kernel/stop_machine.c:240
       cpu_stopper_thread+0x20b/0x490 kernel/stop_machine.c:510
       smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
       kthread+0x3b1/0x4a0 kernel/kthread.c:292
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &p->pi_lock --> tk_core.seq.seqcount

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(tk_core.seq.seqcount);
                               lock(&p->pi_lock);
                               lock(tk_core.seq.seqcount);
  lock(&pool->lock);

 *** DEADLOCK ***

3 locks held by migration/0/16:
 #0: ffffffff8bf90058 (timekeeper_lock){-.-.}-{2:2}, at: change_clocksource+0x1a/0x290 kernel/time/timekeeping.c:1435
 #1: ffffffff8bf8fec8 (tk_core.seq.seqcount){----}-{0:0}, at: multi_cpu_stop+0x15f/0x430 kernel/stop_machine.c:240
 #2: ffffffff8bf718a0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xd0/0xf00 kernel/workqueue.c:1417

stack backtrace:
CPU: 0 PID: 16 Comm: migration/0 Not tainted 5.12.0-rc8-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Stopper: multi_cpu_stop+0x0/0x430 kernel/stop_machine.c:200 <- 0x0
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2128
 check_prev_add kernel/locking/lockdep.c:2937 [inline]
 check_prevs_add kernel/locking/lockdep.c:3060 [inline]
 validate_chain kernel/locking/lockdep.c:3675 [inline]
 __lock_acquire+0x2b14/0x54c0 kernel/locking/lockdep.c:4901
 lock_acquire kernel/locking/lockdep.c:5511 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5476
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 __queue_work+0x366/0xf00 kernel/workqueue.c:1454
 queue_work_on+0xee/0x110 kernel/workqueue.c:1524
 queue_work include/linux/workqueue.h:507 [inline]
 pvclock_gtod_notify arch/x86/kvm/x86.c:7980 [inline]
 pvclock_gtod_notify+0x4a4/0x590 arch/x86/kvm/x86.c:7967
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 update_pvclock_gtod kernel/time/timekeeping.c:653 [inline]
 timekeeping_update+0x2b3/0x4c0 kernel/time/timekeeping.c:749
 change_clocksource+0x1ad/0x290 kernel/time/timekeeping.c:1454
 multi_cpu_stop+0x15f/0x430 kernel/stop_machine.c:240
 cpu_stopper_thread+0x20b/0x490 kernel/stop_machine.c:510
 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
