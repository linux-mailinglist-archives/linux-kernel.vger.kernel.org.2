Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75D945467D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 13:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhKQMlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 07:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKQMli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 07:41:38 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A56C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:38:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b15so10472564edd.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 04:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CASHoMY220WbIMoqoi4v2Ed/uxuEbP5ROvnZnECwp24=;
        b=o0R0HtfUre7N57qD/cxBKObsxf5O10Svg+K909vsgtJOSfQR4i3Y2qhGdCMUsQ8gWT
         EFyphr4wh+KRwmN1HWI+vJRlhiA6fWqfklixvszAo+In0yU3cNBWI31+d/JUjJmkgRYp
         anlyh6j/vUwp7H4FSnKbehGiCkE/2A+hK6rSh1B7p0wZfcZA7a+Ux7hfN3Ojgf2DCmBN
         lbB0O7gxqxworcu1Z+4/MI+6dQVgNGF9qeF7Ra8TxaGmH7EHorpUpIvRRb/LMJfAu10T
         edTOP4Xsr+Pe2chyoXFSOgLTBPsyjVyG0O1G1DScqRLKOD/+wcISFdmF8LWPZBQHz1ae
         KIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CASHoMY220WbIMoqoi4v2Ed/uxuEbP5ROvnZnECwp24=;
        b=3RyAwNoH10WPrkUNXatY7GtUuSpPVATStjLaxi3IMi8PN8qzTQwnmmVBQpX1ESTq45
         32m6+V70n2ZT1Ykzk6eYAzOghqqByFRj3Or6QbaNC9cV2kaWMVAES8yRyjhRwYxUDmWv
         ngFiR97NkCFUwnYABQsu3rNeQngadTB6y1BpjsoY771dBHK2+JhpveSasqZDOsKXnGFL
         vZrCtCzwJBb+Dv0PU3hO6AKOI68MOB1cKlqoP78NttJeycvnPXurYCjLexmQ+oVe5xML
         FgkYCt0H8OpQ5CseCVH26RYCryb+HIBy6owb9yEI/7jow24rrVYgQ1nGJJXe9ML/zySw
         51YA==
X-Gm-Message-State: AOAM530EglYqSnQdkeNXyAJY7KQQiyMth06lJmMNzhEeNDdVv6QleYt9
        fla6MCchjLagGe6IQLtAnys=
X-Google-Smtp-Source: ABdhPJwVkMHrW9m7Ar2Dbr/XcqEhtuXT8GfqYGYoTCPvmo8RQNdgIhdP56ZKY7FynR3pg/CIrMbC7g==
X-Received: by 2002:a17:906:80b:: with SMTP id e11mr21863936ejd.20.1637152718372;
        Wed, 17 Nov 2021 04:38:38 -0800 (PST)
Received: from localhost.localdomain (host-82-61-38-115.retail.telecomitalia.it. [82.61.38.115])
        by smtp.gmail.com with ESMTPSA id sc27sm10471143ejc.125.2021.11.17.04.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 04:38:37 -0800 (PST)
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
        Marco Elver <elver@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] vt: Fix sleeping functions called from atomic context
Date:   Wed, 17 Nov 2021 13:38:33 +0100
Message-ID: <116969909.G7WiQ7h0bV@localhost.localdomain>
In-Reply-To: <YZTDY/h8HcEkq7mO@kroah.com>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com> <1851530.LmWsTuDv9j@localhost.localdomain> <YZTDY/h8HcEkq7mO@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 17, 2021 9:54:59 AM CET Greg Kroah-Hartman wrote:
> On Wed, Nov 17, 2021 at 09:23:45AM +0100, Fabio M. De Francesco wrote:
> > On Tuesday, November 16, 2021 5:59:24 PM CET Greg Kroah-Hartman wrote:
> > > On Tue, Nov 16, 2021 at 04:35:07PM +0100, Fabio M. De Francesco wrote:
> > > > On Tuesday, November 16, 2021 3:58:44 PM CET Greg Kroah-Hartman 
wrote:
> > > > > On Tue, Nov 16, 2021 at 03:49:37PM +0100, Fabio M. De Francesco 
wrote:
> > > > > > Fix two sleeping functions called from atomic context by doing 
> > immediate
> > > > > > return to the caller if !preemptible() evaluates 'true'. Remove 
two
> > > > > > in_interrupt() tests because they are not suited for being used 
here.
> > > > > > 
> > > > > > Since functions do_con_write() and con_flush_chars() might sleep 
in
> > > > > > console_lock(), it must be assured that they are never executed 
in
> > > > > > atomic contexts.
> > > > > > 
> > > > > > This issue is reported by Syzbot which notices that they are 
executed
> > > > > > while holding spinlocks and with interrupts disabled. Actually 
Syzbot
> > > > > > emits a first report and then, after fixing do_con_write(), a 
second
> > > > > > report for the same problem in con_flush_chars() because these 
> > functions
> > > > > > are called one after the other by con_write().
> > > > > > 
> > > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > > > Reported-by: 
syzbot+5f47a8cea6a12b77a876@syzkaller.appspotmail.com
> > > > > > Suggested-by: Marco Elver <elver@google.com>
> > > > > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > > > > ---
> > > > > >  drivers/tty/vt/vt.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > > > > > index 7359c3e80d63..508f8a56d361 100644
> > > > > > --- a/drivers/tty/vt/vt.c
> > > > > > +++ b/drivers/tty/vt/vt.c
> > > > > > @@ -2902,7 +2902,7 @@ static int do_con_write(struct tty_struct 
*tty, 
> > > > const unsigned char *buf, int co
> > > > > >  	struct vt_notifier_param param;
> > > > > >  	bool rescan;
> > > > > >  
> > > > > > -	if (in_interrupt())
> > > > > > +	if (!preemptible())
> > > > > >  		return count;
> > > > > 
> > > > > Very odd, what code is calling these functions to trigger this 
check?
> > > > 
> > > > This is the call trace reported by Syzbot (https://
syzkaller.appspot.com/
> > bug?
> > > > id=fe5a4d5a2482bd73064db5de5d28e024f1e2a387):
> > > > 
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > > >  __might_resched.cold+0x222/0x26b kernel/sched/core.c:9539
> > > >  console_lock+0x17/0x80 kernel/printk/printk.c:2522
> > > >  do_con_write+0x10f/0x1e40 drivers/tty/vt/vt.c:2908
> > > >  con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
> > > >  n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
> > > >  tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
> > > >  __start_tty drivers/tty/tty_io.c:806 [inline]
> > > >  __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
> > > >  n_tty_ioctl_helper+0x299/0x2d0 drivers/tty/tty_ioctl.c:880
> > > > 
> > > > 	^^^^^^^^^^
> > > > n_tty_ioctl_helper() disabled interrupts via spin_lock_irq(&tty-
> > >flow.lock).
> > > > 
> > > >  n_hdlc_tty_ioctl+0xd2/0x340 drivers/tty/n_hdlc.c:633
> > > >  tty_ioctl+0xc69/0x1670 drivers/tty/tty_io.c:2814
> > > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > > >  __do_sys_ioctl fs/ioctl.c:874 [inline]
> > > >  __se_sys_ioctl fs/ioctl.c:860 [inline]
> > > >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
> > > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > > 
> > > > > Shouldn't the caller be fixed instead?
> > > > 
> > > > Maybe that the caller has no need to disable IRQs, but I cannot yet 
> > answer to 
> > > > this particular question.
> > > > 
> > > > > What changed to suddenly cause this to show up?
> > > > 
> > > > Commit c545b66c6922 ("tty: Serialize tcflow() with other tty flow 
control 
> > > > changes") introduced a call to spin_lock_irq() for command "TCOON", 
just 
> > > > before calling __start_tty().
> > > 
> > > That commit happened in 2014.  Why is this suddenly an issue now that 
no
> > > one ever saw before?
> > 
> > Hi Greg,
> > 
> > I have just been informed by Pavel Skripkin (who at this moment cannot 
> > directly write to LKML) that this bug has been reported at least other 
two 
> > times. 
> > 
> > We cannot say why nobody has ever addressed this issue before.
> > 
> > Please read the following reports.
> > 
> > https://syzkaller.appspot.com/bug?
id=9ed44c22919e3cd2c71907b963fb048ac1115073
> > https://syzkaller.appspot.com/bug?
id=e806305a3a65a0bb2f1be7e672819a079d558016
> 
> Great, you have a reproducer, so you should be able to duplicate this
> locally to figure out what is really happening here.
> 
> Good luck!
> 
> greg k-h
> 
Hi Greg,

As you asked for, I've run the reproducer (as root) while "trace-cmd record -
g n_tty_ioctl_helper -p function_graph sleep 15" was in execution.

The call trace from n_tty_ioctl_helper() to console_lock() has been recorded 
and for sure console_lock() is called while holding a spinlock and with IRQs 
disabled via spin_lock_irq().

The following is the relevant part of "trace-cmd report"...

repro-27397 [004] 18814.535029: funcgraph_entry:                   |  
n_tty_ioctl_helper() {
           repro-27397 [004] 18814.535030: funcgraph_entry:        0.676 us   
|    tty_check_change();
           repro-27397 [004] 18814.535032: funcgraph_entry:        0.761 us   
|    _raw_spin_lock_irq();
           repro-27397 [004] 18814.535033: funcgraph_entry:                   
|    __start_tty() {
           repro-27397 [004] 18814.535034: funcgraph_entry:                   
|      con_start() {

---- cut not relevant code ----

repro-27397 [004] 18814.535088: funcgraph_entry:                   |            
con_write() {
           repro-27397 [004] 18814.535088: funcgraph_entry:                   
|              do_con_write() {
           repro-27397 [004] 18814.535088: funcgraph_entry:                   
|                console_lock() {
           repro-27397 [004] 18814.535089: funcgraph_entry:                   
|                  __cond_resched() {

---- cut not relevant code ----

repro-27397 [004] 18814.571839: funcgraph_entry:        0.641 us   |                  
__printk_safe_exit();
           repro-27397 [004] 18814.571841: funcgraph_exit:       + 18.902 us  
|                }
           repro-27397 [004] 18814.571842: funcgraph_exit:       + 31.651 us  
|              }
           repro-27397 [004] 18814.571843: funcgraph_exit:       # 36754.817 
us |            }

Please notice that "#36754.817 us" when finally console_lock() returned.

May very well be that I've overlooked something (as you know I'm a newbie and 
all this is quite new for me :)

As I wrote (please read it again above) for now I confirm that commit 
c545b66c6922 ("tty: Serialize tcflow() with other tty flow control changes") 
introduced a call to spin_lock_irq() for command "TCOON". 

However I have to double check it. 

If it is confirmed, I will reply soon to Tetsuo's message because he says 
that the relevant commit should be a different one. 

However, what is relevant here is that for sure console_lock() is called in 
atomic context and that the Syzbot report is not a false positive. Am I 
missing something?

About the possible fixes I only see two potential solutions:

1) If we need for real spin_lock_irq() in n_tty_ioctl_helper() we should test 
the context before calling console_lock() (it is annotated with 
might_sleep()).

2) If we don't need to disable IRQs we should fix n_tty_ioctl_helper().

I'm not able to go deeper and understand whether or not that spin_lock_irq() 
is an overkill and if it can be converted to a different kind of locking API.

I'd appreciate feedback from you and other experienced developers.

Thank you very much,

Fabio M. De  Francesco





