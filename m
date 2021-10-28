Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5052D43E6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJ1ROb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:14:31 -0400
Received: from foss.arm.com ([217.140.110.172]:57424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhJ1ROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:14:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0B31063;
        Thu, 28 Oct 2021 10:12:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7F43F70D;
        Thu, 28 Oct 2021 10:12:00 -0700 (PDT)
Date:   Thu, 28 Oct 2021 18:11:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        catalin.marinas@arm.com, deanbo422@gmail.com, green.hu@gmail.com,
        guoren@kernel.org, jonas@southpole.se, kernelfans@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        maz@kernel.org, nickhu@andestech.com, palmer@dabbelt.com,
        paulmck@kernel.org, paul.walmsley@sifive.com, peterz@infradead.org,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        tsbogend@alpha.franken.de, vgupta@kernel.org, will@kernel.org
Subject: Re: [PATCH 03/15] irq: mips: simplify do_domain_IRQ()
Message-ID: <20211028171153.GA42845@lakrids.cambridge.arm.com>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-4-mark.rutland@arm.com>
 <20211028170732.GA507928@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028170732.GA507928@roeck-us.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:07:32AM -0700, Guenter Roeck wrote:
> On Thu, Oct 21, 2021 at 07:02:24PM +0100, Mark Rutland wrote:
> > There's no need fpr arch/mips's do_domain_IRQ() to open-code the NULL
> > check performed by handle_irq_desc(), nor the resolution of the desc
> > performed by generic_handle_domain_irq().
> > 
> > Use generic_handle_domain_irq() directly, as this is functioanlly
> > equivalent and clearer.
> > 
> > There should be no functional change as a result of this patch.
> > 
> 
> Except for this compile error:
> 
> arch/mips/kernel/irq.c: In function 'do_domain_IRQ':
> arch/mips/kernel/irq.c:114:26: error: unused variable 'desc' [-Werror=unused-variable]
>   114 |         struct irq_desc *desc;
> 
> Guenter

Sorry for that; this has been fixed by:

  https://lore.kernel.org/r/20211028095652.3503790-1-siyanteng@loongson.cn

... which is queued up:

  https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/remove-handle-domain-irq-20211026&id=34fca8947b2743e6a3a9a8a3a44962e625993533


Thanks,
Mark.

> 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/mips/kernel/irq.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
> > index d20e002b3246..1fee96ef8059 100644
> > --- a/arch/mips/kernel/irq.c
> > +++ b/arch/mips/kernel/irq.c
> > @@ -115,11 +115,7 @@ void __irq_entry do_domain_IRQ(struct irq_domain *domain, unsigned int hwirq)
> >  
> >  	irq_enter();
> >  	check_stack_overflow();
> > -
> > -	desc = irq_resolve_mapping(domain, hwirq);
> > -	if (likely(desc))
> > -		handle_irq_desc(desc);
> > -
> > +	generic_handle_domain_irq(domain, hwirq);
> >  	irq_exit();
> >  }
> >  #endif
> > -- 
> > 2.11.0
> > 
