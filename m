Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF0B43666AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhDUIEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:04:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:51330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230343AbhDUIEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:04:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618992216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=njgxBDKMFjECLNEdhGU4YY0FuQCqkpgNlJ1UWX90J0s=;
        b=gTKsJlyWkHqNt5j/tj2PeXgnPL90WCzffITUftA0RuVPTb0ghtpes69iLSnZ4ejd+ruHMa
        9dhaoYmWu2yX1EA2bAtmm10GVa7rM4NVeF6NgDGvUGvhsq96EI5P8W8AravyPv289bnb9m
        fI/VDO6X0YwsIkI7rPH7J220cwODkOA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3167B137;
        Wed, 21 Apr 2021 08:03:35 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:03:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Message-ID: <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421060259.67554-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Naoya]

On Wed 21-04-21 14:02:59, Muchun Song wrote:
> The possible bad scenario:
> 
> CPU0:                           CPU1:
> 
>                                 gather_surplus_pages()
>                                   page = alloc_surplus_huge_page()
> memory_failure_hugetlb()
>   get_hwpoison_page(page)
>     __get_hwpoison_page(page)
>       get_page_unless_zero(page)
>                                   zero = put_page_testzero(page)
>                                   VM_BUG_ON_PAGE(!zero, page)
>                                   enqueue_huge_page(h, page)
>   put_page(page)
> 
> The refcount can possibly be increased by memory-failure or soft_offline
> handlers, we can trigger VM_BUG_ON_PAGE and wrongly add the page to the
> hugetlb pool list.

The hwpoison side of this looks really suspicious to me. It shouldn't
really touch the reference count of hugetlb pages without being very
careful (and having hugetlb_lock held). What would happen if the
reference count was increased after the page has been enqueed into the
pool? This can just blow up later.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 3476aa06da70..6c96332db34b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2145,17 +2145,14 @@ static int gather_surplus_pages(struct hstate *h, long delta)
>  
>  	/* Free the needed pages to the hugetlb pool */
>  	list_for_each_entry_safe(page, tmp, &surplus_list, lru) {
> -		int zeroed;
> -
>  		if ((--needed) < 0)
>  			break;
>  		/*
> -		 * This page is now managed by the hugetlb allocator and has
> -		 * no users -- drop the buddy allocator's reference.
> +		 * The refcount can possibly be increased by memory-failure or
> +		 * soft_offline handlers.
>  		 */
> -		zeroed = put_page_testzero(page);
> -		VM_BUG_ON_PAGE(!zeroed, page);
> -		enqueue_huge_page(h, page);
> +		if (likely(put_page_testzero(page)))
> +			enqueue_huge_page(h, page);
>  	}
>  free:
>  	spin_unlock_irq(&hugetlb_lock);
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
