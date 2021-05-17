Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA1382B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhEQLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:46:36 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47055 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhEQLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:46:34 -0400
Received: by mail-il1-f200.google.com with SMTP id p3-20020a92c6030000b02901a4787c24f7so6069641ilm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 04:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LOmZFv3PrsCHL4amAtVUmK13HGm/M7XQ1x7jyeuFGXE=;
        b=kPypMcEOYAUtd+lrmdMwPo/0d+SMsL3VQpTADJB0AxnN4yUiSNUQnGPVi/VhNx7hmN
         5Av6ts6VhZ6a0rlI58eXCnRnucbsidnIj+XWLdnE9xRR9aiUb0n5avoKi9lyV5U4nPbZ
         j8ffv3/K8wHqjT2ePwkiEcMSdKeR/dqAqUU0iTbA5mGwoApBzgEwEBDahs8ezLusA6gw
         8priDIdUE5uU9qi124e7PU0whSh/cqAs82xoF6RREDYolg5N4Vrf2OH64C/D8654j0CR
         qmKHjWIvzYicNHdpbSK7TSnln/se/4K8liDuo7CXPZCgPJRnUz+dcqbInP+jh+Wn3aOT
         kWmQ==
X-Gm-Message-State: AOAM531NtYLQdUPJAVWypiiTQcyWmP7CqobfbyAFGDc+jXIykcrAhs0x
        +R4NSlC2BzqbPu5hO02YarHC9kGffCU5Z9UVzf/npK8Qm40Z
X-Google-Smtp-Source: ABdhPJzxf5fUVitkWlq4qb9Ng5WqZl6oVyDnlZsfWQXKEqvMXJKHdovSzF/O41hhgkQ9Q9WvTfV31dypgjL85pJHBgBzP1Arr8UA
MIME-Version: 1.0
X-Received: by 2002:a5d:87c4:: with SMTP id q4mr42324904ios.141.1621251917454;
 Mon, 17 May 2021 04:45:17 -0700 (PDT)
Date:   Mon, 17 May 2021 04:45:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1a22005c2852068@google.com>
Subject: [syzbot] KASAN: use-after-free Read in firmware_loading_store
From:   syzbot <syzbot+77cea49e091776a57689@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1140ab59 Merge tag 'perf-tools-fixes-for-v5.13-2021-05-10'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12586265d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=807beec6b4d66bf1
dashboard link: https://syzkaller.appspot.com/bug?extid=77cea49e091776a57689

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77cea49e091776a57689@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_del_entry_valid+0xd6/0xf0 lib/list_debug.c:54
Read of size 8 at addr ffff88802b3da2c8 by task systemd-udevd/25252

CPU: 0 PID: 25252 Comm: systemd-udevd Not tainted 5.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:233
 __kasan_report mm/kasan/report.c:419 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:436
 __list_del_entry_valid+0xd6/0xf0 lib/list_debug.c:54
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 __fw_load_abort drivers/base/firmware_loader/fallback.c:97 [inline]
 __fw_load_abort drivers/base/firmware_loader/fallback.c:88 [inline]
 fw_load_abort drivers/base/firmware_loader/fallback.c:105 [inline]
 firmware_loading_store+0x141/0x650 drivers/base/firmware_loader/fallback.c:297
 dev_attr_store+0x50/0x80 drivers/base/core.c:2066
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x342/0x500 fs/kernfs/file.c:296
 call_write_iter include/linux/fs.h:2114 [inline]
 new_sync_write+0x426/0x650 fs/read_write.c:518
 vfs_write+0x796/0xa30 fs/read_write.c:605
 ksys_write+0x12d/0x250 fs/read_write.c:658
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6d0b3fe970
Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
RSP: 002b:00007ffde8a82ba8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6d0b3fe970
RDX: 0000000000000002 RSI: 00005567e595b380 RDI: 0000000000000007
RBP: 00005567e595b380 R08: 00007f6d0c58c8c0 R09: 0000000000000002
R10: 0000000000000020 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000001 R14: 00005567e59427d0 R15: 0000000000000002

Allocated by task 25248:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:428 [inline]
 ____kasan_kmalloc mm/kasan/common.c:507 [inline]
 ____kasan_kmalloc mm/kasan/common.c:466 [inline]
 __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:516
 kmalloc include/linux/slab.h:556 [inline]
 kzalloc include/linux/slab.h:686 [inline]
 __allocate_fw_priv drivers/base/firmware_loader/main.c:187 [inline]
 alloc_lookup_fw_priv drivers/base/firmware_loader/main.c:251 [inline]
 _request_firmware_prepare drivers/base/firmware_loader/main.c:746 [inline]
 _request_firmware+0x2de/0xe80 drivers/base/firmware_loader/main.c:808
 request_firmware+0x32/0x50 drivers/base/firmware_loader/main.c:877
 devlink_compat_flash_update+0x25b/0x4f0 net/core/devlink.c:10524
 ethtool_flash_device+0x174/0x1a0 net/ethtool/ioctl.c:2072
 dev_ethtool+0x5e3/0x46d0 net/ethtool/ioctl.c:2765
 dev_ioctl+0x463/0xb70 net/core/dev_ioctl.c:440
 sock_do_ioctl+0x148/0x2d0 net/socket.c:1062
 sock_ioctl+0x477/0x6a0 net/socket.c:1179
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 25225:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:357
 ____kasan_slab_free mm/kasan/common.c:360 [inline]
 ____kasan_slab_free mm/kasan/common.c:325 [inline]
 __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:368
 kasan_slab_free include/linux/kasan.h:212 [inline]
 slab_free_hook mm/slub.c:1581 [inline]
 slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1606
 slab_free mm/slub.c:3166 [inline]
 kfree+0xe5/0x7f0 mm/slub.c:4225
 __free_fw_priv drivers/base/firmware_loader/main.c:283 [inline]
 kref_put include/linux/kref.h:65 [inline]
 free_fw_priv+0x2b1/0x4d0 drivers/base/firmware_loader/main.c:290
 firmware_free_data drivers/base/firmware_loader/main.c:586 [inline]
 release_firmware.part.0+0xc7/0xf0 drivers/base/firmware_loader/main.c:1055
 release_firmware drivers/base/firmware_loader/main.c:842 [inline]
 _request_firmware+0x709/0xe80 drivers/base/firmware_loader/main.c:841
 request_firmware+0x32/0x50 drivers/base/firmware_loader/main.c:877
 devlink_compat_flash_update+0x25b/0x4f0 net/core/devlink.c:10524
 ethtool_flash_device+0x174/0x1a0 net/ethtool/ioctl.c:2072
 dev_ethtool+0x5e3/0x46d0 net/ethtool/ioctl.c:2765
 dev_ioctl+0x463/0xb70 net/core/dev_ioctl.c:440
 sock_do_ioctl+0x148/0x2d0 net/socket.c:1062
 sock_ioctl+0x477/0x6a0 net/socket.c:1179
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3038 [inline]
 call_rcu+0xb1/0x750 kernel/rcu/tree.c:3113
 fib6_info_release include/net/ip6_fib.h:337 [inline]
 fib6_info_release include/net/ip6_fib.h:334 [inline]
 ip6_route_info_create+0x125f/0x19d0 net/ipv6/route.c:3715
 ip6_route_add+0x24/0x150 net/ipv6/route.c:3725
 addrconf_add_mroute+0x216/0x310 net/ipv6/addrconf.c:2479
 addrconf_add_dev+0x162/0x1d0 net/ipv6/addrconf.c:2497
 inet6_addr_add+0x1a4/0xae0 net/ipv6/addrconf.c:2913
 inet6_rtm_newaddr+0xf00/0x1970 net/ipv6/addrconf.c:4871
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5562
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 __sys_sendto+0x21c/0x320 net/socket.c:1977
 __do_sys_sendto net/socket.c:1989 [inline]
 __se_sys_sendto net/socket.c:1985 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:1985
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff88802b3da200
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 200 bytes inside of
 256-byte region [ffff88802b3da200, ffff88802b3da300)
The buggy address belongs to the page:
page:ffffea0000acf680 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b3da
head:ffffea0000acf680 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0000c5fc00 0000000200000002 ffff888011041b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9174, ts 170493776335, free_ts 170097190406
 prep_new_page mm/page_alloc.c:2358 [inline]
 get_page_from_freelist+0x1033/0x2b60 mm/page_alloc.c:3994
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5200
 alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
 alloc_slab_page mm/slub.c:1644 [inline]
 allocate_slab+0x2c5/0x4c0 mm/slub.c:1784
 new_slab mm/slub.c:1847 [inline]
 new_slab_objects mm/slub.c:2593 [inline]
 ___slab_alloc+0x44c/0x7a0 mm/slub.c:2756
 __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2796
 slab_alloc_node mm/slub.c:2878 [inline]
 slab_alloc mm/slub.c:2920 [inline]
 __kmalloc+0x315/0x330 mm/slub.c:4063
 kmalloc include/linux/slab.h:561 [inline]
 kzalloc include/linux/slab.h:686 [inline]
 new_dir fs/proc/proc_sysctl.c:953 [inline]
 get_subdir fs/proc/proc_sysctl.c:998 [inline]
 __register_sysctl_table+0x9ef/0x1090 fs/proc/proc_sysctl.c:1347
 __addrconf_sysctl_register+0x1db/0x3d0 net/ipv6/addrconf.c:6965
 addrconf_sysctl_register net/ipv6/addrconf.c:7012 [inline]
 addrconf_sysctl_register+0x139/0x1d0 net/ipv6/addrconf.c:7001
 ipv6_add_dev+0x936/0x1120 net/ipv6/addrconf.c:445
 ipv6_find_idev+0x169/0x1f0 net/ipv6/addrconf.c:481
 inet6_rtm_newaddr+0x3fe/0x1970 net/ipv6/addrconf.c:4852
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5562
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1298 [inline]
 free_pcp_prepare+0x223/0x300 mm/page_alloc.c:1342
 free_unref_page_prepare mm/page_alloc.c:3250 [inline]
 free_unref_page+0x12/0x1d0 mm/page_alloc.c:3298
 qlink_free mm/kasan/quarantine.c:146 [inline]
 qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
 __kasan_slab_alloc+0x8e/0xa0 mm/kasan/common.c:438
 kasan_slab_alloc include/linux/kasan.h:236 [inline]
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:2912 [inline]
 kmem_cache_alloc_node+0x269/0x3e0 mm/slub.c:2948
 __alloc_skb+0x20b/0x340 net/core/skbuff.c:413
 alloc_skb include/linux/skbuff.h:1107 [inline]
 alloc_skb_with_frags+0x93/0x5d0 net/core/skbuff.c:5990
 sock_alloc_send_pskb+0x793/0x920 net/core/sock.c:2356
 mld_newpack+0x1e0/0x770 net/ipv6/mcast.c:1750
 add_grhead+0x265/0x330 net/ipv6/mcast.c:1854
 add_grec+0x10dd/0x14d0 net/ipv6/mcast.c:1992
 mld_send_initial_cr.part.0+0x100/0x230 net/ipv6/mcast.c:2239
 mld_send_initial_cr net/ipv6/mcast.c:1227 [inline]
 mld_dad_work+0x1d3/0x690 net/ipv6/mcast.c:2265
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421

Memory state around the buggy address:
 ffff88802b3da180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802b3da200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802b3da280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88802b3da300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802b3da380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
