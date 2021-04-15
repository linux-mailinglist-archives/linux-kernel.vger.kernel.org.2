Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB123609F1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhDONFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:05:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:36774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDONFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:05:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DD2BAF0F;
        Thu, 15 Apr 2021 13:04:39 +0000 (UTC)
Subject: Re: [PATCH 10/11] mm/page_alloc: Update PGFREE outside the zone lock
 in __free_pages_ok
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
 <20210414133931.4555-11-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5fd4ecc7-460d-ae44-2722-8c6ab405a82a@suse.cz>
Date:   Thu, 15 Apr 2021 15:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414133931.4555-11-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 3:39 PM, Mel Gorman wrote:
> VM events do not need explicit protection by disabling IRQs so
> update the counter with IRQs enabled in __free_pages_ok.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a0b210077178..8a94fe77bef7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1569,10 +1569,11 @@ static void __free_pages_ok(struct page *page, unsigned int order,
>  	migratetype = get_pfnblock_migratetype(page, pfn);
>  
>  	spin_lock_irqsave(&zone->lock, flags);
> -	__count_vm_events(PGFREE, 1 << order);
>  	migratetype = check_migratetype_isolated(zone, page, pfn, migratetype);
>  	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
>  	spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	__count_vm_events(PGFREE, 1 << order);
>  }
>  
>  void __free_pages_core(struct page *page, unsigned int order)
> 

