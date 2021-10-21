Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD14363C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhJUOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:09:47 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36470 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUOJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:09:44 -0400
Received: by mail-io1-f69.google.com with SMTP id x21-20020a0566022c5500b005ddd625f399so525813iov.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bqwHyCaF+l2/nM6oqc0LhXRxVB487IpS+ktDx04p6og=;
        b=xnQNTkR7O47KxYQsLKHwrmoRMYxHWUX1g4CFCr3vvOGR5ACgcehOqIkUCrspqMkY7y
         SANsodD2hCns5IEgcS7SW8CWV9UzAtBq69SW6a2LcGbBje7g1bl2Y4B3x2z7BBGLvNLn
         yk0WeMR6G6TT38GXOFQcNwanIWB5T9QXPYQDTgTJlKJOxDVZFp8Sx5bxC9MqEpymJgUu
         V4TE3fm2prOkDJAf2XGhuiejnNHDOPJ3LuOojz4TyuWev8nyFUOdJ+GNOhjGPsGnc3bs
         YPtKqDQ3OMPPqSeOqswqHXQdcrbyodHkPxjPxo9ZzCxxozyMKU1qtnCb+9hqk//AJRi5
         OGSA==
X-Gm-Message-State: AOAM533Mg8WflIHVwi2a1R4qxAkd6v85IX4Ob0ZwqOIoUGtyv+4+Kxh4
        IfaUomfvzJLhEMZR+z33A7o0qB8O0tbBe4k0XroSxds+Xbnj
X-Google-Smtp-Source: ABdhPJzIIf08cG5e8R3F6tVMJdRt+kZU4KygpdIlCMrBxRIF01xqg71PE+3eQshcQEojFhhf6s4rFwdIAArFIGWkAK9cGItpnJiS
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40d:: with SMTP id q13mr4125291jap.102.1634825248467;
 Thu, 21 Oct 2021 07:07:28 -0700 (PDT)
Date:   Thu, 21 Oct 2021 07:07:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034836805cedd6a97@google.com>
Subject: [syzbot] general protection fault in start_motor
From:   syzbot <syzbot+4e9b2677f1f8fba5cb18@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d999ade1cc86 Merge tag 'perf-tools-fixes-for-v5.15-2021-10..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146197f4b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bab9d35f204746a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4e9b2677f1f8fba5cb18
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e9b2677f1f8fba5cb18@syzkaller.appspotmail.com

floppy1: FDC access conflict!
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 PID: 3980 Comm: kworker/u16:5 Not tainted 5.15.0-rc5-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:start_motor+0x3a/0x3f0 drivers/block/floppy.c:1905
Code: 08 e8 6a 52 05 fd 48 8b 1d 73 38 e1 0b 48 b8 00 00 00 00 00 fc ff df 0f b6 2d 82 22 e1 0b 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6 04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e be 02 00
RSP: 0018:ffffc90007e3fca8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff847185a6 RDI: ffffffff8471c2e0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8471c346 R11: 0000000000000000 R12: ffffffff8471c2e0
R13: 0000000000000001 R14: ffff8880129da500 R15: ffff888010c71800
FS:  0000000000000000(0000) GS:ffff88802cd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000049291000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 floppy_ready+0x7f/0x1930 drivers/block/floppy.c:1932
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
---[ end trace 5ab26389b77b524a ]---
RIP: 0010:start_motor+0x3a/0x3f0 drivers/block/floppy.c:1905
Code: 08 e8 6a 52 05 fd 48 8b 1d 73 38 e1 0b 48 b8 00 00 00 00 00 fc ff df 0f b6 2d 82 22 e1 0b 48 89 da 48 c1 ea 03 89 e9 41 89 ed <0f> b6 04 02 83 e1 03 41 83 e5 03 84 c0 74 08 3c 03 0f 8e be 02 00
RSP: 0018:ffffc90007e3fca8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff847185a6 RDI: ffffffff8471c2e0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8471c346 R11: 0000000000000000 R12: ffffffff8471c2e0
R13: 0000000000000001 R14: ffff8880129da500 R15: ffff888010c71800
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002001d000 CR3: 000000000b68e000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 e8                	or     %ch,%al
   2:	6a 52                	pushq  $0x52
   4:	05 fd 48 8b 1d       	add    $0x1d8b48fd,%eax
   9:	73 38                	jae    0x43
   b:	e1 0b                	loope  0x18
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	0f b6 2d 82 22 e1 0b 	movzbl 0xbe12282(%rip),%ebp        # 0xbe122a0
  1e:	48 89 da             	mov    %rbx,%rdx
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	89 e9                	mov    %ebp,%ecx
  27:	41 89 ed             	mov    %ebp,%r13d
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	83 e1 03             	and    $0x3,%ecx
  31:	41 83 e5 03          	and    $0x3,%r13d
  35:	84 c0                	test   %al,%al
  37:	74 08                	je     0x41
  39:	3c 03                	cmp    $0x3,%al
  3b:	0f                   	.byte 0xf
  3c:	8e                   	.byte 0x8e
  3d:	be                   	.byte 0xbe
  3e:	02 00                	add    (%rax),%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
