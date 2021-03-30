Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818B034E579
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhC3Kag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhC3KaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:30:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F15E76195C;
        Tue, 30 Mar 2021 10:30:17 +0000 (UTC)
Date:   Tue, 30 Mar 2021 11:30:15 +0100
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
Message-ID: <20210330103013.GD18075@arm.com>
References: <20210312151902.17853-1-steven.price@arm.com>
 <20210312151902.17853-3-steven.price@arm.com>
 <20210327152324.GA28167@arm.com>
 <20210328122131.GB17535@arm.com>
 <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 05:06:51PM +0100, Steven Price wrote:
> On 28/03/2021 13:21, Catalin Marinas wrote:
> > On Sat, Mar 27, 2021 at 03:23:24PM +0000, Catalin Marinas wrote:
> > > On Fri, Mar 12, 2021 at 03:18:58PM +0000, Steven Price wrote:
> > > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > > index 77cb2d28f2a4..b31b7a821f90 100644
> > > > --- a/arch/arm64/kvm/mmu.c
> > > > +++ b/arch/arm64/kvm/mmu.c
> > > > @@ -879,6 +879,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > > >   	if (vma_pagesize == PAGE_SIZE && !force_pte)
> > > >   		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
> > > >   							   &pfn, &fault_ipa);
> > > > +
> > > > +	if (fault_status != FSC_PERM && kvm_has_mte(kvm) && pfn_valid(pfn)) {
> > > > +		/*
> > > > +		 * VM will be able to see the page's tags, so we must ensure
> > > > +		 * they have been initialised. if PG_mte_tagged is set, tags
> > > > +		 * have already been initialised.
> > > > +		 */
> > > > +		struct page *page = pfn_to_page(pfn);
> > > > +		unsigned long i, nr_pages = vma_pagesize >> PAGE_SHIFT;
> > > > +
> > > > +		for (i = 0; i < nr_pages; i++, page++) {
> > > > +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> > > > +				mte_clear_page_tags(page_address(page));
> > > > +		}
> > > > +	}
> > > 
> > > This pfn_valid() check may be problematic. Following commit eeb0753ba27b
> > > ("arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory"), it returns
> > > true for ZONE_DEVICE memory but such memory is allowed not to support
> > > MTE.
> > 
> > Some more thinking, this should be safe as any ZONE_DEVICE would be
> > mapped as untagged memory in the kernel linear map. It could be slightly
> > inefficient if it unnecessarily tries to clear tags in ZONE_DEVICE,
> > untagged memory. Another overhead is pfn_valid() which will likely end
> > up calling memblock_is_map_memory().
> > 
> > However, the bigger issue is that Stage 2 cannot disable tagging for
> > Stage 1 unless the memory is Non-cacheable or Device at S2. Is there a
> > way to detect what gets mapped in the guest as Normal Cacheable memory
> > and make sure it's only early memory or hotplug but no ZONE_DEVICE (or
> > something else like on-chip memory)?  If we can't guarantee that all
> > Cacheable memory given to a guest supports tags, we should disable the
> > feature altogether.
> 
> In stage 2 I believe we only have two types of mapping - 'normal' or
> DEVICE_nGnRE (see stage2_map_set_prot_attr()). Filtering out the latter is a
> case of checking the 'device' variable, and makes sense to avoid the
> overhead you describe.
> 
> This should also guarantee that all stage-2 cacheable memory supports tags,
> as kvm_is_device_pfn() is simply !pfn_valid(), and pfn_valid() should only
> be true for memory that Linux considers "normal".

That's the problem. With Anshuman's commit I mentioned above,
pfn_valid() returns true for ZONE_DEVICE mappings (e.g. persistent
memory, not talking about some I/O mapping that requires Device_nGnRE).
So kvm_is_device_pfn() is false for such memory and it may be mapped as
Normal but it is not guaranteed to support tagging.

For user MTE, we get away with this as the MAP_ANONYMOUS requirement
would filter it out while arch_add_memory() will ensure it's mapped as
untagged in the linear map. See another recent fix for hotplugged
memory: d15dfd31384b ("arm64: mte: Map hotplugged memory as Normal
Tagged"). We needed to ensure that ZONE_DEVICE doesn't end up as tagged,
only hoplugged memory. Both handled via arch_add_memory() in the arch
code with ZONE_DEVICE starting at devm_memremap_pages().

> > > I now wonder if we can get a MAP_ANONYMOUS mapping of ZONE_DEVICE pfn
> > > even without virtualisation.
> > 
> > I haven't checked all the code paths but I don't think we can get a
> > MAP_ANONYMOUS mapping of ZONE_DEVICE memory as we normally need a file
> > descriptor.
> 
> I certainly hope this is the case - it's the weird corner cases of device
> drivers that worry me. E.g. I know i915 has a "hidden" mmap behind an ioctl
> (see i915_gem_mmap_ioctl(), although this case is fine - it's MAP_SHARED).
> Mali's kbase did something similar in the past.

I think this should be fine since it's not a MAP_ANONYMOUS (we do allow
MAP_SHARED to be tagged).

-- 
Catalin
