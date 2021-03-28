Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0634BC4E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhC1MVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhC1MVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:21:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80ACF6196C;
        Sun, 28 Mar 2021 12:21:35 +0000 (UTC)
Date:   Sun, 28 Mar 2021 13:21:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v10 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <20210328122131.GB17535@arm.com>
References: <20210312151902.17853-1-steven.price@arm.com>
 <20210312151902.17853-3-steven.price@arm.com>
 <20210327152324.GA28167@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327152324.GA28167@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 03:23:24PM +0000, Catalin Marinas wrote:
> On Fri, Mar 12, 2021 at 03:18:58PM +0000, Steven Price wrote:
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 77cb2d28f2a4..b31b7a821f90 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -879,6 +879,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> >  	if (vma_pagesize == PAGE_SIZE && !force_pte)
> >  		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
> >  							   &pfn, &fault_ipa);
> > +
> > +	if (fault_status != FSC_PERM && kvm_has_mte(kvm) && pfn_valid(pfn)) {
> > +		/*
> > +		 * VM will be able to see the page's tags, so we must ensure
> > +		 * they have been initialised. if PG_mte_tagged is set, tags
> > +		 * have already been initialised.
> > +		 */
> > +		struct page *page = pfn_to_page(pfn);
> > +		unsigned long i, nr_pages = vma_pagesize >> PAGE_SHIFT;
> > +
> > +		for (i = 0; i < nr_pages; i++, page++) {
> > +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> > +				mte_clear_page_tags(page_address(page));
> > +		}
> > +	}
> 
> This pfn_valid() check may be problematic. Following commit eeb0753ba27b
> ("arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory"), it returns
> true for ZONE_DEVICE memory but such memory is allowed not to support
> MTE.

Some more thinking, this should be safe as any ZONE_DEVICE would be
mapped as untagged memory in the kernel linear map. It could be slightly
inefficient if it unnecessarily tries to clear tags in ZONE_DEVICE,
untagged memory. Another overhead is pfn_valid() which will likely end
up calling memblock_is_map_memory().

However, the bigger issue is that Stage 2 cannot disable tagging for
Stage 1 unless the memory is Non-cacheable or Device at S2. Is there a
way to detect what gets mapped in the guest as Normal Cacheable memory
and make sure it's only early memory or hotplug but no ZONE_DEVICE (or
something else like on-chip memory)?  If we can't guarantee that all
Cacheable memory given to a guest supports tags, we should disable the
feature altogether.

> I now wonder if we can get a MAP_ANONYMOUS mapping of ZONE_DEVICE pfn
> even without virtualisation.

I haven't checked all the code paths but I don't think we can get a
MAP_ANONYMOUS mapping of ZONE_DEVICE memory as we normally need a file
descriptor.

-- 
Catalin
