Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B1B3A4B2C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 01:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFKXZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 19:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhFKXZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 19:25:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B560A611B0;
        Fri, 11 Jun 2021 23:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623453812;
        bh=XOEMUfV+WcQDf35lku9MLHKhHAejd6xTD1D2y888KPc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lFLO/9Gsx859HAXaCCzSLD8Gw3QzamYRBaEPq/TiuZhWk9BD5Dzso8RXEz6k4LZoM
         QihxTbK4XrEAxlqeQc9I+uC62BiuMNYcEX8/POQ9svXYqKYqJQVxuB7O5W9aGGFepR
         6R9igfkDOjyisiN9kHsF0+h+4Lc9AsUsj4MspD/I=
Date:   Fri, 11 Jun 2021 16:23:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm/page_alloc: Allow high-order pages to be stored
 on the per-cpu lists
Message-Id: <20210611162331.272f67eabffa491fc83798b4@linux-foundation.org>
In-Reply-To: <20210611135753.GC30378@techsingularity.net>
References: <20210611135753.GC30378@techsingularity.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 14:57:53 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> Changelog since v1
> o Fix boot problem on KVM with hotplug memory nodes (ziy)
> o Correct PCP list lookup in bulk page allocator
> 
> The per-cpu page allocator (PCP) only stores order-0 pages. This means
> that all THP and "cheap" high-order allocations including SLUB contends
> on the zone->lock. This patch extends the PCP allocator to store THP and
> "cheap" high-order pages. Note that struct per_cpu_pages increases in
> size to 256 bytes (4 cache lines) on x86-64.
> 
> Note that this is not necessarily a universal performance win because of
> how it is implemented. High-order pages can cause pcp->high to be exceeded
> prematurely for lower-orders so for example, a large number of THP pages
> being freed could release order-0 pages from the PCP lists. Hence, much
> depends on the allocation/free pattern as observed by a single CPU to
> determine if caching helps or hurts a particular workload.
> 
> That said, basic performance testing passed. The following is a netperf
> UDP_STREAM test which hits the relevant patches as some of the network
> allocations are high-order.
> 
> netperf-udp
>                                  5.13.0-rc2             5.13.0-rc2
>                            mm-pcpburst-v3r4   mm-pcphighorder-v1r7
> Hmean     send-64         261.46 (   0.00%)      266.30 *   1.85%*
> Hmean     send-128        516.35 (   0.00%)      536.78 *   3.96%*
> Hmean     send-256       1014.13 (   0.00%)     1034.63 *   2.02%*
> Hmean     send-1024      3907.65 (   0.00%)     4046.11 *   3.54%*
> Hmean     send-2048      7492.93 (   0.00%)     7754.85 *   3.50%*
> Hmean     send-3312     11410.04 (   0.00%)    11772.32 *   3.18%*
> Hmean     send-4096     13521.95 (   0.00%)    13912.34 *   2.89%*
> Hmean     send-8192     21660.50 (   0.00%)    22730.72 *   4.94%*
> Hmean     send-16384    31902.32 (   0.00%)    32637.50 *   2.30%*
> 
> >From a functional point of view, a patch like this is necessary to
> make bulk allocation of high-order pages work with similar performance
> to order-0 bulk allocations. The bulk allocator is not updated in this
> series as it would have to be determined by bulk allocation users how
> they want to track the order of pages allocated with the bulk allocator.
> 
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -198,7 +198,7 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
>  extern int user_min_free_kbytes;
>  
> -extern void free_unref_page(struct page *page);
> +extern void free_unref_page(struct page *page, unsigned int order);
>  extern void free_unref_page_list(struct list_head *list);
>  
>  extern void zone_pcp_update(struct zone *zone, int cpu_online);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f24f509c3ee3..8472bae567f0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -676,10 +676,53 @@ static void bad_page(struct page *page, const char *reason)
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
>  
> +static inline unsigned int order_to_pindex(int migratetype, int order)
> +{
> +	int base = order;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> +		VM_BUG_ON(order != pageblock_order);
> +		base = PAGE_ALLOC_COSTLY_ORDER + 1;
> +	}
> +#else
> +	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> +#endif
> +
> +	return (MIGRATE_PCPTYPES * base) + migratetype;
> +}
> +
> +static inline int pindex_to_order(unsigned int pindex)
> +{
> +	int order = pindex / MIGRATE_PCPTYPES;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> +		order = pageblock_order;
> +		VM_BUG_ON(order != pageblock_order);

Somebody has trust issues?

> +	}
> +#else
> +	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> +#endif
> +
> +	return order;
> +}

Do we really need all these assertions, long-term?


