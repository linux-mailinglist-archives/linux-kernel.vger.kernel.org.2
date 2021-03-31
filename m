Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABB734FC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhCaJV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhCaJVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:21:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9835B617C9;
        Wed, 31 Mar 2021 09:21:12 +0000 (UTC)
Date:   Wed, 31 Mar 2021 10:21:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Steven Price <steven.price@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>, Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        qemu-devel@nongnu.org, Marc Zyngier <maz@kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v10 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <20210331092109.GA21921@arm.com>
References: <20210312151902.17853-1-steven.price@arm.com>
 <20210312151902.17853-3-steven.price@arm.com>
 <20210327152324.GA28167@arm.com>
 <20210328122131.GB17535@arm.com>
 <e0b88560-34e1-dcc4-aaa7-9a7a5b771824@arm.com>
 <20210330103013.GD18075@arm.com>
 <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8977120b-841d-4882-2472-6e403bc9c797@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 09:34:44AM +0200, David Hildenbrand wrote:
> On 30.03.21 12:30, Catalin Marinas wrote:
> > On Mon, Mar 29, 2021 at 05:06:51PM +0100, Steven Price wrote:
> > > On 28/03/2021 13:21, Catalin Marinas wrote:
> > > > On Sat, Mar 27, 2021 at 03:23:24PM +0000, Catalin Marinas wrote:
> > > > > On Fri, Mar 12, 2021 at 03:18:58PM +0000, Steven Price wrote:
> > > > > > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > > > > > index 77cb2d28f2a4..b31b7a821f90 100644
> > > > > > --- a/arch/arm64/kvm/mmu.c
> > > > > > +++ b/arch/arm64/kvm/mmu.c
> > > > > > @@ -879,6 +879,22 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> > > > > >    	if (vma_pagesize == PAGE_SIZE && !force_pte)
> > > > > >    		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
> > > > > >    							   &pfn, &fault_ipa);
> > > > > > +
> > > > > > +	if (fault_status != FSC_PERM && kvm_has_mte(kvm) && pfn_valid(pfn)) {
> > > > > > +		/*
> > > > > > +		 * VM will be able to see the page's tags, so we must ensure
> > > > > > +		 * they have been initialised. if PG_mte_tagged is set, tags
> > > > > > +		 * have already been initialised.
> > > > > > +		 */
> > > > > > +		struct page *page = pfn_to_page(pfn);
> > > > > > +		unsigned long i, nr_pages = vma_pagesize >> PAGE_SHIFT;
> > > > > > +
> > > > > > +		for (i = 0; i < nr_pages; i++, page++) {
> > > > > > +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> > > > > > +				mte_clear_page_tags(page_address(page));
> > > > > > +		}
> > > > > > +	}
> > > > > 
> > > > > This pfn_valid() check may be problematic. Following commit eeb0753ba27b
> > > > > ("arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory"), it returns
> > > > > true for ZONE_DEVICE memory but such memory is allowed not to support
> > > > > MTE.
> > > > 
> > > > Some more thinking, this should be safe as any ZONE_DEVICE would be
> > > > mapped as untagged memory in the kernel linear map. It could be slightly
> > > > inefficient if it unnecessarily tries to clear tags in ZONE_DEVICE,
> > > > untagged memory. Another overhead is pfn_valid() which will likely end
> > > > up calling memblock_is_map_memory().
> > > > 
> > > > However, the bigger issue is that Stage 2 cannot disable tagging for
> > > > Stage 1 unless the memory is Non-cacheable or Device at S2. Is there a
> > > > way to detect what gets mapped in the guest as Normal Cacheable memory
> > > > and make sure it's only early memory or hotplug but no ZONE_DEVICE (or
> > > > something else like on-chip memory)?  If we can't guarantee that all
> > > > Cacheable memory given to a guest supports tags, we should disable the
> > > > feature altogether.
> > > 
> > > In stage 2 I believe we only have two types of mapping - 'normal' or
> > > DEVICE_nGnRE (see stage2_map_set_prot_attr()). Filtering out the latter is a
> > > case of checking the 'device' variable, and makes sense to avoid the
> > > overhead you describe.
> > > 
> > > This should also guarantee that all stage-2 cacheable memory supports tags,
> > > as kvm_is_device_pfn() is simply !pfn_valid(), and pfn_valid() should only
> > > be true for memory that Linux considers "normal".
> 
> If you think "normal" == "normal System RAM", that's wrong; see below.

By "normal" I think both Steven and I meant the Normal Cacheable memory
attribute (another being the Device memory attribute).

> > That's the problem. With Anshuman's commit I mentioned above,
> > pfn_valid() returns true for ZONE_DEVICE mappings (e.g. persistent
> > memory, not talking about some I/O mapping that requires Device_nGnRE).
> > So kvm_is_device_pfn() is false for such memory and it may be mapped as
> > Normal but it is not guaranteed to support tagging.
> 
> pfn_valid() means "there is a struct page"; if you do pfn_to_page() and
> touch the page, you won't fault. So Anshuman's commit is correct.

I agree.

> pfn_to_online_page() means, "there is a struct page and it's system RAM
> that's in use; the memmap has a sane content"

Does pfn_to_online_page() returns a valid struct page pointer for
ZONE_DEVICE pages? IIUC, these are not guaranteed to be system RAM, for
some definition of system RAM (I assume NVDIMM != system RAM). For
example, pmem_attach_disk() calls devm_memremap_pages() and this would
use the Normal Cacheable memory attribute without necessarily being
system RAM.

So if pfn_valid() is not equivalent to system RAM, we have a potential
issue with MTE. Even if "system RAM" includes NVDIMMs, we still have
this issue and we may need a new term to describe MTE-safe memory. In
the kernel we assume MTE-safe all pages that can be mapped as
MAP_ANONYMOUS and I don't think these include ZONE_DEVICE pages.

Thanks.

-- 
Catalin
