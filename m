Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9183BF687
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhGHH7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:59:12 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:46947 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhGHH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:59:04 -0400
Received: by mail-io1-f72.google.com with SMTP id a24-20020a5d95580000b029044cbcdddd23so3500735ios.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 00:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O7AQKpyZLQC3aFNhzqdwbPrrpitp3omasznrK3n6h5g=;
        b=nFA5zZULT/I22VpIZgHKsLs6cdb8kep2x22LKs6hb+v6gjQnLiOP3Ji+meyy7OyGW7
         TopEl8FumBg7BFgq6FyGt96Dookjpx8Vlx/dRQreDIOTdlxJYlYIIWiG1Z1ddRnLt14k
         u4VVIZiXLOrvqIJ7kh+8eVD9hzl4NweweRN7zK3lvrhej5talXFbUssyVWtJ+Q+m42rA
         EWXbBNHje22PX1JWQvfHNGmZ4q4tiJzGCDEH7ZRpDrCTlws/cQAe11mn9SxkuSacib5/
         WkSFNndmWzylmfhoCMbokMMzGqKRgcyCJwYdr/7SZ03vqPXpEpgggr2ccNIzlOf2o4vK
         cymQ==
X-Gm-Message-State: AOAM532VwmDmBBz0tnP1AcLkBbHvOh47LYjFKSSJ0dTN2isFm0GRmmTE
        tR1w318kbib2of8ZCemDD6pf+y1AZ1sc42XGHmtsSUrGmOoe
X-Google-Smtp-Source: ABdhPJxw1hU+YC0mw8cRKCbb5cdddK60p8VSTlVUr314MpUNLbHfczXNQnXHcyvIZDXH97HB++ZsJFv4SkYnkIrGoocRjcms80oJ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a1:: with SMTP id z1mr63518jap.77.1625730982828;
 Thu, 08 Jul 2021 00:56:22 -0700 (PDT)
Date:   Thu, 08 Jul 2021 00:56:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb5f8605c697fd87@google.com>
Subject: [syzbot] KASAN: use-after-free Write in get_ucounts
From:   syzbot <syzbot+8c3af233123df0578a5c@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=160c4854300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1700b0b2b41cd52c
dashboard link: https://syzkaller.appspot.com/bug?extid=8c3af233123df0578a5c
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1652cdc4300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c3af233123df0578a5c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_add_negative include/asm-generic/atomic-instrumented.h:556 [inline]
BUG: KASAN: use-after-free in get_ucounts+0x28/0x160 kernel/ucount.c:152
Write of size 4 at addr ffff888014fe2e1c by task syz-executor.0/14561

CPU: 1 PID: 14561 Comm: syz-executor.0 Not tainted 5.13.0-syzkaller #0
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
 atomic_add_negative include/asm-generic/atomic-instrumented.h:556 [inline]
 get_ucounts+0x28/0x160 kernel/ucount.c:152
 set_cred_ucounts+0x220/0x2d0 kernel/cred.c:684
 __sys_setuid+0x355/0x4a0 kernel/sys.c:623
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf0138f188 EFLAGS: 00000246 ORIG_RAX: 0000000000000069
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000003065ff
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffd26c2c90f R14: 00007fcf0138f300 R15: 0000000000022000

Allocated by task 14004:
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

Freed by task 14561:
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
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:659 [inline]
 netdevice_event+0x836/0x970 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain kernel/notifier.c:83 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:410
 __dev_notify_flags+0x306/0x5d0 net/core/dev.c:2122
 dev_change_flags+0xe3/0x190 net/core/dev.c:8870
 devinet_ioctl+0x908/0x1db0 net/ipv4/devinet.c:1142
 inet_ioctl+0x31e/0x400 net/ipv4/af_inet.c:971
 sock_do_ioctl+0xd6/0x300 net/socket.c:1087
 sock_ioctl+0x444/0x6a0 net/socket.c:1214
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888014fe2e00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 28 bytes inside of
 192-byte region [ffff888014fe2e00, ffff888014fe2ec0)
The buggy address belongs to the page:
page:ffffea000053f880 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888014fe2500 pfn:0x14fe2
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000779440 0000000700000007 ffff888011841a00
raw: ffff888014fe2500 0000000080100008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 9328207879, free_ts 7070662202
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
 __kmalloc+0x2e7/0x390 mm/slub.c:4106
 kmalloc include/linux/slab.h:596 [inline]
 usb_alloc_urb+0x38/0x130 drivers/usb/core/urb.c:74
 usb_internal_control_msg drivers/usb/core/message.c:95 [inline]
 usb_control_msg+0x15f/0x470 drivers/usb/core/message.c:153
 usb_get_descriptor+0xa1/0x3c0 drivers/usb/core/message.c:790
 usb_get_configuration+0x2a8/0x650 drivers/usb/core/config.c:928
 usb_enumerate_device drivers/usb/core/hub.c:2391 [inline]
 usb_new_device+0x144/0x1790 drivers/usb/core/hub.c:2527
 register_root_hub+0x214/0x550 drivers/usb/core/hcd.c:1010
 usb_add_hcd+0xa24/0x1490 drivers/usb/core/hcd.c:2809
 vhci_hcd_probe+0x16b/0x3e0 drivers/usb/usbip/vhci_hcd.c:1360
 platform_probe+0x130/0x1b0 drivers/base/platform.c:1447
 really_probe+0x385/0x1020 drivers/base/dd.c:576
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1355 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3341 [inline]
 free_unref_page+0x7e/0x550 mm/page_alloc.c:3420
 kasan_depopulate_vmalloc_pte+0x66/0x80 mm/kasan/shadow.c:375
 apply_to_pte_range mm/memory.c:2435 [inline]
 apply_to_pmd_range mm/memory.c:2479 [inline]
 apply_to_pud_range mm/memory.c:2515 [inline]
 apply_to_p4d_range mm/memory.c:2551 [inline]
 __apply_to_page_range+0x9e4/0xc40 mm/memory.c:2585
 kasan_release_vmalloc+0x96/0xb0 mm/kasan/shadow.c:485
 __purge_vmap_area_lazy+0xcba/0x18d0 mm/vmalloc.c:1652
 try_purge_vmap_area_lazy mm/vmalloc.c:1671 [inline]
 free_vmap_area_noflush+0x9a1/0xa10 mm/vmalloc.c:1713
 free_unmap_vmap_area mm/vmalloc.c:1726 [inline]
 remove_vm_area+0x1ff/0x220 mm/vmalloc.c:2465
 vm_remove_mappings mm/vmalloc.c:2494 [inline]
 __vunmap+0x32e/0xa70 mm/vmalloc.c:2559
 free_work+0x66/0x90 mm/vmalloc.c:80
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888014fe2d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888014fe2d80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff888014fe2e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888014fe2e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888014fe2f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
