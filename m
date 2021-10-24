Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54E4389ED
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 17:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbhJXPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 11:40:02 -0400
Received: from elvis.franken.de ([193.175.24.41]:37656 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231779AbhJXPjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 11:39:52 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mefYp-0006bc-06; Sun, 24 Oct 2021 17:37:24 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 083F3C265F; Sun, 24 Oct 2021 17:31:01 +0200 (CEST)
Date:   Sun, 24 Oct 2021 17:31:00 +0200
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
Subject: Re: [PATCH 03/15] irq: mips: simplify do_domain_IRQ()
Message-ID: <20211024153100.GG4721@alpha.franken.de>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021180236.37428-4-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 07:02:24PM +0100, Mark Rutland wrote:
> There's no need fpr arch/mips's do_domain_IRQ() to open-code the NULL
> check performed by handle_irq_desc(), nor the resolution of the desc
> performed by generic_handle_domain_irq().
> 
> Use generic_handle_domain_irq() directly, as this is functioanlly
> equivalent and clearer.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/kernel/irq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> index d20e002b3246..1fee96ef8059 100644
> --- a/arch/mips/kernel/irq.c
> +++ b/arch/mips/kernel/irq.c
> @@ -115,11 +115,7 @@ void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
>  
>  	irq_enter();
>  	check_stack_overflow();
> -
> -	desc = irq_resolve_mapping(domain, hwirq);
> -	if (likely(desc))
> -		handle_irq_desc(desc);
> -
> +	generic_handle_domain_irq(domain, hwirq);
>  	irq_exit();
>  }
>  #endif
> -- 
> 2.11.0

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
