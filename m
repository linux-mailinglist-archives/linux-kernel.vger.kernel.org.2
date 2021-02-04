Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A830E9C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhBDCAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:00:38 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:12415 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhBDCAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:00:34 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DWMCr488RzjHXp;
        Thu,  4 Feb 2021 09:58:48 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 09:59:47 +0800
Subject: Re: [PATCH 1/4] hugetlb: Dedup the code to add a new file_region
To:     Peter Xu <peterx@redhat.com>
CC:     Wei Zhang <wzam@amazon.com>, Matthew Wilcox <willy@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gal Pressman" <galpress@amazon.com>,
        Christoph Hellwig <hch@lst.de>,
        "Andrea Arcangeli" <aarcange@redhat.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Mike Rapoport" <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210203210832.113685-1-peterx@redhat.com>
 <20210203210832.113685-2-peterx@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0b1f73fb-e51b-c86d-1abe-ad92ddef6b99@huawei.com>
Date:   Thu, 4 Feb 2021 09:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210203210832.113685-2-peterx@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/2/4 5:08, Peter Xu wrote:
> Introduce hugetlb_resv_map_add() helper to add a new file_region rather than
> duplication the similar code twice in add_reservation_in_range().
> 

This cleanup is also in my plan. But I was too sluggish to do this. Many thanks for doing this.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 51 +++++++++++++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18f6ee317900..d2859c2aecc9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -321,6 +321,24 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  	}
>  }
>  
> +static inline long
> +hugetlb_resv_map_add(struct resv_map *map, struct file_region *rg, long from,
> +		     long to, struct hstate *h, struct hugetlb_cgroup *cg,
> +		     long *regions_needed)
> +{
> +	struct file_region *nrg;
> +
> +	if (!regions_needed) {
> +		nrg = get_file_region_entry_from_cache(map, from, to);
> +		record_hugetlb_cgroup_uncharge_info(cg, h, map, nrg);
> +		list_add(&nrg->link, rg->link.prev);
> +		coalesce_file_region(map, nrg);
> +	} else
> +		*regions_needed += 1;
> +
> +	return to - from;
> +}
> +
>  /*
>   * Must be called with resv->lock held.
>   *
> @@ -336,7 +354,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  	long add = 0;
>  	struct list_head *head = &resv->regions;
>  	long last_accounted_offset = f;
> -	struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> +	struct file_region *rg = NULL, *trg = NULL;
>  
>  	if (regions_needed)
>  		*regions_needed = 0;
> @@ -365,18 +383,11 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  		/* Add an entry for last_accounted_offset -> rg->from, and
>  		 * update last_accounted_offset.
>  		 */
> -		if (rg->from > last_accounted_offset) {
> -			add += rg->from - last_accounted_offset;
> -			if (!regions_needed) {
> -				nrg = get_file_region_entry_from_cache(
> -					resv, last_accounted_offset, rg->from);
> -				record_hugetlb_cgroup_uncharge_info(h_cg, h,
> -								    resv, nrg);
> -				list_add(&nrg->link, rg->link.prev);
> -				coalesce_file_region(resv, nrg);
> -			} else
> -				*regions_needed += 1;
> -		}
> +		if (rg->from > last_accounted_offset)
> +			add += hugetlb_resv_map_add(resv, rg,
> +						    last_accounted_offset,
> +						    rg->from, h, h_cg,
> +						    regions_needed);
>  
>  		last_accounted_offset = rg->to;
>  	}
> @@ -384,17 +395,9 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
>  	/* Handle the case where our range extends beyond
>  	 * last_accounted_offset.
>  	 */
> -	if (last_accounted_offset < t) {
> -		add += t - last_accounted_offset;
> -		if (!regions_needed) {
> -			nrg = get_file_region_entry_from_cache(
> -				resv, last_accounted_offset, t);
> -			record_hugetlb_cgroup_uncharge_info(h_cg, h, resv, nrg);
> -			list_add(&nrg->link, rg->link.prev);
> -			coalesce_file_region(resv, nrg);
> -		} else
> -			*regions_needed += 1;
> -	}
> +	if (last_accounted_offset < t)
> +		add += hugetlb_resv_map_add(resv, rg, last_accounted_offset,
> +					    t, h, h_cg, regions_needed);
>  
>  	VM_BUG_ON(add < 0);
>  	return add;
> 

