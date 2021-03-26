Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745B1349F60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhCZCLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:11:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14478 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhCZCLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:11:13 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F654b0454zyNQN;
        Fri, 26 Mar 2021 10:09:03 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 10:10:58 +0800
Subject: Re: [PATCH 4/8] hugetlb: create remove_hugetlb_page() to separate
 functionality
To:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        "Hillf Danton" <hdanton@sina.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-5-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ee3d6134-068b-8f21-31d6-4d13ef417ae1@huawei.com>
Date:   Fri, 26 Mar 2021 10:10:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210325002835.216118-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/25 8:28, Mike Kravetz wrote:
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
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
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

It seems HPageFreed and HPageTemporary is cleared. Which hugetlb specific page flags
is reserverd here and why? Could you please give a simple example to clarify
this in the comment to help understand this NOTE?

The code looks good to me. Many thanks!
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

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
> 

