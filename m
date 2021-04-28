Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5C36DDD7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 19:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241447AbhD1RIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 13:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231916AbhD1RH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 13:07:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0C11613B4;
        Wed, 28 Apr 2021 17:07:10 +0000 (UTC)
Date:   Wed, 28 Apr 2021 18:07:08 +0100
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
Subject: Re: [PATCH v11 2/6] arm64: kvm: Introduce MTE VM feature
Message-ID: <20210428170705.GB4022@arm.com>
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416154309.22129-3-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 04:43:05PM +0100, Steven Price wrote:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 77cb2d28f2a4..5f8e165ea053 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -879,6 +879,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (vma_pagesize == PAGE_SIZE && !force_pte)
>  		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>  							   &pfn, &fault_ipa);
> +
> +	if (fault_status != FSC_PERM && kvm_has_mte(kvm) && !device &&
> +	    pfn_valid(pfn)) {

In the current implementation, device == !pfn_valid(), so we could skip
the latter check.

> +		/*
> +		 * VM will be able to see the page's tags, so we must ensure
> +		 * they have been initialised. if PG_mte_tagged is set, tags
> +		 * have already been initialised.
> +		 */
> +		unsigned long i, nr_pages = vma_pagesize >> PAGE_SHIFT;
> +		struct page *page = pfn_to_online_page(pfn);
> +
> +		if (!page)
> +			return -EFAULT;

I think that's fine, though maybe adding a comment that otherwise it
would be mapped at stage 2 as Normal Cacheable and we cannot guarantee
that the memory supports MTE tags.

> +
> +		for (i = 0; i < nr_pages; i++, page++) {
> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> +				mte_clear_page_tags(page_address(page));
> +		}
> +	}
> +
>  	if (writable)
>  		prot |= KVM_PGTABLE_PROT_W;

I probably asked already but is the only way to map a standard RAM page
(not device) in stage 2 via the fault handler? One case I had in mind
was something like get_user_pages() but it looks like that one doesn't
call set_pte_at_notify(). There are a few other places where
set_pte_at_notify() is called and these may happen before we got a
chance to fault on stage 2, effectively populating the entry (IIUC). If
that's an issue, we could move the above loop and check closer to the
actual pte setting like kvm_pgtable_stage2_map().

While the set_pte_at() race on the page flags is somewhat clearer, we
may still have a race here with the VMM's set_pte_at() if the page is
mapped as tagged. KVM has its own mmu_lock but it wouldn't be held when
handling the VMM page tables (well, not always, see below).

gfn_to_pfn_prot() ends up calling get_user_pages*(). At least the slow
path (hva_to_pfn_slow()) ends up with FOLL_TOUCH in gup and the VMM pte
would be set, tags cleared (if PROT_MTE) before the stage 2 pte. I'm not
sure whether get_user_page_fast_only() does the same.

The race with an mprotect(PROT_MTE) in the VMM is fine I think as the
KVM mmu notifier is invoked before set_pte_at() and racing with another
user_mem_abort() is serialised by the KVM mmu_lock. The subsequent
set_pte_at() would see the PG_mte_tagged set either by the current CPU
or by the one it was racing with.

-- 
Catalin
