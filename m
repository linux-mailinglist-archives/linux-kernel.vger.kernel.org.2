Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3785839B56D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFDJDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFDJDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EA186140F;
        Fri,  4 Jun 2021 09:01:28 +0000 (UTC)
Date:   Fri, 4 Jun 2021 10:01:26 +0100
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
Subject: Re: [PATCH v13 4/8] KVM: arm64: Introduce MTE VM feature
Message-ID: <20210604090125.GA23321@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-5-steven.price@arm.com>
 <20210603160031.GE20338@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603160031.GE20338@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 05:00:31PM +0100, Catalin Marinas wrote:
> On Mon, May 24, 2021 at 11:45:09AM +0100, Steven Price wrote:
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index c5d1f3c87dbd..226035cf7d6c 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -822,6 +822,42 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
> >  	return PAGE_SIZE;
> >  }
> >  
> > +static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
> > +			     unsigned long size)
> > +{
> > +	if (kvm_has_mte(kvm)) {
> > +		/*
> > +		 * The page will be mapped in stage 2 as Normal Cacheable, so
> > +		 * the VM will be able to see the page's tags and therefore
> > +		 * they must be initialised first. If PG_mte_tagged is set,
> > +		 * tags have already been initialised.
> > +		 * pfn_to_online_page() is used to reject ZONE_DEVICE pages
> > +		 * that may not support tags.
> > +		 */
> > +		unsigned long i, nr_pages = size >> PAGE_SHIFT;
> > +		struct page *page = pfn_to_online_page(pfn);
> > +
> > +		if (!page)
> > +			return -EFAULT;
> > +
> > +		for (i = 0; i < nr_pages; i++, page++) {
> > +			/*
> > +			 * There is a potential (but very unlikely) race
> > +			 * between two VMs which are sharing a physical page
> > +			 * entering this at the same time. However by splitting
> > +			 * the test/set the only risk is tags being overwritten
> > +			 * by the mte_clear_page_tags() call.
> > +			 */
> 
> And I think the real risk here is when the page is writable by at least
> one of the VMs sharing the page. This excludes KSM, so it only leaves
> the MAP_SHARED mappings.
> 
> > +			if (!test_bit(PG_mte_tagged, &page->flags)) {
> > +				mte_clear_page_tags(page_address(page));
> > +				set_bit(PG_mte_tagged, &page->flags);
> > +			}
> > +		}
> 
> If we want to cover this race (I'd say in a separate patch), we can call
> mte_sync_page_tags(page, __pte(0), false, true) directly (hopefully I
> got the arguments right). We can avoid the big lock in most cases if
> kvm_arch_prepare_memory_region() sets a VM_MTE_RESET (tag clear etc.)
> and __alloc_zeroed_user_highpage() clears the tags on allocation (as we
> do for VM_MTE but the new flag would not affect the stage 1 VMM page
> attributes).

Another idea: if VM_SHARED is found for any vma within a region in
kvm_arch_prepare_memory_region(), we either prevent the enabling of MTE
for the guest or reject the memory slot if MTE was already enabled.

An alternative here would be to clear VM_MTE_ALLOWED so that any
subsequent mprotect(PROT_MTE) in the VMM would fail in
arch_validate_flags(). MTE would still be allowed in the guest but in
the VMM for the guest memory regions. We can probably do this
irrespective of VM_SHARED. Of course, the VMM can still mmap() the
memory initially with PROT_MTE but that's not an issue IIRC, only the
concurrent mprotect().

-- 
Catalin
