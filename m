Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F65F3B551C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhF0UWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 16:22:46 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:36557 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhF0UWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 16:22:44 -0400
Received: by mail-il1-f198.google.com with SMTP id v4-20020a92cd440000b02901ee67a35b12so6047819ilq.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 13:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y7W9OAJN9khbSVueAeoXtcC3u4Wi00Op8GilTm+dwGE=;
        b=gNQoVL6xO51AjtzKBmmp8Iu7PCDjvwM7e405wHlt29KUnv0ZxJqGj2cYbPrw/963GG
         nquZzILCdbbMXaBwRQH8MDuOjFk80zOcRii+cCZxHI1nFI++5UsaMWG818oam17DErV/
         QtdvFSW8/sUdJKV0lRrxfCPpZ03ZQ4cILxdFd5vRSewkRhFjkD/wP8ed2L094WIRisSx
         0+UseJXx99fPklaAP14r3BZIhbxf62iYgkiGX2wQvhtXYMOjvCO/rRTDiME66Vj5vJC+
         yC1IPktGGn8UucLCEbha/4a/2BBBdpbQ9OLDcmLBZmkNe/V2ciHBpzUb4oV9KWkWGO4f
         GSKA==
X-Gm-Message-State: AOAM530eVC36vvBViVdlpNjYtpx1Y2BN4xfd4Gjmu9W+8y4vOridfUAg
        aJJbYZWRXPFxNmgtExlBnFK9uUGRJR0lOWhtmpFgzvxqhNCi
X-Google-Smtp-Source: ABdhPJwQS/X0ZVSeGShSr/6f8UMHrxc1X9oKQmEo+mB87skuPYJ7FYt2NkJawyZ6VYp+LUVTzan212YhJneFjNW48HOk3P67I2kJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1387:: with SMTP id d7mr15641849ilo.252.1624825220075;
 Sun, 27 Jun 2021 13:20:20 -0700 (PDT)
Date:   Sun, 27 Jun 2021 13:20:20 -0700
In-Reply-To: <000000000000a9b79905c04e25a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000109a4905c5c51a15@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in tx
From:   syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>
To:     Guido.Kiener@rohde-schwarz.com, Thinh.Nguyen@synopsys.com,
        bp@alien8.de, dpenkler@gmail.com, dvyukov@google.com,
        dwmw@amazon.co.uk, gregkh@linuxfoundation.org,
        guido.kiener@rohde-schwarz.com, hpa@zytor.com,
        john.stultz@linaro.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        luto@kernel.org, mathias.nyman@intel.com,
        mathias.nyman@linux.intel.com, mingo@redhat.com, sboyd@kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    625acffd Merge tag 's390-5.13-5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101a20fbd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=279de9012e194ee1
dashboard link: https://syzkaller.appspot.com/bug?extid=e2eae5639e7203360018
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17215fb8300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com

 #3: ffffffff8d5c8818 (kbd_event_lock){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
 #3: ffffffff8d5c8818 (kbd_event_lock){..-.}-{2:2}, at: kbd_event+0x97/0x3c00 drivers/tty/vt/keyboard.c:1525
 #4: ffffffff8cf15d00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30 arch/x86/pci/mmconfig_64.c:151
=============================================
keytouch 0003:0926:3333.00B5: can't resubmit intr, dummy_hcd.4-1/input0, status -19
keytouch 0003:0926:3333.00B5: usb_submit_urb(ctrl) failed: -19
rcu: INFO: rcu_preempt self-detected stall on CPU
rcu: 	1-...!: (2 ticks this GP) idle=d92/1/0x4000000000000000 softirq=25390/25392 fqs=3 
	(t=12164 jiffies g=31645 q=43226)
rcu: rcu_preempt kthread starved for 12162 jiffies! g31645 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26384 pid:   14 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4339 [inline]
 __schedule+0xb98/0x1120 kernel/sched/core.c:5147
 schedule+0x14b/0x200 kernel/sched/core.c:5226
 schedule_timeout+0x1aa/0x2c0 kernel/time/timer.c:1892
 rcu_gp_fqs_loop kernel/rcu/tree.c:2004 [inline]
 rcu_gp_kthread+0x112d/0x2190 kernel/rcu/tree.c:2177
 kthread+0x39a/0x3c0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 3234 Comm: aoe_tx0 Not tainted 5.13.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mark_lock+0x208/0x1eb0 kernel/locking/lockdep.c:4501
Code: ff 8f 49 83 c6 50 4c 89 f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 56 5d 65 00 bb 01 00 00 00 45 85 2e 0f 84 b0 00 00 00 <48> c7 44 24 60 0e 36 e0 45 43 c7 04 27 00 00 00 00 4b c7 44 27 14
RSP: 0018:ffffc90000007580 EFLAGS: 00000002
RAX: 1ffffffff1fff3c2 RBX: 0000000000000001 RCX: ffffffff8161dad9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff9026fd88
RBP: ffffc90000007810 R08: dffffc0000000000 R09: fffffbfff204dfb2
R10: fffffbfff204dfb2 R11: 0000000000000000 R12: 1ffff92000000ebc
R13: 0000000000000002 R14: ffffffff8fff9e10 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00730d2b00 CR3: 00000000141fd000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 mark_usage kernel/locking/lockdep.c:4365 [inline]
 __lock_acquire+0xb66/0x6040 kernel/locking/lockdep.c:4858
 lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5514
 seqcount_lockdep_reader_access+0xe5/0x200 include/linux/seqlock.h:103
 ktime_get+0x35/0x2b0 kernel/time/timekeeping.c:827
 clockevents_program_event+0xe4/0x320 kernel/time/clockevents.c:326
 hrtimer_interrupt+0xbaa/0x1040 kernel/time/hrtimer.c:1676
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:console_trylock_spinning+0x31b/0x3a0 kernel/printk/printk.c:1894
Code: 08 4d 85 ed 74 91 e8 94 c2 19 00 fb 31 db eb 41 e8 8a c2 19 00 e8 95 74 5b 08 4d 85 ed 74 d1 e8 7b c2 19 00 fb bb 01 00 00 00 <48> c7 c7 00 22 df 8c 31 f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00
RSP: 0018:ffffc9000288f360 EFLAGS: 00000293
RAX: ffffffff81655005 RBX: 0000000000000001 RCX: ffff888021699c40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000288f430 R08: ffffffff81654fc2 R09: fffffbfff204dfcb
R10: fffffbfff204dfcb R11: 0000000000000000 R12: 1ffff92000511e6c
R13: 0000000000000200 R14: 0000000000000086 R15: dffffc0000000000
 vprintk_emit+0x201/0x2f0 kernel/printk/printk.c:2173
 dev_vprintk_emit+0x2e1/0x355 drivers/base/core.c:4525
 dev_printk_emit+0xca/0x109 drivers/base/core.c:4536
 __netdev_printk+0x339/0x419 net/core/dev.c:11392
 netdev_warn+0x110/0x158 net/core/dev.c:11445
 ieee802154_subif_start_xmit+0xbd/0x100 net/mac802154/tx.c:125
 __netdev_start_xmit include/linux/netdevice.h:4944 [inline]
 netdev_start_xmit include/linux/netdevice.h:4958 [inline]
 xmit_one net/core/dev.c:3654 [inline]
 dev_hard_start_xmit+0x20b/0x450 net/core/dev.c:3670
 sch_direct_xmit+0x2be/0xec0 net/sched/sch_generic.c:336
 qdisc_restart net/sched/sch_generic.c:401 [inline]
 __qdisc_run+0xa43/0x1c00 net/sched/sch_generic.c:409
 qdisc_run include/net/pkt_sched.h:131 [inline]
 __dev_xmit_skb net/core/dev.c:3857 [inline]
 __dev_queue_xmit+0xedd/0x2fe0 net/core/dev.c:4214
 tx+0x6f/0x110 drivers/block/aoe/aoenet.c:63
 kthread+0x22d/0x440 drivers/block/aoe/aoecmd.c:1230
 kthread+0x39a/0x3c0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
NMI backtrace for cpu 1
CPU: 1 PID: 17756 Comm: systemd-udevd Not tainted 5.13.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x202/0x31e lib/dump_stack.c:120
 nmi_cpu_backtrace+0x16c/0x190 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x191/0x2f0 lib/nmi_backtrace.c:62
 trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
 rcu_dump_cpu_stacks+0x22d/0x390 kernel/rcu/tree_stall.h:341
 print_cpu_stall kernel/rcu/tree_stall.h:624 [inline]
 check_cpu_stall kernel/rcu/tree_stall.h:699 [inline]
 rcu_pending kernel/rcu/tree.c:3911 [inline]
 rcu_sched_clock_irq+0x1d0d/0x2a30 kernel/rcu/tree.c:2649
 update_process_times+0x197/0x200 kernel/time/timer.c:1796
 tick_sched_handle kernel/time/tick-sched.c:226 [inline]
 tick_sched_timer+0x27d/0x420 kernel/time/tick-sched.c:1374
 __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
 __hrtimer_run_queues+0x4cb/0xa60 kernel/time/hrtimer.c:1601
 hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1663
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
 __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1106
 sysvec_apic_timer_interrupt+0x3e/0xb0 arch/x86/kernel/apic/apic.c:1100
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xbc/0x120 kernel/locking/spinlock.c:191
Code: f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 ba ad 03 f8 f6 44 24 21 02 75 4e 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> ff 62 93 f7 65 8b 05 90 64 3e 76 85 c0 74 3f 48 c7 04 24 0e 36
RSP: 0018:ffffc90000dc0800 EFLAGS: 00000206
RAX: 1ffff920001b8104 RBX: ffff888022268000 RCX: ffffffff8161dad9
RDX: dffffc0000000000 RSI: 0000000000000102 RDI: 0000000000000001
RBP: ffffc90000dc0890 R08: dffffc0000000000 R09: fffffbfff204dfce
R10: fffffbfff204dfce R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff920001b8100 R14: ffffc90000dc0820 R15: 0000000000000a06
 dummy_timer+0x3002/0x3100 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0xf6/0x210 kernel/time/timer.c:1431
 expire_timers kernel/time/timer.c:1476 [inline]
 __run_timers+0x6ff/0x910 kernel/time/timer.c:1745
 run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1758
 __do_softirq+0x372/0x7a6 kernel/softirq.c:559
 invoke_softirq kernel/softirq.c:433 [inline]
 __irq_exit_rcu+0x245/0x280 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1100
 </IRQ>
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:647
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xbc/0x120 kernel/locking/spinlock.c:191
Code: f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 ba ad 03 f8 f6 44 24 21 02 75 4e 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> ff 62 93 f7 65 8b 05 90 64 3e 76 85 c0 74 3f 48 c7 04 24 0e 36
RSP: 0018:ffffc9000945f7e0 EFLAGS: 00000206
RAX: 1ffff9200128bf00 RBX: ffffffff911be368 RCX: ffffffff90e87703
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc9000945f870 R08: ffffffff81856800 R09: fffffbfff2237c6e
R10: fffffbfff2237c6e R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff9200128befc R14: ffffc9000945f800 R15: 0000000000000a06
 __debug_check_no_obj_freed lib/debugobjects.c:997 [inline]
 debug_check_no_obj_freed+0x5a2/0x650 lib/debugobjects.c:1018
 slab_free_hook mm/slub.c:1558 [inline]
 slab_free_freelist_hook+0x161/0x290 mm/slub.c:1608
 slab_free mm/slub.c:3168 [inline]
 kmem_cache_free+0x85/0x170 mm/slub.c:3184
 anon_vma_chain_free mm/rmap.c:141 [inline]
 unlink_anon_vmas+0x58b/0x600 mm/rmap.c:439
 free_pgtables+0x7f/0x2d0 mm/memory.c:413
 exit_mmap+0x2be/0x5f0 mm/mmap.c:3209
 __mmput+0x111/0x370 kernel/fork.c:1096
 exit_mm+0x67e/0x7d0 kernel/exit.c:502
 do_exit+0x6b9/0x23d0 kernel/exit.c:813
 do_group_exit+0x168/0x2d0 kernel/exit.c:923
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:934
 __se_sys_exit_group+0x10/0x10 kernel/exit.c:932
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:932
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0072df1618
Code: Unable to access opcode bytes at RIP 0x7f0072df15ee.
RSP: 002b:00007ffc0fb77be8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ffc0fb77cb0 RCX: 00007f0072df1618
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007ffc0fb77d60 R08: 00000000000000e7 R09: fffffffffffffe50
R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000003 R15: 000000000000000e
keytouch 0003:0926:3333.00BB: usb_submit_urb(ctrl) failed: -19
keytouch 0003:0926:3333.00BC: usb_submit_urb(ctrl) failed: -19

