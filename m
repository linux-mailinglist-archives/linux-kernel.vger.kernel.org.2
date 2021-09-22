Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3345D413E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 02:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhIVAPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 20:15:01 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:41906 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhIVAO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 20:14:58 -0400
Received: by mail-il1-f198.google.com with SMTP id c5-20020a92c785000000b0023471480cafso890403ilk.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 17:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=36Y4nAKN32n1w9NWTI9hpGFl6g88aixbRegqHcy5Ivk=;
        b=PJW/F5BEAJl5Cb306M63QoGJseenzkHj2McgYReLS4XGNVju7G8jM/O+/onJHzhf/0
         EEoRtunCNb8KJtRWncfOgfvjegh9nITKzeewUS6zaJtBtsyadsPODmwn1mLUyMuJ93rD
         s7KlSE8MgtD9Kky2eYxS638ptldPE2eIVClN0STNDqYVgNh0kte+Bum6kukZg6ier+9d
         h6SLA+tIw5+oVnnM/L7axrvKMwqKvN9MiQfZ9RVUwLkJxAmIp5pfH++RKHjzsweEw7b+
         2yzbqQdWCFU5PMdwoUtVWlGCILPSlgQMe8dWYSU62gT2HiG+CCDCytFEI7XGwP6x5D6s
         QpmA==
X-Gm-Message-State: AOAM5325Qosjm/KqmO4tspfHhQIbXyZE3+iTqCNYZnpn9Ks0kBnxqvha
        o7HlJhC3FtH2+C+g8Cq3KiNDp7Yf56EisA3vpa6yjKOatdbk
X-Google-Smtp-Source: ABdhPJzbez2ug3iTghF3AFgg4gvHcU3Mu9uYitHwwJPYKDFWRzqEVzwML2sHZaUBudS1cMXwYIldB8bxesS4TA+2GpU1pGP+V1TX
MIME-Version: 1.0
X-Received: by 2002:a5e:a609:: with SMTP id q9mr2151666ioi.23.1632269608757;
 Tue, 21 Sep 2021 17:13:28 -0700 (PDT)
Date:   Tue, 21 Sep 2021 17:13:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003533d205cc8a624b@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in xfrm_set_default
From:   syzbot <syzbot+3d9866419b4aa8f985d6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1f77990c4b79 Add linux-next specific files for 20210920
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1581be9b300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab1346371f2e6884
dashboard link: https://syzkaller.appspot.com/bug?extid=3d9866419b4aa8f985d6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13122c4b300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c511f3300000

The issue was bisected to:

commit 88d0adb5f13b1c52fbb7d755f6f79db18c2f0c2c
Author: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date:   Tue Sep 14 14:46:34 2021 +0000

    xfrm: notify default policy on update

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1075f527300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1275f527300000
console output: https://syzkaller.appspot.com/x/log.txt?x=1475f527300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d9866419b4aa8f985d6@syzkaller.appspotmail.com
Fixes: 88d0adb5f13b ("xfrm: notify default policy on update")

=============================
WARNING: suspicious RCU usage
5.15.0-rc2-next-20210920-syzkaller #0 Not tainted
-----------------------------
net/xfrm/xfrm_user.c:1157 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor917/6560:
 #0: ffffffff8d0d4818 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{3:3}, at: xfrm_netlink_rcv+0x5c/0x90 net/xfrm/xfrm_user.c:2928

stack backtrace:
CPU: 0 PID: 6560 Comm: syz-executor917 Not tainted 5.15.0-rc2-next-20210920-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 xfrm_nlmsg_multicast net/xfrm/xfrm_user.c:1157 [inline]
 xfrm_notify_userpolicy net/xfrm/xfrm_user.c:1991 [inline]
 xfrm_set_default+0x789/0x8b0 net/xfrm/xfrm_user.c:2017
 xfrm_user_rcv_msg+0x430/0xa20 net/xfrm/xfrm_user.c:2907
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 xfrm_netlink_rcv+0x6b/0x90 net/xfrm/xfrm_user.c:2929
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe115dcd079
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffedbf3ee68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe115dcd079
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007fe115d91060 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe115d910f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
unsupported nlmsg_t


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
