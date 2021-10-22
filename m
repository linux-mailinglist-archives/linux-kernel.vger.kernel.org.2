Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC2436F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhJVCAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhJVCAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:00:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D341C061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:58:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t21so1670372plr.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8sLhvlh8s15YkZACc0nmuzMn6IO+rS87+1k5lj2Suns=;
        b=Hgxc3vPOclZDyHlAlzsRKPtJU22EzuXMwvdS9C7YN9YUouc7VtBYGNqVuc+4VPYJyc
         6SmyBLvK9dTAmpeRfrmTm4uwyZz8RjxAURXS5MLx7MvwcwcgcgsC5+0NcHDLtkO5j7Bv
         9aCDQzxBwFb3KPhii2zCFzyDtL7IKqpU/crF3Dl0yLysNZTW4DbbAkzM39i1hPlr2bpD
         /PulKpKM3isNDcYPCHl5zXb3yG5APxlT5XVFAm/+l2QdWgxIF/3t3nCeQ+xMmDS6JaSl
         IzOMnNSCf4w0STSAyiKZxb2nQAzz3mlvbYv/kMSvr8Vh+E3G7uiZUHZ1c4FPUCNtSHke
         rTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8sLhvlh8s15YkZACc0nmuzMn6IO+rS87+1k5lj2Suns=;
        b=tDshxJ2hL2jZFvIaw+sYEyiBwm6Jan645rBXqtsNarISX50DyW+yZoYR0byugY+wOH
         gqGh8A4k5PxNUEzr6BaPB4j/iW4TxeKPqbeXefiMZzkv7niPDLSvNwIU/bncbbU17AmF
         e0QfInRUDrF3oOHMDV0+lrRpmRL9j2kpfKYNYv1uSV+MS9iBw0r6fT41hxIaOYxHsZqd
         dydx1QlEWsD9NPk2s8v7tOGERCQ6u33b2tMzAl5QLP35fRPu10cpz8u5nxfRg8JwoxfP
         MNwp5xGbSCDaE0dStG96PgzLry7YTNF3YPC94ItiXsky6fjfGOesz6txjNXnzVgcUdwc
         UgZA==
X-Gm-Message-State: AOAM530qhwLxnbhytspCjAx12ElkuWAk3FsRA5E394EWj0KF7kusqTo9
        5stivHggWWkaB4xVasKiEQ==
X-Google-Smtp-Source: ABdhPJw/E7DfMOPK/LYC3UXmbN65zv8SJaa+sW/X8ya+j/45TA/Jr0IoCQbeldKU0gIYjCHuHUx5mQ==
X-Received: by 2002:a17:902:ea09:b0:13f:ac2:c5ae with SMTP id s9-20020a170902ea0900b0013f0ac2c5aemr8576150plg.3.1634867883725;
        Thu, 21 Oct 2021 18:58:03 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j8sm7068876pfe.105.2021.10.21.18.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 18:58:03 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:57:53 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 10/15] irq: arm64: perform irqentry in entry code
Message-ID: <YXIaoZvk2B/CUok5@piliu.users.ipa.redhat.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-11-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-11-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:31PM +0100, Mark Rutland wrote:
> In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/arm64
> perform all the irqentry accounting in its entry code.
> 
> As arch/arm64 already performs portions of the irqentry logic in
> enter_from_kernel_mode() and exit_to_kernel_mode(), including
> rcu_irq_{enter,exit}(), the only additional calls that need to be made
> are to irq_{enter,exit}_rcu(). Removing the calls to
> rcu_irq_{enter,exit}() from handle_domain_irq() ensures that we inform
> RCU once per IRQ entry and will correctly identify quiescent periods.
> 
> Since we should not call irq_{enter,exit}_rcu() when entering a
> pseudo-NMI, el1_interrupt() is reworked to have separate __el1_irq() and
> __el1_pnmi() paths for regular IRQ and psuedo-NMI entry, with
> irq_{enter,exit}_irq() only called for the former.
> 
> In preparation for removing HANDLE_DOMAIN_IRQ, the irq regs are managed
> in do_interrupt_handler() for both regular IRQ and pseudo-NMI. This is
> currently redundant, but not harmful.
> 
> For clarity the preemption logic is moved into __el1_irq(). We should
> never preempt within a pseudo-NMI, and arm64_enter_nmi() already
> enforces this by incrementing the preempt_count, but it's clearer if we
> never invoke the preemption logic when entering a pseudo-NMI.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/Kconfig               |  1 -
>  arch/arm64/kernel/entry-common.c | 52 ++++++++++++++++++++++++----------------
>  2 files changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 553239a5a5f7..5c7ae4c3954b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -134,7 +134,6 @@ config ARM64
>  	select GENERIC_GETTIMEOFDAY
>  	select GENERIC_VDSO_TIME_NS
>  	select HANDLE_DOMAIN_IRQ
> -	select HANDLE_DOMAIN_IRQ_IRQENTRY
>  	select HARDIRQS_SW_RESEND
>  	select HAVE_MOVE_PMD
>  	select HAVE_MOVE_PUD
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 32f9796c4ffe..f7408edf8571 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -17,6 +17,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/esr.h>
>  #include <asm/exception.h>
> +#include <asm/irq_regs.h>
>  #include <asm/kprobes.h>
>  #include <asm/mmu.h>
>  #include <asm/processor.h>
> @@ -219,22 +220,6 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
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
> @@ -263,10 +248,14 @@ static void __sched arm64_preempt_schedule_irq(void)
>  static void do_interrupt_handler(struct pt_regs *regs,
>  				 void (*handler)(struct pt_regs *))
>  {
> +	struct pt_regs *old_regs = set_irq_regs(regs);
> +
>  	if (on_thread_stack())
>  		call_on_irq_stack(regs, handler);
>  	else
>  		handler(regs);
> +
> +	set_irq_regs(old_regs);
>  }
>  
>  extern void (*handle_arch_irq)(struct pt_regs *);
> @@ -432,13 +421,22 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
>  	}
>  }
>  
> -static void noinstr el1_interrupt(struct pt_regs *regs,
> -				  void (*handler)(struct pt_regs *))
> +static __always_inline void __el1_pnmi(struct pt_regs *regs,
> +				       void (*handler)(struct pt_regs *))
>  {
> -	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> +	arm64_enter_nmi(regs);
> +	do_interrupt_handler(regs, handler);
> +	arm64_exit_nmi(regs);
> +}
> +
> +static __always_inline void __el1_irq(struct pt_regs *regs,
> +				      void (*handler)(struct pt_regs *))
> +{
> +	enter_from_kernel_mode(regs);
>  
> -	enter_el1_irq_or_nmi(regs);
> +	irq_enter_rcu();
>  	do_interrupt_handler(regs, handler);
> +	irq_exit_rcu();
>  
>  	/*
>  	 * Note: thread_info::preempt_count includes both thread_info::count
> @@ -449,7 +447,17 @@ static void noinstr el1_interrupt(struct pt_regs *regs,
>  	    READ_ONCE(current_thread_info()->preempt_count) == 0)
>  		arm64_preempt_schedule_irq();
>  
> -	exit_el1_irq_or_nmi(regs);
> +	exit_to_kernel_mode(regs);
> +}
> +static void noinstr el1_interrupt(struct pt_regs *regs,
> +				  void (*handler)(struct pt_regs *))
> +{
> +	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
> +
> +	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
> +		__el1_pnmi(regs, handler);
> +	else
> +		__el1_irq(regs, handler);
>  }
>  
>  asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
> @@ -667,7 +675,9 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>  	if (regs->pc & BIT(55))
>  		arm64_apply_bp_hardening();
>  
> +	irq_enter_rcu();
>  	do_interrupt_handler(regs, handler);
> +	irq_exit_rcu();
>  
>  	exit_to_user_mode(regs);
>  }

Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
