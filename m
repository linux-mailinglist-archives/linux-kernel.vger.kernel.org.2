Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E6414235
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhIVG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:58:07 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:51035 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhIVG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:58:00 -0400
Received: by mail-il1-f199.google.com with SMTP id y16-20020a929510000000b0024fca7e125bso1637259ilh.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Pdy3QmovX9Gon5gbC/jG/EJ4Eq2alTzV+gbL4RGy3hY=;
        b=HujGmdB2Egz1uSW+oLAJ5hREK6MuaudDmN/ZK/WT+dSucYjCcQvF+q+saqaRHmYN7+
         VSkyN5vsOz1Z9XAWW8Qp08mE5RQ9VFJuOgRf1rOAcYESpIFx5eFSlL8+nCCl6i7deJ3m
         3j6dsD78HqibuvNSZ/UnwqQhzvx/cJta5ot39YEIYVz8Gt+YoX653yuh9Akvl6MoeFdX
         ZpSDfkuehK15CQfNrYlKpBNx2U93zMvZvH4Np37UcRBlzQFayW6Qa7c6L8FdFy/kwKeq
         b8M5JF+UcQ/puguiK/Gy3i+fPc2Vr8GyNlzTiBKiG3eaSbHDR4qpXEbBBqBci6Dgp7D2
         Nt7Q==
X-Gm-Message-State: AOAM531pA+FwFvMhY3wQQMRquJT6QoI/sR9lwhlIVfantgooHjwoRDmI
        tDAWWrJUylRnjA3qRuR3xobZ6W2/qd16fhT5VVZyXDNAVrS6
X-Google-Smtp-Source: ABdhPJxyYKBJTjDXM39NOLdk8I4TMkXW28svYQvAngZTQBhw9hpaF0w5GlrxwLi98akvwtd8pNpXSPq7dV8YoaqaikVxwzw1HxwI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:: with SMTP id 2mr22739850ilq.97.1632293790416;
 Tue, 21 Sep 2021 23:56:30 -0700 (PDT)
Date:   Tue, 21 Sep 2021 23:56:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c06dd05cc9003df@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_add_one
From:   syzbot <syzbot+ef17b5b364116518fd65@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ddf21bd8ab98 Merge tag 'iov_iter.3-5.15-2021-09-17' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165c1751300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=ef17b5b364116518fd65
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef17b5b364116518fd65@syzkaller.appspotmail.com

usb 4-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 4-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
==================================================================
BUG: KASAN: use-after-free in kernfs_root fs/kernfs/kernfs-internal.h:48 [inline]
BUG: KASAN: use-after-free in kernfs_add_one+0x480/0x4c0 fs/kernfs/dir.c:765
Read of size 8 at addr ffff88801b2ada28 by task kworker/1:4/7907

CPU: 1 PID: 7907 Comm: kworker/1:4 Not tainted 5.15.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 kernfs_root fs/kernfs/kernfs-internal.h:48 [inline]
 kernfs_add_one+0x480/0x4c0 fs/kernfs/dir.c:765
 kernfs_create_dir_ns+0x18b/0x220 fs/kernfs/dir.c:994
 sysfs_create_dir_ns+0x128/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x2d2/0xa60 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 device_add+0x36a/0x21b0 drivers/base/core.c:3294
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:507 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:583 [inline]
 firmware_fallback_sysfs+0x408/0xe70 drivers/base/firmware_loader/fallback.c:659
 _request_firmware+0xbb5/0x1040 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 7907:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x83/0xb0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3206 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x209/0x390 mm/slub.c:3219
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:585
 kernfs_new_node fs/kernfs/dir.c:647 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:984
 sysfs_create_dir_ns+0x128/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x2d2/0xa60 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 device_add+0x36a/0x21b0 drivers/base/core.c:3294
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:507 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:583 [inline]
 firmware_fallback_sysfs+0x408/0xe70 drivers/base/firmware_loader/fallback.c:659
 _request_firmware+0xbb5/0x1040 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 69:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xff/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1700 [inline]
 slab_free_freelist_hook+0x81/0x190 mm/slub.c:1725
 slab_free mm/slub.c:3483 [inline]
 kmem_cache_free+0x8a/0x5b0 mm/slub.c:3499
 kernfs_put.part.0+0x2c4/0x540 fs/kernfs/dir.c:539
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:513
 __kernfs_remove+0x727/0xab0 fs/kernfs/dir.c:1360
 kernfs_remove+0x1d/0x30 fs/kernfs/dir.c:1373
 sysfs_remove_dir+0xc1/0x100 fs/sysfs/dir.c:102
 __kobject_del+0xe2/0x200 lib/kobject.c:620
 kobject_del lib/kobject.c:643 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:635
 device_del+0x834/0xd60 drivers/base/core.c:3558
 usb_disconnect.cold+0x4ba/0x78e drivers/usb/core/hub.c:2251
 hub_port_connect drivers/usb/core/hub.c:5199 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5488 [inline]
 port_event drivers/usb/core/hub.c:5634 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5716
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 process_scheduled_works kernel/workqueue.c:2360 [inline]
 worker_thread+0x85c/0x11f0 kernel/workqueue.c:2446
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

The buggy address belongs to the object at ffff88801b2ad9f8
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 48 bytes inside of
 168-byte region [ffff88801b2ad9f8, ffff88801b2adaa0)
The buggy address belongs to the page:
page:ffffea00006cab40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1b2ad
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001cdb480 0000001100000008 ffff888010dc5a00
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 7198, ts 181519968528, free_ts 181515461864
 prep_new_page mm/page_alloc.c:2424 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4153
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5375
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2197
 alloc_slab_page mm/slub.c:1763 [inline]
 allocate_slab mm/slub.c:1900 [inline]
 new_slab+0x319/0x490 mm/slub.c:1963
 ___slab_alloc+0x921/0xfe0 mm/slub.c:2994
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3081
 slab_alloc_node mm/slub.c:3172 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x365/0x390 mm/slub.c:3219
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:585
 kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:647
 __kernfs_create_file+0x51/0x350 fs/kernfs/file.c:985
 sysfs_add_file_mode_ns+0x226/0x540 fs/sysfs/file.c:317
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x328/0xb20 fs/sysfs/group.c:149
 netdev_queue_add_kobject net/core/net-sysfs.c:1616 [inline]
 netdev_queue_update_kobjects+0x353/0x460 net/core/net-sysfs.c:1655
 register_queue_kobjects net/core/net-sysfs.c:1716 [inline]
 netdev_register_kobject+0x35a/0x430 net/core/net-sysfs.c:1959
 register_netdevice+0xd33/0x1500 net/core/dev.c:10295
 veth_newlink+0x58c/0xb20 drivers/net/veth.c:1726
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 __unfreeze_partials+0x340/0x360 mm/slub.c:2495
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x95/0xb0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:3206 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x209/0x390 mm/slub.c:3219
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:585
 kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:647
 __kernfs_create_file+0x51/0x350 fs/kernfs/file.c:985
 sysfs_add_file_mode_ns+0x226/0x540 fs/sysfs/file.c:317
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x328/0xb20 fs/sysfs/group.c:149
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:185 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:215
 device_add_groups drivers/base/core.c:2438 [inline]
 device_add_attrs drivers/base/core.c:2597 [inline]
 device_add+0x14ee/0x21b0 drivers/base/core.c:3310
 netdev_register_kobject+0x181/0x430 net/core/net-sysfs.c:1955

Memory state around the buggy address:
 ffff88801b2ad900: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801b2ad980: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
>ffff88801b2ada00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88801b2ada80: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
 ffff88801b2adb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
