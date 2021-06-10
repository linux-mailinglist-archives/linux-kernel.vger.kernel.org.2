Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8133A2FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhFJQBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:01:40 -0400
Received: from foss.arm.com ([217.140.110.172]:35418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhFJQBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:01:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1ABAED1;
        Thu, 10 Jun 2021 08:59:42 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E6473F719;
        Thu, 10 Jun 2021 08:59:40 -0700 (PDT)
Date:   Thu, 10 Jun 2021 16:59:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        valentin.schneider@arm.com, kernel-team@android.com
Subject: Re: [PATCH] irqchip/gic-v3: Workaround inconsistent PMR setting on
 NMI entry
Message-ID: <20210610155917.GA63335@C02TD0UTHF1T.local>
References: <20210610145731.1350460-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610145731.1350460-1-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Jun 10, 2021 at 03:57:31PM +0100, Marc Zyngier wrote:
> The arm64 entry code suffers from an annoying issue on taking
> a NMI, as it sets PMR to a value that actually allows IRQs
> to be acknowledged. This is done for consistency with other parts
> of the code, and is in the process of being fixed. This shouldn't
> be a problem, as we are not enabling interrupts whilst in NMI
> context.
> 
> However, in the infortunate scenario that we took a spurious NMI
> (retired before the read of IAR) *and* that there is an IRQ pending
> at the same time, we'll ack the IRQ in NMI context. Too bad.
> 
> In order to avoid deadlocks while running something like perf,
> teach the GICv3 driver about this situation: if we were in
> a context where no interrupt should have fired, transiently
> set PMR to a value that only allows NMIs before acking the pending
> interrupt, and restore the original value after that.
> 
> This papers over the core issue for the time being, and makes
> NMIs great again. Sort of.
> 
> Co-developed-by: Mark Rutland <mark.rutland@arm.com>

According to the kernel documentation, a Co-developed-by should be
immediately followed by that developer's Signed-off-by, so FWIW:

Signed-off-by: Mark Rutland <mark.rutland@arm.com>

... unless you want to downgrade that to a Suggested-by, which is also
fine by me!

> Signed-off-by: Marc Zyngier <maz@kernel.org>

Having played about with a few options, I think this is the
simplest/cleanest thing we can do for now, and given it's all in one
place and "obviously correct", I think there's little risk that this
will break something else. So:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

We should probably also give this:

Fixes: 4d6a38da8e79e94c ("arm64: entry: always set GIC_PRIO_PSR_I_SET during entry")

... since prior to that commit the `gic_prio_irq_setup` gunk would
prevent this specific problem (though other bits like
local_daif_{save,restore}()) would be broken in NMI paths.

Thanks,
Mark.

> ---
>  drivers/irqchip/irq-gic-v3.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 37a23aa6de37..3d3502efb807 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -642,11 +642,45 @@ static inline void gic_handle_nmi(u32 irqnr, struct pt_regs *regs)
>  		nmi_exit();
>  }
>  
> +static u32 do_read_iar(struct pt_regs *regs)
> +{
> +	u32 iar;
> +
> +	if (gic_supports_nmi() && unlikely(!interrupts_enabled(regs))) {
> +		u64 pmr;
> +
> +		/*
> +		 * We were in a context with interrupt disabled. However,
> +		 * the entry code has set PMR to a value that allows any
> +		 * interrupt to be acknowledged, and not just NMIs. This can
> +		 * lead to surprising effects if the NMI has been retired in
> +		 * the meantime, and that there is an IRQ pending. The IRQ
> +		 * would then be taken in NMI context, something that nobody
> +		 * wants to debug a second time.
> +		 *
> +		 * Until we sort this, drop PMR again to a level that will
> +		 * actually only allow NMIs before reading IAR, and then
> +		 * restore it to what it was.
> +		 */
> +		pmr = gic_read_pmr();
> +		gic_pmr_mask_irqs();
> +		isb();
> +
> +		iar = gic_read_iar();
> +
> +		gic_write_pmr(pmr);
> +	} else {
> +		iar = gic_read_iar();
> +	}
> +
> +	return iar;
> +}
> +
>  static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
>  {
>  	u32 irqnr;
>  
> -	irqnr = gic_read_iar();
> +	irqnr = do_read_iar(regs);
>  
>  	/* Check for special IDs first */
>  	if ((irqnr >= 1020 && irqnr <= 1023))
> -- 
> 2.30.2
> 
