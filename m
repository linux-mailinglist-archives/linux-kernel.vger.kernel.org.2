Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5FF4457F0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhKDRJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhKDRJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:09:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABFA1610D0;
        Thu,  4 Nov 2021 17:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636045617;
        bh=Q3KX2xW1zpDKC4VCay8v5kQG0LBSrEoOWXthl7qQ75M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4QNo0A9mr/WTpiiuz3anR4j9IobduIOiuN/xQGGwGodsGglMp7u+GI4+jgH4a6Zp
         RL3U8tfV10mmBYP03eKtftn6mE8TVeA+YO6q/DEb6BWlU2UuUql2D91YMKgYJyUy7J
         YQsat4iwNWPuw8lpXwNBnpjj24ept6JctMfquT/l8eqyUFFzdSnqYISedKHgiZxVyv
         GM+X2iALzm/6koRNVvQoaptIHOQkTlsB3E892euIfqhMwpVy49WC3etlfTro4w98jk
         QwfEZ95nwWq2GGsGWSMHA4L2t3Uw+ImrMQAr6p9TYdi8UHiXQtyeISFgSlJUhXjbeZ
         6mxCvtp5Q5h7Q==
Date:   Thu, 4 Nov 2021 19:06:49 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Track no early_pgtable_alloc() for kmemleak
Message-ID: <YYQTKRrDIJbkcplr@kernel.org>
References: <20211104155623.11158-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104155623.11158-1-quic_qiancai@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:56:23AM -0400, Qian Cai wrote:
> After switched page size from 64KB to 4KB on several arm64 servers here,
> kmemleak starts to run out of early memory pool due to a huge number of
> those early_pgtable_alloc() calls:
> 
>   kmemleak_alloc_phys()
>   memblock_alloc_range_nid()
>   memblock_phys_alloc_range()
>   early_pgtable_alloc()
>   init_pmd()
>   alloc_init_pud()
>   __create_pgd_mapping()
>   __map_memblock()
>   paging_init()
>   setup_arch()
>   start_kernel()
> 
> Increased the default value of DEBUG_KMEMLEAK_MEM_POOL_SIZE by 4 times
> won't be enough for a server with 200GB+ memory. There isn't much
> interesting to check memory leaks for those early page tables and those
> early memory mappings should not reference to other memory. Hence, no
> kmemleak false positives, and we can safely skip tracking those early
> allocations from kmemleak like we did in the commit fed84c785270
> ("mm/memblock.c: skip kmemleak for kasan_init()") without needing to
> introduce complications to automatically scale the value depends on the
> runtime memory size etc. After the patch, the default value of
> DEBUG_KMEMLEAK_MEM_POOL_SIZE becomes sufficient again.
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---
>  arch/arm64/mm/mmu.c      |  3 ++-
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 10 +++++++---
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d77bf06d6a6d..4d3cfbaa92a7 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -96,7 +96,8 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
>  	phys_addr_t phys;
>  	void *ptr;
>  
> -	phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
> +					 MEMBLOCK_ALLOC_PGTABLE);
>  	if (!phys)
>  		panic("Failed to allocate page table page\n");
>  
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 7df557b16c1e..de903055b01c 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -390,6 +390,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
>  #define MEMBLOCK_ALLOC_ACCESSIBLE	0
>  #define MEMBLOCK_ALLOC_KASAN		1
> +#define MEMBLOCK_ALLOC_PGTABLE		2
>  
>  /* We are using top down, so it is safe to use 0 here */
>  #define MEMBLOCK_LOW_LIMIT 0
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 659bf0ffb086..13bc56a641c0 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -287,7 +287,8 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>  {
>  	/* pump up @end */
>  	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
> -	    end == MEMBLOCK_ALLOC_KASAN)
> +	    end == MEMBLOCK_ALLOC_KASAN ||
> +	    end == MEMBLOCK_ALLOC_PGTABLE)

I think I'll be better to rename MEMBLOCK_ALLOC_KASAN to, say,
MEMBLOCK_ALLOC_NOKMEMLEAK and use that for both KASAN and page table cases.

But more generally, we are going to hit this again and again.
Couldn't we add a memblock allocation as a mean to get more memory to
kmemleak::mem_pool_alloc()?

>  		end = memblock.current_limit;
>  
>  	/* avoid allocating the first page */
> @@ -1387,8 +1388,11 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  	return 0;
>  
>  done:
> -	/* Skip kmemleak for kasan_init() due to high volume. */
> -	if (end != MEMBLOCK_ALLOC_KASAN)
> +	/*
> +	 * Skip kmemleak for kasan_init() and early_pgtable_alloc() due to high
> +	 * volume.
> +	 */
> +	if (end != MEMBLOCK_ALLOC_KASAN && end != MEMBLOCK_ALLOC_PGTABLE)
>  		/*
>  		 * The min_count is set to 0 so that memblock allocated
>  		 * blocks are never reported as leaks. This is because many
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
