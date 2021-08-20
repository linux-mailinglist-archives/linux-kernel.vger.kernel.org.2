Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4863F2A48
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhHTKs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:48:58 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:49010 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhHTKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:48:57 -0400
Received: by mail-io1-f71.google.com with SMTP id d12-20020a6b680c000000b005b86e36a1f4so5180526ioc.15
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wSMT4jLT4tSBStgpaXVhtrmhWzGBKn8kNA6mXVfY5U0=;
        b=D0NldVE+jystUFdeFNpoN6gwsK8FVohnGX3sastDsfsxZp8FZEdg6R6je09x99fi4E
         3Nnl3nBje2zQPub1HIKegnWxE5uJdaLHaY0iM5yEb1Fb7ywoSACxFPbEHYJsSyeCjp36
         w1pkVIUA9zz6OD4em21TaKUEs7KHEhn4R9P9D/5TmITAIBKSdM+WsZ8d61by+dRe0hdB
         2xIYMbRY71mWKwVFCIeYcX98qWaVDxbmYErRp4NUbl/8/D+OA+SfBMM0avxeHims1xqS
         kOOXmg66cwkmlVupvClSa1EbL51oxQu3iUsY4nFaqIHorJoFmx0+VadKLeDs2SQTPqyC
         wnmg==
X-Gm-Message-State: AOAM532WXuMDZbx5zEzevDGIg+4328N2ws1rBHpQ2Nq2WqxjZLX4mjS0
        bhrdWg8pTJhvAqQkj2i0ByztTl77c5uO1BPUU3MffXcwZJId
X-Google-Smtp-Source: ABdhPJyKyTWDGwHYaAgg0AwvjjQWazrFW3niYMus0cNLrKI11vhjfGlWT4wKXvKMBbzJGhBHgZ6qc8eO/EpRvCrB0nzngHjAZaoH
MIME-Version: 1.0
X-Received: by 2002:a92:da46:: with SMTP id p6mr13088490ilq.161.1629456498073;
 Fri, 20 Aug 2021 03:48:18 -0700 (PDT)
Date:   Fri, 20 Aug 2021 03:48:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000beab5a05c9fb67bb@google.com>
Subject: [syzbot] KASAN: use-after-free Write in _atomic_dec_and_lock_irqsave
From:   syzbot <syzbot+c59302ca1658701a11fc@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d6d09a694205 Merge tag 'for-5.14-rc6-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e6c341300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=c59302ca1658701a11fc
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c59302ca1658701a11fc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: use-after-free in atomic_add_unless include/asm-generic/atomic-instrumented.h:570 [inline]
BUG: KASAN: use-after-free in _atomic_dec_and_lock_irqsave+0x2f/0x150 lib/dec_and_lock.c:41
Write of size 4 at addr ffff88802a10111c by task ksoftirqd/1/19

CPU: 1 PID: 19 Comm: ksoftirqd/1 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
 print_address_description+0x66/0x3b0 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report+0x163/0x210 mm/kasan/report.c:436
 check_region_inline mm/kasan/generic.c:135 [inline]
 kasan_check_range+0x2b5/0x2f0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_add_unless include/asm-generic/atomic-instrumented.h:570 [inline]
 _atomic_dec_and_lock_irqsave+0x2f/0x150 lib/dec_and_lock.c:41
 put_ucounts+0x7c/0x1a0 kernel/ucount.c:204
 put_cred_rcu+0x221/0x400 kernel/cred.c:124
 rcu_do_batch kernel/rcu/tree.c:2550 [inline]
 rcu_core+0x906/0x14b0 kernel/rcu/tree.c:2785
 __do_softirq+0x372/0x783 kernel/softirq.c:558
 run_ksoftirqd+0xa2/0x100 kernel/softirq.c:920
 smpboot_thread_fn+0x533/0x9d0 kernel/smpboot.c:164
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Allocated by task 20438:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:434 [inline]
 ____kasan_kmalloc+0xc4/0xf0 mm/kasan/common.c:513
 kasan_kmalloc include/linux/kasan.h:264 [inline]
 kmem_cache_alloc_trace+0x96/0x340 mm/slub.c:2986
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_ucounts+0x1b1/0x5d0 kernel/ucount.c:173
 set_cred_ucounts+0x220/0x2d0 kernel/cred.c:684
 __sys_setresuid+0x6d5/0x920 kernel/sys.c:702
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 8456:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:360
 ____kasan_slab_free+0x109/0x150 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:1628 [inline]
 slab_free_freelist_hook+0x1d8/0x290 mm/slub.c:1653
 slab_free mm/slub.c:3213 [inline]
 kfree+0xcf/0x2e0 mm/slub.c:4267
 put_ucounts+0x15c/0x1a0 kernel/ucount.c:207
 put_cred_rcu+0x221/0x400 kernel/cred.c:124
 rcu_do_batch kernel/rcu/tree.c:2550 [inline]
 rcu_core+0x906/0x14b0 kernel/rcu/tree.c:2785
 __do_softirq+0x372/0x783 kernel/softirq.c:558

Last potentially related work creation:
 kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
 kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
 __call_rcu kernel/rcu/tree.c:3029 [inline]
 call_rcu+0x1a0/0xa20 kernel/rcu/tree.c:3109
 inetdev_destroy net/ipv4/devinet.c:325 [inline]
 inetdev_event+0x79a/0x14d0 net/ipv4/devinet.c:1598
 notifier_call_chain kernel/notifier.c:83 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:410
 call_netdevice_notifiers_info net/core/dev.c:2123 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:2135 [inline]
 call_netdevice_notifiers net/core/dev.c:2149 [inline]
 unregister_netdevice_many+0xf7e/0x1980 net/core/dev.c:11093
 ip_tunnel_delete_nets+0x325/0x370 net/ipv4/ip_tunnel.c:1122
 ops_exit_list net/core/net_namespace.c:178 [inline]
 cleanup_net+0x7ec/0xc60 net/core/net_namespace.c:595
 process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

Second to last potentially related work creation:
 kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
 kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:348
 insert_work+0x54/0x400 kernel/workqueue.c:1332
 __queue_work+0x928/0xc60 kernel/workqueue.c:1498
 queue_work_on+0x111/0x200 kernel/workqueue.c:1525
 queue_work include/linux/workqueue.h:507 [inline]
 call_usermodehelper_exec+0x283/0x470 kernel/umh.c:435
 kobject_uevent_env+0x1337/0x1700 lib/kobject_uevent.c:618
 netdev_queue_add_kobject net/core/net-sysfs.c:1621 [inline]
 netdev_queue_update_kobjects+0x1c6/0x400 net/core/net-sysfs.c:1655
 register_queue_kobjects net/core/net-sysfs.c:1716 [inline]
 netdev_register_kobject+0x263/0x310 net/core/net-sysfs.c:1959
 register_netdevice+0x12a1/0x1c20 net/core/dev.c:10349
 register_netdev+0x37/0x50 net/core/dev.c:10473
 sixpack_open+0x5be/0x9e0 drivers/net/hamradio/6pack.c:623
 tty_ldisc_open drivers/tty/tty_ldisc.c:449 [inline]
 tty_set_ldisc+0x530/0x950 drivers/tty/tty_ldisc.c:579
 tiocsetd drivers/tty/tty_io.c:2455 [inline]
 tty_ioctl+0x1394/0x1720 drivers/tty/tty_io.c:2741
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88802a101100
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 28 bytes inside of
 192-byte region [ffff88802a101100, ffff88802a1011c0)
The buggy address belongs to the page:
page:ffffea0000a84040 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2a101
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00005d2100 0000000900000007 ffff888011041a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 8456, ts 148626461315, free_ts 148608362928
 prep_new_page mm/page_alloc.c:2436 [inline]
 get_page_from_freelist+0x779/0xa30 mm/page_alloc.c:4169
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5391
 alloc_slab_page mm/slub.c:1691 [inline]
 allocate_slab+0xf1/0x540 mm/slub.c:1831
 new_slab mm/slub.c:1894 [inline]
 new_slab_objects mm/slub.c:2640 [inline]
 ___slab_alloc+0x1cf/0x350 mm/slub.c:2803
 __slab_alloc mm/slub.c:2843 [inline]
 slab_alloc_node mm/slub.c:2925 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 kmem_cache_alloc_trace+0x29d/0x340 mm/slub.c:2984
 kmalloc include/linux/slab.h:591 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:643 [inline]
 netdevice_event+0x3af/0x970 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain kernel/notifier.c:83 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:410
 __dev_notify_flags+0x306/0x5d0 net/core/dev.c:2123
 dev_change_flags+0xe3/0x190 net/core/dev.c:8898
 do_setlink+0xcbd/0x3f70 net/core/rtnetlink.c:2721
 __rtnl_newlink net/core/rtnetlink.c:3393 [inline]
 rtnl_newlink+0x16e4/0x1cd0 net/core/rtnetlink.c:3508
 rtnetlink_rcv_msg+0x91c/0xe50 net/core/rtnetlink.c:5574
 netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x7de/0x9b0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x9e7/0xe00 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:703 [inline]
 sock_sendmsg net/socket.c:723 [inline]
 __sys_sendto+0x541/0x720 net/socket.c:2019
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1346 [inline]
 free_pcp_prepare+0xc29/0xd20 mm/page_alloc.c:1397
 free_unref_page_prepare mm/page_alloc.c:3332 [inline]
 free_unref_page+0x7e/0x550 mm/page_alloc.c:3411
 free_slab mm/slub.c:1934 [inline]
 discard_slab mm/slub.c:1940 [inline]
 __slab_free+0x5c0/0x6b0 mm/slub.c:3143
 do_slab_free mm/slub.c:3201 [inline]
 ___cache_free+0xfc/0x120 mm/slub.c:3220
 qlist_free_all mm/kasan/quarantine.c:165 [inline]
 kasan_quarantine_reduce+0x151/0x1c0 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:444
 kasan_slab_alloc include/linux/kasan.h:254 [inline]
 slab_post_alloc_hook mm/slab.h:519 [inline]
 slab_alloc_node mm/slub.c:2959 [inline]
 slab_alloc mm/slub.c:2967 [inline]
 kmem_cache_alloc_trace+0x209/0x340 mm/slub.c:2984
 kmalloc include/linux/slab.h:591 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 ipv6_add_addr+0x408/0x1480 net/ipv6/addrconf.c:1083
 add_addr+0x194/0x470 net/ipv6/addrconf.c:3077
 addrconf_notify+0x179f/0x2110 net/ipv6/addrconf.c:3589
 notifier_call_chain kernel/notifier.c:83 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:410
 __dev_notify_flags+0x306/0x5d0 net/core/dev.c:2123
 dev_change_flags+0xe3/0x190 net/core/dev.c:8898
 do_setlink+0xcbd/0x3f70 net/core/rtnetlink.c:2721
 __rtnl_newlink net/core/rtnetlink.c:3393 [inline]
 rtnl_newlink+0x16e4/0x1cd0 net/core/rtnetlink.c:3508
 rtnetlink_rcv_msg+0x91c/0xe50 net/core/rtnetlink.c:5574

Memory state around the buggy address:
 ffff88802a101000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802a101080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88802a101100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802a101180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88802a101200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
