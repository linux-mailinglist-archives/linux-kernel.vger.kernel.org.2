Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D34389EE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhJXPkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:40:04 -0400
Received: from elvis.franken.de ([193.175.24.41]:37657 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231548AbhJXPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:39:52 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mefYq-0006bc-00; Sun, 24 Oct 2021 17:37:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 76899C265F; Sun, 24 Oct 2021 17:31:57 +0200 (CEST)
Date:   Sun, 24 Oct 2021 17:31:57 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 01/15] irq: mips: avoid nested irq_enter()
Message-ID: <20211024153157.GH4721@alpha.franken.de>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-2-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-2-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:22PM +0100, Mark Rutland wrote:
> As bcm6345_l1_irq_handle() is a chained irqchip handler, it will be
> invoked within the context of the root irqchip handler, which must have
> entered IRQ context already.
> 
> When bcm6345_l1_irq_handle() calls arch/mips's do_IRQ() , this will nest
> another call to irq_enter(), and the resulting nested increment to
> `rcu_data.dynticks_nmi_nesting` will cause rcu_is_cpu_rrupt_from_idle()
> to fail to identify wakeups from idle, resulting in failure to preempt,
> and RCU stalls.
> 
> Chained irqchip handlers must invoke IRQ handlers by way of thee core
> irqchip code, i.e. generic_handle_irq() or generic_handle_domain_irq()
> and should not call do_IRQ(), which is intended only for root irqchip
> handlers.
> 
> Fix bcm6345_l1_irq_handle() by calling generic_handle_irq() directly.
> 
> Fixes: c7c42ec2baa1de7a ("irqchips/bmips: Add bcm6345-l1 interrupt controller")
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/irqchip/irq-bcm6345-l1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
> index e3483789f4df..1bd0621c4ce2 100644
> --- a/drivers/irqchip/irq-bcm6345-l1.c
> +++ b/drivers/irqchip/irq-bcm6345-l1.c
> @@ -140,7 +140,7 @@ static void bcm6345_l1_irq_handle(struct irq_desc *desc)
>  		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD) {
>  			irq = irq_linear_revmap(intc->domain, base + hwirq);
>  			if (irq)
> -				do_IRQ(irq);
> +				generic_handle_irq(irq);
>  			else
>  				spurious_interrupt();
>  		}
> -- 
> 2.11.0

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
