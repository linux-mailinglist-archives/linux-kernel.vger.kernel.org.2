Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051033B8A61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 00:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhF3WWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 18:22:41 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:54962 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhF3WWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 18:22:40 -0400
Received: by mail-io1-f71.google.com with SMTP id m14-20020a5d898e0000b02904f7957d92b5so2815426iol.21
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 15:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OABFmw0CVWE1q/Eyqu/mp46ORWo/pibHtpFXOujzctg=;
        b=iMBSSQfTWw/FseA53LqiiqzPgGUSvgHb7YtukTWckSDZ/47ueictfWX3IuMlbPqAzL
         htG/BP8DxLn9zGmPd/305s0pfI+zdwL3qsn5OgsnubG4OKwUmyGBLSWfjI2Gi7Ip127o
         iDAtveX3CambxO+4PbpmsSemwvrG6+EaLHW8Yad15ER6zI2iV44niuwzKUxB3qqUnNEt
         5NqAsx1Ym+r7+z/E6Llb9oQUwIwdO6rnNJdn6Xw+6qYI5gFrY1nk5Z3lFiSbLFWx6ybT
         ZsKFvU49GgU3D2Y3zv+V5SqtUqpxL6ciK4gmUK+sAo5bD82d+x+7MDAYk6f3KJ6bUqnt
         A4/Q==
X-Gm-Message-State: AOAM531sW1hWb2uR89OFzsFbfIT9IQgbVtq4GSUs6Na01oo/qyXxgkpa
        dlwtUtcohedLKx0PLjDquLSVXVfnEj9AR37i2voy0GZsug+N
X-Google-Smtp-Source: ABdhPJz4wIMT6pofrTdOopOzuBSDPKTQJSFL3Zyj9vqkaM8AGX+UVH+3rKt/oAT9QzenEYX9oi/XMeGCwYzQGJrvkWitDhXdy283
MIME-Version: 1.0
X-Received: by 2002:a6b:3c01:: with SMTP id k1mr9459738iob.24.1625091610713;
 Wed, 30 Jun 2021 15:20:10 -0700 (PDT)
Date:   Wed, 30 Jun 2021 15:20:10 -0700
In-Reply-To: <20210701010032.4046a863@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f235305c6032007@google.com>
Subject: Re: [syzbot] possible deadlock in vmci_qp_broker_detach
From:   syzbot <syzbot+44e40ac2cfe68e8ce207@syzkaller.appspotmail.com>
To:     alex.dewar90@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        hdanton@sina.com, jhansen@vmware.com, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com, vdasa@vmware.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in vmci_ctx_destroy

INFO: task syz-executor.1:10566 blocked for more than 143 seconds.
      Not tainted 5.13.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:28336 pid:10566 ppid:  8853 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4683 [inline]
 __schedule+0xb39/0x5980 kernel/sched/core.c:5940
 schedule+0xd3/0x270 kernel/sched/core.c:6019
 vmci_ctx_destroy+0x2db/0x3b0 drivers/misc/vmw_vmci/vmci_context.c:197
 vmci_host_close+0xef/0x170 drivers/misc/vmw_vmci/vmci_host.c:144
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
RSP: 002b:00007f09abe44188 EFLAGS: 00000246 ORIG_RAX: 0000000000000124
RAX: 0000000000000005 RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffcea410a5f R14: 00007f09abe44300 R15: 0000000000022000

Showing all locks held in the system:
1 lock held by khungtaskd/1641:
 #0: ffffffff8b77d7c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/8286:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1641 Comm: khungtaskd Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd4b/0xfb0 kernel/hung_task.c:294
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:write_comp_data kernel/kcov.c:218 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x17/0x70 kernel/kcov.c:284
Code: 30 f0 4c 89 54 d8 20 48 89 10 5b c3 0f 1f 80 00 00 00 00 41 89 f8 bf 03 00 00 00 4c 8b 14 24 89 f1 65 48 8b 34 25 00 f0 01 00 <e8> 54 f0 ff ff 84 c0 74 4b 48 8b 86 40 15 00 00 8b b6 3c 15 00 00
RSP: 0018:ffffc90000ca7b28 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: ffff88813fec8000 RSI: ffff88813fec8000 RDI: 0000000000000003
RBP: ffff8880109b1e48 R08: 0000000000000000 R09: ffff8880109b1e4b
R10: ffffffff817c6c69 R11: 0000000077db5095 R12: 0000000000000002
R13: ffffc90000ca7bb0 R14: 1ffff92000194f72 R15: 0000000000000022
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdc1cf12000 CR3: 0000000036471000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 trace_hardirqs_on+0x19/0x1c0 kernel/trace/trace_preemptirq.c:42
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
 _raw_spin_unlock_irqrestore+0x50/0x70 kernel/locking/spinlock.c:191
 crng_backtrack_protect drivers/char/random.c:1053 [inline]
 _get_random_bytes+0x295/0x670 drivers/char/random.c:1540
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:540 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:570 [inline]
 nsim_dev_trap_report_work+0x740/0xbd0 drivers/net/netdevsim/dev.c:611
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


Tested on:

commit:         44046219 Merge tag 'for-5.14/drivers-2021-06-29' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e7bbdc300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=efdd5c8b8b556274
dashboard link: https://syzkaller.appspot.com/bug?extid=44e40ac2cfe68e8ce207
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134eb1e8300000

