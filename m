Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA84131ECDF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 18:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhBRRH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 12:07:28 -0500
Received: from foss.arm.com ([217.140.110.172]:51682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233751AbhBROW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:22:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28640ED1;
        Thu, 18 Feb 2021 06:22:12 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.48.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8663F73B;
        Thu, 18 Feb 2021 06:22:08 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:22:05 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     Arnd Bergmann <arnd@kernel.org>, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Olof Johansson <olof@lixom.net>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2 08/25] arm64: Always keep DAIF.[IF] in sync
Message-ID: <20210218142205.GB89209@C02TD0UTHF1T.local>
References: <20210215121713.57687-1-marcan@marcan.st>
 <20210215121713.57687-9-marcan@marcan.st>
 <20210217122200.GC5556@C02TD0UTHF1T.local>
 <e88fa913-e2ae-35d0-056f-2a5079babbc2@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e88fa913-e2ae-35d0-056f-2a5079babbc2@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 09:51:40PM +0900, Hector Martin wrote:
> On 17/02/2021 21.22, Mark Rutland wrote:
> > > Root irqchip drivers can discriminate between IRQs and FIQs by checking
> > > the ISR_EL1 system register.
> > 
> > I think we can remove this note for now. If we go with seperate handlers
> > this won't be necessary, and if not this would be better placed on a
> > commit adding the FIQ handling capability.
> 
> Indeed, this doesn't make sense any more. Changed for v3.
> 
> > Judging by `git grep -Wi daif -- arch/arm64`, with this patch applied,
> > we'll also need fixups in:
> > 
> > * gic_arch_enable_irqs() in arch/arm64/include/asm/arch_gicv3.h
> > * save_and_disable_irq() in arch/arm64/include/asm/assembler.h (noted below)
> > * local_daif_save_flags() in arch/arm64/include/asm/daifflags.h
> >    (the fake DAIF should have F set too)
> > * __cpu_do_idle_irqprio() in arch/arm64/kernel/process.c
> 
> Good catches. A few of those are irrelevant for M1 but need to be done now
> that we're making this change globally, others I just missed from the
> beginning.

Sure; my general view is that we should aim for consistency, and should
ensure that DAIF.F==DAIF.I at all times on all platforms unless we have
a strong reason to violate that rule. That generally makes it easier to
reason about the code and avoid accidentally breaking M1/non-M1 if/when
we refactor masking logic.

> There's also an incorrect comment in entry.S:
> 
> 	/*
> 	 * DA_F were cleared at start of handling. If anything is set in
> 	 * DAIF, we come back from an NMI, so skip preemption
> 	 */
> 	mrs	x0, daif
> 	orr	x24, x24, x0
> 
> Now only DA__ are cleared. This actually pairs with gic_arch_enable_irqs()
> and begs the question: in priority masking systems, do we unmask both IRQ
> and FIQ (the gic_arch_enable_irqs change), or do we leave FIQ masked (which
> instead would need an AND in that part of entry.S so as to not consider FIQ
> masked as meaning we're coming back from an NMI)?

I think that for consistency we always want to keep IRQ and FIQ in-sync,
even when using GIC priorities. So when handling a pseudo-NMI we should
unmask DAIF.DA and leave DAIF.IF masked.

> And a minor related one: should init_gic_priority_masking() WARN if FIQ is
> masked too? This probably goes with the above.

I think it should, yes.

> Either way, this was nontrivial to make sense of, so I'll make that entry.S
> comment clearer while I'm touching it.

Sounds good; thanks!

> > I think save_and_diable_irq below needs to be updated too, since it
> > only sets DAIF.I and leaves DAIF.F as-is.
> 
> Totally missed this one! Fixed for v3.
> 
> > > - * FIQ is never expected, but we mask it when we disable debug exceptions, and
> > > - * unmask it at all other times.
> > > + * FIQ is never expected on most platforms, but we keep it synchronized
> > > + * with the IRQ mask status. On platforms that do not expect FIQ, that vector
> > > + * triggers a kernel panic. On platforms that do, the FIQ vector is unified
> > > + * with the IRQ vector.
> > >    */
> > 
> > Can we please delete this bit, though? Now that we say IRQ and FIQ are
> > masked/unmasked together, I don't think the rest is necessary to
> > understand the masking logic, and it's one less thing to keep in sync
> > with changes to the entry code.
> 
> Gone :)

Thanks,
Mark.
