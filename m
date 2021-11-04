Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5BC4450C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhKDJCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:02:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33112 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhKDJCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:02:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34582212BD;
        Thu,  4 Nov 2021 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1636016394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHgMSLSsZciqyDKovNJpJOLLyUz2f8yCrBxcbv99D2w=;
        b=P2VDLgHyqRtFyYFgUXtLqQcQJXO8Kl7PKzqj/1htCo3lXHnEtHDFbBqh96wV/73AEyKFsf
        j2J4FVJ/oKvDizQxfwEMMG8FZiIG9nm6bIxy0QhprMaV7NVtPKoqUBYhgMu5b0BakBIHfu
        LrXC4SL4e/HVywXwtwb58qyNCASWd/c=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76082A3BF2;
        Thu,  4 Nov 2021 08:59:53 +0000 (UTC)
Date:   Thu, 4 Nov 2021 09:59:48 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Averin <vvs@virtuozzo.com>
Subject: Re: [PATCH] mm/vmalloc: Eliminate an extra orig_gfp_mask
Message-ID: <YYOhBGACLb+p1jl0@dhcp22.suse.cz>
References: <20211103200703.2265-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103200703.2265-1-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Vasily]

On Wed 03-11-21 21:07:03, Uladzislau Rezki wrote:
> That extra variable has been introduced just for keeping an original
> passed gfp_mask because it is updated with __GFP_NOWARN on entry, thus
> error handling messages were broken.

I am not sure what you mean by "error handling messages were broken"
part.

It is true that the current Linus tree has a broken allocation failure
reporting but that is not a fault of orig_gfp_mask. In fact patch which
is fixing that "mm/vmalloc: repair warn_alloc()s in
__vmalloc_area_node()" currently in akpm tree is adding the additional
mask.
 
> Instead we can keep an original gfp_mask without modifying it and add
> an extra __GFP_NOWARN flag together with gfp_mask as a parameter to
> the vm_area_alloc_pages() function. It will make it less confused.

I would tend to agree that this is a better approach. There is already
nested_gfp mask and one more doesn't add to the readbility.

Maybe we should just drop the above patch and just go with one which
doesn't introduce the intermediate step and an additional gfp mask.

> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d2a00ad4e1dd..3b549ff5c95e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2920,7 +2920,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				 int node)
>  {
>  	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
> -	const gfp_t orig_gfp_mask = gfp_mask;
>  	unsigned long addr = (unsigned long)area->addr;
>  	unsigned long size = get_vm_area_size(area);
>  	unsigned long array_size;
> @@ -2928,7 +2927,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	unsigned int page_order;
>  
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> -	gfp_mask |= __GFP_NOWARN;
> +
>  	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
>  		gfp_mask |= __GFP_HIGHMEM;
>  
> @@ -2941,7 +2940,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	}
>  
>  	if (!area->pages) {
> -		warn_alloc(orig_gfp_mask, NULL,
> +		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to allocated page array size %lu",
>  			nr_small_pages * PAGE_SIZE, array_size);
>  		free_vm_area(area);
> @@ -2951,8 +2950,8 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
>  	page_order = vm_area_page_order(area);
>  
> -	area->nr_pages = vm_area_alloc_pages(gfp_mask, node,
> -		page_order, nr_small_pages, area->pages);
> +	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> +		node, page_order, nr_small_pages, area->pages);
>  
>  	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
>  
> @@ -2961,7 +2960,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	 * allocation request, free them via __vfree() if any.
>  	 */
>  	if (area->nr_pages != nr_small_pages) {
> -		warn_alloc(orig_gfp_mask, NULL,
> +		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, page order %u, failed to allocate pages",
>  			area->nr_pages * PAGE_SIZE, page_order);
>  		goto fail;
> @@ -2969,7 +2968,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  
>  	if (vmap_pages_range(addr, addr + size, prot, area->pages,
>  			page_shift) < 0) {
> -		warn_alloc(orig_gfp_mask, NULL,
> +		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to map pages",
>  			area->nr_pages * PAGE_SIZE);
>  		goto fail;
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
