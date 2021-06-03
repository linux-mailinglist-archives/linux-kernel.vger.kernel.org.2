Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE769399F95
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFCLN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 07:13:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52212 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCLNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 07:13:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 989F8219E1;
        Thu,  3 Jun 2021 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622718730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4ZskNxQ9y+RiSznyOdkCdxyjrEB/a0TRKXij9AXSi4=;
        b=ODPi3x2Yw+sMVmQT5Bp6tdDxhR2CLEG0rEYU9u3suJ5aTZ9Q/3Ef57LU4fdXCQ6KIUxcFe
        sM+4EPnepYVYQcmJS85nfHNPsVfQ8xoXC2L0S80YR5nRntr9uZ4DDU+f06fw6rDKPqoUDv
        IaothmZZwSUqq3cCkCOb8yQWYURtTtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622718730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4ZskNxQ9y+RiSznyOdkCdxyjrEB/a0TRKXij9AXSi4=;
        b=NaY8RN8INnUyDTf+KAVux/K/mBbK33HLhFAeeLMXnD2qf6koVKVx2QDQHaVakLlfwd0c1S
        t0aeUvWCYd3OMgCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7D877118DD;
        Thu,  3 Jun 2021 11:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622718730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4ZskNxQ9y+RiSznyOdkCdxyjrEB/a0TRKXij9AXSi4=;
        b=ODPi3x2Yw+sMVmQT5Bp6tdDxhR2CLEG0rEYU9u3suJ5aTZ9Q/3Ef57LU4fdXCQ6KIUxcFe
        sM+4EPnepYVYQcmJS85nfHNPsVfQ8xoXC2L0S80YR5nRntr9uZ4DDU+f06fw6rDKPqoUDv
        IaothmZZwSUqq3cCkCOb8yQWYURtTtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622718730;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4ZskNxQ9y+RiSznyOdkCdxyjrEB/a0TRKXij9AXSi4=;
        b=NaY8RN8INnUyDTf+KAVux/K/mBbK33HLhFAeeLMXnD2qf6koVKVx2QDQHaVakLlfwd0c1S
        t0aeUvWCYd3OMgCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id qN0YHgq5uGB/cwAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 03 Jun 2021 11:12:10 +0000
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210603084621.24109-1-mgorman@techsingularity.net>
 <20210603084621.24109-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm/page_alloc: Allow high-order pages to be stored on
 the per-cpu lists
Message-ID: <1c15b083-26f8-4473-80e6-bcc2f549ba41@suse.cz>
Date:   Thu, 3 Jun 2021 13:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603084621.24109-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 10:46 AM, Mel Gorman wrote:
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
> From a functional point of view, a patch like this is necessary to
> make bulk allocation of high-order pages work with similar performance
> to order-0 bulk allocations. The bulk allocator is not updated in this
> series as it would have to be determined by bulk allocation users how
> they want to track the order of pages allocated with the bulk allocator.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Some comments below.

> ---
>  include/linux/mmzone.h |  20 +++++-
>  mm/internal.h          |   2 +-
>  mm/page_alloc.c        | 159 +++++++++++++++++++++++++++++------------
>  mm/swap.c              |   2 +-
>  4 files changed, 135 insertions(+), 48 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0ed61f32d898..1ceaa5f44db6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -333,6 +333,24 @@ enum zone_watermarks {
>  	NR_WMARK
>  };
>  
> +/*
> + * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER plus one additional
> + * for pageblock size for THP if configured.
> + */
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define NR_PCP_THP 1
> +#else
> +#define NR_PCP_THP 0
> +#endif
> +#define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP))
> +
> +/*
> + * Shift to encode migratetype in order in the least significant bits and
> + * migratetype in the higher bits.

Hard for me to understand that comment. I would describe what the code does as
e,g, "Shift to encode migratetype and order in the same integer, with order in
the least significant bit ..." etc.

> + */
> +#define NR_PCP_ORDER_SHIFT 8

Also ORDER_SHIFT is a bit misnomer, it's more precisely an ORDER_WIDTH, and we
are shifting migratetype with it, not order. I'm just comparing with how we name
nid/zid/etc bits in page flags.

> +#define NR_PCP_ORDER_MASK ((1<<NR_PCP_ORDER_SHIFT) - 1)
> +
>  #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
>  #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
>  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
> @@ -349,7 +367,7 @@ struct per_cpu_pages {
>  #endif
>  
>  	/* Lists of pages, one per migrate type stored on the pcp-lists */
> -	struct list_head lists[MIGRATE_PCPTYPES];
> +	struct list_head lists[NR_PCP_LISTS];
>  };
>  
>  struct per_cpu_zonestat {
> diff --git a/mm/internal.h b/mm/internal.h
> index 8fd61e344966..4f5c22dd8987 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -203,7 +203,7 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
>  extern int user_min_free_kbytes;
>  
> -extern void free_unref_page(struct page *page);
> +extern void free_unref_page(struct page *page, unsigned int order);
>  extern void free_unref_page_list(struct list_head *list);
>  
>  extern void zone_pcp_update(struct zone *zone, int cpu_online);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 99ddac0ffece..ffd2d07060eb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -687,10 +687,53 @@ static void bad_page(struct page *page, const char *reason)
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
> +	int order = pindex / PAGE_ALLOC_COSTLY_ORDER;

This seems wrong, shouldn't we divide by MIGRATE_PCPTYPES?
It just happens to be the same number, so testing won't flag this.



