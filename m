Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8534087A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhCRPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:10:27 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:35774 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhCRPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:10:19 -0400
Received: by mail-il1-f197.google.com with SMTP id y8so9882925ill.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=G5136JeB8LQRWRarXRPXObcHHfGKgJ85d0AAPdK8Gd8=;
        b=okSJJzOVtKRIlMClj1oRQ2HOnuoehr8PMyE2Oh+TBqSCHHB6GqTQK7n+ix5qE+8PFO
         5tZr1iuC7n8BzLetcbfZ4K+xxdYXWJe78HQ02wo4MKSyCWlXl3cfDhqw8UVH9IXXd3ix
         XVYlxKtX7oEmjHi48Ibuz4g8nRnPCxNHrByY+pZ9OjqbI6iHw9t+F1SRZwFTsCzEk4wG
         TLKXYXpZwuW0JAGmxJh0tBHMDh3LIhPOf0A1j1Vedbo1/zQBa9NFlU/EgIOG5AuuH/xD
         B/T72oijAumRHTUegxZXh6s4VvB6VR7CnmHhwJWBMN8eNVtjMM0t/aD0yNgwhgorO8kv
         wn/A==
X-Gm-Message-State: AOAM530o6UXHD3zPiIMOTAtUod5p+JQe4h9Svx70maZXD3UPzdJZT825
        8I4C0Iv7IujiT4pw8i7ajxfdonJMrkg86TA2bXXn7joptANf
X-Google-Smtp-Source: ABdhPJyZB/n/JR5FU2VjnbViWPIPsP4gXBiKmWAcRdRGLiZQWddtNcSuU88MT+h723iL8O7CYlzMO/aC0T1OfGjnZy8uGXZV2oyc
MIME-Version: 1.0
X-Received: by 2002:a6b:8b0e:: with SMTP id n14mr10812800iod.199.1616080219268;
 Thu, 18 Mar 2021 08:10:19 -0700 (PDT)
Date:   Thu, 18 Mar 2021 08:10:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065f25405bdd0ff36@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kill_pending_fw_fallback_reqs
From:   syzbot <syzbot+6e23e12624dbacf657bc@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6417f031 module: remove never implemented MODULE_SUPPORTED..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16293a7cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab2c8a4eaedddecd
dashboard link: https://syzkaller.appspot.com/bug?extid=6e23e12624dbacf657bc

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e23e12624dbacf657bc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in kill_pending_fw_fallback_reqs+0x2fb/0x370 drivers/base/firmware_loader/fallback.c:116
Read of size 8 at addr ffff8880757caac0 by task syz-executor.1/14981

CPU: 0 PID: 14981 Comm: syz-executor.1 Not tainted 5.12.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
 __kasan_report mm/kasan/report.c:399 [inline]
 kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
 kill_pending_fw_fallback_reqs+0x2fb/0x370 drivers/base/firmware_loader/fallback.c:116
 fw_pm_notify+0xa2/0x150 drivers/base/firmware_loader/main.c:1448
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
 notifier_call_chain_robust kernel/notifier.c:118 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:302 [inline]
 blocking_notifier_call_chain_robust+0xc4/0x160 kernel/notifier.c:290
 pm_notifier_call_chain_robust+0x26/0x60 kernel/power/main.c:87
 snapshot_open+0x190/0x2a0 kernel/power/user.c:75
 misc_open+0x372/0x4a0 drivers/char/misc.c:141
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:826
 do_open fs/namei.c:3365 [inline]
 path_openat+0x1c0e/0x27e0 fs/namei.c:3498
 do_filp_open+0x17e/0x3c0 fs/namei.c:3525
 do_sys_openat2+0x16d/0x420 fs/open.c:1187
 do_sys_open fs/open.c:1203 [inline]
 __do_sys_openat fs/open.c:1219 [inline]
 __se_sys_openat fs/open.c:1214 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1214
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x465f69
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9819e12188 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 0000000000465f69
RDX: 0000000000000000 RSI: 0000000020000ac0 RDI: ffffffffffffff9c
RBP: 00000000004bfa8f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffd557c11df R14: 00007f9819e12300 R15: 0000000000022000

Allocated by task 13418:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:46 [inline]
 set_alloc_info mm/kasan/common.c:427 [inline]
 ____kasan_kmalloc mm/kasan/common.c:506 [inline]
 ____kasan_kmalloc mm/kasan/common.c:465 [inline]
 __kasan_kmalloc+0x99/0xc0 mm/kasan/common.c:515
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:684 [inline]
 __allocate_fw_priv drivers/base/firmware_loader/main.c:186 [inline]
 alloc_lookup_fw_priv drivers/base/firmware_loader/main.c:250 [inline]
 _request_firmware_prepare drivers/base/firmware_loader/main.c:744 [inline]
 _request_firmware+0x2de/0xe80 drivers/base/firmware_loader/main.c:806
 request_firmware+0x32/0x50 drivers/base/firmware_loader/main.c:875
 reg_reload_regdb+0x7a/0x240 net/wireless/reg.c:1095
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2350
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2433
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8880757caa00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 192 bytes inside of
 256-byte region [ffff8880757caa00, ffff8880757cab00)
The buggy address belongs to the page:
page:ffffea0001d5f280 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880757caa00 pfn:0x757ca
head:ffffea0001d5f280 order:1 compound_mapcount:0
flags: 0xfff00000010200(slab|head)
raw: 00fff00000010200 ffffea000094b608 ffffea00006b8508 ffff888010841b40
raw: ffff8880757caa00 0000000000100005 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880757ca980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880757caa00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880757caa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880757cab00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880757cab80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
