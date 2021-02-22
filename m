Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F8321D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhBVQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 11:32:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:35586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhBVQ3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:29:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614011306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMET2jrpSddtpWkJHAuUT+RtXvTsMyez7xuO3kxxUks=;
        b=g2tsk2ags9OnzyMG3nQzuioxmg3cMeKBT4P+2JdqFcMV1bUJcdtvzwLrq1pyQE54RMqU7D
        /fgy5Koo1D4bieg9KuKjudfVzG5mfQKlQq7oNTTKfHV05jlKW8ljNeZVOZcCwjUVN3u3yz
        W/sEfP6ZS00E7tF/MojxcH+wX/bFgzU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4575AFE6;
        Mon, 22 Feb 2021 16:28:26 +0000 (UTC)
Date:   Mon, 22 Feb 2021 17:28:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Helge Deller <deller@gmx.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH printk-rework 08/14] printk: add syslog_lock
Message-ID: <YDPbqhi6wVwGa5rF@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-9-john.ogness@linutronix.de>
 <YC+9gc/IR8PzeIFf@alley>
 <875z2o15ha.fsf@jogness.linutronix.de>
 <8735xs10hi.fsf@jogness.linutronix.de>
 <db43de06-3183-7401-30f2-0e9302cc48e0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db43de06-3183-7401-30f2-0e9302cc48e0@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-02-21 22:39:42, Helge Deller wrote:
> On 2/19/21 5:33 PM, John Ogness wrote:
> > Added CC: linux-parisc@vger.kernel.org
> > 
> > On 2021-02-19, John Ogness <john.ogness@linutronix.de> wrote:
> > > > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > > > index 20c21a25143d..401df370832b 100644
> > > > > --- a/kernel/printk/printk.c
> > > > > +++ b/kernel/printk/printk.c
> > > > > +/* Return a consistent copy of @syslog_seq. */
> > > > > +static u64 read_syslog_seq_irq(void)
> > > > > +{
> > > > > +	u64 seq;
> > > > > +
> > > > > +	raw_spin_lock_irq(&syslog_lock);
> > > > > +	seq = syslog_seq;
> > > > > +	raw_spin_unlock_irq(&syslog_lock);
> > > > 
> > > > Is there any particular reason to disable interrupts here?
> > > > 
> > > > It would make sense only when the lock could be taken in IRQ
> > > > context. Then we would need to always disable interrupts when
> > > > the lock is taken. And if it is taken in IRQ context, we would
> > > > need to safe flags.
> > > 
> > > All other instances of locking @syslog_lock are done with interrupts
> > > disabled. And we have:
> > > 
> > > register_console()
> > >    logbuf_lock_irqsave()
> > >      raw_spin_lock(&syslog_lock)
> > > 
> > > I suppose I need to go through all the console drivers to see if any
> > > register in interrupt context. If not, that logbuf_lock_irqsave()
> > > should be replaced with logbuf_lock_irq(). And then locking
> > > @syslog_lock will not need to disable interrupts.
> > 
> > I found a possible call chain in interrupt context. From arch/parisc
> > there is the interrupt handler:
> > 
> > handle_interruption(code=1) /* High-priority machine check (HPMC) */
> >    pdc_console_restart()
> >      pdc_console_init_force()
> >        register_console()
> > 
> > All other register_console() calls in the kernel are either during init
> > (within __init sections and probe functions) or are clearly not in
> > interrupt context (using mutex, kzalloc, spin_lock_irq, etc).
> > 
> > I am not familiar with parisc, but I am assuming handle_interruption()
> > is always called with interrupts disabled (unless the HPMC interrupt is
> > somehow an exception).
> 
> Yes, handle_interruption() is the irq handler, running with irqs off.
> HPMC is the crash handler - it's called when the kernel will stop
> anyway. pdc_console is a very basic firmware console which prints
> the last messages before the machine halts on fatal errors.
> So, this code it's not the typical use case....

Thanks for information.

Is this code supposed to work only during early boot or anytime,
please?

Note that it is not safe because register_console() takes
console_lock() which is a sleeping lock.

That said, we are going to rework the console handling a lot. We are
trying to remove as many locks from the printk path as possible.
I guess that the list of consoles will be synchronized using
rcu at the end. But it is still a long way to go.

Best Regards,
Petr
