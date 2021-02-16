Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA5431C688
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 07:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBPGhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 01:37:04 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:38100 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPGg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 01:36:57 -0500
Received: by mail-io1-f71.google.com with SMTP id a12so8506297ioe.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 22:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iszLzMBeRTLoO8PyD6GycRzYEaLBqiitKad70+RYWqQ=;
        b=baXxjV4LNadEGcXl8iZpyFm2nLONitjsvRlxgFeTAS1LUGqH+M/Y8IWh26qdiM6KQF
         aB2biMqHSfq1LbVmjO/JBtkxoaLhZJiGfdfb4iaM5kmQFm1atzD46pvb2Qrovfjc7qOr
         RxfwVn5D/TwFrSdAxOfmEDjMXfT8VGBEXi4aN6sCJYSY4gOWK6M6Asa1AJoMvUTKFup3
         ehNUBohCBSGqV5s5qhA7i0RmBL7RU49biypj1EqUObq90o/Cj+iq/VTfPV2EJ3T/GEsQ
         rUeqBohNGQDCmjNieYkdbVziY7m3NlJx055KU2KVlS7TgZhtYtCvcag97IqZ73b52fba
         2Oww==
X-Gm-Message-State: AOAM532ZRCaphDhOwATmGWV26Z2cA0vq51j0bNWjdXbGKM+KrUTJxgHO
        EtQ2WLubMsYrq5n+2fLkY/GpHp5P1Kxc8fCI6RSymHUQFyVA
X-Google-Smtp-Source: ABdhPJzw0/M/liDMn5PWQKKKtXNUHOMjH74uHbwO3wg67caoHqWun9ooTZkecKVv/0UhXOzDA9G5OyzwXwzU8FxWmfZTfsF3viRv
MIME-Version: 1.0
X-Received: by 2002:a6b:6016:: with SMTP id r22mr15554666iog.93.1613457375433;
 Mon, 15 Feb 2021 22:36:15 -0800 (PST)
Date:   Mon, 15 Feb 2021 22:36:15 -0800
In-Reply-To: <0000000000004a624a05b05a756d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b91a6b05bb6e51fe@google.com>
Subject: Re: INFO: task hung in nbd_ioctl (3)
From:   syzbot <syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchristi@redhat.com,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8b204d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b919ebed7b4902
dashboard link: https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a7953cd00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bc9914d00000

The issue was bisected to:

commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Aug 4 19:10:06 2019 +0000

    nbd: fix max number of supported devs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171556f0500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=149556f0500000
console output: https://syzkaller.appspot.com/x/log.txt?x=109556f0500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")

INFO: task syz-executor645:8465 blocked for more than 143 seconds.
      Not tainted 5.11.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor645 state:D stack:28256 pid: 8465 ppid:  8464 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4327 [inline]
 __schedule+0x999/0xe70 kernel/sched/core.c:5078
 schedule+0x14b/0x200 kernel/sched/core.c:5157
 schedule_timeout+0x43/0x250 kernel/time/timer.c:1854
 do_wait_for_common+0x266/0x3a0 kernel/sched/completion.c:85
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x43/0x50 kernel/sched/completion.c:138
 flush_workqueue+0x704/0x1620 kernel/workqueue.c:2838
 nbd_start_device_ioctl drivers/block/nbd.c:1332 [inline]
 __nbd_ioctl drivers/block/nbd.c:1393 [inline]
 nbd_ioctl+0x76d/0x940 drivers/block/nbd.c:1433
 blkdev_ioctl+0x2d6/0x5f0 block/ioctl.c:576
 block_ioctl+0xae/0xf0 fs/block_dev.c:1658
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4441e9
RSP: 002b:00007ffc87363948 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 00000000004441e9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffc87363ae8 R09: 00007ffc87363ae8
R10: 00007ffc87363ae8 R11: 0000000000000246 R12: 0000000000403500
R13: 431bde82d7b634db R14: 00000000004b2018 R15: 00000000004004a0

Showing all locks held in the system:
1 lock held by khungtaskd/1644:
 #0: ffffffff8c711680 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30 arch/x86/pci/mmconfig_64.c:151
3 locks held by kworker/u5:0/2034:
 #0: ffff888016152938 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: process_one_work+0x6f4/0xfc0 kernel/workqueue.c:2248
 #1: ffffc900072afd78 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work+0x733/0xfc0 kernel/workqueue.c:2250
 #2: ffff888018ca7120 (sk_lock-AF_AX25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1594 [inline]
 #2: ffff888018ca7120 (sk_lock-AF_AX25){+.+.}-{0:0}, at: ax25_recvmsg+0x86/0x740 net/ax25/af_ax25.c:1626
1 lock held by in:imklog/8097:
 #0: ffff8880198b14f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x2f0 fs/file.c:947

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1644 Comm: khungtaskd Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:120
 nmi_cpu_backtrace+0x16c/0x190 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x191/0x2f0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xce9/0xd30 kernel/hung_task.c:294
 kthread+0x39a/0x3c0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4866 Comm: systemd-journal Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rw_verify_area+0xef/0x370 fs/read_write.c:392
Code: 49 8d 9f 20 02 00 00 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 55 a5 f6 ff 48 83 3b 00 <74> 6f 49 8d 5f 28 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff
RSP: 0018:ffffc9000167fde0 EFLAGS: 00000246
RAX: 1ffff110280e66bc RBX: ffff8881407335e0 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000002000 RDI: ffffffffffffffff
RBP: ffffc9000167ff00 R08: ffffffff81c4ad94 R09: ffffed1004612f81
R10: ffffed1004612f81 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000002000 R15: ffff8881407333c0
FS:  00007f86aed678c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86ac137000 CR3: 0000000012623000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 vfs_read+0x168/0xa80 fs/read_write.c:487
 ksys_read+0x11b/0x220 fs/read_write.c:634
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f86ae2f6210
Code: 73 01 c3 48 8b 0d 98 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d b9 c1 20 00 00 75 10 b8 00 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 4e fc ff ff 48 89 04 24
RSP: 002b:00007ffc24b39f78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007ffc24b3c9f0 RCX: 00007f86ae2f6210
RDX: 0000000000002000 RSI: 00007ffc24b3a7f0 RDI: 0000000000000009
RBP: 0000000000000000 R08: 0000000000000008 R09: 0000000000000070
R10: 00007ffc24bb6118 R11: 0000000000000246 R12: 00007ffc24b3a7f0
R13: 00007ffc24b3c948 R14: 00005570d8efb958 R15: 0005bb6e4751e476

