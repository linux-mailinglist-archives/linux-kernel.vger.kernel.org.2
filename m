Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A041DBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351674AbhI3OCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:02:46 -0400
Received: from foss.arm.com ([217.140.110.172]:54706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351650AbhI3OCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:02:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6049101E;
        Thu, 30 Sep 2021 07:01:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30B4B3F70D;
        Thu, 30 Sep 2021 07:01:01 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:00:59 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/3] arm64: entry: refactor EL1 interrupt entry logic
Message-ID: <20210930140058.GD18258@lakrids.cambridge.arm.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
 <20210930131708.35328-3-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930131708.35328-3-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 09:17:07PM +0800, Pingfan Liu wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> Currently we distinguish IRQ and definitely-PNMI at entry/exit time
> via the enter_el1_irq_or_nmi() and enter_el1_irq_or_nmi() helpers. In
> subsequent patches we'll need to handle the two cases more distinctly
> in the body of the exception handler.
> 
> To make this possible, this patch refactors el1_interrupt to be a
> top-level dispatcher to separate handlers for the IRQ and PNMI cases,
> removing the need for the enter_el1_irq_or_nmi() and
> exit_el1_irq_or_nmi() helpers.
> 
> Note that since arm64_enter_nmi() calls __nmi_enter(), which
> increments the preemt_count, we could never preempt when handling a
> PNMI. We now only check for preemption in the IRQ case, which makes
> this clearer.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org

As a heads-up, you need to add your Signed-off-by tag when you post
patches from other people, even if you make no changes. See:

https://www.kernel.org/doc/html/v5.14/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Other than that, this looks fine to me.

Mark.

> ---
>  arch/arm64/kernel/entry-common.c | 44 ++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 32f9796c4ffe..5f1473319fb0 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -219,22 +219,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
> -{
> -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> -		arm64_enter_nmi(regs);
> -	else
> -		enter_from_kernel_mode(regs);
> -}
> -
> -static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
> -{
> -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> -		arm64_exit_nmi(regs);
> -	else
> -		exit_to_kernel_mode(regs);
> -}
> -
>  static void __sched arm64_preempt_schedule_irq(void)
>  {
>  	lockdep_assert_irqs_disabled();
> @@ -432,14 +416,19 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>  	}
>  }
>  
> -static void noinstr el1_interrupt(struct pt_regs *regs,
> -				  void (*handler)(struct pt_regs *))
> +static __always_inline void
> +__el1_pnmi(struct pt_regs *regs, void (*handler)(struct pt_regs *))
>  {
> -	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> -
> -	enter_el1_irq_or_nmi(regs);
> +	arm64_enter_nmi(regs);
>  	do_interrupt_handler(regs, handler);
> +	arm64_exit_nmi(regs);
> +}
>  
> +static __always_inline void
> +__el1_interrupt(struct pt_regs *regs, void (*handler)(struct pt_regs *))
> +{
> +	enter_from_kernel_mode(regs);
> +	do_interrupt_handler(regs, handler);
>  	/*
>  	 * Note: thread_info::preempt_count includes both thread_info::count
>  	 * and thread_info::need_resched, and is not equivalent to
> @@ -448,8 +437,19 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
>  	if (IS_ENABLED(CONFIG_PREEMPTION) &&
>  	    READ_ONCE(current_thread_info()->preempt_count) == 0)
>  		arm64_preempt_schedule_irq();
> +	exit_to_kernel_mode(regs);
> +}
> +
> +static void noinstr el1_interrupt(struct pt_regs *regs,
> +				  void (*handler)(struct pt_regs *))
> +{
> +	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> +
> +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> +		__el1_pnmi(regs, handler);
> +	else
> +		__el1_interrupt(regs, handler);
>  
> -	exit_el1_irq_or_nmi(regs);
>  }
>  
>  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> -- 
> 2.31.1
> 
