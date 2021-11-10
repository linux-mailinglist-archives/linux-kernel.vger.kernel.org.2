Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4374344BE73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhKJKVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:21:22 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:55898 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhKJKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:21:14 -0500
Received: by mail-il1-f198.google.com with SMTP id d14-20020a056e02214e00b0026cd53452f7so1385625ilv.22
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b4Uvl9vCnp35fmvppL43Oih5hA4XWhqHuac0VaEviow=;
        b=5LTm+oeBEabZ8YkW4F/rZ9g8qkC/tvM6vRAosGiJbY2PxcCjqF6RJenBQhOeUYZyeU
         voZk0LnLyaK+E59n4u7zIGt4KIv7bagW/Qs8++Ek5KfiQov9YPx96f1dk0+sFi4FFF3R
         vvF+Wn/Fa27VsNl/2+ZinvOaGRpjrSeHHLiFSEg80kw5WfBMKiUrP/eUGNyG+aVfLJG5
         Mlr1INHbF5ur8F6x5wIaP0qZ7VFRaKdU4/2+gZvlQQt+Eljbtoav9fHdcqVo84ObsDX0
         1XmsBrb3rcd7kHq/G4JkyrS8TpSXzbtNN2MmhJZB76ZRkAH617xJzwAYTqeTekNQb0Ie
         /MQg==
X-Gm-Message-State: AOAM53356An6lozJwdmy0dbcO6Gx+Ey5q2IiKsq5ZqYbHZThSjiKDI0+
        cU1ZISbJGG73oojMjVKrXU6ZjAneCBxuAOOfcB7ZIb+Wgwx2
X-Google-Smtp-Source: ABdhPJz+EVSf+rwWHuqwhVg3UU8X8NJ365l5Iz0LyVQkN6iDtJRLL5fSuVc7vlLqJ5xsa9iQTYBGB2UYmjD/vJYGEvILLXIulHvQ
MIME-Version: 1.0
X-Received: by 2002:a92:c846:: with SMTP id b6mr10584871ilq.255.1636539506635;
 Wed, 10 Nov 2021 02:18:26 -0800 (PST)
Date:   Wed, 10 Nov 2021 02:18:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f43bb905d06c8b7f@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in __might_resched
From:   syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e851dfae4371 Merge tag 'kgdb-5.16-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14078392b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25617f80cd596994
dashboard link: https://syzkaller.appspot.com/bug?extid=5f47a8cea6a12b77a876
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/printk/printk.c:2522
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 21727, name: syz-executor.3
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor.3/21727:
 #0: ffff888022671098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888022671468 (&tty->flow.lock){....}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:375 [inline]
 #1: ffff888022671468 (&tty->flow.lock){....}-{2:2}, at: n_tty_ioctl_helper+0xb6/0x2d0 drivers/tty/tty_ioctl.c:877
 #2: ffff888022671098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
irq event stamp: 236
hardirqs last  enabled at (235): [<ffffffff81be7585>] kasan_quarantine_put+0xf5/0x210 mm/kasan/quarantine.c:220
hardirqs last disabled at (236): [<ffffffff893c12f1>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (236): [<ffffffff893c12f1>] _raw_spin_lock_irq+0x41/0x50 kernel/locking/spinlock.c:170
softirqs last  enabled at (0): [<ffffffff8144aeac>] copy_process+0x1e8c/0x75a0 kernel/fork.c:2136
softirqs last disabled at (0): [<0000000000000000>] 0x0
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 21727 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9539
 console_lock+0x17/0x80 kernel/printk/printk.c:2522
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
RIP: 0033:0x7f5a77a72ae9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5a74fe8188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5a77b85f60 RCX: 00007f5a77a72ae9
RDX: 0000000000000001 RSI: 000000000000540a RDI: 0000000000000003
RBP: 00007f5a77accf25 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5a780b9b2f R14: 00007f5a74fe8300 R15: 0000000000022000
 </TASK>
BUG: scheduling while atomic: syz-executor.3/21727/0x00000002
3 locks held by syz-executor.3/21727:
 #0: ffff888022671098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffff888022671468 (&tty->flow.lock){+.+.}-{2:2}, at: spin_lock_irq include/linux/spinlock.h:375 [inline]
 #1: ffff888022671468 (&tty->flow.lock){+.+.}-{2:2}, at: n_tty_ioctl_helper+0xb6/0x2d0 drivers/tty/tty_ioctl.c:877
 #2: ffff888022671098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
