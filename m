Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7CE34E60E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhC3LGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:06:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbhC3LFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:05:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DD921FB;
        Tue, 30 Mar 2021 04:05:52 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 817723F694;
        Tue, 30 Mar 2021 04:05:51 -0700 (PDT)
Date:   Tue, 30 Mar 2021 12:05:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, lecopzer@gmail.com, yj.chiang@mediatek.com,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH] irqchip/gic-v3: Fix IPRIORITYR can't perform byte
 operations in GIC-600
Message-ID: <20210330110546.GA24881@lpieralisi>
References: <20210330100619.24747-1-lecopzer.chen@mediatek.com>
 <87o8f1q6c6.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8f1q6c6.wl-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 11:33:13AM +0100, Marc Zyngier wrote:
> [+Lorenzo, +Julien on an actual email address]
> 
> On Tue, 30 Mar 2021 11:06:19 +0100,
> Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
> > 
> > When pseudo-NMI enabled, register_nmi() set priority of specific IRQ
> > by byte ops, and this doesn't work in GIC-600.
> > 
> > We have asked ARM Support [1]:
> > > Please refer to following description in
> > > "2.1.2 Distributor ACE-Lite slave interface" of GIC-600 TRM for
> > > the GIC600 ACE-lite slave interface supported sizes:
> > >   "The GIC-600 only accepts single beat accesses of the sizes for
> > >   each register that are shown in the Programmers model,
> > >   see Chapter 4 Programmer's model on page 4-102.
> > >   All other accesses are rejected and given either an
> > >   OKAY or SLVERR response that is based on the GICT_ERR0CTLR.UE bit.".
> > 
> > Thus the register needs to be written by double word operation and
> > the step will be: read 32bit, set byte and write it back.
> > 
> > [1] https://services.arm.com/support/s/case/5003t00001L4Pba
> 
> You do realise that this link:
> 
> - is unusable for most people as it is behind a registration interface
> - discloses confidential information to other people
> 
> I strongly suggest you stop posting such links.
> 
> > 
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  drivers/irqchip/irq-gic-v3.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index eb0ee356a629..cfc5a6ad30dc 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -440,10 +440,21 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
> >  {
> >  	void __iomem *base = gic_dist_base(d);
> >  	u32 offset, index;
> > +	u32 val, prio_offset_mask, prio_offset_shift;
> >  
> >  	offset = convert_offset_index(d, GICD_IPRIORITYR, &index);
> >  
> > -	writeb_relaxed(prio, base + offset + index);
> > +	/*
> > +	 * GIC-600 memory mapping register doesn't support byte opteration,
> > +	 * thus read 32-bits from register, set bytes and wtire back to it.
> > +	 */
> > +	prio_offset_shift = (index & 0x3) * 8;
> > +	prio_offset_mask = GENMASK(prio_offset_shift + 7, prio_offset_shift);
> > +	index &= ~0x3;
> > +	val = readl_relaxed(base + offset + index);
> > +	val &= ~prio_offset_mask;
> > +	val |= prio << prio_offset_shift;
> > +	writel_relaxed(val, base + offset + index);
> >  }
> >  
> >  static u32 gic_get_ppi_index(struct irq_data *d)
> 
> From the architecture spec:
> 
> <quote>
> 11.1.3 GIC memory-mapped register access
> 
> In any system, access to the following registers must be supported:
> 
> [...]
> * Byte accesses to:
> 	- GICD_IPRIORITYR<n>.
> 	- GICD_ITARGETSR<n>.
> 	- GICD_SPENDSGIR<n>.
> 	- GICD_CPENDSGIR<n>.
> 	- GICR_IPRIORITYR<n>.
> </quote>
> 
> So if GIC600 doesn't follow this architectural requirement, this is a
> HW erratum, and I want an actual description of the HW issue together
> with an erratum number.
> 
> Lorenzo, can you please investigate on your side?

Sure - I will look into it and report back.

Thanks,
Lorenzo
