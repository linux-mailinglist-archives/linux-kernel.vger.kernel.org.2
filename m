Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0E3530D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 23:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbhDBVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 17:41:25 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33567 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:41:23 -0400
Received: by mail-io1-f69.google.com with SMTP id o1so6943000iou.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 14:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=yRwQU0I6V3jPf6sryNtKBNI26aKIJlxwm3TJUkR7FQw=;
        b=AM6KlUDhTmyXlbdBE49Ftm563FWXrj0A05/n24qp1Kwv6rdrFmuOuyKp5jB5GksBr4
         ok94PVQZHrtG2k9/Y4qh02tSChq3RmrzrgYOQwqDHxxacRbae+iI0f7Lc0u0Z8Z9DU4J
         +vrw2kqjPrUAZ5N470l99fIlU6DTdvNwtrEFo+SnIPIHsT1/MA8rjnBLmM+LxuysFPA8
         KBmdxyM7K95IaEtgObbYLeS8YrtgFiBEOOqIvCP7q4of1gsKEONErQwze6raywDEx91+
         2sRDT1HGrO89oo88vgi+8mY3NHBmmG5mGEW6Jlj7eRyQaAvPZHJnov2e2rkoyOJ4giPd
         fwYg==
X-Gm-Message-State: AOAM533zFTxuKWCEEYozro/1pR1WfX+7lCrtXQUmenyob3Fwcl4lIzuo
        soIHrfeOLekSjKZATT9jNDgkB+8tkD/AeeCDltq1oGyBs7fm
X-Google-Smtp-Source: ABdhPJw+4xBrHa4marbD2BBgXDv/+N24MZe2uGEyj1tbVRFcIFe8DcnZJEd8AXntD+N2BdIO5lwEuOVempFifuo599iQAoP1lHt2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b01:: with SMTP id i1mr12273624ilv.253.1617399680995;
 Fri, 02 Apr 2021 14:41:20 -0700 (PDT)
Date:   Fri, 02 Apr 2021 14:41:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000721b1305bf043595@google.com>
Subject: [syzbot] KASAN: use-after-free Read in fw_load_sysfs_fallback
From:   syzbot <syzbot+9b91d635e2b51efd6371@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org, sunjunyong@xiaomi.com,
        sunjy516@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5ee96fa9 Merge tag 'irq-urgent-2021-03-21' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1028d621d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c51293a9ca630f6d
dashboard link: https://syzkaller.appspot.com/bug?extid=9b91d635e2b51efd6371
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1794dad6d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f7afe6d00000

The issue was bisected to:

commit bcfbd3523f3c6eea51a74d217a8ebc5463bcb7f4
Author: Junyong Sun <sunjy516@gmail.com>
Date:   Tue Mar 3 02:36:08 2020 +0000

    firmware: fix a double abort case with fw_load_sysfs_fallback

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e4778ad00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1414778ad00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1014778ad00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b91d635e2b51efd6371@syzkaller.appspotmail.com
Fixes: bcfbd3523f3c ("firmware: fix a double abort case with fw_load_sysfs_fallback")

platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
platform regulatory.0: Falling back to sysfs fallback for: regulatory.db
==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x36/0xc0 lib/list_debug.c:23
Read of size 8 at addr ffff888014188ac8 by task syz-executor310/9819

CPU: 0 PID: 9819 Comm: syz-executor310 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x176/0x24e lib/dump_stack.c:120
 print_address_description+0x5f/0x3a0 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report+0x15c/0x200 mm/kasan/report.c:416
 __list_add_valid+0x36/0xc0 lib/list_debug.c:23
 __list_add include/linux/list.h:67 [inline]
 list_add include/linux/list.h:86 [inline]
 fw_load_sysfs_fallback+0x110/0x720 drivers/base/firmware_loader/fallback.c:516
 fw_load_from_user_helper+0x242/0x320 drivers/base/firmware_loader/fallback.c:581
 _request_firmware+0x2c5/0x4c0 drivers/base/firmware_loader/main.c:831
 request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x3a/0x1b0 net/wireless/reg.c:1095
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0xe4e/0x1280 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg net/socket.c:674 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2350
 ___sys_sendmsg net/socket.c:2404 [inline]
 __sys_sendmsg+0x2bf/0x370 net/socket.c:2433
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x44ab59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 01 16 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2b8ba9318 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004d62a8 RCX: 000000000044ab59
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 00000000004d62a0 R08: 0000000000000099 R09: 0000000000000000
R10: 000000000000000c R11: 0000000000000246 R12: 0031313230386c6e
R13: 00007ffeeaba390f R14: 00007fa2b8ba9400 R15: 0000000000022000

Allocated by task 9818:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 ____kasan_kmalloc+0xc2/0xf0 mm/kasan/common.c:506
 kasan_kmalloc include/linux/kasan.h:233 [inline]
 kmem_cache_alloc_trace+0x21b/0x350 mm/slub.c:2934
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:684 [inline]
 __allocate_fw_priv+0x98/0x340 drivers/base/firmware_loader/main.c:186
 alloc_lookup_fw_priv+0x1c3/0x380 drivers/base/firmware_loader/main.c:250
 _request_firmware_prepare+0x23c/0x5b0 drivers/base/firmware_loader/main.c:744
 _request_firmware+0xd9/0x4c0 drivers/base/firmware_loader/main.c:806
 request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x3a/0x1b0 net/wireless/reg.c:1095
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0xe4e/0x1280 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg net/socket.c:674 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2350
 ___sys_sendmsg net/socket.c:2404 [inline]
 __sys_sendmsg+0x2bf/0x370 net/socket.c:2433
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 9815:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:46
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:357
 ____kasan_slab_free+0x100/0x140 mm/kasan/common.c:360
 kasan_slab_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:1562 [inline]
 slab_free_freelist_hook+0x171/0x270 mm/slub.c:1600
 slab_free mm/slub.c:3161 [inline]
 kfree+0xcf/0x2d0 mm/slub.c:4213
 kref_put include/linux/kref.h:65 [inline]
 free_fw_priv drivers/base/firmware_loader/main.c:289 [inline]
 firmware_free_data drivers/base/firmware_loader/main.c:584 [inline]
 release_firmware+0x139/0x1b0 drivers/base/firmware_loader/main.c:1053
 _request_firmware+0x3e1/0x4c0 drivers/base/firmware_loader/main.c:839
 request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x3a/0x1b0 net/wireless/reg.c:1095
 genl_family_rcv_msg_doit net/netlink/genetlink.c:739 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0xe4e/0x1280 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg net/socket.c:674 [inline]
 ____sys_sendmsg+0x519/0x800 net/socket.c:2350
 ___sys_sendmsg net/socket.c:2404 [inline]
 __sys_sendmsg+0x2bf/0x370 net/socket.c:2433
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
 kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
 kasan_record_aux_stack+0xee/0x120 mm/kasan/generic.c:345
 __call_rcu kernel/rcu/tree.c:3039 [inline]
 call_rcu+0x130/0x8e0 kernel/rcu/tree.c:3114
 fib6_info_release include/net/ip6_fib.h:337 [inline]
 ip6_route_info_create+0xf84/0x17f0 net/ipv6/route.c:3736
 ip6_route_add+0x22/0x120 net/ipv6/route.c:3746
 addrconf_prefix_route net/ipv6/addrconf.c:2415 [inline]
 inet6_addr_add+0x99e/0x11a0 net/ipv6/addrconf.c:2948
 inet6_rtm_newaddr+0x754/0x2890 net/ipv6/addrconf.c:4869
 rtnetlink_rcv_msg+0x895/0xd50 net/core/rtnetlink.c:5553
 netlink_rcv_skb+0x190/0x3a0 net/netlink/af_netlink.c:2502
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x786/0x940 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x9ae/0xd50 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg net/socket.c:674 [inline]
 __sys_sendto+0x438/0x5c0 net/socket.c:1977
 __do_sys_sendto net/socket.c:1989 [inline]
 __se_sys_sendto net/socket.c:1985 [inline]
 __x64_sys_sendto+0xda/0xf0 net/socket.c:1985
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff888014188a00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 200 bytes inside of
 256-byte region [ffff888014188a00, ffff888014188b00)
The buggy address belongs to the page:
page:ffffea0000506200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14188
head:ffffea0000506200 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 0000000000000000 0000000100000001 ffff888010841b40
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888014188980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888014188a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888014188a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888014188b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888014188b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
