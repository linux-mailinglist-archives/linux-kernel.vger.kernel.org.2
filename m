Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8493C6F92
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbhGMLVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:21:16 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:56096 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhGMLVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:21:03 -0400
Received: by mail-io1-f72.google.com with SMTP id i13-20020a5d88cd0000b02904e5ab8bdc6cso14105800iol.22
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 04:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=d0VXKmH7GtiFChh3wG0gJbpxoNP+Hj7GfncK49Y+M/4=;
        b=ZKJ5+8j/7H6ZGI9KFCXifH2SPIoQZiwixHqq19F+XQgnij1zFAvmkFH5pV5vRYxoBx
         7N70NGWdfyOrx1Im/7uAz6K8tzriG4S5drB2jnc7qZuIuwilZLULlxebTrdkB2SFWT8H
         pLVjzamXh2bRl5lssLLKip8iP8eDqq+27CgcWklo9/hCMoUnX4xdExbQuq8cqkIOJEkZ
         vnvwVOoR20p9Du8+HahVcfVdAIAbXLCSsC8bdblVzcoBrYXigQgaADv76hLRx45Us83r
         bIxqAOKDQ0YU5CS/svp3RfIVhMGDdNLKnW0KEDftCt0TSfJq2lWGgNUZR966pOiEja7g
         vmRA==
X-Gm-Message-State: AOAM530Yw7z2VSvVpPSWHqBYNPDY2MwTPg1zcV9Fgfsmpmd2ofb2WCxj
        BzeLYnreUj3GHnmNXLdCl2zcH5YAlUKWNoW1Cjt/Ka7fHN51
X-Google-Smtp-Source: ABdhPJwSwmoL+1H2Ma3tyI4dWfwT3Sngsf0Ze5XZyhc+4ebVpO7r0IoL++Y3os3k+J9Wc57gXR9ubAs38hEbhRUdIFiaI5rZ9aW5
MIME-Version: 1.0
X-Received: by 2002:a92:d990:: with SMTP id r16mr2650651iln.204.1626175092483;
 Tue, 13 Jul 2021 04:18:12 -0700 (PDT)
Date:   Tue, 13 Jul 2021 04:18:12 -0700
In-Reply-To: <20210713121908.181cb183@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baeb3805c6ff644a@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in r871xu_dev_remove
From:   syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        mudongliangabcd@gmail.com, paskripkin@gmail.com,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in r871xu_dev_remove

==================================================================
BUG: KASAN: slab-out-of-bounds in debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
BUG: KASAN: slab-out-of-bounds in do_raw_spin_lock+0x262/0x2b0 kernel/locking/spinlock_debug.c:112
Read of size 4 at addr ffff88802f7ace14 by task kworker/0:0/5

CPU: 0 PID: 5 Comm: kworker/0:0 Tainted: G        W         5.14.0-rc1-next-20210713-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
 do_raw_spin_lock+0x262/0x2b0 kernel/locking/spinlock_debug.c:112
 do_wait_for_common kernel/sched/completion.c:86 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x181/0x280 kernel/sched/completion.c:138
 r871xu_dev_remove+0x80/0x320 drivers/staging/rtl8712/usb_intf.c:599
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458
 __device_release_driver+0x3bd/0x6f0 drivers/base/dd.c:1201
 device_release_driver_internal drivers/base/dd.c:1232 [inline]
 device_release_driver+0x26/0x40 drivers/base/dd.c:1255
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
 device_del+0x502/0xd40 drivers/base/core.c:3544
 usb_disable_device+0x35b/0x7b0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x27a/0x78e drivers/usb/core/hub.c:2221
 hub_port_connect drivers/usb/core/hub.c:5151 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5440 [inline]
 port_event drivers/usb/core/hub.c:5586 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5668
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 10657:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc mm/kasan/common.c:513 [inline]
 ____kasan_kmalloc mm/kasan/common.c:472 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
 kmalloc include/linux/slab.h:596 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x1d5/0x590 security/tomoyo/file.c:723
 security_file_ioctl+0x50/0xb0 security/security.c:1539
 __do_sys_ioctl fs/ioctl.c:1063 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0xb3/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 10657:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
 kasan_slab_free include/linux/kasan.h:229 [inline]
 slab_free_hook mm/slub.c:1650 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1675
 slab_free mm/slub.c:3235 [inline]
 kfree+0xeb/0x650 mm/slub.c:4295
 tomoyo_realpath_from_path+0x191/0x620 security/tomoyo/realpath.c:291
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x1d5/0x590 security/tomoyo/file.c:723
 security_file_ioctl+0x50/0xb0 security/security.c:1539
 __do_sys_ioctl fs/ioctl.c:1063 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0xb3/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88802f7ac000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3604 bytes inside of
 4096-byte region [ffff88802f7ac000, ffff88802f7ad000)
The buggy address belongs to the page:
page:ffffea0000bdea00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2f7a8
head:ffffea0000bdea00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888010842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 59, ts 93061328154, free_ts 93052725619
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4166
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5374
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 alloc_slab_page mm/slub.c:1713 [inline]
 allocate_slab+0x32b/0x4c0 mm/slub.c:1853
 new_slab mm/slub.c:1916 [inline]
 new_slab_objects mm/slub.c:2662 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2825
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2865
 slab_alloc_node mm/slub.c:2947 [inline]
 slab_alloc mm/slub.c:2989 [inline]
 kmem_cache_alloc_trace+0x30f/0x3c0 mm/slub.c:3006
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 kobject_uevent_env+0x240/0x1650 lib/kobject_uevent.c:524
 driver_bound+0x1a8/0x300 drivers/base/dd.c:401
 really_probe+0x3d8/0xcd0 drivers/base/dd.c:643
 __driver_probe_device+0x338/0x4d0 drivers/base/dd.c:747
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:777
 __device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:894
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x228/0x4a0 drivers/base/dd.c:965
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1343 [inline]
 free_pcp_prepare+0x312/0x7d0 mm/page_alloc.c:1394
 free_unref_page_prepare mm/page_alloc.c:3329 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3408
 kvfree+0x42/0x50 mm/util.c:616
 netdev_freemem net/core/dev.c:10780 [inline]
 free_netdev+0x495/0x5b0 net/core/dev.c:10958
 rtl871x_load_fw_cb drivers/staging/rtl8712/hal_init.c:47 [inline]
 rtl871x_load_fw_cb.cold+0x100/0x120 drivers/staging/rtl8712/hal_init.c:32
 request_firmware_work_func+0x12c/0x230 drivers/base/firmware_loader/main.c:1081
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88802f7acd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f7acd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802f7ace00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88802f7ace80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802f7acf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         8f0df15b Add linux-next specific files for 20210713
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12ef886c300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ef73f190e4b0b9a
dashboard link: https://syzkaller.appspot.com/bug?extid=5872a520e0ce0a7c7230
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164561d2300000

