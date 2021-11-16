Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7226F4535E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbhKPPib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhKPPiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:38:13 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:35:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y13so14658985edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 07:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyYmGZuh7SBnRPAJuSflACm1W39YcvEId0U7HmwLVyk=;
        b=NiPDvp3ooXIUxVB/FT51IGVKvAB0fd/U/TT7bOH432SyxZz+EM+9pZtc2DkL3v2epV
         vSaLEYclsiCa1+iZzY8CccFxcSpVMn7VHscJ715UKJBF6M/2D1LqZljvlTsWy94wWZ4o
         HyCRjtXTbY+yVv/XLDJ24bsq084isHANs04SXtq3nJx26cLSnWwoMEtpVpAAuDZZplfw
         UW4QLqGxbT0qCVqeHoeb4pHUy3uHEUr1uwWfR+Eu3vVxDd3M+9JiI8JqBMieZ/PGilaI
         5KtMqMOsZd6c00QFl1pW3ZZRx5ofu9PEcV91M49bv2NBr+1G1m6o2/NvSMNjZUv6TmJq
         AhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyYmGZuh7SBnRPAJuSflACm1W39YcvEId0U7HmwLVyk=;
        b=LQIuyx1dr1EUVuUn6XByu76s849uor0lmSIHa4iHKwsEavcUUexzEkm6FLyAJ9u4/n
         iYQse0AsDiJSs9Q/3+AJv+0Pfik0iARmKV7cvg+d+xOP93lvxeeYGB8PNe18nMp8KODW
         AWSGrg8EB4Lul0im5bQlKWTsyGt8RTDLpoyXjzSGUb8uqQMg3nS3m1FxIojFaJZxv+e8
         /gKJCCeypJ7ZB+5cmrA05MR2135upt+n6/Bc3yGb0+GmSLvYrZOL1oSLXQa/ETVXdcRm
         jU227x/Tt73zqRkY2TsybqLYC4ar0y/U49OZ9jG+9txPOmNm+aX9KgR1DHjEUeFhfgzW
         RMKg==
X-Gm-Message-State: AOAM532QaqvCPvel42FjqmLKFU/kkcdC3pjaOx77JXE23DjYkZQfttLB
        /zW6n1jE7uS4hzAVzjahGDM=
X-Google-Smtp-Source: ABdhPJxcCJRsmJNZY+TMi1q0s5q154PD+TJT6ubtBRqO8MXdbjQF8tpVd82W53g00HG1rf4yZkmR9g==
X-Received: by 2002:a05:6402:2d9:: with SMTP id b25mr11327084edx.383.1637076909947;
        Tue, 16 Nov 2021 07:35:09 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id f7sm9508523edl.33.2021.11.16.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:35:09 -0800 (PST)
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
Date:   Tue, 16 Nov 2021 16:35:07 +0100
Message-ID: <2524108.PJBYKFOWIp@localhost.localdomain>
In-Reply-To: <YZPHJE2R4VCQ20Za@kroah.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <YZPHJE2R4VCQ20Za@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 16, 2021 3:58:44 PM CET Greg Kroah-Hartman wrote:
> On Tue, Nov 16, 2021 at 03:49:37PM +0100, Fabio M. De Francesco wrote:
> > Fix two sleeping functions called from atomic context by doing immediate
> > return to the caller if !preemptible() evaluates 'true'. Remove two
> > in_interrupt() tests because they are not suited for being used here.
> > 
> > Since functions do_con_write() and con_flush_chars() might sleep in
> > console_lock(), it must be assured that they are never executed in
> > atomic contexts.
> > 
> > This issue is reported by Syzbot which notices that they are executed
> > while holding spinlocks and with interrupts disabled. Actually Syzbot
> > emits a first report and then, after fixing do_con_write(), a second
> > report for the same problem in con_flush_chars() because these functions
> > are called one after the other by con_write().
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/tty/vt/vt.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 7359c3e80d63..508f8a56d361 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, 
const unsigned char *buf, int co
> >  	struct vt_notifier_param param;
> >  	bool rescan;
> >  
> > -	if (in_interrupt())
> > +	if (!preemptible())
> >  		return count;
> 
> Very odd, what code is calling these functions to trigger this check?

This is the call trace reported by Syzbot (https://syzkaller.appspot.com/bug?
id=fe5a4d5a2482bd73064db5de5d28e024f1e2a387):

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

	^^^^^^^^^^
n_tty_ioctl_helper() disabled interrupts via spin_lock_irq(&tty->flow.lock).

 n_hdlc_tty_ioctl+0xd2/0x340 drivers/tty/n_hdlc.c:633
 tty_ioctl+0xc69/0x1670 drivers/tty/tty_io.c:2814
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

> Shouldn't the caller be fixed instead?

Maybe that the caller has no need to disable IRQs, but I cannot yet answer to 
this particular question.

> What changed to suddenly cause this to show up?

Commit c545b66c6922 ("tty: Serialize tcflow() with other tty flow control 
changes") introduced a call to spin_lock_irq() for command "TCOON", just 
before calling __start_tty().

Thanks,

Fabio M. De Francesco

> Given that this check has been here for a _very_ long time, changing it
> now without finding out the root cause is probably not a good idea.
> 
> thanks,
> 
> greg k-h
> 




