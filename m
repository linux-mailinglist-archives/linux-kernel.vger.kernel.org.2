Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D758F450207
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbhKOKMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 05:12:21 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:39429 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbhKOKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:12:17 -0500
Received: by mail-il1-f198.google.com with SMTP id n15-20020a056e021baf00b0026ac65da316so10223516ili.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/ir1ALrM/rqWXZAvCOSmN5qXw1nT/a9uTB/a3thjY2A=;
        b=CjYb0YG3m0dkiij7pgizw8ZYXPFGVSV+MSIXBod5hChdQOOpGVHwAasj2S9SAJpJzo
         kOjwX+klWnX6KVuEYeHLF5O3mJ79xzeHLXe6DTu5PRwwuqB4V9oDulvQ3sWIqBrn5SaZ
         E4L18G5ZISvZaM0izDrJM85VR1Oxpe4oBFbb+AfKM3NzWQhQAFs9X6lyG0+ApFNGXPdw
         8kqqk6+Z+xeFqXlLTI9KCFNw1RDvseXUOqU3kCmrKoXJexeCkvtVob3h0VtmqcOcJdZ3
         h8EwdkYvQk+vUKQna0eEsdbwdbyvjQ6AgBsFgtMcfsJ2/PSeyV51zwRzeIZJ7T3Y96Tk
         2Y4w==
X-Gm-Message-State: AOAM532IfUbVqUzCKaNzisnL4KabapEtRkENbOpqpW4Kq5K9KcA6fPRL
        cvlvp5FYesqyR6NnFTlwPl5wfIQQB9WY4KZn8p4tKz6rX5Zn
X-Google-Smtp-Source: ABdhPJzXnp8UEIHVG8Wrv6UMfJvuzJ3CFIgQTYdXfLRYnrWGC+3zKh2daMx38Asnh7zOsDoK7aPPYl16j5aYvr4iox9cNlAC05dc
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1603:: with SMTP id x3mr24460091iow.83.1636970962451;
 Mon, 15 Nov 2021 02:09:22 -0800 (PST)
Date:   Mon, 15 Nov 2021 02:09:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9847805d0d100b1@google.com>
Subject: [syzbot] general protection fault in rxrpc_unbundle_conn
From:   syzbot <syzbot+078e7e5466f101cd2ba6@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, kuba@kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        marc.dionne@auristor.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ccfff0a2bd2a Merge tag 'virtio-mem-for-5.16' of git://gith..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1087de21b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66be9d86baea8a4a
dashboard link: https://syzkaller.appspot.com/bug?extid=078e7e5466f101cd2ba6
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+078e7e5466f101cd2ba6@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 21485 Comm: kworker/1:8 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: krxrpcd rxrpc_local_processor
RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
RIP: 0010:rb_erase+0x615/0xf40 lib/rbtree.c:445
Code: 83 01 00 00 90 48 8d 5d 10 48 89 dd 48 c1 ed 03 42 80 7c 3d 00 00 74 08 48 89 df e8 55 0c 94 fd 4c 8b 2b 4d 89 ee 49 c1 ee 03 <43> 80 3c 3e 00 74 08 4c 89 ef e8 3c 0c 94 fd 41 f6 45 00 01 48 89
RSP: 0018:ffffc90004c4fa50 EFLAGS: 00010246
RAX: 1ffff11002a7c7ae RBX: ffff8880199a6e80 RCX: dffffc0000000000
RDX: ffff88801d7f3a00 RSI: ffff8880899311d0 RDI: ffff88801e52c478
RBP: 1ffff11003334dd0 R08: ffffffff8943b24b R09: 0000000000000003
R10: fffff52000989f45 R11: 0000000000000004 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562128df3158 CR3: 000000006f090000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxrpc_unbundle_conn+0x441/0x5f0 net/rxrpc/conn_client.c:927
 rxrpc_clean_up_local_conns+0x485/0x570 net/rxrpc/conn_client.c:1112
 rxrpc_local_destroyer net/rxrpc/local_object.c:377 [inline]
 rxrpc_local_processor+0x486/0x640 net/rxrpc/local_object.c:411
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
---[ end trace 46cd0dc6be526c5b ]---
RIP: 0010:____rb_erase_color lib/rbtree.c:354 [inline]
RIP: 0010:rb_erase+0x615/0xf40 lib/rbtree.c:445
Code: 83 01 00 00 90 48 8d 5d 10 48 89 dd 48 c1 ed 03 42 80 7c 3d 00 00 74 08 48 89 df e8 55 0c 94 fd 4c 8b 2b 4d 89 ee 49 c1 ee 03 <43> 80 3c 3e 00 74 08 4c 89 ef e8 3c 0c 94 fd 41 f6 45 00 01 48 89
RSP: 0018:ffffc90004c4fa50 EFLAGS: 00010246
RAX: 1ffff11002a7c7ae RBX: ffff8880199a6e80 RCX: dffffc0000000000
RDX: ffff88801d7f3a00 RSI: ffff8880899311d0 RDI: ffff88801e52c478
RBP: 1ffff11003334dd0 R08: ffffffff8943b24b R09: 0000000000000003
R10: fffff52000989f45 R11: 0000000000000004 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562128df3158 CR3: 000000006f090000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	83 01 00             	addl   $0x0,(%rcx)
   3:	00 90 48 8d 5d 10    	add    %dl,0x105d8d48(%rax)
   9:	48 89 dd             	mov    %rbx,%rbp
   c:	48 c1 ed 03          	shr    $0x3,%rbp
  10:	42 80 7c 3d 00 00    	cmpb   $0x0,0x0(%rbp,%r15,1)
  16:	74 08                	je     0x20
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	e8 55 0c 94 fd       	callq  0xfd940c75
  20:	4c 8b 2b             	mov    (%rbx),%r13
  23:	4d 89 ee             	mov    %r13,%r14
  26:	49 c1 ee 03          	shr    $0x3,%r14
* 2a:	43 80 3c 3e 00       	cmpb   $0x0,(%r14,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ef             	mov    %r13,%rdi
  34:	e8 3c 0c 94 fd       	callq  0xfd940c75
  39:	41 f6 45 00 01       	testb  $0x1,0x0(%r13)
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
