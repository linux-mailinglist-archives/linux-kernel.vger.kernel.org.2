Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA5310A03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBELNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:13:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:48060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhBELKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:10:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612523395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RiFnfJjtFsj5ti5e/2PFrSEZfZLdOYj80gs4VIm0Xhw=;
        b=lmycmO81HTCqAkDPHjst08KGwntH5P0u3TQQ9k6cGBgRAwQUBpfKkiXIVCLHTyDPhEPa8J
        z0FDUsVjBFN9bMFHBBYwDuOrqRWmvcbWrwX1spNZwkhsF1zCO4xwUvdf5vSruWa6TtHmcA
        9DPWVztLZCVcOAerz1Gn5LLVeNtaNi0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3109AD29;
        Fri,  5 Feb 2021 11:09:54 +0000 (UTC)
Date:   Fri, 5 Feb 2021 12:09:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix deadlock when kernel panic
Message-ID: <YB0nggSa7a95UCIK@alley>
References: <20210201102601.87168-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201102601.87168-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first, I am sorry for the late reply. I have been somehow distracted
this week.

On Mon 2021-02-01 18:26:01, Muchun Song wrote:
> We found a deadlock bug on our server when the kernel panic. It can be
> described in the following diagram.
> 
> CPU0:                                         CPU1:
> panic                                         rcu_dump_cpu_stacks
>   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
>     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
>                                                     __printk_safe_flush
>                                                       raw_spin_lock_irqsave(&read_lock)
>     // send NMI to other processors
>     apic_send_IPI_allbutself(NMI_VECTOR)
>                                                         // NMI interrupt, dead loop
>                                                         crash_nmi_callback
>   printk_safe_flush_on_panic
>     printk_safe_flush
>       __printk_safe_flush
>         // deal lock
>         raw_spin_lock_irqsave(&read_lock)

Great catch!

>  kernel/printk/printk_safe.c | 58 ++++++++++++++++++++++++++-------------------
>  1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index a0e6f746de6c..86d9fa74ac5c 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -174,30 +174,13 @@ static void report_message_lost(struct printk_safe_seq_buf *s)
>  		printk_deferred("Lost %d message(s)!\n", lost);
>  }
>  
> -/*
> - * Flush data from the associated per-CPU buffer. The function
> - * can be called either via IRQ work or independently.
> - */
> -static void __printk_safe_flush(struct irq_work *work)
> +static void __printk_safe_flush_work(struct irq_work *work)
>  {
> -	static raw_spinlock_t read_lock =
> -		__RAW_SPIN_LOCK_INITIALIZER(read_lock);
>  	struct printk_safe_seq_buf *s =
>  		container_of(work, struct printk_safe_seq_buf, work);
> -	unsigned long flags;
>  	size_t len;
> -	int i;
> +	int i = 0;
>  
> -	/*
> -	 * The lock has two functions. First, one reader has to flush all
> -	 * available message to make the lockless synchronization with
> -	 * writers easier. Second, we do not want to mix messages from
> -	 * different CPUs. This is especially important when printing
> -	 * a backtrace.
> -	 */
> -	raw_spin_lock_irqsave(&read_lock, flags);
> -
> -	i = 0;
>  more:
>  	len = atomic_read(&s->len);
>  
> @@ -232,6 +215,26 @@ static void __printk_safe_flush(struct irq_work *work)
>  
>  out:
>  	report_message_lost(s);
> +}
> +
> +/*
> + * Flush data from the associated per-CPU buffer. The function
> + * can be called either via IRQ work or independently.
> + */
> +static void printk_safe_flush_work(struct irq_work *work)
> +{
> +	unsigned long flags;
> +	static DEFINE_RAW_SPINLOCK(read_lock);
> +
> +	/*
> +	 * The lock has two functions. First, one reader has to flush all
> +	 * available message to make the lockless synchronization with
> +	 * writers easier. Second, we do not want to mix messages from
> +	 * different CPUs. This is especially important when printing
> +	 * a backtrace.
> +	 */
> +	raw_spin_lock_irqsave(&read_lock, flags);
> +	__printk_safe_flush_work(work);
>  	raw_spin_unlock_irqrestore(&read_lock, flags);
>  }
>  
> @@ -248,9 +251,9 @@ void printk_safe_flush(void)
>  
>  	for_each_possible_cpu(cpu) {
>  #ifdef CONFIG_PRINTK_NMI
> -		__printk_safe_flush(&per_cpu(nmi_print_seq, cpu).work);
> +		printk_safe_flush_work(&per_cpu(nmi_print_seq, cpu).work);
>  #endif
> -		__printk_safe_flush(&per_cpu(safe_print_seq, cpu).work);
> +		printk_safe_flush_work(&per_cpu(safe_print_seq, cpu).work);
>  	}
>  }
>  
> @@ -266,6 +269,8 @@ void printk_safe_flush(void)
>   */
>  void printk_safe_flush_on_panic(void)
>  {
> +	int cpu;
> +
>  	/*
>  	 * Make sure that we could access the main ring buffer.
>  	 * Do not risk a double release when more CPUs are up.
> @@ -278,7 +283,12 @@ void printk_safe_flush_on_panic(void)
>  		raw_spin_lock_init(&logbuf_lock);
>  	}
>  
> -	printk_safe_flush();
> +	for_each_possible_cpu(cpu) {
> +#ifdef CONFIG_PRINTK_NMI
> +		__printk_safe_flush_work(&per_cpu(nmi_print_seq, cpu).work);
> +#endif
> +		__printk_safe_flush_work(&per_cpu(safe_print_seq, cpu).work);
> +	}

There might be two CPUs running this code when more CPUs are still running.
The might definitely be the case here:

	if (!_crash_kexec_post_notifiers) {
		printk_safe_flush_on_panic();
		__crash_kexec(NULL);

__printk_safe_flush_work() is relatively safe even in this case.
It accesses only data that are limited by s->len that is updated
atomically.

But it calls:

  + printk_safe_flush_on_panic()
    + __printk_safe_flush_work()
      +  printk_safe_flush_buffer()
	+ printk_safe_flush_line()
	  + printk_deferred()

where printk_deferred() used logbuf_lock() until v5.11-rc1, see
the commit b031a684bfd01d633c ("printk: remove logbuf_lock
writer-protection of ringbuffer").

We need a solution that might be backported back to v4.7-rc1
where logbuf_lock() might cause a deadlock.

Also we really want to call printk_safe_flush_on_panic()
in panic(). It is trying hard but it should not cause
deadlock.

Therefore, I suggest to handle read_lock the same way in
printk_safe_flush_on_panic() as we handle logbuf_lock there.

I mean to make it global in printk_safe.c:

static DEFINE_RAW_SPINLOCK(safe_read_lock);

and do something like this in printk_safe_flush_on_panic()

	if (raw_spin_is_locked(&safe_read_lock)) {
		if (num_online_cpus() > 1)
			return;

		debug_locks_off();
		raw_spin_lock_init(&safe_read_lock);
	}

How does that sound, please?

Best Regards,
Petr
