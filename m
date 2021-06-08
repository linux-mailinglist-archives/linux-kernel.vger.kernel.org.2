Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19B639F543
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhFHLm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:42:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38340 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhFHLm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:42:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 80EDE1FD33;
        Tue,  8 Jun 2021 11:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623152433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pqTdmb4ajlEiuOedwu42jHW2ZkkaCsnLspnZNVDMmM=;
        b=tByp5qXLxRMV1e+qtQ1lqEnGgHeH//ZLoJaUINXon6RAy1kvEv0GQjwzqZOU8BEUDogSi7
        DwXKptTST8y/nzhyvom9cD8wIaxcHZakYEBH0v7+LKUuuempGxH/AOLW45GlBtH7hRtaOx
        KH4rpsZJArj4t1Wcz+dmoIDUjNvOdZU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 03ECDA3B87;
        Tue,  8 Jun 2021 11:40:32 +0000 (UTC)
Date:   Tue, 8 Jun 2021 13:40:32 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH next v2 1/2] dump_stack: move cpu lock to printk.c
Message-ID: <YL9XMBxeZ4fGRS79@alley>
References: <20210607200232.22211-1-john.ogness@linutronix.de>
 <20210607200232.22211-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607200232.22211-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-06-07 22:02:31, John Ogness wrote:
> dump_stack() implements its own cpu-reentrant spinning lock to
> best-effort serialize stack traces in the printk log. However,
> there are other functions (such as show_regs()) that can also
> benefit from this serialization.
> 
> Move the cpu-reentrant spinning lock (cpu lock) into new helper
> functions printk_cpu_lock_irqsave()/printk_cpu_unlock_irqrestore()
> so that it is available for others as well. For !CONFIG_SMP the
> cpu lock is a NOP.
> 
> Note that having multiple cpu locks in the system can easily
> lead to deadlock. Code needing a cpu lock should use the
> printk cpu lock, since the printk cpu lock could be acquired
> from any code and any context.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

There are some nits below but the patch looks fine to me as it.

Reviewed-by: Petr Mladek <pmladek@suse.com>

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3532,3 +3532,78 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
> +void printk_cpu_lock_irqsave(bool *lock_flag, unsigned long *irq_flags)
> +{
> +	int old;
> +	int cpu;
> +
> +retry:
> +	local_irq_save(*irq_flags);
> +
> +	cpu = smp_processor_id();
> +
> +	old = atomic_cmpxchg(&printk_cpulock_owner, -1, cpu);
> +	if (old == -1) {
> +		/* This CPU is now the owner. */
> +

Superfluous space?

> +		*lock_flag = true;

The original name name "was_locked" was more descriptive. I agree that
it was not good for an API. What about keeping the inverted logic and
calling it "lock_nested" ?

I do not resist on any change. The logic is trivial so...

> +
> +	} else if (old == cpu) {
> +		/* This CPU is already the owner. */
> +
> +		*lock_flag = false;
> +

Even more superfluous spaces?

> +	} else {
> +		local_irq_restore(*irq_flags);
> +
> +		/*
> +		 * Wait for the lock to release before jumping to cmpxchg()
> +		 * in order to mitigate the thundering herd problem.
> +		 */
> +		do {
> +			cpu_relax();
> +		} while (atomic_read(&printk_cpulock_owner) != -1);
> +
> +		goto retry;
> +	}
> +}
> +EXPORT_SYMBOL(printk_cpu_lock_irqsave);
> +
> +/*
> + * printk_cpu_unlock_irqrestore: Release the printk cpu-reentrant spinning
> + *                               lock and restore interrupts.
> + * @lock_flag: The current lock state.
> + * @irq_flags: The current irq state.

"The current" is a bit misleading. Both values actually describe
the state before the related printk_cpu_lock_irqsave().
What about something like?

  * @lock_nested: Lock state set when the lock was taken.
  * @irq_flags: IRQ flags stored when the lock was taken.


> + *
> + * Release the lock. The calling processor must be the owner of the lock.
> + *
> + * It is safe to call this function from any context and state.
> + */
> +void printk_cpu_unlock_irqrestore(bool lock_flag, unsigned long irq_flags)
> +{
> +	if (lock_flag) {
> +		atomic_set(&printk_cpulock_owner, -1);
> +
> +		local_irq_restore(irq_flags);
> +	}
> +}
> +EXPORT_SYMBOL(printk_cpu_unlock_irqrestore);
> +#endif /* CONFIG_SMP */

 Best Regards,
 Petr
 
