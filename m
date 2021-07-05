Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0CF3BBA14
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 11:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhGEJXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 05:23:07 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:43612 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhGEJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 05:23:05 -0400
Received: by mail-il1-f200.google.com with SMTP id i24-20020a056e021d18b02901ee8f952fd0so10256466ila.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 02:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=a5Wwbi9rUkrEm82fhbrZPPcE2NddEtz7uwIT+1Le3Xk=;
        b=WHKHar9aDlmdsFjB1iKq+/I6XswpsZe2VYuEoz3dPR/7h8wxpitsG6SnXTqOiF90NJ
         tRzwh1BfEfLt0WGqydp4qEUyJviroI7A0ZDpwQMdKx28uB+RH+cHbyXRfX3pGdKN3Dz5
         Jq0N/sfgiSnB5uaxlQNgH8o8grb/Q910HURRxbl3vb0g7eZefd/YCR8N2F9paSm2loS2
         46wb3XJ/HwPp3LQk2dowgoIaftyhI+ATVeILjxw5rCApr4BwebcvA7nQsGz7isV6fl+p
         mbddn82QgBt0rdRl187Y84J2x6+yKVZ0elA2Yn9q4nD0QY09+XCZK2hxXU5CIhuHZ1WT
         7vRg==
X-Gm-Message-State: AOAM532AfKD8lmZJ40okk0fYSu3Mz5+2p3sL8ff2SyvwrzG32TONU1+0
        o9+BAB71ZC+1Y5Chgd8YxbF6wp07os41RMME7dLCBua0nMEq
X-Google-Smtp-Source: ABdhPJweungbPAIcZCzlkStVt37DXqIwi6bGQ2cpE16AvPTShzrNToqZ9+8L0h9QfkLO4TmBrA7bSNY2bmhVcXnjXI+wyyzFLnFO
MIME-Version: 1.0
X-Received: by 2002:a92:c80a:: with SMTP id v10mr9857580iln.251.1625476828235;
 Mon, 05 Jul 2021 02:20:28 -0700 (PDT)
Date:   Mon, 05 Jul 2021 02:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f00e7705c65cd05e@google.com>
Subject: [syzbot] KASAN: use-after-free Write in dec_ucount
From:   syzbot <syzbot+ed34370dbda6d44c06b2@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c692e4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=ed34370dbda6d44c06b2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed34370dbda6d44c06b2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic64_dec_if_positive include/asm-generic/atomic-instrumented.h:1176 [inline]
BUG: KASAN: use-after-free in atomic_long_dec_if_positive include/asm-generic/atomic-long.h:515 [inline]
BUG: KASAN: use-after-free in dec_ucount+0x54/0x130 kernel/ucount.c:245
Write of size 8 at addr ffff888017d7d840 by task kworker/u4:4/24672

CPU: 0 PID: 24672 Comm: kworker/u4:4 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic64_dec_if_positive include/asm-generic/atomic-instrumented.h:1176 [inline]
 atomic_long_dec_if_positive include/asm-generic/atomic-long.h:515 [inline]
 dec_ucount+0x54/0x130 kernel/ucount.c:245
 dec_net_namespaces net/core/net_namespace.c:394 [inline]
 cleanup_net+0x6f3/0xb10 net/core/net_namespace.c:611
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 8464:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_ucounts+0x23d/0x5b0 kernel/ucount.c:169
 set_cred_ucounts+0x171/0x3a0 kernel/cred.c:684
 copy_creds+0x853/0xb20 kernel/cred.c:375
 copy_process+0x1413/0x74c0 kernel/fork.c:1992
 kernel_clone+0xe7/0xab0 kernel/fork.c:2509
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2626
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 13:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1639 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1664
 slab_free mm/slub.c:3224 [inline]
 kfree+0xeb/0x670 mm/slub.c:4268
 put_ucounts kernel/ucount.c:200 [inline]
 put_ucounts+0x117/0x150 kernel/ucount.c:192
 dec_pid_namespaces kernel/pid_namespace.c:67 [inline]
 delayed_free_pidns+0x3f/0x120 kernel/pid_namespace.c:127
 rcu_do_batch kernel/rcu/tree.c:2558 [inline]
 rcu_core+0x7ab/0x1380 kernel/rcu/tree.c:2793
 __do_softirq+0x29b/0x9bd kernel/softirq.c:558

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1332
 __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
 queue_work_on+0xee/0x110 kernel/workqueue.c:1525
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x1f0/0x4c0 kernel/umh.c:435
 kobject_uevent_env+0xf8f/0x1650 lib/kobject_uevent.c:618
 kobject_synth_uevent+0x701/0x850 lib/kobject_uevent.c:208
 uevent_store+0x42/0x90 drivers/base/bus.c:585
 drv_attr_store+0x6d/0xa0 drivers/base/bus.c:77
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x796/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1332
 __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
 queue_work_on+0xee/0x110 kernel/workqueue.c:1525
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x1f0/0x4c0 kernel/umh.c:435
 kobject_uevent_env+0xf8f/0x1650 lib/kobject_uevent.c:618
 kernel_add_sysfs_param kernel/params.c:798 [inline]
 param_sysfs_builtin kernel/params.c:833 [inline]
 param_sysfs_init+0x3bf/0x498 kernel/params.c:952
 do_one_initcall+0x103/0x650 init/main.c:1246
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1355 [inline]
 kernel_init_freeable+0x6b8/0x741 init/main.c:1557
 kernel_init+0x1a/0x1d0 init/main.c:1449
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff888017d7d800
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 64 bytes inside of
 192-byte region [ffff888017d7d800, ffff888017d7d8c0)
The buggy address belongs to the page:
page:ffffea00005f5f40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17d7d
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 0000000300000001 ffff888011041a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 3073366427, free_ts 2934084203
 prep_new_page mm/page_alloc.c:2445 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4178
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5386
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
 alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1702 [inline]
 allocate_slab+0x32b/0x4c0 mm/slub.c:1842
 new_slab mm/slub.c:1905 [inline]
 new_slab_objects mm/slub.c:2651 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2814
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2854
 slab_alloc_node mm/slub.c:2936 [inline]
 slab_alloc mm/slub.c:2978 [inline]
 kmem_cache_alloc_trace+0x325/0x3c0 mm/slub.c:2995
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 call_usermodehelper_setup+0x97/0x340 kernel/umh.c:365
 kobject_uevent_env+0xf73/0x1650 lib/kobject_uevent.c:614
 kernel_add_sysfs_param kernel/params.c:798 [inline]
 param_sysfs_builtin kernel/params.c:833 [inline]
 param_sysfs_init+0x3bf/0x498 kernel/params.c:952
 do_one_initcall+0x103/0x650 init/main.c:1246
 do_initcall_level init/main.c:1319 [inline]
 do_initcalls init/main.c:1335 [inline]
 do_basic_setup init/main.c:1355 [inline]
 kernel_init_freeable+0x6b8/0x741 init/main.c:1557
 kernel_init+0x1a/0x1d0 init/main.c:1449
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1355 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3341 [inline]
 free_unref_page_list+0x1a1/0x1050 mm/page_alloc.c:3457
 release_pages+0x856/0x20a0 mm/swap.c:972
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x620 mm/mmap.c:3204
 __mmput+0x122/0x470 kernel/fork.c:1101
 mmput+0x58/0x60 kernel/fork.c:1122
 free_bprm+0x65/0x2e0 fs/exec.c:1482
 kernel_execve+0x380/0x460 fs/exec.c:1979
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888017d7d700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888017d7d780: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff888017d7d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888017d7d880: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888017d7d900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
