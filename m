Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6A134F437
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhC3W0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:26:38 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:47303 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhC3W0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:26:16 -0400
Received: by mail-il1-f197.google.com with SMTP id h21so223246ila.14
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 15:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1u93kqYdtAiLCX1gVbvoAizOOKaaxSinv27S/a6wWSA=;
        b=B7+5cKg9qSuaDE5GQAN3SEWT0PXExa/twwUSa8qwbEtawbHg481kc5qY9V0avrznka
         OI4arzoJ5iDFZGiC0x584r3KO81w61flYxfrstkF194N2/aWIoZPh13gtpz3zvxaarjm
         sYH451Mtxv/2VB9UcWIS7qKLmVSMDjiZZkEA8TgA0P07mXmI4tSk4F+J7PoacocdD4Dy
         dnf5q5GiewanwJABgNo1iX4mVKuD3AlpSkimGnWkLI9DSzVZXIVhVBxgQ9yxE6g0dnL/
         dWj45jUKiRTzwP30xZmWKQrHIM0LfBekMIh+w5o6e7TU3S4BfAVzVjr85Gqxt9Pp/5Sa
         V4vA==
X-Gm-Message-State: AOAM531yiyB3v4BRJxtL92Px0jccNYAlOnoQtKPcyaFkUqoAjYeaL5+q
        ylETPZwreZ/vGI0UjVHbzuf//Z2RNfgw9IVC9jZZDtAMZEpf
X-Google-Smtp-Source: ABdhPJzxqbFv/0SefYItE0ZpkwRGGzKfvBf+v0+HqR7xCyOZYQEmAi1ayjT6R2QAFlekf1bvAyAMmHFTZHeit2+pYHs32G5tB03c
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1614:: with SMTP id x20mr408084jas.19.1617143175472;
 Tue, 30 Mar 2021 15:26:15 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:26:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086695705bec87c9f@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in copy_page_range
From:   syzbot <syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, christian@brauner.io,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    db24726b Merge tag 'integrity-v5.12-fix' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c16b7cd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=daeff30c2474a60f
dashboard link: https://syzkaller.appspot.com/bug?extid=1a33233ccd8201ec2322

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a33233ccd8201ec2322@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-rc4-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8294 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
3 locks held by syz-executor.0/8401:
 #0: ffffffff8c03e5b0 (dup_mmap_sem){++++}-{0:0}, at: dup_mmap kernel/fork.c:479 [inline]
 #0: ffffffff8c03e5b0 (dup_mmap_sem){++++}-{0:0}, at: dup_mm+0x108/0x1380 kernel/fork.c:1368
 #1: ffff888018d08858 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff888018d08858 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap kernel/fork.c:480 [inline]
 #1: ffff888018d08858 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mm+0x12e/0x1380 kernel/fork.c:1368
 #2: ffff88801888c058 (&mm->mmap_lock/1){+.+.}-{3:3}, at: mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff88801888c058 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap kernel/fork.c:489 [inline]
 #2: ffff88801888c058 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mm+0x18a/0x1380 kernel/fork.c:1368

stack backtrace:
CPU: 0 PID: 8401 Comm: syz-executor.0 Not tainted 5.12.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep+0x229/0x2c0 kernel/sched/core.c:8294
 copy_pte_range mm/memory.c:1010 [inline]
 copy_pmd_range mm/memory.c:1064 [inline]
 copy_pud_range mm/memory.c:1101 [inline]
 copy_p4d_range mm/memory.c:1125 [inline]
 copy_page_range+0x1270/0x3fd0 mm/memory.c:1198
 dup_mmap kernel/fork.c:594 [inline]
 dup_mm+0x9ed/0x1380 kernel/fork.c:1368
 copy_mm kernel/fork.c:1424 [inline]
 copy_process+0x2b99/0x7150 kernel/fork.c:2107
 kernel_clone+0xe7/0xab0 kernel/fork.c:2500
 __do_sys_clone+0xc8/0x110 kernel/fork.c:2617
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x464a4b
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffd44303270 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000464a4b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000002e94400
R10: 0000000002e946d0 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffd44303360


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
