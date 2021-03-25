Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5711348E56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCYKtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:49:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhCYKtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616669360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QdxzzroCgUOdRL70W7p4VSDcvj9eC8PKxqMJmtZ9YM=;
        b=ewtSMh5646bY3cviDnJwEibtlRxYaOdua4iAN205UTjSY2vKhRHPVBeJE1xAB8t0+NjVlC
        tGs6tMrBV7hHZKDL3xJUpbCQnlV9qZ64xQVCPv+i4qqyqaw1LZqMRvFZvPUqMmkYigo1TH
        qZu9rE4YdV8RZt8Hj6z9iBxV/+MU4WM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C54FAC3C;
        Thu, 25 Mar 2021 10:49:20 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:49:19 +0100
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
Subject: Re: [PATCH 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
Message-ID: <YFxqr0igkFldyFdv@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 17:28:31, Mike Kravetz wrote:
> The new remove_hugetlb_page() routine is designed to remove a hugetlb
> page from hugetlbfs processing.  It will remove the page from the active
> or free list, update global counters and set the compound page
> destructor to NULL so that PageHuge() will return false for the 'page'.
> After this call, the 'page' can be treated as a normal compound page or
> a collection of base size pages.
> 
> remove_hugetlb_page is to be called with the hugetlb_lock held.
> 
> Creating this routine and separating functionality is in preparation for
> restructuring code to reduce lock hold times.

Call out that this is not intended to introduce any functional change.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/hugetlb.c | 70 +++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 45 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 404b0b1c5258..3938ec086b5c 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1327,6 +1327,46 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> +/*
> + * Remove hugetlb page from lists, and update dtor so that page appears
> + * as just a compound page.  A reference is held on the page.
> + * NOTE: hugetlb specific page flags stored in page->private are not
> + *	 automatically cleared.  These flags may be used in routines
> + *	 which operate on the resulting compound page.
> + *
> + * Must be called with hugetlb lock held.
> + */
> +static void remove_hugetlb_page(struct hstate *h, struct page *page,
> +							bool adjust_surplus)
> +{
> +	int nid = page_to_nid(page);
> +
> +	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +		return;
> +
> +	list_del(&page->lru);
> +
> +	if (HPageFreed(page)) {
> +		h->free_huge_pages--;
> +		h->free_huge_pages_node[nid]--;
> +		ClearHPageFreed(page);
> +	}
> +	if (adjust_surplus) {
> +		h->surplus_huge_pages--;
> +		h->surplus_huge_pages_node[nid]--;
> +	}
> +
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> +	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> +
> +	ClearHPageTemporary(page);
> +	set_page_refcounted(page);
> +	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> +
> +	h->nr_huge_pages--;
> +	h->nr_huge_pages_node[nid]--;
> +}
> +
>  static void update_and_free_page(struct hstate *h, struct page *page)
>  {
>  	int i;
> @@ -1335,8 +1375,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> -	h->nr_huge_pages--;
> -	h->nr_huge_pages_node[page_to_nid(page)]--;
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1344,10 +1382,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  				1 << PG_active | 1 << PG_private |
>  				1 << PG_writeback);
>  	}
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page), page);
> -	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page_rsvd(page), page);
> -	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
> -	set_page_refcounted(page);
>  	if (hstate_is_gigantic(h)) {
>  		destroy_compound_gigantic_page(page, huge_page_order(h));
>  		free_gigantic_page(page, huge_page_order(h));
> @@ -1415,15 +1449,12 @@ static void __free_huge_page(struct page *page)
>  		h->resv_huge_pages++;
>  
>  	if (HPageTemporary(page)) {
> -		list_del(&page->lru);
> -		ClearHPageTemporary(page);
> +		remove_hugetlb_page(h, page, false);
>  		update_and_free_page(h, page);
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
> -		list_del(&page->lru);
> +		remove_hugetlb_page(h, page, true);
>  		update_and_free_page(h, page);
> -		h->surplus_huge_pages--;
> -		h->surplus_huge_pages_node[nid]--;
>  	} else {
>  		arch_clear_hugepage_flags(page);
>  		enqueue_huge_page(h, page);
> @@ -1708,13 +1739,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  			struct page *page =
>  				list_entry(h->hugepage_freelists[node].next,
>  					  struct page, lru);
> -			list_del(&page->lru);
> -			h->free_huge_pages--;
> -			h->free_huge_pages_node[node]--;
> -			if (acct_surplus) {
> -				h->surplus_huge_pages--;
> -				h->surplus_huge_pages_node[node]--;
> -			}
> +			remove_hugetlb_page(h, page, acct_surplus);
>  			update_and_free_page(h, page);
>  			ret = 1;
>  			break;
> @@ -1752,7 +1777,6 @@ int dissolve_free_huge_page(struct page *page)
>  	if (!page_count(page)) {
>  		struct page *head = compound_head(page);
>  		struct hstate *h = page_hstate(head);
> -		int nid = page_to_nid(head);
>  		if (h->free_huge_pages - h->resv_huge_pages == 0)
>  			goto out;
>  
> @@ -1783,9 +1807,7 @@ int dissolve_free_huge_page(struct page *page)
>  			SetPageHWPoison(page);
>  			ClearPageHWPoison(head);
>  		}
> -		list_del(&head->lru);
> -		h->free_huge_pages--;
> -		h->free_huge_pages_node[nid]--;
> +		remove_hugetlb_page(h, page, false);
>  		h->max_huge_pages--;
>  		update_and_free_page(h, head);
>  		rc = 0;
> @@ -2553,10 +2575,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  				return;
>  			if (PageHighMem(page))
>  				continue;
> -			list_del(&page->lru);
> +			remove_hugetlb_page(h, page, false);
>  			update_and_free_page(h, page);
> -			h->free_huge_pages--;
> -			h->free_huge_pages_node[page_to_nid(page)]--;
>  		}
>  	}
>  }
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
