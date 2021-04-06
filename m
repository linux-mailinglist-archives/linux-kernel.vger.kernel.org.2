Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99716355065
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 11:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbhDFJ57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 05:57:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:57782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233842AbhDFJ55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 05:57:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617703068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PrzMnQvTadcMOrBNWUDd7HakkDHKU9nVmDx9/Wi5Qk0=;
        b=W5G/DuRyRImzG7aKBi4/jd627pDCv4Q/QbHMycXee+ZsQhYVJNowiy7SwsMGNQpOnyDzNI
        et8tKP+8IGLr2itDXAUOHSmOsBx6+yqeY9woEhZY9jM6l7gOw1F00aK5nU0ZUdqX4SNGOX
        iFpMnauW6O6Ef9rzzJbsQiWm9pipbLM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1A23B12E;
        Tue,  6 Apr 2021 09:57:48 +0000 (UTC)
Date:   Tue, 6 Apr 2021 11:57:47 +0200
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
Subject: Re: [PATCH v4 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
Message-ID: <YGwwm0EJHfPfpuW8@dhcp22.suse.cz>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-6-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05-04-21 16:00:40, Mike Kravetz wrote:
> With the introduction of remove_hugetlb_page(), there is no need for
> update_and_free_page to hold the hugetlb lock.  Change all callers to
> drop the lock before calling.
> 
> With additional code modifications, this will allow loops which decrease
> the huge page pool to drop the hugetlb_lock with each page to reduce
> long hold times.
> 
> The ugly unlock/lock cycle in free_pool_huge_page will be removed in
> a subsequent patch which restructures free_pool_huge_page.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Still looks good.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/hugetlb.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index df2a3d1f632b..be6031a8e2a9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1446,16 +1446,18 @@ static void __free_huge_page(struct page *page)
>  
>  	if (HPageTemporary(page)) {
>  		remove_hugetlb_page(h, page, false);
> +		spin_unlock(&hugetlb_lock);
>  		update_and_free_page(h, page);
>  	} else if (h->surplus_huge_pages_node[nid]) {
>  		/* remove the page from active list */
>  		remove_hugetlb_page(h, page, true);
> +		spin_unlock(&hugetlb_lock);
>  		update_and_free_page(h, page);
>  	} else {
>  		arch_clear_hugepage_flags(page);
>  		enqueue_huge_page(h, page);
> +		spin_unlock(&hugetlb_lock);
>  	}
> -	spin_unlock(&hugetlb_lock);
>  }
>  
>  /*
> @@ -1736,7 +1738,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
>  				list_entry(h->hugepage_freelists[node].next,
>  					  struct page, lru);
>  			remove_hugetlb_page(h, page, acct_surplus);
> +			/*
> +			 * unlock/lock around update_and_free_page is temporary
> +			 * and will be removed with subsequent patch.
> +			 */
> +			spin_unlock(&hugetlb_lock);
>  			update_and_free_page(h, page);
> +			spin_lock(&hugetlb_lock);
>  			ret = 1;
>  			break;
>  		}
> @@ -1805,8 +1813,9 @@ int dissolve_free_huge_page(struct page *page)
>  		}
>  		remove_hugetlb_page(h, page, false);
>  		h->max_huge_pages--;
> +		spin_unlock(&hugetlb_lock);
>  		update_and_free_page(h, head);
> -		rc = 0;
> +		return 0;
>  	}
>  out:
>  	spin_unlock(&hugetlb_lock);
> @@ -2291,6 +2300,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  	int nid = page_to_nid(old_page);
>  	struct page *new_page;
> +	struct page *page_to_free;
>  	int ret = 0;
>  
>  	/*
> @@ -2313,16 +2323,16 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		 * Freed from under us. Drop new_page too.
>  		 */
>  		remove_hugetlb_page(h, new_page, false);
> -		update_and_free_page(h, new_page);
> -		goto unlock;
> +		page_to_free = new_page;
> +		goto unlock_free;
>  	} else if (page_count(old_page)) {
>  		/*
>  		 * Someone has grabbed the page, try to isolate it here.
>  		 * Fail with -EBUSY if not possible.
>  		 */
>  		remove_hugetlb_page(h, new_page, false);
> -		update_and_free_page(h, new_page);
>  		spin_unlock(&hugetlb_lock);
> +		update_and_free_page(h, new_page);
>  		if (!isolate_huge_page(old_page, list))
>  			ret = -EBUSY;
>  		return ret;
> @@ -2344,11 +2354,12 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		 * enqueue_huge_page for new page.  Net result is no change.
>  		 */
>  		remove_hugetlb_page(h, old_page, false);
> -		update_and_free_page(h, old_page);
>  		enqueue_huge_page(h, new_page);
> +		page_to_free = old_page;
>  	}
> -unlock:
> +unlock_free:
>  	spin_unlock(&hugetlb_lock);
> +	update_and_free_page(h, page_to_free);
>  
>  	return ret;
>  }
> @@ -2671,22 +2682,34 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  						nodemask_t *nodes_allowed)
>  {
>  	int i;
> +	struct page *page, *next;
> +	LIST_HEAD(page_list);
>  
>  	if (hstate_is_gigantic(h))
>  		return;
>  
> +	/*
> +	 * Collect pages to be freed on a list, and free after dropping lock
> +	 */
>  	for_each_node_mask(i, *nodes_allowed) {
> -		struct page *page, *next;
>  		struct list_head *freel = &h->hugepage_freelists[i];
>  		list_for_each_entry_safe(page, next, freel, lru) {
>  			if (count >= h->nr_huge_pages)
> -				return;
> +				goto out;
>  			if (PageHighMem(page))
>  				continue;
>  			remove_hugetlb_page(h, page, false);
> -			update_and_free_page(h, page);
> +			list_add(&page->lru, &page_list);
>  		}
>  	}
> +
> +out:
> +	spin_unlock(&hugetlb_lock);
> +	list_for_each_entry_safe(page, next, &page_list, lru) {
> +		update_and_free_page(h, page);
> +		cond_resched();
> +	}
> +	spin_lock(&hugetlb_lock);
>  }
>  #else
>  static inline void try_to_free_low(struct hstate *h, unsigned long count,
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
