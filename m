Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81B93906DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhEYQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhEYQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:47:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99D6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:46:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kr9so9120033pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UWSNucc0Fbg/N0O9e1BPa19xkxMtY5iUg9LrIIpQVIA=;
        b=c5iI4WiLJ8Mlx3ULjcLWiCuzFw/rE6hM7shCRXtzj2IV/H8cAkI2Za9qDIpCM/mUiM
         lFHkYiElwLNPl7pP+eIW5HezoTYqKMhppH11KXXckDW5B932JEwIMZq9tti9vxn1wSJR
         nJ1RqjH6nH02meL3oOGi4zKnuqw/mmzkXlgkuBiOcZovYKvrguUc8I467368w5ylcPKl
         wwgd51M5P6HKouG/8eR12NB72Bj62RB5ZcQznI7P7y3GXFRGkK/YA9ZGFLaFXqAtFsEg
         5IgDZrm59TsRgpO3RauO0qS/HdJ6CecwzUbGSxK/rmXu3t1hCfIEgmIrJbnuGhb7UlXd
         uesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UWSNucc0Fbg/N0O9e1BPa19xkxMtY5iUg9LrIIpQVIA=;
        b=nfhicGoV/+vA9fn4qhOJdMHLsdDXDHsx9VM8R4hOJrMaFPCfdQMQi0H2+697v8WQDD
         b7VTo9FZD6uU7vtUMOb3JX4nh0VW/U56PusDLJP5YCKnOIHVc28ns47hi4qiuCB6Ugyt
         C/WY1ZoxRm699Py6jCupUByAjjlbdaJ8mPLA3zOt+qg8y/M5veihkdOH7lwF7RAxLUXO
         MWN6n0iHcSug1+VbZb8VfgSWBQX4OPEK0d0bq12iUa48fNdlqyAcjat28hOCION3mzO1
         MHWI+7IOHDQksR71qTMAMSUYY5DcmvJHOLX2Xqn/rfRXvcG17liwu2K7i0epgvELVbD6
         ubxw==
X-Gm-Message-State: AOAM532rztWqdhi5Ra6ysbg5EyjRMZc5hbbxof4+FOaVmX2mwc/ve/rC
        B4dvmQDxgmpUSesrzT1yRZQ=
X-Google-Smtp-Source: ABdhPJxZc8AKB2etBkZad8HKPJGcA+XjdJ+8sO4LFdVu4/W+wPCqR9730FlRPiHfYWk/gOfNUOVuGA==
X-Received: by 2002:a17:903:22d1:b029:f2:67be:82fb with SMTP id y17-20020a17090322d1b02900f267be82fbmr31194844plg.15.1621961189340;
        Tue, 25 May 2021 09:46:29 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:37cd:d6b4:7992:c290])
        by smtp.gmail.com with ESMTPSA id bo10sm2595311pjb.36.2021.05.25.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:46:28 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 25 May 2021 09:46:25 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        naoya.horiguchi@nec.com, wangyugui@e16-tech.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 1/2] mm: rmap: make try_to_unmap() void function
Message-ID: <YK0p4fSXk1vhsmKt@google.com>
References: <20210525162145.3510-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525162145.3510-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 09:21:44AM -0700, Yang Shi wrote:
> Currently try_to_unmap() return bool value by checking page_mapcount(),
> however this may return false positive since page_mapcount() doesn't
> check all subpages of compound page.  The total_mapcount() could be used
> instead, but its cost is higher since it traverses all subpages.
> 
> Actually the most callers of try_to_unmap() don't care about the
> return value at all.  So just need check if page is still mapped by
> page_mapped() when necessary.  And page_mapped() does bail out early
> when it finds mapped subpage.
> 
> Suggested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/rmap.h |  2 +-
>  mm/huge_memory.c     |  4 +---
>  mm/memory-failure.c  | 13 ++++++-------
>  mm/rmap.c            |  6 +-----
>  mm/vmscan.c          |  3 ++-
>  5 files changed, 11 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index def5c62c93b3..116cb193110a 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -194,7 +194,7 @@ static inline void page_dup_rmap(struct page *page, bool compound)
>  int page_referenced(struct page *, int is_locked,
>  			struct mem_cgroup *memcg, unsigned long *vm_flags);
>  
> -bool try_to_unmap(struct page *, enum ttu_flags flags);
> +void try_to_unmap(struct page *, enum ttu_flags flags);
>  
>  /* Avoid racy checks */
>  #define PVMW_SYNC		(1 << 0)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 19195fca1aee..80fe642d742d 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2336,15 +2336,13 @@ static void unmap_page(struct page *page)
>  {
>  	enum ttu_flags ttu_flags = TTU_IGNORE_MLOCK |
>  		TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD;
> -	bool unmap_success;
>  
>  	VM_BUG_ON_PAGE(!PageHead(page), page);
>  
>  	if (PageAnon(page))
>  		ttu_flags |= TTU_SPLIT_FREEZE;
>  
> -	unmap_success = try_to_unmap(page, ttu_flags);
> -	VM_BUG_ON_PAGE(!unmap_success, page);
> +	try_to_unmap(page, ttu_flags);
>  }
>  
>  static void remap_page(struct page *page, unsigned int nr)
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 9dcc9bcea731..6dd53ff34825 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1126,7 +1126,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  		collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
>  
>  	if (!PageHuge(hpage)) {
> -		unmap_success = try_to_unmap(hpage, ttu);
> +		try_to_unmap(hpage, ttu);
>  	} else {
>  		if (!PageAnon(hpage)) {
>  			/*
> @@ -1138,17 +1138,16 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
>  			 */
>  			mapping = hugetlb_page_mapping_lock_write(hpage);
>  			if (mapping) {
> -				unmap_success = try_to_unmap(hpage,
> -						     ttu|TTU_RMAP_LOCKED);
> +				try_to_unmap(hpage, ttu|TTU_RMAP_LOCKED);
>  				i_mmap_unlock_write(mapping);
> -			} else {
> +			} else
>  				pr_info("Memory failure: %#lx: could not lock mapping for mapped huge page\n", pfn);
> -				unmap_success = false;
> -			}
>  		} else {
> -			unmap_success = try_to_unmap(hpage, ttu);
> +			try_to_unmap(hpage, ttu);
>  		}
>  	}
> +
> +	unmap_success = !page_mapped(hpage);
>  	if (!unmap_success)
>  		pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
>  		       pfn, page_mapcount(hpage));
> diff --git a/mm/rmap.c b/mm/rmap.c
> index a35cbbbded0d..728de421e43a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1748,10 +1748,8 @@ static int page_not_mapped(struct page *page)
>   *
>   * Tries to remove all the page table entries which are mapping this
>   * page, used in the pageout path.  Caller must hold the page lock.
> - *
> - * If unmap is successful, return true. Otherwise, false.
>   */
> -bool try_to_unmap(struct page *page, enum ttu_flags flags)
> +void try_to_unmap(struct page *page, enum ttu_flags flags)
>  {
>  	struct rmap_walk_control rwc = {
>  		.rmap_one = try_to_unmap_one,
> @@ -1776,8 +1774,6 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
>  		rmap_walk_locked(page, &rwc);
>  	else
>  		rmap_walk(page, &rwc);
> -
> -	return !page_mapcount(page) ? true : false;

Couldn't we use page_mapped instead of page_mapcount here?
With boolean return of try sematic looks reasonable to me
rather than void.

>  }
>  
>  /**
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f96d62159720..fa5052ace415 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1499,7 +1499,8 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  			if (unlikely(PageTransHuge(page)))
>  				flags |= TTU_SPLIT_HUGE_PMD;
>  
> -			if (!try_to_unmap(page, flags)) {
> +			try_to_unmap(page, flags);
> +			if (page_mapped(page)) {
>  				stat->nr_unmap_fail += nr_pages;
>  				if (!was_swapbacked && PageSwapBacked(page))
>  					stat->nr_lazyfree_fail += nr_pages;
> -- 
> 2.26.2
> 
> 
