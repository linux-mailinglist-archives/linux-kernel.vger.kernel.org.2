Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883FE433BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhJSQYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:24:48 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:44784 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSQYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:24:45 -0400
Received: by mail-il1-f197.google.com with SMTP id i11-20020a92540b000000b0025456903645so10511712ilb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 09:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kImlPyETt2Mgiil4U6/qqXdfh5BZFYhyyE5lVZIvwTE=;
        b=n3kcvKajV0XeAbDiiSVnJc8tKskZdpBhNXDZJwLxEN6UyRTqfpOctM07RovQ/6R3yw
         7/Y7uhmmtMWOIoT1yPDB2cKirI3oIW6u8RqtBUx2ZkxDAnhKxmJqGkqyUbxR1bYjkc65
         T7O+r8ipHgXNjJ8NhT5qLhNrNoyQ2ZSjgDVoL9IGBYF2daaCqOnWACBzZe+KDXDmPQkG
         CTM77SFGC7K+h8xdFuJNV+WXdghW8MMtcuvm/fiwVEa5Bb6MFrHilVcUOlKVhYbR6sx9
         HDYpytFd5YNproferMg7tb0xlU8tyDMXLQSf2jYgfL6ebN6pz1+EOm//EwWu3Aj+3JdQ
         fC0A==
X-Gm-Message-State: AOAM5316avpX5GcZ4gjYLjq35M9H8ETE6sv32zKk/vMRiVWylE8/PnAg
        pXSvI4T2lMqmasfQvVPYAYt49QhtAE4YLf09YxThVpJY2eSY
X-Google-Smtp-Source: ABdhPJxvMFDx+2O9Td8kYmlL5+N4SxI7pXmnPPWbgmUyv7VLXKyEg8PVQxz1sQd+ivMR6ZiFWuFykzq9/To66x0RntAQjI/+voBH
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1343:: with SMTP id i3mr19680214iov.58.1634660551804;
 Tue, 19 Oct 2021 09:22:31 -0700 (PDT)
Date:   Tue, 19 Oct 2021 09:22:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084d90105ceb7119b@google.com>
Subject: [syzbot] INFO: rcu detected stall in newfstat (2)
From:   syzbot <syzbot+40ef7b5e4067ef581a8c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    519d81956ee2 Linux 5.15-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13630630b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f7f46d98a0da80e
dashboard link: https://syzkaller.appspot.com/bug?extid=40ef7b5e4067ef581a8c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165544e8b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159822fcb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40ef7b5e4067ef581a8c@syzkaller.appspotmail.com

mceusb 6-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (1 GPs behind) idle=71b/1/0x4000000000000000 softirq=9149/9150 fqs=3 
	(t=10502 jiffies g=9413 q=137)
rcu: rcu_preempt kthread starved for 10496 jiffies! g9413 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:29248 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xb44/0x5960 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
 rcu_gp_fqs_loop+0x186/0x800 kernel/rcu/tree.c:1957
 rcu_gp_kthread+0x1de/0x320 kernel/rcu/tree.c:2130
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
mceusb 3-1:0.0: Error: urb status = -71
NMI backtrace for cpu 0
CPU: 0 PID: 2968 Comm: systemd-journal Not tainted 5.15.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x2d/0x60 kernel/kcov.c:197
Code: e9 17 8b 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 40 f0 01 00 a9 00 01 ff 00 74 0e 85 c9 74 35 8b 82 64 15 00 00 <85> c0 74 2b 8b 82 40 15 00 00 83 f8 02 75 20 48 8b 8a 48 15 00 00
RSP: 0018:ffffc900000070b0 EFLAGS: 00000006
RAX: 0000000000000000 RBX: ffffffff898cbaa6 RCX: 0000000000000100
RDX: ffff88807b009c80 RSI: ffffffff83f6c7a7 RDI: 0000000000000003
RBP: ffffc900000071d0 R08: ffffffff89e79440 R09: ffffffff83f6c37a
R10: 0000000000000005 R11: 0000000000000036 R12: ffffffff898cbaa8
R13: ffffffff898cbaa6 R14: 1ffff92000000e1a R15: 0000000000000036
FS:  00007f42ee2b38c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffe750f0e30 CR3: 000000001ac32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 format_decode+0x637/0xad0 lib/vsprintf.c:2562
 vsnprintf+0x157/0x14f0 lib/vsprintf.c:2749
 sprintf+0xc0/0x100 lib/vsprintf.c:2999
 print_time kernel/printk/printk.c:1261 [inline]
 info_print_prefix+0x248/0x340 kernel/printk/printk.c:1287
 record_print_text+0x14d/0x3e0 kernel/printk/printk.c:1336
 console_unlock+0x2d8/0xb70 kernel/printk/printk.c:2691
 vprintk_emit+0x198/0x4f0 kernel/printk/printk.c:2244
 dev_vprintk_emit+0x36e/0x3b2 drivers/base/core.c:4596
 dev_printk_emit+0xba/0xf1 drivers/base/core.c:4607
 __dev_printk+0xcf/0xf5 drivers/base/core.c:4619
 _dev_err+0xd7/0x109 drivers/base/core.c:4662
 mceusb_dev_recv.cold+0x159/0x18b drivers/media/rc/mceusb.c:1400
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1656
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1726
 dummy_timer+0x11f9/0x32b0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 invoke_softirq kernel/softirq.c:432 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:636
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1097
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
RIP: 0010:tomoyo_domain_quota_is_ok+0x16d/0x550 security/tomoyo/util.c:1059
Code: 00 48 8b 6d 00 48 3b 2c 24 0f 84 89 00 00 00 e8 89 d9 d3 fd 48 8d 7d 18 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07 42 0f b6 04 30 <38> d0 7f 08 84 c0 0f 85 4a 03 00 00 0f b6 5d 18 31 ff 89 de e8 9a
RSP: 0018:ffffc90002c6f908 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff83a2fe87 RDI: ffff888019e96798
RBP: ffff888019e96780 R08: 0000000000000000 R09: 0000000000000010
R10: ffffffff83a3005a R11: 0000000000000010 R12: 0000000000000022
R13: 00000000000000b0 R14: dffffc0000000000 R15: 0000000000000000
 tomoyo_supervisor+0x2f2/0xf00 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3a0 security/tomoyo/file.c:573
 tomoyo_path_perm+0x2f0/0x400 security/tomoyo/file.c:838
 security_inode_getattr+0xcf/0x140 security/security.c:1333
 vfs_getattr fs/stat.c:157 [inline]
 vfs_fstat+0x43/0xb0 fs/stat.c:182
 __do_sys_newfstat+0x81/0x100 fs/stat.c:422
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f42ed56e2e2
Code: 48 8b 05 b9 db 2b 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 83 ff 01 77 33 48 63 fe b8 05 00 00 00 48 89 d6 0f 05 <48> 3d 00 f0 ff ff 77 06 f3 c3 0f 1f 40 00 48 8b 15 81 db 2b 00 f7
RSP: 002b:00007ffd0d0dcad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000005
RAX: ffffffffffffffda RBX: 00007f42ed829440 RCX: 00007f42ed56e2e2
RDX: 00007ffd0d0dcae0 RSI: 00007ffd0d0dcae0 RDI: 0000000000000015
RBP: 000055d7be808eb0 R08: 0000000000000b40 R09: 000055d7be8090e0
R10: 000055d7be808eb0 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000001c R14: 000055d7be8090e0 R15: 000000000000001c
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 3.463 msecs
NMI backtrace for cpu 1
mceusb 2-1:0.0: Error: urb status = -71
CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.15.0-rc6-syzkaller #0
mceusb 3-1:0.0: Error: urb status = -71
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
mceusb 2-1:0.0: Error: urb status = -71
Call Trace:
 <IRQ>
mceusb 3-1:0.0: Error: urb status = -71
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
mceusb 2-1:0.0: Error: urb status = -71
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
mceusb 3-1:0.0: Error: urb status = -71
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:343
mceusb 2-1:0.0: Error: urb status = -71
 print_cpu_stall kernel/rcu/tree_stall.h:627 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:711 [inline]
 rcu_pending kernel/rcu/tree.c:3880 [inline]
 rcu_sched_clock_irq.cold+0x9d/0x746 kernel/rcu/tree.c:2599
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
 update_process_times+0x16d/0x200 kernel/time/timer.c:1785
mceusb 2-1:0.0: Error: urb status = -71
 tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
mceusb 3-1:0.0: Error: urb status = -71
 tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1421
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
 __run_hrtimer kernel/time/hrtimer.c:1685 [inline]
 __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1749
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
 hrtimer_interrupt+0x31c/0x790 kernel/time/hrtimer.c:1811
mceusb 3-1:0.0: Error: urb status = -71
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1086 [inline]
 __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1103
mceusb 2-1:0.0: Error: urb status = -71
 sysvec_apic_timer_interrupt+0x8e/0xc0 arch/x86/kernel/apic/apic.c:1097
mceusb 3-1:0.0: Error: urb status = -71
 </IRQ>
mceusb 2-1:0.0: Error: urb status = -71
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
mceusb 3-1:0.0: Error: urb status = -71
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
mceusb 2-1:0.0: Error: urb status = -71
Code: 74 24 10 e8 2a fb 22 f8 48 89 ef e8 72 71 23 f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> b3 5c 16 f8 65 8b 05 2c c1 c8 76 85 c0 74 0a 5b 5d c3 e8 c0 d2
mceusb 3-1:0.0: Error: urb status = -71
RSP: 0018:ffffc90000d979f0 EFLAGS: 00000206
mceusb 2-1:0.0: Error: urb status = -71

RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff1fa9942
mceusb 3-1:0.0: Error: urb status = -71
RDX: 0000000000000000 RSI: 0000000000000101 RDI: 0000000000000001
mceusb 2-1:0.0: Error: urb status = -71
RBP: ffff888146884000 R08: 0000000000000001 R09: ffffffff8fcffaaf
mceusb 3-1:0.0: Error: urb status = -71
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888146896440
mceusb 2-1:0.0: Error: urb status = -71
R13: ffff88801539f700 R14: dffffc0000000000 R15: ffff88801c411900
mceusb 3-1:0.0: Error: urb status = -71
 spin_unlock_irqrestore include/linux/spinlock.h:418 [inline]
 dummy_timer+0x12f6/0x32b0 drivers/usb/gadget/udc/dummy_hcd.c:2001
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
 expire_timers kernel/time/timer.c:1466 [inline]
 __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
 __run_timers kernel/time/timer.c:1715 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
 run_ksoftirqd kernel/softirq.c:920 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:912
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
mceusb 5-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 1-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 4-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
mceusb 5-1:0.0: Error: urb status = -71
mceusb 2-1:0.0: Error: urb status = -71
mceusb 6-1:0.0: Error: urb status = -71
mceusb 3-1:0.0: Error: urb status = -71
----------------
Code disassembly (best guess):
   0:	e9 17 8b 7e 89       	jmpq   0x897e8b1c
   5:	c1 48 8b 34          	rorl

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
