Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAED430BAC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhBBJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:17:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:41076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231621AbhBBJQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:16:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612257337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Po2Q/2zwzavvhoOnN15a5ryoMFy4vJPIEnIH7L7Khw=;
        b=pvmwFpqMDy/t9KwnRCKmGfTHuoUl/YZkOLzJYrOLwNqihOqeEJw6t7324hrZsBYih1IMbE
        BqsmGBJcDeQRuWfpZ3Qkt85OJJDbEGFpm1YNWblj/mBCK0uFub9RGoiYumid+wMSZDsHeM
        MD32s7rp/NLbaLrg+BtPtbK/pCeKyJs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 847EEB049;
        Tue,  2 Feb 2021 09:15:37 +0000 (UTC)
Date:   Tue, 2 Feb 2021 10:15:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 11/12] printk: remove logbuf_lock
Message-ID: <YBkYOKL22kADKTeG@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de>
 <20210126211551.26536-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126211551.26536-12-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-01-26 22:21:50, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock.
> 
> This means that printk_nmi_direct and printk_safe_flush_on_panic()
> no longer need to acquire any lock to run.
> 
> @console_seq, @exclusive_console_stop_seq, @console_dropped are
> protected by @console_lock.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index d14a4afc5b72..b57dba7f077d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -401,6 +366,7 @@ static u64 syslog_seq;
>  static size_t syslog_partial;
>  static bool syslog_time;
>  
> +/* All 3 protected by @console_sem. */
>  /* the next printk record to write to the console */
>  static u64 console_seq;
>  static u64 exclusive_console_stop_seq;
> @@ -762,27 +728,27 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>  	if (ret)
>  		return ret;
>  
> -	logbuf_lock_irq();
> +	printk_safe_enter_irq();

What is the exact reason to keep this, please?

1. The primary function of the printk_safe context is to avoid deadlock
   caused by logbuf_lock. It might have happened with recursive or nested
   printk(). But logbuf_lock is gone now.

2. There are still some hidded locks that were guarded by this as
   well. For example, console_owner_lock, or spinlock inside
   console_sem, or scheduler locks taken when console_sem()
   wakes another waiting process. It might still make sense
   to somehow guard these.

3. It kind of prevented infinite printk() recursion by using another
   code path. The other path was limited by the size of the per-cpu
   buffer. Well, recursion inside printk_safe code would likely
   hit end of the stack first.


IMHO, we do not need printk safe context here in devkmsg_read().
It does not belong into any categoty that is described above.
logbug_lock() is gone. devkmsg_read() is never called directly
from printk().

The same is true for almost entire patch. There are only two
or so exceptions, see below.


>  	if (!prb_read_valid(prb, atomic64_read(&user->seq), r)) {
>  		if (file->f_flags & O_NONBLOCK) {
>  			ret = -EAGAIN;
> -			logbuf_unlock_irq();
> +			printk_safe_exit_irq();
>  			goto out;
>  		}
>  
> -		logbuf_unlock_irq();
> +		printk_safe_exit_irq();
>  		ret = wait_event_interruptible(log_wait,
>  				prb_read_valid(prb, atomic64_read(&user->seq), r));
>  		if (ret)
>  			goto out;
> -		logbuf_lock_irq();
> +		printk_safe_enter_irq();
>  	}
>  
>  	if (atomic64_read(&user->seq) < prb_first_valid_seq(prb)) {
>  		/* our last seen message is gone, return error and reset */
>  		atomic64_set(&user->seq, prb_first_valid_seq(prb));
>  		ret = -EPIPE;
> -		logbuf_unlock_irq();
> +		printk_safe_exit_irq();
>  		goto out;
>  	}
>  


> @@ -2593,7 +2559,6 @@ void console_unlock(void)
>  		size_t len;
>  
>  		printk_safe_enter_irqsave(flags);
> -		raw_spin_lock(&logbuf_lock);
>  skip:
>  		if (!prb_read_valid(prb, console_seq, &r))
>  			break;

I agree that printk_safe context makes sense in console_unlock().
It prevents eventual deadlocks caused, for example by
console_lock_owner.

It also somehow prevents an infinite loop when a console driver would
add a new message that would need to get flushed out as well which
would trigger another messages ...


> @@ -2973,9 +2933,7 @@ void register_console(struct console *newcon)
>  		/*
>  		 * console_unlock(); will print out the buffered messages
>  		 * for us.
> -		 */
> -		logbuf_lock_irqsave(flags);

I am just curious what was the motivation to remove printk_safe
context here? It is a bit inconsistent with the other locations
where you kept it.

IMHO, it can be removed. It does not fit into any category
where it would help as described above.

Anyway, we have to be consistent and explain it in the commit message.



> -		/*
> +		 *
>  		 * We're about to replay the log buffer.  Only do this to the
>  		 * just-registered console to avoid excessive message spam to
>  		 * the already-registered consoles.
> @@ -2988,11 +2946,9 @@ void register_console(struct console *newcon)
>  		exclusive_console_stop_seq = console_seq;
>  
>  		/* Get a consistent copy of @syslog_seq. */
> -		raw_spin_lock(&syslog_lock);
> +		raw_spin_lock_irqsave(&syslog_lock, flags);

I guess that you have added _irqsafe() variant here to preserve the
original behavior.

I just wonder if it makes sense. We take the sleeping console_lock()
in this function. This should not be allowed in a context
with disabled interrupts.

IMHO, we do not need the irqsafe variant here. But it probably should
be removed in a separate patch. We should not hide it in this huge patch.


>  		console_seq = syslog_seq;
> -		raw_spin_unlock(&syslog_lock);
> -
> -		logbuf_unlock_irqrestore(flags);
> +		raw_spin_unlock_irqrestore(&syslog_lock, flags);
>  	}
>  	console_unlock();
>  	console_sysfs_notify();
> @@ -3414,9 +3366,11 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper_iter *iter, bool syslog,
>  	struct printk_info info;
>  	unsigned int line_count;
>  	struct printk_record r;
> +	unsigned long flags;
>  	size_t l = 0;
>  	bool ret = false;
>  
> +	printk_safe_enter_irqsave(flags);

This change is neither obvious nor documented.

I guess that this is preparation step for unfying
kmsg_dump_get_line_nolock() and kmsg_dump_get_line().

Please, do it in the next patch and keep this one strightforward.

That said, IMHO, the printk_safe() context is not needed here at all.
This code is not called from printk() directly. The recursion is
prevented by iter->next_seq or the buffer size.


>  	prb_rec_init_rd(&r, &info, line, size);
>  
>  	if (!iter->active)


> @@ -3569,8 +3517,12 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>   */
>  void kmsg_dump_rewind_nolock(struct kmsg_dumper_iter *iter)
>  {
> +	unsigned long flags;
> +
> +	printk_safe_enter_irqsave(flags);

This is the same as in kmsg_dump_get_line_nolock().

Please, keep this huge patch strightforward. Either replace
logbuf_lock*() with the corresponding printk_safe*() calls.
Or do not add printk_safe*() where it is not needed.

>  	iter->cur_seq = latched_seq_read_nolock(&clear_seq);
>  	iter->next_seq = prb_next_seq(prb);
> +	printk_safe_exit_irqrestore(flags);
>  }
>  
>  /**

> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index a0e6f746de6c..a9a3137bd972 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -368,20 +354,21 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  #endif
>  
>  	/*
> -	 * Try to use the main logbuf even in NMI. But avoid calling console
> +	 * Use the main logbuf even in NMI. But avoid calling console
>  	 * drivers that might have their own locks.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
> -	    raw_spin_trylock(&logbuf_lock)) {
> +	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
> +		unsigned long flags;
>  		int len;
>  
> +		printk_safe_enter_irqsave(flags);

The printk_safe context does not make much sense here. The per-context
redirection is done in vprintk_func(). It will always use this path
because PRINTK_NMI_DIRECT_CONTEXT_MASK is handled before
PRINTK_SAFE_CONTEXT_MASK.

>  		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
> -		raw_spin_unlock(&logbuf_lock);
> +		printk_safe_exit_irqrestore(flags);
>  		defer_console_output();
>  		return len;
>  	}
>  
> -	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
> +	/* Use extra buffer in NMI. */
>  	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
>  		return vprintk_nmi(fmt, args);

I agree that it makes sense to keep vprintk_nmi() for now. It prevents
an infinite recursion. I still hope that we will agree on a better
solution later.


Summary:

I do not have a strong opinion whether to remove printk_safe
enter/exit calls in this patch or in a separate one. I would
be fine with both solutions.

Anyway, please keep the patch as straightforward as possible.
Please, do not move printk_safe context into another locations.

Also provide more reasoning in the commit message. Why printk_safe
enter/exit calls are preserved or why they can be removed.

Feel free to mention that printk_safe context still makes sense on
some locations, explain why, and say that it will be removed later.

Best Regards,
Petr
