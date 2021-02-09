Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27DF314987
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 08:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhBIHaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 02:30:35 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:46661 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhBIHaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 02:30:07 -0500
Received: by mail-il1-f200.google.com with SMTP id j5so14508832ila.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 23:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5orj6tT5T1x1L9vtYG4xbbP5JgnSTrwRQXYq81er3X8=;
        b=fdtXvWRvf8xCC9oUc9UVJCEZZDpmzvxqYiqbcXuHsah4aOdL0GZ7qe20WUyqrMgtdY
         ixYC+80KtW66GrM39EIjxQQ4d1+8ed6TfyVMezAZUAL6c7rQT/liFvF9KUaJ/ZJQ8Kql
         ZRwFsJaFsctUD8IYeOzJ/e/T73TrY+yb4/gfXdJFv1sZOakvR9mrmZ8ie3bX3hyNKOw4
         1g6gvq1Oek6GkgnwGxsIvKLzMaO7+eKw/AI4SOLHBfUV7i3DblW2M17VnyVMMHq+G6/b
         6Fo1xi5ME6e09m+FXhhufLu1hIsJbiMAyoSWwGytJr6MGHGB1hb4jjDhEAPCLZYt9SlO
         ug3w==
X-Gm-Message-State: AOAM530+AitVj3PLBGiKyec3mr5DTuAtEeC5vUxBygpVufFT+5agP9e9
        fMxO6gdfL+DIbLhQb9v2rAKYwVIG1XZtWMaNoAaUeitW2pys
X-Google-Smtp-Source: ABdhPJwxdADdEALKP3KtXbdDCu2prZcA+yi8/ydQOZiURsCf7sBNQXjZ+DiylWQ9rb6mN8A670eC6MYJpj56tiUNH8X3REXfHEKr
MIME-Version: 1.0
X-Received: by 2002:a02:6f47:: with SMTP id b7mr13070776jae.64.1612855764941;
 Mon, 08 Feb 2021 23:29:24 -0800 (PST)
Date:   Mon, 08 Feb 2021 23:29:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f17f6c05bae23ebc@google.com>
Subject: KASAN: use-after-free Read in powermate_config_complete
From:   syzbot <syzbot+cd1a880b2232c9b2c3e2@syzkaller.appspotmail.com>
To:     andreyknvl@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5c279c4c Revert "x86/setup: don't remove E820_TYPE_RAM for..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16aa751b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e83e68d0a6aba5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=cd1a880b2232c9b2c3e2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cd1a880b2232c9b2c3e2@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAINS too low!
turning off the locking correctness validator.
CPU: 1 PID: 27518 Comm: syz-executor.2 Not tainted 5.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 add_chain_cache kernel/locking/lockdep.c:3456 [inline]
 lookup_chain_cache_add kernel/locking/lockdep.c:3555 [inline]
 validate_chain kernel/locking/lockdep.c:3576 [inline]
 __lock_acquire.cold+0x36f/0x39e kernel/locking/lockdep.c:4832
 lock_acquire kernel/locking/lockdep.c:5442 [inline]
 lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
 stack_depot_save+0x1c9/0x4e0 lib/stackdepot.c:283
 kasan_save_stack+0x32/0x40 mm/kasan/common.c:40
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x7f/0xa0 mm/kasan/common.c:429
 kasan_slab_alloc include/linux/kasan.h:209 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc mm/slab.c:3315 [inline]
 kmem_cache_alloc_trace+0x1b1/0x400 mm/slab.c:3552
 kmalloc include/linux/slab.h:552 [inline]
 dummy_urb_enqueue+0x8a/0x8b0 drivers/usb/gadget/udc/dummy_hcd.c:1253
 usb_hcd_submit_urb+0x2b2/0x22d0 drivers/usb/core/hcd.c:1548
 usb_submit_urb+0x6e4/0x1540 drivers/usb/core/urb.c:585
 powermate_sync_state+0x494/0xac0 drivers/input/misc/powermate.c:189
 powermate_config_complete+0x84/0xb0 drivers/input/misc/powermate.c:203
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1656
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1726
 dummy_timer+0x11f4/0x32a0 drivers/usb/gadget/udc/dummy_hcd.c:1971
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
 expire_timers kernel/time/timer.c:1462 [inline]
 __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1731
 __run_timers kernel/time/timer.c:1712 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:420 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:kmem_cache_free+0x75/0x1c0 mm/slab.c:3700
Code: 00 00 4c 89 e6 48 89 ef e8 b8 20 00 00 84 c0 75 0e 4c 89 f2 4c 89 e6 48 89 ef e8 86 c3 ff ff 4d 85 ed 0f 85 ac 00 00 00 53 9d <48> 8b 74 24 28 0f 1f 44 00 00 65 8b 05 6a 5e 4c 7e 83 f8 07 0f 87
RSP: 0018:ffffc9000302f8d8 EFLAGS: 00000286
RAX: 00000000000085a7 RBX: 0000000000000286 RCX: 1ffffffff1b46f39
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888010c4fc00 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8178a708 R11: 0000000000000000 R12: ffff888019eaed20
R13: 0000000000000200 R14: ffffffff8132c949 R15: 0000000000000000
 pgtable_pte_page_dtor include/linux/mm.h:2215 [inline]
 ___pte_free_tlb+0x19/0x150 arch/x86/mm/pgtable.c:55
 __pte_free_tlb arch/x86/include/asm/pgalloc.h:61 [inline]
 free_pte_range mm/memory.c:220 [inline]
 free_pmd_range mm/memory.c:238 [inline]
 free_pud_range mm/memory.c:272 [inline]
 free_p4d_range mm/memory.c:306 [inline]
 free_pgd_range+0x498/0xc10 mm/memory.c:386
 free_pgtables+0x230/0x2f0 mm/memory.c:418
 exit_mmap+0x2c0/0x5a0 mm/mmap.c:3221
 __mmput+0x122/0x470 kernel/fork.c:1082
 mmput+0x53/0x60 kernel/fork.c:1103
 exit_mm kernel/exit.c:501 [inline]
 do_exit+0xb6a/0x2ae0 kernel/exit.c:812
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x427/0x20f0 kernel/signal.c:2773
 arch_do_signal_or_restart+0x2a8/0x1eb0 arch/x86/kernel/signal.c:811
 handle_signal_work kernel/entry/common.c:147 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x148/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:302
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x465b09
Code: Unable to access opcode bytes at RIP 0x465adf.
RSP: 002b:00007f903b08c188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: 0000000000000040 RBX: 000000000056c008 RCX: 0000000000465b09
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000007
RBP: 00000000004b069f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c008
R13: 00007ffd80dac9bf R14: 00007f903b08c300 R15: 0000000000022000
powermate: config urb returned -108
==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x262/0x2b0 kernel/locking/spinlock_debug.c:112
Read of size 4 at addr ffff88802568ae44 by task systemd-journal/4884

CPU: 1 PID: 4884 Comm: systemd-journal Not tainted 5.11.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2c6 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
 do_raw_spin_lock+0x262/0x2b0 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:117 [inline]
 _raw_spin_lock_irqsave+0x41/0x50 kernel/locking/spinlock.c:159
 powermate_config_complete+0x79/0xb0 drivers/input/misc/powermate.c:202
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1656
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1726
 dummy_timer+0x11f4/0x32a0 drivers/usb/gadget/udc/dummy_hcd.c:1971
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
 expire_timers kernel/time/timer.c:1462 [inline]
 __run_timers.part.0+0x67c/0xa50 kernel/time/timer.c:1731
 __run_timers kernel/time/timer.c:1712 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 asm_call_irq_on_stack+0xf/0x20
 </IRQ>
 __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
 run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
 do_softirq_own_stack+0xaa/0xd0 arch/x86/kernel/irq_64.c:77
 invoke_softirq kernel/softirq.c:226 [inline]
 __irq_exit_rcu kernel/softirq.c:420 [inline]
 irq_exit_rcu+0x134/0x200 kernel/softirq.c:432
 sysvec_apic_timer_interrupt+0x4d/0x100 arch/x86/kernel/apic/apic.c:1096
 asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:629
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:163 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:197
Code: 00 00 00 4d 8b 0b 48 0f bd c8 49 8b 14 24 48 63 c9 e9 66 ff ff ff 4c 01 ca 49 89 13 e9 00 fd ff ff 66 0f 1f 84 00 00 00 00 00 <65> 8b 05 29 1c 8f 7e 89 c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b
RSP: 0018:ffffc90001667c38 EFLAGS: 00000246
RAX: 0000000000000007 RBX: 0000000000000fdb RCX: 1ffffffff1b47cb3
RDX: 0000000000000000 RSI: ffffffff8178a721 RDI: ffffffff815b0d2c
RBP: 0000000000001c6a R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8178a708 R11: 0000000000000000 R12: 0000000000000041
R13: 0000000000000000 R14: ffffffff815b0c10 R15: 0000000000000001
 devkmsg_poll+0x122/0x1d0 kernel/printk/printk.c:832
 vfs_poll include/linux/poll.h:90 [inline]
 ep_item_poll+0xf4/0x190 fs/eventpoll.c:840
 ep_send_events fs/eventpoll.c:1677 [inline]
 ep_poll fs/eventpoll.c:1792 [inline]
 do_epoll_wait+0x724/0x1920 fs/eventpoll.c:2220
 __do_sys_epoll_wait fs/eventpoll.c:2232 [inline]
 __se_sys_epoll_wait fs/eventpoll.c:2227 [inline]
 __x64_sys_epoll_wait+0x158/0x270 fs/eventpoll.c:2227
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f3d4ee062e3
Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 3d 29 54 2b 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 0b c2 00 00 48 89 04 24
RSP: 002b:00007ffdd927b1b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 000056461c07a200 RCX: 00007f3d4ee062e3
RDX: 0000000000000013 RSI: 00007ffdd927b1c0 RDI: 0000000000000008
RBP: 00007ffdd927b3b0 R08: 000056461c085860 R09: 00007ffdd9357080
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdd927b1c0
R13: 0000000000000001 R14: 0000000000000000 R15: 0005ba8b8645139e

Allocated by task 19120:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x7f/0xa0 mm/kasan/common.c:429
 kasan_kmalloc include/linux/kasan.h:219 [inline]
 kmem_cache_alloc_trace+0x1e0/0x400 mm/slab.c:3554
 kmalloc include/linux/slab.h:552 [inline]
 kzalloc include/linux/slab.h:682 [inline]
 powermate_probe+0x24a/0x12a0 drivers/input/misc/powermate.c:323
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbc4/0x1d90 drivers/base/core.c:3109
 usb_set_configuration+0x1137/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbc4/0x1d90 drivers/base/core.c:3109
 usb_new_device.cold+0x721/0x1058 drivers/usb/core/hub.c:2555
 hub_port_connect drivers/usb/core/hub.c:5223 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x2357/0x4320 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Freed by task 9766:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
 ____kasan_slab_free+0xb0/0xe0 mm/kasan/common.c:362
 kasan_slab_free include/linux/kasan.h:192 [inline]
 __cache_free mm/slab.c:3424 [inline]
 kfree+0xed/0x270 mm/slab.c:3760
 powermate_disconnect+0x1ce/0x250 drivers/input/misc/powermate.c:432
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1156
 device_release_driver_internal drivers/base/dd.c:1187 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1210
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x502/0xd40 drivers/base/core.c:3288
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1413
 usb_disconnect.cold+0x27d/0x791 drivers/usb/core/hub.c:2218
 hub_port_connect drivers/usb/core/hub.c:5074 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5363 [inline]
 port_event drivers/usb/core/hub.c:5509 [inline]
 hub_event+0x1c9c/0x4320 drivers/usb/core/hub.c:5591
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0x87/0xb0 mm/kasan/generic.c:344
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x700 kernel/rcu/tree.c:3038
 free_fib_info net/ipv4/fib_semantics.c:256 [inline]
 fib_create_info+0x1fda/0x47f0 net/ipv4/fib_semantics.c:1548
 fib_table_insert+0x1ce/0x1af0 net/ipv4/fib_trie.c:1189
 fib_magic+0x3b9/0x520 net/ipv4/fib_frontend.c:1085
 fib_add_ifaddr+0x16c/0x520 net/ipv4/fib_frontend.c:1107
 fib_netdev_event+0x488/0x670 net/ipv4/fib_frontend.c:1466
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2040
 call_netdevice_notifiers_extack net/core/dev.c:2052 [inline]
 call_netdevice_notifiers net/core/dev.c:2066 [inline]
 __dev_notify_flags+0x110/0x2b0 net/core/dev.c:8516
 dev_change_flags+0x100/0x160 net/core/dev.c:8554
 do_setlink+0x891/0x3a70 net/core/rtnetlink.c:2708
 __rtnl_newlink+0xc1c/0x16e0 net/core/rtnetlink.c:3376
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3491
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5553
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 __sys_sendto+0x21c/0x320 net/socket.c:1975
 __do_sys_sendto net/socket.c:1987 [inline]
 __se_sys_sendto net/socket.c:1983 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:1983
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0x87/0xb0 mm/kasan/generic.c:344
 __call_rcu kernel/rcu/tree.c:2965 [inline]
 call_rcu+0xbb/0x700 kernel/rcu/tree.c:3038
 fib6_info_release include/net/ip6_fib.h:336 [inline]
 fib6_info_release include/net/ip6_fib.h:333 [inline]
 fib6_del_route net/ipv6/ip6_fib.c:1993 [inline]
 fib6_del+0x11ae/0x15a0 net/ipv6/ip6_fib.c:2026
 fib6_clean_node+0x398/0x5c0 net/ipv6/ip6_fib.c:2188
 fib6_walk_continue+0x4aa/0x8e0 net/ipv6/ip6_fib.c:2110
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2158
 fib6_clean_tree+0xdb/0x120 net/ipv6/ip6_fib.c:2238
 __fib6_clean_all+0x120/0x290 net/ipv6/ip6_fib.c:2254
 rt6_sync_down_dev net/ipv6/route.c:4780 [inline]
 rt6_disable_ip+0x77f/0x890 net/ipv6/route.c:4785
 addrconf_ifdown.isra.0+0xf6/0x1590 net/ipv6/addrconf.c:3704
 addrconf_notify+0x55c/0x23f0 net/ipv6/addrconf.c:3629
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2040
 call_netdevice_notifiers_extack net/core/dev.c:2052 [inline]
 call_netdevice_notifiers net/core/dev.c:2066 [inline]
 dev_close_many+0x30b/0x650 net/core/dev.c:1641
 rollback_registered_many+0x3ee/0x14c0 net/core/dev.c:9472
 unregister_netdevice_many.part.0+0x1a/0x2f0 net/core/dev.c:10735
 unregister_netdevice_many net/core/dev.c:10734 [inline]
 default_device_exit_batch+0x30c/0x3d0 net/core/dev.c:11218
 ops_exit_list+0x10d/0x160 net/core/net_namespace.c:190
 cleanup_net+0x4ea/0xb10 net/core/net_namespace.c:604
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

The buggy address belongs to the object at ffff88802568ae00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 68 bytes inside of
 256-byte region [ffff88802568ae00, ffff88802568af00)
The buggy address belongs to the page:
page:000000001704bae5 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2568a
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea0000a3e288 ffffea00008b9688 ffff888010c40500
raw: 0000000000000000 ffff88802568a000 0000000100000008 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88802568ad00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802568ad80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802568ae00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff88802568ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802568af00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
