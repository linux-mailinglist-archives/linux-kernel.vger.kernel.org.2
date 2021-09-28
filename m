Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5802441AB42
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 10:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbhI1I4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 04:56:46 -0400
Received: from foss.arm.com ([217.140.110.172]:42868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239712AbhI1I4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 04:56:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D28C46D;
        Tue, 28 Sep 2021 01:55:05 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5487A3F7B4;
        Tue, 28 Sep 2021 01:55:03 -0700 (PDT)
Date:   Tue, 28 Sep 2021 09:55:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Yuichi Ito <ito-yuichi@fujitsu.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv2 3/5] kernel/irq: make irq_{enter,exit}() in
 handle_domain_irq() arch optional
Message-ID: <20210928085500.GC1924@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-4-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924132837.45994-4-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:28:35PM +0800, Pingfan Liu wrote:
> handle_domain_irq() contains two major parts:
>   -1. irq_enter()/irq_exit(), which serves as hooks for rcu and trace etc.
>   -2. irq mapping and dispatching
> 
> After the introduction of irqentry_enter()/irqentry_exit() and arch
> specific counterpart (e.g. arm64), roughly speaking, rcu_irq_enter() has
> already been called.  Hence here comes requirement to move
> irq_enter/irq_exit out of handle_domain_irq(). And arches should handle
> about irq_enter_rcu()/irq_exit_rcu() by themself.
> 
> Since there is still arches, which does not adopt irqentry_enter(), let
> irq_enter()/irq_exit() arch optional in handle_domain_irq().

The patch below looks good to me, but the commit message is a little
hard to follow. How about:

  When an IRQ is taken, some accounting needs to be performed to enter
  and exit IRQ context around the IRQ handler. Historically arch code
  would leave this to the irqchip or core IRQ code, but these days we
  want this to happen in exception entry code, and architectures such as
  arm64 do this.

  Currently handle_domain_irq() performs this entry/exit accounting, and
  if used on an architecture where the entry code also does this, the
  entry/exit accounting will be performed twice per IRQ. This is
  problematic as core RCU code such as rcu_is_cpu_rrupt_from_idle()
  depends on this happening once per IRQ, and will not detect quescent
  periods correctly, leading to stall warnings.

  As irqchip drivers which use handle_domain_irq() need to work on
  architectures with or without their own entry/exit accounting, this
  patch makes handle_domain_irq() conditionally perform the entry
  accounting depending on a new HAVE_ARCH_IRQENTRY Kconfig symbol that
  architectures can select if they perform this entry accounting
  themselves.

  For architectures which do not select the symbol. there should be no
  functional change as a result of this patch.

With that commit message:

  Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Julien Thierry <julien.thierry@arm.com>
> Cc: Yuichi Ito <ito-yuichi@fujitsu.com>
> Cc: linux-arm-kernel@lists.infradead.org
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/irq/Kconfig   | 3 +++
>  kernel/irq/irqdesc.c | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
> index fbc54c2a7f23..defa1db2d664 100644
> --- a/kernel/irq/Kconfig
> +++ b/kernel/irq/Kconfig
> @@ -100,6 +100,9 @@ config IRQ_MSI_IOMMU
>  config HANDLE_DOMAIN_IRQ
>  	bool
>  
> +config HAVE_ARCH_IRQENTRY
> +	bool
> +
>  config IRQ_TIMINGS
>  	bool
>  
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 4e3c29bb603c..fd5dd9d278b5 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -693,7 +693,9 @@ int handle_domain_irq(struct irq_domain *domain,
>  	struct irq_desc *desc;
>  	int ret = 0;
>  
> +#ifndef CONFIG_HAVE_ARCH_IRQENTRY
>  	irq_enter();
> +#endif
>  
>  	/* The irqdomain code provides boundary checks */
>  	desc = irq_resolve_mapping(domain, hwirq);
> @@ -702,7 +704,9 @@ int handle_domain_irq(struct irq_domain *domain,
>  	else
>  		ret = -EINVAL;
>  
> +#ifndef CONFIG_HAVE_ARCH_IRQENTRY
>  	irq_exit();
> +#endif
>  	set_irq_regs(old_regs);
>  	return ret;
>  }
> -- 
> 2.31.1
> 
