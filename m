Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5345837C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 13:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbhKUMwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 07:52:30 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:36691 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbhKUMwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 07:52:30 -0500
Received: by mail-il1-f200.google.com with SMTP id i10-20020a056e02152a00b00293be3da5c0so7682272ilu.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 04:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iB6Fss+wDuhQjrFvZzxbPmya635R61SJlT+nAZoDV6A=;
        b=a/kYVceH1NBIWOli+EHg27dsCnEZBzw3OYu6piBL45iITRI3/c7921RaqFnynU6m+M
         YLZGpr/yyTH+2dGUN6BdhBgUz2ReIVlozXNZIFlf/uHgpykrK46N8+/HTGn/svRvVAKI
         0wBBFN5hQpS+Kn1kU4krZf4GVdX2UEJlXoSFA+EA15SqiQrvUZcTyY/VAvx3rl3twE5n
         6Q2+WQQBm9pzFOp/oMKAqb4s+pyv5v0clJXGWCI98lQbLgZxTEhMyIYfvaNN0Bvhod/h
         YmdxjDNoEaWqGIAraEpsH8vZdsuIOU6QD6MgmdhiudT4SMBE5+vwi5Aik32l9lT+cPSa
         XABw==
X-Gm-Message-State: AOAM530/Q1DMogvVg/RxuD+2NCrO52Q3BgNNpo1yoEdxdju+IhXv+L1R
        clt4MxH9bfgSnsICjYUbivLi8zBOKFYmJptuSJr4kLJXo6lL
X-Google-Smtp-Source: ABdhPJy18tz2twPcODTi1gsQY7KZP9HLhOSTPP31FgmKWvbYH9tHcVKFcNZoYFqICDI6eTpIohV4dRSi3EU7xMZBz3lrph9HZrJs
MIME-Version: 1.0
X-Received: by 2002:a02:6666:: with SMTP id l38mr39485790jaf.146.1637498965047;
 Sun, 21 Nov 2021 04:49:25 -0800 (PST)
Date:   Sun, 21 Nov 2021 04:49:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021bb9b05d14bf0c7@google.com>
Subject: [syzbot] WARNING in page_counter_cancel (3)
From:   syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1483f0e9b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7264d1cb8ba2795
dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com

------------[ cut here ]------------
page_counter underflow: -4294964789 nr_pages=4294967295
WARNING: CPU: 2 PID: 3785 at mm/page_counter.c:56 page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56
Modules linked in:
CPU: 2 PID: 3785 Comm: kworker/2:6 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events mptcp_worker

RIP: 0010:page_counter_cancel+0xcf/0xe0 mm/page_counter.c:56
Code: c7 04 24 00 00 00 00 45 31 f6 eb 97 e8 2a 2b b5 ff 4c 89 ea 48 89 ee 48 c7 c7 00 9e b8 89 c6 05 a0 c1 ba 0b 01 e8 95 e4 4b 07 <0f> 0b eb a8 4c 89 e7 e8 25 5a fb ff eb c7 0f 1f 00 41 56 41 55 49
RSP: 0018:ffffc90002d4f918 EFLAGS: 00010082

RAX: 0000000000000000 RBX: ffff88806a494120 RCX: 0000000000000000
RDX: ffff8880688c41c0 RSI: ffffffff815e8f28 RDI: fffff520005a9f15
RBP: ffffffff000009cb R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815e2cfe R11: 0000000000000000 R12: ffff88806a494120
R13: 00000000ffffffff R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2de21000 CR3: 000000005ad59000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_counter_uncharge+0x2e/0x60 mm/page_counter.c:160
 drain_stock+0xc1/0x180 mm/memcontrol.c:2219
 refill_stock+0x139/0x2f0 mm/memcontrol.c:2271
 __sk_mem_reduce_allocated+0x24d/0x550 net/core/sock.c:2945
 __mptcp_rmem_reclaim net/mptcp/protocol.c:167 [inline]
 __mptcp_mem_reclaim_partial+0x124/0x410 net/mptcp/protocol.c:975
 mptcp_mem_reclaim_partial net/mptcp/protocol.c:982 [inline]
 mptcp_alloc_tx_skb net/mptcp/protocol.c:1212 [inline]
 mptcp_sendmsg_frag+0x18c6/0x2190 net/mptcp/protocol.c:1279
 __mptcp_push_pending+0x232/0x720 net/mptcp/protocol.c:1545
 mptcp_release_cb+0xfe/0x200 net/mptcp/protocol.c:2975
 release_sock+0xb4/0x1b0 net/core/sock.c:3306
 mptcp_worker+0x51e/0xc10 net/mptcp/protocol.c:2443
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
