Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3EA3D84C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 02:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhG1Ajd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 20:39:33 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:56235 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbhG1Ajb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 20:39:31 -0400
Received: by mail-il1-f199.google.com with SMTP id x16-20020a9206100000b02902166568c213so532436ilg.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 17:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uA/AXCGMamU1no+NfRDMc2VJXOVvs4cQsOp6iRBbhYE=;
        b=IJMq4LXukJ6sOeuuRKKrTdJD6qQTmYptRHlgcZqsOOucUVojbSueiJg/oiS8KLGev6
         Nfce0URcNg7BgEXlIFKMaf56HtH/z+oGVZET7ytbUHrl2CitOlRZx82ZoocWJ9fg1qda
         6SSg79ibsR2Tu2qwyWc+UsdlzyqSq5+jJbVweJo4u3UsJyUWUBNaswTIgq+MlPnPQ9L7
         /sAGFC5S3TrtTImeUt7tQ+xamGC/aZyfuYKJZ8WVqG0yOPMI/lwh+5amXTH6pX7KCFGf
         wIvWHop1flfsbPwXjCswUiyTCl0uMEttU3CFybhg4KzbDN1BDPSZ1HgzjKfkBB68RDmf
         viyQ==
X-Gm-Message-State: AOAM530g38+sfGmuhxHivhlM9Gcfh4am06vO1+qFUkkU/5+4jVmUlLjR
        CQsT/ZmtS6GaH6X3nI/fzwaPa3FGX1sYHzeWGocRWa1QUOXf
X-Google-Smtp-Source: ABdhPJydhbzl1ihLpelYdIiEsSqAwKLiyzom1Fq1rA3yoqLXKbllnBomdKddqRD/TGWln5mQ7tTN2Y0IMEZu69gk2NfIuA2/mMnE
MIME-Version: 1.0
X-Received: by 2002:a02:8241:: with SMTP id q1mr23647579jag.134.1627432770118;
 Tue, 27 Jul 2021 17:39:30 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028acb305c82438c5@google.com>
Subject: [syzbot] possible deadlock in tty_buffer_flush
From:   syzbot <syzbot+d1017f46f010a6c225da@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8baef6386baa Merge tag 'drm-fixes-2021-07-23' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e1b60a300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42748795a8952874
dashboard link: https://syzkaller.appspot.com/bug?extid=d1017f46f010a6c225da
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1017f46f010a6c225da@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.14.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
kworker/1:17/10474 is trying to acquire lock:
ffff8880108790b8 (&buf->lock){+.+.}-{3:3}, at: tty_buffer_flush+0x76/0x2b0 drivers/tty/tty_buffer.c:229

but task is already holding lock:
ffffffff8b96aac0 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x10/0x310 drivers/tty/vt/vt_ioctl.c:980

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (console_lock){+.+.}-{0:0}:
       console_lock+0x49/0x80 kernel/printk/printk.c:2462
       con_flush_chars drivers/tty/vt/vt.c:3325 [inline]
       con_flush_chars+0x35/0x90 drivers/tty/vt/vt.c:3317
       n_tty_write+0xbe5/0xfd0 drivers/tty/n_tty.c:2305
       do_tty_write drivers/tty/tty_io.c:1038 [inline]
       file_tty_write.constprop.0+0x526/0x910 drivers/tty/tty_io.c:1110
       call_write_iter include/linux/fs.h:2114 [inline]
       new_sync_write+0x426/0x650 fs/read_write.c:518
       vfs_write+0x75a/0xa40 fs/read_write.c:605
       ksys_write+0x12d/0x250 fs/read_write.c:658
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (&tty->termios_rwsem){++++}-{3:3}:
       down_write+0x92/0x150 kernel/locking/rwsem.c:1406
       n_tty_flush_buffer+0x1d/0x230 drivers/tty/n_tty.c:369
       tty_buffer_flush+0x1f0/0x2b0 drivers/tty/tty_buffer.c:240
       tty_ldisc_flush+0x66/0xe0 drivers/tty/tty_ldisc.c:400
       tty_port_close_start.part.0+0x22c/0x550 drivers/tty/tty_port.c:602
       tty_port_close_start drivers/tty/tty_port.c:646 [inline]
       tty_port_close+0x46/0x170 drivers/tty/tty_port.c:639
       uart_close+0x83/0x210 drivers/tty/serial/serial_core.c:1538
       tty_release+0x45e/0x1200 drivers/tty/tty_io.c:1771
       __fput+0x288/0x920 fs/file_table.c:280
       task_work_run+0xdd/0x1a0 kernel/task_work.c:164
       tracehook_notify_resume include/linux/tracehook.h:189 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:175 [inline]
       exit_to_user_mode_prepare+0x27e/0x290 kernel/entry/common.c:209
       __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
       syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
       do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&buf->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x2a07/0x54a0 kernel/locking/lockdep.c:5015
       lock_acquire kernel/locking/lockdep.c:5625 [inline]
       lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
       __mutex_lock_common kernel/locking/mutex.c:959 [inline]
       __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
       tty_buffer_flush+0x76/0x2b0 drivers/tty/tty_buffer.c:229
       tty_ldisc_flush+0x66/0xe0 drivers/tty/tty_ldisc.c:400
       __do_SAK.part.0+0xd5/0x390 drivers/tty/tty_io.c:3046
       __do_SAK+0x1b/0x30 drivers/tty/tty_io.c:3039
       vc_SAK+0x7c/0x310 drivers/tty/vt/vt_ioctl.c:990
       process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
       worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
       kthread+0x3e5/0x4d0 kernel/kthread.c:319
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295

other info that might help us debug this:

Chain exists of:
  &buf->lock --> &tty->termios_rwsem --> console_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(console_lock);
                               lock(&tty->termios_rwsem);
                               lock(console_lock);
  lock(&buf->lock);

 *** DEADLOCK ***

4 locks held by kworker/1:17/10474:
 #0: ffff888010864d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888010864d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:620 [inline]
 #0: ffff888010864d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888010864d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:617 [inline]
 #0: ffff888010864d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:644 [inline]
 #0: ffff888010864d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x871/0x1630 kernel/workqueue.c:2247
 #1: ffffc90017fe7db0 ((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at: process_one_work+0x8a5/0x1630 kernel/workqueue.c:2251
 #2: ffffffff8b96aac0 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x10/0x310 drivers/tty/vt/vt_ioctl.c:980
 #3: ffff888015c8b098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref drivers/tty/tty_ldisc.c:273 [inline]
 #3: ffff888015c8b098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_flush+0x18/0xe0 drivers/tty/tty_ldisc.c:398

stack backtrace:
CPU: 1 PID: 10474 Comm: kworker/1:17 Not tainted 5.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events vc_SAK
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
 __mutex_lock_common kernel/locking/mutex.c:959 [inline]
 __mutex_lock+0x12a/0x10a0 kernel/locking/mutex.c:1104
 tty_buffer_flush+0x76/0x2b0 drivers/tty/tty_buffer.c:229
 tty_ldisc_flush+0x66/0xe0 drivers/tty/tty_ldisc.c:400
 __do_SAK.part.0+0xd5/0x390 drivers/tty/tty_io.c:3046
 __do_SAK+0x1b/0x30 drivers/tty/tty_io.c:3039
 vc_SAK+0x7c/0x310 drivers/tty/vt/vt_ioctl.c:990
 process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
