Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7E31D977
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhBQMcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:32:09 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:45664 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbhBQMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:32:00 -0500
Received: by mail-il1-f200.google.com with SMTP id h17so10192374ila.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 04:31:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bYBex3tvallKPBA4b+9Dc5CLb5q4r+rVWyRqw6fbV5Y=;
        b=tnjqBE7W15HLpXEgwU5m0ypTuAd3O4MgFLxB4RvswaHNr8d1vdTlH89H+GLDFNtlBN
         AKz/cOq6meQfwLPO3mlwxjPSnNGdveu4gaC02frN9uzSA0hfM0P3aNmzyrK6uUi6DzPW
         qFyeLE3VTU8tEo7d+rXjNQBIPWeimMjQrsKDOQjFar8NOhxJnO/P0CQO7f4HXcuTY60C
         EfLaWr2n5DSDAaST9PfNwElZi4BvtNDaH3PzZmv65uG1UcicYFuiDfAXkL6rXXHDi/OW
         ldpw1OlIdlkWkEXiMZl0IG4w24vfE3Gxio5frtrvJoh4kLvw4VfZSPXOmD8QASDNkEDj
         G8hg==
X-Gm-Message-State: AOAM530G1UGKTyEJwxMEXQ3Oan109+IQ0fgdODFxEp2/g3VHjoIU8V3d
        X2wl4EWX7t56Qmxx0dbn8NGVySix6lnC6LA7bSvLR1QgE+7d
X-Google-Smtp-Source: ABdhPJwjMHw+5l7zXW9AFo41x6Pz6hDvKtoR0txQBF/R2gQK6Mbj0SfslE+VN92r6kp802ENk/K23SFcpVXBUJe9A3kzti/ctie+
MIME-Version: 1.0
X-Received: by 2002:a02:2b2a:: with SMTP id h42mr20967309jaa.44.1613565079407;
 Wed, 17 Feb 2021 04:31:19 -0800 (PST)
Date:   Wed, 17 Feb 2021 04:31:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061508405bb8765e4@google.com>
Subject: general protection fault in nl802154_del_llsec_devkey
From:   syzbot <syzbot+368672e0da240db53b5f@syzkaller.appspotmail.com>
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

HEAD commit:    57baf8cc net: axienet: Handle deferred probe on clock prop..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=11f4b614d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cb23303ddb9411f
dashboard link: https://syzkaller.appspot.com/bug?extid=368672e0da240db53b5f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a18502d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16af6ed2d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+368672e0da240db53b5f@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8442 Comm: syz-executor604 Not tainted 5.11.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:nla_len include/net/netlink.h:1148 [inline]
RIP: 0010:nla_parse_nested_deprecated include/net/netlink.h:1231 [inline]
RIP: 0010:nl802154_del_llsec_devkey+0x165/0x370 net/ieee802154/nl802154.c:1916
Code: 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 c9 01 00 00 48 8b 93 20 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 d1 48 c1 e9 03 <0f> b6 0c 01 48 89 d0 83 e0 07 83 c0 01 38 c8 7c 08 84 c9 0f 85 54
RSP: 0018:ffffc9000734f528 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880183ee400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8889170f RDI: ffff8880183ee520
RBP: 1ffff92000e69ea6 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff87315ffa R11: 0000000000000000 R12: ffff888144394000
R13: ffff88801bd80bd0 R14: ffffc9000734f8b0 R15: 0000000000000000
FS:  0000000001a44300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000408 CR3: 0000000013300000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
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
RIP: 0033:0x43f8a9
Code: 28 c3 e8 5a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb69f7518 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 000000000043f8a9
RDX: 0000000024000044 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 0000000000403310 R08: 00000000004004a0 R09: 00000000004004a0
R10: 0000000000000006 R11: 0000000000000246 R12: 00000000004033a0
R13: 0000000000000000 R14: 00000000004ad018 R15: 00000000004004a0
Modules linked in:
---[ end trace f6610dc4e783dd3a ]---
RIP: 0010:nla_len include/net/netlink.h:1148 [inline]
RIP: 0010:nla_parse_nested_deprecated include/net/netlink.h:1231 [inline]
RIP: 0010:nl802154_del_llsec_devkey+0x165/0x370 net/ieee802154/nl802154.c:1916
Code: 00 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 c9 01 00 00 48 8b 93 20 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 d1 48 c1 e9 03 <0f> b6 0c 01 48 89 d0 83 e0 07 83 c0 01 38 c8 7c 08 84 c9 0f 85 54
RSP: 0018:ffffc9000734f528 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff8880183ee400 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8889170f RDI: ffff8880183ee520
RBP: 1ffff92000e69ea6 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff87315ffa R11: 0000000000000000 R12: ffff888144394000
R13: ffff88801bd80bd0 R14: ffffc9000734f8b0 R15: 0000000000000000
FS:  0000000001a44300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f236003e108 CR3: 0000000013300000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
