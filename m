Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105E8437995
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhJVPH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:07:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233069AbhJVPHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:07:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A3F31FB;
        Fri, 22 Oct 2021 08:05:37 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB3533F694;
        Fri, 22 Oct 2021 08:05:32 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:05:24 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nickhu@andestech.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tglx@linutronix.de,
        torvalds@linux-foundation.org, tsbogend@alpha.franken.de,
        vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 01/15] irq: mips: avoid nested irq_enter()
Message-ID: <20211022150524.GA86184@C02TD0UTHF1T.local>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-2-mark.rutland@arm.com>
 <87mtn1bazk.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtn1bazk.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:38:23AM +0100, Marc Zyngier wrote:
> On Thu, 21 Oct 2021 19:02:22 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > As bcm6345_l1_irq_handle() is a chained irqchip handler, it will be
> > invoked within the context of the root irqchip handler, which must have
> > entered IRQ context already.
> > 
> > When bcm6345_l1_irq_handle() calls arch/mips's do_IRQ() , this will nest
> > another call to irq_enter(), and the resulting nested increment to
> > `rcu_data.dynticks_nmi_nesting` will cause rcu_is_cpu_rrupt_from_idle()
> > to fail to identify wakeups from idle, resulting in failure to preempt,
> > and RCU stalls.
> > 
> > Chained irqchip handlers must invoke IRQ handlers by way of thee core
> > irqchip code, i.e. generic_handle_irq() or generic_handle_domain_irq()
> > and should not call do_IRQ(), which is intended only for root irqchip
> > handlers.
> > 
> > Fix bcm6345_l1_irq_handle() by calling generic_handle_irq() directly.
> > 
> > Fixes: c7c42ec2baa1de7a ("irqchips/bmips: Add bcm6345-l1 interrupt controller")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  drivers/irqchip/irq-bcm6345-l1.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
> > index e3483789f4df..1bd0621c4ce2 100644
> > --- a/drivers/irqchip/irq-bcm6345-l1.c
> > +++ b/drivers/irqchip/irq-bcm6345-l1.c
> > @@ -140,7 +140,7 @@ static void bcm6345_l1_irq_handle(struct irq_desc *desc)
> >  		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
> >  			irq = irq_linear_revmap(intc->domain, base + hwirq);
> >  			if (irq)
> > -				do_IRQ(irq);
> > +				generic_handle_irq(irq);
> >  			else
> >  				spurious_interrupt();
> >  		}
> 
> A marginally better fix would be to have:
> 
> diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
> index 1bd0621c4ce2..fd079215c17f 100644
> --- a/drivers/irqchip/irq-bcm6345-l1.c
> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> @@ -132,16 +132,12 @@ static void bcm6345_l1_irq_handle(struct irq_desc *desc)
>  		int base = idx * IRQS_PER_WORD;
>  		unsigned long pending;
>  		irq_hw_number_t hwirq;
> -		unsigned int irq;
>  
>  		pending = __raw_readl(cpu->map_base + reg_status(intc, idx));
>  		pending &= __raw_readl(cpu->map_base + reg_enable(intc, idx));
>  
>  		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
> -			irq = irq_linear_revmap(intc->domain, base + hwirq);
> -			if (irq)
> -				generic_handle_irq(irq);
> -			else
> +			if (generic_handle_domain_irq(intc->domain, base + hwirq))
>  				spurious_interrupt();
>  		}
>  	}
> 
> but we can also tackle that separately if you'd rather keep the change
> minimal.

I'll add that to the series immediately after this patch, to keep this
change minimal for backporting.

Thanks,
Mark.
