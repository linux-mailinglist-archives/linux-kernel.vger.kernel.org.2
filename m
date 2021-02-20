Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEEC320729
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 22:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhBTVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 16:06:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41438 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhBTVF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 16:05:59 -0500
Received: by mail-il1-f200.google.com with SMTP id d11so5510750ilu.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 13:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZQtpAQVB6/f7QDP6UrdydxZqWOmGn8fxXYvlSfRgRYA=;
        b=esrsyxuH7mJO8Q5JpLBCiJ/mCi9wm9x2KD9TW3aoBLx6MCKVw4BvjERNp2vco69mw0
         xrhomF6XZYBuYLDOaiETgR5hs/jdeuuZ7rd5ZN/aT/jJX13dKrGs0igIRV384l+NxT9f
         Y4Jw5tUk1rXMeocTmyiZOaoOQF6J0Bq/AGvfoC15FcgTkwpVC2wTBgsRK+ItKY4M5Zsq
         MltKibyUF2WZ1tptNipkTlSyufl6/V4TKB7aiU0YNOHuQavCVJedzKtGsOJupp2hksCm
         1uJsBXyQPITPoGwWKDWGPJKMPQwjfTrvAZxeeQnhH84GCZfS7iTpG4lOP9SrkwIuu+c9
         ZmJg==
X-Gm-Message-State: AOAM531e7U8f7akCf5mR25yZ/MtHWTHjtyvL2PIbXtL5a1FBAzg8TJ7D
        p9xRO/hcACtmH+4GdXz7vQsHINHp5FVn0Q7h0vABzIcYdand
X-Google-Smtp-Source: ABdhPJxBvKoivtkVywcBgKlcYLlIG0GUJC+RW16mmJ8QEb6j63KFZ3L/+/c3N/TIr7RPhup7/XQdMiaTqnVirj3kF4umXsd9CuEX
MIME-Version: 1.0
X-Received: by 2002:a92:2e05:: with SMTP id v5mr9738105ile.241.1613855118171;
 Sat, 20 Feb 2021 13:05:18 -0800 (PST)
Date:   Sat, 20 Feb 2021 13:05:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009a2c505bbcaed68@google.com>
Subject: INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
To:     fweisbec@gmail.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1397f498d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e53d04227c52a0df
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a81012d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1282b6d2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-....: (10153 ticks this GP) idle=f1a/1/0x4000000000000000 softirq=10867/10868 fqs=925 
	(t=10502 jiffies g=10029 q=19103)
NMI backtrace for cpu 1
CPU: 1 PID: 10530 Comm: syz-executor248 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x1f4/0x230 kernel/rcu/tree_stall.h:337
 print_cpu_stall kernel/rcu/tree_stall.h:569 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:643 [inline]
 rcu_pending kernel/rcu/tree.c:3751 [inline]
 rcu_sched_clock_irq.cold+0x48e/0xedf kernel/rcu/tree.c:2580
 update_process_times+0x16d/0x200 kernel/time/timer.c:1782
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1369
 __run_hrtimer kernel/time/hrtimer.c:1519 [inline]
 __hrtimer_run_queues+0x1c0/0xe40 kernel/time/hrtimer.c:1583
 hrtimer_interrupt+0x334/0x940 kernel/time/hrtimer.c:1645
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x540 arch/x86/kernel/apic/apic.c:1106
 run_sysvec_on_irqstack_cond arch/x86/include/asm/irq_stack.h:91 [inline]
 sysvec_apic_timer_interrupt+0x48/0x100 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x25/0x50 kernel/locking/spinlock.c:191
Code: f8 5d c3 66 90 55 48 89 fd 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 9a d6 5b f8 48 89 ef e8 42 8b 5c f8 f6 c7 02 75 1a 53 9d <bf> 01 00 00 00 e8 81 92 50 f8 65 8b 05 7a f8 04 77 85 c0 74 0a 5b
RSP: 0018:ffffc90000db0e48 EFLAGS: 00000286
RAX: 0000000000ce281a RBX: 0000000000000286 RCX: 1ffffffff1b46a19
RDX: 0000000000000000 RSI: 0000000000000102 RDI: 0000000000000000
RBP: ffff8880b9d26a00 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8178a8b8 R11: 0000000000000000 R12: 000000a80fcc296a
R13: ffff8880b9d26c80 R14: ffff8880b9d26a00 R15: ffffffff851589e0
 __run_hrtimer kernel/time/hrtimer.c:1515 [inline]
 __hrtimer_run_queues+0x51a/0xe40 kernel/time/hrtimer.c:1583
 hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1600
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:420 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:queue_work_on+0x83/0xd0 kernel/workqueue.c:1530
Code: 31 ff 89 ee e8 6e 02 29 00 40 84 ed 74 46 e8 e4 fb 28 00 31 ff 48 89 de e8 ca 03 29 00 48 85 db 75 26 e8 d0 fb 28 00 41 56 9d <48> 83 c4 08 44 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 b6 fb 28
RSP: 0018:ffffc90002e5fc80 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000200 RCX: 0000000000000000
RDX: ffff8880265f5340 RSI: ffffffff8149da20 RDI: 0000000000000000
RBP: ffffc90002e68000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8178a8b8 R11: 0000000000000000 R12: ffff8880b9d31568
R13: ffff888010c64c00 R14: 0000000000000293 R15: 0000000000000001
 queue_work include/linux/workqueue.h:507 [inline]
 schedule_work include/linux/workqueue.h:568 [inline]
 __vfree_deferred mm/vmalloc.c:2307 [inline]
 vfree_atomic+0xac/0xe0 mm/vmalloc.c:2325
 free_thread_stack kernel/fork.c:291 [inline]
 release_task_stack kernel/fork.c:428 [inline]
 put_task_stack+0x29c/0x480 kernel/fork.c:439
 finish_task_switch.isra.0+0x557/0x7e0 kernel/sched/core.c:4236
 context_switch kernel/sched/core.c:4330 [inline]
 __schedule+0x914/0x21a0 kernel/sched/core.c:5078
 preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:5238
 preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:35
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x36/0x40 kernel/locking/spinlock.c:183
 spin_unlock include/linux/spinlock.h:394 [inline]
 pick_file+0x129/0x1e0 fs/file.c:613
 close_fd+0x44/0x80 fs/file.c:622
 __do_sys_close fs/open.c:1299 [inline]
 __se_sys_close fs/open.c:1297 [inline]
 __x64_sys_close+0x2f/0xa0 fs/open.c:1297
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x403353
Code: c7 c2 c0 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
RSP: 002b:00007ffdb38739a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000403353
RDX: 0000000000042000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000031 R09: 0000000000000031
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000aa47b
R13: 00007ffdb3873a00 R14: 00007ffdb38739f0 R15: 00007ffdb38739c4


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
