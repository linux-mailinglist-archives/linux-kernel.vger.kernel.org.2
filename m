Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC463440FCE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 18:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhJaRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 13:43:03 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:37744 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhJaRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 13:43:00 -0400
Received: by mail-io1-f70.google.com with SMTP id w8-20020a0566022c0800b005dc06acea8dso11110811iov.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 10:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FaKcqRHzMLbH5u8NNeIw2kJUUFiOkDyVZdvGBGaubq0=;
        b=Vd5784frLE65pdaDVpydBaA2jHgNhVOZd4orqaPGj2PiKIEJZ8XBeCOG8z7oGy2hBZ
         xHiP6C7+4csK+PijJy2u7dGGCIx8ePbOjV/YpxMV1HOHT4z9Hk7dFRXTd3sgQbF9IC9Z
         Y8MKFMJxr7lPjndUrqThUtFtqOPd18Q5YmqBAWcYmBNKTQSaE6i4df9dEMnn56k0rbmt
         06UerUzp/WbXEm5s+99FSUPemV9Skged/YMs0Ml826Q5jNs/0Dye/rP2iJpaewrm6y2W
         ZZeGH8/SdR3beGE3rjZFgwihTnZg4u8HWLMs36Dw7j/MSHg7OmWX1MQ0UCXpkmxhZB7S
         Wycw==
X-Gm-Message-State: AOAM531t3HOLX3Q5w+RQUvxFK+/RUxRr2GlV+LBiE5yR/c9jHZ/1TXhl
        F62ms/PBpgUaKpIYcMOtVse9QE4CRB29vXtQLbpL+XeyqcbL
X-Google-Smtp-Source: ABdhPJw9LjiP8AhyRWBPFnMRi1wV941Kz+m2k0gsY6tBs4Iia/YW76hgoTsMJIQIZWXqENXO9ZyTg/f+qB16ei98Ny8T1qvZWeuJ
MIME-Version: 1.0
X-Received: by 2002:a02:620b:: with SMTP id d11mr17851905jac.69.1635702025705;
 Sun, 31 Oct 2021 10:40:25 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:40:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000335eea05cfa98e32@google.com>
Subject: [syzbot] KASAN: use-after-free Read in unmap_page_range (2)
From:   syzbot <syzbot+11210d36738191856de4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, christian@brauner.io,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1fc596a56b33 Merge tag 'trace-v5.15-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1173759ab00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9646ff3aa1daf1a8
dashboard link: https://syzkaller.appspot.com/bug?extid=11210d36738191856de4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d15ad4b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142a0b64b00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11210d36738191856de4@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 8652 Comm: syz-executor811 Not tainted 5.15.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__lock_acquire+0xd7d/0x54a0 kernel/locking/lockdep.c:4885
Code: e9 0d 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 f9 0b e9 0d e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 f3 2f 00 00 48 81 3b 00 35 f0 8e 0f 84 52 f3 ff
RSP: 0018:ffffc9000562f970 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888077151c80 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555f75300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdc1e38c38 CR3: 00000000780df000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:363 [inline]
 zap_pte_range mm/memory.c:1320 [inline]
 zap_pmd_range mm/memory.c:1481 [inline]
 zap_pud_range mm/memory.c:1510 [inline]
 zap_p4d_range mm/memory.c:1531 [inline]
 unmap_page_range+0x87b/0x2a10 mm/memory.c:1552
 __oom_reap_task_mm+0x22d/0x400 mm/oom_kill.c:555
 __do_sys_process_mrelease+0x32a/0x400 mm/oom_kill.c:1199
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7faa3e405d29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc1e38c38 EFLAGS: 00000246 ORIG_RAX: 00000000000001c0
RAX: ffffffffffffffda RBX: 0000000000011d9b RCX: 00007faa3e405d29
RDX: 00007faa3e405d29 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffdc1e38dd8 R09: 00007ffdc1e38dd8
R10: 00007ffdc1e38dd8 R11: 0000000000000246 R12: 00007ffdc1e38c4c
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 281cbdc141c02a9c ]---
RIP: 0010:__lock_acquire+0xd7d/0x54a0 kernel/locking/lockdep.c:4885
Code: e9 0d 41 be 01 00 00 00 0f 86 c8 00 00 00 89 05 f9 0b e9 0d e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 f3 2f 00 00 48 81 3b 00 35 f0 8e 0f 84 52 f3 ff
RSP: 0018:ffffc9000562f970 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000018 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888077151c80 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555555f75300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdc1e38c38 CR3: 00000000780df000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	0d 41 be 01 00       	or     $0x1be41,%eax
   5:	00 00                	add    %al,(%rax)
   7:	0f 86 c8 00 00 00    	jbe    0xd5
   d:	89 05 f9 0b e9 0d    	mov    %eax,0xde90bf9(%rip)        # 0xde90c0c
  13:	e9 bd 00 00 00       	jmpq   0xd5
  18:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1f:	fc ff df
  22:	48 89 da             	mov    %rbx,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 f3 2f 00 00    	jne    0x3026
  33:	48 81 3b 00 35 f0 8e 	cmpq   $0xffffffff8ef03500,(%rbx)
  3a:	0f                   	.byte 0xf
  3b:	84 52 f3             	test   %dl,-0xd(%rdx)
  3e:	ff                   	.byte 0xff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
