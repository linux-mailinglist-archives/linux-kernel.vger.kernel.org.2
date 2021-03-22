Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8699B3446BD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhCVOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:08:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhCVOHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:07:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616422067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CvcYWkfFq9PJh9O1Ss2tX6oEUxfsWFJNOcab7Fz4Fvc=;
        b=b8uYwC9diI01M+DXE8nWtbMoFcgWQzEns9qXcBZVMvHeX1VhoEtIyMk2q0jSuV/HnPnVuV
        Rvgw8otzZD6FbVX2TLQH8StF/vmE4DJ2W0M0DcuKB7Wvij30T5mT9X2Dt1GbdE9RuE6N1p
        TFn1g53iiGJwcseVFMoR3ihB6ucg1Lg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 821B6AC1F;
        Mon, 22 Mar 2021 14:07:47 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:07:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/8] hugetlb: recompute min_count when dropping
 hugetlb_lock
Message-ID: <YFikrdN6DHQSEm6a@dhcp22.suse.cz>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319224209.150047-3-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-03-21 15:42:03, Mike Kravetz wrote:
> The routine set_max_huge_pages reduces the number of hugetlb_pages,
> by calling free_pool_huge_page in a loop.  It does this as long as
> persistent_huge_pages() is above a calculated min_count value.
> However, this loop can conditionally drop hugetlb_lock and in some
> circumstances free_pool_huge_page can drop hugetlb_lock.  If the
> lock is dropped, counters could change the calculated min_count
> value may no longer be valid.

OK, this one looks like a real bug fix introduced by 55f67141a8927.
Unless I am missing something we could release pages which are reserved
already.
 
> The routine try_to_free_low has the same issue.
> 
> Recalculate min_count in each loop iteration as hugetlb_lock may have
> been dropped.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d5be25f910e8..c537274c2a38 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2521,11 +2521,20 @@ static void __init report_hugepages(void)
>  	}
>  }
>  
> +static inline unsigned long min_hp_count(struct hstate *h, unsigned long count)
> +{
> +	unsigned long min_count;
> +
> +	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
> +	return max(count, min_count);

Just out of curiousity, is compiler allowed to inline this piece of code
and then cache the value? In other words do we need to make these
READ_ONCE or otherwise enforce the no-caching behavior?

> +}
> +
>  #ifdef CONFIG_HIGHMEM
>  static void try_to_free_low(struct hstate *h, unsigned long count,
>  						nodemask_t *nodes_allowed)
>  {
>  	int i;
> +	unsigned long min_count = min_hp_count(h, count);
>  
>  	if (hstate_is_gigantic(h))
>  		return;
> @@ -2534,7 +2543,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  		struct page *page, *next;
>  		struct list_head *freel = &h->hugepage_freelists[i];
>  		list_for_each_entry_safe(page, next, freel, lru) {
> -			if (count >= h->nr_huge_pages)
> +			if (min_count >= h->nr_huge_pages)
>  				return;
>  			if (PageHighMem(page))
>  				continue;
> @@ -2542,6 +2551,12 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  			update_and_free_page(h, page);
>  			h->free_huge_pages--;
>  			h->free_huge_pages_node[page_to_nid(page)]--;
> +
> +			/*
> +			 * update_and_free_page could have dropped lock so
> +			 * recompute min_count.
> +			 */
> +			min_count = min_hp_count(h, count);
>  		}
>  	}
>  }
> @@ -2695,13 +2710,15 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	 * and won't grow the pool anywhere else. Not until one of the
>  	 * sysctls are changed, or the surplus pages go out of use.
>  	 */
> -	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
> -	min_count = max(count, min_count);
> -	try_to_free_low(h, min_count, nodes_allowed);
> +	min_count = min_hp_count(h, count);
> +	try_to_free_low(h, count, nodes_allowed);
>  	while (min_count < persistent_huge_pages(h)) {
>  		if (!free_pool_huge_page(h, nodes_allowed, 0))
>  			break;
>  		cond_resched_lock(&hugetlb_lock);
> +
> +		/* Recompute min_count in case hugetlb_lock was dropped */
> +		min_count = min_hp_count(h, count);
>  	}
>  	while (count < persistent_huge_pages(h)) {
>  		if (!adjust_pool_surplus(h, nodes_allowed, 1))
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
