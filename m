Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC8338D050
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhEUVyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:54:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:38663 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhEUVyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:54:04 -0400
IronPort-SDR: Uztdzq2D/SPLu2rXXqyMVzgEfnlAP4Qm5wjEcGO10lDYFMsdWrwsvFk9a2Ix5c5eDg1DOGOTtr
 Pmmr3X90o21g==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="198497400"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="198497400"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 14:52:40 -0700
IronPort-SDR: bgdQcUbvfsZiNpIBGMqZy6pcr0L3WBePzqj/o9s1GB0guGiI3/nF7oE3dgH5IYOmnJxwAeMFnI
 CX/LNDq0qwRA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="613395099"
Received: from pburton-mobl.amr.corp.intel.com (HELO [10.209.36.169]) ([10.209.36.169])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 14:52:39 -0700
Subject: Re: [PATCH 2/6] mm/page_alloc: Disassociate the pcp->high from
 pcp->batch
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210521102826.28552-1-mgorman@techsingularity.net>
 <20210521102826.28552-3-mgorman@techsingularity.net>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <83ddf311-cdfb-34cf-d08f-70590420beff@intel.com>
Date:   Fri, 21 May 2021 14:52:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210521102826.28552-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 3:28 AM, Mel Gorman wrote:
> Note that in this patch the pcp->high values are adjusted after memory
> hotplug events, min_free_kbytes adjustments and watermark scale factor
> adjustments but not CPU hotplug events.

Not that it was a long wait to figure it out, but I'd probably say:

	"CPU hotplug events are handled later in the series".

instead of just saying they're not handled.

> Before grep -E "high:|batch" /proc/zoneinfo | tail -2
>               high:  378
>               batch: 63
> 
> After grep -E "high:|batch" /proc/zoneinfo | tail -2
>               high:  649
>               batch: 63

You noted the relationship between pcp->high and zone lock contention.
Larger ->high values mean less contention.  It's probably also worth
noting the trend of having more logical CPUs per NUMA node.

I have the feeling when this was put in place it wasn't uncommon to have
somewhere between 1 and 8 CPUs in a node pounding on a zone.

Today, having ~60 is common.  I've occasionally resorted to recommending
that folks enable hardware features like Sub-NUMA-Clustering [1] since
it increases the number of zones and decreases the number of CPUs
pounding on each zone lock.

1.
https://software.intel.com/content/www/us/en/develop/articles/intel-xeon-processor-scalable-family-technical-overview.html

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a48f305f0381..bf5cdc466e6c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2163,14 +2163,6 @@ void __init page_alloc_init_late(void)
>  	/* Block until all are initialised */
>  	wait_for_completion(&pgdat_init_all_done_comp);
>  
> -	/*
> -	 * The number of managed pages has changed due to the initialisation
> -	 * so the pcpu batch and high limits needs to be updated or the limits
> -	 * will be artificially small.
> -	 */
> -	for_each_populated_zone(zone)
> -		zone_pcp_update(zone);
> -
>  	/*
>  	 * We initialized the rest of the deferred pages.  Permanently disable
>  	 * on-demand struct page initialization.
> @@ -6594,13 +6586,12 @@ static int zone_batchsize(struct zone *zone)
>  	int batch;
>  
>  	/*
> -	 * The per-cpu-pages pools are set to around 1000th of the
> -	 * size of the zone.
> +	 * The number of pages to batch allocate is either 0.1%

Probably worth making that "~0.1%" just in case someone goes looking for
the /1000 and can't find it.

> +	 * of the zone or 1MB, whichever is smaller. The batch
> +	 * size is striking a balance between allocation latency
> +	 * and zone lock contention.
>  	 */
> -	batch = zone_managed_pages(zone) / 1024;
> -	/* But no more than a meg. */
> -	if (batch * PAGE_SIZE > 1024 * 1024)
> -		batch = (1024 * 1024) / PAGE_SIZE;
> +	batch = min(zone_managed_pages(zone) >> 10, (1024 * 1024) / PAGE_SIZE);
>  	batch /= 4;		/* We effectively *= 4 below */
>  	if (batch < 1)
>  		batch = 1;
> @@ -6637,6 +6628,27 @@ static int zone_batchsize(struct zone *zone)
>  #endif
>  }
>  
> +static int zone_highsize(struct zone *zone)
> +{
> +#ifdef CONFIG_MMU
> +	int high;
> +	int nr_local_cpus;
> +
> +	/*
> +	 * The high value of the pcp is based on the zone low watermark
> +	 * when reclaim is potentially active spread across the online
> +	 * CPUs local to a zone. Note that early in boot that CPUs may
> +	 * not be online yet.
> +	 */

FWIW, I like the way the changelog talked about this a bit better, with
the goal of avoiding background reclaim even in the face of a bunch of
full pcp's.

> +	nr_local_cpus = max(1U, cpumask_weight(cpumask_of_node(zone_to_nid(zone))));
> +	high = low_wmark_pages(zone) / nr_local_cpus;

I'm a little concerned that this might get out of hand on really big
nodes with no CPUs.  For persistent memory (which we *do* toss into the
page allocator for volatile use), we can have multi-terabyte zones with
no CPUs in the node.

Also, while the CPUs which are on the node are the ones *most* likely to
be hitting the ->high limit, we do *keep* a pcp for each possible CPU.
So, the amount of memory which can actually be sequestered is
num_online_cpus()*high.  Right?

*That* might really get out of hand if we have nr_local_cpus=1.

We might want some overall cap on 'high', or even to scale it
differently for the zone-local cpus' pcps versus remote.
