Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7075C454296
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhKQI0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhKQI0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:26:50 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9217C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:23:51 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so7587146edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUJ5GsxcE2rvyfjoAWwvuJvQfqlnlJtrA5yPAMDK4XE=;
        b=eOk08KjkvrPkWch0M55T2QDuQA2avxTpHSJfxhV9ckixY7NqFPyiI9zLWlkRPjN0Nu
         aCx+HhUr7cnkEaU3PBzTMITzinT1hX2c9XSQh3UeOIjwlHblqkhY6e9EgWfL9n5+8RnE
         hoZfypxvMxy92l20H1ih96/9XFvEPgAy8byUOOCscr8meH+BIwXOq+DqxT2hHwVMD8Vo
         OxuByXujSOF9DpooHofWN5fl1iljSrzdcqm4MJFwbIJ800hhyJabLImsX1+rsssq4HA5
         CvYmnwsyqwJKHVYgY2w4ZxWaoHvq4SoEzYNSq13Azlqlp8lhPTmvKh9aeEbJhft7gjCC
         EStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUJ5GsxcE2rvyfjoAWwvuJvQfqlnlJtrA5yPAMDK4XE=;
        b=7epblQNhzzfVwlj50yxq5OzwgrJiw3mPKgnA2t2bbTH0FpUz5vQUALIEdoLWOcIdrF
         a4jkpuub4EyHsfw3d41l5QK8u5C69h7HNE3qKyH62Ww6ep3voZ35qYCsQfWDiAGrw68U
         wQpdVR6z15vJnTy1guU/57NqrC+gtMFb/RecEP1nDjdKw381HQANQmn1coWTtw4k13/W
         CvnWGI7yCwhzYHUDk/CSn/GzT4QjJ9RZhoaApqtgXC2/FyeCzQcM2/mMq8lmUDdzVOfj
         wMfF4nuTyn9EIAvDg6gxnbECfjxQr/Bzuf5INv/4AmiPbk0dCxpyrhmRvot4Bvaon9S9
         FeOQ==
X-Gm-Message-State: AOAM533x1dNLXXpdSwZfYkbHTYdyM+1C6YLdCipVgXp3E1nRP6iO7OAG
        hDSYfx4Ggr6ZpsFqkcOHDag=
X-Google-Smtp-Source: ABdhPJzCbuWp4MY9gz6WveId/KjYzOwZTr2q4eWi+Ob2Oqwdzyo89zoDRPyTylvExMyZaQTayqI8NQ==
X-Received: by 2002:a05:6402:8:: with SMTP id d8mr20010513edu.61.1637137430157;
        Wed, 17 Nov 2021 00:23:50 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id h10sm10866155edb.59.2021.11.17.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 00:23:49 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        nick black <dankamongmen@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Date:   Wed, 17 Nov 2021 09:23:45 +0100
Message-ID: <1851530.LmWsTuDv9j@localhost.localdomain>
In-Reply-To: <YZPjbI/uCNtugFJZ@kroah.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <2524108.PJBYKFOWIp@localhost.localdomain> <YZPjbI/uCNtugFJZ@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 16, 2021 5:59:24 PM CET Greg Kroah-Hartman wrote:
> On Tue, Nov 16, 2021 at 04:35:07PM +0100, Fabio M. De Francesco wrote:
> > On Tuesday, November 16, 2021 3:58:44 PM CET Greg Kroah-Hartman wrote:
> > > On Tue, Nov 16, 2021 at 03:49:37PM +0100, Fabio M. De Francesco wrote:
> > > > Fix two sleeping functions called from atomic context by doing 
immediate
> > > > return to the caller if !preemptible() evaluates 'true'. Remove two
> > > > in_interrupt() tests because they are not suited for being used here.
> > > > 
> > > > Since functions do_con_write() and con_flush_chars() might sleep in
> > > > console_lock(), it must be assured that they are never executed in
> > > > atomic contexts.
> > > > 
> > > > This issue is reported by Syzbot which notices that they are executed
> > > > while holding spinlocks and with interrupts disabled. Actually Syzbot
> > > > emits a first report and then, after fixing do_con_write(), a second
> > > > report for the same problem in con_flush_chars() because these 
functions
> > > > are called one after the other by con_write().
> > > > 
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> > > > Suggested-by: Marco Elver <elver@google.com>
> > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > ---
> > > >  drivers/tty/vt/vt.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > > index 7359c3e80d63..508f8a56d361 100644
> > > > --- a/drivers/tty/vt/vt.c
> > > > +++ b/drivers/tty/vt/vt.c
> > > > @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, 
> > const unsigned char *buf, int co
> > > >  	struct vt_notifier_param param;
> > > >  	bool rescan;
> > > >  
> > > > -	if (in_interrupt())
> > > > +	if (!preemptible())
> > > >  		return count;
> > > 
> > > Very odd, what code is calling these functions to trigger this check?
> > 
> > This is the call trace reported by Syzbot (https://syzkaller.appspot.com/
bug?
> > id=fe5a4d5a2482bd73064db5de5d28e024f1e2a387):
> > 
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9539
> >  console_lock+0x17/0x80 kernel/printk/printk.c:2522
> >  do_con_write+0x10f/0x1e40 drivers/tty/vt/vt.c:2908
> >  con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
> >  n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
> >  tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
> >  __start_tty drivers/tty/tty_io.c:806 [inline]
> >  __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> >  n_tty_ioctl_helper+0x299/0x2d0 drivers/tty/tty_ioctl.c:880
> > 
> > 	^^^^^^^^^^
> > n_tty_ioctl_helper() disabled interrupts via spin_lock_irq(&tty-
>flow.lock).
> > 
> >  n_hdlc_tty_ioctl+0xd2/0x340 drivers/tty/n_hdlc.c:633
> >  tty_ioctl+0xc69/0x1670 drivers/tty/tty_io.c:2814
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:874 [inline]
> >  __se_sys_ioctl fs/ioctl.c:860 [inline]
> >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > > Shouldn't the caller be fixed instead?
> > 
> > Maybe that the caller has no need to disable IRQs, but I cannot yet 
answer to 
> > this particular question.
> > 
> > > What changed to suddenly cause this to show up?
> > 
> > Commit c545b66c6922 ("tty: Serialize tcflow() with other tty flow control 
> > changes") introduced a call to spin_lock_irq() for command "TCOON", just 
> > before calling __start_tty().
> 
> That commit happened in 2014.  Why is this suddenly an issue now that no
> one ever saw before?

Hi Greg,

I have just been informed by Pavel Skripkin (who at this moment cannot 
directly write to LKML) that this bug has been reported at least other two 
times. 

We cannot say why nobody has ever addressed this issue before.

Please read the following reports.

https://syzkaller.appspot.com/bug?id=9ed44c22919e3cd2c71907b963fb048ac1115073
https://syzkaller.appspot.com/bug?id=e806305a3a65a0bb2f1be7e672819a079d558016

Thanks,

Fabio

> I am worried you are not actually fixing the real issue here by just
> making syzbot be quiet.  Can you work to figure out what the real issue
> is please?
> 
> thanks,
> 
> greg k-h
> 




