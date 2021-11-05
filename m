Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA744461BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhKEJ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhKEJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:58:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C7C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 02:55:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636106134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qh6RxtEJsuIwX72Zd/aEZ9gJ+PJVkg8DjOskJnoW+gM=;
        b=MAfXmulExhmA4I8HyVrh4Cqw+1mhxI7hFqKKGC3Uh2hS4CReHEtlCXcfQFzek87Z6ogVHI
        w9aBAW1avQoUYqqbsyfUM84SfMiTAwbx8xIEtif4Sx3NNjyOFbekLfzykLAR/J2oTmXErd
        G8x6rRjxYs9DUZHA9dQ3ipWY7REDE3M2YrHFKEEQzGMdGN/Skwp9lB0VRLsYM8VyFdbp/i
        ASvMcemdcS4FVFsxsjggO+6zpN1Q1BpMLQNujRQ6F1ECKVxOWAtAO6GO7L19JfdJYO74wj
        bkD54uOpVEoKVQbU2Fha1W2hiFWq7ePw7ra4aTvAzVEqhKv0+udwG+DqFhb9Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636106134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qh6RxtEJsuIwX72Zd/aEZ9gJ+PJVkg8DjOskJnoW+gM=;
        b=JA8w/xDPkweGESOk1FnwebI/FZJgRrQ48MRY5W7crUzFjajlSJc3bSUoXdBTqBzhxMwp6H
        BKBnylMo071nYCCQ==
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
In-Reply-To: <1636073838.qpmyp6q17i.astroid@bobo.none>
References: <1636039236.y415994wfa.astroid@bobo.none>
 <87ee7vki7f.fsf@jogness.linutronix.de>
 <1636073838.qpmyp6q17i.astroid@bobo.none>
Date:   Fri, 05 Nov 2021 11:01:33 +0106
Message-ID: <87r1bv2aga.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>> We are planning on implementing a pr_flush() that will do something
>> similar. But I am wondering how you are planning on triggering a CPU
>> to call that function.
>
> Similar way as was removed by commit 93d102f094b ("printk: remove safe
> buffers") fro nmi_backtrace and powerpc watchdog. The following patch
> is what I'm using which seems to work for me.

What was removed from 93d102f094b was irq_work triggering on all
CPUs. Your patch is attempting to directly print from a non-NMI
context. This is obviously a better approach if a caller is known to be
non-NMI.

Also, before 93d102f094b the safe buffer flushing was performed before
triggering the NMI backtraces (in some cases). So clearly it worked
before by accident rather than by design. (Not that that really
matters.)

> What would pr_flush do differently and where were you planning to use
> it?

Currently, and particularly when we move to threaded printers, printk
callers do not know when their messages are actually visible. However,
in some cases the printk caller (or some related task) wants to be sure
the message is visible.

pr_flush() will allow a task to block until all pending messages (at the
time of the call) are output on all consoles.

Your patch is doing something similar for non-NMI contexts, except that
it will exit early if it fails to get the console lock. For your case
this is probably acceptable because you are only concerned that some
context is printing the messages, even if the latest messages may not
have been printed yet.

>     printk: restore flushing of NMI buffers on remote CPUs after NMI backtraces
>     
>     printk from NMI context relies on irq work being raised on the local CPU
>     to print to console. This can be a problem if the NMI was raised by a
>     lockup detector to print lockup stack and regs, because the CPU may not
>     enable irqs (because it is locked up).
>     
>     Introduce printk_flush() that can be called from non-NMI context on
>     another CPU to try to get those messages to the console.
>     
>     Fixes: 93d102f094be ("printk: remove safe buffers")
>     Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 5f69ba4de1f3..59ddb24797ae 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -227,6 +227,12 @@ static void watchdog_smp_panic(int cpu)
>  		cpumask_clear(&wd_smp_cpus_ipi);
>  	}
>  
> +	/*
> +	 * Force flush any remote buffers that might be stuck in IRQ context
> +	 * and therefore could not run their irq_work.
> +	 */
> +	printk_flush();
> +

nmi_trigger_cpumask_backtrace() tracks and waits (up to 10 seconds) for
the CPUs to print their backtrace before flushing. Here there is no
waiting. I suppose in practice the NMI backtrace will be fast enough,
but I am just wondering if there should be some sort of tracking/waiting
like in nmi_trigger_cpumask_backtrace().

>  	if (hardlockup_panic)
>  		nmi_panic(NULL, "Hard LOCKUP");
>  
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 85b656f82d75..50424ad87fb5 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -198,6 +198,7 @@ void dump_stack_print_info(const char *log_lvl);
>  void show_regs_print_info(const char *log_lvl);
>  extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
>  extern asmlinkage void dump_stack(void) __cold;
> +void printk_flush(void);
>  #else
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)
> @@ -274,6 +275,9 @@ static inline void dump_stack_lvl(const char *log_lvl)
>  static inline void dump_stack(void)
>  {
>  }
> +static inline void printk_flush(void)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_SMP
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index a8d0a58deebc..dd9471bb58c2 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2206,6 +2206,26 @@ int vprintk_store(int facility, int level,
>  	return ret;
>  }
>  
> +void printk_flush(void)
> +{
> +	/*
> +	 * Disable preemption to avoid being preempted while holding
> +	 * console_sem which would prevent anyone from printing to
> +	 * console
> +	 */
> +	preempt_disable();
> +	/*
> +	 * Try to acquire and then immediately release the console
> +	 * semaphore.  The release will print out buffers and wake up
> +	 * /dev/kmsg and syslog() users.
> +	 */
> +	if (console_trylock_spinning())
> +		console_unlock();
> +	preempt_enable();
> +
> +	wake_up_klogd();
> +}

I have mixed feelings about this printk_flush() because it is exactly
this code that is about to undergo massive reworking. If this function
is accepted, then I wonder if printk_trigger_flush() might be a better
name since it does not necessarily wait until the messages are
printed. (There could be another task printing and already a queued
handover printer. Or this task could handover printing before
finishing.)

John Ogness
