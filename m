Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B294F348E7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCYLGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:06:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhCYLGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:06:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616670384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wkoiOF43ahZ9DErK2et0KPyZmKWgEdCs4O7A2c26vl0=;
        b=gBHpt56eZwbsQ9bWe8v+weTxpjBLKRgNLwuYbnrT7+WCCtOS1XVGJPu2kolRd9uQ6pnsM4
        TiubaN+Ns9ADjrJ2ViMK0L9cP4I4F8RLlfT92/v7d4fRa9V4fnaCQdeKbhovYuuy6zegum
        wPeyRYjypif6yML0Jjrwc8y5vf5E4Ac=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76CBDAC16;
        Thu, 25 Mar 2021 11:06:24 +0000 (UTC)
Date:   Thu, 25 Mar 2021 12:06:22 +0100
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
Message-ID: <YFxurrhDuZZG1FlQ@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-7-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-7-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 17:28:33, Mike Kravetz wrote:
[...]
> @@ -2074,17 +2067,16 @@ static int gather_surplus_pages(struct hstate *h, long delta)
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
> +	struct page *page, *t_page;
> +	struct list_head page_list;
> +
> +	/* Uncommit the reservation */
> +	h->resv_huge_pages -= unused_resv_pages;

Is this ok for cases where remove_pool_huge_page fails early? I have to
say I am kinda lost in the resv_huge_pages accounting here. The original
code was already quite supicious to me. TBH.
>  
>  	/* Cannot return gigantic pages currently */
>  	if (hstate_is_gigantic(h))
> @@ -2101,24 +2093,27 @@ static void return_unused_surplus_pages(struct hstate *h,
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
> +		INIT_LIST_HEAD(&page->lru);

again unnecessary INIT_LIST_HEAD

> +		list_add(&page->lru, &page_list);
>  	}
>  
>  out:
> -	/* Fully uncommit the reservation */
> -	h->resv_huge_pages -= unused_resv_pages;
> +	spin_unlock(&hugetlb_lock);
> +	list_for_each_entry_safe(page, t_page, &page_list, lru) {
> +		list_del(&page->lru);
> +		update_and_free_page(h, page);
> +		cond_resched();
> +	}

You have the same construct at 3 different places maybe it deserves a
little helper update_and_free_page_batch.

> +	spin_lock(&hugetlb_lock);
>  }
>  
>  
> @@ -2648,6 +2643,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  			      nodemask_t *nodes_allowed)
>  {
>  	unsigned long min_count, ret;
> +	struct page *page, *t_page;
> +	struct list_head page_list;
>  	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
>  
>  	/*
> @@ -2757,11 +2754,28 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
> +		INIT_LIST_HEAD(&page->lru);

INIT_LIST_HEAD again.

> +		list_add(&page->lru, &page_list);
>  	}
> +	/* free the pages after dropping lock */
> +	spin_unlock(&hugetlb_lock);
> +	list_for_each_entry_safe(page, t_page, &page_list, lru) {
> +		list_del(&page->lru);
> +		update_and_free_page(h, page);
> +		cond_resched();
> +	}
> +	spin_lock(&hugetlb_lock);
> +
>  	while (count < persistent_huge_pages(h)) {
>  		if (!adjust_pool_surplus(h, nodes_allowed, 1))
>  			break;
> -- 
> 2.30.2

-- 
Michal Hocko
SUSE Labs
