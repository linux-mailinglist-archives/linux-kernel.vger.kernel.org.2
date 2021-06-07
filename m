Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC66539E124
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhFGPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:48:33 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:52196 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhFGPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:48:31 -0400
Received: by mail-io1-f70.google.com with SMTP id d17-20020a0566021851b02904c0de164d44so773022ioi.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 08:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TrMhmU0JCMnXZFPSiuVYpKbEcdcwJ8R8CkELJLbUjHw=;
        b=L0EROg4tfYwQEiBVrOX8keL0NxqM90nwuI1sULBNkwKw7juLpLFsr0Vj5rJQrG7wFf
         oBBa6Adxysq6eSrQRc8duKP965tAHMP7fokXZzurH48+KkdD3gATL4uSPjKgvKJR6NS7
         lBf5bmflzkvN0UcQ4ZcXUFLcmqac7UQi57MxJxvlV69VdeLB0FdzTU/vxcTeq/M4n6oo
         XzxMo5dX58EKDeVWEHV+W1tXMVAXyOEr1fCav9JcKef4gGYZ4mL7Pl7sg1QD9FaMO1/E
         KBTgqGOkQmuH57Iqo9Co+Oi7UA7tXB44ggTbgWphBceej98LGAxhj3FeLzuJJMLevRjv
         7tcA==
X-Gm-Message-State: AOAM531Z0Zd7KLbpwHUb6PFBsCOiy2uzIoJuSEgpJ8cqvpAZgW01VOR0
        UdLCetRX68DR7YFxgDT6A0b0biSY34AVSMgVrBBZmoywYxZP
X-Google-Smtp-Source: ABdhPJzfNxCRnxvzSAMT/fI/+MN9OdMlENIoNPg3dkobV2Uv1lQwNevTRucuL91b06tBe7LxW4cvIwuxjC2xpOXjPT62XugAZtPF
MIME-Version: 1.0
X-Received: by 2002:a92:ccd1:: with SMTP id u17mr15425574ilq.239.1623080786444;
 Mon, 07 Jun 2021 08:46:26 -0700 (PDT)
Date:   Mon, 07 Jun 2021 08:46:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7ca4c05c42ef16c@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in
 console_lock (2)
From:   syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e5220dd1 Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fbe875d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a9e9956ca52a5f6
dashboard link: https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ae4ec0300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f3c6c0300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13e0c2e0300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1010c2e0300000
console output: https://syzkaller.appspot.com/x/log.txt?x=17e0c2e0300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2460
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 8430, name: syz-executor396
3 locks held by syz-executor396/8430:
 #0: ffff88801f8ff098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffff88801f8ff3f8 (&tty->flow_lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:379 [inline]
 #1: ffff88801f8ff3f8 (&tty->flow_lock){....}-{2:2}, at: n_tty_ioctl_helper+0xcc/0x3a0 drivers/tty/tty_ioctl.c:857
 #2: ffff88801f8ff098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:288
irq event stamp: 16848
hardirqs last  enabled at (16847): [<ffffffff89193940>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (16847): [<ffffffff89193940>] _raw_spin_unlock_irqrestore+0x50/0x70 kernel/locking/spinlock.c:191
hardirqs last disabled at (16848): [<ffffffff891936a1>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:126 [inline]
hardirqs last disabled at (16848): [<ffffffff891936a1>] _raw_spin_lock_irq+0x41/0x50 kernel/locking/spinlock.c:167
softirqs last  enabled at (15244): [<ffffffff812aa603>] fpu__clear+0xd3/0x220 arch/x86/kernel/fpu/core.c:379
softirqs last disabled at (15242): [<ffffffff812aa55a>] fpu__clear+0x2a/0x220 arch/x86/kernel/fpu/core.c:364
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 8430 Comm: syz-executor396 Not tainted 5.13.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:8338
 console_lock+0x19/0x80 kernel/printk/printk.c:2460
 do_con_write+0x10f/0x1e60 drivers/tty/vt/vt.c:2868
 con_write+0x21/0x40 drivers/tty/vt/vt.c:3255
 n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
 tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
 __start_tty drivers/tty/tty_io.c:822 [inline]
 __start_tty+0x116/0x150 drivers/tty/tty_io.c:815
 n_tty_ioctl_helper+0x348/0x3a0 drivers/tty/tty_ioctl.c:860
 n_hdlc_tty_ioctl+0xe4/0x360 drivers/tty/n_hdlc.c:631
 tty_ioctl+0xef9/0x1600 drivers/tty/tty_io.c:2814
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_64+0x3a/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43f159
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc20312ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043f159
RDX: 0000000000000001 RSI: 000000000000540a RDI: 0000000000000003
RBP: 0000000000402fe0 R08: 0000000000400488 R09: 0000000000400488


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
