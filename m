Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD84169BF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243880AbhIXCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:00:03 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:35517 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243848AbhIXB76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:59:58 -0400
Received: by mail-il1-f199.google.com with SMTP id f4-20020a056e0204c400b0022dbd3f8b18so7967677ils.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 18:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TsotylzfZ4kF4vvNWaiSjvWOLTgdeqLefI9Wml5Hx/Q=;
        b=ZNPmnoy1XoZp/00kVOFnaWKUCgvrOhZ4xk4maw99pK6coeWTevd62vSgsIxEWPudmP
         PBT+eqRtSuG2gSzErCYe0BAGLqYFoOrVw7nCkvw0hxWsAvEhBJEkCHJYZUSRsanOEDKk
         0xHZgmuwXOHNC0uaomjkLt5uM/TTlXpQopGOAqwL6iVgPm/NXNxHH+XWMNaLW7R6xBdV
         8QlLt2M39s7GDUHCg+J87I24u7k3EvZmM6fbcKpgPae2QnTAaJUXKmGY+H9F0MnM2oYo
         0/90pEhJ4ZVFCz8eVrbMfEvklWT9wqnfs1NU+lSRVw3HAqaXnGEZAHsjKD+W8Peqqif8
         pCwg==
X-Gm-Message-State: AOAM532LKXr+IKWCRIL/AyIVfWWP4S6tSYdaCVzXir9cB0k7GONdX9me
        LSWOLo9Oa06fFShgiE8CnRabEV/KOFvUqTfqYnTctwrJ9Ywn
X-Google-Smtp-Source: ABdhPJzJIXaySQWzFZzgDD7O9/7f3/H7x74KQr/lvK9SKbKnfmRllnN7R6YVpJVvNEKJ5dab38hRVxQqVLRwR9ntEyRb+G0bJ9Nt
MIME-Version: 1.0
X-Received: by 2002:a6b:5d10:: with SMTP id r16mr6564779iob.148.1632448705742;
 Thu, 23 Sep 2021 18:58:25 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000384c7f05ccb415b0@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in qfq_update_agg (3)
From:   syzbot <syzbot+ed284664846fc47b6300@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b3f98404bd62 Merge branch 'dsa-devres'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17838dab300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=ed284664846fc47b6300
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed284664846fc47b6300@syzkaller.appspotmail.com

netlink: 52 bytes leftover after parsing attributes in process `syz-executor.1'.
================================================================================
UBSAN: array-index-out-of-bounds in net/sched/sch_qfq.c:300:24
index 29 is out of range for type 'qfq_group [25]'
CPU: 1 PID: 2911 Comm: syz-executor.1 Not tainted 5.15.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:291
 qfq_update_agg+0x6e6/0x700 net/sched/sch_qfq.c:300
 qfq_add_to_agg+0x75/0x500 net/sched/sch_qfq.c:317
 qfq_change_class+0x6f0/0x17a0 net/sched/sch_qfq.c:507
 tc_ctl_tclass+0x52f/0xe60 net/sched/sch_api.c:2107
 rtnetlink_rcv_msg+0x413/0xb80 net/core/rtnetlink.c:5572
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2409
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2463
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2492
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fc9a0bdb739
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc99e110188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc9a0ce00f0 RCX: 00007fc9a0bdb739
RDX: 0000000000000000 RSI: 0000000020000380 RDI: 0000000000000004
RBP: 00007fc9a0c35cc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc9a0ce00f0
R13: 00007ffed233187f R14: 00007fc99e110300 R15: 0000000000022000
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
