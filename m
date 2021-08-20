Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94193F2D21
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhHTNbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:31:04 -0400
Received: from foss.arm.com ([217.140.110.172]:32862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhHTNbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:31:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5205C11FB;
        Fri, 20 Aug 2021 06:30:25 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B8E43F66F;
        Fri, 20 Aug 2021 06:30:24 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: Fix priority comparison when non-secure
 priorities are used
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210811171505.1502090-1-wenst@chromium.org>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <d279bf85-aeac-1745-9c65-911794343e36@arm.com>
Date:   Fri, 20 Aug 2021 14:31:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210811171505.1502090-1-wenst@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Pending Marc's testing (I realized I don't have any hardware to test this on at
the moment), this patch looks correct to me. One comment below.

On 8/11/21 6:15 PM, Chen-Yu Tsai wrote:
> When non-secure priorities are used, compared to the raw priority set,
> the value read back from RPR is also right-shifted by one and the
> highest bit set.
>
> Add a macro to do the modifications to the raw priority when doing the
> comparison against the RPR value. This corrects the pseudo-NMI behavior
> when non-secure priorities in the GIC are used. Tested on 5.10 with
> the "IPI as pseudo-NMI" series [1] applied on MT8195.
>
> [1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/
>
> Fixes: 336780590990 ("irqchip/gic-v3: Support pseudo-NMIs when SCR_EL3.FIQ == 0")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index e0f4debe64e1..e7a0b55413db 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -100,6 +100,15 @@ EXPORT_SYMBOL(gic_pmr_sync);
>  DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
>  EXPORT_SYMBOL(gic_nonsecure_priorities);
>  
> +#define GICD_INT_RPR_PRI(priority)					\
> +	({								\
> +		u32 __priority = (priority);				\
> +		if (static_branch_unlikely(&gic_nonsecure_priorities))	\
> +			__priority = 0x80 | (__priority >> 1);		\
> +									\
> +		__priority;						\
> +	})

Would you mind adding a comment to the macro explaining why it's needed? This
behaviour is rather subtle and I'm hoping it will save someone's time at some
point in the future. I'm thinking something like this (please ignore it if you can
think of something better):

When the Non-secure world has access to group 0 interrupts (SCR_EL3.FIQ = 0),
reading the ICC_RPR_EL1 register will return the Distributor's view of the
interrupt priority. When GIC security is enabled (GICD_CTLR.DS = 0), the interrupt
priority written by software is moved to the Non-secure range by the Distributor.
If both are true (which is the situation where gic_nonsecure_priorities gets
enabled), then we need to shift down the priority programmed by software if we
want match it against the value returned from ICC_RPR_EL1.

With a comment added:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

> +
>  /* ppi_nmi_refs[n] == number of cpus having ppi[n + 16] set as NMI */
>  static refcount_t *ppi_nmi_refs;
>  
> @@ -687,7 +696,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>  		return;
>  
>  	if (gic_supports_nmi() &&
> -	    unlikely(gic_read_rpr() == GICD_INT_NMI_PRI)) {
> +	    unlikely(gic_read_rpr() == GICD_INT_RPR_PRI(GICD_INT_NMI_PRI))) {
>  		gic_handle_nmi(irqnr, regs);
>  		return;
>  	}
