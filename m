Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449DC4238EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhJFHeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 03:34:16 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:55919 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbhJFHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:34:15 -0400
Received: by mail-il1-f200.google.com with SMTP id c11-20020a928e0b000000b0024eb114af51so1222636ild.22
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 00:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=v2XyC/ESmma/mYoF8fEwUIRl7OIJI4DzGLfKNGadpYs=;
        b=IuqH5aITf4llV0f//8uaoE6UNSDF2ZQ27eQ6ZjoSn2I1DaZnYCnlw5TLz3jd9UL03V
         9eTc1H90QPuG4AGq13/NNgUCMg1DueVct34OF4ZPHmRg8HpsPGOm1dkeEyoEM4oOG6fi
         ugm+o+chUzyhh2/6Boyg1S9x00FjBqSNHWg39h9LXosCK8b9Y6QuBIT9gfC00ajg7EAf
         EhzzjTkTdx05EYJZImZ9rG1hQTeSeyZX+0+wpCJNwUW05CUn8oeFD0ZvMEK8v2jsgUfX
         OkiWML8dsKlvwiiT24xochUCmYLW88zX8p+MMYRilrVNoIBXz8cz5Il51eayZ4YSMl60
         4CVw==
X-Gm-Message-State: AOAM5310e0wXczf1191DNN1cVTFhAMkmtbLaIx+Od+7eXyusOrydOEYU
        XcJ6C2YPEd0XkARY68xoubGH/bdFgEREl84ILxuAPeSlm3q8
X-Google-Smtp-Source: ABdhPJwr14EPPPA4gMQx9OL5gR6Jl1TWMayLz64XQbdP4Zlt9E3r7Fy0pJl87puVxiUHWpNby+ZXgHjWNADgvQMy+ev4qM/t5YVC
MIME-Version: 1.0
X-Received: by 2002:a5e:9314:: with SMTP id k20mr5179316iom.136.1633505543301;
 Wed, 06 Oct 2021 00:32:23 -0700 (PDT)
Date:   Wed, 06 Oct 2021 00:32:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5aee105cdaa2586@google.com>
Subject: [syzbot] KASAN: use-after-free Read in icmpv6_sk_exit (2)
From:   syzbot <syzbot+497d3e91eb557f7dc0aa@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    84b3e42564ac Merge tag 'media/v5.15-3' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bd85df300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb467ad25fcc6899
dashboard link: https://syzkaller.appspot.com/bug?extid=497d3e91eb557f7dc0aa
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13753e7b300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+497d3e91eb557f7dc0aa@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000090: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000480-0x0000000000000487]
CPU: 0 PID: 8 Comm: kworker/u4:0 Not tainted 5.15.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:inet_ctl_sock_destroy include/net/inet_common.h:65 [inline]
RIP: 0010:icmpv6_sk_exit+0x106/0x1f0 net/ipv6/icmp.c:1038
Code: 42 80 3c 20 00 74 08 48 89 df e8 e5 7a f3 f8 48 8b 1b 48 85 db 74 2d e8 c8 0d a8 f8 48 81 c3 80 04 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 bb 7a f3 f8 48 8b 3b e8 f3 30 25
RSP: 0018:ffffc90000cd7b40 EFLAGS: 00010206
RAX: 0000000000000090 RBX: 0000000000000481 RCX: ffff888012375580
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000008
RBP: ffffffff8c38a7d8 R08: ffffffff88da6485 R09: ffffffff843540e0
R10: 0000000000000009 R11: ffff888012375580 R12: dffffc0000000000
R13: 1ffffffff1bb7fbf R14: ffff88801fcf3fe0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005606aea732f8 CR3: 000000005c17f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ops_exit_list net/core/net_namespace.c:168 [inline]
 cleanup_net+0x758/0xc50 net/core/net_namespace.c:591
 process_one_work+0x853/0x1140 kernel/workqueue.c:2297
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2444
 kthread+0x453/0x480 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
Modules linked in:
---[ end trace e9d83564f5107008 ]---
RIP: 0010:inet_ctl_sock_destroy include/net/inet_common.h:65 [inline]
RIP: 0010:icmpv6_sk_exit+0x106/0x1f0 net/ipv6/icmp.c:1038
Code: 42 80 3c 20 00 74 08 48 89 df e8 e5 7a f3 f8 48 8b 1b 48 85 db 74 2d e8 c8 0d a8 f8 48 81 c3 80 04 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 bb 7a f3 f8 48 8b 3b e8 f3 30 25
RSP: 0018:ffffc90000cd7b40 EFLAGS: 00010206
RAX: 0000000000000090 RBX: 0000000000000481 RCX: ffff888012375580
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000008
RBP: ffffffff8c38a7d8 R08: ffffffff88da6485 R09: ffffffff843540e0
R10: 0000000000000009 R11: ffff888012375580 R12: dffffc0000000000
R13: 1ffffffff1bb7fbf R14: ffff88801fcf3fe0 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f93fc5792d8 CR3: 000000005c17f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   5:	74 08                	je     0xf
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 e5 7a f3 f8       	callq  0xf8f37af4
   f:	48 8b 1b             	mov    (%rbx),%rbx
  12:	48 85 db             	test   %rbx,%rbx
  15:	74 2d                	je     0x44
  17:	e8 c8 0d a8 f8       	callq  0xf8a80de4
  1c:	48 81 c3 80 04 00 00 	add    $0x480,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 bb 7a f3 f8       	callq  0xf8f37af4
  39:	48 8b 3b             	mov    (%rbx),%rdi
  3c:	e8                   	.byte 0xe8
  3d:	f3                   	repz
  3e:	30                   	.byte 0x30
  3f:	25                   	.byte 0x25


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
