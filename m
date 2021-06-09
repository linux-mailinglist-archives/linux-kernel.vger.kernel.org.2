Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4803A0BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 07:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhFIFZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 01:25:18 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:48729 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhFIFZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 01:25:17 -0400
Received: by mail-il1-f197.google.com with SMTP id o6-20020a056e0214c6b02901e2d3bfd590so17174125ilk.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 22:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7MV9DRegZs9jKCYPVOE+0qW44siF1lHbYWbAK9CIcjg=;
        b=c/Nh1PQIbAopSCvSddvIb+hbzlis6VP0r1zTy2nKRrQS1iHw23XCNYwZXm+Fod8Clm
         fyaF18RGPcox9zepKgnD1pfIpLB5Q0g95JcZi/L+xc3go90znf0YqhQjU15RJmPwi/HP
         NOsYhMi+kJEkzTvuPJEpLce8N+DsHmK+FaGdojIxz0lBM6zQLqSl/DRibVjubsmvnjeR
         ygPekq4kwhsrIuhf08Gu1ogh7imB7WfoSdko2V9lJs6X80NcIgwmz4eg7M6jD+zZWh0M
         i5wyFU2cCzjNUeTYqLboPIb4XjYA0qlrTz8OPP2xCS+ge8q88g9S2QYnTnMlf45BsLGn
         OhIQ==
X-Gm-Message-State: AOAM5308C8Y3+JAd79M+zrR6goa7WT0ZhFBJinv7slXPdYgqYHsYv4F7
        TrgyT+VXBbRNceTcP08n0/Q+6TwTHmIwFYqWhshjumBVuBHy
X-Google-Smtp-Source: ABdhPJxWDUVeJFMxLkRE/xyBk/xtEGUPfTZIyDPbbGhpka+jq6YNXwPh1CFYxurZFcn3B//BJTQNyd/p0A4CeujqrwOAj1XPeH6s
MIME-Version: 1.0
X-Received: by 2002:a92:dc42:: with SMTP id x2mr16811288ilq.58.1623216203775;
 Tue, 08 Jun 2021 22:23:23 -0700 (PDT)
Date:   Tue, 08 Jun 2021 22:23:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003842c805c44e7951@google.com>
Subject: [syzbot] KASAN: use-after-free Read in blk_mq_exit_sched
From:   syzbot <syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a1f92694 Add linux-next specific files for 20210518
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=123aeeafd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
dashboard link: https://syzkaller.appspot.com/bug?extid=77ba3d171a25c56756ea

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77ba3d171a25c56756ea@syzkaller.appspotmail.com

sd 1:0:0:7: [sdi] Test Unit Ready failed: Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
==================================================================
BUG: KASAN: use-after-free in blk_mq_exit_sched+0x53e/0x6a0 block/blk-mq-sched.c:685
Read of size 4 at addr ffff88801d4d81e0 by task systemd-udevd/13794

CPU: 0 PID: 13794 Comm: systemd-udevd Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x13e/0x1d6 lib/dump_stack.c:129
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 blk_mq_exit_sched+0x53e/0x6a0 block/blk-mq-sched.c:685
 __elevator_exit+0x28/0x40 block/elevator.c:194
 blk_exit_queue block/blk-sysfs.c:760 [inline]
 blk_release_queue+0x25e/0x4d0 block/blk-sysfs.c:821
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 disk_release+0x1cd/0x250 block/genhd.c:1138
 device_release+0x9f/0x240 drivers/base/core.c:2186
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3428
 put_disk+0x44/0x60 block/genhd.c:1340
 blkdev_put_no_open fs/block_dev.c:1400 [inline]
 blkdev_put+0x12c/0x580 fs/block_dev.c:1639
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1646
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x26f/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x3e/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa8e1223270
Code: 73 01 c3 48 8b 0d 38 7d 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 59 c1 20 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ee fb ff ff 48 89 04 24
RSP: 002b:00007ffcb788b128 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 00007fa8e1223270
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000007
RBP: 00007fa8e20dd710 R08: 0000556cdaf47210 R09: 0000556cdaf46f00
R10: 00007fa8e20dd8c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000556cdaf4c6a0 R14: 0000000000000003 R15: 000000000000000e

Allocated by task 33:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:431 [inline]
 ____kasan_kmalloc mm/kasan/common.c:510 [inline]
 ____kasan_kmalloc mm/kasan/common.c:469 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:519
 kmalloc include/linux/slab.h:595 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 scsi_host_alloc+0x2c/0xfc0 drivers/scsi/hosts.c:376
 usb_stor_probe1+0x45/0x162b drivers/usb/storage/usb.c:952
 storage_probe+0x6f5/0xaa0 drivers/usb/storage/usb.c:1134
 usb_probe_interface+0x315/0x7f0 drivers/usb/core/driver.c:396
 really_probe+0x291/0xf60 drivers/base/dd.c:576
 driver_probe_device+0x298/0x410 drivers/base/dd.c:763
 __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:938
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbe0/0x2100 drivers/base/core.c:3320
 usb_set_configuration+0x113f/0x1910 drivers/usb/core/message.c:2164
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd9/0x2c0 drivers/usb/core/driver.c:293
 really_probe+0x291/0xf60 drivers/base/dd.c:576
 driver_probe_device+0x298/0x410 drivers/base/dd.c:763
 __device_attach_driver+0x203/0x2c0 drivers/base/dd.c:870
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:938
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbe0/0x2100 drivers/base/core.c:3320
 usb_new_device.cold+0x721/0x1058 drivers/usb/core/hub.c:2556
 hub_port_connect drivers/usb/core/hub.c:5276 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5416 [inline]
 port_event drivers/usb/core/hub.c:5562 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5644
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 process_scheduled_works kernel/workqueue.c:2337 [inline]
 worker_thread+0x82b/0x1120 kernel/workqueue.c:2423
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Freed by task 13794:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:363 [inline]
 ____kasan_slab_free mm/kasan/common.c:328 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:371
 kasan_slab_free include/linux/kasan.h:212 [inline]
 slab_free_hook mm/slub.c:1623 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1648
 slab_free mm/slub.c:3208 [inline]
 kfree+0xeb/0x650 mm/slub.c:4274
 device_release+0x9f/0x240 drivers/base/core.c:2186
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3428
 device_release+0x9f/0x240 drivers/base/core.c:2186
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3428
 scsi_device_dev_release_usercontext+0x927/0xd50 drivers/scsi/scsi_sysfs.c:503
 execute_in_process_context+0x37/0x150 kernel/workqueue.c:3327
 device_release+0x9f/0x240 drivers/base/core.c:2186
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3428
 scsi_disk_put drivers/scsi/sd.c:692 [inline]
 sd_release+0x124/0x290 drivers/scsi/sd.c:1493
 __blkdev_put+0x5d4/0x790 fs/block_dev.c:1585
 blkdev_put+0x92/0x580 fs/block_dev.c:1638
 blkdev_close+0x8c/0xb0 fs/block_dev.c:1646
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x26f/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x3e/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 insert_work+0x48/0x370 kernel/workqueue.c:1331
 __queue_work+0x5c1/0xed0 kernel/workqueue.c:1497
 call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1417
 expire_timers kernel/time/timer.c:1457 [inline]
 __run_timers.part.0+0x4a6/0xa50 kernel/time/timer.c:1731
 __run_timers kernel/time/timer.c:1712 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1744
 __do_softirq+0x29b/0x9fb kernel/softirq.c:559

The buggy address belongs to the object at ffff88801d4d8000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 480 bytes inside of
 8192-byte region [ffff88801d4d8000, ffff88801d4da000)
The buggy address belongs to the page:
page:ffffea0000753600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d4d8
head:ffffea0000753600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 0000000100000001 ffff888011042280
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 8500, ts 203379539844, free_ts 203367663569
 prep_new_page mm/page_alloc.c:2377 [inline]
 get_page_from_freelist+0x125c/0x2ed0 mm/page_alloc.c:4038
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5239
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1686 [inline]
 allocate_slab+0x2c2/0x4c0 mm/slub.c:1826
 new_slab mm/slub.c:1889 [inline]
 new_slab_objects mm/slub.c:2635 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2798
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2838
 slab_alloc_node mm/slub.c:2920 [inline]
 __kmalloc_node_track_caller+0x2e3/0x360 mm/slub.c:4653
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0xde/0x340 net/core/skbuff.c:425
 alloc_skb include/linux/skbuff.h:1107 [inline]
 netlink_dump+0x2c9/0xb70 net/netlink/af_netlink.c:2250
 __netlink_dump_start+0x642/0x900 net/netlink/af_netlink.c:2381
 genl_family_rcv_msg_dumpit+0x2af/0x310 net/netlink/genetlink.c:686
 genl_family_rcv_msg net/netlink/genetlink.c:780 [inline]
 genl_rcv_msg+0x434/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x84c/0xd90 net/netlink/af_netlink.c:1927
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1305 [inline]
 __free_pages_ok+0x4cb/0xf30 mm/page_alloc.c:1586
 unfreeze_partials+0x17c/0x1d0 mm/slub.c:2416
 put_cpu_partial+0x13d/0x230 mm/slub.c:2452
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x8e/0xa0 mm/kasan/common.c:441
 kasan_slab_alloc include/linux/kasan.h:236 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2954 [inline]
 slab_alloc mm/slub.c:2962 [inline]
 kmem_cache_alloc_trace+0x26d/0x3c0 mm/slub.c:2979
 kmalloc include/linux/slab.h:590 [inline]
 syslog_print+0xb2/0x430 kernel/printk/printk.c:1492
 do_syslog.part.0+0x367/0x830 kernel/printk/printk.c:1662
 do_syslog+0x49/0x60 kernel/printk/printk.c:1642
 kmsg_read+0x90/0xb0 fs/proc/kmsg.c:40
 pde_read fs/proc/inode.c:311 [inline]
 proc_reg_read+0x119/0x300 fs/proc/inode.c:321
 vfs_read+0x1b5/0x570 fs/read_write.c:494
 ksys_read+0x12d/0x250 fs/read_write.c:634
 do_syscall_64+0x31/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88801d4d8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801d4d8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801d4d8180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88801d4d8200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801d4d8280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
