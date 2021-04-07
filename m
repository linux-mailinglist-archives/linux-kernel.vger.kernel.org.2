Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB63566CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbhDGI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:28:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240739AbhDGI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:28:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77DE9AFCF;
        Wed,  7 Apr 2021 08:27:53 +0000 (UTC)
Date:   Wed, 7 Apr 2021 10:27:49 +0200
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
Subject: Re: [PATCH v4 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
Message-ID: <20210407082744.GA10058@linux>
References: <20210405230043.182734-1-mike.kravetz@oracle.com>
 <20210405230043.182734-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405230043.182734-6-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 04:00:40PM -0700, Mike Kravetz wrote:
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

Without looking too close at the changes made to alloc_and_dissolve_huge_page():

Reviewed-by: Oscar Salvador <osalvador@suse.de>

One question below:

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

Can we get here with an empty list? Maybe if someone raced with us manipulating
nr_huge_pages? AFAICS, this gets called under the lock, and the adjusting in
remove_hugetlb_page() gets also done under the lock, so I guess this is not
possible to happen.
The reason I am asking is whether we want to check for the list to be empty before
we do the unacquire/acquire lock dancing.


-- 
Oscar Salvador
SUSE L3
