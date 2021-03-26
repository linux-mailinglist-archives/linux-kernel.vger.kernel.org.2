Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5482A349F62
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhCZCNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:13:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14905 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhCZCMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:12:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F656m2S9Qzkg4x;
        Fri, 26 Mar 2021 10:10:56 +0800 (CST)
Received: from [10.174.178.163] (10.174.178.163) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 10:12:32 +0800
Subject: Re: [PATCH 8/8] hugetlb: add lockdep_assert_held() calls for
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
        Andrew Morton <akpm@linux-foundation.org>
References: <20210325002835.216118-1-mike.kravetz@oracle.com>
 <20210325002835.216118-9-mike.kravetz@oracle.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <aebbfd0f-e998-90ca-5024-2faa1991a68c@huawei.com>
Date:   Fri, 26 Mar 2021 10:12:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210325002835.216118-9-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/25 8:28, Mike Kravetz wrote:
> After making hugetlb lock irq safe and separating some functionality
> done under the lock, add some lockdep_assert_held to help verify
> locking.
> 

Looks good to me. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
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
> 

