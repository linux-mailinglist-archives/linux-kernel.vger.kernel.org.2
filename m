Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675723CD5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 15:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhGSNBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 09:01:49 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:50828 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbhGSNBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 09:01:47 -0400
Received: by mail-io1-f71.google.com with SMTP id t10-20020a6b5f0a0000b029052c7ba9d3c3so8850097iob.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 06:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LmzuAbr1S4QYzHKh1chjZLU0DJX1LhIL/fhQuZ9XnbY=;
        b=cl1IjJ5FSCRGP0hhNuGW6401mfssR5wiGMuz7fgWsL417tgWrcyAsjmiy/0ZAK8QYQ
         ems64zQAEKigkXAfZVqUGY/h+8JSnQ16sJwjK71tb+aqhhGS+fhNJe7nLVRSHVdVuLo2
         mULco/B7219PnDs+lcz1wdYIXdWL9ZAMkgQhcBj736IL4ZW55bsGHaDZTULpKJAauyY2
         MQenYioMkUFwtiF5B5fljcjr36b1hX35kIDmdnY1sa5QexFsaOzrOyiuMPs5/PsGK5Fg
         rXtU27nQ4bVf0cxvRvzHQHCCQ4GdP2NeUSaJMmmuYXbWjvrDrYvY0LWYKlOzER/b8ooq
         JMcg==
X-Gm-Message-State: AOAM530QMi9dCHtWpvDXrKfS5FnNegPtsdruhILlYdyNYRjkDi3CgGI2
        A/V1n3a2sZouhKzpfbkxOyUA8iX0cxg1bqsrhMFB924Ed0BU
X-Google-Smtp-Source: ABdhPJzi9GPMoqAQaea0pqj3j0E7fe+X2tw45B+UNXaAtqbrwhm4YsQX62hArhkS9ZtkKpnej2ZhhAGqeuWu0UgafBBqY0DZ6/E/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3796:: with SMTP id w22mr5599143jal.34.1626702145287;
 Mon, 19 Jul 2021 06:42:25 -0700 (PDT)
Date:   Mon, 19 Jul 2021 06:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008678f205c77a1b93@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in do_wait_for_common
From:   syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com>
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

HEAD commit:    8096acd7442e Merge tag 'net-5.14-rc2' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167ca94a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5294764a378649cb
dashboard link: https://syzkaller.appspot.com/bug?extid=cc699626e48a6ebaf295
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d68024300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e4f180300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
BUG: KASAN: slab-out-of-bounds in do_raw_spin_lock+0x4f5/0x8e0 kernel/locking/spinlock_debug.c:112
Read of size 4 at addr ffff88802b46ce14 by task kworker/0:6/8471

CPU: 0 PID: 8471 Comm: kworker/0:6 Tainted: G        W         5.14.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_address_description+0x66/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x163/0x210 mm/kasan/report.c:436
 debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
 do_raw_spin_lock+0x4f5/0x8e0 kernel/locking/spinlock_debug.c:112
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:129 [inline]
 _raw_spin_lock_irq+0xba/0xf0 kernel/locking/spinlock.c:167
 do_wait_for_common+0x2e5/0x480 kernel/sched/completion.c:86
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:138
 r871xu_dev_remove+0x83/0x460 drivers/staging/rtl8712/usb_intf.c:599
 usb_unbind_interface+0x1f2/0x860 drivers/usb/core/driver.c:458
 __device_release_driver drivers/base/dd.c:1201 [inline]
 device_release_driver_internal+0x51e/0x7b0 drivers/base/dd.c:1232
 bus_remove_device+0x2fd/0x410 drivers/base/bus.c:529
 device_del+0x6e1/0xc10 drivers/base/core.c:3540
 usb_disable_device+0x407/0x800 drivers/usb/core/message.c:1419
 usb_disconnect+0x33a/0x8a0 drivers/usb/core/hub.c:2221
 hub_port_connect+0x297/0x27a0 drivers/usb/core/hub.c:5151
 hub_port_connect_change+0x5d0/0xbf0 drivers/usb/core/hub.c:5440
 port_event+0xaee/0x1140 drivers/usb/core/hub.c:5586
 hub_event+0x48d/0xd80 drivers/usb/core/hub.c:5668
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 10:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 __kasan_slab_alloc+0x96/0xd0 mm/kasan/common.c:467
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slab.h:512 [inline]
 slab_alloc_node mm/slub.c:2981 [inline]
 kmem_cache_alloc_node+0x200/0x370 mm/slub.c:3017
 alloc_task_struct_node kernel/fork.c:171 [inline]
 dup_task_struct+0x52/0x980 kernel/fork.c:871
 copy_process+0x615/0x5b00 kernel/fork.c:1952
 kernel_clone+0x21a/0x7d0 kernel/fork.c:2509
 kernel_thread+0x146/0x1c0 kernel/fork.c:2561
 call_usermodehelper_exec_work+0x57/0x220 kernel/umh.c:174
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Last potentially related work creation:
 kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
 kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3029 [inline]
 call_rcu+0x1a0/0xa20 kernel/rcu/tree.c:3109
 schedule_tail+0xc/0xb0 kernel/sched/core.c:4619
 ret_from_fork+0x8/0x30 arch/x86/entry/entry_64.S:280

The buggy address belongs to the object at ffff88802b46b880
 which belongs to the cache task_struct of size 6976
The buggy address is located 5524 bytes inside of
 6976-byte region [ffff88802b46b880, ffff88802b46d3c0)
The buggy address belongs to the page:
page:ffffea0000ad1a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b468
head:ffffea0000ad1a00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888140006280
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 10, ts 43802781641, free_ts 43793596145
 prep_new_page mm/page_alloc.c:2433 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4166
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5374
 alloc_slab_page mm/slub.c:1713 [inline]
 allocate_slab+0xf1/0x540 mm/slub.c:1853
 new_slab mm/slub.c:1916 [inline]
 new_slab_objects mm/slub.c:2662 [inline]
 ___slab_alloc+0x1cf/0x350 mm/slub.c:2825
 __slab_alloc mm/slub.c:2865 [inline]
 slab_alloc_node mm/slub.c:2947 [inline]
 kmem_cache_alloc_node+0x2ca/0x370 mm/slub.c:3017
 alloc_task_struct_node kernel/fork.c:171 [inline]
 dup_task_struct+0x52/0x980 kernel/fork.c:871
 copy_process+0x615/0x5b00 kernel/fork.c:1952
 kernel_clone+0x21a/0x7d0 kernel/fork.c:2509
 kernel_thread+0x146/0x1c0 kernel/fork.c:2561
 call_usermodehelper_exec_work+0x57/0x220 kernel/umh.c:174
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1343 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1394
 free_unref_page_prepare mm/page_alloc.c:3329 [inline]
 free_unref_page+0x7e/0x550 mm/page_alloc.c:3408
 kfree+0x287/0x2d0 mm/slub.c:4292
 request_firmware_work_func+0x175/0x250 drivers/base/firmware_loader/main.c:1081
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Memory state around the buggy address:
 ffff88802b46cd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802b46cd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802b46ce00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                         ^
 ffff88802b46ce80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802b46cf00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
