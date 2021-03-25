Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2442E348E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCYKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:39196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhCYKrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:47:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616669227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cG0AzQK4074+rn9gesZQ2PJkz4OIzsNWxFZQsnN9pwc=;
        b=JbtjUS+UE8pQVw8wCDbXME5aE9cW4/Ur1GPkmPeiUzn7CEvIRh5Zgt1JCvsuBsAjMV+2he
        stwh4NjkAXrpbdKKR5FBsZbdUE2Ihgq7Ujn+JGEhsn8l6NYvnJkqGYjgkvG6A2XQ8Bt5fQ
        dJTWQIrsQfD7RaH5DGM4rLJv5ab10Jo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 60609AC3C;
        Thu, 25 Mar 2021 10:47:07 +0000 (UTC)
Date:   Thu, 25 Mar 2021 11:47:04 +0100
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
Subject: Re: [PATCH 3/8] hugetlb: add per-hstate mutex to synchronize user
 adjustments
Message-ID: <YFxqKH0OQoFMEiIb@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-4-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 17:28:30, Mike Kravetz wrote:
> The helper routine hstate_next_node_to_alloc accesses and modifies the
> hstate variable next_nid_to_alloc.  The helper is used by the routines
> alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
> called with hugetlb_lock held.  However, alloc_pool_huge_page can not
> be called with the hugetlb lock held as it will call the page allocator.
> Two instances of alloc_pool_huge_page could be run in parallel or
> alloc_pool_huge_page could run in parallel with adjust_pool_surplus
> which may result in the variable next_nid_to_alloc becoming invalid
> for the caller and pages being allocated on the wrong node.
> 
> Both alloc_pool_huge_page and adjust_pool_surplus are only called from
> the routine set_max_huge_pages after boot.  set_max_huge_pages is only
> called as the reusult of a user writing to the proc/sysfs nr_hugepages,
> or nr_hugepages_mempolicy file to adjust the number of hugetlb pages.
> 
> It makes little sense to allow multiple adjustment to the number of
> hugetlb pages in parallel.  Add a mutex to the hstate and use it to only
> allow one hugetlb page adjustment at a time.  This will synchronize
> modifications to the next_nid_to_alloc variable.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I would just recommend s@mutex@resize_lock@ so that the intention is
more clear from the name.
> ---
>  include/linux/hugetlb.h | 1 +
>  mm/hugetlb.c            | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index a7f7d5f328dc..8817ec987d68 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -566,6 +566,7 @@ HPAGEFLAG(Freed, freed)
>  #define HSTATE_NAME_LEN 32
>  /* Defines one hugetlb page size */
>  struct hstate {
> +	struct mutex mutex;
>  	int next_nid_to_alloc;
>  	int next_nid_to_free;
>  	unsigned int order;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f9ba63fc1747..404b0b1c5258 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2616,6 +2616,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	else
>  		return -ENOMEM;
>  
> +	/* mutex prevents concurrent adjustments for the same hstate */
> +	mutex_lock(&h->mutex);
>  	spin_lock(&hugetlb_lock);
>  
>  	/*
> @@ -2648,6 +2650,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	if (hstate_is_gigantic(h) && !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>  		if (count > persistent_huge_pages(h)) {
>  			spin_unlock(&hugetlb_lock);
> +			mutex_unlock(&h->mutex);
>  			NODEMASK_FREE(node_alloc_noretry);
>  			return -EINVAL;
>  		}
> @@ -2722,6 +2725,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  out:
>  	h->max_huge_pages = persistent_huge_pages(h);
>  	spin_unlock(&hugetlb_lock);
> +	mutex_unlock(&h->mutex);
>  
>  	NODEMASK_FREE(node_alloc_noretry);
>  
> @@ -3209,6 +3213,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
>  	BUG_ON(order == 0);
>  	h = &hstates[hugetlb_max_hstate++];
> +	mutex_init(&h->mutex);
>  	h->order = order;
>  	h->mask = ~(huge_page_size(h) - 1);
>  	for (i = 0; i < MAX_NUMNODES; ++i)
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
