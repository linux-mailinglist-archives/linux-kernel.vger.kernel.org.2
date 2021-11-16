Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B54452C49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhKPIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhKPIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:00:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C61DC061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:57:53 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w1so83983810edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 23:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+/xPiZQB+UC7sbKipcx9KJDi05lxsXzCw6EdHSdnEp0=;
        b=Q483gRu3RrbdaxAZCj32ypARtIQV3z/G7qVS4P+B7wYEpSpVpE26F1KrY3cuHMVNsH
         hM+phHJM4qX9MQ0yRPVK6Bah04m05vh+EmHDhICsT0f0mfjKLZqcqv6eZuNDvHS5Tdee
         Ql0DbRCZjP0XkBAz7sNEqtRHxAR4AIXSq6kkLYaszpvF4QEfCndP6w7eNt5wSmGXkYba
         biHnL4n9NrI8nXo7jNJta+AU4wz+PvpGzJNkFwysThp8r2jlOI9lYtHTFXrBk0SHToqT
         H24b3QDflL/HwZhO6kM5Y2nNTXhPzZhtWCBOBqPmz/T9qe5ZN0HP7sT5RsNYcBGei0/g
         Bsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+/xPiZQB+UC7sbKipcx9KJDi05lxsXzCw6EdHSdnEp0=;
        b=Whh5ORFxJZvLgvNTm2FMlR3a2l6NR0IfbxEO/EJTmUOd8jron0NkEwYwUgfuz5ndkj
         8R77gTh4vKNTsXSCMnMO6qKwasWZ6N28TrzyCb5qWdeICPifCbJD817TT1xY0OVkaTkl
         TkLPbnvlSUO8FC5oDyM7JIXV29y1k4RUd7GpwiVVCiqqrGWiPgymCpIRCtoCd4I7tpOu
         27iWvJVfJR9pCcW2oMhgsVyN1KDbvr80JMy2Rryh+7howxZll73vh36kQps9Kfhq4rsh
         p/jPSgJfjkIK0N2UC9HQA85Mj2x4zWqU/1sN8T5TECAqKhxb7cjROiPrhQDPe6F+JEyS
         Rtbg==
X-Gm-Message-State: AOAM531CfrB+nKiC1ImbCKlXyKPOdJnHDNNqUSdVjq34byOsUxv8w7vH
        Ztv3h2sYn0F0G48RtVUJ4RA=
X-Google-Smtp-Source: ABdhPJzwYwWCt7XUZ1PKx8YO58KMMLbMrO2BKUbkAGHqkmsvXF2Sd+bdHrz9LB94u4wHfXhHRPK6GA==
X-Received: by 2002:a05:6402:51c6:: with SMTP id r6mr7442736edd.365.1637049472014;
        Mon, 15 Nov 2021 23:57:52 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id go10sm7796284ejc.115.2021.11.15.23.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 23:57:51 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
Date:   Tue, 16 Nov 2021 08:57:49 +0100
Message-ID: <10635720.r0gBeNIlcX@localhost.localdomain>
In-Reply-To: <0000000000003efce905d0b135e6@google.com>
References: <0000000000003efce905d0b135e6@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart12407418.tSIYDGc9g1"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart12407418.tSIYDGc9g1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Saturday, November 13, 2021 9:13:24 PM CET syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f2e19fd15bd7 Add linux-next specific files for 20211112
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15def132b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ba9c83199208e103
> dashboard link: https://syzkaller.appspot.com/bug?
extid=5f47a8cea6a12b77a876
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils 
for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdb2c9b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109194aab00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the 
commit:
> Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> 
> BUG: sleeping function called from invalid context at kernel/printk/
printk.c:2525
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6529, name: syz-
executor925
> preempt_count: 1, expected: 0
> RCU nest depth: 0, expected: 0
> 3 locks held by syz-executor925/6529:
>  #0: ffff888018d79098 (&tty->ldisc_sem){++++}-{0:0}, at: 
tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
>  #1: ffff888018d79468 (&tty->flow.lock){....}-{2:2}, at: spin_lock_irq 
include/linux/spinlock.h:379 [inline]
>  #1: ffff888018d79468 (&tty->flow.lock){....}-{2:2}, at: 
n_tty_ioctl_helper+0xb6/0x2d0 drivers/tty/tty_ioctl.c:877
>  #2: ffff888018d79098 (&tty->ldisc_sem){++++}-{0:0}, at: 
tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
> irq event stamp: 16252
> hardirqs last  enabled at (16251): [<ffffffff8952dbc0>] 
__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last  enabled at (16251): [<ffffffff8952dbc0>] 
_raw_spin_unlock_irqrestore+0x50/0x70 kernel/locking/spinlock.c:194
> hardirqs last disabled at (16252): [<ffffffff8952d921>] __raw_spin_lock_irq 
include/linux/spinlock_api_smp.h:117 [inline]
> hardirqs last disabled at (16252): [<ffffffff8952d921>] 
_raw_spin_lock_irq+0x41/0x50 kernel/locking/spinlock.c:170
> softirqs last  enabled at (14452): [<ffffffff812bc45c>] fpu_reset_fpregs 
arch/x86/kernel/fpu/core.c:601 [inline]
> softirqs last  enabled at (14452): [<ffffffff812bc45c>] 
fpu_flush_thread+0x23c/0x390 arch/x86/kernel/fpu/core.c:647
> softirqs last disabled at (14450): [<ffffffff812bc3eb>] fpstate_reset arch/
x86/kernel/fpu/core.c:452 [inline]
> softirqs last disabled at (14450): [<ffffffff812bc3eb>] 
fpu_flush_thread+0x1cb/0x390 arch/x86/kernel/fpu/core.c:646
> Preemption disabled at:
> [<0000000000000000>] 0x0
> CPU: 0 PID: 6529 Comm: syz-executor925 Not tainted 5.15.0-next-20211112-
syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
Google 01/01/2011
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9554
>  console_lock+0x17/0x80 kernel/printk/printk.c:2525
>  do_con_write+0x10f/0x1e40 drivers/tty/vt/vt.c:2908
>  con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
>  n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
>  tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
>  __start_tty drivers/tty/tty_io.c:806 [inline]
>  __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
>  n_tty_ioctl_helper+0x299/0x2d0 drivers/tty/tty_ioctl.c:880
>  n_hdlc_tty_ioctl+0xd2/0x340 drivers/tty/n_hdlc.c:633
>  tty_ioctl+0xc69/0x1670 drivers/tty/tty_io.c:2814
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:874 [inline]
>  __se_sys_ioctl fs/ioctl.c:860 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f16c8522349
> Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 
73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff6ccb8b98 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f16c8522349
> RDX: 0000000000000001 RSI: 000000000000540a RDI: 0000000000000005
> RBP: 00007f16c84e61d0 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000

I think that thanks to Marco Elver we have a solution for this issue.

However I'd propose a transformation on Marco's solution based on one of the 
De Morgan's laws: !(A && B) <=> !A || !B. 

I think that this is more readable and comprehensible.

Therefore, if I'm not wrong, Marco's "!preemptible()", that is "if (!
(preempt_count() == 0 && !irqs_disabled())", might be rewritten to an easier 
to understand "if (preempt_count() || irqs_disabled())". 

Am I wrong? Let's test it...

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

--
Fabio M. De Francesco


--nextPart12407418.tSIYDGc9g1
Content-Disposition: attachment; filename="vt.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="vt.c.diff"

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63..a0c6d29eb2a6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (preempt_count() || irqs_disabled())
 		return count;
 
 	console_lock();

--nextPart12407418.tSIYDGc9g1--



