Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60DD30BEBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhBBMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 07:51:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:47666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231837AbhBBMvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 07:51:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612270208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3F6qa8X0Xbhc890ifMMao+IDeLJ53e6DtIS3S2SWeMw=;
        b=cP2YZVCt1yH8knyPp29hVTdPhGEGhy/aw1zq43+b3tSYuk4FvwOwsZs03TMtgjs5T4C5JI
        Hhko43viQi9KnY1H6wWIkSCHvYOsFPfuFa8cYwqJ5u+tst+I1D+9qLoI3NVECsff0s2RVt
        ujN+UnXTLFl9RMahD2U8cL2LCEk+M8A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8205CAF76;
        Tue,  2 Feb 2021 12:50:08 +0000 (UTC)
Date:   Tue, 2 Feb 2021 13:50:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 07/12] printk: add syslog_lock
Message-ID: <YBlKf1XWzMcJVCkX@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-8-john.ogness@linutronix.de>
 <YBfzfs9zU8rgHl6y@alley>
 <87h7mwj5k4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7mwj5k4.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-01 14:17:55, John Ogness wrote:
> On 2021-02-01, Petr Mladek <pmladek@suse.com> wrote:
> >> The global variables @syslog_seq, @syslog_partial, @syslog_time
> >> and write access to @clear_seq are protected by @logbuf_lock.
> >> Once @logbuf_lock is removed, these variables will need their
> >> own synchronization method. Introduce @syslog_lock for this
> >> purpose.
> >
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -390,8 +390,12 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
> >>  		printk_safe_exit_irqrestore(flags);	\
> >>  	} while (0)
> >>  
> >> +/* syslog_lock protects syslog_* variables and write access to clear_seq. */
> >> +static DEFINE_RAW_SPINLOCK(syslog_lock);
> >
> > I am not expert on RT code but I think that it prefers the generic
> > spinlocks. syslog_lock seems to be used in a normal context.
> > IMHO, it does not need to be a raw spinlock.
> >
> > Note that using normal spinlock would require switching the locking
> > order. logbuf_lock is a raw lock. Normal spinlock must not be taken
> > under a raw spinlock.
> >
> > Or we could switch syslog_lock to the normal spinlock later
> > after logbuf_lock is removed.
> 
> I was planning on this last option because I think it is the
> simplest. There are places such as syslog_print_all() where the
> printk_safe_enter() and logbuf_lock locking are not at the same place as
> the syslog_lock locking (and syslog_lock is inside).
>
> Once the safe buffers are removed, syslog_lock can transition to a
> spinlock. (spinlock's must not be under local_irq_save().)

Fair enough. Please, mention in the commit message that it
will get switched to normal spinlock later. And the the raw
spinlock is used to make the transition more straightforward
or something like this.
 
> >> +
> >>  #ifdef CONFIG_PRINTK
> >>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> >> +/* All 3 protected by @syslog_lock. */
> >>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
> >>  static u64 syslog_seq;
> >>  static size_t syslog_partial;
> >> @@ -1648,8 +1661,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
> >>  			return 0;
> >>  		if (!access_ok(buf, len))
> >>  			return -EFAULT;
> >> +
> >> +		/* Get a consistent copy of @syslog_seq. */
> >> +		raw_spin_lock_irq(&syslog_lock);
> >> +		seq = syslog_seq;
> >> +		raw_spin_unlock_irq(&syslog_lock);
> >> +
> >>  		error = wait_event_interruptible(log_wait,
> >> -				prb_read_valid(prb, syslog_seq, NULL));
> >> +				prb_read_valid(prb, seq, NULL));
> >
> > Hmm, this will not detect when syslog_seq gets cleared in parallel.
> > I hope that nobody rely on this behavior. But who knows?
> >
> > A solution might be to have also syslog_seq latched. But I am
> > not sure if it is worth it.
> >
> > I am for taking the risk and use the patch as it is now. Let's keep
> > the code for now. We could always use the latched variable when
> > anyone complains. Just keep it in mind.
> 
> We could add a simple helper:
> 
> /* Get a consistent copy of @syslog_seq. */
> static u64 syslog_seq_read(void)
> {
>     unsigned long flags;
> 
>     raw_spin_lock_irqsave(&syslog_lock, flags);
>     seq = syslog_seq;
>     raw_spin_unlock_irqrestore(&syslog_lock, flags);
>     return seq;
> }
> 
> Then change the code to:
> 
>     error = wait_event_interruptible(log_wait,
>                     prb_read_valid(prb, read_syslog_seq(), NULL));
> 

Great idea! Please, use it but without the flags. IMHO, using flags
might be confusing when reading the come. It might create false
expectations...

> register_console() could also make use of the function. (That is why I
> am suggesting the flags variant.)

I think that flags are actually not needed in register_console() as
mentioned in the other mail. Anyway, we could keep register_console()
as is (opencoded) for now.

Best Regards,
Petr
