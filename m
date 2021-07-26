Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055103D50C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 02:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhGYXs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 19:48:56 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:55205 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGYXsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 19:48:55 -0400
Received: by mail-il1-f197.google.com with SMTP id m11-20020a92870b0000b0290210d3ffca31so3724043ild.21
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 17:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HapdQG+zthiUobnTEPfoSW7q18/Z9dQsVC64iOywMdA=;
        b=AzBgS0IN8d+N/FkEwvHal5VIkfSWAnN88q4+YlKq3MJJhVo62GU2G2D+y53lO0MmHK
         qs6wMQ/zkE6diy0AswUCRL62aIO4gaSwsbRnC3WHFFQ18R9OXVye52QdhzOf++QP+2EC
         XOK1BrEJP1OB58ZSADLevfZyJoIAyM8rGWdFFNxLMqrXuXSSAjk3j30G2WGp8Kbgwn+x
         bCojhp+vUKO1rIq5MJpXjbTEODQkycf1aVinlhXTfDIVq67Fw6aiJyx8MfsfRPyDDIX4
         Tj6D2iij5IslNFBo06BWANkNvOkrUyy1LlN1o/rTANA6cxsVsHwi+lwdtrnI5cYJuk+y
         WLuQ==
X-Gm-Message-State: AOAM5311/VFNoDN45h75S58x6mwi2sPN0ZaPT0IbCBQYMmv1IPCBv5Cu
        sh160+7hawD/l/nE26uuPNUqImpbZ+/iYS3P+QLt3lscCRr4
X-Google-Smtp-Source: ABdhPJyqtMwGONMKqD+rbwimGb8oQ7FhM2dITv7cjmxMdCRixFhMcEI9Qbt5LH9BVyIrelsrDGRJZI74jFJ9UTROg6CMDpw/B8PV
MIME-Version: 1.0
X-Received: by 2002:a92:d8c5:: with SMTP id l5mr11190835ilo.79.1627259365167;
 Sun, 25 Jul 2021 17:29:25 -0700 (PDT)
Date:   Sun, 25 Jul 2021 17:29:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b15c805c7fbd885@google.com>
Subject: [syzbot] memory leak in mld_newpack
From:   syzbot <syzbot+dcd3e13cf4472f2e0ba1@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8cae8cd89f05 seq_file: disallow extremely large seq buffer..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1100e00a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7384ed231a0fd986
dashboard link: https://syzkaller.appspot.com/bug?extid=dcd3e13cf4472f2e0ba1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c646a2300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcd3e13cf4472f2e0ba1@syzkaller.appspotmail.com

2021/07/22 00:14:37 executed programs: 3
2021/07/22 00:14:42 executed programs: 5
2021/07/22 00:14:48 executed programs: 7
BUG: memory leak
unreferenced object 0xffff88810df2ad00 (size 232):
  comm "kworker/1:2", pid 2838, jiffies 4294938475 (age 902.280s)
  hex dump (first 32 bytes):
    a0 34 1f 19 81 88 ff ff a0 34 1f 19 81 88 ff ff  .4.......4......
    00 40 1c 10 81 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace:
    [<ffffffff836e0f5f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff836eb79a>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff836eb79a>] alloc_skb_with_frags+0x6a/0x2b0 net/core/skbuff.c:6005
    [<ffffffff836d9083>] sock_alloc_send_pskb+0x353/0x3c0 net/core/sock.c:2461
    [<ffffffff83b7fd64>] mld_newpack+0x84/0x200 net/ipv6/mcast.c:1751
    [<ffffffff83b7ff83>] add_grhead+0xa3/0xc0 net/ipv6/mcast.c:1854
    [<ffffffff83b80c26>] add_grec+0x7b6/0x820 net/ipv6/mcast.c:1992
    [<ffffffff83b830d3>] mld_send_cr net/ipv6/mcast.c:2118 [inline]
    [<ffffffff83b830d3>] mld_ifc_work+0x273/0x750 net/ipv6/mcast.c:2655
    [<ffffffff81262669>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81262f59>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126c3b8>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

BUG: memory leak
unreferenced object 0xffff88811109ca00 (size 232):
  comm "kworker/1:2", pid 2838, jiffies 4294938656 (age 900.470s)
  hex dump (first 32 bytes):
    a0 ac 9e 16 81 88 ff ff a0 ac 9e 16 81 88 ff ff  ................
    00 00 37 13 81 88 ff ff 00 00 00 00 00 00 00 00  ..7.............
  backtrace:
    [<ffffffff836e0f5f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:414
    [<ffffffff83b6bb36>] alloc_skb include/linux/skbuff.h:1112 [inline]
    [<ffffffff83b6bb36>] ndisc_alloc_skb+0x56/0xe0 net/ipv6/ndisc.c:420
    [<ffffffff83b7085c>] ndisc_send_rs+0x1bc/0x2a0 net/ipv6/ndisc.c:686
    [<ffffffff83b46bae>] addrconf_dad_completed+0x17e/0x560 net/ipv6/addrconf.c:4195
    [<ffffffff83b4736d>] addrconf_dad_work+0x3dd/0x900 net/ipv6/addrconf.c:4105
    [<ffffffff81262669>] process_one_work+0x2c9/0x610 kernel/workqueue.c:2276
    [<ffffffff81262f59>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2422
    [<ffffffff8126c3b8>] kthread+0x188/0x1d0 kernel/kthread.c:319
    [<ffffffff810022cf>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
