Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3312C3211BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 09:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbhBVIGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 03:06:13 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41026 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhBVIGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 03:06:10 -0500
Received: by mail-il1-f200.google.com with SMTP id d11so7091046ilu.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 00:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+DNCnXkYgjNeMtNYx/y9gykHMdDqLWWPfQzkJlb/eio=;
        b=VUhvBs+pxYBoac4Cb1+3SjOmAtMwnGsCi0y5Sp9+0qgzjIvXBMwUW7uVY0TRMCXiB6
         In9IFCI8YEoPrOODBFTR9UOUEL1nW9BNvndLWRjDHef0cXb21bY2HZg3/F1t1vXgGU5l
         jlwdDfDq6phUNPtlN7s4sJRF1LsnQINt8lBe4w+7QYqX2g0ZiZkdN4g+Nu1DU1tcXT03
         pCkppw9WanmeC1BkPjyftL/UhLOR4J2EyyfF0EvyyuqPKHq4NeOy79cWCcIn10mpaT29
         MA3xeh7inCkgIVSC2jswDyctvSWjcwNxdf7s4K/3egs4+U7L+zfWepuck03JfY4WYmmT
         R0Iw==
X-Gm-Message-State: AOAM532RZNMy9JHPQD7rEH31v/99Rdrg702CblBVUDcxBaPd2uSaAUdp
        pelPxyEnyz+Yg9b3LqHZlY1kaX2nClMKIkdJ37XMCRvxkAyZ
X-Google-Smtp-Source: ABdhPJzc/vHboxd2/GoCtVE94V6/8QMQiLfKYwT0IDKiIewPQVCIhOlkOzFNrZ9/NIRYlVx8WYOZWXl8jP4yuKIEGX7d0TxHPPcs
MIME-Version: 1.0
X-Received: by 2002:a6b:db01:: with SMTP id t1mr2348276ioc.83.1613981129340;
 Mon, 22 Feb 2021 00:05:29 -0800 (PST)
Date:   Mon, 22 Feb 2021 00:05:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e37c9805bbe843c1@google.com>
Subject: UBSAN: shift-out-of-bounds in nl802154_new_interface
From:   syzbot <syzbot+7bf7b22759195c9a21e9@syzkaller.appspotmail.com>
To:     alex.aring@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org, stefan@datenfreihafen.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3af409ca net: enetc: fix destroyed phylink dereference dur..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=139da604d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cb23303ddb9411f
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf7b22759195c9a21e9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108c7e04d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1177c324d00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11a6e7d2d00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13a6e7d2d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15a6e7d2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bf7b22759195c9a21e9@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in net/ieee802154/nl802154.c:914:44
shift exponent -1627389953 is negative
CPU: 0 PID: 8454 Comm: syz-executor539 Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
 nl802154_new_interface.cold+0x19/0x1e net/ieee802154/nl802154.c:914
 genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:739
 genl_family_rcv_msg net/netlink/genetlink.c:783 [inline]
 genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:800
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2494
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:811
 netlink_unicast_kernel net/netlink/af_netlink.c:1304 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1330
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1919
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2345
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2399
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2432
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43fa19
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffda15b8b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 000000000043fa19
RDX: 0000000000000000 RSI: 0000000020000ac0 RDI: 0000000000000003
RBP: 0000000000403480 R08: 0000000000000001 R09: 00000000004004a0
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000403510
R13: 0000000000000000 R14: 00000000004ad018 R15: 00000000004004a0
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
