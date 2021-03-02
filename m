Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3D32B6F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 11:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356716AbhCCKsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:48:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1075 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2361009AbhCBXKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:10:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603ec5c50000>; Tue, 02 Mar 2021 15:09:57 -0800
Received: from [10.2.62.164] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Mar
 2021 23:09:55 +0000
Message-ID: <e177e381-4461-f85d-14e1-a17739b12e5e@nvidia.com>
Date:   Tue, 2 Mar 2021 15:09:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2] mm: vmstat: add cma statistics
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <joaodias@google.com>, <surenb@google.com>
References: <20210302183346.3707237-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20210302183346.3707237-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614726597; bh=r7vcFFXe7sgEJ2nO7wop6ul+G25XAZLjT/ih8UIr5ZY=;
        h=Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
         To:CC:References:From:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=otFRU1NrfFpUyud3otr8gxO/NMyl+NyBW51NnOAf1WDFKK6mjjMBSxks4mDhA0WzS
         FP6gxqMio5XH5tc2laaweumc2rLbr115K3i2Tu7iDV/Q4FHPGzC+NqWh+nNbsO1Z4D
         6k51zsvPtuyvyA6GB9hMk2dQv6wpiDqijfUw5odI9hACt+Vi4zru3xMak56keWb823
         hI3qe2hJr60xOmcRyCPMHpgBXRMwcfJKSBIU1JnbrNzfBkq/FHSb8pPLW1sAL1BD/c
         gpkcWm2+8xePhqw5zn/qlW3P3CW8+mCOxCqqX46+qtaprraSqGvVGSNnl9RwS6vOdY
         OHp1AWIJn3y4g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 10:33, Minchan Kim wrote:
> Since CMA is used more widely, it's worth to have CMA
> allocation statistics into vmstat. With it, we could
> know how agressively system uses cma allocation and
> how often it fails.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from v1 - https://lore.kernel.org/linux-mm/20210217170025.512704-1-minchan@kernel.org/
>    * change alloc_attempt with alloc_success - jhubbard
>    * item per line for vm_event_item - jhubbard
> 
>   include/linux/vm_event_item.h |  4 ++++
>   mm/cma.c                      | 12 +++++++++---
>   mm/vmstat.c                   |  4 ++++
>   3 files changed, 17 insertions(+), 3 deletions(-)
> 

Seems reasonable, and the diffs look good.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 18e75974d4e3..21d7c7f72f1c 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -70,6 +70,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>   #endif
>   #ifdef CONFIG_HUGETLB_PAGE
>   		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
> +#endif
> +#ifdef CONFIG_CMA
> +		CMA_ALLOC_SUCCESS,
> +		CMA_ALLOC_FAIL,
>   #endif
>   		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
>   		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
> diff --git a/mm/cma.c b/mm/cma.c
> index 23d4a97c834a..04ca863d1807 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -435,13 +435,13 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	int ret = -ENOMEM;
>   
>   	if (!cma || !cma->count || !cma->bitmap)
> -		return NULL;
> +		goto out;
>   
>   	pr_debug("%s(cma %p, count %zu, align %d)\n", __func__, (void *)cma,
>   		 count, align);
>   
>   	if (!count)
> -		return NULL;
> +		goto out;
>   
>   	mask = cma_bitmap_aligned_mask(cma, align);
>   	offset = cma_bitmap_aligned_offset(cma, align);
> @@ -449,7 +449,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>   
>   	if (bitmap_count > bitmap_maxno)
> -		return NULL;
> +		goto out;
>   
>   	for (;;) {
>   		mutex_lock(&cma->lock);
> @@ -506,6 +506,12 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	}
>   
>   	pr_debug("%s(): returned %p\n", __func__, page);
> +out:
> +	if (page)
> +		count_vm_event(CMA_ALLOC_SUCCESS);
> +	else
> +		count_vm_event(CMA_ALLOC_FAIL);
> +
>   	return page;
>   }
>   
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 97fc32a53320..d8c32a33208d 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1305,6 +1305,10 @@ const char * const vmstat_text[] = {
>   #ifdef CONFIG_HUGETLB_PAGE
>   	"htlb_buddy_alloc_success",
>   	"htlb_buddy_alloc_fail",
> +#endif
> +#ifdef CONFIG_CMA
> +	"cma_alloc_success",
> +	"cma_alloc_fail",
>   #endif
>   	"unevictable_pgs_culled",
>   	"unevictable_pgs_scanned",
> 
