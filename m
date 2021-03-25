Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5460348E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCYKzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:55:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:41532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhCYKzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:55:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616669706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aZbrWvjcrrKg8+bBJwUTS8hNI4fbjg0t3/5rrIErIXY=;
        b=R7rle/gUrBDB+hT/r8WlhU7R33LIYdabqGJM9rgEGy58PSKG6+VG+r9rGraLzv6rA6zwb8
        hD21UcexlOJ7daH4V+Zf9jhR72/Mb6ljS/mdnR24HaPWbKtMoOFGpaWYlGcbWox6q2Yadn
        j4Ocqkrg+re5ztKBn6c/SMuMySHpDXA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99F11AC6A;
        Thu, 25 Mar 2021 10:55:06 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:55:03 +0100
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
Subject: Re: [PATCH 5/8] hugetlb: call update_and_free_page without
 hugetlb_lock
Message-ID: <YFxsB4YLXCobtGGv@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-6-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-6-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 17:28:32, Mike Kravetz wrote:
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

Acked-by: Michal Hocko <mhocko@suse.com>

One minor thing below

[...]
> @@ -2563,22 +2572,37 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  						nodemask_t *nodes_allowed)
>  {
>  	int i;
> +	struct list_head page_list;
> +	struct page *page, *next;
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
> +			INIT_LIST_HEAD(&page->lru);

What is the point of rhis INIT_LIST_HEAD? Page has been removed from the
list by remove_hugetlb_page so it can be added to a new one without any
reinitialization.

> +			list_add(&page->lru, &page_list);
>  		}
>  	}
> +
> +out:
> +	spin_unlock(&hugetlb_lock);
> +	list_for_each_entry_safe(page, next, &page_list, lru) {
> +		list_del(&page->lru);
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
