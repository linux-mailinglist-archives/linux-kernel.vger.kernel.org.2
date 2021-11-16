Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69217453881
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 18:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238829AbhKPRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 12:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238728AbhKPRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 12:31:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66581C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:28:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r11so27381393edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 09:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7l6ouNHlrkwp2BYieZ/osbBl1961RL7zxm0tIZZ77I=;
        b=MzwciEbrm6mttcIzY9XRrd49hcSCTCgxu4FttLW46HVEo85WixGsZRFKuXRjd4Toff
         0+WQvmrHt05E0/M6EHNu7/r92lEJGM/29Y5iOGeEr/cKkHLZJaYgLQs4oTFEvFizpwd0
         8OODWJ8tBzRDm3TJeQYbMEIrqckgnUmww28oj8Ro1aBwI8EdRqLHYEoK3/AfRmoQP4nf
         hjEe5QBJUvRQqFWyt79+mdJxkCo+JQYRzs9sQJksP5cQmkMQZF8pKyfvmIyJj1LKlEeE
         qg5S3ZQJCeGfhB7ux3iCkh5TKDWpriYh0Mh8xEEIpMRuUckCNBu6IGFM99IeGYRETs/8
         he3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7l6ouNHlrkwp2BYieZ/osbBl1961RL7zxm0tIZZ77I=;
        b=J8+85gUDGdk7xTdEscVaWA6H8lZi+NZMoov8cZtRirpqz1wd//BGcirBuKhFjsBNC4
         QMK8+MjlmGguN3g6oSfuswCTHicigSSAlGAqwBYzyZgNO2dZGFWiJvoA7OklaPZBZSkS
         NguV64yXEa5mjZb6LGhJ/7K8Knw5008Jw/dVayfT1zE6dFmfrw7NQ+2bHAvH/G/JaUGv
         8NQTB8Dg3pM7t7ABRjz9aHGbfPOblNnlFtn0FwFJWgjczSCBfLEcFWWhC+fCdm3xMmuB
         j+JPf2vEp1jC0BmfnK7PuE+6ENOK9YwKekdAgSakGLiPi6VCCXqT/UzJMGmFjmqbJ3P+
         ICCg==
X-Gm-Message-State: AOAM532Kx9Ox+SDPTiKuSeXOf05wVSx9zxGj79NZttiKbwSLpg9jrBcQ
        /XCiMZ3nM+UxDCajiYnGPTSIWxonf3A=
X-Google-Smtp-Source: ABdhPJxpmiOC2EzJuW1s+awUNtx4U38abdhaQ1V2lTwiDpwHQk55Q/m+XNjgl95rtvsrW+GzM62Utw==
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr5775346edc.92.1637083710917;
        Tue, 16 Nov 2021 09:28:30 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id kx3sm4281253ejc.112.2021.11.16.09.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 09:28:30 -0800 (PST)
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
Date:   Tue, 16 Nov 2021 18:28:28 +0100
Message-ID: <5810790.S3fJg7CHgZ@localhost.localdomain>
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
> 
> I am worried you are not actually fixing the real issue here by just
> making syzbot be quiet.  Can you work to figure out what the real issue
> is please?

Yes, Greg. For sure I'll try my best to figure out what the real issue is.

No doubts that this code has been around for very long time without no one 
that had noticed anything wrong, so this report looks weird. There must be 
something that I still can't see. Therefore, I agree with you that, with an 
high degree of probability, the real issue is somewhere else. (if there is a 
real one).

It looks interesting to investigate, although for doing it properly I'll need 
some time because I know very little of this code.

Thanks for your reply,

Fabio M. De Francesco 

> 
> thanks,
> 
> greg k-h
> 




