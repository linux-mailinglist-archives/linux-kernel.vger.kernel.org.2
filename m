Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E681044F535
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 21:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhKMUQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 15:16:19 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56973 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhKMUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 15:16:17 -0500
Received: by mail-il1-f197.google.com with SMTP id h14-20020a056e021d8e00b002691dcecdbaso7801821ila.23
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:13:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RJjJDAT6CKIWY1SeSj+yIgHbS8v3uCTnBSNnSc23uH0=;
        b=psuavo4BF0bQ8KPL7yd958hsEk3V3KBDGWvfzmXu3SXX5KNoe+R4vAHa1l9gUI4jDE
         ApjpF8AQe4UkVqReF1/sC34VL/K87uXNTnT1Q7uQpAxBQBcHHizY426U3VGdSSOQNIOF
         +sGHxuLmaeRXZJq/e24EEkPQCtuGdhYQe1RgaylLy5KdvUa1HRJyopMMg/kNW9vwzgUM
         ELq3+wbwqdfFpUHvI0AzmvDzbQ0TK2YrbQJe4PjYSO0HlfCVQEUE1XRVWv7my2gLSbFq
         PSOELb1SVhTVdYIfJArtGTR1oKUYcoXAAkXx7m+mao291NF27jlugGJMu8WH7U3gK3Fi
         kXbw==
X-Gm-Message-State: AOAM530vwtDO57o9CfUpBwR/kHM1tIfXSG09tGooZqYjpsYniw2xZoIS
        NP9TyptY3fCerg5jz2zOLVrjXjTJ7IgYYT4DTzf8jQDlEOgt
X-Google-Smtp-Source: ABdhPJyKomM2ryFQomI0jcUr2+vKuukAhPQG70U/coveGMALIykEy5VZsqgRNr4nTUl8kOqBI9C3wJ7yYvfzPKoTSBTWbjUGRsJR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:: with SMTP id m39mr19460191jav.75.1636834404660;
 Sat, 13 Nov 2021 12:13:24 -0800 (PST)
Date:   Sat, 13 Nov 2021 12:13:24 -0800
In-Reply-To: <000000000000f43bb905d06c8b7f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003efce905d0b135e6@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
From:   syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
To:     elver@google.com, fmdefrancesco@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f2e19fd15bd7 Add linux-next specific files for 20211112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15def132b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c83199208e103
dashboard link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdb2c9b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109194aab00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2525
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6529, name: syz-executor925
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor925/6529:
 #0: ffff888018d79098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888018d79468 (&tty->flow.lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
 #1: ffff888018d79468 (&tty->flow.lock){....}-{2:2}, at: n_tty_ioctl_helper+0xb6/0x2d0 drivers/tty/tty_ioctl.c:877
 #2: ffff888018d79098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
irq event stamp: 16252
hardirqs last  enabled at (16251): [<ffffffff8952dbc0>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (16251): [<ffffffff8952dbc0>] _raw_spin_unlock_irqrestore+0x50/0x70 kernel/locking/spinlock.c:194
hardirqs last disabled at (16252): [<ffffffff8952d921>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (16252): [<ffffffff8952d921>] _raw_spin_lock_irq+0x41/0x50 kernel/locking/spinlock.c:170
softirqs last  enabled at (14452): [<ffffffff812bc45c>] fpu_reset_fpregs arch/x86/kernel/fpu/core.c:601 [inline]
softirqs last  enabled at (14452): [<ffffffff812bc45c>] fpu_flush_thread+0x23c/0x390 arch/x86/kernel/fpu/core.c:647
softirqs last disabled at (14450): [<ffffffff812bc3eb>] fpstate_reset arch/x86/kernel/fpu/core.c:452 [inline]
softirqs last disabled at (14450): [<ffffffff812bc3eb>] fpu_flush_thread+0x1cb/0x390 arch/x86/kernel/fpu/core.c:646
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 6529 Comm: syz-executor925 Not tainted 5.15.0-next-20211112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9554
 console_lock+0x17/0x80 kernel/printk/printk.c:2525
 do_con_write+0x10f/0x1e40 drivers/tty/vt/vt.c:2908
 con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
 n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
 tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
 __start_tty drivers/tty/tty_io.c:806 [inline]
 __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
 n_tty_ioctl_helper+0x299/0x2d0 drivers/tty/tty_ioctl.c:880
 n_hdlc_tty_ioctl+0xd2/0x340 drivers/tty/n_hdlc.c:633
 tty_ioctl+0xc69/0x1670 drivers/tty/tty_io.c:2814
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f16c8522349
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6ccb8b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f16c8522349
RDX: 0000000000000001 RSI: 000000000000540a RDI: 0000000000000005
RBP: 00007f16c84e61d0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000

