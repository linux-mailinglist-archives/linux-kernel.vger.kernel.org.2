Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD4B420BE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhJDNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:00:48 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45625 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhJDM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:59:12 -0400
Received: by mail-io1-f69.google.com with SMTP id a18-20020a6b6612000000b005d8f6622bafso16055901ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=I49KRy3M5oIsPUIzBa5mEXw7WpUGeWhaia4U7xDXi0A=;
        b=pD8Np+GPlPvRDlY8fs7mDtYLyZp7EFZtS+zswxEeVJ79SKq5B7X0Y3X6T1gt2FQndJ
         5tpw5ZeDGikO67WlG4UNDtFw+2WzQg0704FJB7er7O+PzOOSWDkDbXwY99gIT9wGUcVi
         9HEo+gtMEa07qglBcubxHm23EswbqLhZESiPZxP7uJF7VJyljUfeb14MBTr1DkYLZJgC
         3GU0VfAqqD9urRMRMKMN6O/Hgc+uTKEzZkmtihSOdQnr+3lNSQATwOFc2xZz3ROJROeS
         iXvfYcuxmNCmf36MAfMeVlGyxdSa42xH4fGi5QDXnzv8CJYV3US3gtG52h6OmUTPKXxK
         jnww==
X-Gm-Message-State: AOAM532LiItoMPw7HVShT7cf/BpwKmKpRCU/OSjp0rvUTTf6RdmeBD3k
        Pwvx9oy6KvVtOkRMxEk8M84E3C7P3Oe13j7iDdUa5Y7r210k
X-Google-Smtp-Source: ABdhPJwWXP3Nb82JquBTGh/AD+X2jklPKysU7EyUm3VYELYYVc+gsDL7zJos0WI3EjpqV9cxtmpbCA7KMkeDN5VGoabqGdZvIWuS
MIME-Version: 1.0
X-Received: by 2002:a02:9542:: with SMTP id y60mr5877009jah.133.1633352242860;
 Mon, 04 Oct 2021 05:57:22 -0700 (PDT)
Date:   Mon, 04 Oct 2021 05:57:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a95ce05cd867417@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post (2)
From:   syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    02d5e016800d Merge tag 'sound-5.15-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130eeb90b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/adi930.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/adi930.fw
==================================================================
BUG: KASAN: use-after-free in kernfs_type include/linux/kernfs.h:294 [inline]
BUG: KASAN: use-after-free in kernfs_leftmost_descendant fs/kernfs/dir.c:1218 [inline]
BUG: KASAN: use-after-free in kernfs_next_descendant_post+0x1da/0x290 fs/kernfs/dir.c:1249
Read of size 2 at addr ffff888064de27d8 by task kworker/0:1/7

CPU: 0 PID: 7 Comm: kworker/0:1 Not tainted 5.15.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:256
 __kasan_report mm/kasan/report.c:442 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:459
 kernfs_type include/linux/kernfs.h:294 [inline]
 kernfs_leftmost_descendant fs/kernfs/dir.c:1218 [inline]
 kernfs_next_descendant_post+0x1da/0x290 fs/kernfs/dir.c:1249
 kernfs_activate+0x3a/0x1d0 fs/kernfs/dir.c:1284
 kernfs_add_one+0x368/0x4c0 fs/kernfs/dir.c:766
 kernfs_create_dir_ns+0x18b/0x220 fs/kernfs/dir.c:994
 sysfs_create_dir_ns+0x128/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x2d2/0xa60 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 class_dir_create_and_add drivers/base/core.c:2913 [inline]
 get_device_parent+0x3de/0x590 drivers/base/core.c:2968
 device_add+0x2b1/0x21b0 drivers/base/core.c:3280
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:507 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:583 [inline]
 firmware_fallback_sysfs+0x408/0xe70 drivers/base/firmware_loader/fallback.c:659
 _request_firmware+0xbb5/0x1040 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 7:
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
 class_dir_create_and_add drivers/base/core.c:2913 [inline]
 get_device_parent+0x3de/0x590 drivers/base/core.c:2968
 device_add+0x2b1/0x21b0 drivers/base/core.c:3280
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:507 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:583 [inline]
 firmware_fallback_sysfs+0x408/0xe70 drivers/base/firmware_loader/fallback.c:659
 _request_firmware+0xbb5/0x1040 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 20913:
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

The buggy address belongs to the object at ffff888064de2740
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 152 bytes inside of
 168-byte region [ffff888064de2740, ffff888064de27e8)
The buggy address belongs to the page:
page:ffffea0001937880 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x64de2
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 dead000000000100 dead000000000122 ffff888010dc5a00
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 6583, ts 177318160712, free_ts 177312628642
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
 sysfs_merge_group+0x198/0x320 fs/sysfs/group.c:343
 dpm_sysfs_add+0x241/0x290 drivers/base/power/sysfs.c:707
 device_add+0xad8/0x21b0 drivers/base/core.c:3316
 netdev_register_kobject+0x181/0x430 net/core/net-sysfs.c:1955
 register_netdevice+0xd33/0x1500 net/core/dev.c:10299
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3394
 __vunmap+0x783/0xb70 mm/vmalloc.c:2621
 free_work+0x58/0x70 mm/vmalloc.c:95
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888064de2680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888064de2700: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888064de2780: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
                                                    ^
 ffff888064de2800: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
 ffff888064de2880: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
