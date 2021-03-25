Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FCA348ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCYLWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:22:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhCYLWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:22:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616671321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H84pzAwugDWWKwnl52shIBT7k4wDLgWbgXF7tco8RiQ=;
        b=tr/qxXOQMV4A1v4B58d1Kfiw/HMM6aK44Uc0uepviVODuFj6cE9aMGqXJvuu4iCRgZ8qai
        qqnvgwtggQfa/ZmO/tYjx6jLc2v4F2a88I0w2PZHpKrKlLcP8wQqdEhF35F3cUq9u+yU0G
        fDHyeeXNZX9l5BGb2TIgQoBPGoz9ooE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9341AC16;
        Thu, 25 Mar 2021 11:22:01 +0000 (UTC)
Date:   Thu, 25 Mar 2021 12:22:00 +0100
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
Subject: Re: [PATCH 8/8] hugetlb: add lockdep_assert_held() calls for
 hugetlb_lock
Message-ID: <YFxyWG1xBc2BlTUB@dhcp22.suse.cz>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-9-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325002835.216118-9-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-03-21 17:28:35, Mike Kravetz wrote:
> After making hugetlb lock irq safe and separating some functionality
> done under the lock, add some lockdep_assert_held to help verify
> locking.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/hugetlb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e4c441b878f2..de5b3cf4a155 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1062,6 +1062,8 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>  static void enqueue_huge_page(struct hstate *h, struct page *page)
>  {
>  	int nid = page_to_nid(page);
> +
> +	lockdep_assert_held(&hugetlb_lock);
>  	list_move(&page->lru, &h->hugepage_freelists[nid]);
>  	h->free_huge_pages++;
>  	h->free_huge_pages_node[nid]++;
> @@ -1073,6 +1075,7 @@ static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  	struct page *page;
>  	bool pin = !!(current->flags & PF_MEMALLOC_PIN);
>  
> +	lockdep_assert_held(&hugetlb_lock);
>  	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
>  		if (pin && !is_pinnable_page(page))
>  			continue;
> @@ -1345,6 +1348,7 @@ static void remove_hugetlb_page(struct hstate *h, struct page *page,
>  {
>  	int nid = page_to_nid(page);
>  
> +	lockdep_assert_held(&hugetlb_lock);
>  	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>  		return;
>  
> @@ -1690,6 +1694,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
>  	int nr_nodes, node;
>  	struct page *page = NULL;
>  
> +	lockdep_assert_held(&hugetlb_lock);
>  	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
>  		/*
>  		 * If we're returning unused surplus pages, only examine
> @@ -1939,6 +1944,7 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>  	long needed, allocated;
>  	bool alloc_ok = true;
>  
> +	lockdep_assert_held(&hugetlb_lock);
>  	needed = (h->resv_huge_pages + delta) - h->free_huge_pages;
>  	if (needed <= 0) {
>  		h->resv_huge_pages += delta;
> @@ -2032,6 +2038,7 @@ static void return_unused_surplus_pages(struct hstate *h,
>  	struct page *page, *t_page;
>  	struct list_head page_list;
>  
> +	lockdep_assert_held(&hugetlb_lock);
>  	/* Uncommit the reservation */
>  	h->resv_huge_pages -= unused_resv_pages;
>  
> @@ -2527,6 +2534,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
>  	struct list_head page_list;
>  	struct page *page, *next;
>  
> +	lockdep_assert_held(&hugetlb_lock);
>  	if (hstate_is_gigantic(h))
>  		return;
>  
> @@ -2573,6 +2581,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  {
>  	int nr_nodes, node;
>  
> +	lockdep_assert_held(&hugetlb_lock);
>  	VM_BUG_ON(delta != -1 && delta != 1);
>  
>  	if (delta < 0) {
> -- 
> 2.30.2
> 

-- 
Michal Hocko
SUSE Labs
