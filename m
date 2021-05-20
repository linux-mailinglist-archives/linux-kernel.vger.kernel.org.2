Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB038AD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242805AbhETL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240449AbhETLzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:55:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAF0161006;
        Thu, 20 May 2021 11:54:29 +0000 (UTC)
Date:   Thu, 20 May 2021 12:54:27 +0100
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
Subject: Re: [PATCH v12 4/8] arm64: kvm: Introduce MTE VM feature
Message-ID: <20210520115426.GB12251@arm.com>
References: <20210517123239.8025-1-steven.price@arm.com>
 <20210517123239.8025-5-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517123239.8025-5-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 01:32:35PM +0100, Steven Price wrote:
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index c5d1f3c87dbd..8660f6a03f51 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -822,6 +822,31 @@ transparent_hugepage_adjust(struct kvm_memory_slot *memslot,
>  	return PAGE_SIZE;
>  }
>  
> +static int sanitise_mte_tags(struct kvm *kvm, unsigned long size,
> +			     kvm_pfn_t pfn)
> +{
> +	if (kvm_has_mte(kvm)) {
> +		/*
> +		 * The page will be mapped in stage 2 as Normal Cacheable, so
> +		 * the VM will be able to see the page's tags and therefore
> +		 * they must be initialised first. If PG_mte_tagged is set,
> +		 * tags have already been initialised.
> +		 */
> +		unsigned long i, nr_pages = size >> PAGE_SHIFT;
> +		struct page *page = pfn_to_online_page(pfn);
> +
> +		if (!page)
> +			return -EFAULT;

IIRC we ended up with pfn_to_online_page() to reject ZONE_DEVICE pages
that may be mapped into a guest and we have no idea whether they support
MTE. It may be worth adding a comment, otherwise, as Marc said, the page
wouldn't disappear.

> +
> +		for (i = 0; i < nr_pages; i++, page++) {
> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> +				mte_clear_page_tags(page_address(page));

We started the page->flags thread and ended up fixing it for the host
set_pte_at() as per the first patch:

https://lore.kernel.org/r/c3293d47-a5f2-ea4a-6730-f5cae26d8a7e@arm.com

Now, can we have a race between the stage 2 kvm_set_spte_gfn() and a
stage 1 set_pte_at()? Only the latter takes a lock. Or between two
kvm_set_spte_gfn() in different VMs? I think in the above thread we
concluded that there's only a problem if the page is shared between
multiple VMMs (MAP_SHARED). How realistic is this and what's the
workaround?

Either way, I think it's worth adding a comment here on the race on
page->flags as it looks strange that here it's just a test_and_set_bit()
while set_pte_at() uses a spinlock.

-- 
Catalin
