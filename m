Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D440437068D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhEAJRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 05:17:09 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53242 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 05:17:06 -0400
Received: by mail-il1-f199.google.com with SMTP id s2-20020a056e0210c2b0290196bac26c2cso626161ilj.19
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 02:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vMCZHcHmoyj7c4CSJbzriqo+5ayghNwxYVlHFmKSQQM=;
        b=WDPf+j9949J8BFv1AbjTWP+SACmQxd1nzSifvwfqsyCWQWAipbhWncdnxLmp994KXE
         Vs5gDEHbDdpj7uI/fs8MfCP4EmALcbUd+qJOeJ2PNoXLBi4BeyEfnxMRsH1y0cNKwm6x
         vNbHg88fDzuCelsWBwNLcfY580flz3ncT2EaSovpO+BGbyXc4KAHiKvVGo0/23TL5Hn8
         lBKaerCl6KhlPhVuRGL3R54yG3x0TegMquG2BiewjLmCzS2UD2Ugd2hogw5Yjdr2qFdU
         tG/DDt7iriCN/1cVktgCc5gGzTD9nnVVLy7zz7ZhuWcl+41u/LhgJIuwXAsFBKpWz/1x
         juIQ==
X-Gm-Message-State: AOAM533hIXLZDPS/CXBSsrzcL2HlxdfXeUnVbPqnY3C5RbW+7FUV7/GF
        Dsz8jHHdbVcFw1jrUt4e/W7q1MbOnvXe3vPdQwJAuMPFOSTN
X-Google-Smtp-Source: ABdhPJyVhyvoMckAWt+iF+NiicJ+aG/upVXUfnmDsU4Ca9EORX1vqWKWmDhT4DO/afPyPBD32f0eeBW6U0LRIr03SquWo+8Pcz7i
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bc3:: with SMTP id x3mr7507150ilv.47.1619860576595;
 Sat, 01 May 2021 02:16:16 -0700 (PDT)
Date:   Sat, 01 May 2021 02:16:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040f5f905c1412e77@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
From:   syzbot <syzbot+e5d7fe84afc81da312df@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4a0225c3 Merge tag 'spi-v5.13' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c0f2b9d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c37352b2923ef305
dashboard link: https://syzkaller.appspot.com/bug?extid=e5d7fe84afc81da312df
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e5d7fe84afc81da312df@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
==================================================================
BUG: KASAN: use-after-free in kernfs_type include/linux/kernfs.h:289 [inline]
BUG: KASAN: use-after-free in kernfs_leftmost_descendant fs/kernfs/dir.c:1203 [inline]
BUG: KASAN: use-after-free in kernfs_next_descendant_post+0x1dd/0x290 fs/kernfs/dir.c:1234
Read of size 2 at addr ffff888025e70098 by task kworker/1:6/9747

CPU: 1 PID: 9747 Comm: kworker/1:6 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:436
 kernfs_type include/linux/kernfs.h:289 [inline]
 kernfs_leftmost_descendant fs/kernfs/dir.c:1203 [inline]
 kernfs_next_descendant_post+0x1dd/0x290 fs/kernfs/dir.c:1234
 kernfs_activate+0x3c/0x1d0 fs/kernfs/dir.c:1269
 kernfs_add_one+0x36a/0x4c0 fs/kernfs/dir.c:807
 kernfs_create_dir_ns+0x18b/0x220 fs/kernfs/dir.c:1035
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x2d2/0xa60 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 class_dir_create_and_add drivers/base/core.c:2871 [inline]
 get_device_parent+0x3de/0x590 drivers/base/core.c:2926
 device_add+0x2b1/0x2100 drivers/base/core.c:3238
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:509 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:581 [inline]
 firmware_fallback_sysfs+0x40b/0xe20 drivers/base/firmware_loader/fallback.c:657
 _request_firmware+0xa80/0xe80 drivers/base/firmware_loader/main.c:831
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1077
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 9747:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 __kasan_slab_alloc+0x75/0x90 mm/kasan/common.c:460
 kasan_slab_alloc include/linux/kasan.h:223 [inline]
 slab_post_alloc_hook mm/slab.h:516 [inline]
 slab_alloc_node mm/slub.c:2907 [inline]
 slab_alloc mm/slub.c:2915 [inline]
 kmem_cache_alloc+0x153/0x370 mm/slub.c:2920
 kmem_cache_zalloc include/linux/slab.h:674 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:626
 kernfs_new_node fs/kernfs/dir.c:688 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1025
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x2d2/0xa60 lib/kobject.c:255
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 class_dir_create_and_add drivers/base/core.c:2871 [inline]
 get_device_parent+0x3de/0x590 drivers/base/core.c:2926
 device_add+0x2b1/0x2100 drivers/base/core.c:3238
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:509 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:581 [inline]
 firmware_fallback_sysfs+0x40b/0xe20 drivers/base/firmware_loader/fallback.c:657
 _request_firmware+0xa80/0xe80 drivers/base/firmware_loader/main.c:831
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1077
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 9733:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 ____kasan_slab_free mm/kasan/common.c:325 [inline]
 __kasan_slab_free+0xf5/0x130 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x92/0x210 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kmem_cache_free+0x8a/0x730 mm/slub.c:3177
 kernfs_put.part.0+0x2c4/0x540 fs/kernfs/dir.c:537
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:511
 __kernfs_remove+0x703/0xa90 fs/kernfs/dir.c:1345
 kernfs_remove+0x1f/0x30 fs/kernfs/dir.c:1358
 sysfs_remove_dir+0xc1/0x100 fs/sysfs/dir.c:102
 __kobject_del+0xe2/0x200 lib/kobject.c:620
 kobject_del lib/kobject.c:643 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:635
 device_del+0x816/0xd40 drivers/base/core.c:3519
 usb_disconnect.cold+0x4bd/0x791 drivers/usb/core/hub.c:2245
 hub_port_connect drivers/usb/core/hub.c:5127 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5416 [inline]
 port_event drivers/usb/core/hub.c:5562 [inline]
 hub_event+0x1c9c/0x4320 drivers/usb/core/hub.c:5644
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 process_scheduled_works kernel/workqueue.c:2337 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2423
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff888025e70000
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 152 bytes inside of
 168-byte region [ffff888025e70000, ffff888025e700a8)
The buggy address belongs to the page:
page:ffffea0000979c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25e70
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea0000a78000 0000000500000005 ffff8880111bd780
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888025e6ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888025e70000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888025e70080: fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb
                            ^
 ffff888025e70100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888025e70180: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
