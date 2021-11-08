Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9585A447E29
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 11:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhKHKnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 05:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhKHKm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:42:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB66C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 02:40:14 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636368013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FW6JswIDu9qA1nuRkk62bEsDXrDikiWc8n7F/BGFqE8=;
        b=0mDUzYRVn4Xk1G+5lUQKnWREAK9xysiSGkWVtXvS5ZScmTlYwMkG8SrUmTJZ66yHNdmK4m
        ooae4Xb132NKAbEXvmF/3lg91dqsQZmDUZNNclid1bAhSblbAc+guh/cqX1/5nenL0WV0d
        kE0g9zU16WqNOq5vVCsQqAG0YoNE1tTt76z5+o2pGC+Ne6ekrzk9rFWobwRuQRgS3ue1oz
        PwTD/fZfYkuAyMcIVKUPsLzslt8wr3OcU6aKUVCGnw821KwIqrkxezlf5XisJ/duVOWvXJ
        Zw2zdbPQQHpTtwd/rH08vAJHAuypU7EqnpbYZOM3oWbq+KE9g/YPhFX7r2pHPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636368013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FW6JswIDu9qA1nuRkk62bEsDXrDikiWc8n7F/BGFqE8=;
        b=9V/RF8VejtlEIocR6Y/sNvVkp70HyEIsgsNB4SBOFU+0KsNg+/qSHRfQCawhKFResG7xP4
        eEsI5hJ0Vc0eRADQ==
To:     Nicholas Piggin <npiggin@gmail.com>, Petr Mladek <pmladek@suse.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: restore flushing of NMI buffers on remote CPUs
 after NMI backtraces
In-Reply-To: <20211107045116.1754411-1-npiggin@gmail.com>
References: <20211107045116.1754411-1-npiggin@gmail.com>
Date:   Mon, 08 Nov 2021 11:46:13 +0106
Message-ID: <87cznbx75e.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-07, Nicholas Piggin <npiggin@gmail.com> wrote:
> printk from NMI context relies on irq work being raised on the local CPU
> to print to console. This can be a problem if the NMI was raised by a
> lockup detector to print lockup stack and regs, because the CPU may not
> enable irqs (because it is locked up).
>
> Introduce printk_trigger_flush() that can be called another CPU to try
> to get those messages to the console, call that where printk_safe_flush
> was previously called.
>
> Fixes: 93d102f094be ("printk: remove safe buffers")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> ---
>  arch/powerpc/kernel/watchdog.c | 6 ++++++
>  include/linux/printk.h         | 4 ++++
>  kernel/printk/printk.c         | 5 +++++
>  lib/nmi_backtrace.c            | 6 ++++++
>  4 files changed, 21 insertions(+)
>
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
> index 5f69ba4de1f3..c8017bc23b00 100644
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
> +	printk_trigger_flush();
> +
>  	if (hardlockup_panic)
>  		nmi_panic(NULL, "Hard LOCKUP");
>  
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 85b656f82d75..9497f6b98339 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -198,6 +198,7 @@ void dump_stack_print_info(const char *log_lvl);
>  void show_regs_print_info(const char *log_lvl);
>  extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
>  extern asmlinkage void dump_stack(void) __cold;
> +void printk_trigger_flush(void);
>  #else
>  static inline __printf(1, 0)
>  int vprintk(const char *s, va_list args)
> @@ -274,6 +275,9 @@ static inline void dump_stack_lvl(const char *log_lvl)
>  static inline void dump_stack(void)
>  {
>  }
> +static inline void printk_trigger_flush(void)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_SMP
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index a8d0a58deebc..99221b016c68 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3252,6 +3252,11 @@ void defer_console_output(void)
>  	preempt_enable();
>  }
>  
> +void printk_trigger_flush(void)
> +{
> +	defer_console_output();
> +}
> +
>  int vprintk_deferred(const char *fmt, va_list args)
>  {
>  	int r;
> diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
> index f9e89001b52e..199ab201d501 100644
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
> +	printk_trigger_flush();
> +
>  	clear_bit_unlock(0, &backtrace_flag);
>  	put_cpu();
>  }
> -- 
> 2.23.0
