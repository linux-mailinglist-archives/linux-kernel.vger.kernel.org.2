Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E743745ECFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349018AbhKZLye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:54:34 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:55998 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345868AbhKZLwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:52:34 -0500
Received: by mail-il1-f197.google.com with SMTP id h25-20020a056e021d9900b002a10123b5d0so8511643ila.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 03:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TJVyePaUxVjq9vTQ/r63hP1+yKII/gvjyk7O6Js39NU=;
        b=GdLI67ZVuq8U2nQ/Ge6PDdYuR6DZlwKwvFUoubCaj92wk88jkbfzbj5ge5Iua+jNkp
         IdknWuPVdvXy3qLwqfaQJPJvtjbchn6lEdvfAHyslyk/kixDvhQjmjcfziehLrimnNsj
         mSUsfEyfreUktlTf333k5EAV6um7t+s4NJTqkyt50kcf9ZoeVgWVo/xcoHLpAfHjkwQ4
         lSTeE9D6WaVs9IaAxrrCb3GOXvVbofW0ZPDPK3h2UdC6/D4qv3UPFYjx1uLOI72Q8dKs
         2qhIhIJW3fFSl1Kqu9GI8j0PVLE4upw7Q4ixvQHF327CzQrflVeQs8iN8+TJxlZq6tY4
         5fPQ==
X-Gm-Message-State: AOAM531CuDNXx3LJw9gyJGHmY+I1r8GIxEvoLjcUQ68NcozqVnAdnCDM
        6tY0euQgyRB6gxzg/YpHamEE8IeyxrFNOV+H8iuPr5NRVTWK
X-Google-Smtp-Source: ABdhPJwm+bGFpaUrMvOl7J2JHsScjQlqFjYCFqZdVJe0yMpD6B7s+qWDggbAqbklUQ1nGShLUirHGdCocVH4V92YlwLz4ocs06VQ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd4:: with SMTP id j20mr38117885iow.106.1637927361177;
 Fri, 26 Nov 2021 03:49:21 -0800 (PST)
Date:   Fri, 26 Nov 2021 03:49:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087eba405d1afaec3@google.com>
Subject: [syzbot] possible deadlock in io_flush_timeouts
From:   syzbot <syzbot+847f02ec20a6609a328b@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a4849f6000e2 Merge tag 'drm-fixes-2021-11-26' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155d6431b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=178bb64dabf569c5
dashboard link: https://syzkaller.appspot.com/bug?extid=847f02ec20a6609a328b
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+847f02ec20a6609a328b@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.16.0-rc2-syzkaller #0 Not tainted
--------------------------------------------
syz-executor.5/3756 is trying to acquire lock:
ffff88807c93b418 (&ctx->timeout_lock){+.+.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
ffff88807c93b418 (&ctx->timeout_lock){+.+.}-{2:2}, at: io_flush_timeouts+0x80/0x34c fs/io_uring.c:1587

but task is already holding lock:
ffff88807c93b418 (&ctx->timeout_lock){+.+.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
ffff88807c93b418 (&ctx->timeout_lock){+.+.}-{2:2}, at: io_poll_remove_all+0x49/0x319 fs/io_uring.c:5702

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&ctx->timeout_lock);
  lock(&ctx->timeout_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz-executor.5/3756:
 #0: ffff88807c93b3d8 (&ctx->completion_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
 #0: ffff88807c93b3d8 (&ctx->completion_lock){+.+.}-{2:2}, at: io_poll_remove_all+0x38/0x319 fs/io_uring.c:5701
 #1: ffff88807c93b418 (&ctx->timeout_lock){+.+.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
 #1: ffff88807c93b418 (&ctx->timeout_lock){+.+.}-{2:2}, at: io_poll_remove_all+0x49/0x319 fs/io_uring.c:5702

stack backtrace:
CPU: 1 PID: 3756 Comm: syz-executor.5 Not tainted 5.16.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 print_deadlock_bug kernel/locking/lockdep.c:2956 [inline]
 check_deadlock kernel/locking/lockdep.c:2999 [inline]
 validate_chain+0x5984/0x8240 kernel/locking/lockdep.c:3788
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0xcf/0x110 kernel/locking/spinlock.c:170
 spin_lock_irq include/linux/spinlock.h:374 [inline]
 io_flush_timeouts+0x80/0x34c fs/io_uring.c:1587
 __io_commit_cqring_flush+0x80/0xbf fs/io_uring.c:1618
 io_commit_cqring fs/io_uring.c:1626 [inline]
 io_poll_remove_one+0x4bd/0x610 fs/io_uring.c:5684
 io_poll_remove_all+0x24c/0x319 fs/io_uring.c:5709
 io_ring_ctx_wait_and_kill+0x22c/0x36a fs/io_uring.c:9534
 io_uring_release+0x59/0x63 fs/io_uring.c:9554
 __fput+0x3fc/0x870 fs/file_table.c:280
 task_work_run+0x146/0x1c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
 exit_to_user_mode_prepare+0x209/0x220 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x2e/0x70 kernel/entry/common.c:300
 do_syscall_64+0x53/0xd0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8fcca06ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8fc9f7c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000124
RAX: 0000000000000004 RBX: 00007f8fccb19f60 RCX: 00007f8fcca06ae9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007f8fcca60f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdd4f85a4f R14: 00007f8fc9f7c300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
