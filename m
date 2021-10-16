Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8AD4303B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 18:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhJPQ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbhJPQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 12:29:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB3C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:27:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i24so54827810lfj.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sQ9MmYJBuCFx6xP+hNWvVvbHM5PG9vrczGM888TZF4k=;
        b=lM7N+OqcjWVuhtLlHxInnpbXNDo3y53iymmzurUdoMREFIZ++mDJjhqRhUJiIvhc8u
         CoxXopYWB6ay7Nq5kDGcqJ/9MHbeFP8e7bN4e3PSMkmpYjF99JmBLUNvh6NC4/Xn+qla
         jQX0lOHP/idjHzza6VaebaIRftPiB1xnQWFrDLfx32HidWouwQji4WzpkOb0/HzcQMh1
         tGCM2uFUKsAfaLLhS/QeuuUAwq06J5xd6PnCAvYA/yYW7R9RZtiKqHvJM91Y1wi6NZD7
         vcAEkj5DlHyFEwR2Go6CGuQAE9EQkDVSUonHic1Lhcw1GxxZLeGHrAbzYrBYwmQFu7+z
         WnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sQ9MmYJBuCFx6xP+hNWvVvbHM5PG9vrczGM888TZF4k=;
        b=er/jhP8N+SNe4cMK8z/VdWAj5WvTB2Trvf1dEdFIH7OU5L104ZikYwd2F12aCc9TkD
         7dNZXZ0flo7T/LUj9Zo84zvWb1ogKZHN9KFX63WN8tENEJ5e8KjtPGJ+Cq6XwRp1z7jb
         le0FKgRCYm1/BR24v/G9+ln5V+pdbLwU/JddURnnuQyCDr8tyfdBlRicEsQpahp262UY
         q8KLemMRurawROD3NFz1TAYA3hN8vqYHtIFPKa3badrXhYuiFDCxYfMJjQD6olxumOmZ
         ZD3ivPnzTScO3xPkd96uR3QiE0WMqOUP85Vl5fQqlP8To01VtlarcAPd1TJgPQPJ8xa3
         yBPw==
X-Gm-Message-State: AOAM531KcWxuGkMVJxyv0e92vWF3JZUjrbE3gDX53a35EvtAoE5XGZZk
        GPLaeaVDpvFUFpAYivf4JZk=
X-Google-Smtp-Source: ABdhPJwbhiNxospEeLweYzRGJn/g2oXILwqZCvvwt0eL6ckHy82fEKyeAvrxfR3J/8qm97ohBWXgBA==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr19344897ljg.11.1634401623356;
        Sat, 16 Oct 2021 09:27:03 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m7sm890774lfk.63.2021.10.16.09.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 09:27:02 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 16 Oct 2021 18:27:00 +0200
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, shakeelb@google.com, npiggin@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        edumazet@google.com, wangkefeng.wang@huawei.com,
        guohanjun@huawei.com
Subject: Re: [PATCH] mm/vmalloc: introduce alloc_pages_bulk_array_mempolicy
 to accelerate memory allocation
Message-ID: <20211016162700.GA1914@pc638.lan>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
 <20211014092952.1500982-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014092952.1500982-1-chenwandun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 05:29:52PM +0800, Chen Wandun wrote:
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
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ----------------
> based on "[PATCH] mm/vmalloc: fix numa spreading for large hash tables"
> ---
>  include/linux/gfp.h |  4 +++
>  mm/mempolicy.c      | 76 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/vmalloc.c        | 19 +++---------
>  3 files changed, 85 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 558299cb2970..b976c4177299 100644
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
> +
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
> -- 
> 2.25.1
> 
Now it looks much more correct.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
