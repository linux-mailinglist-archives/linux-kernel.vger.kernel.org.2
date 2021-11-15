Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078CD45044C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 13:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhKOMWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 07:22:30 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:48959 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhKOMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:22:19 -0500
Received: by mail-io1-f69.google.com with SMTP id g23-20020a6be617000000b005e245747fb4so10577079ioh.15
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 04:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wIjelldcIGTV2BDMoHCyCI4gAKHEihq72N4Vjo2zKnQ=;
        b=EVwttPHIiUkOfuq/Tnm6qbKsM3768M3bXb45l0iz9zB8dVnp7kPksCwauNx2BrHYa4
         9fEajiSqOqYxfSrpU8adR0C4dJEBTruS+OGE4fwOUX9z80HWDWi91XXTqmdoQXtDAfrH
         xEc0x/m06xS1Yrp3D7/udVkT2D7QyFrbgqF8El12kXl271psVliNd/3MgsNVEtupqkL3
         wAKgfKnNr8WkV6GisRdzSY+pKeIx9fQa4gjzszD0FZOrtLSA9Hm3QF1uDLCoRl82ELlR
         FXHxpavHf+/cjzzapisyDr+rWq253G29uMF/0eokUYusO9d0a8GvUMBA+zRPY3TVHGLH
         mdfg==
X-Gm-Message-State: AOAM531TBvt8b4Nup4cZGFIgvAY7rx2VHpZzGUSBy1HPdHH/36Yhz71p
        GPEVa5Uz2qBAbnqlIZ7lnLnlm6CjHNX2Y92XTkTloRtq1WOU
X-Google-Smtp-Source: ABdhPJxcGEygl3LDrMOi0TUuRjTHSwIZu5CKjWhCuTHoV+sa0NCOHyg7DvQNE8oMOL2g+Bi19XGA66uPzRog5/UpzQ519LoMQJI1
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr25440477iov.98.1636978763620;
 Mon, 15 Nov 2021 04:19:23 -0800 (PST)
Date:   Mon, 15 Nov 2021 04:19:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5e7f105d0d2d165@google.com>
Subject: [syzbot] WARNING in __i2c_transfer (2)
From:   syzbot <syzbot+e417648b303855b91d8a@syzkaller.appspotmail.com>
To:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, wsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c8c109546a19 Merge tag 'zstd-for-linus-v5.16' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a5bb32b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a262045c4c15a9e0
dashboard link: https://syzkaller.appspot.com/bug?extid=e417648b303855b91d8a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e417648b303855b91d8a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12113 at drivers/i2c/i2c-core-base.c:2178 __i2c_transfer+0xa14/0x17c0 drivers/i2c/i2c-core-base.c:2178
Modules linked in:
CPU: 0 PID: 12113 Comm: syz-executor.4 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__i2c_transfer+0xa14/0x17c0 drivers/i2c/i2c-core-base.c:2178
Code: 0f 94 c7 31 ff 44 89 fe e8 39 89 8e fb 45 84 ff 0f 84 26 fd ff ff e8 4b 85 8e fb 0f 1f 44 00 00 e9 17 fd ff ff e8 3c 85 8e fb <0f> 0b 41 bc ea ff ff ff e9 9e fd ff ff e8 2a 85 8e fb 44 89 ee bf
RSP: 0018:ffffc90004a67ce8 EFLAGS: 00010212
RAX: 0000000000008838 RBX: 0000000000000010 RCX: ffffc90011e05000
RDX: 0000000000040000 RSI: ffffffff85e961b4 RDI: 0000000000000003
RBP: ffff88814a28cb58 R08: 0000000000000000 R09: ffffffff8ff75b57
R10: ffffffff85e957d8 R11: 0000000000000000 R12: 0000000000000010
R13: 0000000000000000 R14: ffff88814a28cb78 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0063) knlGS:00000000f4460b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002c021000 CR3: 0000000070b50000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 i2c_transfer+0x1e6/0x3e0 drivers/i2c/i2c-core-base.c:2269
 i2cdev_ioctl_rdwr+0x583/0x6a0 drivers/i2c/i2c-dev.c:297
 compat_i2cdev_ioctl+0x419/0x4f0 drivers/i2c/i2c-dev.c:561
 __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf6e66549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f44605fc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000707
RDX: 00000000200000c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
