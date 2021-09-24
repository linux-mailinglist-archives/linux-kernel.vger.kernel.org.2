Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13650417A27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbhIXRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:54:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344909AbhIXRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:54:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D957ED6E;
        Fri, 24 Sep 2021 10:53:11 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.20.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833943F719;
        Fri, 24 Sep 2021 10:53:09 -0700 (PDT)
Date:   Fri, 24 Sep 2021 18:53:06 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/5] arm64/entry-common: push the judgement of nmi ahead
Message-ID: <20210924175306.GB42068@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-2-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924132837.45994-2-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:28:33PM +0800, Pingfan Liu wrote:
> In enter_el1_irq_or_nmi(), it can be the case which NMI interrupts an
> irq, which makes the condition !interrupts_enabled(regs) fail to detect
> the NMI. This will cause a mistaken account for irq.

Can you please explain this in more detail? It's not clear which
specific case you mean when you say "NMI interrupts an irq", as that
could mean a number of distinct scenarios.

AFAICT, if we're in an IRQ handler (with NMIs unmasked), and an NMI
causes a new exception we'll do the right thing. So either I'm missing a
subtlety or you're describing a different scenario..

Note that the entry code is only trying to distinguish between:

a) This exception is *definitely* an NMI (because regular interrupts
   were masked).

b) This exception is *either* and IRQ or an NMI (and this *cannot* be
   distinguished until we acknowledge the interrupt), so we treat it as
   an IRQ for now.

... and we leave it to the irqchip to handle the gory details. We only
need to distinguish (a) early to avoid nesting IRQ logic within itself
in an unsafe way.

Thanks,
Mark.

> Introducing two interfaces: handle_arch_nmi and interrupt_is_nmi to
> judge NMI at this stage.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/irq.h     |  5 ++++
>  arch/arm64/kernel/entry-common.c | 45 ++++++++++++++++++++++----------
>  arch/arm64/kernel/irq.c          | 29 ++++++++++++++++++++
>  3 files changed, 65 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index fac08e18bcd5..a59b1745f458 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -12,6 +12,11 @@ int set_handle_irq(void (*handle_irq)(struct pt_regs *));
>  #define set_handle_irq	set_handle_irq
>  int set_handle_fiq(void (*handle_fiq)(struct pt_regs *));
>  
> +extern void (*handle_arch_irq)(struct pt_regs *regs);
> +extern void (*handle_arch_fiq)(struct pt_regs *regs);
> +extern void (*handle_arch_nmi)(struct pt_regs *regs);
> +extern bool (*interrupt_is_nmi)(void);
> +
>  static inline int nr_legacy_irqs(void)
>  {
>  	return 0;
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 32f9796c4ffe..69a8cc082712 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -24,6 +24,7 @@
>  #include <asm/stacktrace.h>
>  #include <asm/sysreg.h>
>  #include <asm/system_misc.h>
> +#include <asm/irq.h>
>  
>  /*
>   * Handle IRQ/context state management when entering from kernel mode.
> @@ -219,17 +220,28 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  		lockdep_hardirqs_on(CALLER_ADDR0);
>  }
>  
> -static void noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
> +static inline bool arm64_in_nmi(struct pt_regs *regs)
>  {
> -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> +	if (!interrupts_enabled(regs) || (*interrupt_is_nmi)())
> +		return true;
> +	return false;
> +}
> +
> +/* return true if in irq, otherwise in nmi */
> +static bool noinstr enter_el1_irq_or_nmi(struct pt_regs *regs)
> +{
> +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && arm64_in_nmi(regs)) {
>  		arm64_enter_nmi(regs);
> -	else
> +		return false;
> +	} else {
>  		enter_from_kernel_mode(regs);
> +		return true;
> +	}
>  }
>  
> -static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs)
> +static void noinstr exit_el1_irq_or_nmi(struct pt_regs *regs, bool in_irq)
>  {
> -	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !in_irq)
>  		arm64_exit_nmi(regs);
>  	else
>  		exit_to_kernel_mode(regs);
> @@ -269,9 +281,6 @@ static void do_interrupt_handler(struct pt_regs *regs,
>  		handler(regs);
>  }
>  
> -extern void (*handle_arch_irq)(struct pt_regs *);
> -extern void (*handle_arch_fiq)(struct pt_regs *);
> -
>  static void noinstr __panic_unhandled(struct pt_regs *regs, const char *vector,
>  				      unsigned int esr)
>  {
> @@ -433,12 +442,20 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>  }
>  
>  static void noinstr el1_interrupt(struct pt_regs *regs,
> -				  void (*handler)(struct pt_regs *))
> +				  void (*handler)(struct pt_regs *),
> +				  void (*nmi_handler)(struct pt_regs *))
>  {
> +	bool in_irq;
> +	void (*h)(struct pt_regs *regs);
> +
>  	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
>  
> -	enter_el1_irq_or_nmi(regs);
> -	do_interrupt_handler(regs, handler);
> +	in_irq = enter_el1_irq_or_nmi(regs);
> +	if (in_irq)
> +		h = handler;
> +	else
> +		h = nmi_handler;
> +	do_interrupt_handler(regs, h);
>  
>  	/*
>  	 * Note: thread_info::preempt_count includes both thread_info::count
> @@ -449,17 +466,17 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
>  	    READ_ONCE(current_thread_info()->preempt_count) == 0)
>  		arm64_preempt_schedule_irq();
>  
> -	exit_el1_irq_or_nmi(regs);
> +	exit_el1_irq_or_nmi(regs, in_irq);
>  }
>  
>  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
>  {
> -	el1_interrupt(regs, handle_arch_irq);
> +	el1_interrupt(regs, handle_arch_irq, handle_arch_nmi);
>  }
>  
>  asmlinkage void noinstr el1h_64_fiq_handler(struct pt_regs *regs)
>  {
> -	el1_interrupt(regs, handle_arch_fiq);
> +	el1_interrupt(regs, handle_arch_fiq, handle_arch_nmi);
>  }
>  
>  asmlinkage void noinstr el1h_64_error_handler(struct pt_regs *regs)
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index bda49430c9ea..e67435eb4cba 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -81,8 +81,19 @@ static void default_handle_fiq(struct pt_regs *regs)
>  	panic("FIQ taken without a root FIQ handler\n");
>  }
>  
> +static void default_handle_nmi(struct pt_regs *unused)
> +{
> +}
> +
> +static bool default_nmi_discriminator(void)
> +{
> +	return false;
> +}
> +
>  void (*handle_arch_irq)(struct pt_regs *) __ro_after_init = default_handle_irq;
>  void (*handle_arch_fiq)(struct pt_regs *) __ro_after_init = default_handle_fiq;
> +void (*handle_arch_nmi)(struct pt_regs *) __ro_after_init = default_handle_nmi;
> +bool (*interrupt_is_nmi)(void) __ro_after_init = default_nmi_discriminator;
>  
>  int __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  {
> @@ -104,6 +115,24 @@ int __init set_handle_fiq(void (*handle_fiq)(struct pt_regs *))
>  	return 0;
>  }
>  
> +int __init set_handle_nmi(void (*handle_nmi)(struct pt_regs *))
> +{
> +	if (handle_arch_nmi != default_handle_nmi)
> +		return -EBUSY;
> +
> +	handle_arch_nmi = handle_nmi;
> +	return 0;
> +}
> +
> +int __init set_nmi_discriminator(bool (*discriminator)(void))
> +{
> +	if (interrupt_is_nmi != default_nmi_discriminator)
> +		return -EBUSY;
> +
> +	interrupt_is_nmi = discriminator;
> +	return 0;
> +}
> +
>  void __init init_IRQ(void)
>  {
>  	init_irq_stacks();
> -- 
> 2.31.1
> 
