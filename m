Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820A43894B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhESRgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:36:43 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48100 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhESRgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:36:41 -0400
Received: by mail-io1-f71.google.com with SMTP id s188-20020a6b2cc50000b0290456cc0f2184so1144351ios.14
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UZHccjix8oNmHRhg4MY5ztlGF7uJvQZGhEY/WEJTmWA=;
        b=rp/X4okRQs0jzgugHP2Ad5UN5EzNQumFT+oXMn6EkzPbOWmhkukYPdJynRtu/BJ8z0
         DduoWK8BLRChEBzZVusoZpvU0PUVcToRukKc7hF/Olkm+785+TmgWLqOoIFScjjvASV0
         1z86iZIGsTaC4AIpcCB/OUUBRZ2uRwHoPy0ZKfFrGLnG3YTFIywfx6D/7fHiQJx6zMIQ
         UHLBBCfX0+5fxhtMS3UkYcD2kHsfI1qDsHFRfmKg8LgDtlYaC4Gt5NYc8WyH7saXRHrE
         tXlujcf9kprA2XVVPZ6FZvbSVXwe0zW/1BFgW/abuOUYeKc9IN+08i4ETiQQPAx8AMH7
         XXdQ==
X-Gm-Message-State: AOAM530If6M8A+nqlQ0KaupgVxmdmAlaE88oAlUuNz7HT5pfahJ7HKKT
        b6TfEUB9pXLyP6IJH4jEN8MFYHoJ0WPrGc31vSzu6DxxZvMB
X-Google-Smtp-Source: ABdhPJx8nIme+6MkuMdV8XSTC3jU4BYJoZreomahlwSDgpBYdZiJB6DjldurwWK0/dGzPp+ku2sAA7L0X+o4m/XAC4FtRnQ5BbQt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c5:: with SMTP id r5mr130961ilq.48.1621445720834;
 Wed, 19 May 2021 10:35:20 -0700 (PDT)
Date:   Wed, 19 May 2021 10:35:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003687bd05c2b2401d@google.com>
Subject: [syzbot] BUG: MAX_LOCKDEP_KEYS too low! (2)
From:   syzbot <syzbot+a70a6358abd2c3f9550f@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b81ac784 net: cdc_eem: fix URL to CDC EEM 1.0 spec
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15a257c3d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b86a12e0d1933b5
dashboard link: https://syzkaller.appspot.com/bug?extid=a70a6358abd2c3f9550f

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a70a6358abd2c3f9550f@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_KEYS too low!
turning off the locking correctness validator.
CPU: 0 PID: 5917 Comm: syz-executor.4 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 register_lock_class.cold+0x14/0x19 kernel/locking/lockdep.c:1281
 __lock_acquire+0x102/0x5230 kernel/locking/lockdep.c:4781
 lock_acquire kernel/locking/lockdep.c:5512 [inline]
 lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
 flush_workqueue+0x110/0x13e0 kernel/workqueue.c:2786
 drain_workqueue+0x1a5/0x3c0 kernel/workqueue.c:2951
 destroy_workqueue+0x71/0x800 kernel/workqueue.c:4382
 alloc_workqueue+0xc40/0xef0 kernel/workqueue.c:4343
 wg_newlink+0x43d/0x9e0 drivers/net/wireguard/device.c:335
 __rtnl_newlink+0x1062/0x1710 net/core/rtnetlink.c:3452
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3500
 rtnetlink_rcv_msg+0x44e/0xad0 net/core/rtnetlink.c:5562
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2502
 netlink_unicast_kernel net/netlink/af_netlink.c:1312 [inline]
 netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1338
 netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1927
 sock_sendmsg_nosec net/socket.c:654 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:674
 ____sys_sendmsg+0x6e8/0x810 net/socket.c:2350
 ___sys_sendmsg+0xf3/0x170 net/socket.c:2404
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2433
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb25febe188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000056c0b0 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c0b0
R13: 00007fff30a5021f R14: 00007fb25febe300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
