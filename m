Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3043BE3C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 09:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhGGHmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 03:42:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46877 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhGGHmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 03:42:03 -0400
Received: by mail-io1-f72.google.com with SMTP id a24-20020a5d95580000b029044cbcdddd23so1060634ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 00:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RlWPby5m5M01us5mQTxVv7N+C8Wo5yZcpEmQa5QiOvw=;
        b=Qnl5sAOs6QMHbt6yPIY7TEJEOuKYzVY4BDsJjeA1tt2+c4CpnAr3tx4vJ5o4iKoH0S
         o5fzTuCa30GYnI3HC9GQVhuK4Z6CVYZEZ/dTrH8PjUFwk3Q81I6TPZIKjk2xaLRgHVg7
         BTfbvEUjZTpGJNxgljREaymcPV2VVzXNXW2QNE8V9ttDx/PZ0MyV7eBO46tdupmdI+oD
         c3tfA15rdNTgMkNcMqE/D6fV1GhAEhagieBmMbUUV4Ge3p3SSHyW6tkibf0Fn3gwHfCZ
         56VRSkHk3qPO+OqlRaoxtoJr8itPleCrL+4kjFSpFloVmWUJBSaeRM09cQNrkxvCuT9x
         OgqQ==
X-Gm-Message-State: AOAM531GNrk4bMLf19zV5vbNlXDlmSOCiaX0/Uoov81S2+JFpjEFvWT9
        UhFXFwLPYL6I2lMNscMLER8EsvAWpoDjjmqYIdRaNGTEIrRD
X-Google-Smtp-Source: ABdhPJw4+A4JhdJAHoVYFrw7BDn9FGJsN+gX913g4479/M/9oefPKYSMXM3L9CGGi6x6abqYYbMG6x91DjaJJXD9lP1Y59xrkQEZ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1527:: with SMTP id i7mr2734270ilu.134.1625643562963;
 Wed, 07 Jul 2021 00:39:22 -0700 (PDT)
Date:   Wed, 07 Jul 2021 00:39:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a184905c683a30c@google.com>
Subject: [syzbot] upstream boot error: possible deadlock in fs_reclaim_acquire
From:   syzbot <syzbot+48d0e7b5b3d19b7e1b17@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    77d34a46 Merge tag 'for-linus' of git://git.armlinux.org.u..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1070a84c300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de173057cf7f2559
dashboard link: https://syzkaller.appspot.com/bug?extid=48d0e7b5b3d19b7e1b17

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+48d0e7b5b3d19b7e1b17@syzkaller.appspotmail.com

usbcore: registered new interface driver spca505
usbcore: registered new interface driver spca506
usbcore: registered new interface driver spca508
usbcore: registered new interface driver spca561
usbcore: registered new interface driver spca1528
usbcore: registered new interface driver sq905
usbcore: registered new interface driver sq905c
usbcore: registered new interface driver sq930x
usbcore: registered new interface driver sunplus
usbcore: registered new interface driver stk014
usbcore: registered new interface driver stk1135
usbcore: registered new interface driver stv0680
usbcore: registered new interface driver t613
usbcore: registered new interface driver gspca_topro
usbcore: registered new interface driver touptek
usbcore: registered new interface driver tv8532
usbcore: registered new interface driver vc032x
usbcore: registered new interface driver vicam
usbcore: registered new interface driver xirlink-cit
usbcore: registered new interface driver gspca_zc3xx
usbcore: registered new interface driver ALi m5602
usbcore: registered new interface driver STV06xx
usbcore: registered new interface driver gspca_gl860
usbcore: registered new interface driver Philips webcam
usbcore: registered new interface driver airspy
usbcore: registered new interface driver hackrf
usbcore: registered new interface driver msi2500
cpia2: V4L-Driver for Vision CPiA2 based cameras v3.0.1
usbcore: registered new interface driver cpia2
au0828: au0828 driver loaded
usbcore: registered new interface driver au0828
usbcore: registered new interface driver hdpvr
usbcore: registered new interface driver pvrusb2
pvrusb2: V4L in-tree version:Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tuner
pvrusb2: Debug mask is 31 (0x1f)
usbcore: registered new interface driver stk1160
usbcore: registered new interface driver cx231xx
usbcore: registered new interface driver tm6000
usbcore: registered new interface driver em28xx
em28xx: Registered (Em28xx v4l2 Extension) extension
em28xx: Registered (Em28xx Audio Extension) extension
em28xx: Registered (Em28xx dvb Extension) extension
em28xx: Registered (Em28xx Input Extension) extension
usbcore: registered new interface driver usbtv
usbcore: registered new interface driver go7007
usbcore: registered new interface driver go7007-loader
usbcore: registered new interface driver Abilis Systems as10x usb driver
vivid-000: using single planar format API

======================================================
WARNING: possible circular locking dependency detected
5.13.0-syzkaller #0 Not tainted
------------------------------------------------------
swapper/0/1 is trying to acquire lock:
ffffffff8ba9c9e0 (fs_reclaim){+.+.}-{0:0}, at: fs_reclaim_acquire+0xf7/0x160 mm/page_alloc.c:4585

but task is already holding lock:
ffff8880b9c4d660 (lock#2){..-.}-{2:2}, at: __alloc_pages_bulk+0x4ad/0x1870 mm/page_alloc.c:5290

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (lock#2){..-.}-{2:2}:
       local_lock_acquire include/linux/local_lock_internal.h:42 [inline]
       rmqueue_pcplist mm/page_alloc.c:3674 [inline]
       rmqueue mm/page_alloc.c:3712 [inline]
       get_page_from_freelist+0x4aa/0x2f80 mm/page_alloc.c:4174
       __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5385
       alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
       stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
       kasan_save_stack+0x32/0x40 mm/kasan/common.c:40
       kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
       insert_work+0x48/0x370 kernel/workqueue.c:1332
       __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
       __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1645
       queue_delayed_work_on+0x105/0x120 kernel/workqueue.c:1681
       process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #1 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
       __queue_work+0x366/0xed0 kernel/workqueue.c:1455
       queue_work_on+0xee/0x110 kernel/workqueue.c:1525
       queue_work include/linux/workqueue.h:507 [inline]
       schedule_work include/linux/workqueue.h:568 [inline]
       __vfree_deferred mm/vmalloc.c:2609 [inline]
       vfree_atomic+0xac/0xe0 mm/vmalloc.c:2627
       free_thread_stack kernel/fork.c:292 [inline]
       release_task_stack kernel/fork.c:432 [inline]
       put_task_stack+0x2e0/0x4e0 kernel/fork.c:443
       finish_task_switch.isra.0+0x77f/0xa50 kernel/sched/core.c:4595
       context_switch kernel/sched/core.c:4686 [inline]
       __schedule+0x942/0x26f0 kernel/sched/core.c:5940
       preempt_schedule_irq+0x4e/0x90 kernel/sched/core.c:6328
       irqentry_exit+0x31/0x80 kernel/entry/common.c:427
       asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
       lock_acquire+0x1ef/0x510 kernel/locking/lockdep.c:5593
       __fs_reclaim_acquire mm/page_alloc.c:4563 [inline]
       fs_reclaim_acquire+0x117/0x160 mm/page_alloc.c:4577
       might_alloc include/linux/sched/mm.h:198 [inline]
       slab_pre_alloc_hook mm/slab.h:485 [inline]
       slab_alloc_node mm/slub.c:2891 [inline]
       slab_alloc mm/slub.c:2978 [inline]
       kmem_cache_alloc+0x3e/0x4a0 mm/slub.c:2983
       kmem_cache_zalloc include/linux/slab.h:711 [inline]
       __alloc_file+0x21/0x280 fs/file_table.c:101
       alloc_empty_file+0x6d/0x170 fs/file_table.c:150
       path_openat+0xde/0x27f0 fs/namei.c:3493
       do_filp_open+0x1aa/0x400 fs/namei.c:3534
       do_open_execat+0x116/0x690 fs/exec.c:910
       bprm_execve fs/exec.c:1806 [inline]
       bprm_execve+0x48c/0x19b0 fs/exec.c:1793
       kernel_execve+0x370/0x460 fs/exec.c:1974
       call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __fs_reclaim_acquire mm/page_alloc.c:4563 [inline]
       fs_reclaim_acquire+0x117/0x160 mm/page_alloc.c:4577
       prepare_alloc_pages+0x15c/0x580 mm/page_alloc.c:5175
       __alloc_pages+0x12f/0x500 mm/page_alloc.c:5374
       alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2119
       alloc_pages+0x238/0x2a0 mm/mempolicy.c:2242
       stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
       save_stack+0x15e/0x1e0 mm/page_owner.c:120
       __set_page_owner+0x50/0x290 mm/page_owner.c:181
       prep_new_page mm/page_alloc.c:2444 [inline]
       __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5312
       alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
       vm_area_alloc_pages mm/vmalloc.c:2793 [inline]
       __vmalloc_area_node mm/vmalloc.c:2863 [inline]
       __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2966
       __vmalloc_node mm/vmalloc.c:3015 [inline]
       vzalloc+0x67/0x80 mm/vmalloc.c:3085
       tpg_alloc+0x277/0x530 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:146
       vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1770 [inline]
       vivid_probe.cold+0x1d80/0x86a5 drivers/media/test-drivers/vivid/vivid-core.c:2001
       platform_probe+0xfc/0x1f0 drivers/base/platform.c:1427
       call_driver_probe drivers/base/dd.c:517 [inline]
       really_probe+0x23c/0xcd0 drivers/base/dd.c:595
       __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
       __driver_attach+0x22d/0x4e0 drivers/base/dd.c:1136
       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
       bus_add_driver+0x3a9/0x630 drivers/base/bus.c:618
       driver_register+0x220/0x3a0 drivers/base/driver.c:171
       vivid_init+0x37/0x64 drivers/media/test-drivers/vivid/vivid-core.c:2131
       do_one_initcall+0x103/0x650 init/main.c:1280
       do_initcall_level init/main.c:1353 [inline]
       do_initcalls init/main.c:1369 [inline]
       do_basic_setup init/main.c:1389 [inline]
       kernel_init_freeable+0x6b8/0x741 init/main.c:1591
       kernel_init+0x1a/0x1d0 init/main.c:1483
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &pool->lock --> lock#2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#2);
                               lock(&pool->lock);
                               lock(lock#2);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by swapper/0/1:
 #0: ffffffff8cc8d228 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754 [inline]
 #0: ffffffff8cc8d228 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1028 [inline]
 #0: ffffffff8cc8d228 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x222/0x4e0 drivers/base/dd.c:1135
 #1: ffff8880b9c4d660 (lock#2){..-.}-{2:2}, at: __alloc_pages_bulk+0x4ad/0x1870 mm/page_alloc.c:5290

stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __fs_reclaim_acquire mm/page_alloc.c:4563 [inline]
 fs_reclaim_acquire+0x117/0x160 mm/page_alloc.c:4577
 prepare_alloc_pages+0x15c/0x580 mm/page_alloc.c:5175
 __alloc_pages+0x12f/0x500 mm/page_alloc.c:5374
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2119
 alloc_pages+0x238/0x2a0 mm/mempolicy.c:2242
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2444 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5312
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2793 [inline]
 __vmalloc_area_node mm/vmalloc.c:2863 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2966
 __vmalloc_node mm/vmalloc.c:3015 [inline]
 vzalloc+0x67/0x80 mm/vmalloc.c:3085
 tpg_alloc+0x277/0x530 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:146
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1770 [inline]
 vivid_probe.cold+0x1d80/0x86a5 drivers/media/test-drivers/vivid/vivid-core.c:2001
 platform_probe+0xfc/0x1f0 drivers/base/platform.c:1427
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __driver_attach+0x22d/0x4e0 drivers/base/dd.c:1136
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x3a9/0x630 drivers/base/bus.c:618
 driver_register+0x220/0x3a0 drivers/base/driver.c:171
 vivid_init+0x37/0x64 drivers/media/test-drivers/vivid/vivid-core.c:2131
 do_one_initcall+0x103/0x650 init/main.c:1280
 do_initcall_level init/main.c:1353 [inline]
 do_initcalls init/main.c:1369 [inline]
 do_basic_setup init/main.c:1389 [inline]
 kernel_init_freeable+0x6b8/0x741 init/main.c:1591
 kernel_init+0x1a/0x1d0 init/main.c:1483
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
BUG: sleeping function called from invalid context at mm/page_alloc.c:5178
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
INFO: lockdep is turned off.
irq event stamp: 880390
hardirqs last  enabled at (880389): [<ffffffff892adbe0>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (880389): [<ffffffff892adbe0>] _raw_spin_unlock_irqrestore+0x50/0x70 kernel/locking/spinlock.c:191
hardirqs last disabled at (880390): [<ffffffff81b26ff7>] __alloc_pages_bulk+0x1017/0x1870 mm/page_alloc.c:5290
softirqs last  enabled at (879778): [<ffffffff81463c3e>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last  enabled at (879778): [<ffffffff81463c3e>] __irq_exit_rcu+0x16e/0x1c0 kernel/softirq.c:636
softirqs last disabled at (879773): [<ffffffff81463c3e>] invoke_softirq kernel/softirq.c:432 [inline]
softirqs last disabled at (879773): [<ffffffff81463c3e>] __irq_exit_rcu+0x16e/0x1c0 kernel/softirq.c:636
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
 prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5178
 __alloc_pages+0x12f/0x500 mm/page_alloc.c:5374
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2119
 alloc_pages+0x238/0x2a0 mm/mempolicy.c:2242
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2444 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5312
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2793 [inline]
 __vmalloc_area_node mm/vmalloc.c:2863 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2966
 __vmalloc_node mm/vmalloc.c:3015 [inline]
 vzalloc+0x67/0x80 mm/vmalloc.c:3085
 tpg_alloc+0x277/0x530 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:146
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1770 [inline]
 vivid_probe.cold+0x1d80/0x86a5 drivers/media/test-drivers/vivid/vivid-core.c:2001
 platform_probe+0xfc/0x1f0 drivers/base/platform.c:1427
 call_driver_probe drivers/base/dd.c:517 [inline]
 really_probe+0x23c/0xcd0 drivers/base/dd.c:595
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __driver_attach+0x22d/0x4e0 drivers/base/dd.c:1136
 bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x3a9/0x630 drivers/base/bus.c:618
 driver_register+0x220/0x3a0 drivers/base/driver.c:171
 vivid_init+0x37/0x64 drivers/media/test-drivers/vivid/vivid-core.c:2131
 do_one_initcall+0x103/0x650 init/main.c:1280
 do_initcall_level init/main.c:1353 [inline]
 do_initcalls init/main.c:1369 [inline]
 do_basic_setup init/main.c:1389 [inline]
 kernel_init_freeable+0x6b8/0x741 init/main.c:1591
 kernel_init+0x1a/0x1d0 init/main.c:1483
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
vivid-000: CEC adapter cec0 registered for HDMI input 0
vivid-000: V4L2 capture device registered as video3
vivid-000: CEC adapter cec1 registered for HDMI output 0
vivid-000: V4L2 output device registered as video4
vivid-000: V4L2 capture device registered as vbi0, supports raw and sliced VBI
vivid-000: V4L2 output device registered as vbi1, supports raw and sliced VBI
vivid-000: V4L2 capture device registered as swradio0
vivid-000: V4L2 receiver device registered as radio0
vivid-000: V4L2 transmitter device registered as radio1
vivid-000: V4L2 metadata capture device registered as video5
vivid-000: V4L2 metadata output device registered as video6
vivid-000: V4L2 touch capture device registered as v4l-touch0
vivid-001: using multiplanar format API
vivid-001: CEC adapter cec2 registered for HDMI input 0
vivid-001: V4L2 capture device registered as video7
vivid-001: CEC adapter cec3 registered for HDMI output 0
vivid-001: V4L2 output device registered as video8
vivid-001: V4L2 capture device registered as vbi2, supports raw and sliced VBI
vivid-001: V4L2 output device registered as vbi3, supports raw and sliced VBI
vivid-001: V4L2 capture device registered as swradio1
vivid-001: V4L2 receiver device registered as radio2
vivid-001: V4L2 transmitter device registered as radio3
vivid-001: V4L2 metadata capture device registered as video9
vivid-001: V4L2 metadata output device registered as video10
vivid-001: V4L2 touch capture device registered as v4l-touch1
vivid-002: using single planar format API
vivid-002: CEC adapter cec4 registered for HDMI input 0
vivid-002: V4L2 capture device registered as video11
vivid-002: CEC adapter cec5 registered for HDMI output 0
vivid-002: V4L2 output device registered as video12
vivid-002: V4L2 capture device registered as vbi4, supports raw and sliced VBI
vivid-002: V4L2 output device registered as vbi5, supports raw and sliced VBI
vivid-002: V4L2 capture device registered as swradio2
vivid-002: V4L2 receiver device registered as radio4
vivid-002: V4L2 transmitter device registered as radio5
vivid-002: V4L2 metadata capture device registered as video13
vivid-002: V4L2 metadata output device registered as video14
vivid-002: V4L2 touch capture device registered as v4l-touch2
vivid-003: using multiplanar format API
vivid-003: CEC adapter cec6 registered for HDMI input 0
vivid-003: V4L2 capture device registered as video15
vivid-003: CEC adapter cec7 registered for HDMI output 0
vivid-003: V4L2 output device registered as video16
vivid-003: V4L2 capture device registered as vbi6, supports raw and sliced VBI
vivid-003: V4L2 output device registered as vbi7, supports raw and sliced VBI
vivid-003: V4L2 capture device registered as swradio3
vivid-003: V4L2 receiver device registered as radio6
vivid-003: V4L2 transmitter device registered as radio7
vivid-003: V4L2 metadata capture device registered as video17
vivid-003: V4L2 metadata output device registered as video18
vivid-003: V4L2 touch capture device registered as v4l-touch3
vivid-004: using single planar format API
vivid-004: CEC adapter cec8 registered for HDMI input 0
vivid-004: V4L2 capture device registered as video19
vivid-004: CEC adapter cec9 registered for HDMI output 0
vivid-004: V4L2 output device registered as video20
vivid-004: V4L2 capture device registered as vbi8, supports raw and sliced VBI
vivid-004: V4L2 output device registered as vbi9, supports raw and sliced VBI
vivid-004: V4L2 capture device registered as swradio4
vivid-004: V4L2 receiver device registered as radio8
vivid-004: V4L2 transmitter device registered as radio9
vivid-004: V4L2 metadata capture device registered as video21
vivid-004: V4L2 metadata output device registered as video22
vivid-004: V4L2 touch capture device registered as v4l-touch4
vivid-005: using multiplanar format API
vivid-005: CEC adapter cec10 registered for HDMI input 0
vivid-005: V4L2 capture device registered as video23
vivid-005: CEC adapter cec11 registered for HDMI output 0
vivid-005: V4L2 output device registered as video24
vivid-005: V4L2 capture device registered as vbi10, supports raw and sliced VBI
vivid-005: V4L2 output device registered as vbi11, supports raw and sliced VBI
vivid-005: V4L2 capture device registered as swradio5
vivid-005: V4L2 receiver device registered as radio10
vivid-005: V4L2 transmitter device registered as radio11
vivid-005: V4L2 metadata capture device registered as video25
vivid-005: V4L2 metadata output device registered as video26
vivid-005: V4L2 touch capture device registered as v4l-touch5
vivid-006: using single planar format API
vivid-006: CEC adapter cec12 registered for HDMI input 0
vivid-006: V4L2 capture device registered as video27
vivid-006: CEC adapter cec13 registered for HDMI output 0
vivid-006: V4L2 output device registered as video28
vivid-006: V4L2 capture device registered as vbi12, supports raw and sliced VBI
vivid-006: V4L2 output device registered as vbi13, supports raw and sliced VBI
vivid-006: V4L2 capture device registered as swradio6
vivid-006: V4L2 receiver device registered as radio12
vivid-006: V4L2 transmitter device registered as radio13
vivid-006: V4L2 metadata capture device registered as video29
vivid-006: V4L2 metadata output device registered as video30
vivid-006: V4L2 touch capture device registered as v4l-touch6
vivid-007: using multiplanar format API
vivid-007: CEC adapter cec14 registered for HDMI input 0
vivid-007: V4L2 capture device registered as video31
vivid-007: CEC adapter cec15 registered for HDMI output 0
vivid-007: V4L2 output device registered as video32
vivid-007: V4L2 capture device registered as vbi14, supports raw and sliced VBI
vivid-007: V4L2 output device registered as vbi15, supports raw and sliced VBI
vivid-007: V4L2 capture device registered as swradio7
vivid-007: V4L2 receiver device registered as radio14
vivid-007: V4L2 transmitter device registered as radio15
vivid-007: V4L2 metadata capture device registered as video33
vivid-007: V4L2 metadata output device registered as video34
vivid-007: V4L2 touch capture device registered as v4l-touch7
vivid-008: using single planar format API
vivid-008: CEC adapter cec16 registered for HDMI input 0
vivid-008: V4L2 capture device registered as video35
vivid-008: CEC adapter cec17 registered for HDMI output 0
vivid-008: V4L2 output device registered as video36
vivid-008: V4L2 capture device registered as vbi16, supports raw and sliced VBI
vivid-008: V4L2 output device registered as vbi17, supports raw and sliced VBI
vivid-008: V4L2 capture device registered as swradio8
vivid-008: V4L2 receiver device registered as radio16
vivid-008: V4L2 transmitter device registered as radio17
vivid-008: V4L2 metadata capture device registered as video37
vivid-008: V4L2 metadata output device registered as video38
vivid-008: V4L2 touch capture device registered as v4l-touch8
vivid-009: using multiplanar format API
vivid-009: CEC adapter cec18 registered for HDMI input 0
vivid-009: V4L2 capture device registered as video39
vivid-009: CEC adapter cec19 registered for HDMI output 0
vivid-009: V4L2 output device registered as video40
vivid-009: V4L2 capture device registered as vbi18, supports raw and sliced VBI
vivid-009: V4L2 output device registered as vbi19, supports raw and sliced VBI
vivid-009: V4L2 capture device registered as swradio9
vivid-009: V4L2 receiver device registered as radio18
vivid-009: V4L2 transmitter device registered as radio19
vivid-009: V4L2 metadata capture device registered as video41
vivid-009: V4L2 metadata output device registered as video42
vivid-009: V4L2 touch capture device registered as v4l-touch9
vivid-010: using single planar format API
vivid-010: CEC adapter cec20 registered for HDMI input 0
vivid-010: V4L2 capture device registered as video43
vivid-010: CEC adapter cec21 registered for HDMI output 0
vivid-010: V4L2 output device registered as video44
vivid-010: V4L2 capture device registered as vbi20, supports raw and sliced VBI
vivid-010: V4L2 output device registered as vbi21, supports raw and sliced VBI
vivid-010: V4L2 capture device registered as swradio10
vivid-010: V4L2 receiver device registered as radio20
vivid-010: V4L2 transmitter device registered as radio21
vivid-010: V4L2 metadata capture device registered as video45
vivid-010: V4L2 metadata output device registered as video46
vivid-010: V4L2 touch capture device registered as v4l-touch10
vivid-011: using multiplanar format API
vivid-011: CEC adapter cec22 registered for HDMI input 0
vivid-011: V4L2 capture device registered as video47
vivid-011: CEC adapter cec23 registered for HDMI output 0
vivid-011: V4L2 output device registered as video48
vivid-011: V4L2 capture device registered as vbi22, supports raw and sliced VBI
vivid-011: V4L2 output device registered as vbi23, supports raw and sliced VBI
vivid-011: V4L2 capture device registered as swradio11
vivid-011: V4L2 receiver device registered as radio22
vivid-011: V4L2 transmitter device registered as radio23
vivid-011: V4L2 metadata capture device registered as video49
vivid-011: V4L2 metadata output device registered as video50
vivid-011: V4L2 touch capture device registered as v4l-touch11
vivid-012: using single planar format API
vivid-012: CEC adapter cec24 registered for HDMI input 0
vivid-012: V4L2 capture device registered as video51
vivid-012: CEC adapter cec25 registered for HDMI output 0
vivid-012: V4L2 output device registered as video52
vivid-012: V4L2 capture device registered as vbi24, supports raw and sliced VBI
vivid-012: V4L2 output device registered as vbi25, supports raw and sliced VBI
vivid-012: V4L2 capture device registered as swradio12
vivid-012: V4L2 receiver device registered as radio24
vivid-012: V4L2 transmitter device registered as radio25
vivid-012: V4L2 metadata capture device registered as video53
vivid-012: V4L2 metadata output device registered as video54
vivid-012: V4L2 touch capture device registered as v4l-touch12
vivid-013: using multiplanar format API
vivid-013: CEC adapter cec26 registered for HDMI input 0
vivid-013: V4L2 capture device registered as video55
vivid-013: CEC adapter cec27 registered for HDMI output 0
vivid-013: V4L2 output device registered as video56
vivid-013: V4L2 capture device registered as vbi26, supports raw and sliced VBI
vivid-013: V4L2 output device registered as vbi27, supports raw and sliced VBI
vivid-013: V4L2 capture device registered as swradio13
vivid-013: V4L2 receiver device registered as radio26
vivid-013: V4L2 transmitter device registered as radio27
vivid-013: V4L2 metadata capture device registered as video57
vivid-013: V4L2 metadata output device registered as video58
vivid-013: V4L2 touch capture device registered as v4l-touch13
vivid-014: using single planar format API
vivid-014: CEC adapter cec28 registered for HDMI input 0
vivid-014: V4L2 capture device registered as video59
vivid-014: CEC adapter cec29 registered for HDMI output 0
vivid-014: V4L2 output device registered as video60
vivid-014: V4L2 capture device registered as vbi28, supports raw and sliced VBI
vivid-014: V4L2 output device registered as vbi29, supports raw and sliced VBI
vivid-014: V4L2 capture device registered as swradio14
vivid-014: V4L2 receiver device registered as radio28
vivid-014: V4L2 transmitter device registered as radio29
vivid-014: V4L2 metadata capture device registered as video61
vivid-014: V4L2 metadata output device registered as video62
vivid-014: V4L2 touch capture device registered as v4l-touch14
vivid-015: using multiplanar format API
vivid-015: CEC adapter cec30 registered for HDMI input 0
vivid-015: V4L2 capture device registered as video63
vivid-015: CEC adapter cec31 registered for HDMI output 0
vivid-015: V4L2 output device registered as video64
vivid-015: V4L2 capture device registered as vbi30, supports raw and sliced VBI
vivid-015: V4L2 output device registered as vbi31, supports raw and sliced VBI
vivid-015: V4L2 capture device registered as swradio15
vivid-015: V4L2 receiver device registered as radio30
vivid-015: V4L2 transmitter device registered as radio31
vivid-015: V4L2 metadata capture device registered as video65
vivid-015: V4L2 metadata output device registered as video66
vivid-015: V4L2 touch capture device registered as v4l-touch15
vim2m vim2m.0: Device registered as /dev/video0
vicodec vicodec.0: Device 'stateful-encoder' registered as /dev/video68
vicodec vicodec.0: Device 'stateful-decoder' registered as /dev/video69
vicodec vicodec.0: Device 'stateless-decoder' registered as /dev/video70
dvbdev: DVB: registering new adapter (dvb_vidtv_bridge)
i2c i2c-0: DVB: registering adapter 0 frontend 0 (Dummy demod for DVB-T/T2/C/S/S2)...
dvbdev: dvb_create_media_entity: media entity 'Dummy demod for DVB-T/T2/C/S/S2' registered.
dvbdev: dvb_create_media_entity: media entity 'dvb-demux' registered.
vidtv vidtv.0: Successfully initialized vidtv!
usbcore: registered new interface driver radioshark
usbcore: registered new interface driver radioshark2
usbcore: registered new interface driver dsbr100
usbcore: registered new interface driver radio-si470x
usbcore: registered new interface driver radio-usb-si4713
usbcore: registered new interface driver radio-mr800
usbcore: registered new interface driver radio-keene
usbcore: registered new interface driver radio-ma901
usbcore: registered new interface driver radio-raremono
usbcore: registered new interface driver pcwd_usb
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@redhat.com
device-mapper: multipath round-robin: version 1.2.0 loaded
device-mapper: multipath queue-length: version 0.2.0 loaded
device-mapper: multipath service-time: version 0.3.0 loaded
device-mapper: raid: Loading target version 1.15.1
Bluetooth: HCI UART driver ver 2.3
Bluetooth: HCI UART protocol H4 registered
Bluetooth: HCI UART protocol BCSP registered
Bluetooth: HCI UART protocol LL registered
Bluetooth: HCI UART protocol Three-wire (H5) registered
Bluetooth: HCI UART protocol QCA registered
Bluetooth: HCI UART protocol AG6XX registered
Bluetooth: HCI UART protocol Marvell registered
usbcore: registered new interface driver bcm203x
usbcore: registered new interface driver bpa10x
usbcore: registered new interface driver bfusb
usbcore: registered new interface driver btusb
usbcore: registered new interface driver ath3k
CAPI 2.0 started up with major 68 (middleware)
Modular ISDN core version 1.1.29
NET: Registered PF_ISDN protocol family
DSP module 2.0
mISDN_dsp: DSP clocks every 80 samples. This equals 1 jiffies.
mISDN: Layer-1-over-IP driver Rev. 2.00
0 virtual devices registered
usbcore: registered new interface driver HFC-S_USB
intel_pstate: CPU model not supported
VUB300 Driver rom wait states = 1C irqpoll timeout = 0400
usbcore: registered new interface driver vub300
usbcore: registered new interface driver ushc
iscsi: registered transport (iser)
SoftiWARP attached
Driver 'framebuffer' was unable to register with bus_type 'coreboot' because the bus was not initialized.
Driver 'memconsole' was unable to register with bus_type 'coreboot' because the bus was not initialized.
Driver 'vpd' was unable to register with bus_type 'coreboot' because the bus was not initialized.
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
usbcore: registered new interface driver es2_ap_driver
comedi: version 0.7.76 - http://www.comedi.org
usbcore: registered new interface driver dt9812
usbcore: registered new interface driver ni6501
usbcore: registered new interface driver usbdux
usbcore: registered new interface driver usbduxfast
usbcore: registered new interface driver usbduxsigma
usbcore: registered new interface driver vmk80xx
usbcore: registered new interface driver prism2_usb
usbcore: registered new interface driver r8712u
ashmem: initialized
greybus: registered new driver hid
greybus: registered new driver gbphy
gb_gbphy: registered new driver usb
asus_wmi: ASUS WMI generic driver loaded
usbcore: registered new interface driver snd-usb-audio
usbcore: registered new interface driver snd-ua101
usbcore: registered new interface driver snd-usb-usx2y
usbcore: registered new interface driver snd-usb-us122l
usbcore: registered new interface driver snd-usb-caiaq
usbcore: registered new interface driver snd-usb-6fire
usbcore: registered new interface driver snd-usb-hiface
usbcore: registered new interface driver snd-bcd2000
usbcore: registered new interface driver snd_usb_pod
usbcore: registered new interface driver snd_usb_podhd
usbcore: registered new interface driver snd_usb_toneport
usbcore: registered new interface driver snd_usb_variax
drop_monitor: Initializing network drop monitor service
NET: Registered PF_LLC protocol family
GACT probability on
Mirror/redirect action on
Simple TC action Loaded
netem: version 1.3
u32 classifier
    Performance counters on
    input device check on
    Actions configured
nf_conntrack_irc: failed to register helpers
nf_conntrack_sane: failed to register helpers
nf_conntrack_sip: failed to register helpers
xt_time: kernel timezone is -0000
IPVS: Registered protocols (TCP, UDP, SCTP, AH, ESP)
IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
IPVS: ipvs loaded.
IPVS: [rr] scheduler registered.
IPVS: [wrr] scheduler registered.
IPVS: [lc] scheduler registered.
IPVS: [wlc] scheduler registered.
IPVS: [fo] scheduler registered.
IPVS: [ovf] scheduler registered.
IPVS: [lblc] scheduler registered.
IPVS: [lblcr] scheduler registered.
IPVS: [dh] scheduler registered.
IPVS: [sh] scheduler registered.
IPVS: [mh] scheduler registered.
IPVS: [sed] scheduler registered.
IPVS: [nq] scheduler registered.
IPVS: [twos] scheduler registered.
IPVS: [sip] pe registered.
ipip: IPv4 and MPLS over IPv4 tunneling driver
gre: GRE over IPv4 demultiplexor driver
ip_gre: GRE over IPv4 tunneling driver
IPv4 over IPsec tunneling driver
ipt_CLUSTERIP: ClusterIP Version 0.8 loaded successfully
Initializing XFRM netlink socket
IPsec XFRM device driver
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
RPL Segment Routing with IPv6
mip6: Mobile IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
ip6_gre: GRE over IPv6 tunneling driver
NET: Registered PF_PACKET protocol family
NET: Registered PF_KEY protocol family
Bridge firewalling registered
NET: Registered PF_X25 protocol family
X25: Linux Version 0.2
NET: Registered PF_NETROM protocol family
NET: Registered PF_ROSE protocol family
NET: Registered PF_AX25 protocol family
can: controller area network core
NET: Registered PF_CAN protocol family
can: raw protocol
can: broadcast manager protocol
can: netlink gateway - max_hops=1
can: SAE J1939
can: isotp protocol
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: CMTP (CAPI Emulation) ver 1.0
Bluetooth: CMTP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.2
Bluetooth: HIDP socket layer initialized
NET: Registered PF_RXRPC protocol family
Key type rxrpc registered
Key type rxrpc_s registered
NET: Registered PF_KCM protocol family
lec:lane_module_init: lec.c: initialized
mpoa:atm_mpoa_init: mpc.c: initialized
l2tp_core: L2TP core driver, V2.0
l2tp_ppp: PPPoL2TP kernel driver, V2.0
l2tp_ip: L2TP IP encapsulation support (L2TPv3)
l2tp_netlink: L2TP netlink interface
l2tp_eth: L2TP ethernet pseudowire support (L2TPv3)
l2tp_ip6: L2TP IP encapsulation support for IPv6 (L2TPv3)
NET: Registered PF_PHONET protocol family
8021q: 802.1Q VLAN Support v1.8
DCCP: Activated CCID 2 (TCP-like)
DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
sctp: Hash tables configured (bind 32/56)
NET: Registered PF_RDS protocol family
Registered RDS/infiniband transport
Registered RDS/tcp transport
tipc: Activated (version 2.0.0)
NET: Registered PF_TIPC protocol family
tipc: Started in single node mode
NET: Registered PF_SMC protocol family
9pnet: Installing 9P2000 support
NET: Registered PF_CAIF protocol family
NET: Registered PF_IEEE802154 protocol family
Key type dns_resolver registered
Key type ceph registered
libceph: loaded (mon/osd proto 15/24)
batman_adv: B.A.T.M.A.N. advanced 2021.2 (compatibility version 15) loaded
openvswitch: Open vSwitch switching datapath
NET: Registered PF_VSOCK protocol family
mpls_gso: MPLS GSO support
IPI shorthand broadcast: enabled
AVX2 version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
sched_clock: Marking stable (14944482050, 26399296)->(14981193022, -10311676)
registered taskstats version 1
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
zswap: loaded using pool lzo/zbud
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
Key type ._fscrypt registered
Key type .fscrypt registered
Key type fscrypt-provisioning registered
kAFS: Red Hat AFS client v0.1 registering.
FS-Cache: Netfs 'afs' registered for caching
Btrfs loaded, crc32c=crc32c-intel, assert=on, zoned=yes
Key type big_key registered
Key type encrypted registered
AppArmor: AppArmor sha1 policy hashing enabled
ima: No TPM chip found, activating TPM-bypass!
Loading compiled-in module X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: f850c787ad998c396ae089c083b940ff0a9abb77'
ima: Allocated hash algorithm: sha256
ima: No architecture policies found
evm: Initialising EVM extended attributes:
evm: security.selinux (disabled)
evm: security.SMACK64 (disabled)
evm: security.SMACK64EXEC (disabled)
evm: security.SMACK64TRANSMUTE (disabled)
evm: security.SMACK64MMAP (disabled)
evm: security.apparmor
evm: security.ima
evm: security.capability
evm: HMAC attrs: 0x1
PM:   Magic number: 13:578:855
tty ptyv7: hash matches
tty ptysa: hash matches
printk: console [netcon0] enabled
netconsole: network logging started
gtp: GTP module loaded (pdp ctx size 104 bytes)
rdma_rxe: loaded
cfg80211: Loading compiled-in X.509 certificates for regulatory database
cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
ALSA device list:
  #0: Dummy 1
  #1: Loopback 1
  #2: Virtual MIDI Card 1
md: Waiting for all devices to be available before autodetect
md: If you don't use raid, use raid=noautodetect
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
VFS: Cannot open root device "sda1" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available partitions:
0100            4096 ram0 
 (driver?)
0101            4096 ram1 
 (driver?)
0102            4096 ram2 
 (driver?)
0103            4096 ram3 
 (driver?)
0104            4096 ram4 
 (driver?)
0105            4096 ram5 
 (driver?)
0106            4096 ram6 
 (driver?)
0107            4096 ram7 
 (driver?)
0108            4096 ram8 
 (driver?)
0109            4096 ram9 
 (driver?)
010a            4096 ram10 
 (driver?)
010b            4096 ram11 
 (driver?)
010c            4096 ram12 
 (driver?)
010d            4096 ram13 
 (driver?)
010e            4096 ram14 
 (driver?)
010f            4096 ram15 
 (driver?)
1f00             128 mtdblock0 
 (driver?)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
