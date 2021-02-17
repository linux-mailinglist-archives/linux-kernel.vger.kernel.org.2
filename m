Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0345931E0EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 21:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhBQU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 15:58:09 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8611 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbhBQU6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 15:58:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602d83360000>; Wed, 17 Feb 2021 12:57:26 -0800
Received: from [10.2.55.242] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 20:57:25 +0000
Subject: Re: [PATCH] mm: vmstat: add cma statistics
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <surenb@google.com>, <joaodias@google.com>
References: <20210217170025.512704-1-minchan@kernel.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8036d8e6-8e96-7b4e-91c0-e1ae91b637e1@nvidia.com>
Date:   Wed, 17 Feb 2021 12:57:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20210217170025.512704-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613595446; bh=hI0hY92PVZ/Q8bLOHZtIMPTuj0DO35pgrbP+g6IycJk=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=f31UQ+734TU3Iut9TEFTyDhQ6PvmWIYjezGcPbIORNJCP39NI5Fph5I0kpRe72Bf/
         UpKtyfwXEnAvDY+pv8butvZABcj2ACipE2xPBQwWFmCzx9DVMTh8fi1HhmbJIQfAsk
         aeID8fnSAY7VLGN8ss7vxX/3x2y8nVKDn4ncGhBBC4U15nioCJar9pSCLl42rjSGNu
         uh+xo9BsXK2wphoepTQyYnfDWznq6+AlXYD/dJwtGdswsQtXrO8IqcfB8Apxfb3xTY
         Op0ply0O2UbEbYCnP9gHV+5uiaAt4xn0n5xU160AnUoUyGBTG0nSCeztKkerncRmBu
         1npqpwcE9puZQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/21 9:00 AM, Minchan Kim wrote:
> Since CMA is used more widely, it's worth to have CMA
> allocation statistics into vmstat. With it, we could
> know how agressively system uses cma allocation and
> how often it fails.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   include/linux/vm_event_item.h |  3 +++
>   mm/cma.c                      | 12 +++++++++---
>   mm/vmstat.c                   |  4 ++++
>   3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 18e75974d4e3..0c567014ce82 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -70,6 +70,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>   #endif
>   #ifdef CONFIG_HUGETLB_PAGE
>   		HTLB_BUDDY_PGALLOC, HTLB_BUDDY_PGALLOC_FAIL,
> +#endif
> +#ifdef CONFIG_CMA
> +		CMA_ALLOC, CMA_ALLOC_FAIL,

This seems wrong: here it's called "alloc", but in the output it's
called "alloc success", and in the implementation it's clearly
"alloc attempt" that is being counted.

Once these are all made consistent, then the bug should naturally
go away as part of that.

nit: I think the multiple items per line is a weak idea at best, even
though it's used here already. Each item is important and needs to be
visually compared to it's output item later. So one per line might
have helped avoid mismatches, and I think we should change to that to
encourage that trend.

thanks,
-- 
John Hubbard
NVIDIA

>   #endif
>   		UNEVICTABLE_PGCULLED,	/* culled to noreclaim list */
>   		UNEVICTABLE_PGSCANNED,	/* scanned for reclaimability */
> diff --git a/mm/cma.c b/mm/cma.c
> index 23d4a97c834a..ea1e39559526 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -434,14 +434,16 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	struct page *page = NULL;
>   	int ret = -ENOMEM;
>   
> +	count_vm_event(CMA_ALLOC);
> +
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
> @@ -449,7 +451,7 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	bitmap_count = cma_bitmap_pages_to_bits(cma, count);
>   
>   	if (bitmap_count > bitmap_maxno)
> -		return NULL;
> +		goto out;
>   
>   	for (;;) {
>   		mutex_lock(&cma->lock);
> @@ -506,6 +508,10 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
>   	}
>   
>   	pr_debug("%s(): returned %p\n", __func__, page);
> +out:
> +	if (!page)
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

