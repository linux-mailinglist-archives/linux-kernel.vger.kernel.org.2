Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8993D3CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 17:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhGWPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:14:55 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40713 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbhGWPOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:14:51 -0400
Received: by mail-io1-f69.google.com with SMTP id q137-20020a6b8e8f0000b02904bd1794d00eso2015448iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 08:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jrEVoI183Kmw64l8qy1wZKHXIRYmyIqbXtBbkwNlUZY=;
        b=UHLdDSzlX2D5lRTlK0Op9PDmWV5M6m5oL57ytv3PGQGKx6TEcbB/BpyrrFCg7EyQPA
         d68e9acglTC7lQNR2BReL3aPc4ZbFdUyAT8PFmvWNF16N5js7KHOHzWAJ1ONidCP1bZP
         iMhX6zMKuEYNsP5aOGsbXaZUf4OfiPeT9UzqdzhifH9YBxdW0mNQ099wSOeti+8tPRJh
         lrboKqXXtBFdkWZ916wNWFpuCBeSPPBmyzxPNTD5oNDIQ2QuJgP3K0/Oesfn7CedWRpy
         W8tcBD9qLouQfcCyPswj8hJBqTbKGRop+LKKXY6u+NaVyc+ZRmwbTtLnqSKRg9nqXpIR
         yC8Q==
X-Gm-Message-State: AOAM531Joub9freD9IgAPOc2s6z6ce10OJ+6eQVRm9F/Ezixr/o0ZX2r
        v1r5uW4zrMMDVmBgVKP62QT6xq+0kIECcDVBtu0WakdIfPkQ
X-Google-Smtp-Source: ABdhPJymrKiMmzSlvulLG5/vb/egL5Os45wshW6Wj0yEXXxrLSIF25GxB2eY1uphmCT3VKL5XqftjR/PRS8uLkhbrBIE4xyG1JRq
MIME-Version: 1.0
X-Received: by 2002:a5e:8619:: with SMTP id z25mr4488495ioj.13.1627055723368;
 Fri, 23 Jul 2021 08:55:23 -0700 (PDT)
Date:   Fri, 23 Jul 2021 08:55:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bd5e505c7cc6ec3@google.com>
Subject: [syzbot] memory leak in can_create
From:   syzbot <syzbot+ba3c733fb22a7be2ce04@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2734d6c1b1a0 Linux 5.14-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121ee3f2300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7384ed231a0fd986
dashboard link: https://syzkaller.appspot.com/bug?extid=ba3c733fb22a7be2ce04
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1200c812300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1608525a300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba3c733fb22a7be2ce04@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff8881140ffc00 (size 1024):
  comm "syz-executor060", pid 8644, jiffies 4294942938 (age 13.010s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    1d 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
  backtrace:
    [<ffffffff836d5d92>] kmalloc include/linux/slab.h:596 [inline]
    [<ffffffff836d5d92>] sk_prot_alloc+0xd2/0x1b0 net/core/sock.c:1808
    [<ffffffff836da5a0>] sk_alloc+0x30/0x3f0 net/core/sock.c:1861
    [<ffffffff83c8fd18>] can_create+0x108/0x300 net/can/af_can.c:158
    [<ffffffff836ce96b>] __sock_create+0x1ab/0x2b0 net/socket.c:1450
    [<ffffffff836d198f>] sock_create net/socket.c:1501 [inline]
    [<ffffffff836d198f>] __sys_socket+0x6f/0x140 net/socket.c:1543
    [<ffffffff836d1a7a>] __do_sys_socket net/socket.c:1552 [inline]
    [<ffffffff836d1a7a>] __se_sys_socket net/socket.c:1550 [inline]
    [<ffffffff836d1a7a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1550
    [<ffffffff843b0915>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843b0915>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff8881170d2340 (size 32):
  comm "syz-executor060", pid 8644, jiffies 4294942938 (age 13.010s)
  hex dump (first 32 bytes):
    b0 02 05 40 81 88 ff ff 00 00 00 00 00 00 00 00  ...@............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff82167ee3>] kmalloc include/linux/slab.h:591 [inline]
    [<ffffffff82167ee3>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82167ee3>] apparmor_sk_alloc_security+0x53/0xd0 security/apparmor/lsm.c:785
    [<ffffffff8212d441>] security_sk_alloc+0x31/0x70 security/security.c:2261
    [<ffffffff836d5dad>] sk_prot_alloc+0xed/0x1b0 net/core/sock.c:1811
    [<ffffffff836da5a0>] sk_alloc+0x30/0x3f0 net/core/sock.c:1861
    [<ffffffff83c8fd18>] can_create+0x108/0x300 net/can/af_can.c:158
    [<ffffffff836ce96b>] __sock_create+0x1ab/0x2b0 net/socket.c:1450
    [<ffffffff836d198f>] sock_create net/socket.c:1501 [inline]
    [<ffffffff836d198f>] __sys_socket+0x6f/0x140 net/socket.c:1543
    [<ffffffff836d1a7a>] __do_sys_socket net/socket.c:1552 [inline]
    [<ffffffff836d1a7a>] __se_sys_socket net/socket.c:1550 [inline]
    [<ffffffff836d1a7a>] __x64_sys_socket+0x1a/0x20 net/socket.c:1550
    [<ffffffff843b0915>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843b0915>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811344a100 (size 232):
  comm "syz-executor060", pid 8644, jiffies 4294942938 (age 13.010s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 2c 10 81 88 ff ff 00 fc 0f 14 81 88 ff ff  ..,.............
  backtrace:
    [<ffffffff836e0ebf>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff836eb6fa>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff836eb6fa>] alloc_skb_with_frags+0x6a/0x2b0 net/core/skbuff.c:6005
    [<ffffffff836d8fe3>] sock_alloc_send_pskb+0x353/0x3c0 net/core/sock.c:2461
    [<ffffffff83c9ee2f>] j1939_sk_alloc_skb net/can/j1939/socket.c:861 [inline]
    [<ffffffff83c9ee2f>] j1939_sk_send_loop net/can/j1939/socket.c:1043 [inline]
    [<ffffffff83c9ee2f>] j1939_sk_sendmsg+0x2cf/0x800 net/can/j1939/socket.c:1178
    [<ffffffff836cfb86>] sock_sendmsg_nosec net/socket.c:703 [inline]
    [<ffffffff836cfb86>] sock_sendmsg+0x56/0x80 net/socket.c:723
    [<ffffffff836d00ec>] ____sys_sendmsg+0x36c/0x390 net/socket.c:2392
    [<ffffffff836d413b>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2446
    [<ffffffff836d4238>] __sys_sendmsg+0x88/0x100 net/socket.c:2475
    [<ffffffff843b0915>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843b0915>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae

BUG: memory leak
unreferenced object 0xffff88811344aa00 (size 232):
  comm "syz-executor060", pid 8644, jiffies 4294942938 (age 13.010s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 2c 10 81 88 ff ff 00 fc 0f 14 81 88 ff ff  ..,.............
  backtrace:
    [<ffffffff836e0ebf>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff836eb6fa>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff836eb6fa>] alloc_skb_with_frags+0x6a/0x2b0 net/core/skbuff.c:6005
    [<ffffffff836d8fe3>] sock_alloc_send_pskb+0x353/0x3c0 net/core/sock.c:2461
    [<ffffffff83c9ee2f>] j1939_sk_alloc_skb net/can/j1939/socket.c:861 [inline]
    [<ffffffff83c9ee2f>] j1939_sk_send_loop net/can/j1939/socket.c:1043 [inline]
    [<ffffffff83c9ee2f>] j1939_sk_sendmsg+0x2cf/0x800 net/can/j1939/socket.c:1178
    [<ffffffff836cfb86>] sock_sendmsg_nosec net/socket.c:703 [inline]
    [<ffffffff836cfb86>] sock_sendmsg+0x56/0x80 net/socket.c:723
    [<ffffffff836d00ec>] ____sys_sendmsg+0x36c/0x390 net/socket.c:2392
    [<ffffffff836d413b>] ___sys_sendmsg+0x8b/0xd0 net/socket.c:2446
    [<ffffffff836d4238>] __sys_sendmsg+0x88/0x100 net/socket.c:2475
    [<ffffffff843b0915>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff843b0915>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84400068>] entry_SYSCALL_64_after_hwframe+0x44/0xae



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
