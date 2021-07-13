Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF20C3C68D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 05:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhGMDRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 23:17:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33285 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhGMDRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 23:17:14 -0400
Received: by mail-io1-f69.google.com with SMTP id i9-20020a0566021349b02904df6556dad4so13409852iov.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 20:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2Kd2j0EgB4c82m8k6zWGd8bDvRKEVLAFtQoMz/5kceI=;
        b=HcHZzUUqdGlPRaz2ap4YESP+1yKquDZ85fhM0YImqxiKiD6M+CJS4/fC8Kr5K9PQ7D
         1K8J3Rj4misALyQM4ECGDua0O7keGK7MUWpYtaVTtKigzk7H0upB3ErQ4EOhRoH1ChW1
         E+ImUKxvThnfJ9D79NuMzmSaZHxgzDNMLrDK6oAQ5bTdNJbmy52L4yOXW/SJb/aEaFXr
         CPeraOqmrn8zbPW/Xi8X8KOUPVKLBO9fKxEJaprr2uqHWk0Q76hLzsWcygsBCIw1JUvx
         Uf9xaE8kO74zInAOMkP4tkwiSosk/qjxwliPxLLZ1TB/xdQBBdQoIL7yS0oA9egUx8Hc
         PQ8Q==
X-Gm-Message-State: AOAM532KZjl7cYMabFoTmyuj7isloZXBzKT3c1rMyzrUAEjm6xCQIXkh
        7UiWLYE4IjI+G7EWdTj9bPmDF+9MXZuSDkN1sUU0oJw4ttbo
X-Google-Smtp-Source: ABdhPJxHxGYfkOxsxjHmkEtgNkNmHi6Zp1gatxcN29F8/pgLPnMNQo2pED1QT6Kn0+DmlQ4iZ4H05n6PuBaPCi++eYmZjoRksQ5W
MIME-Version: 1.0
X-Received: by 2002:a5e:dd42:: with SMTP id u2mr1555731iop.135.1626146064542;
 Mon, 12 Jul 2021 20:14:24 -0700 (PDT)
Date:   Mon, 12 Jul 2021 20:14:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087b4c305c6f8a243@google.com>
Subject: [syzbot] KASAN: use-after-free Read in r871xu_dev_remove
From:   syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        paskripkin@gmail.com, rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92510a7f Add linux-next specific files for 20210709
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16c50180300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505de2716f052686
dashboard link: https://syzkaller.appspot.com/bug?extid=5872a520e0ce0a7c7230
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1639a73c300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fcd5e4300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com

usb 1-1: USB disconnect, device number 14
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3d86/0x54a0 kernel/locking/lockdep.c:4885
Read of size 8 at addr ffff888038bbce28 by task kworker/1:2/4393

CPU: 1 PID: 4393 Comm: kworker/1:2 Not tainted 5.13.0-next-20210709-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
 __lock_acquire+0x3d86/0x54a0 kernel/locking/lockdep.c:4885
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:128 [inline]
 _raw_spin_lock_irq+0x32/0x50 kernel/locking/spinlock.c:167
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

Allocated by task 4860:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x84/0xa0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2981 [inline]
 slab_alloc mm/slub.c:2989 [inline]
 kmem_cache_alloc+0x216/0x3a0 mm/slub.c:2994
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags fs/namei.c:2747 [inline]
 user_path_at_empty+0xa1/0x100 fs/namei.c:2747
 user_path_at include/linux/namei.h:57 [inline]
 vfs_statx+0x142/0x390 fs/stat.c:203
 vfs_fstatat fs/stat.c:225 [inline]
 vfs_lstat include/linux/fs.h:3426 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 4860:
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
 kmem_cache_free+0x8e/0x5a0 mm/slub.c:3251
 putname+0xe1/0x120 fs/namei.c:259
 filename_lookup+0x3df/0x5b0 fs/namei.c:2477
 user_path_at include/linux/namei.h:57 [inline]
 vfs_statx+0x142/0x390 fs/stat.c:203
 vfs_fstatat fs/stat.c:225 [inline]
 vfs_lstat include/linux/fs.h:3426 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888038bbc400
 which belongs to the cache names_cache of size 4096
The buggy address is located 2600 bytes inside of
 4096-byte region [ffff888038bbc400, ffff888038bbd400)
The buggy address belongs to the page:
page:ffffea0000e2ee00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x38bb8
head:ffffea0000e2ee00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff8880109c43c0
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4860, ts 1160993662069, free_ts 1160991389825
 prep_new_page mm/page_alloc.c:2444 [inline]
 get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4177
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5385
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
 alloc_slab_page mm/slub.c:1713 [inline]
 allocate_slab+0x32b/0x4c0 mm/slub.c:1853
 new_slab mm/slub.c:1916 [inline]
 new_slab_objects mm/slub.c:2662 [inline]
 ___slab_alloc+0x4ba/0x820 mm/slub.c:2825
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2865
 slab_alloc_node mm/slub.c:2947 [inline]
 slab_alloc mm/slub.c:2989 [inline]
 kmem_cache_alloc+0x372/0x3a0 mm/slub.c:2994
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
 getname_flags fs/namei.c:2747 [inline]
 user_path_at_empty+0xa1/0x100 fs/namei.c:2747
 user_path_at include/linux/namei.h:57 [inline]
 vfs_statx+0x142/0x390 fs/stat.c:203
 vfs_fstatat fs/stat.c:225 [inline]
 vfs_lstat include/linux/fs.h:3426 [inline]
 __do_sys_newlstat+0x91/0x110 fs/stat.c:380
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1354 [inline]
 free_pcp_prepare+0x312/0x7d0 mm/page_alloc.c:1405
 free_unref_page_prepare mm/page_alloc.c:3340 [inline]
 free_unref_page+0x19/0x690 mm/page_alloc.c:3419
 kvfree+0x42/0x50 mm/util.c:616
 netdev_freemem net/core/dev.c:10778 [inline]
 free_netdev+0x495/0x5b0 net/core/dev.c:10956
 rtl871x_load_fw_cb drivers/staging/rtl8712/hal_init.c:46 [inline]
 rtl871x_load_fw_cb.cold+0xf7/0x117 drivers/staging/rtl8712/hal_init.c:32
 request_firmware_work_func+0x12c/0x230 drivers/base/firmware_loader/main.c:1081
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff888038bbcd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888038bbcd80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888038bbce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888038bbce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888038bbcf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
