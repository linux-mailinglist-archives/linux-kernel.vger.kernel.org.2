Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC273373299
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 01:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhEDXEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 19:04:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbhEDXEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 19:04:15 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620169399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ll/PI4F/FVWkSEpqvRhq/+/IfArUdPCmgxQCahW3Q3M=;
        b=bA7TtUpy/VkWS1LYnlQ8VPaObfNtx7ewqZbJgB5Tg6hFjPki3RG1ZAEV24kBg5QP5vTFR6
        qbabswYvNGCQlIas1dckpYV9HQ+awsOR5m+D4b7wL+CxS4F4pEoBTkjd66/JXo9iswdkVi
        uaMq9PckdldwUYtmKnN+eqslJALyoM77mFCq3+sN0f96cFl+Lsh6ZgOrgXH4JPRwLX/fw+
        N/upsUArXqTsu669S4r+mfxIhBez18YqekBzal9/gLz5Gjsy7AOmyPOGEQf6mogqetKdmq
        ISKjbIsBXOZ/8/6cXGcnw0JVnDm6n15FWi11mo30tb4mP/i/NNvzbLJgvuIa+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620169399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ll/PI4F/FVWkSEpqvRhq/+/IfArUdPCmgxQCahW3Q3M=;
        b=ZOtoHv13IU/mSywRedzAxnTRdphnFF8B7Do7UiUO4rjVFd53PtqHXsYUbJzGN3lnENbXiG
        zj5CY/++GeQ1rzAg==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     "woodhouse\, Jacob Pan" <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC PATCH v5 5/7] iommu/vt-d: Fixup delivery mode of the HPET hardlockup interrupt
In-Reply-To: <20210504191049.22661-6-ricardo.neri-calderon@linux.intel.com>
References: <20210504191049.22661-1-ricardo.neri-calderon@linux.intel.com> <20210504191049.22661-6-ricardo.neri-calderon@linux.intel.com>
Date:   Wed, 05 May 2021 01:03:18 +0200
Message-ID: <87lf8uhzk9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04 2021 at 12:10, Ricardo Neri wrote:
> In x86 there is not an IRQF_NMI flag that can be used to indicate the

There exists no IRQF_NMI flag at all. No architecture provides that.

> delivery mode when requesting an interrupt (via request_irq()). Thus,
> there is no way for the interrupt remapping driver to know and set
> the delivery mode.

There is no support for this today. So what?

> Hence, when allocating an interrupt, check if such interrupt belongs to
> the HPET hardlockup detector and fixup the delivery mode accordingly.

What?

> +		/*
> +		 * If we find the HPET hardlockup detector irq, fixup the
> +		 * delivery mode.
> +		 */
> +		if (is_hpet_irq_hardlockup_detector(info))
> +			irq_cfg->delivery_mode = APIC_DELIVERY_MODE_NMI;

Again. We are not sticking some random device checks into that
code. It's wrong and I explained it to you before.

  https://lore.kernel.org/lkml/alpine.DEB.2.21.1906161042080.1760@nanos.tec.linutronix.de/

But I'm happy to repeat it again:

  "No. This is horrible hackery violating all the layering which we carefully
   put into place to avoid exactly this kind of sprinkling conditionals into
   all code pathes.

   With some thought the existing irqdomain hierarchy can be used to achieve
   the same thing without tons of extra functions and conditionals."

So the outcome of thought and using the irqdomain hierarchy is:

   Replacing an hpet specific conditional in one place with an hpet
   specific conditional in a different place.

Impressive.

hpet_assign_irq(...., bool nmi)
  init_info(info)
    ...
    if (nmi)
        info.flags |= X86_IRQ_ALLOC_AS_NMI;
  
   irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, &info)
     intel_irq_remapping_alloc(..., info)
       irq_domain_alloc_irq_parents(..., info)
         x86_vector_alloc_irqs(..., info)
         {   
           if (info->flags & X86_IRQ_ALLOC_AS_NMI && nr_irqs != 1)
                  return -EINVAL;

           for (i = 0; i < nr_irqs; i++) {
             ....
             if (info->flags & X86_IRQ_ALLOC_AS_NMI) {
                 irq_cfg_setup_nmi(apicd);
                 continue;
             }
             ...
         }

irq_cfg_setup_nmi() sets irq_cfg->delivery_mode and whatever is required
and everything else just works. Of course this needs a few other minor
tweaks but none of those introduces random hpet quirks all over the
place. Not convoluted enough, right?

But that solves none of other problems. Let me summarize again which
options or non-options we have:

    1) Selective IPIs from NMI context cannot work

       As explained in the other thread.

    2) Shorthand IPI allbutself from NMI
    
       This should work, but that obviously does not take the watchdog
       cpumask into account.

       Also this only works when IPI shorthand mode is enabled. See
       apic_smt_update() for details.

    3) Sending the IPIs from irq_work

       This would solve the problem, but if the CPU which is the NMI
       target is really stuck in an interrupt disabled region then the
       IPIs won't be sent.

       OTOH, if that's the case then the CPU which was processing the
       NMI will continue to be stuck until the next NMI hits which
       will detect that the CPU is stuck which is a good enough
       reason to send a shorthand IPI to all CPUs ignoring the
       watchdog cpumask.

       Same limitation vs. shorthand mode as #2

    4) Changing affinity of the HPET NMI from NMI

       As we established two years ago that cannot work with interrupt
       remapping

    5) Changing affinity of the HPET NMI from irq_work

       Same issues as #3

Anything else than #2 is just causing more problems than it solves, but
surely the NOHZ_FULL/isolation people might have opinions on this.

OTOH, as this is opt-in, anything which wants a watchdog mask which is
not the full online set, has to accept that HPET has these restrictions.

And that's exactly what I suggested two years ago:

 https://lore.kernel.org/lkml/alpine.DEB.2.21.1906172343120.1963@nanos.tec.linutronix.de/

  "It definitely would be worthwhile to experiment with that. if we
   could use shorthands (also for regular IPIs) that would be a great
   improvement in general and would nicely solve that NMI issue. Beware
   of the dragons though."

As a consequence of this conversation I implemented shorthand IPIs...

But I haven't seen any mentioning that this has been tried, why the
approach was not chosen or any discussion about that matter.

Not that I'm surprised.

Thanks,

        tglx
