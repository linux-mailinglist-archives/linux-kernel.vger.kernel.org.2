Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2BD43799A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 17:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhJVPIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 11:08:45 -0400
Received: from foss.arm.com ([217.140.110.172]:55510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhJVPIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:08:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2E661FB;
        Fri, 22 Oct 2021 08:06:24 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33DB23F694;
        Fri, 22 Oct 2021 08:06:20 -0700 (PDT)
Date:   Fri, 22 Oct 2021 16:06:17 +0100
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
Subject: Re: [PATCH 15/15] irq: remove handle_domain_{irq,nmi}()
Message-ID: <20211022150617.GC86184@C02TD0UTHF1T.local>
References: <20211021180236.37428-1-mark.rutland@arm.com>
 <20211021180236.37428-16-mark.rutland@arm.com>
 <87o87hbcie.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o87hbcie.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 11:05:29AM +0100, Marc Zyngier wrote:
> On Thu, 21 Oct 2021 19:02:36 +0100,
> Mark Rutland <mark.rutland@arm.com> wrote:
> > 
> > Now that entry code handles IRQ entry (including setting the IRQ regs)
> > before calling irqchip code, irqchip code can safely call
> > generic_handle_domain_irq(), and there's no functional reason for it to
> > call handle_domain_irq().
> > 
> > Let's cement this split of responsibility and remove handle_domain_irq()
> > entirely, updating irqchip drivers to call generic_handle_domain_irq().
> > 
> > For consistency, handle_domain_nmi() is similarly removed and replaced
> > with a generic_handle_domain_nmi() function which also does not perform
> > any entry logic.
> > 
> > Previously handle_domain_{irq,nmi}() had a WARN_ON() which would fire
> > when they were called in an inappropriate context. So that we can
> > identify similar issues going forward, similar WARN_ON_ONCE() logic is
> > added to the generic_handle_*() functions, and comments are updated for
> > clarity and consistency.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> 
> [...]
> 
> > -/**
> > - * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
> > - * @domain:	The domain where to perform the lookup
> > - * @hwirq:	The HW irq number to convert to a logical one
> > - * @regs:	Register file coming from the low-level handling code
> > - *
> > - *		This function must be called from an NMI context.
> >   *
> > - * Returns:	0 on success, or -EINVAL if conversion has failed
> > - */
> > -int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
> > -		      struct pt_regs *regs)
> > + * 		This function must be called from an NMI context with irq regs
> > + * 		initialized.
> > + **/
> > +int generic_handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq)
> >  {
> > -	struct pt_regs *old_regs = set_irq_regs(regs);
> > -	int ret;
> > -
> > -	/*
> > -	 * NMI context needs to be setup earlier in order to deal with tracing.
> > -	 */
> > -	WARN_ON(!in_nmi());
> > -
> > -	ret = generic_handle_domain_irq(domain, hwirq);
> > -
> > -	set_irq_regs(old_regs);
> > -	return ret;
> > +	WARN_ON_ONCE(!in_nmi());
> > +	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
> >  }
> > -#endif
> > +EXPORT_SYMBOL_GPL(generic_handle_domain_nmi);
> 
> nit: we don't need this export (only a root controller can handle
> NMIs), and that's the sort of thing I would really want to avoid
> exposing to modules.

Sure, I'll drop that; I'd only added that for symmetry with
generic_handle_domain_irq(), and I don't need it to be exported.

Thanks,
Mark.
