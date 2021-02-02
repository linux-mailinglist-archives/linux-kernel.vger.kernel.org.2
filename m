Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D148030BD51
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhBBLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhBBLmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 06:42:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524B6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 03:41:25 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612266081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=30MYwFclK9Gy+v05p1Q3CW8gPbbm+Y7wuHsDVyMwA/k=;
        b=EebEMfww7DSNaK3QOMUCFGsdeaL2nZoGKrauoD0lCexedQpastQbGoB5K6liqxou2G9lfB
        C54zWK7xwJULruqaZjOxC7X7wbhmKU52+aY9RWLzELzT83WQ+Fgo43R7ocUZxD6aNHHkQu
        UOHgdBjHnPTmPUi2PZCSMMiKEn9tS76prQvBBUKoMaSFaLC+no89+vwXyG43F9QYd6Dm18
        0MOUcMQuo75JAnfcmopYSlAuF4LgEPM/4G5BoEOH5jIgdNyRtd8eaIuW3Jr84q5pbBhRgo
        tlCzr+nrqjOYpBqw/O8WVgtw+D8zd7vQ0Bl9YBIVymxRXU1vb5wK6uvL335eAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612266081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=30MYwFclK9Gy+v05p1Q3CW8gPbbm+Y7wuHsDVyMwA/k=;
        b=ysG3zVt6lrQYNjs5wI4+fG0WBpJvotKyTCZpJL9Rj2QL/x2Qew75NtezhZVXgQBfgA2Cqy
        HIqgUFB2cRB4iiDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 11/12] printk: remove logbuf_lock
In-Reply-To: <YBkYOKL22kADKTeG@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-12-john.ogness@linutronix.de> <YBkYOKL22kADKTeG@alley>
Date:   Tue, 02 Feb 2021 12:47:20 +0106
Message-ID: <87czxivgrj.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2021-01-26 22:21:50, John Ogness wrote:
>> Since the ringbuffer is lockless, there is no need for it to be
>> protected by @logbuf_lock. Remove @logbuf_lock.
>> 
>> This means that printk_nmi_direct and printk_safe_flush_on_panic()
>> no longer need to acquire any lock to run.
>> 
>> @console_seq, @exclusive_console_stop_seq, @console_dropped are
>> protected by @console_lock.
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index d14a4afc5b72..b57dba7f077d 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -401,6 +366,7 @@ static u64 syslog_seq;
>>  static size_t syslog_partial;
>>  static bool syslog_time;
>>  
>> +/* All 3 protected by @console_sem. */
>>  /* the next printk record to write to the console */
>>  static u64 console_seq;
>>  static u64 exclusive_console_stop_seq;
>> @@ -762,27 +728,27 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>>  	if (ret)
>>  		return ret;
>>  
>> -	logbuf_lock_irq();
>> +	printk_safe_enter_irq();
>
> What is the exact reason to keep this, please?

As Sergey pointed out [0], logbuf_lock_irq() does 2 things: logbuf_lock
and safe buffers. This series is not trying to remove the safe buffers
(a later series will). The series is only removing logbuf_lock. So all
logbuf_lock_*() calls will turn into printk_safe_*() calls. There are a
few exceptions, which you noticed and I will respond to.

[0] https://lkml.kernel.org/r/20201208203539.GB1667627@google.com

> 1. The primary function of the printk_safe context is to avoid deadlock
>    caused by logbuf_lock. It might have happened with recursive or nested
>    printk(). But logbuf_lock is gone now.

Agreed. Deadlock is not a concern anymore.

> 2. There are still some hidded locks that were guarded by this as
>    well. For example, console_owner_lock, or spinlock inside
>    console_sem, or scheduler locks taken when console_sem()
>    wakes another waiting process. It might still make sense
>    to somehow guard these.

This was not my motivation and I do not think it is an issue. I am not
aware of any technical need for the safe buffers to protect such
synchronization.

> 3. It kind of prevented infinite printk() recursion by using another
>    code path. The other path was limited by the size of the per-cpu
>    buffer. Well, recursion inside printk_safe code would likely
>    hit end of the stack first.

Yes, this was my main motivation. The safe buffers carry this
responsibility in mainline. So until a replacement for recursion
protection is in place, the safe buffers should remain.

And even if we decide we do not need/want recursion protection, I still
do not think this series should be the one to remove it. I only wanted
to remove logbuf_lock for now.

If we later have regressions, it will be helpful to bisect if the safe
buffers (with their local_irq_disable()) or the logbuf_lock were
involved.

> IMHO, we do not need printk safe context here in devkmsg_read().
> It does not belong into any categoty that is described above.
> logbug_lock() is gone. devkmsg_read() is never called directly
> from printk().

No. But it is calling printk_ringbuffer functions that can trigger
WARN_ONs that can trigger printk's.

> The same is true for almost entire patch. There are only two or so
> exceptions, see below.
>
>
>>  	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
>>  		if (file->f_flags & O_NONBLOCK) {
>>  			ret = -EAGAIN;
>> -			logbuf_unlock_irq();
>> +			printk_safe_exit_irq();
>>  			goto out;
>>  		}
>>  
>> -		logbuf_unlock_irq();
>> +		printk_safe_exit_irq();
>>  		ret = wait_event_interruptible(log_wait,
>>  				prb_read_valid(prb, atomic64_read(&user->seq), r));
>>  		if (ret)
>>  			goto out;
>> -		logbuf_lock_irq();
>> +		printk_safe_enter_irq();
>>  	}
>>  
>>  	if (atomic64_read(&user->seq) < prb_first_valid_seq(prb)) {
>>  		/* our last seen message is gone, return error and reset */
>>  		atomic64_set(&user->seq, prb_first_valid_seq(prb));
>>  		ret = -EPIPE;
>> -		logbuf_unlock_irq();
>> +		printk_safe_exit_irq();
>>  		goto out;
>>  	}
>>  
>
>
>> @@ -2593,7 +2559,6 @@ void console_unlock(void)
>>  		size_t len;
>>  
>>  		printk_safe_enter_irqsave(flags);
>> -		raw_spin_lock(&logbuf_lock);
>>  skip:
>>  		if (!prb_read_valid(prb, console_seq, &r))
>>  			break;
>
> I agree that printk_safe context makes sense in console_unlock().
> It prevents eventual deadlocks caused, for example by
> console_lock_owner.
>
> It also somehow prevents an infinite loop when a console driver would
> add a new message that would need to get flushed out as well which
> would trigger another messages ...
>
>
>> @@ -2973,9 +2933,7 @@ void register_console(struct console *newcon)
>>  		/*
>>  		 * console_unlock(); will print out the buffered messages
>>  		 * for us.
>> -		 */
>> -		logbuf_lock_irqsave(flags);
>
> I am just curious what was the motivation to remove printk_safe
> context here? It is a bit inconsistent with the other locations
> where you kept it.

This never should have been logbuf_lock_irqsave(flags) in the first
place. It would have been enough to just grab @logbuf_lock. The safe
buffers only make sense if printk or printk_ringbuffer functions are
called. Here we are just copying some variables (which are already
protected by console_sem and syslog_lock).

> IMHO, it can be removed. It does not fit into any category
> where it would help as described above.
>
> Anyway, we have to be consistent and explain it in the commit message.

I could add an earlier patch that changes logbuf_lock_irqsave() here to
spin_lock_irqsave() and explain. Then for this patch it would be clear
that it is just dropped.

>> -		/*
>> +		 *
>>  		 * We're about to replay the log buffer.  Only do this to the
>>  		 * just-registered console to avoid excessive message spam to
>>  		 * the already-registered consoles.
>> @@ -2988,11 +2946,9 @@ void register_console(struct console *newcon)
>>  		exclusive_console_stop_seq = console_seq;
>>  
>>  		/* Get a consistent copy of @syslog_seq. */
>> -		raw_spin_lock(&syslog_lock);
>> +		raw_spin_lock_irqsave(&syslog_lock, flags);
>
> I guess that you have added _irqsafe() variant here to preserve the
> original behavior.

Yes.

> I just wonder if it makes sense. We take the sleeping console_lock()
> in this function. This should not be allowed in a context
> with disabled interrupts.
>
> IMHO, we do not need the irqsafe variant here. But it probably should
> be removed in a separate patch. We should not hide it in this huge patch.

Yes. Let's put that in another patch. It is not related to logbuf_lock
removal.

>>  		console_seq = syslog_seq;
>> -		raw_spin_unlock(&syslog_lock);
>> -
>> -		logbuf_unlock_irqrestore(flags);
>> +		raw_spin_unlock_irqrestore(&syslog_lock, flags);
>>  	}
>>  	console_unlock();
>>  	console_sysfs_notify();
>> @@ -3414,9 +3366,11 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
>>  	struct printk_info info;
>>  	unsigned int line_count;
>>  	struct printk_record r;
>> +	unsigned long flags;
>>  	size_t l = 0;
>>  	bool ret = false;
>>  
>> +	printk_safe_enter_irqsave(flags);
>
> This change is neither obvious nor documented.

I noticed that this function was calling ringbuffer functions without
marking the region for safe buffers. I should have included a separate
patch before this one adding the safe buffers so that it would be
clear. Sorry.

> I guess that this is preparation step for unfying
> kmsg_dump_get_line_nolock() and kmsg_dump_get_line().
>
> Please, do it in the next patch and keep this one strightforward.

Or I will just do it in the following unification patch.

> That said, IMHO, the printk_safe() context is not needed here at all.
> This code is not called from printk() directly. The recursion is
> prevented by iter->next_seq or the buffer size.

My logic was: "If it is calling prb_*(), it should be protected by safe
buffers."

>>  	prb_rec_init_rd(&r, &info, line, size);
>>  
>>  	if (!iter->active)
>
>
>> @@ -3569,8 +3517,12 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>>   */
>>  void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
>>  {
>> +	unsigned long flags;
>> +
>> +	printk_safe_enter_irqsave(flags);
>
> This is the same as in kmsg_dump_get_line_nolock().
>
> Please, keep this huge patch strightforward. Either replace
> logbuf_lock*() with the corresponding printk_safe*() calls.
> Or do not add printk_safe*() where it is not needed.

Agreed. Sorry.

>>  	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
>>  	iter->next_seq = prb_next_seq(prb);
>> +	printk_safe_exit_irqrestore(flags);
>>  }
>>  
>>  /**
>
>> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
>> index a0e6f746de6c..a9a3137bd972 100644
>> --- a/kernel/printk/printk_safe.c
>> +++ b/kernel/printk/printk_safe.c
>> @@ -368,20 +354,21 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>>  #endif
>>  
>>  	/*
>> -	 * Try to use the main logbuf even in NMI. But avoid calling console
>> +	 * Use the main logbuf even in NMI. But avoid calling console
>>  	 * drivers that might have their own locks.
>>  	 */
>> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
>> -	    raw_spin_trylock(&logbuf_lock)) {
>> +	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
>> +		unsigned long flags;
>>  		int len;
>>  
>> +		printk_safe_enter_irqsave(flags);
>
> The printk_safe context does not make much sense here. The per-context
> redirection is done in vprintk_func(). It will always use this path
> because PRINTK_NMI_DIRECT_CONTEXT_MASK is handled before
> PRINTK_SAFE_CONTEXT_MASK.

If the following vprintk_store() calls printk(), those printk's should
land in safe buffers. If @printk_context is not incremented, they land
here again.

vprintk_store() relies on its caller to update @printk_context.

>>  		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
>> -		raw_spin_unlock(&logbuf_lock);
>> +		printk_safe_exit_irqrestore(flags);
>>  		defer_console_output();
>>  		return len;
>>  	}
>>  
>> -	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
>> +	/* Use extra buffer in NMI. */
>>  	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
>>  		return vprintk_nmi(fmt, args);
>
> I agree that it makes sense to keep vprintk_nmi() for now. It prevents
> an infinite recursion. I still hope that we will agree on a better
> solution later.
>
>
> Summary:
>
> I do not have a strong opinion whether to remove printk_safe
> enter/exit calls in this patch or in a separate one. I would
> be fine with both solutions.
>
> Anyway, please keep the patch as straightforward as possible.
> Please, do not move printk_safe context into another locations.
>
> Also provide more reasoning in the commit message. Why printk_safe
> enter/exit calls are preserved or why they can be removed.
>
> Feel free to mention that printk_safe context still makes sense on
> some locations, explain why, and say that it will be removed later.

OK. Thank you for the excellent response. I will go over this again.

John Ogness
