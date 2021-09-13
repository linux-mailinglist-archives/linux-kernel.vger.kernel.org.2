Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E267408313
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 05:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237970AbhIMDOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 23:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbhIMDOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 23:14:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B3BC06175F;
        Sun, 12 Sep 2021 20:13:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id f129so8085809pgc.1;
        Sun, 12 Sep 2021 20:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=bDLmuiIS8l9ea16+p4hdEv65iZjsiJXngujhhGVMahc=;
        b=H9MNciHb/mcK81+e2XuDNCvZ9r+4ssws66tG7Vb2a4NEBFCW6D/n3gOfyjve1oB/Hn
         VlaYhATkH4VRAYTY6Zz0TfcN7vhKnQGl8sd3AIZXg35cTb2Yii9dG9QESUSAhYOBU9F9
         /3TUj06lXVstaiGiC+C3pbhexUeKTOBeJMfhNIxrC8S0SKzOgI3J8bwxDD72PVEKTfmx
         lBVT/GzWNyta3pZcRDcGy/o8w3iQ5SlVSKvltAa93/0kSQhrB+p4XFthkPxa3Blwih/5
         MoMOHSK90xSHOmzfq36NYOwBYDBIE9J+fZ+WYOzE8uNVUn3+KvSL884DHw84gW4Uzc78
         jtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=bDLmuiIS8l9ea16+p4hdEv65iZjsiJXngujhhGVMahc=;
        b=zYk8+GZBCTweZyGj+iXSNkB4luWfIWAQI6yj2o/BJnVAS+sPc5XHumHpgdXoShRsiw
         gr7yX2o0WhhDT0q1+A0QZ+/Z5/wglaOXFxRUAYTzOc1Qg/wlJoX9t4njT/fITc2xdYSe
         KWD8nZlGOYRYNRJY0vB/xpGum/678CPP19dFSbcH+7kGTx7i8YN6Saxtpzd2Jq/w05nu
         Ice3MjQVBzwL6Rifb+ZDDd0DFB1k2gKDrlP+4w8XUFKPITyUf91NOpx13h7Z20Hzk78N
         rQERZ8fZdJRAuEzDurrJu+l0ntqBnDzKLA0mFR8hbglrICihimUd6hKvao+7Wo0Dz8wk
         CsIw==
X-Gm-Message-State: AOAM5311OHg4aqKSprduIFKDIj+/sa8PAnh4QwKs+3B6ncffMzH8Zq2y
        yVnevnceTLjv+tWZDnSM8hUWNcIhxypLI+INzA==
X-Google-Smtp-Source: ABdhPJw3UB4S3+pBHpSv4hOp5cPlRFyvaje8XqbSoZcfLEJzstxuhIl8o+jhEJL9qvROfUtZ0NxD+ew4oTqxtlOYLLg=
X-Received: by 2002:a63:36c4:: with SMTP id d187mr9179623pga.205.1631502806038;
 Sun, 12 Sep 2021 20:13:26 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 13 Sep 2021 11:13:15 +0800
Message-ID: <CACkBjsYQxQxGQwb3YS4obVWH3EODzqky5=nM3ADP7+13hBYgAA@mail.gmail.com>
Subject: INFO: task hung in hub_port_init
To:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Cc:     a.darwish@linutronix.de, johan@kernel.org,
        linux-kernel@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the Linux kernel, the following crash was triggered.

HEAD commit: ac08b1c68d1b Merge tag 'pci-v5.15-changes'
git tree: upstream
console output:
https://drive.google.com/file/d/1ZeDIMe-DoY3fB32j2p5ifgpq-Lc5N74I/view?usp=sharing
kernel config: https://drive.google.com/file/d/1qrJUXD8ZIeAkg-xojzDpp04v9MtQ8RR6/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1tZe8VmXfxoPqlNpzpGOd-e5WCSWgbkxB/view?usp=sharing
Similar report:
https://groups.google.com/g/syzkaller-bugs/c/zX55CUzjBOY/m/uf91r0XqAgAJ

Sorry, I don't have a C reproducer for this crash but have a Syzlang
reproducer. Also, hope the symbolized report can help.
Here are the instructions on how to execute Syzlang prog:
https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task kworker/2:10:12595 blocked for more than 143 seconds.
      Not tainted 5.14.0+ #15
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/2:10    state:D stack:12600 pid:12595 ppid:     2 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0x323/0xae0 kernel/sched/core.c:6287
 schedule+0x36/0xe0 kernel/sched/core.c:6366
 usb_kill_urb+0xcf/0x110 drivers/usb/core/urb.c:720
 usb_start_wait_urb+0x103/0x1a0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0xee/0x170 drivers/usb/core/message.c:153
 hub_port_init+0x5a8/0x1060 drivers/usb/core/hub.c:4829
 hub_port_connect drivers/usb/core/hub.c:5280 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x1083/0x1ec0 drivers/usb/core/hub.c:5716
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Showing all locks held in the system:
1 lock held by khungtaskd/1673:
 #0: ffffffff85a1d520 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0xe/0x1a0 kernel/locking/lockdep.c:6446
1 lock held by in:imklog/8139:
 #0: ffff88810537cef0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x55/0x60 fs/file.c:990
3 locks held by kworker/u8:2/9082:
 #0: ffff8881000bad38 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #0: ffff8881000bad38 ((wq_completion)netns){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff8881000bad38 ((wq_completion)netns){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #1: ffffc900034d7e70 (net_cleanup_work){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #1: ffffc900034d7e70 (net_cleanup_work){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #1: ffffc900034d7e70 (net_cleanup_work){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #2: ffffffff85e926d0 (pernet_ops_rwsem){++++}-{3:3}, at:
cleanup_net+0x4f/0x4e0 net/core/net_namespace.c:553
5 locks held by kworker/2:10/12595:
 #0: ffff88800a3b0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:633 [inline]
 #0: ffff88800a3b0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #0: ffff88800a3b0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #1: ffffc90003a3fe70 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: set_work_data kernel/workqueue.c:633 [inline]
 #1: ffffc90003a3fe70 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: set_work_pool_and_clear_pending kernel/workqueue.c:661 [inline]
 #1: ffffc90003a3fe70 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: process_one_work+0x2a0/0x850 kernel/workqueue.c:2268
 #2: ffff88800e159220 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:760 [inline]
 #2: ffff88800e159220 (&dev->mutex){....}-{3:3}, at:
hub_event+0xad/0x1ec0 drivers/usb/core/hub.c:5662
 #3: ffff88800e15adc0 (&port_dev->status_lock){+.+.}-{3:3}, at:
usb_lock_port drivers/usb/core/hub.c:3086 [inline]
 #3: ffff88800e15adc0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect drivers/usb/core/hub.c:5279 [inline]
 #3: ffff88800e15adc0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 #3: ffff88800e15adc0 (&port_dev->status_lock){+.+.}-{3:3}, at:
port_event drivers/usb/core/hub.c:5634 [inline]
 #3: ffff88800e15adc0 (&port_dev->status_lock){+.+.}-{3:3}, at:
hub_event+0x106c/0x1ec0 drivers/usb/core/hub.c:5716
 #4: ffff88800e0fbba8 (hcd->address0_mutex){+.+.}-{3:3}, at:
hub_port_init+0x83/0x1060 drivers/usb/core/hub.c:4703

=============================================

NMI backtrace for cpu 2
CPU: 2 PID: 1673 Comm: khungtaskd Not tainted 5.14.0+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:105
 nmi_cpu_backtrace+0x1e9/0x210 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x120/0x180 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0x4e1/0x980 kernel/hung_task.c:295
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 2 to CPUs 0-1,3:
NMI backtrace for cpu 3 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 0
CPU: 0 PID: 4919 Comm: systemd-journal Not tainted 5.14.0+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0033:0x7f64cb4fd944
Code: ff 0f 1f 44 00 00 41 54 55 53 48 83 ec 40 64 48 8b 04 25 28 00
00 00 48 89 44 24 38 31 c0 48 85 ff 48 c7 44 24 10 00 00 00 00 <48> c7
44 24 18 00 00 00 00 48 c7 44 24 20 00 00 00 00 48 c7 44 24
RSP: 002b:00007ffefbc47ab0 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000056107dab12a0 RDI: 000056107dab11e0
RBP: 000056107dab11e0 R08: 00007ffefbd3f080 R09: 00007ffefbd3f080
R10: 00000000000288c8 R11: 0000000000000202 R12: 00007f64cb56e548
R13: 00007f64cb55b147 R14: 00007f64cb5b8800 R15: 0005cb8a5495d061
FS:  00007f64cb8588c0 GS:  0000000000000000
NMI backtrace for cpu 1
CPU: 1 PID: 8140 Comm: rs:main Q:Reg Not tainted 5.14.0+ #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:91 [inline]
RIP: 0010:lock_is_held_type+0x4c/0x140 kernel/locking/lockdep.c:5661
Code: f3 dc 7b 85 c0 74 12 48 83 c4 08 44 89 e8 5b 5d 41 5c 41 5d 41
5e 41 5f c3 65 4c 8b 24 25 40 70 01 00 41 8b 94 24 f4 09 00 00 <85> d2
75 d9 41 89 f6 48 89 fd 9c 8f 04 24 fa 48 c7 c7 d0 46 5d 85
RSP: 0018:ffffc90006a07e20 EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffffffff85a1d4a0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810ba48000
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000000
FS:  00007f672594b700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64c670c000 CR3: 00000001052a5000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 lock_is_held include/linux/lockdep.h:283 [inline]
 rcu_read_lock_sched_held+0x4d/0x80 kernel/rcu/update.c:125
 trace_lock_acquire include/trace/events/lock.h:13 [inline]
 lock_acquire+0x2b7/0x340 kernel/locking/lockdep.c:5596
 do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
 do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
 vtime_user_exit+0x50/0xe0 kernel/sched/cputime.c:719
 __context_tracking_exit+0x88/0x1f0 kernel/context_tracking.c:160
 user_exit_irqoff include/linux/context_tracking.h:47 [inline]
 __enter_from_user_mode kernel/entry/common.c:22 [inline]
 syscall_enter_from_user_mode+0x4a/0x70 kernel/entry/common.c:104
 do_syscall_64+0x15/0xb0 arch/x86/entry/common.c:76
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f672838f1cd
Code: c2 20 00 00 75 10 b8 01 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31
c3 48 83 ec 08 e8 ae fc ff ff 48 89 04 24 b8 01 00 00 00 0f 05 <48> 8b
3c 24 48 89 c2 e8 f7 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007f672594a590 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f671c025620 RCX: 00007f672838f1cd
RDX: 00000000000005fc RSI: 00007f671c025620 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f671c0253a0
R13: 00007f672594a5b0 R14: 000055ff62a4b440 R15: 00000000000005fc
----------------
Code disassembly (best guess), 3 bytes skipped:
   0: 85 c0                test   %eax,%eax
   2: 74 12                je     0x16
   4: 48 83 c4 08          add    $0x8,%rsp
   8: 44 89 e8              mov    %r13d,%eax
   b: 5b                    pop    %rbx
   c: 5d                    pop    %rbp
   d: 41 5c                pop    %r12
   f: 41 5d                pop    %r13
  11: 41 5e                pop    %r14
  13: 41 5f                pop    %r15
  15: c3                    retq
  16: 65 4c 8b 24 25 40 70 mov    %gs:0x17040,%r12
  1d: 01 00
  1f: 41 8b 94 24 f4 09 00 mov    0x9f4(%r12),%edx
  26: 00
* 27: 85 d2                test   %edx,%edx <-- trapping instruction
  29: 75 d9                jne    0x4
  2b: 41 89 f6              mov    %esi,%r14d
  2e: 48 89 fd              mov    %rdi,%rbp
  31: 9c                    pushfq
  32: 8f 04 24              popq   (%rsp)
  35: fa                    cli
  36: 48 c7 c7 d0 46 5d 85 mov    $0xffffffff855d46d0,%rdi
