Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F04730C522
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhBBQNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:13:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:44442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235153AbhBBQLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:11:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612282262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+hG/BeAD///eAJAicuOGh33+TvlaAZhxESXYIg+J8c=;
        b=mOO0UgX9pJ4sMiS6lBuANV7T88ocGyDyTzhOJAgUySqSrSF5Mo+dR6O0Q+M1PJu3wyjxLA
        XqO49ok7sH04Wii5LbF34LQOsJe8Q3tUODZ2LW5k3w4grlWmscZkJcnbQxzqXSMm72PPd6
        Y4PCG7pDV4hJ7JYH9zHuplyzpzBCsS0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B90CB13F;
        Tue,  2 Feb 2021 16:11:02 +0000 (UTC)
Date:   Tue, 2 Feb 2021 17:11:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 11/12] printk: remove logbuf_lock
Message-ID: <YBl5lSpFt/OblQVC@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-12-john.ogness@linutronix.de>
 <YBkYOKL22kADKTeG@alley>
 <87czxivgrj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czxivgrj.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-02 12:47:20, John Ogness wrote:
> On 2021-02-02, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2021-01-26 22:21:50, John Ogness wrote:
> >> Since the ringbuffer is lockless, there is no need for it to be
> >> protected by @logbuf_lock. Remove @logbuf_lock.
> >> 
> >> This means that printk_nmi_direct and printk_safe_flush_on_panic()
> >> no longer need to acquire any lock to run.
> >> 
> >> @console_seq, @exclusive_console_stop_seq, @console_dropped are
> >> protected by @console_lock.
> >> 
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index d14a4afc5b72..b57dba7f077d 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -401,6 +366,7 @@ static u64 syslog_seq;
> >>  static size_t syslog_partial;
> >>  static bool syslog_time;
> >>  
> >> +/* All 3 protected by @console_sem. */
> >>  /* the next printk record to write to the console */
> >>  static u64 console_seq;
> >>  static u64 exclusive_console_stop_seq;
> >> @@ -762,27 +728,27 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
> >>  	if (ret)
> >>  		return ret;
> >>  
> >> -	logbuf_lock_irq();
> >> +	printk_safe_enter_irq();
> >
> > What is the exact reason to keep this, please?
> 
> As Sergey pointed out [0], logbuf_lock_irq() does 2 things: logbuf_lock
> and safe buffers. This series is not trying to remove the safe buffers
> (a later series will). The series is only removing logbuf_lock. So all
> logbuf_lock_*() calls will turn into printk_safe_*() calls. There are a
> few exceptions, which you noticed and I will respond to.
> 
> [0] https://lkml.kernel.org/r/20201208203539.GB1667627@google.com
> 
> > 1. The primary function of the printk_safe context is to avoid deadlock
> >    caused by logbuf_lock. It might have happened with recursive or nested
> >    printk(). But logbuf_lock is gone now.
> 
> Agreed. Deadlock is not a concern anymore.
> 
> > 2. There are still some hidded locks that were guarded by this as
> >    well. For example, console_owner_lock, or spinlock inside
> >    console_sem, or scheduler locks taken when console_sem()
> >    wakes another waiting process. It might still make sense
> >    to somehow guard these.
> 
> This was not my motivation and I do not think it is an issue. I am not
> aware of any technical need for the safe buffers to protect such
> synchronization.

Just to make it clear. These locks are explicitely protected, see
printk_safe_enter_irqsave()/printk_safe_exit_irqrestore() in

	+ console_lock_spinning_enable()
	+ console_lock_spinning_disable_and_check()
	+ console_trylock_spinning()
	+ __up_console_sem()
	+  __down_trylock_console_sem()

Re-entering the code guarded by console_sem.lock or console_owner_lock
would cause a deadlock.

For example, spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_)
in console_trylock_spinning() might cause recursive printk().

These code paths are not touched by this patch because they
do not use logbuf_lock. I mentioned this primary for completnes.

We could not remove printk_safe code before we prevent these
deadlocks another way. Well, it is possible that all this
code will get removed after offloading consoles into kthreads.

Alternatively, we might simply prevent calling console in any recursive
printk.

Anyway, prink_safe is too big hammer. We do not longer have problems
to write recursive messages into the lockless ringbuffer. We only
need to somehow limit the recursion.

Anyway, this is for another patchset.

> 
> > 3. It kind of prevented infinite printk() recursion by using another
> >    code path. The other path was limited by the size of the per-cpu
> >    buffer. Well, recursion inside printk_safe code would likely
> >    hit end of the stack first.
> 
> Yes, this was my main motivation. The safe buffers carry this
> responsibility in mainline. So until a replacement for recursion
> protection is in place, the safe buffers should remain.
>
> And even if we decide we do not need/want recursion protection, I still
> do not think this series should be the one to remove it. I only wanted
> to remove logbuf_lock for now.

Fair enough.

> If we later have regressions, it will be helpful to bisect if the safe
> buffers (with their local_irq_disable()) or the logbuf_lock were
> involved.

Makes perfect sense.

> > IMHO, we do not need printk safe context here in devkmsg_read().
> > It does not belong into any categoty that is described above.
> > logbug_lock() is gone. devkmsg_read() is never called directly
> > from printk().
> 
> No. But it is calling printk_ringbuffer functions that can trigger
> WARN_ONs that can trigger printk's.

But printk() does not call devkmsg_read(). At least not directly.
So this does not cause any infinite recursion.

Anyway, I agree that we should just remove logbuf_lock in this patch
and keep printk_safe context where it was.


> >> @@ -2973,9 +2933,7 @@ void register_console(struct console *newcon)
> >>  		/*
> >>  		 * console_unlock(); will print out the buffered messages
> >>  		 * for us.
> >> -		 */
> >> -		logbuf_lock_irqsave(flags);
> >
> > I am just curious what was the motivation to remove printk_safe
> > context here? It is a bit inconsistent with the other locations
> > where you kept it.
> 
> This never should have been logbuf_lock_irqsave(flags) in the first
> place. It would have been enough to just grab @logbuf_lock. The safe
> buffers only make sense if printk or printk_ringbuffer functions are
> called. Here we are just copying some variables (which are already
> protected by console_sem and syslog_lock).

I think that we replaced all spin_lock_irqsave() with
logbuf_lock_irqsave(flags) at some point to be on the safe side.

> > IMHO, it can be removed. It does not fit into any category
> > where it would help as described above.
> >
> > Anyway, we have to be consistent and explain it in the commit message.
> 
> I could add an earlier patch that changes logbuf_lock_irqsave() here to
> spin_lock_irqsave() and explain. Then for this patch it would be clear
> that it is just dropped.

My main concern was that you _moved_ the _location_ where the lock/printk
safe context was taken. Such a change should not be hidden in this
patch.

I suggest to simply replace logbuf_lock_irqsave(flags) with
printk_safe_enter_irqsave(flags) and keep the location. I mean to do
exactly the same thing that you did on all other locations in this
patch.

As you said. Let's keep this patch(set) for removing logbuf_lock.
And let's remove printk_safe context in another patchset later.

> 
> >> -		/*
> >> +		 *
> >>  		 * We're about to replay the log buffer.  Only do this to the
> >>  		 * just-registered console to avoid excessive message spam to
> >>  		 * the already-registered consoles.


> >> @@ -3414,9 +3366,11 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
> >>  	struct printk_info info;
> >>  	unsigned int line_count;
> >>  	struct printk_record r;
> >> +	unsigned long flags;
> >>  	size_t l = 0;
> >>  	bool ret = false;
> >>  
> >> +	printk_safe_enter_irqsave(flags);
> >
> > This change is neither obvious nor documented.
> 
> I noticed that this function was calling ringbuffer functions without
> marking the region for safe buffers. I should have included a separate
> patch before this one adding the safe buffers so that it would be
> clear. Sorry.
> 
> > I guess that this is preparation step for unfying
> > kmsg_dump_get_line_nolock() and kmsg_dump_get_line().
> >
> > Please, do it in the next patch and keep this one strightforward.
> 
> Or I will just do it in the following unification patch.
> 
> > That said, IMHO, the printk_safe() context is not needed here at all.
> > This code is not called from printk() directly. The recursion is
> > prevented by iter->next_seq or the buffer size.
> 
> My logic was: "If it is calling prb_*(), it should be protected by safe
> buffers."

IMHO, it is not necessary if there is no risk of recursion.

Let's just remove logbuf_lock in this patch. Let's keep printk_safe
enter/exit calls on the same locations where they were before.
We should neither add, remove, or move them.

> >>  	prb_rec_init_rd(&r, &info, line, size);
> >>  
> >>  	if (!iter->active)
> >
> >
> >> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> >> index a0e6f746de6c..a9a3137bd972 100644
> >> --- a/kernel/printk/printk_safe.c
> >> +++ b/kernel/printk/printk_safe.c
> >> @@ -368,20 +354,21 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
> >>  #endif
> >>  
> >>  	/*
> >> -	 * Try to use the main logbuf even in NMI. But avoid calling console
> >> +	 * Use the main logbuf even in NMI. But avoid calling console
> >>  	 * drivers that might have their own locks.
> >>  	 */
> >> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
> >> -	    raw_spin_trylock(&logbuf_lock)) {
> >> +	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> >> +		unsigned long flags;
> >>  		int len;
> >>  
> >> +		printk_safe_enter_irqsave(flags);
> >
> > The printk_safe context does not make much sense here. The per-context
> > redirection is done in vprintk_func(). It will always use this path
> > because PRINTK_NMI_DIRECT_CONTEXT_MASK is handled before
> > PRINTK_SAFE_CONTEXT_MASK.
> 
> If the following vprintk_store() calls printk(), those printk's should
> land in safe buffers. If @printk_context is not incremented, they land
> here again.
> 
> vprintk_store() relies on its caller to update @printk_context.

Nevermind. Use printk_safe_enter_irqsave(flags) here as you did. It is
a straightforward replacement of the above raw_spin_trylock(&logbuf_lock)).

> >>  		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
> >> -		raw_spin_unlock(&logbuf_lock);
> >> +		printk_safe_exit_irqrestore(flags);
> >>  		defer_console_output();
> >>  		return len;
> >>  	}
> >>  
> >> -	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
> >> +	/* Use extra buffer in NMI. */
> >>  	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
> >>  		return vprintk_nmi(fmt, args);
> >
> OK. Thank you for the excellent response. I will go over this again.

Thanks a lot for patience. I know that reshufling non-trivial
patchsets is a pain. But I think that we are getting close.
I really like that we do it in small steps.

Best Regards,
Petr
