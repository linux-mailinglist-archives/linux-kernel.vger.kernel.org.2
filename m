Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B326939A52E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhFCQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:02:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F074613DC;
        Thu,  3 Jun 2021 16:00:33 +0000 (UTC)
Date:   Thu, 3 Jun 2021 17:00:31 +0100
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
Message-ID: <20210603160031.GE20338@arm.com>
References: <20210524104513.13258-1-steven.price@arm.com>
 <20210524104513.13258-5-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524104513.13258-5-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 11:45:09AM +0100, Steven Price wrote:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index c5d1f3c87dbd..226035cf7d6c 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -822,6 +822,42 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
>  	return PAGE_SIZE;
>  }
>  
> +static int sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
> +			     unsigned long size)
> +{
> +	if (kvm_has_mte(kvm)) {

Nitpick (less indentation):

	if (!kvm_has_mte(kvm))
		return 0;

> +		/*
> +		 * The page will be mapped in stage 2 as Normal Cacheable, so
> +		 * the VM will be able to see the page's tags and therefore
> +		 * they must be initialised first. If PG_mte_tagged is set,
> +		 * tags have already been initialised.
> +		 * pfn_to_online_page() is used to reject ZONE_DEVICE pages
> +		 * that may not support tags.
> +		 */
> +		unsigned long i, nr_pages = size >> PAGE_SHIFT;
> +		struct page *page = pfn_to_online_page(pfn);
> +
> +		if (!page)
> +			return -EFAULT;
> +
> +		for (i = 0; i < nr_pages; i++, page++) {
> +			/*
> +			 * There is a potential (but very unlikely) race
> +			 * between two VMs which are sharing a physical page
> +			 * entering this at the same time. However by splitting
> +			 * the test/set the only risk is tags being overwritten
> +			 * by the mte_clear_page_tags() call.
> +			 */

And I think the real risk here is when the page is writable by at least
one of the VMs sharing the page. This excludes KSM, so it only leaves
the MAP_SHARED mappings.

> +			if (!test_bit(PG_mte_tagged, &page->flags)) {
> +				mte_clear_page_tags(page_address(page));
> +				set_bit(PG_mte_tagged, &page->flags);
> +			}
> +		}

If we want to cover this race (I'd say in a separate patch), we can call
mte_sync_page_tags(page, __pte(0), false, true) directly (hopefully I
got the arguments right). We can avoid the big lock in most cases if
kvm_arch_prepare_memory_region() sets a VM_MTE_RESET (tag clear etc.)
and __alloc_zeroed_user_highpage() clears the tags on allocation (as we
do for VM_MTE but the new flag would not affect the stage 1 VMM page
attributes).

> +	}
> +
> +	return 0;
> +}
> +
>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  			  struct kvm_memory_slot *memslot, unsigned long hva,
>  			  unsigned long fault_status)
> @@ -971,8 +1007,13 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (writable)
>  		prot |= KVM_PGTABLE_PROT_W;
>  
> -	if (fault_status != FSC_PERM && !device)
> +	if (fault_status != FSC_PERM && !device) {
> +		ret = sanitise_mte_tags(kvm, pfn, vma_pagesize);
> +		if (ret)
> +			goto out_unlock;

Maybe it was discussed in a previous version, why do we need this in
addition to kvm_set_spte_gfn()?

> +
>  		clean_dcache_guest_page(pfn, vma_pagesize);
> +	}
>  
>  	if (exec_fault) {
>  		prot |= KVM_PGTABLE_PROT_X;
> @@ -1168,12 +1209,17 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
>  bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
>  {
>  	kvm_pfn_t pfn = pte_pfn(range->pte);
> +	int ret;
>  
>  	if (!kvm->arch.mmu.pgt)
>  		return 0;
>  
>  	WARN_ON(range->end - range->start != 1);
>  
> +	ret = sanitise_mte_tags(kvm, pfn, PAGE_SIZE);
> +	if (ret)
> +		return false;
> +
>  	/*
>  	 * We've moved a page around, probably through CoW, so let's treat it
>  	 * just like a translation fault and clean the cache to the PoC.

Otherwise the patch looks fine.

-- 
Catalin
