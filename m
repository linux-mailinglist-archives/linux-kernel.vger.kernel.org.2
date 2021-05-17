Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A33827FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhEQJQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:16:50 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:48895 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbhEQJNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:13:34 -0400
Received: by mail-il1-f197.google.com with SMTP id h4-20020a926c040000b0290192f4fa4c3bso5784817ilc.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B1taG3xXG5NS6mXpOdWdzWAZ4iBvV+P4w98OBAJS8AE=;
        b=FfYVf2Ev4S1IhSMfwZ8N63l/ksf7uhYPcNaFTHJVk/5/ZOdo+K57htqGtYJEWN30Hg
         KhS8zfO6jP6Ssx3A2LvCKbhZvwAezFujyMLVXmFgfU5ONHN1Nt1GMxF1tibQsM6qKcEp
         vAWhIHCWmrFJ/Zprb+GWkLrNti4+slsvSdF5Zyb8I3Pmam4CEC0V82iCsrFBWPGBzMwS
         sIyWHw6j6/1eWceFR7nCslYH0uZfwom0Pj9JWlR2KRRR1ncYCBaKZnYpt3/8J8n6expB
         ir9DRu0/lYQFYpwnoGpQ1FD4q/s9T5Xdf7sY7lwUcmvuVjdeRyArIz0nB7Art6dDF38L
         KWdg==
X-Gm-Message-State: AOAM533CYsC2dwTUc/Ypi2Ra0UO4N1285mfIEDtbKPhewOA88I0hpKzL
        Bmcqb25ZUA/NIvuwwheD+b2t0oTo7JoQq6Utgpa5fjmihZ76
X-Google-Smtp-Source: ABdhPJxFwuorrEIuaIIAgEg+Kx5t+HxojZze1FkHigbrIz2dSy9iPq8tqmgCavPmue1vxgPf3bZPB8yj1YjVwdp7v8vuLqYKYZ27
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1650:: with SMTP id a16mr55063359jat.23.1621242736687;
 Mon, 17 May 2021 02:12:16 -0700 (PDT)
Date:   Mon, 17 May 2021 02:12:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a3ee005c282fd13@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in usb_destroy_configuration (2)
From:   syzbot <syzbot+47c8cb2d261ba11f0a4c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4676be28 usb: xhci-mtk: use first-fit for LS/FS
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=10977455d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5308902274df0f54
dashboard link: https://syzkaller.appspot.com/bug?extid=47c8cb2d261ba11f0a4c

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47c8cb2d261ba11f0a4c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in usb_destroy_configuration+0x6e2/0x710 drivers/usb/core/config.c:834
Read of size 8 at addr ffff8881095a5fa8 by task kworker/1:3/6895

CPU: 1 PID: 6895 Comm: kworker/1:3 Not tainted 5.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x143/0x1db lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:436
 usb_destroy_configuration+0x6e2/0x710 drivers/usb/core/config.c:834
 usb_release_dev+0x3e/0x100 drivers/usb/core/usb.c:462
 device_release+0x9f/0x240 drivers/base/core.c:2185
 kobject_cleanup lib/kobject.c:705 [inline]
 kobject_release lib/kobject.c:736 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c8/0x540 lib/kobject.c:753
 put_device+0x1b/0x30 drivers/base/core.c:3427
 hub_port_connect drivers/usb/core/hub.c:5127 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5416 [inline]
 port_event drivers/usb/core/hub.c:5562 [inline]
 hub_event+0x1c9c/0x4330 drivers/usb/core/hub.c:5644
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Allocated by task 28157:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:428 [inline]
 ____kasan_kmalloc mm/kasan/common.c:507 [inline]
 __kasan_kmalloc+0x7c/0x90 mm/kasan/common.c:516
 kmalloc include/linux/slab.h:561 [inline]
 kzalloc include/linux/slab.h:686 [inline]
 usb_get_configuration+0x186/0x3d60 drivers/usb/core/config.c:887
 usb_enumerate_device drivers/usb/core/hub.c:2389 [inline]
 usb_new_device+0x42c/0x7a0 drivers/usb/core/hub.c:2525
 hub_port_connect drivers/usb/core/hub.c:5276 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5416 [inline]
 port_event drivers/usb/core/hub.c:5562 [inline]
 hub_event+0x2357/0x4330 drivers/usb/core/hub.c:5644
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the object at ffff8881095a5fa0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 8-byte region [ffff8881095a5fa0, ffff8881095a5fa8)
The buggy address belongs to the page:
page:ffffea0004256940 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1095a5
flags: 0x200000000000200(slab|node=0|zone=2)
raw: 0200000000000200 ffffea00041ee7c0 0000001200000012 ffff888100041280
raw: 0000000000000000 0000000000660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, ts 2488779673, free_ts 2417060616
 prep_new_page mm/page_alloc.c:2358 [inline]
 get_page_from_freelist+0xc97/0x26a0 mm/page_alloc.c:3994
 __alloc_pages+0x1b2/0x4f0 mm/page_alloc.c:5200
 alloc_page_interleave+0x1e/0x190 mm/mempolicy.c:2147
 alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1644 [inline]
 allocate_slab+0x2c5/0x4c0 mm/slub.c:1784
 new_slab mm/slub.c:1847 [inline]
 new_slab_objects mm/slub.c:2593 [inline]
 ___slab_alloc+0x476/0x7b0 mm/slub.c:2756
 __slab_alloc+0x68/0x80 mm/slub.c:2796
 slab_alloc_node mm/slub.c:2878 [inline]
 slab_alloc mm/slub.c:2920 [inline]
 __kmalloc+0x2f4/0x310 mm/slub.c:4063
 acpi_ns_internalize_name drivers/acpi/acpica/nsutils.c:331 [inline]
 acpi_ns_internalize_name+0xf2/0x1a1 drivers/acpi/acpica/nsutils.c:312
 acpi_ns_get_node_unlocked drivers/acpi/acpica/nsutils.c:666 [inline]
 acpi_ns_get_node_unlocked+0x1d8/0x278 drivers/acpi/acpica/nsutils.c:635
 acpi_ns_get_node+0x4b/0x6a drivers/acpi/acpica/nsutils.c:726
 acpi_ns_evaluate+0xd2/0x966 drivers/acpi/acpica/nseval.c:62
 acpi_ut_evaluate_object+0xf1/0x3f6 drivers/acpi/acpica/uteval.c:60
 acpi_ut_execute_STA+0x82/0x17b drivers/acpi/acpica/uteval.c:223
 acpi_ns_init_one_device+0x142/0x41a drivers/acpi/acpica/nsinit.c:561
 acpi_ns_walk_namespace+0x23d/0x41f drivers/acpi/acpica/nswalk.c:237
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1298 [inline]
 free_pcp_prepare+0x216/0x390 mm/page_alloc.c:1342
 free_unref_page_prepare mm/page_alloc.c:3250 [inline]
 free_unref_page+0x12/0x1c0 mm/page_alloc.c:3298
 __vunmap+0x783/0xb60 mm/vmalloc.c:2566
 free_work+0x58/0x70 mm/vmalloc.c:80
 process_one_work+0x98d/0x1580 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x38c/0x460 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

Memory state around the buggy address:
 ffff8881095a5e80: fc 00 fc fc fc fc 00 fc fc fc fc 00 fc fc fc fc
 ffff8881095a5f00: fa fc fc fc fc fa fc fc fc fc fa fc fc fc fc 00
>ffff8881095a5f80: fc fc fc fc 00 fc fc fc fc fa fc fc fc fc fc fc
                                  ^
 ffff8881095a6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8881095a6080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
