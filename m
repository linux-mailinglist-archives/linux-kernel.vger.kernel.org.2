Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985793CC17F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 08:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhGQGZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 02:25:37 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56040 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhGQGZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 02:25:16 -0400
Received: by mail-io1-f70.google.com with SMTP id i13-20020a5d88cd0000b02904e5ab8bdc6cso7722134iol.22
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 23:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vSQ6RHZGOz3Sx7bvdQhQaDT7NtzDRE2Xz21clfUPc1k=;
        b=g0IBUsTE+pn4+Xl5BVHFIHvVBLmJ1N0x+SHG3davcLHKnH4hQ/ILd9Y4ykwUE/JuTz
         KyEYFUsrzEAoLYZryLL454PN6eHd2IIDxFxvLnAhViUQqTYpMzZ2r1QTBMdB5lQ6NiSw
         drNyBIfkZw28NoPy3oiReoL2pekewexQ4r3uO5kaOAYDUAlobronfAZ1ymBDiMYIErUA
         UsKWH/NJZIrWrIdwWE/8GrOCqBNDJOP7y3g0T+rGq+meEFHTe2J2JyM8qFksK2ZBpejU
         KOYkyjqm111lFGY1UaD7aXn7Y4WVsxVkD8lZJpIzrBdHtkFFXN/sgLVCAZ97HA+BF1bO
         GR9Q==
X-Gm-Message-State: AOAM532wFtL79HBsEm+fwNm5uWF2ybkU8IemRcoJJqjSgW+G5gLupq+a
        gM+aNN0z9shO3Lp5i01qskR1f8cM4wYpzoKDHYg0+BA3eNxP
X-Google-Smtp-Source: ABdhPJw1k+b0a+1yRvug8oZ9K3ihJG1RBCSri2rD/7As3lkJm/cJkbo0fQJ0JLK5X6jBz9X9IhAs6Qzj9E9sL4ERkP5pYVBAam/B
MIME-Version: 1.0
X-Received: by 2002:a02:9508:: with SMTP id y8mr12213052jah.28.1626502939726;
 Fri, 16 Jul 2021 23:22:19 -0700 (PDT)
Date:   Fri, 16 Jul 2021 23:22:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2d84305c74bb986@google.com>
Subject: [syzbot] KASAN: use-after-free Write in dec_rlimit_ucounts
From:   syzbot <syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e2869 Merge branch 'for-5.14' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f4b9d8300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1700b0b2b41cd52c
dashboard link: https://syzkaller.appspot.com/bug?extid=01985d7909f9468f013c
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01985d7909f9468f013c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic64_add_return include/asm-generic/atomic-instrumented.h:640 [inline]
BUG: KASAN: use-after-free in atomic_long_add_return include/asm-generic/atomic-long.h:59 [inline]
BUG: KASAN: use-after-free in dec_rlimit_ucounts+0x88/0x170 kernel/ucount.c:272
Write of size 8 at addr ffff888021498d80 by task syz-executor.1/32612

CPU: 0 PID: 32612 Comm: syz-executor.1 Not tainted 5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:96
 print_address_description+0x66/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x163/0x210 mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:135 [inline]
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic64_add_return include/asm-generic/atomic-instrumented.h:640 [inline]
 atomic_long_add_return include/asm-generic/atomic-long.h:59 [inline]
 dec_rlimit_ucounts+0x88/0x170 kernel/ucount.c:272
 release_task+0x323/0x15a0 kernel/exit.c:191
 exit_notify kernel/exit.c:699 [inline]
 do_exit+0x1aa2/0x2510 kernel/exit.c:845
 do_group_exit+0x168/0x2d0 kernel/exit.c:922
 get_signal+0x16c0/0x20d0 kernel/signal.c:2796
 arch_do_signal_or_restart+0x8e/0x6d0 arch/x86/kernel/signal.c:789
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x191/0x220 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:302
 do_syscall_64+0x4c/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: Unable to access opcode bytes at RIP 0x4665af.
RSP: 002b:00007fa6e68ec218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 000000000056bf88 RCX: 00000000004665d9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000056bf8c
RBP: 000000000056bf80 R08: 000000000000000d R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 000000000056bf8c
R13: 00007fff105041ff R14: 00007fa6e68ec300 R15: 0000000000022000

Allocated by task 32600:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc+0xc4/0xf0 mm/kasan/common.c:513
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 kmem_cache_alloc_trace+0x96/0x340 mm/slub.c:2997
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_ucounts+0x176/0x420 kernel/ucount.c:169
 set_cred_ucounts+0x220/0x2d0 kernel/cred.c:684
 __sys_setuid+0x355/0x4a0 kernel/sys.c:623
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 32580:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:360
 ____kasan_slab_free+0x109/0x150 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1639 [inline]
 slab_free_freelist_hook+0x1d8/0x290 mm/slub.c:1664
 slab_free mm/slub.c:3224 [inline]
 kfree+0xcf/0x2d0 mm/slub.c:4268
 put_cred_rcu+0x221/0x400 kernel/cred.c:124
 rcu_do_batch kernel/rcu/tree.c:2558 [inline]
 rcu_core+0x906/0x14b0 kernel/rcu/tree.c:2793
 __do_softirq+0x372/0x783 kernel/softirq.c:558

The buggy address belongs to the object at ffff888021498d00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 128 bytes inside of
 192-byte region [ffff888021498d00, ffff888021498dc0)
The buggy address belongs to the page:
page:ffffea0000852600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21498
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001c8ac80 0000000400000004 ffff888011841a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 32273, ts 862400369934, free_ts 857108006622
 prep_new_page mm/page_alloc.c:2445 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4178
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5386
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
 push_stack+0x86/0x710 kernel/bpf/verifier.c:1019
 check_cond_jmp_op kernel/bpf/verifier.c:8815 [inline]
 do_check+0x18d54/0x218b0 kernel/bpf/verifier.c:10882
 do_check_common+0xc01/0x21a0 kernel/bpf/verifier.c:12865
 do_check_main kernel/bpf/verifier.c:12931 [inline]
 bpf_check+0x112e2/0x14720 kernel/bpf/verifier.c:13498
 bpf_prog_load kernel/bpf/syscall.c:2274 [inline]
 __sys_bpf+0x10923/0x11d80 kernel/bpf/syscall.c:4469
 __do_sys_bpf kernel/bpf/syscall.c:4573 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:4571 [inline]
 __x64_sys_bpf+0x78/0x90 kernel/bpf/syscall.c:4571
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
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
 exit_mm+0x60a/0x770 kernel/exit.c:501
 do_exit+0x6ae/0x2510 kernel/exit.c:812
 do_group_exit+0x168/0x2d0 kernel/exit.c:922
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:933
 __ia32_sys_exit_group+0x0/0x40 kernel/exit.c:931
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff888021498c80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888021498d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888021498d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff888021498e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021498e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
