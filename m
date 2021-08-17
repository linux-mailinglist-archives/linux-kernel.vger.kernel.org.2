Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD83EE42B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbhHQCH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:07:57 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44634 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbhHQCH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:07:56 -0400
Received: by mail-io1-f71.google.com with SMTP id d15-20020a0566022befb02905b2e9040807so4750735ioy.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 19:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=B3AAPQuMcQ62qqulG+gvB5HQAEfDQ5g/T+ib/OQjkUU=;
        b=Uf6JYSeRsoiOW38fQgR7kj9g8AqkKwG+u+7dY/7BmGq3kuk86cjEU8tL3+rLSjd6z9
         KNbZtOPR6zhyu1wJHTbOZd2JasCO+adFn7jIEOPuHwl96H72bOLzaQ+25aedmhrqSkVa
         Ho5YAetlixrln3+MbjoK+P9yeNjxeySYk49cgy8T2rdZFxdPdoxkNjx7eupnxeprL/bz
         3UVD5VzrGNP11sMbDfPoTdG9ndX6D4UqNqui4Z7zdi7D1ys3XWSjmCDP+6vC4SoHvxv1
         6TYnhV+RUJOpARNoPBoROlNgO1PYfGGMnx+qQWN8WQHLIFFPiDA9Z+0Vdxnja/zZebV5
         Jx/Q==
X-Gm-Message-State: AOAM533Qf+rc2Lqdj1jjdo+yIj2WcWZ1PDtNdDho+OiI+0YbMI73SAOJ
        Atq9PsS262qgdF8D2l6VVvlYFWr6KkdVxK1V0iH3Oh1T9nMl
X-Google-Smtp-Source: ABdhPJwmgHpjOZmlXhwQBShLlP55HuoWCGGOFAETkI8fDeI1jjHx65yd7UXNcta4RhC3sbA6B92mkvMvjY3lJwEYytXJyipT0174
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2184:: with SMTP id j4mr755018ila.30.1629166043689;
 Mon, 16 Aug 2021 19:07:23 -0700 (PDT)
Date:   Mon, 16 Aug 2021 19:07:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050776d05c9b7c7f0@google.com>
Subject: [syzbot] kernel BUG in remove_inode_hugepages
From:   syzbot <syzbot+67654e51e54455f1c585@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mike.kravetz@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a2824f19e606 Merge tag 'mtd/fixes-for-5.14-rc7' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110d54ee300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96f0602203250753
dashboard link: https://syzkaller.appspot.com/bug?extid=67654e51e54455f1c585
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12eeb6a6300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13515779300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67654e51e54455f1c585@syzkaller.appspotmail.com

Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffedef26928 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 000000000043f589
RDX: 000000000000effd RSI: 0000000020000680 RDI: 0000000000000003
RBP: 00007ffedef26930 R08: 0000000000000001 R09: 0000000000400034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000005
R13: 0000000000000000 R14: 00000000004ad018 R15: 0000000000400488
------------[ cut here ]------------
kernel BUG at fs/hugetlbfs/inode.c:532!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8445 Comm: syz-executor211 Not tainted 5.14.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:remove_inode_hugepages+0x52f/0xa90 fs/hugetlbfs/inode.c:532
Code: ff e8 d5 f2 4c ff 48 89 ef e8 3d c3 70 ff e9 17 ff ff ff e8 c3 f2 4c ff 48 89 ef e8 cb 50 71 ff e9 1a fe ff ff e8 b1 f2 4c ff <0f> 0b e8 aa f2 4c ff 49 83 ed 01 e9 d5 fd ff ff e8 9c f2 4c ff 48
RSP: 0018:ffffc900017afa30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888017093880 RSI: ffffffff8228b64f RDI: 0000000000000003
RBP: ffffea0000a48000 R08: 0000000000000000 R09: ffffea0000a4802f
R10: ffffffff8228b4a7 R11: 0000000000000000 R12: 7fffffffffffffff
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004801c0 CR3: 0000000029917000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 hugetlbfs_evict_inode+0x1f/0x70 fs/hugetlbfs/inode.c:557
 evict+0x2ed/0x6b0 fs/inode.c:584
 iput_final fs/inode.c:1660 [inline]
 iput.part.0+0x539/0x850 fs/inode.c:1686
 iput+0x58/0x70 fs/inode.c:1676
 dentry_unlink_inode+0x2b1/0x3d0 fs/dcache.c:376
 __dentry_kill+0x3c0/0x640 fs/dcache.c:582
 dentry_kill fs/dcache.c:708 [inline]
 dput+0x73a/0xbc0 fs/dcache.c:888
 __fput+0x3ae/0x920 fs/file_table.c:293
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbd4/0x2a60 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 __do_sys_exit_group kernel/exit.c:933 [inline]
 __se_sys_exit_group kernel/exit.c:931 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43e289
Code: Unable to access opcode bytes at RIP 0x43e25f.
RSP: 002b:00007ffedef26908 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00000000004af3b0 RCX: 000000000043e289
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000400034
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004af3b0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
Modules linked in:
---[ end trace b9c8e89a63f407f9 ]---
RIP: 0010:remove_inode_hugepages+0x52f/0xa90 fs/hugetlbfs/inode.c:532
Code: ff e8 d5 f2 4c ff 48 89 ef e8 3d c3 70 ff e9 17 ff ff ff e8 c3 f2 4c ff 48 89 ef e8 cb 50 71 ff e9 1a fe ff ff e8 b1 f2 4c ff <0f> 0b e8 aa f2 4c ff 49 83 ed 01 e9 d5 fd ff ff e8 9c f2 4c ff 48
RSP: 0018:ffffc900017afa30 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888017093880 RSI: ffffffff8228b64f RDI: 0000000000000003
RBP: ffffea0000a48000 R08: 0000000000000000 R09: ffffea0000a4802f
R10: ffffffff8228b4a7 R11: 0000000000000000 R12: 7fffffffffffffff
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004801c0 CR3: 0000000029917000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	28 c3                	sub    %al,%bl
   2:	e8 2a 14 00 00       	callq  0x1431
   7:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   e:	00 00 00 
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 c7 c1 c0 ff ff ff 	mov    $0xffffffffffffffc0,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
