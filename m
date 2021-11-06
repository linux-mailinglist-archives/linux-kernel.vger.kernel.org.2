Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C330447052
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 21:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhKFUH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 16:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbhKFUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 16:07:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9CEC061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 13:05:10 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636229107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3LAhmyA9MVbYyu1NRCaNhJnh3QMqcX+oD7lwbOXZlsU=;
        b=ghhQqagYiFDUqbJD8lqxaRKoM4qsqHlKXmLNT6En0dbxkKv6hw8Eyl9JgtC2DWU0NvujeY
        CD2tu4j2Lj0KRhsAlyaB48zW5WNao2RwH2XPryH8sc7Frb+l1FjDIZ2iBNC1Ju/lyqSiRK
        Ug3dZw95cTcV7Zh8V1jBRRm24wKpTyiHQ4NFFygkjYobAZXgRneJiddi7GZFU6VPbk6JTf
        EO/1fOeF9Pu1l+nPS9WYC2niK2YmjZTnU0NDtXlIDGgHrmL7FNH4b/0jcsxBytZpdH6mxB
        Mnhu5/EJZ4EpJ4vz/YEYJU+VQ+8EeeL0hWqVBMjXilUlPEYckB9eabSel4DDvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636229107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3LAhmyA9MVbYyu1NRCaNhJnh3QMqcX+oD7lwbOXZlsU=;
        b=oQ2NOu/DqeEw4gtqWZRpr3ngzE8Q218vI5qxYFJWYLra0/+ysBnw3R9aLzLDy18Rq0uos3
        pSV5l0Dlwatrs4CA==
To:     Nicholas Piggin <npiggin@gmail.com>, Petr Mladek <pmladek@suse.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Removal of printk safe buffers delays NMI context printk
In-Reply-To: <1636158295.cxlln6r0kk.astroid@bobo.none>
References: <1636039236.y415994wfa.astroid@bobo.none>
 <87ee7vki7f.fsf@jogness.linutronix.de>
 <1636073838.qpmyp6q17i.astroid@bobo.none>
 <87r1bv2aga.fsf@jogness.linutronix.de>
 <1636111599.wwppq55w4t.astroid@bobo.none>
 <87h7cqg0xk.fsf@jogness.linutronix.de> <YYVakNdzjrYuBmhf@alley>
 <87lf22eem7.fsf@jogness.linutronix.de>
 <1636158295.cxlln6r0kk.astroid@bobo.none>
Date:   Sat, 06 Nov 2021 21:11:07 +0106
Message-ID: <871r3tqccs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-06, Nicholas Piggin <npiggin@gmail.com> wrote:
> This patch seems to work, I can submit it if you'd like?

It looks good to me. Thanks for identifying and fixing this regression.

John Ogness

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
