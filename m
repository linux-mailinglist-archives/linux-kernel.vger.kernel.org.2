Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFA4466A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbhKEQDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:03:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44892 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbhKEQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:03:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3B2D6217BA;
        Fri,  5 Nov 2021 16:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636128073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOsNns36vf6x5kTkPX74IQMiHYryzGFaw/DBet3wRkc=;
        b=tG6KxdEuDuao4yOMuItqv12SOV7RJedZlwn+lf801BgQnD2Sv9iMfLOC+Upmap/wjbO6ST
        P1TvQKTsyZoZNyLkmxhDlO7C3wHERnN0dQn0yPSsIf+wk8nK+ULTxAvTnasUj9rWgsEBGK
        Ll+OJZJcscoAN1vVhIG4OhTeBwi52cU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1BF312C14A;
        Fri,  5 Nov 2021 16:01:13 +0000 (UTC)
Date:   Fri, 5 Nov 2021 17:01:12 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
Message-ID: <YYVVSMc3pH32twTn@alley>
References: <1636039236.y415994wfa.astroid@bobo.none>
 <87ee7vki7f.fsf@jogness.linutronix.de>
 <1636073838.qpmyp6q17i.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636073838.qpmyp6q17i.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-11-05 11:26:35, Nicholas Piggin wrote:
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
> +
>  asmlinkage int vprintk_emit(int facility, int level,
>  			    const struct dev_printk_info *dev_info,
>  			    const char *fmt, va_list args)
> --- a/lib/nmi_backtrace.c
> +++ b/lib/nmi_backtrace.c
> @@ -75,6 +75,12 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
>  		touch_softlockup_watchdog();
>  	}
>  
> +	/*
> +	 * Force flush any remote buffers that might be stuck in IRQ context
> +	 * and therefore could not run their irq_work.
> +	 */
> +	printk_flush();

IMHO, nmi_trigger_cpumask_backtrace() might be called also from NMI
context.

printk_flush() is not safe in NMI context because console drivers have
their own locks. Even conosle_trylock() takes a lock, see
raw_spin_lock_irqsave(&sem->lock, flags) in down_trylock().

Best Regards,
Petr

> +
>  	clear_bit_unlock(0, &backtrace_flag);
>  	put_cpu();
>  }
