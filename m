Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2293801A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 03:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhENB7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 21:59:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:51130 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhENB7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 21:59:47 -0400
IronPort-SDR: e2Yve/ImpJcT490UpnjJjOEJ9LhRAQRCgqDvq6ZSaECZzOsog/2xisLKVIJ124MPKwSob3DGf9
 WnAlKY4NIGZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187508836"
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="187508836"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 18:58:36 -0700
IronPort-SDR: +amoTEPJ69s2snxXyepxyCLQnvPHdTfZvsiiAzENGm61CmMEfiE/iA+ao/iY6V2jQSL9c9udYg
 ntF1SY2zFM6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,298,1613462400"; 
   d="scan'208";a="538631277"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2021 18:58:35 -0700
Date:   Thu, 13 May 2021 18:57:48 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "woodhouse, Jacob Pan" <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH v5 5/7] iommu/vt-d: Fixup delivery mode of the HPET
 hardlockup interrupt
Message-ID: <20210514015748.GA8236@ranerica-svr.sc.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com>
 <20210504191049.22661-6-ricardo.neri-calderon@linux.intel.com>
 <87lf8uhzk9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf8uhzk9.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 01:03:18AM +0200, Thomas Gleixner wrote:
> On Tue, May 04 2021 at 12:10, Ricardo Neri wrote:

Thank you very much for your feedback, Thomas. I am sorry it took me a
while to reply to your email. I needed to digest and research your
comments.

> > In x86 there is not an IRQF_NMI flag that can be used to indicate the
> 
> There exists no IRQF_NMI flag at all. No architecture provides that.

Thank you for the clarification. I think I meant to say that there is a
request_nmi() function but AFAIK it is only used in the ARM PMU and
would not work on x86.

> 
> > delivery mode when requesting an interrupt (via request_irq()). Thus,
> > there is no way for the interrupt remapping driver to know and set
> > the delivery mode.
> 
> There is no support for this today. So what?

Using request_irq() plus a HPET quirk looked to me a reasonable
way to use the irqdomain hierarchy to allocate an interrupt with NMI as
the delivery mode.

> 
> > Hence, when allocating an interrupt, check if such interrupt belongs to
> > the HPET hardlockup detector and fixup the delivery mode accordingly.
> 
> What?
> 
> > +		/*
> > +		 * If we find the HPET hardlockup detector irq, fixup the
> > +		 * delivery mode.
> > +		 */
> > +		if (is_hpet_irq_hardlockup_detector(info))
> > +			irq_cfg->delivery_mode = APIC_DELIVERY_MODE_NMI;
> 
> Again. We are not sticking some random device checks into that
> code. It's wrong and I explained it to you before.
> 
>   https://lore.kernel.org/lkml/alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de/
> 
> But I'm happy to repeat it again:
> 
>   "No. This is horrible hackery violating all the layering which we carefully
>    put into place to avoid exactly this kind of sprinkling conditionals into
>    all code pathes.
> 
>    With some thought the existing irqdomain hierarchy can be used to achieve
>    the same thing without tons of extra functions and conditionals."
> 
> So the outcome of thought and using the irqdomain hierarchy is:
> 
>    Replacing an hpet specific conditional in one place with an hpet
>    specific conditional in a different place.
> 
> Impressive.

I am sorry Thomas, I did try to make the quirk less hacky but I did not
think of the solution you provide below.

> 
> hpet_assign_irq(...., bool nmi)
>   init_info(info)
>     ...
>     if (nmi)
>         info.flags |= X86_IRQ_ALLOC_AS_NMI;
>   
>    irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info)
>      intel_irq_remapping_alloc(..., info)
>        irq_domain_alloc_irq_parents(..., info)
>          x86_vector_alloc_irqs(..., info)
>          {   
>            if (info->flags & X86_IRQ_ALLOC_AS_NMI && nr_irqs != 1)
>                   return -EINVAL;
> 
>            for (i = 0; i < nr_irqs; i++) {
>              ....
>              if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
>                  irq_cfg_setup_nmi(apicd);
>                  continue;
>              }
>              ...
>          }
> 
> irq_cfg_setup_nmi() sets irq_cfg->delivery_mode and whatever is required
> and everything else just works. Of course this needs a few other minor
> tweaks but none of those introduces random hpet quirks all over the
> place. Not convoluted enough, right?

Thanks for the detailed demonstration! It does seem cleaner than what I
implemented.

> 
> But that solves none of other problems. Let me summarize again which
> options or non-options we have:
> 
>     1) Selective IPIs from NMI context cannot work
> 
>        As explained in the other thread.
> 
>     2) Shorthand IPI allbutself from NMI
>     
>        This should work, but that obviously does not take the watchdog
>        cpumask into account.
> 
>        Also this only works when IPI shorthand mode is enabled. See
>        apic_smt_update() for details.
> 
>     3) Sending the IPIs from irq_work
> 
>        This would solve the problem, but if the CPU which is the NMI
>        target is really stuck in an interrupt disabled region then the
>        IPIs won't be sent.
> 
>        OTOH, if that's the case then the CPU which was processing the
>        NMI will continue to be stuck until the next NMI hits which
>        will detect that the CPU is stuck which is a good enough
>        reason to send a shorthand IPI to all CPUs ignoring the
>        watchdog cpumask.
> 
>        Same limitation vs. shorthand mode as #2
> 
>     4) Changing affinity of the HPET NMI from NMI
> 
>        As we established two years ago that cannot work with interrupt
>        remapping
> 
>     5) Changing affinity of the HPET NMI from irq_work
> 
>        Same issues as #3
> 
> Anything else than #2 is just causing more problems than it solves, but
> surely the NOHZ_FULL/isolation people might have opinions on this.
> 
> OTOH, as this is opt-in, anything which wants a watchdog mask which is
> not the full online set, has to accept that HPET has these restrictions.
> 
> And that's exactly what I suggested two years ago:
> 
>  https://lore.kernel.org/lkml/alpine.DEB.2.21.1906172343120.1963@nanos.tec.linutronix.de/
> 
>   "It definitely would be worthwhile to experiment with that. if we
>    could use shorthands (also for regular IPIs) that would be a great
>    improvement in general and would nicely solve that NMI issue. Beware
>    of the dragons though."
> 
> As a consequence of this conversation I implemented shorthand IPIs...
> 
> But I haven't seen any mentioning that this has been tried, why the
> approach was not chosen or any discussion about that matter.

Indeed, I focused on 5) and I overlooked your comment on using your
new support for shortand IPIs.

I'll go back and see to implement option #2, or perhaps the alternative
solution you proposed on a separate thread.

Thanks and BR,
Ricardo
