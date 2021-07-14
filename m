Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E553C93E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbhGNWfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:35:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhGNWfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A223613C9;
        Wed, 14 Jul 2021 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626301929;
        bh=EHY882iGgDnDRGkqCFxlcI9IHP3HEwM+N+ik+0IVVjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oDTjyZtKIPXeq1bX83YD6pIo2C+3MPcxM8jSvTVZyorJQS/g82Cw8MEH5KB/6U0+D
         rmax19QPt6/22JIXx3UGw6UBlCbFrxH9A5N+9ylZeHjwCqszBlEc8Wd9fJDD4nhCZx
         8jmoIbjNW5iDwasSKYXK9FfNF25GDeBfpYBG8PmI=
Date:   Wed, 14 Jul 2021 15:32:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/4] mm: introduce memmap_alloc() to unify memory map
 allocation
Message-Id: <20210714153208.ef96cfc7c6bac360598101ed@linux-foundation.org>
In-Reply-To: <20210714123739.16493-4-rppt@kernel.org>
References: <20210714123739.16493-1-rppt@kernel.org>
        <20210714123739.16493-4-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 15:37:38 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are several places that allocate memory for the memory map:
> alloc_node_mem_map() for FLATMEM, sparse_buffer_init() and
> __populate_section_memmap() for SPARSEMEM.
> 
> The memory allocated in the FLATMEM case is zeroed and it is never
> poisoned, regardless of CONFIG_PAGE_POISON setting.
> 
> The memory allocated in the SPARSEMEM cases is not zeroed and it is
> implicitly poisoned inside memblock if CONFIG_PAGE_POISON is set.
> 
> Introduce memmap_alloc() wrapper for memblock allocators that will be used
> for both FLATMEM and SPARSEMEM cases and will makei memory map zeroing and
> poisoning consistent for different memory models.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6730,6 +6730,26 @@ static void __init memmap_init(void)
>  		init_unavailable_range(hole_pfn, end_pfn, zone_id, nid);
>  }
>  
> +void __init *memmap_alloc(phys_addr_t size, phys_addr_t align,
> +			  phys_addr_t min_addr, int nid, bool exact_nid)
> +{
> +	void *ptr;
> +
> +	if (exact_nid)
> +		ptr = memblock_alloc_exact_nid_raw(size, align, min_addr,
> +						   MEMBLOCK_ALLOC_ACCESSIBLE,
> +						   nid);
> +	else
> +		ptr = memblock_alloc_try_nid_raw(size, align, min_addr,
> +						 MEMBLOCK_ALLOC_ACCESSIBLE,
> +						 nid);
> +
> +	if (ptr && size > 0)
> +		page_init_poison(ptr, size);
> +
> +	return ptr;
> +}
> +
>  static int zone_batchsize(struct zone *zone)
>  {
>  #ifdef CONFIG_MMU
> @@ -7501,8 +7521,8 @@ static void __ref alloc_node_mem_map(struct pglist_data *pgdat)
>  		end = pgdat_end_pfn(pgdat);
>  		end = ALIGN(end, MAX_ORDER_NR_PAGES);
>  		size =  (end - start) * sizeof(struct page);
> -		map = memblock_alloc_node(size, SMP_CACHE_BYTES,
> -					  pgdat->node_id);
> +		map = memmap_alloc(size, SMP_CACHE_BYTES, MEMBLOCK_LOW_LIMIT,
> +				   pgdat->node_id, false);

Mostly offtopic, but...  Why is alloc_node_mem_map() marked __ref? 
afaict it can be __init?
