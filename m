Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EDF30AF39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhBAS2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:56280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232570AbhBASQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:16:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9760264EA1;
        Mon,  1 Feb 2021 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612203374;
        bh=O2ySvZKk+7LW2Hug34+LrzWUUJZ3jK9LMYnCRRoYkpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRqdWsyMRFoVtw+2RHzX6Rf9rI2AHMhHD1u5H1P2KdDsZBksXRhdgP95MIAXfc1ib
         rGq3rg3Z7Np6F2AwGVqjM9hWIjZ9bqJegQeDqWs34dwgtOMdRkNT8DRFGbectSYs64
         /R6G0hPhnh0sYav41X9bJ7ESdt1ay6lEAtYoGRnqvqchsUkkADYYTKTBzcSP6jmQwp
         sky5TBXgvkNYo3TtBalVHY0whpF9GTfw7Ke68WUvtRgm0mVyUA4GDFZ6INhc2q+W5p
         kAnxEOF/6HkslC+j1Ym5uvrhgArtO/6gumr5Xoz24NDGnVR/WE2PeVK3md74cW/w/g
         uNcTXejdE9zTA==
Date:   Mon, 1 Feb 2021 18:16:08 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 06/26] KVM: arm64: Factor memory allocation out of
 pgtable.c
Message-ID: <20210201181607.GD15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-7-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-7-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:04PM +0000, Quentin Perret wrote:
> In preparation for enabling the creation of page-tables at EL2, factor
> all memory allocation out of the page-table code, hence making it
> re-usable with any compatible memory allocator.
> 
> No functional changes intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 32 +++++++++-
>  arch/arm64/kvm/hyp/pgtable.c         | 90 +++++++++++++++++-----------
>  arch/arm64/kvm/mmu.c                 | 70 +++++++++++++++++++++-
>  3 files changed, 154 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 52ab38db04c7..45acc9dc6c45 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -13,17 +13,41 @@
>  
>  typedef u64 kvm_pte_t;
>  
> +/**
> + * struct kvm_pgtable_mm_ops - Memory management callbacks.
> + * @zalloc_page:	Allocate a zeroed memory page.

Please describe the 'arg' parameter.

> + * @zalloc_pages_exact:	Allocate an exact number of zeroed memory pages.

I think this comment coulld be expanded somewhat to make it clear that (a)
the 'size' parameter is in bytes rather than pages (b) the rounding
behaviour applied if 'size' is not page-aligned and (c) that the resulting
allocation is physically contiguous.

> + * @free_pages_exact:	Free an exact number of memory pages.
> + * @get_page:		Increment the refcount on a page.
> + * @put_page:		Decrement the refcount on a page.
> + * @page_count:		Returns the refcount of a page.
> + * @phys_to_virt:	Convert a physical address into a virtual address.
> + * @virt_to_phys:	Convert a virtual address into a physical address.

I think it would be good to be explicit about the nature of the virtual
address here. We've dealing with virtual addresses that are mapped in the
current context rather than e.g. guest virtual addresses.

> + */
> +struct kvm_pgtable_mm_ops {
> +	void*		(*zalloc_page)(void *arg);
> +	void*		(*zalloc_pages_exact)(size_t size);
> +	void		(*free_pages_exact)(void *addr, size_t size);
> +	void		(*get_page)(void *addr);
> +	void		(*put_page)(void *addr);
> +	int		(*page_count)(void *addr);
> +	void*		(*phys_to_virt)(phys_addr_t phys);
> +	phys_addr_t	(*virt_to_phys)(void *addr);
> +};

[...]

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 1f41173e6149..278e163beda4 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -88,6 +88,48 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>  	return !pfn_valid(pfn);
>  }
>  
> +static void *stage2_memcache_alloc_page(void *arg)
> +{
> +	struct kvm_mmu_memory_cache *mc = arg;
> +	kvm_pte_t *ptep = NULL;
> +
> +	/* Allocated with GFP_KERNEL_ACCOUNT, so no need to zero */

I couldn't spot where GFP_KERNEL_ACCOUNT implies __GFP_ZERO. Please can you
elaborate?

> +	if (mc && mc->nobjs)
> +		ptep = mc->objects[--mc->nobjs];
> +
> +	return ptep;
> +}

Why can't we use kvm_mmu_memory_cache_alloc() directly instead of opening up
the memory_cache?

> +static void *kvm_host_zalloc_pages_exact(size_t size)
> +{
> +	return alloc_pages_exact(size, GFP_KERNEL_ACCOUNT | __GFP_ZERO);

Hmm, so now we're passing __GFP_ZERO? ;)

> +static void kvm_host_get_page(void *addr)
> +{
> +	get_page(virt_to_page(addr));
> +}
> +
> +static void kvm_host_put_page(void *addr)
> +{
> +	put_page(virt_to_page(addr));
> +}
> +
> +static int kvm_host_page_count(void *addr)
> +{
> +	return page_count(virt_to_page(addr));
> +}
> +
> +static phys_addr_t kvm_host_pa(void *addr)
> +{
> +	return __pa(addr);
> +}
> +
> +static void *kvm_host_va(phys_addr_t phys)
> +{
> +	return __va(phys);
> +}
> +
>  /*
>   * Unmapping vs dcache management:
>   *
> @@ -351,6 +393,17 @@ int create_hyp_exec_mappings(phys_addr_t phys_addr, size_t size,
>  	return 0;
>  }
>  
> +static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
> +	.zalloc_page		= stage2_memcache_alloc_page,
> +	.zalloc_pages_exact	= kvm_host_zalloc_pages_exact,
> +	.free_pages_exact	= free_pages_exact,
> +	.get_page		= kvm_host_get_page,
> +	.put_page		= kvm_host_put_page,
> +	.page_count		= kvm_host_page_count,
> +	.phys_to_virt		= kvm_host_va,
> +	.virt_to_phys		= kvm_host_pa,
> +};

Idle thought, but I wonder whether it would be better to have these
implementations as the default and make the mm_ops structure parameter
to kvm_pgtable_stage2_init() optional? I guess you don't gain an awful
lot though, so feel free to ignore me.

Will
