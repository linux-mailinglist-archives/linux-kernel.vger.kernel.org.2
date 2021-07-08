Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4923A3BF686
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGHH7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhGHH7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:59:05 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19BEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 00:56:23 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id i3-20020a056e021b03b02901f9cee02769so6446119ilv.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 00:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gLwH5KtPcjjHJJ7PTdkBm5w39jiLsxLbRN03Pw9Zx3Q=;
        b=KMzC3fn0+yy5Jkgd69d6U4yFcxmRL/qyuruXAYW0Rhh2FgokqdxMoyM4czWVaFFlcr
         IRtJz/rIkwT5K5kJTS3iqZxUz0tIDlx2Tqs9WX/pRYRzZGqkmx9+qsX24cKzc9bOqVWz
         JdCtKrnEw6JBgv4cMGSEvu9PRL03M0k44Re5e/LxdANGu8AC6FPfYWrORVzc+LUIC24l
         3ZZmAhoNtA/h5zxrgway0dpfgJ2lXMn/79kHTlyNYnJ5BSPO1lUh9UxRcbWOvd2ZBJaY
         h+3xpvdJ0EzoKQm/4Pn7Hv3h4HmjYNeaSyDt7zA1OoLZviT9Rmkr5ir+8+K4p/28ynwU
         fzCw==
X-Gm-Message-State: AOAM5335SI49Yt+f7wpXXt842gjITeksPafdUDRrZStv2vEORAFJv1u5
        S7S/2mb2TdKMbazceE3jpYe4cD+XYoZgDwo2BMrBlHFEHVtX
X-Google-Smtp-Source: ABdhPJyHZDhCyMM1vD7LNy6aj2ALKMKOmJ8xiM3EQHp2Co4X9XY7CTHr4hslfazXbHq2Swa8KAihhyUBstRsI6gc+KxYv5gLxTe4
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2204:: with SMTP id n4mr10696538ion.181.1625730982720;
 Thu, 08 Jul 2021 00:56:22 -0700 (PDT)
Date:   Thu, 08 Jul 2021 00:56:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9ba3805c697fdf5@google.com>
Subject: [syzbot] KASAN: use-after-free Read in inc_rlimit_ucounts
From:   syzbot <syzbot+6913b594227aa60e1925@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=149ba2e2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1700b0b2b41cd52c
dashboard link: https://syzkaller.appspot.com/bug?extid=6913b594227aa60e1925
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1108c6e2300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137c72e4300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6913b594227aa60e1925@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in inc_rlimit_ucounts+0x7a/0x1f0 kernel/ucount.c:257
Read of size 8 at addr ffff888016f76f10 by task syz-executor031/8444

CPU: 1 PID: 8444 Comm: syz-executor031 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:96
 print_address_description+0x66/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x163/0x210 mm/kasan/report.c:436
 inc_rlimit_ucounts+0x7a/0x1f0 kernel/ucount.c:257
 __sigqueue_alloc+0x24c/0x540 kernel/signal.c:428
 __send_signal+0x213/0xe50 kernel/signal.c:1116
 force_sig_info_to_task+0x2a4/0x3f0 kernel/signal.c:1337
 force_sig_fault_to_task kernel/signal.c:1676 [inline]
 force_sig_fault+0x11e/0x1c0 kernel/signal.c:1683
 __bad_area_nosemaphore+0x390/0x570 arch/x86/mm/fault.c:840
 do_kern_addr_fault arch/x86/mm/fault.c:1200 [inline]
 handle_page_fault arch/x86/mm/fault.c:1473 [inline]
 exc_page_fault+0x153/0x1e0 arch/x86/mm/fault.c:1531
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568
RIP: 0033:0x401e38
Code: 4a 00 bf 08 cd 49 00 48 89 e5 e8 b3 d9 07 00 5d e9 5d ff ff ff 0f 1f 44 00 00 e9 53 ff ff ff 0f 1f 00 48 83 ec 08 48 8b 46 10 <64> 8b 14 25 c0 ff ff ff 48 2d 00 00 10 00 48 3d 00 00 30 06 76 1e
RSP: 002b:00007ffec8539b30 EFLAGS: 00010206
RAX: ffffffffffffffc0 RBX: 00000000004ac0f8 RCX: 0000000000000001
RDX: 00007ffec8539b40 RSI: 00007ffec8539c70 RDI: 000000000000000b
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000401e30
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00000000004ac018 R15: 0000000000400488

Allocated by task 8423:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc+0xc4/0xf0 mm/kasan/common.c:513
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 kmem_cache_alloc_trace+0x96/0x340 mm/slub.c:2997
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_ucounts+0x176/0x420 kernel/ucount.c:169
 set_cred_ucounts kernel/cred.c:684 [inline]
 copy_creds+0xb3c/0xd70 kernel/cred.c:375
 copy_process+0xbae/0x5b30 kernel/fork.c:1992
 kernel_clone+0x21a/0x7d0 kernel/fork.c:2509
 __do_sys_clone kernel/fork.c:2626 [inline]
 __se_sys_clone kernel/fork.c:2610 [inline]
 __x64_sys_clone+0x236/0x2b0 kernel/fork.c:2610
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 8444:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:360
 ____kasan_slab_free+0x109/0x150 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1639 [inline]
 slab_free_freelist_hook+0x1d8/0x290 mm/slub.c:1664
 slab_free mm/slub.c:3224 [inline]
 kfree+0xcf/0x2d0 mm/slub.c:4268
 __sigqueue_free kernel/signal.c:455 [inline]
 dequeue_synchronous_signal kernel/signal.c:745 [inline]
 get_signal+0xadf/0x20d0 kernel/signal.c:2676
 arch_do_signal_or_restart+0x8e/0x6d0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:209
 irqentry_exit_to_user_mode+0x6/0x40 kernel/entry/common.c:315
 exc_page_fault+0xe0/0x1e0 arch/x86/mm/fault.c:1534
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:568

Last potentially related work creation:
 kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
 kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
 insert_work+0x54/0x400 kernel/workqueue.c:1332
 __queue_work+0x90e/0xc40 kernel/workqueue.c:1498
 queue_work_on+0x111/0x200 kernel/workqueue.c:1525
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x283/0x470 kernel/umh.c:435
 kobject_uevent_env+0x1337/0x1700 lib/kobject_uevent.c:618
 kobject_synth_uevent+0x3bf/0x900 lib/kobject_uevent.c:208
 uevent_store+0x20/0x60 drivers/base/core.c:2370
 kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0xa39/0xc90 fs/read_write.c:605
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Second to last potentially related work creation:
 kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
 kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
 insert_work+0x54/0x400 kernel/workqueue.c:1332
 __queue_work+0x90e/0xc40 kernel/workqueue.c:1498
 queue_work_on+0x111/0x200 kernel/workqueue.c:1525
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x283/0x470 kernel/umh.c:435
 kobject_uevent_env+0x1337/0x1700 lib/kobject_uevent.c:618
 kobject_synth_uevent+0x3bf/0x900 lib/kobject_uevent.c:208
 uevent_store+0x47/0x70 drivers/base/bus.c:585
 kernfs_fop_write_iter+0x3b6/0x510 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0xa39/0xc90 fs/read_write.c:605
 ksys_write+0x171/0x2a0 fs/read_write.c:658
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888016f76f00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 16 bytes inside of
 192-byte region [ffff888016f76f00, ffff888016f76fc0)
The buggy address belongs to the page:
page:ffffea00005bdd80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16f76
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00005c6340 0000000a0000000a ffff888011841a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 2541399091, free_ts 2456137529
 prep_new_page mm/page_alloc.c:2445 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4178
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5386
 alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2147
 alloc_slab_page mm/slub.c:1702 [inline]
 allocate_slab+0xf1/0x540 mm/slub.c:1842
 new_slab mm/slub.c:1905 [inline]
 new_slab_objects mm/slub.c:2651 [inline]
 ___slab_alloc+0x1cf/0x350 mm/slub.c:2814
 __slab_alloc mm/slub.c:2854 [inline]
 slab_alloc_node mm/slub.c:2936 [inline]
 slab_alloc mm/slub.c:2978 [inline]
 kmem_cache_alloc_trace+0x29d/0x340 mm/slub.c:2995
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 call_usermodehelper_setup+0x8a/0x260 kernel/umh.c:365
 kobject_uevent_env+0x1311/0x1700 lib/kobject_uevent.c:614
 kernel_add_sysfs_param+0x106/0x126 kernel/params.c:798
 param_sysfs_builtin+0x145/0x1b9 kernel/params.c:833
 param_sysfs_init+0x68/0x6c kernel/params.c:952
 do_one_initcall+0x1a7/0x400 init/main.c:1246
 do_initcall_level+0x14a/0x1f5 init/main.c:1319
 do_initcalls+0x4b/0x8c init/main.c:1335
 kernel_init_freeable+0x3f1/0x57e init/main.c:1557
 kernel_init+0x19/0x2a0 init/main.c:1449
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1355 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3341 [inline]
 free_unref_page_list+0x118/0xad0 mm/page_alloc.c:3457
 release_pages+0x18bb/0x1af0 mm/swap.c:972
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:340
 exit_mmap+0x404/0x7a0 mm/mmap.c:3204
 __mmput+0x111/0x370 kernel/fork.c:1101
 free_bprm+0x136/0x2f0 fs/exec.c:1482
 kernel_execve+0x740/0x9a0 fs/exec.c:1979
 call_usermodehelper_exec_async+0x262/0x3b0 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888016f76e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888016f76e80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888016f76f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888016f76f80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888016f77000: 00 00 00 00 00 00 00 00 fc fc fc fc 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
