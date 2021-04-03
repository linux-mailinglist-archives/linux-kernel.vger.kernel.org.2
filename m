Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228DE353547
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhDCSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:54:23 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54892 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236035AbhDCSyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:54:22 -0400
Received: by mail-il1-f198.google.com with SMTP id f14so7487961ilr.21
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 11:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ixDYXgZlEH42SiFgDybl3219XIh1RgCciY74dVCHNNE=;
        b=n9EfYu3i7b3RVl+S4CPo2ZKjXZFh1xTO8R4QY3UvqsS+5otnRGCu224h0gHEUV1Xje
         ZqACi0Bg4MMUXTH4w1SJAE/Um3vLnFHCNMmVlzcwKRd33DUHphaZBjT1E1alk6VWcZdI
         3vuLpik3lC/M7V0/AIrmuq5Ec9+UJfOpxcm/4oq9hYWcWVbCH+21dOeKGcVvvw/xBP8S
         cuiDMq2wtWr3TsAvPK2e3B+FtBgFWzrXJdYHKpbegDDorrp/DpMQTd1bM5OjKi5kGP49
         90yT6wFY6wh5kxLnY0w0sbbaJ6Vyv8JYp95BgUZXCSku7hZTFIReYvP+BcXNh+kSocgK
         uoxQ==
X-Gm-Message-State: AOAM533EPp8rkWCE46lawAwLC56PAPknFkM+w0cRJURpIFK0Vs3AqJ/p
        TZKXpN8lC0NC6AMuZQHtwUxFYjaNqCHzbc8nRMJMO8KndglA
X-Google-Smtp-Source: ABdhPJz8BNfq19K4KFrVFG9vgsm+6gBtGlF/AU27HtpoCbR0y21qToebw9NkmxsKkdYjFuKUQ+AANzn08TZ7+lss0kpyrXuGLl2f
MIME-Version: 1.0
X-Received: by 2002:a6b:db15:: with SMTP id t21mr14912179ioc.133.1617476058757;
 Sat, 03 Apr 2021 11:54:18 -0700 (PDT)
Date:   Sat, 03 Apr 2021 11:54:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea3ddb05bf15fdf8@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in copy_pte_range
From:   syzbot <syzbot+c2d2a6e2af34adb88749@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, christian@brauner.io,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e43c377 Merge tag 'xtensa-20210329' of git://github.com/j..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15604986d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a75beb62b62a34
dashboard link: https://syzkaller.appspot.com/bug?extid=c2d2a6e2af34adb88749
compiler:       Debian clang version 11.0.1-2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2d2a6e2af34adb88749@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.12.0-rc5-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:8294 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
3 locks held by syz-executor.2/8400:
 #0: ffffffff8c796770 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mmap+0x73/0xde0 kernel/fork.c:479
 #1: ffff8880286c0158 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #1: ffff8880286c0158 (&mm->mmap_lock#2){++++}-{3:3}, at: dup_mmap+0x87/0xde0 kernel/fork.c:480
 #2: ffff8880286c2458 (&mm->mmap_lock/1){+.+.}-{3:3}, at: mmap_write_lock_nested include/linux/mmap_lock.h:78 [inline]
 #2: ffff8880286c2458 (&mm->mmap_lock/1){+.+.}-{3:3}, at: dup_mmap+0xd1/0xde0 kernel/fork.c:489

stack backtrace:
CPU: 1 PID: 8400 Comm: syz-executor.2 Not tainted 5.12.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x176/0x24e lib/dump_stack.c:120
 ___might_sleep+0xb4/0x530 kernel/sched/core.c:8294
 copy_pte_range+0x255b/0x2a20 mm/memory.c:1010
 copy_pmd_range mm/memory.c:1064 [inline]
 copy_pud_range mm/memory.c:1101 [inline]
 copy_p4d_range mm/memory.c:1125 [inline]
 copy_page_range+0xba9/0xff0 mm/memory.c:1198
 dup_mmap+0x9aa/0xde0 kernel/fork.c:594
 dup_mm+0x8c/0x310 kernel/fork.c:1368
 copy_mm kernel/fork.c:1424 [inline]
 copy_process+0x24c1/0x5690 kernel/fork.c:2113
 kernel_clone+0x1a6/0x6c0 kernel/fork.c:2500
 __do_sys_clone kernel/fork.c:2617 [inline]
 __se_sys_clone kernel/fork.c:2601 [inline]
 __x64_sys_clone+0x1d5/0x220 kernel/fork.c:2601
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x464a4b
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffc64260880 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000464a4b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000003070400
R10: 00000000030706d0 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffc64260970


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
