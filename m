Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B54232A533
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443556AbhCBMKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:10:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12660 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443024AbhCBLrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 06:47:09 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DqZzH3hMnzlRVn;
        Tue,  2 Mar 2021 19:44:11 +0800 (CST)
Received: from [10.174.179.20] (10.174.179.20) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 19:46:15 +0800
Subject: Re: [PATCH] mm/hugetlb: use some helper functions to cleanup code
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210210065346.21958-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <73ece5cf-679d-b1c9-95d5-4c1a6e0d4cc7@huawei.com>
Date:   Tue, 2 Mar 2021 19:46:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210210065346.21958-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.20]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/2/10 14:53, Miaohe Lin wrote:
> We could use pages_per_huge_page to get the number of pages per hugepage,
> use get_hstate_idx to calculate hstate index, and use hstate_is_gigantic
> to check if a hstate is gigantic to make code more succinct.
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

friendly ping after busy merge window. :)

> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  mm/hugetlb.c         | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 701c82c36138..c262566f7c5d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1435,7 +1435,7 @@ static int get_hstate_idx(int page_size_log)
>  
>  	if (!h)
>  		return -1;
> -	return h - hstates;
> +	return hstate_index(h);
>  }
>  
>  /*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8f6c98096476..da347047ea10 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1271,7 +1271,7 @@ static void free_gigantic_page(struct page *page, unsigned int order)
>  static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
>  		int nid, nodemask_t *nodemask)
>  {
> -	unsigned long nr_pages = 1UL << huge_page_order(h);
> +	unsigned long nr_pages = pages_per_huge_page(h);
>  	if (nid == NUMA_NO_NODE)
>  		nid = numa_mem_id();
>  
> @@ -3262,10 +3262,10 @@ static int __init hugepages_setup(char *s)
>  
>  	/*
>  	 * Global state is always initialized later in hugetlb_init.
> -	 * But we need to allocate >= MAX_ORDER hstates here early to still
> +	 * But we need to allocate gigantic hstates here early to still
>  	 * use the bootmem allocator.
>  	 */
> -	if (hugetlb_max_hstate && parsed_hstate->order >= MAX_ORDER)
> +	if (hugetlb_max_hstate && hstate_is_gigantic(parsed_hstate))
>  		hugetlb_hstate_alloc_pages(parsed_hstate);
>  
>  	last_mhp = mhp;
> 

