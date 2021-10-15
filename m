Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165BA42FD47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243075AbhJOVPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238548AbhJOVPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:15:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DF8C61151;
        Fri, 15 Oct 2021 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1634332392;
        bh=sBthmh0Ow6dHCAklrKdpkJ5pe7lwapwvnI3whKX5G38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dqD3fJsMDbXeWDkCEAycK1ev1cVrym+ayoatD3KKaj7F0v4EgfQKNUL9lb6MeGeKE
         jQiyCo2ygdaQGrhCMzxe+DmJ5hamOskOmjYFX0QhWRKrHZfc50M2qk642o7fOtgerf
         uMYhD2Sz8DpjjoJUvYFlizP3eIQ2HrjWtv70ZAvc=
Date:   Fri, 15 Oct 2021 14:13:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <shakeelb@google.com>, <npiggin@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <edumazet@google.com>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>
Subject: Re: [PATCH] mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy
 to accelerate memory allocation
Message-Id: <20211015141310.f69c5fbf0eb910ad0a43ebd5@linux-foundation.org>
In-Reply-To: <20211014092952.1500982-1-chenwandun@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
        <20211014092952.1500982-1-chenwandun@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 17:29:52 +0800 Chen Wandun <chenwandun@huawei.com> wrote:

> It will cause significant performance regressions in some situations
> as Andrew mentioned in [1]. The main situation is vmalloc, vmalloc
> will allocate pages with NUMA_NO_NODE by default, that will result
> in alloc page one by one;
> 
> In order to solve this, __alloc_pages_bulk and mempolicy should be
> considered at the same time.
> 
> 1) If node is specified in memory allocation request, it will alloc
> all pages by __alloc_pages_bulk.
> 
> 2) If interleaving allocate memory, it will cauculate how many pages
> should be allocated in each node, and use __alloc_pages_bulk to alloc
> pages in each node.
> 
> [1]: https://lore.kernel.org/lkml/CALvZod4G3SzP3kWxQYn0fj+VgG-G3yWXz=gz17+3N57ru1iajw@mail.gmail.com/t/#m750c8e3231206134293b089feaa090590afa0f60
> 
> ...
>
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -531,6 +531,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  				struct list_head *page_list,
>  				struct page **page_array);
>  
> +unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
> +				unsigned long nr_pages,
> +				struct page **page_array);
> +
>  /* Bulk allocate order-0 pages */
>  static inline unsigned long
>  alloc_pages_bulk_list(gfp_t gfp, unsigned long nr_pages, struct list_head *list)
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 9f8cd1457829..f456c5eb8d10 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2196,6 +2196,82 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
>  }
>  EXPORT_SYMBOL(alloc_pages);
>  
> +unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
> +		struct mempolicy *pol, unsigned long nr_pages,
> +		struct page **page_array)

I'll make this static.

> +{
> +	int nodes;
> +	unsigned long nr_pages_per_node;
> +	int delta;
> +	int i;
> +	unsigned long nr_allocated;
> +	unsigned long total_allocated = 0;
> +
> +	nodes = nodes_weight(pol->nodes);
> +	nr_pages_per_node = nr_pages / nodes;
> +	delta = nr_pages - nodes * nr_pages_per_node;
> +
> +	for (i = 0; i < nodes; i++) {
> +		if (delta) {
> +			nr_allocated = __alloc_pages_bulk(gfp,
> +					interleave_nodes(pol), NULL,
> +					nr_pages_per_node + 1, NULL,
> +					page_array);
> +			delta--;
> +		} else {
> +			nr_allocated = __alloc_pages_bulk(gfp,
> +					interleave_nodes(pol), NULL,
> +					nr_pages_per_node, NULL, page_array);
> +		}
> +
> +		page_array += nr_allocated;
> +		total_allocated += nr_allocated;
> +	}
> +
> +	return total_allocated;
> +}
> +
> +unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
> +		struct mempolicy *pol, unsigned long nr_pages,
> +		struct page **page_array)

And this.

> +{
> +	gfp_t preferred_gfp;
> +	unsigned long nr_allocated = 0;
> +
> +	preferred_gfp = gfp | __GFP_NOWARN;
> +	preferred_gfp &= ~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL);
> +
> +	nr_allocated  = __alloc_pages_bulk(preferred_gfp, nid, &pol->nodes,
> +					   nr_pages, NULL, page_array);
> +
> +	if (nr_allocated < nr_pages)
> +		nr_allocated += __alloc_pages_bulk(gfp, numa_node_id(), NULL,
> +				nr_pages - nr_allocated, NULL,
> +				page_array + nr_allocated);
> +	return nr_allocated;
> +}
> +
> +unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
> +		unsigned long nr_pages, struct page **page_array)
> +{
> +	struct mempolicy *pol = &default_policy;
> +
> +	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
> +		pol = get_task_policy(current);
> +
> +	if (pol->mode == MPOL_INTERLEAVE)
> +		return alloc_pages_bulk_array_interleave(gfp, pol,
> +							 nr_pages, page_array);
> +
> +	if (pol->mode == MPOL_PREFERRED_MANY)
> +		return alloc_pages_bulk_array_preferred_many(gfp,
> +				numa_node_id(), pol, nr_pages, page_array);
> +
> +	return __alloc_pages_bulk(gfp, policy_node(gfp, pol, numa_node_id()),
> +				  policy_nodemask(gfp, pol), nr_pages, NULL,
> +				  page_array);
> +}

Some documentation via code comments would be nice.  If only for
alloc_pages_bulk_array_mempolicy().  Mainly to explain why it exists. 
I suppose the internal functions can be left uncommented if they're
sufficiently obvious?

>  struct folio *folio_alloc(gfp_t gfp, unsigned order)
>  {
>  	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b7ac4a8fe2b3..49adba793f3c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2856,23 +2856,14 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  			 */
>  			nr_pages_request = min(100U, nr_pages - nr_allocated);
>  
> -			if (nid == NUMA_NO_NODE) {
> -				for (i = 0; i < nr_pages_request; i++) {
> -					page = alloc_page(gfp);
> -					if (page)
> -						pages[nr_allocated + i] = page;
> -					else {
> -						nr = i;
> -						break;
> -					}
> -				}
> -				if (i >= nr_pages_request)
> -					nr = nr_pages_request;
> -			} else {
> +			if (nid == NUMA_NO_NODE)
> +				nr = alloc_pages_bulk_array_mempolicy(gfp,
> +							nr_pages_request,
> +							pages + nr_allocated);
> +			else
>  				nr = alloc_pages_bulk_array_node(gfp, nid,
>  							nr_pages_request,
>  							pages + nr_allocated);
> -			}
>  			nr_allocated += nr;
>  			cond_resched();
>  

