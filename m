Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22666349F18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbhCZBwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:52:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14477 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCZBwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:52:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F64fr1NYkzyNHl;
        Fri, 26 Mar 2021 09:50:12 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 09:52:10 +0800
Subject: Re: [PATCH 3/8] hugetlb: add per-hstate mutex to synchronize user
 adjustments
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
 <20210325002835.216118-4-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <aa294d0f-b3ef-b1cc-83d8-779abe06f74e@huawei.com>
Date:   Fri, 26 Mar 2021 09:52:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210325002835.216118-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/25 8:28, Mike Kravetz wrote:
> The helper routine hstate_next_node_to_alloc accesses and modifies the
> hstate variable next_nid_to_alloc.  The helper is used by the routines
> alloc_pool_huge_page and adjust_pool_surplus.  adjust_pool_surplus is
> called with hugetlb_lock held.  However, alloc_pool_huge_page can not
> be called with the hugetlb lock held as it will call the page allocator.
> Two instances of alloc_pool_huge_page could be run in parallel or
> alloc_pool_huge_page could run in parallel with adjust_pool_surplus
> which may result in the variable next_nid_to_alloc becoming invalid
> for the caller and pages being allocated on the wrong node.
> > Both alloc_pool_huge_page and adjust_pool_surplus are only called from
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

I am also with Michal and Oscar here, renaming the mutex to something closer to
its function.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

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
> 

