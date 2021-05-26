Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F62392279
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhEZWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhEZWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:04:19 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37003C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:02:47 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q10so2712263qkc.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=m9kpVikMq0X/WHn50vIzul0uM/x6WaxsLnPxzV8XYwY=;
        b=dW9xLrwNtI1/mAS/0ZIsltlDg3VzivWh4QdL3oj5P80QrOqsJ69IkopdmzJgTrUP7i
         l5A0d6UTWe5OLP4sU8Of5bV34YNk/UWBffHWn5OGsV49OJ5Jdh01D1M+jY+mtR8PrmA9
         B44q7ZRKrUC9Pe09cqmAyWhdMXgy7pxhx4tGNi8duVL8lWaapkz0UqCWRzAcWiNmA/9m
         AkL++frY2KbZN2vGPPor4ECBZS7VWbYeCIRm/Ce7yDkzisEcxqrKu5G26527DQFIhfJQ
         2/uOdSWAWU5DUCm35PmqOBF0cP9eHvHM3myu0sMTphxrJkGoC7fo8biIsTQlU5IH/j72
         +SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=m9kpVikMq0X/WHn50vIzul0uM/x6WaxsLnPxzV8XYwY=;
        b=Z/F8zC3/nAid0tmGnUQrOuDrLr1fVPwn5Lg0ne58N+YvmEUqqo5WwZOie/0Hr7FPFZ
         WHabB0iSxqEjkbmwkFMJKcSLmmONqMoZ8q4z1aBkV2qo4S4DwuXwii4PteM6RP26XR7Q
         oBUmZ31QuBEb/98R9evNVV4vUn4n9EbJjstZOBQv15Luw+SPoaXciDUhUtugJO21+gAJ
         1fUiLu2e9N5CqA85/T8GUgExKsK8cOzCsQQgiAj7RXEkKBZeFmUpNm+C4VM7ohdJQWpW
         y53d5Yh+tqR6AtYylxM5TyiRmzzIsKH2h5mcJiaL3TW8swVtJ3Fs9GD6+9vHFT/RyJQA
         J8gg==
X-Gm-Message-State: AOAM532aZ1WFAxcnsFxGCGzeiglKtrQX28D7b40aFvZzHyIcsO4FxV4h
        dBBgM6uKm5ZNRdIlmUBlOoRdmA==
X-Google-Smtp-Source: ABdhPJwKeenmvMpGNUJK6iXR3FHH2Vz/PN88ujD0+f1MT4LHxXMV4WjPo3xcDmZWglNZYNlVyowE8A==
X-Received: by 2002:a37:2cc3:: with SMTP id s186mr282800qkh.500.1622066566096;
        Wed, 26 May 2021 15:02:46 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 123sm140993qkh.104.2021.05.26.15.02.44
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 26 May 2021 15:02:45 -0700 (PDT)
Date:   Wed, 26 May 2021 15:02:30 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        minchan@kernel.org, naoya.horiguchi@nec.com,
        wangyugui@e16-tech.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v4 PATCH 1/2] mm: thp: replace DEBUG_VM BUG with VM_WARN when
 unmap fails for split
In-Reply-To: <20210526201239.3351-1-shy828301@gmail.com>
Message-ID: <alpine.LSU.2.11.2105261501430.16282@eggly.anvils>
References: <20210526201239.3351-1-shy828301@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Yang Shi wrote:

> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> fail, but the first VM_BUG_ON_PAGE() just checks page_mapcount() however
> it may miss the failure when head page is unmapped but other subpage is
> mapped.  Then the second DEBUG_VM BUG() that check total mapcount would
> catch it.  This may incur some confusion.  And this is not a fatal issue,
> so consolidate the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE().
> 
> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks: and 2/2 already has my Ack, correct.

> ---
> v4: Updated the subject and commit log per Hugh.
>     Reordered the patches per Hugh.
> v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
>     since there is no fundamental change against v2.
> v2: Removed dead code and updated the comment of try_to_unmap() per Zi
>     Yan.
> 
>  mm/huge_memory.c | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 19195fca1aee..8827f82c5302 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2336,15 +2336,15 @@ static void unmap_page(struct page *page)
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
> +
> +	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);
>  }
>  
>  static void remap_page(struct page *page, unsigned int nr)
> @@ -2655,7 +2655,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	struct deferred_split *ds_queue = get_deferred_split_queue(head);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
> -	int count, mapcount, extra_pins, ret;
> +	int extra_pins, ret;
>  	pgoff_t end;
>  
>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> @@ -2714,7 +2714,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	}
>  
>  	unmap_page(head);
> -	VM_BUG_ON_PAGE(compound_mapcount(head), head);
>  
>  	/* block interrupt reentry in xa_lock and spinlock */
>  	local_irq_disable();
> @@ -2732,9 +2731,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  
>  	/* Prevent deferred_split_scan() touching ->_refcount */
>  	spin_lock(&ds_queue->split_queue_lock);
> -	count = page_count(head);
> -	mapcount = total_mapcount(head);
> -	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
> +	if (page_ref_freeze(head, 1 + extra_pins)) {
>  		if (!list_empty(page_deferred_list(head))) {
>  			ds_queue->split_queue_len--;
>  			list_del(page_deferred_list(head));
> @@ -2754,16 +2751,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  		__split_huge_page(page, list, end);
>  		ret = 0;
>  	} else {
> -		if (IS_ENABLED(CONFIG_DEBUG_VM) && mapcount) {
> -			pr_alert("total_mapcount: %u, page_count(): %u\n",
> -					mapcount, count);
> -			if (PageTail(page))
> -				dump_page(head, NULL);
> -			dump_page(page, "total_mapcount(head) > 0");
> -			BUG();
> -		}
>  		spin_unlock(&ds_queue->split_queue_lock);
> -fail:		if (mapping)
> +fail:
> +		if (mapping)
>  			xa_unlock(&mapping->i_pages);
>  		local_irq_enable();
>  		remap_page(head, thp_nr_pages(head));
> -- 
> 2.26.2
> 
> 
