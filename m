Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB4630A862
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhBANMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:12:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57534 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhBANMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:12:39 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612185116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUaCyr3F7lqUdpg4F0N9kWvTDUoAE0/ywIy7lgPol1Y=;
        b=LKQ9SVA7OazpDeEL++kzx1lrPvmddTdlJM7N2q+ye8vftUs5cuTPlFrZDaUaEBL3RDz3cy
        dqq+H0pc/B8k6CIgTU7lwYvIJnUmvRHN1Xce8GvmQN0gLhnB34lfvp0ndPDJ2n7njohe9g
        G+xN1vB34qwUyD7gLGSKKRftA5IGTLpD80pmOROWP5uqQI4LOOUAHjKvumgCseDwcvQSJN
        lSS8cpjNzKvlpk0BT/eQt+YYumUacENOhfKX5iC+QdyaGtgAC8tdhH6NBqskyqhniVK57R
        AzuK9Vn/aXC4qty74m474jwIsYKei2k1qQL7J2L4xJ5tzS+VRe7D0ZBiBQ5qFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612185116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eUaCyr3F7lqUdpg4F0N9kWvTDUoAE0/ywIy7lgPol1Y=;
        b=i9BKcFmNuVf6k65hRZktN7NvsYtG3J2GoFgLW1oaMvvTBZ2x8jIcffHob9awGz2I+ee24U
        rFN6qoO2/pcymyCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk-rework 07/12] printk: add syslog_lock
In-Reply-To: <YBfzfs9zU8rgHl6y@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-8-john.ogness@linutronix.de> <YBfzfs9zU8rgHl6y@alley>
Date:   Mon, 01 Feb 2021 14:17:55 +0106
Message-ID: <87h7mwj5k4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-01, Petr Mladek <pmladek@suse.com> wrote:
>> The global variables @syslog_seq, @syslog_partial, @syslog_time
>> and write access to @clear_seq are protected by @logbuf_lock.
>> Once @logbuf_lock is removed, these variables will need their
>> own synchronization method. Introduce @syslog_lock for this
>> purpose.
>
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -390,8 +390,12 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
>>  		printk_safe_exit_irqrestore(flags);	\
>>  	} while (0)
>>  
>> +/* syslog_lock protects syslog_* variables and write access to clear_seq. */
>> +static DEFINE_RAW_SPINLOCK(syslog_lock);
>
> I am not expert on RT code but I think that it prefers the generic
> spinlocks. syslog_lock seems to be used in a normal context.
> IMHO, it does not need to be a raw spinlock.
>
> Note that using normal spinlock would require switching the locking
> order. logbuf_lock is a raw lock. Normal spinlock must not be taken
> under a raw spinlock.
>
> Or we could switch syslog_lock to the normal spinlock later
> after logbuf_lock is removed.

I was planning on this last option because I think it is the
simplest. There are places such as syslog_print_all() where the
printk_safe_enter() and logbuf_lock locking are not at the same place as
the syslog_lock locking (and syslog_lock is inside).

Once the safe buffers are removed, syslog_lock can transition to a
spinlock. (spinlock's must not be under local_irq_save().)

>> +
>>  #ifdef CONFIG_PRINTK
>>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>> +/* All 3 protected by @syslog_lock. */
>>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
>>  static u64 syslog_seq;
>>  static size_t syslog_partial;
>> @@ -1631,6 +1643,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
>>  	bool clear = false;
>>  	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
>>  	int error;
>> +	u64 seq;
>
> This allows to remove definition of the same temporary variable
> for case SYSLOG_ACTION_SIZE_UNREAD.

Right. I missed that.

>>  
>>  	error = check_syslog_permissions(type, source);
>>  	if (error)
>> @@ -1648,8 +1661,14 @@ int do_syslog(int type, char __user *buf, int len, int source)
>>  			return 0;
>>  		if (!access_ok(buf, len))
>>  			return -EFAULT;
>> +
>> +		/* Get a consistent copy of @syslog_seq. */
>> +		raw_spin_lock_irq(&syslog_lock);
>> +		seq = syslog_seq;
>> +		raw_spin_unlock_irq(&syslog_lock);
>> +
>>  		error = wait_event_interruptible(log_wait,
>> -				prb_read_valid(prb, syslog_seq, NULL));
>> +				prb_read_valid(prb, seq, NULL));
>
> Hmm, this will not detect when syslog_seq gets cleared in parallel.
> I hope that nobody rely on this behavior. But who knows?
>
> A solution might be to have also syslog_seq latched. But I am
> not sure if it is worth it.
>
> I am for taking the risk and use the patch as it is now. Let's keep
> the code for now. We could always use the latched variable when
> anyone complains. Just keep it in mind.

We could add a simple helper:

/* Get a consistent copy of @syslog_seq. */
static u64 syslog_seq_read(void)
{
    unsigned long flags;

    raw_spin_lock_irqsave(&syslog_lock, flags);
    seq = syslog_seq;
    raw_spin_unlock_irqrestore(&syslog_lock, flags);
    return seq;
}

Then change the code to:

    error = wait_event_interruptible(log_wait,
                    prb_read_valid(prb, read_syslog_seq(), NULL));


register_console() could also make use of the function. (That is why I
am suggesting the flags variant.)

John Ogness
