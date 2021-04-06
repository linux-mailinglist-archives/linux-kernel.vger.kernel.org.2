Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A790355595
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhDFNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238412AbhDFNpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:45:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C1A1EB1AB;
        Tue,  6 Apr 2021 13:44:57 +0000 (UTC)
Date:   Tue, 6 Apr 2021 15:44:54 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
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
Subject: Re: [PATCH v4 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
Message-ID: <YGxl1iRg1F9DCwfG@localhost.localdomain>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-5-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-5-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:00:39PM -0700, Mike Kravetz wrote:
> The new remove_hugetlb_page() routine is designed to remove a hugetlb
> page from hugetlbfs processing.  It will remove the page from the active
> or free list, update global counters and set the compound page
> destructor to NULL so that PageHuge() will return false for the 'page'.
> After this call, the 'page' can be treated as a normal compound page or
> a collection of base size pages.
> 
> update_and_free_page no longer decrements h->nr_huge_pages{_node} as
> this is performed in remove_hugetlb_page.  The only functionality
> performed by update_and_free_page is to free the base pages to the lower
> level allocators.
> 
> update_and_free_page is typically called after remove_hugetlb_page.
> 
> remove_hugetlb_page is to be called with the hugetlb_lock held.
> 
> Creating this routine and separating functionality is in preparation for
> restructuring code to reduce lock hold times.  This commit should not
> introduce any changes to functionality.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Btw, it seems you were just doing fine before realizing that my series
went in.
So, as this seems a rather urgent matter to move forward (for obvious
reasons and also because it holds hotplug-vmemmap stuff), I wonder if
it would make your life easier to just ask Andrew to remove my series
for the time being and give it yours priority.

I can later work on top of that.

> ---
>  mm/hugetlb.c | 88 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8497a3598c86..df2a3d1f632b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1055,18 +1055,13 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  	return false;
>  }
>  
> -static void __enqueue_huge_page(struct list_head *list, struct page *page)
> -{
> -	list_move(&page->lru, list);
> -	SetHPageFreed(page);
> -}
> -
>  static void enqueue_huge_page(struct hstate *h, struct page *page)
>  {
>  	int nid = page_to_nid(page);
> -	__enqueue_huge_page(&h->hugepage_freelists[nid], page);
> +	list_move(&page->lru, &h->hugepage_freelists[nid]);
>  	h->free_huge_pages++;
>  	h->free_huge_pages_node[nid]++;
> +	SetHPageFreed(page);
>  }
>  
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> @@ -1331,6 +1326,43 @@ static inline void destroy_compound_gigantic_page(struct page *page,
>  						unsigned int order) { }
>  #endif
>  
> +/*
> + * Remove hugetlb page from lists, and update dtor so that page appears
> + * as just a compound page.  A reference is held on the page.
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
> @@ -1339,8 +1371,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> -	h->nr_huge_pages--;
> -	h->nr_huge_pages_node[page_to_nid(page)]--;
>  	for (i = 0; i < pages_per_huge_page(h);
>  	     i++, subpage = mem_map_next(subpage, page, i)) {
>  		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
> @@ -1348,10 +1378,6 @@ static void update_and_free_page(struct hstate *h, struct page *page)
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
> @@ -1419,15 +1445,12 @@ static void __free_huge_page(struct page *page)
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
> @@ -1712,13 +1735,7 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
> @@ -1756,7 +1773,6 @@ int dissolve_free_huge_page(struct page *page)
>  	if (!page_count(page)) {
>  		struct page *head = compound_head(page);
>  		struct hstate *h = page_hstate(head);
> -		int nid = page_to_nid(head);
>  		if (h->free_huge_pages - h->resv_huge_pages == 0)
>  			goto out;
>  
> @@ -1787,9 +1803,7 @@ int dissolve_free_huge_page(struct page *page)
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
> @@ -2298,6 +2312,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		/*
>  		 * Freed from under us. Drop new_page too.
>  		 */
> +		remove_hugetlb_page(h, new_page, false);
>  		update_and_free_page(h, new_page);
>  		goto unlock;
>  	} else if (page_count(old_page)) {
> @@ -2305,6 +2320,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		 * Someone has grabbed the page, try to isolate it here.
>  		 * Fail with -EBUSY if not possible.
>  		 */
> +		remove_hugetlb_page(h, new_page, false);
>  		update_and_free_page(h, new_page);
>  		spin_unlock(&hugetlb_lock);
>  		if (!isolate_huge_page(old_page, list))
> @@ -2323,13 +2339,13 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		/*
>  		 * Ok, old_page is still a genuine free hugepage. Replace it
>  		 * with the new one.
> +		 * Note: h->free_huge_pages{_node} counters are decremented
> +		 * in remove_hugetlb_page for old_page and incremented in
> +		 * enqueue_huge_page for new page.  Net result is no change.
>  		 */
> -		list_del(&old_page->lru);
> +		remove_hugetlb_page(h, old_page, false);
>  		update_and_free_page(h, old_page);
> -		/*
> -		 * h->free_huge_pages{_node} counters do not need to be updated.
> -		 */
> -		__enqueue_huge_page(&h->hugepage_freelists[nid], new_page);
> +		enqueue_huge_page(h, new_page);
>  	}
>  unlock:
>  	spin_unlock(&hugetlb_lock);
> @@ -2667,10 +2683,8 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
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
Oscar Salvador
SUSE L3
