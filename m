Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF6B3B0D66
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhFVTGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 15:06:45 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:57261 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFVTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:06:39 -0400
Received: by mail-il1-f197.google.com with SMTP id k12-20020a056e021a8cb02901ee3943c474so129523ilv.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 12:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6B09qJitkXkrlV9UF7bw3/haDx6V0dIWg9bl/gymHkQ=;
        b=fbeb1lYtIGwXmQ21oBUfc5sIuFBD0DH3RqmxVHmVCfBmXt0V9GjQE4KHRyxMYemVxB
         jP4heG298Snoi131ZybzITRevDCij4L2MkkjXxIMTwPpIEubxh78wBCN9tnri/7aVJm9
         JgPU4e38/svWTbxhNlPP5YItT+aDJJ5XIjeH+9KOeFBYzhjwGSroRWpmITIX/2tvKvnT
         dSk/OlLdOiwqxOdL+kxS2KJk97YNXDkKsFnz4QPq0+x+APTCKVZDOkGc0+kcO3D5d/32
         OtOMR1QyiXPPNE95qG/Urz+Kv1zs/cAUAzZFWnBTLkcRDi+DjZfnVd2mMaY4oadnufRe
         LcqA==
X-Gm-Message-State: AOAM5328+cYHWVBOO4H6sPVJcHpmF2kpWVaomRnVuP6ezXkd04iJDUwT
        fSpBiU8u4GoSOD885Ti0IHpCvv/MAYoSdkA1aUaEZXhJ0NJw
X-Google-Smtp-Source: ABdhPJwagUwNCj6dRRbO01rg3t0ZYcnjYGBczXB5pvJtQxgqGGTZKzlIrntYlr9AEnbaqBUMM7rBko/SaprySMxbgH/AyhoUt8Z5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:511:: with SMTP id d17mr103157ils.277.1624388663182;
 Tue, 22 Jun 2021 12:04:23 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:04:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f0bbd05c55f7511@google.com>
Subject: [syzbot] memory leak in xfrm_user_rcv_msg
From:   syzbot <syzbot+fb347cf82c73a90efcca@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fd0aa1a4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17464aa4300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ec2526c74098317
dashboard link: https://syzkaller.appspot.com/bug?extid=fb347cf82c73a90efcca
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14946548300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d28548300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb347cf82c73a90efcca@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810f402d00 (size 232):
  comm "syz-executor486", pid 8416, jiffies 4294943639 (age 13.060s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff836a0d5f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:413
    [<ffffffff83ad5686>] alloc_skb include/linux/skbuff.h:1107 [inline]
    [<ffffffff83ad5686>] xfrm_alloc_compat+0x1d6/0x6d0 net/xfrm/xfrm_compat.c:324
    [<ffffffff83ad2b4c>] xfrm_alloc_userspi+0x29c/0x3f0 net/xfrm/xfrm_user.c:1448
    [<ffffffff83ace7f8>] xfrm_user_rcv_msg+0x208/0x3e0 net/xfrm/xfrm_user.c:2812
    [<ffffffff838233d7>] netlink_rcv_skb+0x87/0x1d0 net/netlink/af_netlink.c:2504
    [<ffffffff83acc9e2>] xfrm_netlink_rcv+0x32/0x40 net/xfrm/xfrm_user.c:2824
    [<ffffffff838225c2>] netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
    [<ffffffff838225c2>] netlink_unicast+0x392/0x4c0 net/netlink/af_netlink.c:1340
    [<ffffffff83822a58>] netlink_sendmsg+0x368/0x6a0 net/netlink/af_netlink.c:1929
    [<ffffffff836908a6>] sock_sendmsg_nosec net/socket.c:654 [inline]
    [<ffffffff836908a6>] sock_sendmsg+0x56/0x80 net/socket.c:674
    [<ffffffff83696c6f>] sock_no_sendpage+0x8f/0xc0 net/core/sock.c:2862
    [<ffffffff836901ab>] kernel_sendpage.part.0+0xeb/0x150 net/socket.c:3631
    [<ffffffff83690e8b>] kernel_sendpage net/socket.c:3628 [inline]
    [<ffffffff83690e8b>] sock_sendpage+0x5b/0x90 net/socket.c:947
    [<ffffffff815b8872>] pipe_to_sendpage+0xa2/0x110 fs/splice.c:364
    [<ffffffff815ba712>] splice_from_pipe_feed fs/splice.c:418 [inline]
    [<ffffffff815ba712>] __splice_from_pipe+0x1e2/0x330 fs/splice.c:562
    [<ffffffff815baf3f>] splice_from_pipe fs/splice.c:597 [inline]
    [<ffffffff815baf3f>] generic_splice_sendpage+0x6f/0xa0 fs/splice.c:746
    [<ffffffff815b892b>] do_splice_from fs/splice.c:767 [inline]
    [<ffffffff815b892b>] direct_splice_actor+0x4b/0x70 fs/splice.c:936



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
