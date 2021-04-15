Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6839360707
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhDOKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:34052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhDOKYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:24:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED0B2ACC4;
        Thu, 15 Apr 2021 10:24:14 +0000 (UTC)
Subject: Re: [PATCH 08/11] mm/page_alloc: Explicitly acquire the zone lock in
 __free_pages_ok
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
 <20210414133931.4555-9-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1f6fbbaa-bd0e-3e04-26d5-d8f6aee6bd1d@suse.cz>
Date:   Thu, 15 Apr 2021 12:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-9-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> __free_pages_ok() disables IRQs before calling a common helper
> free_one_page() that acquires the zone lock. This is not safe according
> to Documentation/locking/locktypes.rst and in this context, IRQ disabling
> is not protecting a per_cpu_pages structure either or a local_lock would
> be used.
> 
> This patch explicitly acquires the lock with spin_lock_irqsave instead of
> relying on a helper. This removes the last instance of local_irq_save()
> in page_alloc.c.

\o/

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1ed370668e7f..6791e9361076 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1559,21 +1559,18 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>  	unsigned long flags;
>  	int migratetype;
>  	unsigned long pfn = page_to_pfn(page);
> +	struct zone *zone = page_zone(page);
>  
>  	if (!free_pages_prepare(page, order, true))
>  		return;
>  
>  	migratetype = get_pfnblock_migratetype(page, pfn);
>  
> -	/*
> -	 * TODO FIX: Disable IRQs before acquiring IRQ-safe zone->lock
> -	 * and protect vmstat updates.
> -	 */
> -	local_irq_save(flags);
> +	spin_lock_irqsave(&zone->lock, flags);
>  	__count_vm_events(PGFREE, 1 << order);
> -	free_one_page(page_zone(page), page, pfn, order, migratetype,
> -		      fpi_flags);
> -	local_irq_restore(flags);
> +	migratetype = check_migratetype_isolated(zone, page, pfn, migratetype);
> +	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
> +	spin_unlock_irqrestore(&zone->lock, flags);
>  }
>  
>  void __free_pages_core(struct page *page, unsigned int order)
> 

