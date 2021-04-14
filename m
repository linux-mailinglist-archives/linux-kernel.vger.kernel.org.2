Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0287935F4D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347576AbhDNN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:26:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231370AbhDNNZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:25:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618406735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h8J6j8/YB/RYsAIGiVMUyssVRJiGq/GWCjtsMsXrzbQ=;
        b=gLx95Yv3dc6nXDNJIIknBGI8pb1t80CFfCmwv4Vv3U0TkHUWfBo33nOXuE6aVnKB4RNxQv
        Wc2D/LI//ssKSyIhVmY8mIjJCW74anXBehW6tvyvfw15afAh7t+Y3zr/OGeEm/RteQwTiz
        2TvCYvGnSkwKGqCszpUqKzmihYij2cA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85AE1AEF8;
        Wed, 14 Apr 2021 13:25:35 +0000 (UTC)
Date:   Wed, 14 Apr 2021 15:25:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 11/13] mm/mempolicy: huge-page allocation for many
 preferred
Message-ID: <YHbtTtEfCICx/yME@dhcp22.suse.cz>
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-12-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615952410-36895-12-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please use hugetlb prefix to make it explicit that this is hugetlb
related.

On Wed 17-03-21 11:40:08, Feng Tang wrote:
> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> Implement the missing huge page allocation functionality while obeying
> the preferred node semantics.
> 
> This uses a fallback mechanism to try multiple preferred nodes first,
> and then all other nodes. It cannot use the helper function that was
> introduced because huge page allocation already has its own helpers and
> it was more LOC, and effort to try to consolidate that.
> 
> The weirdness is MPOL_PREFERRED_MANY can't be called yet because it is
> part of the UAPI we haven't yet exposed. Instead of make that define
> global, it's simply changed with the UAPI patch.
> 
> [ feng: add NOWARN flag, and skip the direct reclaim to speedup allocation
>   in some case ]
> 
> Link: https://lore.kernel.org/r/20200630212517.308045-12-ben.widawsky@intel.com
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/hugetlb.c   | 26 +++++++++++++++++++++++---
>  mm/mempolicy.c |  3 ++-
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8fb42c6..9dfbfa3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1105,7 +1105,7 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  				unsigned long address, int avoid_reserve,
>  				long chg)
>  {
> -	struct page *page;
> +	struct page *page = NULL;
>  	struct mempolicy *mpol;
>  	gfp_t gfp_mask;
>  	nodemask_t *nodemask;
> @@ -1126,7 +1126,17 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  
>  	gfp_mask = htlb_alloc_mask(h);
>  	nid = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> -	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> +	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */

Please use MPOL_PREFERRED_MANY explicitly here.

> +		gfp_t gfp_mask1 = gfp_mask | __GFP_NOWARN;
> +
> +		gfp_mask1 &= ~__GFP_DIRECT_RECLAIM;
> +		page = dequeue_huge_page_nodemask(h,
> +				gfp_mask1, nid, nodemask);
> +		if (!page)
> +			page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
> +	} else {
> +		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
> +	}
>  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
>  		SetHPageRestoreReserve(page);
>  		h->resv_huge_pages--;

__GFP_DIRECT_RECLAIM handing is not needed here. dequeue_huge_page_nodemask 
only uses gfp mask to get zone and cpusets constraines. So the above
should have simply been
	if (mpol->mode == MPOL_PREFERRED_MANY) {
		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
		if (page)
			goto got_page;
		/* fallback to all nodes */
		nodemask = NULL;
	}
	page = dequeue_huge_page_nodemask(h, gfp_mask, nid, nodemask);
got_page:
	if (page ...)

> @@ -1883,7 +1893,17 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  	nodemask_t *nodemask;
>  
>  	nid = huge_node(vma, addr, gfp_mask, &mpol, &nodemask);
> -	page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
> +	if (mpol->mode != MPOL_BIND && nodemask) { /* AKA MPOL_PREFERRED_MANY */
> +		gfp_t gfp_mask1 = gfp_mask | __GFP_NOWARN;
> +
> +		gfp_mask1 &= ~__GFP_DIRECT_RECLAIM;
> +		page = alloc_surplus_huge_page(h,
> +				gfp_mask1, nid, nodemask);
> +		if (!page)
> +			alloc_surplus_huge_page(h, gfp_mask, nid, NULL);
> +	} else {
> +		page = alloc_surplus_huge_page(h, gfp_mask, nid, nodemask);
> +	}

And here similar
	if (mpol->mode == MPOL_PREFERRED_MANY) {
		page = alloc_surplus_huge_page(h, (gfp_mask | __GFP_NOWARN) & ~(__GFP_DIRECT_RECLAIM), nodemask);
		if (page)
			goto got_page;
		/* fallback to all nodes */
		nodemask = NULL;
	}
	page = alloc_surplus_huge_page(h, gfp_mask, nodemask);
got_page:
>  	mpol_cond_put(mpol);

You can have a dedicated gfp mask here if you prefer of course but I
calling out MPOL_PREFERRED_MANY explicitly will make the code easier to
read.

>  	return page;
-- 
Michal Hocko
SUSE Labs
