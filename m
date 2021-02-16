Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6029F31CB81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 14:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBPN4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 08:56:01 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:53857 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhBPNz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 08:55:57 -0500
Received: by mail-il1-f199.google.com with SMTP id s12so7851369ilh.20
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 05:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=k4S8eFdQa50p/tNPWyAGeojY7fwTY9KS9wse53t0UEg=;
        b=BVldCkLpZnpvPZodovJe3Y7M/jCEEACBxmXhDwSsW7uL7m2VSKHVv2MyjWv3r9BgKm
         RKcJCkw9Z9dImDge7KJVzgacIwzrHGXume+pLkvmAKiVY26mossa9p2r506+FdvujJXi
         hzekCScKQ/VoMTSHDlHrZ2eV1YWZqlhdf4ZUqmIjn5RQkQE7NR71M1EFehv3QBZ0eZlO
         KSVPRTbUy76vxs9sYP5csyIuKDNxHFnCs+pISGoEaQOV/opOl4EzWoWggemRyNGRGQA5
         o19SvGeYdZBSDck5TyV7a5VSW0TxZCc33EYfOJKIYEAdKSz6bOPNIs1NpMf7Se0yaA1i
         W+LA==
X-Gm-Message-State: AOAM530LsPaet4/MgsX8LP3+X4RoMzQEVP9PIpD3wcode7uT3JlMNqLt
        TuJRZeNebp3jkwTijObsVQ1nzDr8lMffnYbgO7O1qd+Fira4
X-Google-Smtp-Source: ABdhPJwfp2E+kjiYL7muPFvP0R47FdFuDt60+Yo2IeZtbAs4txeKhsonVyaBhUny325dAW+bzKNEjttCItaPvvqM1GaBGW4FyGMK
MIME-Version: 1.0
X-Received: by 2002:a6b:f406:: with SMTP id i6mr17070854iog.121.1613483715421;
 Tue, 16 Feb 2021 05:55:15 -0800 (PST)
Date:   Tue, 16 Feb 2021 05:55:15 -0800
In-Reply-To: <0000000000005b805d05afcf6ab8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b567ca05bb7473c0@google.com>
Subject: Re: KASAN: use-after-free Read in lbmIODone
From:   syzbot <syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d2b614d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e53d04227c52a0df
dashboard link: https://syzkaller.appspot.com/bug?extid=5d2008bd1f1b722ba94e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e7f498d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d2008bd1f1b722ba94e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3db6/0x54f0 kernel/locking/lockdep.c:4702
Read of size 8 at addr ffff88803d834368 by task ksoftirqd/1/18

CPU: 1 PID: 18 Comm: ksoftirqd/1 Not tainted 5.11.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 __lock_acquire+0x3db6/0x54f0 kernel/locking/lockdep.c:4702
 lock_acquire kernel/locking/lockdep.c:5442 [inline]
 lock_acquire+0x1a8/0x720 kernel/locking/lockdep.c:5407
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
 __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:137
 lbmIODone+0x44b/0xf60 fs/jfs/jfs_logmgr.c:2294
 bio_endio+0x3cd/0x790 block/bio.c:1450
 req_bio_endio block/blk-core.c:264 [inline]
 blk_update_request+0x68b/0x1480 block/blk-core.c:1462
 blk_mq_end_request+0x4c/0x510 block/blk-mq.c:564
 lo_complete_rq+0x20d/0x2d0 drivers/block/loop.c:497
 blk_done_softirq+0x294/0x3e0 block/blk-mq.c:588
 __do_softirq+0x29b/0x9f6 kernel/softirq.c:343
 run_ksoftirqd kernel/softirq.c:650 [inline]
 run_ksoftirqd+0x2d/0x50 kernel/softirq.c:642
 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296

Allocated by task 9974:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:401 [inline]
 ____kasan_kmalloc.constprop.0+0x82/0xa0 mm/kasan/common.c:429
 kmalloc include/linux/slab.h:552 [inline]
 lbmLogInit fs/jfs/jfs_logmgr.c:1829 [inline]
 lmLogInit+0x30b/0x1420 fs/jfs/jfs_logmgr.c:1278
 open_inline_log fs/jfs/jfs_logmgr.c:1183 [inline]
 lmLogOpen+0x759/0x1250 fs/jfs/jfs_logmgr.c:1077
 jfs_mount_rw+0x286/0x4c0 fs/jfs/jfs_mount.c:259
 jfs_fill_super+0x860/0xbc0 fs/jfs/super.c:571
 mount_bdev+0x34d/0x410 fs/super.c:1366
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount fs/namespace.c:3409 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3409
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 9974:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:356
 ____kasan_slab_free+0xe1/0x110 mm/kasan/common.c:362
 kasan_slab_free include/linux/kasan.h:192 [inline]
 slab_free_hook mm/slub.c:1547 [inline]
 slab_free_freelist_hook+0x5d/0x150 mm/slub.c:1580
 slab_free mm/slub.c:3143 [inline]
 kfree+0xdb/0x3b0 mm/slub.c:4139
 lbmLogShutdown fs/jfs/jfs_logmgr.c:1872 [inline]
 lmLogInit+0x94a/0x1420 fs/jfs/jfs_logmgr.c:1423
 open_inline_log fs/jfs/jfs_logmgr.c:1183 [inline]
 lmLogOpen+0x759/0x1250 fs/jfs/jfs_logmgr.c:1077
 jfs_mount_rw+0x286/0x4c0 fs/jfs/jfs_mount.c:259
 jfs_fill_super+0x860/0xbc0 fs/jfs/super.c:571
 mount_bdev+0x34d/0x410 fs/super.c:1366
 legacy_get_tree+0x105/0x220 fs/fs_context.c:592
 vfs_get_tree+0x89/0x2f0 fs/super.c:1496
 do_new_mount fs/namespace.c:2881 [inline]
 path_mount+0x13ad/0x20c0 fs/namespace.c:3211
 do_mount fs/namespace.c:3224 [inline]
 __do_sys_mount fs/namespace.c:3432 [inline]
 __se_sys_mount fs/namespace.c:3409 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3409
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xc5/0xf0 mm/kasan/generic.c:344
 insert_work+0x48/0x370 kernel/workqueue.c:1331
 __queue_work+0x5c1/0xf00 kernel/workqueue.c:1497
 queue_work_on+0xc7/0xd0 kernel/workqueue.c:1524
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x1f0/0x4c0 kernel/umh.c:433
 kobject_uevent_env+0xf9f/0x1680 lib/kobject_uevent.c:617
 rx_queue_add_kobject net/core/net-sysfs.c:980 [inline]
 net_rx_queue_update_kobjects+0xee/0x450 net/core/net-sysfs.c:1020
 register_queue_kobjects net/core/net-sysfs.c:1695 [inline]
 netdev_register_kobject+0x275/0x430 net/core/net-sysfs.c:1943
 register_netdevice+0xd6d/0x1770 net/core/dev.c:10058
 nsim_create+0x245/0x2f0 drivers/net/netdevsim/netdev.c:317
 __nsim_dev_port_add+0x270/0x4c0 drivers/net/netdevsim/dev.c:941
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:990 [inline]
 nsim_dev_probe+0xc42/0x1070 drivers/net/netdevsim/dev.c:1119
 really_probe+0x291/0xe60 drivers/base/dd.c:554
 driver_probe_device+0x26b/0x3d0 drivers/base/dd.c:740
 __device_attach_driver+0x1d1/0x290 drivers/base/dd.c:846
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:431
 __device_attach+0x228/0x4a0 drivers/base/dd.c:914
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0xbc4/0x1d90 drivers/base/core.c:3109
 nsim_bus_dev_new drivers/net/netdevsim/bus.c:336 [inline]
 new_device_store+0x374/0x5c0 drivers/net/netdevsim/bus.c:215
 bus_attr_store+0x72/0xa0 drivers/base/bus.c:122
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x791/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88803d834300
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 104 bytes inside of
 192-byte region [ffff88803d834300, ffff88803d8343c0)
The buggy address belongs to the page:
page:00000000650479c7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3d834
flags: 0xfff00000000200(slab)
raw: 00fff00000000200 ffffea0000f4c180 0000000300000003 ffff888010c41500
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88803d834200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88803d834280: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88803d834300: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88803d834380: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88803d834400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

