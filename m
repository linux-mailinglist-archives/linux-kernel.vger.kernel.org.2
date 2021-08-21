Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30023F398E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbhHUIpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 04:45:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49077 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhHUIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:45:04 -0400
Received: by mail-io1-f72.google.com with SMTP id d12-20020a6b680c000000b005b86e36a1f4so6860948ioc.15
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 01:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5dza6HD2w6jZF9ySGymlzorliTLvvwOmdt7UWx4yWkc=;
        b=XOjWZ89FBkggBEzWC09ERIQ4JKm1wg55ibZjYpSGl/2YKGbnqQ1GvDFa35Da3NwUJu
         wB6kfrsXhySedYdypi9quZ3HvE/Ng8InSy/rE+teqnSXEShLZwVpl/1cd7dYuqz8IQb+
         +7BRaSnM9jMci5TuNJqaazC5B0GCpkwCNVTqDjiGCMEpcPqb5s9em5Z5XcrUCsIiHeuV
         9Cz6RTBRjixiRvRirV0mYSKVebhQ9uUs4ZaiAI69P+MGheRDSCPNNdcbO/lmv18D7nuN
         kbbV+kK/YeGNUpIfOqnqOhwN70QFa8uoe0wJfclW9eyFs25k1iHsdJaM07qjhlMg7iaI
         wZGg==
X-Gm-Message-State: AOAM532O0yCGscZ5GPLyzzsixo8ZzrZ5iRMhQzkOg1drmzlSTvZwF6ZG
        qUogFPGyGtGguo0hnTeDjo9JPBRsYiaAPyeTULqDxnCTUkKE
X-Google-Smtp-Source: ABdhPJyeGTwTJUGeUJp+UmwNY792sPz6K6efdtRKFQ9hUsoiLy6z55u4pk51WDrLUCkIMvvi3XgncRUmjGr7CPSNWYJeLAD7oTM0
MIME-Version: 1.0
X-Received: by 2002:a5d:8596:: with SMTP id f22mr19836551ioj.147.1629535465753;
 Sat, 21 Aug 2021 01:44:25 -0700 (PDT)
Date:   Sat, 21 Aug 2021 01:44:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000095ceb705ca0dca6d@google.com>
Subject: [syzbot] general protection fault in unlink_anon_vmas (2)
From:   syzbot <syzbot+83dc7d9efc6d710e264d@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fa54d366a6e4 Merge tag 'acpi-5.14-rc7' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179ed189300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f61012d0b1cd846f
dashboard link: https://syzkaller.appspot.com/bug?extid=83dc7d9efc6d710e264d
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83dc7d9efc6d710e264d@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
CPU: 1 PID: 11237 Comm: systemd-udevd Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:unlink_anon_vmas+0x21f/0x600 mm/rmap.c:409
Code: 00 00 00 00 00 fc ff df 42 80 3c 28 00 74 08 48 89 ef e8 d4 51 0d 00 48 8b 5d 00 b8 a4 00 00 00 48 01 c3 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 4c 8b 7c 24 10 0f 85 cc 00 00 00 ff 0b 48 8b
RSP: 0018:ffffc900023ff9e8 EFLAGS: 00010207
RAX: 0000000000000014 RBX: 00000000000000a4 RCX: ffff888071edb880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88800010f1a8 R08: ffffffff81b54680 R09: ffffed100257e5e3
R10: ffffed100257e5e3 R11: 0000000000000000 R12: ffff88807b5e6078
R13: dffffc0000000000 R14: 1ffff1100dd0c1ec R15: ffff88806e860f60
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bb059c2928 CR3: 0000000078608000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_pgtables+0x190/0x2d0 mm/memory.c:426
 exit_mmap+0x3fc/0x7a0 mm/mmap.c:3202
 __mmput+0x111/0x370 kernel/fork.c:1101
 exit_mm+0x60a/0x770 kernel/exit.c:501
 do_exit+0x6ae/0x2510 kernel/exit.c:812
 do_group_exit+0x168/0x2d0 kernel/exit.c:922
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:933
 __se_sys_exit_group+0x10/0x10 kernel/exit.c:931
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f32b0229618
Code: Unable to access opcode bytes at RIP 0x7f32b02295ee.
RSP: 002b:00007fff87af41c8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fff87af4290 RCX: 00007f32b0229618
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00007fff87af4340 R08: 00000000000000e7 R09: fffffffffffffe50
R10: 00000000ffffffff R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000003 R15: 000000000000000e
Modules linked in:
---[ end trace b77ca344fbcca8ec ]---
RIP: 0010:unlink_anon_vmas+0x21f/0x600 mm/rmap.c:409
Code: 00 00 00 00 00 fc ff df 42 80 3c 28 00 74 08 48 89 ef e8 d4 51 0d 00 48 8b 5d 00 b8 a4 00 00 00 48 01 c3 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 4c 8b 7c 24 10 0f 85 cc 00 00 00 ff 0b 48 8b
RSP: 0018:ffffc900023ff9e8 EFLAGS: 00010207
RAX: 0000000000000014 RBX: 00000000000000a4 RCX: ffff888071edb880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88800010f1a8 R08: ffffffff81b54680 R09: ffffed100257e5e3
R10: ffffed100257e5e3 R11: 0000000000000000 R12: ffff88807b5e6078
R13: dffffc0000000000 R14: 1ffff1100dd0c1ec R15: ffff88806e860f60
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd068008020 CR3: 0000000023261000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	df 42 80             	filds  -0x80(%rdx)
   3:	3c 28                	cmp    $0x28,%al
   5:	00 74 08 48          	add    %dh,0x48(%rax,%rcx,1)
   9:	89 ef                	mov    %ebp,%edi
   b:	e8 d4 51 0d 00       	callq  0xd51e4
  10:	48 8b 5d 00          	mov    0x0(%rbp),%rbx
  14:	b8 a4 00 00 00       	mov    $0xa4,%eax
  19:	48 01 c3             	add    %rax,%rbx
  1c:	48 89 d8             	mov    %rbx,%rax
  1f:	48 c1 e8 03          	shr    $0x3,%rax
* 23:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  28:	84 c0                	test   %al,%al
  2a:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
  2f:	0f 85 cc 00 00 00    	jne    0x101
  35:	ff 0b                	decl   (%rbx)
  37:	48                   	rex.W
  38:	8b                   	.byte 0x8b


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
