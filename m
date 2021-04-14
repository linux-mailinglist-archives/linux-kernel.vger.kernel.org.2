Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4C435F986
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbhDNRLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:11:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233673AbhDNRLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:11:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBDBBB0DA;
        Wed, 14 Apr 2021 17:10:44 +0000 (UTC)
Subject: Re: [PATCH 06/11] mm/page_alloc: Reduce duration that IRQs are
 disabled for VM counters
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20210414133931.4555-1-mgorman@techsingularity.net>
 <20210414133931.4555-7-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d976abae-9d3f-4c79-64a7-8802552202fe@suse.cz>
Date:   Wed, 14 Apr 2021 19:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-7-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> IRQs are left disabled for the zone and node VM event counters. This is
> unnecessary as the affected counters are allowed to race for preemmption
> and IRQs.
> 
> This patch reduces the scope of IRQs being disabled
> via local_[lock|unlock]_irq on !PREEMPT_RT kernels. One
> __mod_zone_freepage_state is still called with IRQs disabled. While this
> could be moved out, it's not free on all architectures as some require
> IRQs to be disabled for mod_zone_page_state on !PREEMPT_RT kernels.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Nice!
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cff0f1c98b28..295624fe293b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3474,11 +3474,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
>  	pcp = this_cpu_ptr(zone->per_cpu_pageset);
>  	list = &pcp->lists[migratetype];
>  	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
> +	local_unlock_irqrestore(&pagesets.lock, flags);
>  	if (page) {
>  		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
>  		zone_statistics(preferred_zone, zone, 1);
>  	}
> -	local_unlock_irqrestore(&pagesets.lock, flags);
>  	return page;
>  }
>  
> @@ -3530,15 +3530,15 @@ struct page *rmqueue(struct zone *preferred_zone,
>  		if (!page)
>  			page = __rmqueue(zone, order, migratetype, alloc_flags);
>  	} while (page && check_new_pages(page, order));
> -	spin_unlock(&zone->lock);
>  	if (!page)
>  		goto failed;
> +
>  	__mod_zone_freepage_state(zone, -(1 << order),
>  				  get_pcppage_migratetype(page));
> +	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
>  	zone_statistics(preferred_zone, zone, 1);
> -	local_irq_restore(flags);
>  
>  out:
>  	/* Separate test+clear to avoid unnecessary atomics */
> @@ -3551,7 +3551,7 @@ struct page *rmqueue(struct zone *preferred_zone,
>  	return page;
>  
>  failed:
> -	local_irq_restore(flags);
> +	spin_unlock_irqrestore(&zone->lock, flags);
>  	return NULL;
>  }
>  
> @@ -5103,11 +5103,11 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>  		nr_populated++;
>  	}
>  
> +	local_unlock_irqrestore(&pagesets.lock, flags);
> +
>  	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>  	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
>  
> -	local_unlock_irqrestore(&pagesets.lock, flags);
> -
>  	return nr_populated;
>  
>  failed_irq:
> 

