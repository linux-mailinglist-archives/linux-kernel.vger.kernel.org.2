Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8F41DB86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351505AbhI3NzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:55:01 -0400
Received: from foss.arm.com ([217.140.110.172]:54606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235171AbhI3NzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:55:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03BB1101E;
        Thu, 30 Sep 2021 06:53:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7327D3F70D;
        Thu, 30 Sep 2021 06:53:16 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:53:14 +0100
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
Subject: Re: [PATCHv3 3/3] arm64/entry-common: supplement irq accounting
Message-ID: <20210930135314.GC18258@lakrids.cambridge.arm.com>
References: <20210930131708.35328-1-kernelfans@gmail.com>
 <20210930131708.35328-4-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930131708.35328-4-kernelfans@gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 09:17:08PM +0800, Pingfan Liu wrote:
> At present, the irq entry/exit accounting, which is performed by
> handle_domain_irq(), overlaps with arm64 exception entry code somehow.
> 
> By supplementing irq accounting on arm64 exception entry code, the
> accounting in handle_domain_irq() can be dropped totally by selecting
> the macro HAVE_ARCH_IRQENTRY.

I think we need to be more thorough and explain the specific problem and
solution. How about we crib some wording from patch 1, and say:

  arm64: entry: avoid double-accounting IRQ RCU entry

  When an IRQ is taken, some accounting needs to be performed to enter
  and exit IRQ context around the IRQ handler. On arm64 some of this
  accounting is performed by both the architecture code and the IRQ
  domain code, resulting in calling rcu_irq_enter() twice per exception
  entry, violating the expectations of the core RCU code, and resulting
  in failing to identify quiescent periods correctly (e.g. in
  rcu_is_cpu_rrupt_from_idle()).

  To fix this, we must perform all the accounting from the architecture
  code. We prevent the IRQ domain code from performing any accounting by
  selecting HAVE_ARCH_IRQENTRY, and must call irq_enter_rcu() and
  irq_exit_rcu() around invoking the root IRQ handler.

  When we take a pNMI from a context with IRQs disabled, we'll perform
  the necessary accounting as part of arm64_enter_nmi() and
  arm64_exit_nmi(), and should only call irq_enter_rcu() and
  irq_exit_rcu() when we may have taken a regular interrupt.

That way it's clear what specifically the overlap is and the problem(s)
it results in. The bit at the end explains why we don't call
irq_{enter,exit}_rcu() when we're certain we've taken a pNMI.

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
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
>  arch/arm64/Kconfig               | 1 +
>  arch/arm64/kernel/entry-common.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5c7ae4c3954b..d29bae38a951 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -98,6 +98,7 @@ config ARM64
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARM_AMBA
>  	select ARM_ARCH_TIMER
> +	select HAVE_ARCH_IRQENTRY

Please put this with the other HAVE_ARCH_* entries in
arch/arm64/Kconfig -- it should be between HAVE_ARCH_HUGE_VMAP and
HAVE_ARCH_JUMP_LABEL to keep that in alphabetical order.

With that and the title and commit message above:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  	select ARM_GIC
>  	select AUDIT_ARCH_COMPAT_GENERIC
>  	select ARM_GIC_V2M if PCI
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 5f1473319fb0..6d4dc3b3799f 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -428,7 +428,9 @@ static __always_inline void
>  __el1_interrupt(struct pt_regs *regs, void (*handler)(struct pt_regs *))
>  {
>  	enter_from_kernel_mode(regs);
> +	irq_enter_rcu();
>  	do_interrupt_handler(regs, handler);
> +	irq_exit_rcu();
>  	/*
>  	 * Note: thread_info::preempt_count includes both thread_info::count
>  	 * and thread_info::need_resched, and is not equivalent to
> @@ -667,7 +669,9 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
>  	if (regs->pc & BIT(55))
>  		arm64_apply_bp_hardening();
>  
> +	irq_enter_rcu();
>  	do_interrupt_handler(regs, handler);
> +	irq_exit_rcu();
>  
>  	exit_to_user_mode(regs);
>  }
> -- 
> 2.31.1
> 
