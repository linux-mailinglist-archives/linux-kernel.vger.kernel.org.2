Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B534DDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhC3CK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:10:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15095 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhC3CKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:10:18 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8Xsd1l1Dz17PBQ;
        Tue, 30 Mar 2021 10:08:05 +0800 (CST)
Received: from [10.174.179.86] (10.174.179.86) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 10:10:03 +0800
Subject: Re: [PATCH v2 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210329232402.575396-1-mike.kravetz@oracle.com>
 <20210329232402.575396-6-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <efeb775e-57f1-5f5c-a23a-9a4309948995@huawei.com>
Date:   Tue, 30 Mar 2021 10:10:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210329232402.575396-6-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/30 7:23, Mike Kravetz wrote:
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
> Acked-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Looks good to me. Thanks!
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/hugetlb.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 16beabbbbe49..dec7bd0dc63d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1451,16 +1451,18 @@ static void __free_huge_page(struct page *page)
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
> @@ -1741,7 +1743,13 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
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
> @@ -1810,8 +1818,9 @@ int dissolve_free_huge_page(struct page *page)
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
> @@ -2674,22 +2683,35 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
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
> +	INIT_LIST_HEAD(&page_list);
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
> 

