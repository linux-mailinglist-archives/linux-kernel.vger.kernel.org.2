Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1855641AB8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbhI1JMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:12:40 -0400
Received: from foss.arm.com ([217.140.110.172]:43976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239811AbhI1JMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:12:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2A196D;
        Tue, 28 Sep 2021 02:10:59 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0906F3F7B4;
        Tue, 28 Sep 2021 02:10:56 -0700 (PDT)
Date:   Tue, 28 Sep 2021 10:10:53 +0100
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
Subject: Re: [PATCHv2 4/5] irqchip/GICv3: let gic_handle_irq() utilize
 irqentry on arm64
Message-ID: <20210928091053.GD1924@C02TD0UTHF1T.local>
References: <20210924132837.45994-1-kernelfans@gmail.com>
 <20210924132837.45994-5-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924132837.45994-5-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 09:28:36PM +0800, Pingfan Liu wrote:
> The call to rcu_irq_enter() originated from gic_handle_irq() is
> redundant now, since arm64 has enter_from_kernel_mode() akin to
> irqenter_entry(), which has already called rcu_irq_enter().

Here I think you're referring to the call in handle_domain_irq(), but
that isn't clear from the commit message.

> Based on code analysis, the redundant can raise some mistake, e.g.
> rcu_data->dynticks_nmi_nesting inc 2, which causes
> rcu_is_cpu_rrupt_from_idle() unexpected.
> 
> So eliminate the call to irq_enter() in handle_domain_irq(). And
> accordingly supplementing irq_enter_rcu().

We support many more irqchips on arm64, and GICv3 can be used on regular
32-bit arm, so this isn't right. Moving the irq_enter_rcu() call
into the GICv3 driver specifically breaks other drivers on arm64 by
removing the call, and breaks the GICv3 driver on arm by adding a
duplicate call.

It looks like this should live in do_interrupt_handler() in
arch/arm64/kernel/entry-common.c, e.g.

| static void do_interrupt_handler(struct pt_regs *regs,
| 				 void (*handler)(struct pt_regs *)) 
| {
| 	irq_enter_rcu();
| 	if (on_thread_stack())
| 		call_on_irq_stack(regs, handler);
| 	else
| 		handler(regs);
| 	irq_exit_rcu();
| }

... unless there's some problem with that?

Thanks,
Mark.

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
>  arch/arm64/Kconfig           | 1 +
>  drivers/irqchip/irq-gic-v3.c | 2 ++
>  2 files changed, 3 insertions(+)
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
>  	select ARM_GIC
>  	select AUDIT_ARCH_COMPAT_GENERIC
>  	select ARM_GIC_V2M if PCI
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 89dcec902a82..906538fa8771 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -729,10 +729,12 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  	else
>  		isb();
>  
> +	irq_enter_rcu();
>  	if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
>  		WARN_ONCE(true, "Unexpected interrupt received!\n");
>  		gic_deactivate_unhandled(irqnr);
>  	}
> +	irq_exit_rcu();
>  }
>  
>  static u32 gic_get_pribits(void)
> -- 
> 2.31.1
> 
