Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0544694C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhKETvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230063AbhKETvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:51:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B51D61053;
        Fri,  5 Nov 2021 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636141751;
        bh=y9E2/3tUW798ZN2V86zmgMhgAcJlwxxzk/tb4Atgp4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U46T9o8IV/RIMPrYDEotuj/2aagThYdTPu35w0FmRmg+DLk/WW9tVuxnDYxA/o/8x
         MLzqCcFnOPeDMubg/0HZ0I+7FyAjygtoQbBYonTTSZDe8sxDjz4DPzmFLXQYMaOiJy
         sSR+H1V0kgrd47R0nYq6JrsbuhE345saZ6CDn8e1DuUk2+j3nKroTGkBUtWGaP08BU
         /sR00KaRFzdk+3VVZgcQtK0/e2gcXauJQPRyxNUzal1gY0oYibV6hvtPDQTLABeoHD
         WIUBpuiov1aPJ/F+Woxd8WnC6KYaUciiBBez8zhsr6wL88PuFztyKzbPKDSreid6hV
         oUXeZPCUJcsEg==
Date:   Fri, 5 Nov 2021 21:49:01 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: Track no early_pgtable_alloc() for kmemleak
Message-ID: <YYWKrdrVbjXLn0wJ@kernel.org>
References: <20211105150509.7826-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105150509.7826-1-quic_qiancai@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 11:05:09AM -0400, Qian Cai wrote:
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

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> v2:
> Rename MEMBLOCK_ALLOC_KASAN to MEMBLOCK_ALLOC_NOLEAKTRACE to deal with
> those situations in general.
> 
>  arch/arm/mm/kasan_init.c   | 2 +-
>  arch/arm64/mm/kasan_init.c | 5 +++--
>  arch/arm64/mm/mmu.c        | 3 ++-
>  include/linux/memblock.h   | 2 +-
>  mm/memblock.c              | 9 ++++++---
>  5 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
> index 4b1619584b23..5ad0d6c56d56 100644
> --- a/arch/arm/mm/kasan_init.c
> +++ b/arch/arm/mm/kasan_init.c
> @@ -32,7 +32,7 @@ pmd_t tmp_pmd_table[PTRS_PER_PMD] __page_aligned_bss;
>  static __init void *kasan_alloc_block(size_t size)
>  {
>  	return memblock_alloc_try_nid(size, size, __pa(MAX_DMA_ADDRESS),
> -				      MEMBLOCK_ALLOC_KASAN, NUMA_NO_NODE);
> +				      MEMBLOCK_ALLOC_NOLEAKTRACE, NUMA_NO_NODE);
>  }
>  
>  static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 6f5a6fe8edd7..c12cd700598f 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -36,7 +36,7 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
>  {
>  	void *p = memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
>  					      __pa(MAX_DMA_ADDRESS),
> -					      MEMBLOCK_ALLOC_KASAN, node);
> +					      MEMBLOCK_ALLOC_NOLEAKTRACE, node);
>  	if (!p)
>  		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%llx\n",
>  		      __func__, PAGE_SIZE, PAGE_SIZE, node,
> @@ -49,7 +49,8 @@ static phys_addr_t __init kasan_alloc_raw_page(int node)
>  {
>  	void *p = memblock_alloc_try_nid_raw(PAGE_SIZE, PAGE_SIZE,
>  						__pa(MAX_DMA_ADDRESS),
> -						MEMBLOCK_ALLOC_KASAN, node);
> +						MEMBLOCK_ALLOC_NOLEAKTRACE,
> +						node);
>  	if (!p)
>  		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%llx\n",
>  		      __func__, PAGE_SIZE, PAGE_SIZE, node,
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d77bf06d6a6d..acfae9b41cc8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -96,7 +96,8 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
>  	phys_addr_t phys;
>  	void *ptr;
>  
> -	phys = memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
> +	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
> +					 MEMBLOCK_ALLOC_NOLEAKTRACE);
>  	if (!phys)
>  		panic("Failed to allocate page table page\n");
>  
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 7df557b16c1e..8adcf1fa8096 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -389,7 +389,7 @@ static inline int memblock_get_region_node(const struct memblock_region *r)
>  /* Flags for memblock allocation APIs */
>  #define MEMBLOCK_ALLOC_ANYWHERE	(~(phys_addr_t)0)
>  #define MEMBLOCK_ALLOC_ACCESSIBLE	0
> -#define MEMBLOCK_ALLOC_KASAN		1
> +#define MEMBLOCK_ALLOC_NOLEAKTRACE	1
>  
>  /* We are using top down, so it is safe to use 0 here */
>  #define MEMBLOCK_LOW_LIMIT 0
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 659bf0ffb086..1018e50566f3 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -287,7 +287,7 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
>  {
>  	/* pump up @end */
>  	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
> -	    end == MEMBLOCK_ALLOC_KASAN)
> +	    end == MEMBLOCK_ALLOC_NOLEAKTRACE)
>  		end = memblock.current_limit;
>  
>  	/* avoid allocating the first page */
> @@ -1387,8 +1387,11 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
>  	return 0;
>  
>  done:
> -	/* Skip kmemleak for kasan_init() due to high volume. */
> -	if (end != MEMBLOCK_ALLOC_KASAN)
> +	/*
> +	 * Skip kmemleak for those places like kasan_init() and
> +	 * early_pgtable_alloc() due to high volume.
> +	 */
> +	if (end != MEMBLOCK_ALLOC_NOLEAKTRACE)
>  		/*
>  		 * The min_count is set to 0 so that memblock allocated
>  		 * blocks are never reported as leaks. This is because many
> -- 
> 2.30.2
> 

-- 
Sincerely yours,
Mike.
