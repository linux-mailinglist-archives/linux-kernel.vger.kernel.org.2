Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A41D45430A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbhKQI6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:58:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234687AbhKQI57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:57:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E480561B54;
        Wed, 17 Nov 2021 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637139301;
        bh=C18o8urZBapk4/yqwFIS4vnIJFEMm1/Co09y7hTK9xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hU/+0IMZfDemjnn130BxDSmjGsgthuZ7t1bxt7s0DKXyCuNypzuwSVTByiaVMYGDh
         mvt0jwnzDe3P30uI0AL+zsxk5USE/nBrMVJwcnvJJqlesgAyO+5G1GPGoZjji7Gvbz
         b5Hy8F3PZUP5TuvtXrWaIuNSE2Dt1MnwsqD5bCYA=
Date:   Wed, 17 Nov 2021 09:54:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
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
Message-ID: <YZTDY/h8HcEkq7mO@kroah.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <2524108.PJBYKFOWIp@localhost.localdomain>
 <YZPjbI/uCNtugFJZ@kroah.com>
 <1851530.LmWsTuDv9j@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1851530.LmWsTuDv9j@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 09:23:45AM +0100, Fabio M. De Francesco wrote:
> On Tuesday, November 16, 2021 5:59:24 PM CET Greg Kroah-Hartman wrote:
> > On Tue, Nov 16, 2021 at 04:35:07PM +0100, Fabio M. De Francesco wrote:
> > > On Tuesday, November 16, 2021 3:58:44 PM CET Greg Kroah-Hartman wrote:
> > > > On Tue, Nov 16, 2021 at 03:49:37PM +0100, Fabio M. De Francesco wrote:
> > > > > Fix two sleeping functions called from atomic context by doing 
> immediate
> > > > > return to the caller if !preemptible() evaluates 'true'. Remove two
> > > > > in_interrupt() tests because they are not suited for being used here.
> > > > > 
> > > > > Since functions do_con_write() and con_flush_chars() might sleep in
> > > > > console_lock(), it must be assured that they are never executed in
> > > > > atomic contexts.
> > > > > 
> > > > > This issue is reported by Syzbot which notices that they are executed
> > > > > while holding spinlocks and with interrupts disabled. Actually Syzbot
> > > > > emits a first report and then, after fixing do_con_write(), a second
> > > > > report for the same problem in con_flush_chars() because these 
> functions
> > > > > are called one after the other by con_write().
> > > > > 
> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > Reported-by: syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> > > > > Suggested-by: Marco Elver <elver@google.com>
> > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > ---
> > > > >  drivers/tty/vt/vt.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > > > index 7359c3e80d63..508f8a56d361 100644
> > > > > --- a/drivers/tty/vt/vt.c
> > > > > +++ b/drivers/tty/vt/vt.c
> > > > > @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct *tty, 
> > > const unsigned char *buf, int co
> > > > >  	struct vt_notifier_param param;
> > > > >  	bool rescan;
> > > > >  
> > > > > -	if (in_interrupt())
> > > > > +	if (!preemptible())
> > > > >  		return count;
> > > > 
> > > > Very odd, what code is calling these functions to trigger this check?
> > > 
> > > This is the call trace reported by Syzbot (https://syzkaller.appspot.com/
> bug?
> > > id=fe5a4d5a2482bd73064db5de5d28e024f1e2a387):
> > > 
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9539
> > >  console_lock+0x17/0x80 kernel/printk/printk.c:2522
> > >  do_con_write+0x10f/0x1e40 drivers/tty/vt/vt.c:2908
> > >  con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
> > >  n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
> > >  tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
> > >  __start_tty drivers/tty/tty_io.c:806 [inline]
> > >  __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> > >  n_tty_ioctl_helper+0x299/0x2d0 drivers/tty/tty_ioctl.c:880
> > > 
> > > 	^^^^^^^^^^
> > > n_tty_ioctl_helper() disabled interrupts via spin_lock_irq(&tty-
> >flow.lock).
> > > 
> > >  n_hdlc_tty_ioctl+0xd2/0x340 drivers/tty/n_hdlc.c:633
> > >  tty_ioctl+0xc69/0x1670 drivers/tty/tty_io.c:2814
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:874 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:860 [inline]
> > >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > 
> > > > Shouldn't the caller be fixed instead?
> > > 
> > > Maybe that the caller has no need to disable IRQs, but I cannot yet 
> answer to 
> > > this particular question.
> > > 
> > > > What changed to suddenly cause this to show up?
> > > 
> > > Commit c545b66c6922 ("tty: Serialize tcflow() with other tty flow control 
> > > changes") introduced a call to spin_lock_irq() for command "TCOON", just 
> > > before calling __start_tty().
> > 
> > That commit happened in 2014.  Why is this suddenly an issue now that no
> > one ever saw before?
> 
> Hi Greg,
> 
> I have just been informed by Pavel Skripkin (who at this moment cannot 
> directly write to LKML) that this bug has been reported at least other two 
> times. 
> 
> We cannot say why nobody has ever addressed this issue before.
> 
> Please read the following reports.
> 
> https://syzkaller.appspot.com/bug?id=9ed44c22919e3cd2c71907b963fb048ac1115073
> https://syzkaller.appspot.com/bug?id=e806305a3a65a0bb2f1be7e672819a079d558016

Great, you have a reproducer, so you should be able to duplicate this
locally to figure out what is really happening here.

Good luck!

greg k-h
