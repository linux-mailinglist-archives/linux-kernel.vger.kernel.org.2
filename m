Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5934E2BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhC3IHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:07:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:59076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231344AbhC3IGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:06:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617091591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q8p2oqXXXu9nUKelMDeKKfZABE1Fca6WUpfu+tzIQ5Y=;
        b=PbgZC5emMG9q6BYX0ZuP9cAdt4KP3J6Jcjgyuxv5O2Q7j+cTxw+XGPOyASW2V61Tfs4WH2
        h+D10xdXsAYtLHiPUtba13nBTtDheJ8CSY4iN9i0njb+vfEgH8w7g9kglosK3+W/SwoBAS
        64gp6/JvDrUne+Pwl+pxOvLu/kXVyXE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C04FAEC2;
        Tue, 30 Mar 2021 08:06:31 +0000 (UTC)
Date:   Tue, 30 Mar 2021 10:06:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>,
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
        Hillf Danton <hdanton@sina.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 6/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
Message-ID: <YGLcBhP1dt2Fuhph@dhcp22.suse.cz>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-7-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329232402.575396-7-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-03-21 16:24:00, Mike Kravetz wrote:
> free_pool_huge_page was called with hugetlb_lock held.  It would remove
> a hugetlb page, and then free the corresponding pages to the lower level
> allocators such as buddy.  free_pool_huge_page was called in a loop to
> remove hugetlb pages and these loops could hold the hugetlb_lock for a
> considerable time.
> 
> Create new routine remove_pool_huge_page to replace free_pool_huge_page.
> remove_pool_huge_page will remove the hugetlb page, and it must be
> called with the hugetlb_lock held.  It will return the removed page and
> it is the responsibility of the caller to free the page to the lower
> level allocators.  The hugetlb_lock is dropped before freeing to these
> allocators which results in shorter lock hold times.
> 
> Add new helper routine to call update_and_free_page for a list of pages.
> 
> Note: Some changes to the routine return_unused_surplus_pages are in
> need of explanation.  Commit e5bbc8a6c992 ("mm/hugetlb.c: fix reservation
> race when freeing surplus pages") modified this routine to address a
> race which could occur when dropping the hugetlb_lock in the loop that
> removes pool pages.  Accounting changes introduced in that commit were
> subtle and took some thought to understand.  This commit removes the
> cond_resched_lock() and the potential race.  Therefore, remove the
> subtle code and restore the more straight forward accounting effectively
> reverting the commit.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Please drop INIT_LIST_HEAD which seems to be a left over from rebasing
to use LIST_HEAD.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/hugetlb.c | 95 +++++++++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dec7bd0dc63d..d3f3cb8766b8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1209,7 +1209,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
>  }
>  
>  /*
> - * helper for free_pool_huge_page() - return the previously saved
> + * helper for remove_pool_huge_page() - return the previously saved
>   * node ["this node"] from which to free a huge page.  Advance the
>   * next node id whether or not we find a free huge page to free so
>   * that the next attempt to free addresses the next node.
> @@ -1391,6 +1391,16 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	}
>  }
>  
> +static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> +{
> +	struct page *page, *t_page;
> +
> +	list_for_each_entry_safe(page, t_page, list, lru) {
> +		update_and_free_page(h, page);
> +		cond_resched();
> +	}
> +}
> +
>  struct hstate *size_to_hstate(unsigned long size)
>  {
>  	struct hstate *h;
> @@ -1721,16 +1731,18 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  }
>  
>  /*
> - * Free huge page from pool from next node to free.
> - * Attempt to keep persistent huge pages more or less
> - * balanced over allowed nodes.
> + * Remove huge page from pool from next node to free.  Attempt to keep
> + * persistent huge pages more or less balanced over allowed nodes.
> + * This routine only 'removes' the hugetlb page.  The caller must make
> + * an additional call to free the page to low level allocators.
>   * Called with hugetlb_lock locked.
>   */
> -static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> -							 bool acct_surplus)
> +static struct page *remove_pool_huge_page(struct hstate *h,
> +						nodemask_t *nodes_allowed,
> +						 bool acct_surplus)
>  {
>  	int nr_nodes, node;
> -	int ret = 0;
> +	struct page *page = NULL;
>  
>  	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
>  		/*
> @@ -1739,23 +1751,14 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  		 */
>  		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
>  		    !list_empty(&h->hugepage_freelists[node])) {
> -			struct page *page =
> -				list_entry(h->hugepage_freelists[node].next,
> +			page = list_entry(h->hugepage_freelists[node].next,
>  					  struct page, lru);
>  			remove_hugetlb_page(h, page, acct_surplus);
> -			/*
> -			 * unlock/lock around update_and_free_page is temporary
> -			 * and will be removed with subsequent patch.
> -			 */
> -			spin_unlock(&hugetlb_lock);
> -			update_and_free_page(h, page);
> -			spin_lock(&hugetlb_lock);
> -			ret = 1;
>  			break;
>  		}
>  	}
>  
> -	return ret;
> +	return page;
>  }
>  
>  /*
> @@ -2075,17 +2078,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>   *    to the associated reservation map.
>   * 2) Free any unused surplus pages that may have been allocated to satisfy
>   *    the reservation.  As many as unused_resv_pages may be freed.
> - *
> - * Called with hugetlb_lock held.  However, the lock could be dropped (and
> - * reacquired) during calls to cond_resched_lock.  Whenever dropping the lock,
> - * we must make sure nobody else can claim pages we are in the process of
> - * freeing.  Do this by ensuring resv_huge_page always is greater than the
> - * number of huge pages we plan to free when dropping the lock.
>   */
>  static void return_unused_surplus_pages(struct hstate *h,
>  					unsigned long unused_resv_pages)
>  {
>  	unsigned long nr_pages;
> +	struct page *page;
> +	LIST_HEAD(page_list);
> +
> +	/* Uncommit the reservation */
> +	h->resv_huge_pages -= unused_resv_pages;
>  
>  	/* Cannot return gigantic pages currently */
>  	if (hstate_is_gigantic(h))
> @@ -2102,24 +2104,22 @@ static void return_unused_surplus_pages(struct hstate *h,
>  	 * evenly across all nodes with memory. Iterate across these nodes
>  	 * until we can no longer free unreserved surplus pages. This occurs
>  	 * when the nodes with surplus pages have no free pages.
> -	 * free_pool_huge_page() will balance the freed pages across the
> +	 * remove_pool_huge_page() will balance the freed pages across the
>  	 * on-line nodes with memory and will handle the hstate accounting.
> -	 *
> -	 * Note that we decrement resv_huge_pages as we free the pages.  If
> -	 * we drop the lock, resv_huge_pages will still be sufficiently large
> -	 * to cover subsequent pages we may free.
>  	 */
> +	INIT_LIST_HEAD(&page_list);
>  	while (nr_pages--) {
> -		h->resv_huge_pages--;
> -		unused_resv_pages--;
> -		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
> +		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
> +		if (!page)
>  			goto out;
> -		cond_resched_lock(&hugetlb_lock);
> +
> +		list_add(&page->lru, &page_list);
>  	}
>  
>  out:
> -	/* Fully uncommit the reservation */
> -	h->resv_huge_pages -= unused_resv_pages;
> +	spin_unlock(&hugetlb_lock);
> +	update_and_free_pages_bulk(h, &page_list);
> +	spin_lock(&hugetlb_lock);
>  }
>  
>  
> @@ -2683,7 +2683,6 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  						nodemask_t *nodes_allowed)
>  {
>  	int i;
> -	struct page *page, *next;
>  	LIST_HEAD(page_list);
>  
>  	if (hstate_is_gigantic(h))
> @@ -2694,6 +2693,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  	 */
>  	INIT_LIST_HEAD(&page_list);
>  	for_each_node_mask(i, *nodes_allowed) {
> +		struct page *page, *next;
>  		struct list_head *freel = &h->hugepage_freelists[i];
>  		list_for_each_entry_safe(page, next, freel, lru) {
>  			if (count >= h->nr_huge_pages)
> @@ -2707,10 +2707,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  
>  out:
>  	spin_unlock(&hugetlb_lock);
> -	list_for_each_entry_safe(page, next, &page_list, lru) {
> -		update_and_free_page(h, page);
> -		cond_resched();
> -	}
> +	update_and_free_pages_bulk(h, &page_list);
>  	spin_lock(&hugetlb_lock);
>  }
>  #else
> @@ -2757,6 +2754,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  			      nodemask_t *nodes_allowed)
>  {
>  	unsigned long min_count, ret;
> +	struct page *page;
> +	LIST_HEAD(page_list);
>  	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
>  
>  	/*
> @@ -2869,11 +2868,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	min_count = h->resv_huge_pages + h->nr_huge_pages - h->free_huge_pages;
>  	min_count = max(count, min_count);
>  	try_to_free_low(h, min_count, nodes_allowed);
> +
> +	/*
> +	 * Collect pages to be removed on list without dropping lock
> +	 */
> +	INIT_LIST_HEAD(&page_list);
>  	while (min_count < persistent_huge_pages(h)) {
> -		if (!free_pool_huge_page(h, nodes_allowed, 0))
> +		page = remove_pool_huge_page(h, nodes_allowed, 0);
> +		if (!page)
>  			break;
> -		cond_resched_lock(&hugetlb_lock);
> +
> +		list_add(&page->lru, &page_list);
>  	}
> +	/* free the pages after dropping lock */
> +	spin_unlock(&hugetlb_lock);
> +	update_and_free_pages_bulk(h, &page_list);
> +	spin_lock(&hugetlb_lock);
> +
>  	while (count < persistent_huge_pages(h)) {
>  		if (!adjust_pool_surplus(h, nodes_allowed, 1))
>  			break;
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
