Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F8431AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhJRNYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:24:39 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:34491 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRNYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:24:37 -0400
Received: by mail-il1-f197.google.com with SMTP id b4-20020a056e02048400b0025932d71f2fso7957545ils.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 06:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Pbp76wAdmlPNEinvDjKUNycFErp4tXhEE+oW6UED/78=;
        b=4qmbgmrUQuSQzsdVdVky4xnAAgsM7kVI4U7nqM79x7PkLSleD6LGyLEugKjXE820Ig
         yGvGve6XCA8tlOzsnYAzAso6o+9N7K7hVekPAWeT0v897AV12e0N13z1MppALZEw9GfS
         WzYak4/YWBmW8XzAL2Qc2wWoeo6jHQY6OjdFRvJImjYb0RJY38ms9kybVqxcpKqstxTA
         WbfwqEWPhlwwgRwZamf/3Hu4ZQWgpMxzRwWpQpSbmkNRj5Ue56oc0EZBGXpVQQ2G0yik
         bR7q3lunmOkAZD+X6oDIXq+pzw8aCb8ClD4w6aX5oXXSdt6B7ssCP75MQV1Y2u9ifSkp
         fSRA==
X-Gm-Message-State: AOAM532BgsLiX48rX9XgfPz+A3J5cRmkCK1ay4OZMZyl5HqEsfHjL15w
        O0TpbxtNe9GNZG8j1DJH/Y6Lb36Ss2+ooGJOmGRPZxeIziWT
X-Google-Smtp-Source: ABdhPJzsuCxCbhz8eAIzQE2YEQ4KjsXeASOLGAltm1YEYuBBK3qt9N/uLHBxMz9oBcZpJ99irp7aL/ZaR06iGPl+gg1iRFoFmcz4
MIME-Version: 1.0
X-Received: by 2002:a02:1688:: with SMTP id a130mr18181135jaa.40.1634563345979;
 Mon, 18 Oct 2021 06:22:25 -0700 (PDT)
Date:   Mon, 18 Oct 2021 06:22:25 -0700
In-Reply-To: <0000000000008c06dd05cc9003df@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099a92c05cea06f27@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_add_one
From:   syzbot <syzbot+ef17b5b364116518fd65@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    cf52ad5ff16c Merge tag 'driver-core-5.15-rc6' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16db5734b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9479508d7bb83ad9
dashboard link: https://syzkaller.appspot.com/bug?extid=ef17b5b364116518fd65
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11af3768b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16788f94b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef17b5b364116518fd65@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
==================================================================
BUG: KASAN: use-after-free in kernfs_root fs/kernfs/kernfs-internal.h:48 [inline]
BUG: KASAN: use-after-free in kernfs_add_one+0x480/0x4c0 fs/kernfs/dir.c:765
Read of size 8 at addr ffff88807d1cf200 by task kworker/1:0/20

CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 5.15.0-rc5-syzkaller #0
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
 class_dir_create_and_add drivers/base/core.c:2950 [inline]
 get_device_parent+0x3de/0x590 drivers/base/core.c:3005
 device_add+0x2a8/0x1ee0 drivers/base/core.c:3317
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:507 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:583 [inline]
 firmware_fallback_sysfs+0x408/0xe70 drivers/base/firmware_loader/fallback.c:659
 _request_firmware+0xbb5/0x1040 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 20:
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
 class_dir_create_and_add drivers/base/core.c:2950 [inline]
 get_device_parent+0x3de/0x590 drivers/base/core.c:3005
 device_add+0x2a8/0x1ee0 drivers/base/core.c:3317
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:507 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:583 [inline]
 firmware_fallback_sysfs+0x408/0xe70 drivers/base/firmware_loader/fallback.c:659
 _request_firmware+0xbb5/0x1040 drivers/base/firmware_loader/main.c:833
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1079
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Freed by task 1053:
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
 __kernfs_remove+0x727/0xab0 fs/kernfs/dir.c:1372
 kernfs_remove+0x1d/0x30 fs/kernfs/dir.c:1385
 sysfs_remove_dir+0xc1/0x100 fs/sysfs/dir.c:102
 __kobject_del+0xe2/0x200 lib/kobject.c:620
 kobject_del lib/kobject.c:643 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:635
 device_del+0x834/0xd60 drivers/base/core.c:3595
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

The buggy address belongs to the object at ffff88807d1cf1d0
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 48 bytes inside of
 168-byte region [ffff88807d1cf1d0, ffff88807d1cf278)
The buggy address belongs to the page:
page:ffffea0001f473c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d1cf
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000122 ffff888010dc5a00
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1053, ts 267312666352, free_ts 267295630227
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
 device_add+0xac4/0x1ee0 drivers/base/core.c:3353
 usb_create_ep_devs+0x15c/0x2a0 drivers/usb/core/endpoint.c:169
 usb_new_device.cold+0xc7c/0x108e drivers/usb/core/hub.c:2591
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1338 [inline]
 free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1389
 free_unref_page_prepare mm/page_alloc.c:3315 [inline]
 free_unref_page_list+0x1a9/0xfa0 mm/page_alloc.c:3431
 release_pages+0x830/0x20b0 mm/swap.c:963
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu mm/mmu_gather.c:249 [inline]
 tlb_finish_mmu+0x165/0x8c0 mm/mmu_gather.c:340
 exit_mmap+0x1ea/0x630 mm/mmap.c:3173
 __mmput+0x122/0x4b0 kernel/fork.c:1115
 mmput+0x58/0x60 kernel/fork.c:1136
 free_bprm+0x65/0x2e0 fs/exec.c:1483
 kernel_execve+0x380/0x460 fs/exec.c:1980
 call_usermodehelper_exec_async+0x2e3/0x580 kernel/umh.c:112
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88807d1cf100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807d1cf180: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
>ffff88807d1cf200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
                   ^
 ffff88807d1cf280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807d1cf300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

