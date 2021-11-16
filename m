Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586DF452DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 10:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbhKPJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 04:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhKPJQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 04:16:20 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACFFC061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:13:23 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b15so84368564edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 01:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Titug5d67LzpBF68sn9rEkCJ8fbreaCra8Rn/2rSVL8=;
        b=FMmWdviJTqpKdRAswaiyMY/meHHxG82lC9WXaA25U7ch/lWITSwShgK0qvTRxxZwlT
         YxgKRSDWukZ92jDt35cCOk02TiOfwGFi45N7JkdrFB1r0VC/Ph1MvNn9LRm9BpXCKrhu
         0fUpT2DZNNLnbc9twWs1C/lregtFKr7G4mnUTbjlfRnFfKSRbC8icrC4RPXSLcSGrrno
         U9IJR5++5vqUNHiCBw6yM/tbcQh3Cbo2tYLjOExTFasPSNSsCjovBO0o0wRfB+met/Dc
         NhqyY+QbT9D4zAgTBHJvOXA+Mxta3pAT4vCEmTJTgYVHPIi5SJNOccpM7/ZWC+tq7JoK
         IpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Titug5d67LzpBF68sn9rEkCJ8fbreaCra8Rn/2rSVL8=;
        b=D/nY/s5YiCukag6sJE/TY9FA/zJMA7OHQY4vL+EoyIWHa+5qQwBmh4St+3y2Fu1wu1
         WhLf/vAXW64uZct4eRmSry2sEFMuDYjJ1YBZkijoBkxBvLc102qAvicZo7CzhwRXUWNB
         ns6dR9QCrzDIhGwM7mOaOU5iaFg2n35r1G5rwxMDVH04L5UcAIYQlM8qAOvCDK2rYkfI
         itCrtm2GpTR1FtzHkRDPEmGHuXczxgOe2AiI5M4fya/EHojWruJGq0aHmENDiI5eq56f
         tmbS5jFXdh1UNTiB72qNIoIUnJKE+c06FoVIqoCto+WwLLa1HTPBxjqB/M81Z+3oM3NS
         DaHw==
X-Gm-Message-State: AOAM5331wNLIff8+efic3rThCcj/0Op3wTjqEHFTK9jB+5xvtI+4a5uo
        /VKpKOixq0O9ohjQMJOF7ckFtAe/7AM=
X-Google-Smtp-Source: ABdhPJySJW/ML5mMqldsYYTSiOG5Jevc9WEJ+6Wi2E8TlPh2uEEXP9/ahwoMJlPGxYysBza7si0ApA==
X-Received: by 2002:a05:6402:486:: with SMTP id k6mr8147704edv.315.1637054001919;
        Tue, 16 Nov 2021 01:13:21 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id gn26sm7919967ejc.14.2021.11.16.01.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 01:13:21 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     elver@google.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in __might_resched
Date:   Tue, 16 Nov 2021 10:13:19 +0100
Message-ID: <3786254.cann4MMnV1@localhost.localdomain>
In-Reply-To: <5631140.hc6UrLtR2d@localhost.localdomain>
References: <000000000000be6cff05d0e3709b@google.com> <5631140.hc6UrLtR2d@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2317752.Q3uhY6xqpY"
Content-Transfer-Encoding: 7Bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart2317752.Q3uhY6xqpY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday, November 16, 2021 9:53:53 AM CET Fabio M. De Francesco wrote:
> On Tuesday, November 16, 2021 9:09:11 AM CET syzbot wrote:
> > Hello,
> > 
> > syzbot has tested the proposed patch but the reproducer is still 
triggering 
> an issue:
> > BUG: sleeping function called from invalid context in __might_resched
> > 
> > BUG: sleeping function called from invalid context at kernel/printk/
> printk.c:2522
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 8755, name: syz-
> executor.2
> > preempt_count: 1, expected: 0
> > RCU nest depth: 0, expected: 0
> > 3 locks held by syz-executor.2/8755:
> >  #0: ffff888070c9a098
> >  (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/
> tty/tty_ldisc.c:252
> >  #1: ffff888070c9a468
> >  (&tty->flow.lock){....}-{2:2}, at: spin_lock_irq include/linux/
spinlock.h:
> 374 [inline]
> >  (&tty->flow.lock){....}-{2:2}, at: n_tty_ioctl_helper+0xb6/0x2d0 
drivers/
> tty/tty_ioctl.c:877
> >  #2: ffff888070c9a098 (&tty->ldisc_sem){++++}-{0:0}, at: 
> tty_ldisc_ref+0x1d/0x80 drivers/tty/tty_ldisc.c:273
> > irq event stamp: 916
> > hardirqs last  enabled at (915): [<ffffffff81beabd5>] 
> kasan_quarantine_put+0xf5/0x210 mm/kasan/quarantine.c:220
> > hardirqs last disabled at (916): [<ffffffff8950a731>] __raw_spin_lock_irq 
> include/linux/spinlock_api_smp.h:117 [inline]
> > hardirqs last disabled at (916): [<ffffffff8950a731>] 
> _raw_spin_lock_irq+0x41/0x50 kernel/locking/spinlock.c:170
> > softirqs last  enabled at (0): [<ffffffff8144cf0c>] copy_process+0x1e8c/
> 0x75a0 kernel/fork.c:2136
> > softirqs last disabled at (0): [<0000000000000000>] 0x0
> > Preemption disabled at:
> > [<0000000000000000>] 0x0
> > CPU: 1 PID: 8755 Comm: syz-executor.2 Not tainted 5.16.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS 
> Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9542
> >  console_lock+0x17/0x80 kernel/printk/printk.c:2522
> >  con_flush_chars drivers/tty/vt/vt.c:3365 [inline]
> >  con_flush_chars+0x35/0x90 drivers/tty/vt/vt.c:3357
> >  con_write+0x2c/0x40 drivers/tty/vt/vt.c:3296
> 
> The reproducer is still triggering an issue, but this time it looks like it 
> is triggered by a different path of execution.
> 
> The same invalid "in_interrupt()" test is also in con_flush_chars().
> 
> Let's try to remove it too...
> 
> My first idea would be to replace "if (in_interrupt())" with the same 
> "preempt_count() || irqs_disabled()" I used in do_con_write(). However I 
> noticed that both do_con_write() and con_flush_chars() are only called from 
> inside con_write() (which, aside from calling those functions, does nothing 
> else).
> 
> So why not remove the if (in_interrupt()) from both them and use if 
> (preempt_count() || irqs_disabled()) just once in con_write()?
> 
> I think this should be the right solution, but I prefer to go one step at a 
> time.
> 
> Therefore, I'll (1) use the same (redundant, if it was used in con_write()) 
> test also in con_flush_chars(), (2) wait for Syzbot to confirm that it 
fixes 
> the bug, and (3) wait for maintainers review and suggestions about whether 
or 
> not moving those tests one level upper.
> 

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

> 
> ---
> Fabio M. De Francesco
> 


--nextPart2317752.Q3uhY6xqpY
Content-Disposition: attachment; filename="vt.c.diff"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="vt.c.diff"

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63..46511d1ac6ee 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (preempt_count() || irqs_disabled())
 		return count;
 
 	console_lock();
@@ -3358,7 +3358,7 @@ static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vc_data *vc;
 
-	if (in_interrupt())	/* from flush_to_ldisc */
+	if (preempt_count() || irqs_disabled())	/* from flush_to_ldisc */
 		return;
 
 	/* if we race with con_close(), vt may be null */

--nextPart2317752.Q3uhY6xqpY--



