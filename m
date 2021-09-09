Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52923404215
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348246AbhIIALk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:11:40 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:41949 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348007AbhIIALh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:11:37 -0400
Received: by mail-il1-f198.google.com with SMTP id l4-20020a92d8c40000b02902242b6ea4b3so150813ilo.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 17:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=efoBqDBB90Zo6KBGwOvcOUmrPC3kWtBAO4+aYll1It8=;
        b=egxyb01wKp419k4Q1kVjZX6G8Kte/YcDdtf915HJ1Lwbx+rjSr/Agh/CkgOM5HkmYv
         184WtgENLQbZoRYMS5Bj9SBp/j8COCqgtm7z0aBJjMi1AyQfEmWiMLPiNpivDbztzUlj
         ZQrGtE6blcZtqrymLWgIV+Z6pUy0Ga/wZZMeMkLeLSUuqr23AE/oDEp0V65NqHb2tp3c
         1yW+G0d3ldsLMWBAPND+VtlYxZCj2aheyIgL/A3Nkg6TC0/FUfSPkBlaxHkwyvlshDRl
         1pQXhbMgYKnlZ6/NrwHNn0rpRugj1L9n70QjtGA2fGu+ec3wSaaVpvTCfYZSA4UjqupO
         0APQ==
X-Gm-Message-State: AOAM530GukHlRRftltD0D9IKi3mbL4B4Iq5Pzm9P8eScNm07mIpwKj9K
        vWRwR9rawU7V3S2MIBgwl4/KnHrVQZLuPIm5JZAChz4F5qgg
X-Google-Smtp-Source: ABdhPJz10IOR/DzL4piVzfvWlvIn/1eg9Ce7IdPfOkPYXWIzOOUWokUYnXL6+TYdlCFsSXl7dQtbpfiW5PEr1SbmuQucu7isb4+2
MIME-Version: 1.0
X-Received: by 2002:a02:9669:: with SMTP id c96mr192374jai.128.1631146228680;
 Wed, 08 Sep 2021 17:10:28 -0700 (PDT)
Date:   Wed, 08 Sep 2021 17:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000898c7405cb84d309@google.com>
Subject: [syzbot] possible deadlock in io_sq_thread
From:   syzbot <syzbot+c9e7f2674197989e8afb@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a2b28235335f Merge branch 'dmi-for-linus' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175ec47d300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5102874b5591af7
dashboard link: https://syzkaller.appspot.com/bug?extid=c9e7f2674197989e8afb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9e7f2674197989e8afb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.14.0-syzkaller #0 Not tainted
------------------------------------------------------
iou-sqp-17493/17496 is trying to acquire lock:
ffff888084a320a8 (&ctx->uring_lock){+.+.}-{3:3}, at: __io_sq_thread fs/io_uring.c:7291 [inline]
ffff888084a320a8 (&ctx->uring_lock){+.+.}-{3:3}, at: io_sq_thread+0x65a/0x1370 fs/io_uring.c:7368

but task is already holding lock:
ffff888012986870 (&sqd->lock){+.+.}-{3:3}, at: io_sq_thread+0x20f/0x1370 fs/io_uring.c:7356

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&sqd->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       io_register_iowq_max_workers fs/io_uring.c:10551 [inline]
       __io_uring_register fs/io_uring.c:10757 [inline]
       __do_sys_io_uring_register+0x10aa/0x2e70 fs/io_uring.c:10792
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&ctx->uring_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:596 [inline]
       __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
       __io_sq_thread fs/io_uring.c:7291 [inline]
       io_sq_thread+0x65a/0x1370 fs/io_uring.c:7368
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sqd->lock);
                               lock(&ctx->uring_lock);
                               lock(&sqd->lock);
  lock(&ctx->uring_lock);

 *** DEADLOCK ***

1 lock held by iou-sqp-17493/17496:
 #0: ffff888012986870 (&sqd->lock){+.+.}-{3:3}, at: io_sq_thread+0x20f/0x1370 fs/io_uring.c:7356

stack backtrace:
CPU: 0 PID: 17496 Comm: iou-sqp-17493 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 __mutex_lock_common kernel/locking/mutex.c:596 [inline]
 __mutex_lock+0x131/0x12f0 kernel/locking/mutex.c:729
 __io_sq_thread fs/io_uring.c:7291 [inline]
 io_sq_thread+0x65a/0x1370 fs/io_uring.c:7368
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
