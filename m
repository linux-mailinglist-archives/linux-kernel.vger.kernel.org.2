Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96812452C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhKPIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:12:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48777 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhKPIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:12:08 -0500
Received: by mail-il1-f199.google.com with SMTP id h11-20020a92c26b000000b0026c4b63618fso12245144ild.15
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vn4FhEBss6pDvp/WJ6CIyXKtFAJCVTA3t1tnZ8laTo0=;
        b=vVkeC8Q3HA4WPY8c9+AJBwi9QrDx7UrZL7me/PIfuveoaLmXB02sKw/K3JM4BdZoG7
         AN1al33iLbtGsRd4R9n3SjioEFH2XndtIFTdjlaiGjHk6lWSp/TKuBpqC1RiLGg1rBmU
         ear278OHv+CTHUopkR+QX+YAwTBSVzo1mhq9PESg8UiUZuaGAn8R/+CZ0So7/iFp7P0x
         dyDqQ0TEHiDSkBb82hEMCG6gC3afVtUjq0JSBsbNxgKF2Z4YWYwCm2c5WsrCw1GTH4Da
         gfjsPkGQUdP72bRXgV/BKZFw63tmSXYrC09lAfHcaMHAqtAFBOMhFMvts0WQCeeZ8edQ
         3Llg==
X-Gm-Message-State: AOAM530ZTd08Xq1v+XNH0KijtRBJDA+ck09TA12p0eAJum8HWwc4CYTQ
        Y/HvdXY2ekv2mLWIgyTKoFeRQ/a1OIBPKI8JXgVrVcBgeTKX
X-Google-Smtp-Source: ABdhPJz43St/HkTtb7e4jCawwWEEojES6puO5rBcFl/8Of/V0ReZSu5JLuocFM5dtnAHezFo/2dzn/NXgB1+wVpFxxnj1JVOlZEI
MIME-Version: 1.0
X-Received: by 2002:a02:712c:: with SMTP id n44mr3957179jac.92.1637050151233;
 Tue, 16 Nov 2021 00:09:11 -0800 (PST)
Date:   Tue, 16 Nov 2021 00:09:11 -0800
In-Reply-To: <10635720.r0gBeNIlcX@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be6cff05d0e3709b@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
From:   syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
To:     elver@google.com, fmdefrancesco@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in __might_resched

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2522
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 8755, name: syz-executor.2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor.2/8755:
 #0: ffff888070c9a098
 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888070c9a468
 (&tty->flow.lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
 (&tty->flow.lock){....}-{2:2}, at: n_tty_ioctl_helper+0xb6/0x2d0 drivers/tty/tty_ioctl.c:877
 #2: ffff888070c9a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
irq event stamp: 916
hardirqs last  enabled at (915): [<ffffffff81beabd5>] kasan_quarantine_put+0xf5/0x210 mm/kasan/quarantine.c:220
hardirqs last disabled at (916): [<ffffffff8950a731>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (916): [<ffffffff8950a731>] _raw_spin_lock_irq+0x41/0x50 kernel/locking/spinlock.c:170
softirqs last  enabled at (0): [<ffffffff8144cf0c>] copy_process+0x1e8c/0x75a0 kernel/fork.c:2136
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 8755 Comm: syz-executor.2 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9542
 console_lock+0x17/0x80 kernel/printk/printk.c:2522
 con_flush_chars drivers/tty/vt/vt.c:3365 [inline]
 con_flush_chars+0x35/0x90 drivers/tty/vt/vt.c:3357
 con_write+0x2c/0x40 drivers/tty/vt/vt.c:3296
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
RIP: 0033:0x7f9322bb3ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9322329188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9322cc6f60 RCX: 00007f9322bb3ae9
RDX: 0000000000000001 RSI: 000000000000540a RDI: 0000000000000005
RBP: 00007f9322c0df6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe7ad1cc3f R14: 00007f9322329300 R15: 0000000000022000
 </TASK>
BUG: scheduling while atomic: syz-executor.2/8755/0x00000002
3 locks held by syz-executor.2/8755:
 #0: ffff888070c9a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888070c9a468 (&tty->flow.lock){+.+.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:374 [inline]
 #1: ffff888070c9a468 (&tty->flow.lock){+.+.}-{2:2}, at: n_tty_ioctl_helper+0xb6/0x2d0 drivers/tty/tty_ioctl.c:877
 #2: ffff888070c9a098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


Tested on:

commit:         8ab77458 Merge tag 'trace-v5.16-5' of git://git.kernel..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git --
console output: https://syzkaller.appspot.com/x/log.txt?x=16dd826eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2db820d271ec6d2
dashboard link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c10b69b00000

