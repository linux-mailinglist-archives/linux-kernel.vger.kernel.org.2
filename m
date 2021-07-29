Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D43DAB77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 20:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhG2S5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 14:57:25 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:48801 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhG2S5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 14:57:23 -0400
Received: by mail-il1-f198.google.com with SMTP id p6-20020a056e021446b0290205af2e2342so3719951ilo.15
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 11:57:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B4g8CjUYhyhHHQwWP6lX9+FTCYwl+KxbHM9KgcFJQNI=;
        b=Niw0VCqiZiVCDIaF1cjbuVHl8Q6IsX+cJpg7LTFrw8J1NbuPoJreEh3hZWZqu38xes
         ZSoFZcKlyFz5TEEeGZaBJYQpTB5N3eRpzozJa0Vh8/Z03HrRidBn26sm1TAfZ0XCHvpl
         vISgsxF2ahAkIzgMKdHmhIehbfzaa7PtZPxB78XHk98CFsQ7y9ETf5AY/HHoNsa2/e2m
         4bBoorpQk5u+syDvGeEl1Gxjp0s8IM4VxILLwLx7igF+ybGa4DNxFkbv5jaNQSsOyoHk
         BrecuurQu4IeW80RCm/MgphAHGKz+9WWdBTFlxEn6sVjbM/GVztsyRE5C/8Y6FKQzzeR
         OXFQ==
X-Gm-Message-State: AOAM531VHqm2ZPPbOtyQTzAH6T+YIo8wm1KBNlYS9s4zWvPBnwFqo024
        b/XvvBEqY6JexouM1ROKajV6iYoli4tAufxD5rACiIkQ4PqC
X-Google-Smtp-Source: ABdhPJyqQfxoHGreQK0oa77LdRFrQAW/PezfCpvfijrBN9L1RkKEszK5gEGVZ5YyPy1ZJ8ITtX5iPlCyg1g7Id5Og+mnXNew1Y/a
MIME-Version: 1.0
X-Received: by 2002:a6b:3e8b:: with SMTP id l133mr5181963ioa.137.1627585037817;
 Thu, 29 Jul 2021 11:57:17 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:57:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000005594405c847ac3f@google.com>
Subject: [syzbot] INFO: task hung in flush_to_ldisc (3)
From:   syzbot <syzbot+5864be6ce31bdf05e8ee@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6498f6151825 Merge tag 'riscv-for-linus-5.14-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1085167a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42748795a8952874
dashboard link: https://syzkaller.appspot.com/bug?extid=5864be6ce31bdf05e8ee
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147459f4300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146889b2300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e2c32e300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16e2c32e300000
console output: https://syzkaller.appspot.com/x/log.txt?x=12e2c32e300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5864be6ce31bdf05e8ee@syzkaller.appspotmail.com

INFO: task kworker/u4:0:8 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:0    state:D stack:24104 pid:    8 ppid:     2 flags:0x00004000
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6078
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x7b6/0x10a0 kernel/locking/mutex.c:1104
 flush_to_ldisc+0x3e/0x380 drivers/tty/tty_buffer.c:515
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task syz-executor035:8505 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc2-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor035 state:D stack:28176 pid: 8505 ppid:  8447 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6078
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0x7b6/0x10a0 kernel/locking/mutex.c:1104
 set_selection_kernel drivers/tty/vt/selection.c:357 [inline]
 set_selection_user+0x9f/0x1b0 drivers/tty/vt/selection.c:185
 tioclinux+0x114/0x560 drivers/tty/vt/vt.c:3160
 vt_ioctl+0x225f/0x2ac0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xe4d/0x1600 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4412a9
RSP: 002b:00007ffd8b8eef98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000172c20 RCX: 00000000004412a9
RDX: 0000000020000000 RSI: 000000000000541c RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000000e R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8b8eefdc
R13: 00007ffd8b8ef010 R14: 00007ffd8b8eeff0 R15: 0000000000000015

Showing all locks held in the system:
3 locks held by kworker/u4:0/8:
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff888010869138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x871/0x1630 kernel/workqueue.c:2247
 #1: ffffc90000cd7db0 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1630 kernel/workqueue.c:2251
 #2: ffff8880210310b8 (&buf->lock){+.+.}-{3:3}, at: flush_to_ldisc+0x3e/0x380 drivers/tty/tty_buffer.c:515
1 lock held by khungtaskd/1651:
 #0: ffffffff8b97b9c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/8139:
 #0: ffff88802aa319f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:974
3 locks held by syz-executor035/8503:
1 lock held by syz-executor035/8505:
 #0: ffffffff8c3855c8 (vc_sel.lock){+.+.}-{3:3}, at: set_selection_kernel drivers/tty/vt/selection.c:357 [inline]
 #0: ffffffff8c3855c8 (vc_sel.lock){+.+.}-{3:3}, at: set_selection_user+0x9f/0x1b0 drivers/tty/vt/selection.c:185

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1651 Comm: khungtaskd Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xd0a/0xfc0 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 8503 Comm: syz-executor035 Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:paste_selection+0x2c1/0x4c0 drivers/tty/vt/selection.c:396
Code: be 08 00 00 00 48 89 df e8 3c 40 8d fd 41 80 3e 00 0f 85 c3 01 00 00 48 8b 03 31 ff 83 e0 04 49 89 c7 48 89 c6 e8 5f 11 47 fd <4d> 85 ff 0f 85 88 00 00 00 e8 f1 0b 47 fd 4d 8d bd 38 04 00 00 be
RSP: 0018:ffffc900016ffa88 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff8880246cd4c0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff8880246cd4c0 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff8880246cd4c7
R10: ffffffff842e7cd1 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888028323000 R14: ffffed10048d9a98 R15: 0000000000000000
FS:  00000000016363c0(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001636384 CR3: 00000000211b9000 CR4: 0000000000350ee0
Call Trace:
 tioclinux+0x126/0x560 drivers/tty/vt/vt.c:3164
 vt_ioctl+0x225f/0x2ac0 drivers/tty/vt/vt_ioctl.c:760
 tty_ioctl+0xe4d/0x1600 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4412a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8b8eef98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000063 RCX: 00000000004412a9
RDX: 0000000020000000 RSI: 000000000000541c RDI: 0000000000000003
RBP: 0000000000000063 R08: 000000000000000e R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8b8eefdc
R13: 00007ffd8b8ef010 R14: 00007ffd8b8eeff0 R15: 0000000000000014


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
