Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30B73E1DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 23:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbhHEV0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 17:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbhHEV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 17:26:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0908EC0613D5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 14:25:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628198750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZYp++T6FZwGQPJ2epsUaQfUvNJ2MplLv9vDsehcnrw=;
        b=u+ypxBTzJN1PJrfN8/Ygqdigj1F4JR+stcHh4pqN7fQDr3XXws6RdUq2Jx2O2by640p3YR
        oGisoS1l2BWQotDV43dm4Lm8P+CQKtS0LO2gD0ai0HTFDCUq0EoWK6gXeQslVUydI0sdkH
        uxrfNuqYE8HUy/yCF4b0BriL4Qahc0qy0Ed3XWjvvS5I2EBGfQzpl8Ja3YWUp09p0oBwR9
        YK9JdvdDa30X0G5S2v8d4Pcj/uXOgZCIP2CXrPC1mRM6qAr/kNbG/SP8lZ/O16DQOyYHpj
        yzOQg+zhfzwmMl1T2ecjTaUCdaH0Tadi3yETz77zyFkxZ5yrPaNm4BfP5VDMpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628198750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZYp++T6FZwGQPJ2epsUaQfUvNJ2MplLv9vDsehcnrw=;
        b=KeYVp5Iuv0+wRZM3plb/NejAtz6oIzx9C9qCrENM5TbRmCZB49kRIRpnoW9XeqEWtUm6wh
        Ie6RPyCPmqkNPBDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 08/10] printk: introduce kernel sync mode
In-Reply-To: <YQwbwJmhzXklJrGq@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de> <20210803131301.5588-9-john.ogness@linutronix.de> <YQwbwJmhzXklJrGq@alley>
Date:   Thu, 05 Aug 2021 23:31:49 +0206
Message-ID: <87mtpv1t42.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2021-08-03 15:18:59, John Ogness wrote:
>> Introduce "sync mode", which means that all printk calls will
>> synchronously write to the console. Once activated, this mode is
>> never deactivated. It is used when the kernel is about to end
>> (such as panic, oops, shutdown, reboot).
>> 
>> Sync mode can only be activated if atomic consoles are available.
>> 
>> In sync mode:
>> 
>> - only atomic consoles (write_atomic() callback) will print
>> - printing occurs within vprintk_store() instead of console_unlock()
>> 
>> CONSOLE_LOG_MAX is moved to printk.h to support the per-console
>> buffer used in sync mode.
>> 
>> diff --git a/include/linux/console.h b/include/linux/console.h
>> index 2f11b604e487..eda9b96e3fb6 100644
>> --- a/include/linux/console.h
>> +++ b/include/linux/console.h
>> @@ -151,6 +151,9 @@ struct console {
>>  	short	flags;
>>  	short	index;
>>  	int	cflag;
>> +#if defined(CONFIG_PRINTK) && defined(CONFIG_HAVE_ATOMIC_CONSOLE)
>> +	char	sync_buf[CONSOLE_LOG_MAX];
>
> Could it be allocated in register_console()?
>
> It is needed only when sync_write() callback is defined...

Agreed.

>> +#endif
>>  	void	*data;
>>  	struct	 console *next;
>>  };
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> +static bool print_sync(struct console *con, u64 *seq)
>> +{
>> +	struct printk_info info;
>> +	struct printk_record r;
>> +	size_t text_len;
>> +
>> +	prb_rec_init_rd(&r, &info, &con->sync_buf[0], sizeof(con->sync_buf));
>> +
>> +	if (!prb_read_valid(prb, *seq, &r))
>> +		return false;
>> +
>
> It should check suppress_message_printing().

Agreed. Nice catch.

>> +	text_len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
>> +
>> +	con->write_atomic(con, &con->sync_buf[0], text_len);
>> +
>> +	*seq = r.info->seq;
>> +
>> +	touch_softlockup_watchdog_sync();
>> +	clocksource_touch_watchdog();
>> +	rcu_cpu_stall_reset();
>> +	touch_nmi_watchdog();
>> +
>> +	if (text_len)
>> +		printk_delay(r.info->level);
>> +
>> +	return true;
>> +}
>> +
>> +static void print_sync_to(struct console *con, u64 seq)
>> +{
>> +	u64 printk_seq;
>> +
>> +	while (!__printk_cpu_trylock())
>> +		__printk_wait_on_cpu_lock();
>> +
>> +	for (;;) {
>> +		printk_seq = read_console_seq();
>> +		if (printk_seq > seq)
>> +			break;
>> +		if (!print_sync(con, &printk_seq))
>> +			break;
>> +#ifdef CONFIG_PRINTK_NMI
>> +		if (in_nmi()) {
>> +			latched_seq_write(&console_sync_nmi_seq, printk_seq + 1);
>> +			continue;
>> +		}
>> +#endif
>> +		latched_seq_write(&console_sync_seq, printk_seq + 1);
>> +	}
>> +
>> +	__printk_cpu_unlock();
>> +}
>> +
>> +static void call_sync_console_drivers(u64 seq)
>> +{
>> +	struct console *con;
>> +
>> +	for_each_console(con) {
>> +		if (!(con->flags & CON_ENABLED))
>> +			continue;
>> +		if (!con->write_atomic)
>> +			continue;
>> +		print_sync_to(con, seq);
>> +	}
>> +}
>> +#else
>> +
>> +#define read_console_seq()		latched_seq_read_nolock(&console_seq)
>> +#define in_sync_mode()			false
>> +#define enable_sync_mode()
>> +#define call_sync_console_drivers(seq)	((void)seq)
>> +
>> +#endif /* CONFIG_HAVE_ATOMIC_CONSOLE */
>> +
>>  /*
>>   * Special console_lock variants that help to reduce the risk of soft-lockups.
>>   * They allow to pass console_lock to another printk() call using a busy wait.
>> @@ -2084,6 +2231,8 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>>  		if (!cpu_online(smp_processor_id()) &&
>>  		    !(con->flags & CON_ANYTIME))
>>  			continue;
>> +		if (in_sync_mode())
>> +			continue;
>
> IMHO, this causes that console_unlock() will iterate over all pending
> messsages without calling console. But it will still increment
> console_seq.
>
> As a result, the messages will be skipped also by print_sync_to() because
> read_console_seq() will return the incremented value.
>
> I think that we need to break the iteration in console_unlock().
>
> Or do I miss something?

You are correct.

>>  		if (con->flags & CON_EXTENDED)
>>  			con->write(con, ext_text, ext_len);
>>  		else {
>> @@ -2251,6 +2400,7 @@ int vprintk_store(int facility, int level,
>>  	const u32 caller_id = printk_caller_id();
>>  	struct prb_reserved_entry e;
>>  	enum printk_info_flags flags = 0;
>> +	bool final_commit = false;
>>  	struct printk_record r;
>>  	unsigned long irqflags;
>>  	u16 trunc_msg_len = 0;
>> @@ -2261,6 +2411,7 @@ int vprintk_store(int facility, int level,
>>  	u16 text_len;
>>  	int ret = 0;
>>  	u64 ts_nsec;
>> +	u64 seq;
>>  
>>  	/*
>>  	 * Since the duration of printk() can vary depending on the message
>> @@ -2299,6 +2450,7 @@ int vprintk_store(int facility, int level,
>>  	if (flags & LOG_CONT) {
>>  		prb_rec_init_wr(&r, reserve_size);
>>  		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
>> +			seq = r.info->seq;
>>  			text_len = printk_sprint(&r.text_buf[r.info->text_len], reserve_size,
>>  						 facility, &flags, fmt, args);
>>  			r.info->text_len += text_len;
>> @@ -2306,6 +2458,7 @@ int vprintk_store(int facility, int level,
>>  			if (flags & LOG_NEWLINE) {
>>  				r.info->flags |= LOG_NEWLINE;
>>  				prb_final_commit(&e);
>> +				final_commit = true;
>>  			} else {
>>  				prb_commit(&e);
>>  			}
>> @@ -2330,6 +2483,8 @@ int vprintk_store(int facility, int level,
>>  			goto out;
>>  	}
>>  
>> +	seq = r.info->seq;
>> +
>>  	/* fill message */
>>  	text_len = printk_sprint(&r.text_buf[0], reserve_size, facility, &flags, fmt, args);
>>  	if (trunc_msg_len)
>> @@ -2344,13 +2499,19 @@ int vprintk_store(int facility, int level,
>>  		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
>>  
>>  	/* A message without a trailing newline can be continued. */
>> -	if (!(flags & LOG_NEWLINE))
>> +	if (!(flags & LOG_NEWLINE)) {
>>  		prb_commit(&e);
>> -	else
>> +	} else {
>>  		prb_final_commit(&e);
>> +		final_commit = true;
>> +	}
>>  
>>  	ret = text_len + trunc_msg_len;
>>  out:
>> +	/* only the kernel may perform synchronous printing */
>> +	if (in_sync_mode() && facility == 0 && final_commit)
>> +		call_sync_console_drivers(seq);
>
> Is there any reason why this is called from vprintk_emit()?
>
> I guess that you wanted to call it before releasing IRQ.
> But is it really necessary? call_sync_console_drivers(seq)
> reads the message again via the seq number anyway.

The goal of sync mode is for all printk callers to print
synchronously. The synchronous printing occurs at the earliest possible
moment (immediately after the record has been stored in the
ringbuffer).

Although sync mode is used for non-crash scenarios (halt/reboot), it is
tuned for crash scenarios. I think we should be pushing those messages
out as soon as possible and not do things like re-enable interrupts
first.

> I have to say that the new code makes the printk() code/api much more
> twisted. It is a combination of the naming scheme and design.

Thank you for this comment. I may be too focussed on the end goal and
not investing enough care to maximize the beauty of these intermediate
releases.

> The original code path is:
>
>   + printk()
>     + vprintk_emit()
>       + vprintk_store()
>       + console_trylock()
>       + console_unlock()
> 	+ prb_read_valid()
> 	+ record_print_text()
> 	+ call_console_drivers()
> 	  + con->write()
>
> The new code path is:
>
>   + printk()
>     + vprintk_emit()
>       + vprintk_store()
> 	+ call_sync_console_drivers()
> 	  + printk_sync_to()
> 	    + print_sync()
> 	      + prb_read_valid()
> 	      + record_print_text()
> 	      + con->write_atomic()
>
>
> One thing is the ordering of the api names:
>
>   + printk -> vprintk -> console -> record_print -> call_console -> con -> write
> vs.
>   + printk -> vprintk -> call_console -> print -> record_print -> con -> write
>
>
> The original patch called console() API from printk() API. The most
> ugly things were:
>
>     + console_unlock() flushed the messages to the console.
>       A cleaner API would be:
>
> 	console_lock();
> 	console_flush();
> 	console_unlock();
>
>
>     + record_print() called from console_unlock(). The "print" name
>       name makes it hard to distinguish from the "printk" API.
>       But it does a completely different job:
>
> 	+ "printk" API stores the message and call console
> 	+ "record_print" API converts the message into the console format
>
>
> The new code adds even more twists:
>
>     + Adds yet another "print" API. It has another meaning than
>       "printk" or "record_print" API:
>
> 	+ "printk" API stores the message and call console
> 	+ "print" API prints the message to the console
> 	+ "record_print" API converts the message into the console format
>
>
>     + call_sync_console_drivers() does similar job as console_unlock()
>       (iterates over all pending messages, read, format, call console).
>       While the original call_console_drivers() only called the
>       console. The logic is somehow inside out.

It is difficult for me to compare code that is planned for complete
removal with new functions (which in several cases are also planned for
complete removal).

I will seriously consider your naming/design comments and try to rework
things that fit better into the current scheme of things.

> This is why I opened the discussion about the behavior with console
> kthreads.
>
> I think that we might need another synchronous mode also for the early
> boot, suspend, kexec, panic, for non-atomic consoles. We might need
> another cycle/solution when there are per-console kthreads.

I think our energies are better spent engineering more atomic
consoles. Trying to make non-atomic code work in atomic context usually
causes more problems than it solves.

Keep in mind we do have a real world implementation (PREEMPT_RT series)
where 8250 UART users can test if kthread printers and atomic consoles
are a genuine improvement (i.e. printk never disturbs the system during
runtime and crash scenarios are reliably pushing out dumps via the 8250
atomic console). Rather than speculating if something is missing, I
prefer that users test and point out real existing issues. Obviously the
PREEMPT_RT series is not being merged 1:1 into mainline, but with regard
to printk, PREEMPT_RT is functionally fairly close to what I am aiming
for.

> I would prefer to somehow refactor the existing console_unlock()
> so that the iteration over pending messages and call_console_drivers()
> might be usable also in the other sync modes, console kthreads, ...

I will do my best to interpret these suggestions.

> PS: I have vacation the following two weeks. I am still going to work
>     tomorrow (Friday) but I am not sure how much time I will have to
>     discuss this. I am afraid that I won't be able to help much before
>     I am back from the vacation.

Thank you for taking time this week for so much feedback. I have plenty
to prepare for v2.

John Ogness
