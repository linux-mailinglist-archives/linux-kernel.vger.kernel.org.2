Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06933DA9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhG2RPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:15:33 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47778 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2RPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:15:32 -0400
Received: by mail-il1-f200.google.com with SMTP id b11-20020a92c84b0000b0290205c6edd752so3599770ilq.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zqW+PPXna4gzkbruTcj2ztQ2AUsoIoF6bjWocmO5kJw=;
        b=llKsSl+/oIjgIb99o13YwaNOedPatc9Ow/a4WijEEixR4KhbC/bouPHakd/oQw4Ik7
         y8UB8/stsBgYmKYmzzlFilzLyroIq3CZXf8U6nznZlmbF1Y+7IrdLsJ3J2fhaR6Ut5XS
         Cy7mbD7Oh1p3U8poNqtBIk4aMw3Ryb9Up20ENXMqpI569AmEyiTRwuxU3Hpzaa7Qbr1q
         e4wna+jVKNud9gOmT74knhV6Ir4oGM88kbdfx59oTFo2XcOovyPYIIYTlMORE+2NHDbf
         DUyxG2rsQasnprvA641/ur9Y3O5vxBqBO67feyXPpd7VNia5x4Q4WB0y3Z0JZ+mK2A79
         CG8w==
X-Gm-Message-State: AOAM533ZpoVLPvvfz3IKhpw088MzWYwIfe+PPlDtAh2y94qmUsUXcqPx
        IqNKccVPJPIol/C/2FCvwI9lsNQHck+dzLp2l2XXC+C/1GO5
X-Google-Smtp-Source: ABdhPJyDFmlmPYctjWvJKu3M6VJCkjsxYdHxxS/bh1zy+1idBphD2yOV8C8Uf1heg/vrKHB87FbQ7B76nBBnf2gmtOtlDo2PvJkx
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e8f:: with SMTP id m15mr5040728iow.80.1627578928063;
 Thu, 29 Jul 2021 10:15:28 -0700 (PDT)
Date:   Thu, 29 Jul 2021 10:15:28 -0700
In-Reply-To: <000000000000a6b91c05c74bb6ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9e8e105c8463f20@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in alloc_ucounts
From:   syzbot <syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4010a528219e Merge tag 'fixes_for_v5.14-rc4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133f4a66300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dee114394f7d2c2
dashboard link: https://syzkaller.appspot.com/bug?extid=59dd63761094a80ad06d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b8851a300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59dd63761094a80ad06d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_add_negative include/asm-generic/atomic-instrumented.h:556 [inline]
BUG: KASAN: use-after-free in get_ucounts kernel/ucount.c:152 [inline]
BUG: KASAN: use-after-free in get_ucounts kernel/ucount.c:150 [inline]
BUG: KASAN: use-after-free in alloc_ucounts+0x19b/0x5b0 kernel/ucount.c:188
Write of size 4 at addr ffff888017c0f61c by task syz-executor.0/12089

CPU: 1 PID: 12089 Comm: syz-executor.0 Not tainted 5.14.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x2d6 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_add_negative include/asm-generic/atomic-instrumented.h:556 [inline]
 get_ucounts kernel/ucount.c:152 [inline]
 get_ucounts kernel/ucount.c:150 [inline]
 alloc_ucounts+0x19b/0x5b0 kernel/ucount.c:188
 set_cred_ucounts+0x171/0x3a0 kernel/cred.c:684
 __sys_setresuid+0x62c/0x840 kernel/sys.c:702
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665e9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f97fb5de188 EFLAGS: 00000246 ORIG_RAX: 0000000000000075
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
RDX: 0000000000000000 RSI: 000000000000ee01 RDI: 000000000000ee01
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffff4281c7f R14: 00007f97fb5de300 R15: 0000000000022000

Allocated by task 10190:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x98/0xc0 mm/kasan/common.c:522
 kasan_kmalloc include/linux/kasan.h:264 [inline]
 kmem_cache_alloc_trace+0x1e4/0x480 mm/slab.c:3575
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_ucounts+0x23d/0x5b0 kernel/ucount.c:169
 set_cred_ucounts+0x171/0x3a0 kernel/cred.c:684
 __sys_setresuid+0x62c/0x840 kernel/sys.c:702
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 9890:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xcd/0x100 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 __cache_free mm/slab.c:3445 [inline]
 kfree+0x106/0x2c0 mm/slab.c:3803
 put_ucounts kernel/ucount.c:200 [inline]
 put_ucounts+0x117/0x150 kernel/ucount.c:192
 put_cred_rcu+0x27a/0x520 kernel/cred.c:124
 rcu_do_batch kernel/rcu/tree.c:2550 [inline]
 rcu_core+0x7ab/0x1380 kernel/rcu/tree.c:2785
 __do_softirq+0x29b/0x9c2 kernel/softirq.c:558

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xa4/0xd0 mm/kasan/generic.c:348
 insert_work+0x48/0x370 kernel/workqueue.c:1332
 __queue_work+0x5c1/0xed0 kernel/workqueue.c:1498
 queue_work_on+0xee/0x110 kernel/workqueue.c:1525
 queue_work include/linux/workqueue.h:507 [inline]
 addr_event.part.0+0x31c/0x4d0 drivers/infiniband/core/roce_gid_mgmt.c:853
 addr_event drivers/infiniband/core/roce_gid_mgmt.c:824 [inline]
 inet6addr_event+0x13e/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:883
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 atomic_notifier_call_chain+0x70/0x180 kernel/notifier.c:217
 ipv6_add_addr+0x1705/0x1f00 net/ipv6/addrconf.c:1152
 addrconf_add_linklocal+0x1ca/0x590 net/ipv6/addrconf.c:3182
 addrconf_addr_gen+0x3a4/0x3e0 net/ipv6/addrconf.c:3313
 addrconf_dev_config+0x253/0x420 net/ipv6/addrconf.c:3360
 addrconf_notify+0x366/0x2400 net/ipv6/addrconf.c:3593
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2123
 netdev_state_change net/core/dev.c:1514 [inline]
 netdev_state_change+0x100/0x130 net/core/dev.c:1507
 linkwatch_do_dev+0x151/0x1b0 net/core/link_watch.c:167
 __linkwatch_run_queue+0x1ea/0x630 net/core/link_watch.c:212
 linkwatch_event+0x4a/0x60 net/core/link_watch.c:251
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff888017c0f600
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 28 bytes inside of
 192-byte region [ffff888017c0f600, ffff888017c0f6c0)
The buggy address belongs to the page:
page:ffffea00005f03c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888017c0fb00 pfn:0x17c0f
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000098a7c8 ffffea0000bcb3c8 ffff888010840000
raw: ffff888017c0fb00 ffff888017c0f000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x242220(__GFP_HIGH|__GFP_ATOMIC|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 8466, ts 421925544813, free_ts 416394009964
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4169
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5391
 __alloc_pages_node include/linux/gfp.h:570 [inline]
 kmem_getpages mm/slab.c:1377 [inline]
 cache_grow_begin+0x75/0x460 mm/slab.c:2593
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2965
 ____cache_alloc mm/slab.c:3048 [inline]
 ____cache_alloc mm/slab.c:3031 [inline]
 __do_cache_alloc mm/slab.c:3275 [inline]
 slab_alloc mm/slab.c:3316 [inline]
 kmem_cache_alloc_trace+0x38c/0x480 mm/slab.c:3573
 kmalloc include/linux/slab.h:591 [inline]
 addr_event.part.0+0x7b/0x4d0 drivers/infiniband/core/roce_gid_mgmt.c:840
 addr_event drivers/infiniband/core/roce_gid_mgmt.c:824 [inline]
 inet6addr_event+0x13e/0x1b0 drivers/infiniband/core/roce_gid_mgmt.c:883
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 atomic_notifier_call_chain+0x70/0x180 kernel/notifier.c:217
 ipv6_add_addr+0x1705/0x1f00 net/ipv6/addrconf.c:1152
 addrconf_add_linklocal+0x1ca/0x590 net/ipv6/addrconf.c:3182
 addrconf_addr_gen+0x3a4/0x3e0 net/ipv6/addrconf.c:3313
 addrconf_dev_config+0x253/0x420 net/ipv6/addrconf.c:3360
 addrconf_notify+0x366/0x2400 net/ipv6/addrconf.c:3593
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2123
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1397
 free_unref_page_prepare mm/page_alloc.c:3332 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3411
 slab_destroy mm/slab.c:1627 [inline]
 slabs_destroy+0x89/0xc0 mm/slab.c:1647
 cache_flusharray mm/slab.c:3418 [inline]
 ___cache_free+0x4ba/0x600 mm/slab.c:3480
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x4e/0x110 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x8b/0xa0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc mm/slab.c:3323 [inline]
 kmem_cache_alloc+0x25f/0x540 mm/slab.c:3507
 prepare_kernel_cred+0x27/0x8a0 kernel/cred.c:724
 call_usermodehelper_exec_async+0x10e/0x580 kernel/umh.c:91
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888017c0f500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888017c0f580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888017c0f600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888017c0f680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888017c0f700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

