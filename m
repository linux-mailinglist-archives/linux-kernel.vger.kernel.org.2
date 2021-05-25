Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5017390BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEYWHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhEYWHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:07:31 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E784C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:06:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v22so31769736oic.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=V2f60hFSBg5mplGHJu5ZXvvWvgziSj8114cWWDTA9tc=;
        b=VeBJ+qroJZ6lptIFw3vuc9CAr1u2l2n5YGdEIfOeOH4SCoiF55HE9g4PD3/QE1mqrN
         bI9EsboT3lIAjhVvshAIfIGN6cNgA7rz5wRSQtn0eoP3N7W4i4E3vtXo6ufOFWuDXIpX
         Fl5oe0SdmGhrC8QKe0wgmnDAWMtpXqH/5I4YaWqVguwcB0+X2eFPmutCzbU++NoS91sB
         XClFoObDbjFLvtZ11xAffuoIU+Ws04AWl1y7WfRtN/SmK/TG8LzfmK9ooXsNDSGuIQhi
         LKUae758Zkf4z2ijuw7h6QAXM5JLW7PummJH1sqSmx9kIAdh32xA/Si/KsHmiYcMcMS+
         oqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=V2f60hFSBg5mplGHJu5ZXvvWvgziSj8114cWWDTA9tc=;
        b=CZmZAW6VG4a9AREbSS0exH8CP/dCm5jB9sktuDxqVvEnRdLADaCALrWRlxramu5ORP
         6ncC4tMq3Xi71xWbfm05szcH6gGhU2OUMK48yC96ddwHeVtecoiigo2jxg8DI7ByR5x7
         tl2sdTJAk6BZ+CGTP0RXirD4RN+FHhWFWvtLDvCYGKNA/aBAnYodsRdDNaH2PvzZ2b2e
         JNE7fML1iL47K+3MG86cqTYn7/m+KwCdTylGZj7VZl5AFs/ZUOkB1xbtVtqlGjqHQLo3
         oiYvhahgzMPCV9f9XoXOijnl4JbwXzx4c2un8L8B42Q7xEXmHgLg9QxsGeEa04uyMZjn
         vUgA==
X-Gm-Message-State: AOAM530whCrg8LbBRKZ9BHso7s+HNKiyxubo64dkgNdt7qlI5/wKQtf6
        8SbzO52pUnULBt9yN5bTP+EqVw==
X-Google-Smtp-Source: ABdhPJy1tKFmLZf9y03mRZLZ33XkSMEIxr0p6rAiykzoBjdZLKDgJFm9fANgsdRfPpIXyTD9WBUh1A==
X-Received: by 2002:aca:cf8d:: with SMTP id f135mr309891oig.33.1621980360190;
        Tue, 25 May 2021 15:06:00 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v19sm4052931otq.35.2021.05.25.15.05.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 25 May 2021 15:05:59 -0700 (PDT)
Date:   Tue, 25 May 2021 15:05:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     hughd@google.com, ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        naoya.horiguchi@nec.com, wangyugui@e16-tech.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH 2/2] mm: thp: check page_mapped instead of page_mapcount
 for split
In-Reply-To: <20210525162145.3510-2-shy828301@gmail.com>
Message-ID: <alpine.LSU.2.11.2105251412140.2003@eggly.anvils>
References: <20210525162145.3510-1-shy828301@gmail.com> <20210525162145.3510-2-shy828301@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Yang Shi wrote:

> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> return false positive for PTE-mapped THP since page_mapcount() is used
> to check if the THP is unmapped, but it just checks compound mapount and
> head page's mapcount.  If the THP is PTE-mapped and head page is not
> mapped, it may return false positive.

But those false positives did not matter because there was a separate
DEBUG_VM check later.

It's good to have the link to Wang Yugui's report, but that paragraph
is not really about this patch, as it has evolved now: this patch
consolidates the two DEBUG_VM checks into one VM_WARN_ON_ONCE_PAGE.

> 
> The try_to_unmap() has been changed to void function, so check
> page_mapped() after it.  And changed BUG_ON to WARN_ON since it is not a
> fatal issue.

The change from DEBUG_VM BUG to VM_WARN_ON_ONCE is the most important
part of this, and the reason it's good for stable: and the patch title
ought to highlight that, not the page_mapcount business.

> 
> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

This will be required Cc: stable@vger.kernel.org
(but we don't want to Cc them on this mail).

As I said on the other, I think this should be 1/2 not 2/2.

> ---
> v3: Incorporated the comments from Hugh. Keep Zi Yan's reviewed-by tag
>     since there is no fundamental change against v2.
> v2: Removed dead code and updated the comment of try_to_unmap() per Zi
>     Yan.
>  mm/huge_memory.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 80fe642d742d..72d81d8e01b1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2343,6 +2343,8 @@ static void unmap_page(struct page *page)
>  		ttu_flags |= TTU_SPLIT_FREEZE;
>  
>  	try_to_unmap(page, ttu_flags);
> +
> +	VM_WARN_ON_ONCE_PAGE(page_mapped(page), page);

There is one useful piece of information that dump_page() will not show:
total_mapcount(page).  Is there a way of crafting that into the output?

Not with the macros available, I think.  Maybe we should be optimistic
and assume I already have the fixes, so not worth trying to refine the
message (but I'm not entirely convinced of that!).

The trouble with
	if (VM_WARN_ON_ONCE_PAGE(page_mapped(page), page))
		pr_warn("total_mapcount:%d\n", total_mapcount(page));
is that it's printed regardless of the ONCEness.  Another "trouble"
is that it's printed so long after the page_mapped(page) check that
it may be 0 by now - but one can see that as itself informative.

I guess leave it as you have it, I don't see an easy better
(without going back to something like the old contortions).

>  }
>  
>  static void remap_page(struct page *page, unsigned int nr)
> @@ -2653,7 +2655,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	struct deferred_split *ds_queue = get_deferred_split_queue(head);
>  	struct anon_vma *anon_vma = NULL;
>  	struct address_space *mapping = NULL;
> -	int count, mapcount, extra_pins, ret;
> +	int mapcount, extra_pins, ret;

Remove mapcount too.

>  	pgoff_t end;
>  
>  	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
> @@ -2712,7 +2714,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	}
>  
>  	unmap_page(head);
> -	VM_BUG_ON_PAGE(compound_mapcount(head), head);
>  
>  	/* block interrupt reentry in xa_lock and spinlock */
>  	local_irq_disable();
> @@ -2730,7 +2731,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  
>  	/* Prevent deferred_split_scan() touching ->_refcount */
>  	spin_lock(&ds_queue->split_queue_lock);
> -	count = page_count(head);
>  	mapcount = total_mapcount(head);
>  	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {

mapcount was useful for printing in the hand-crafted message deleted,
but serves no purpose now: just do the page_ref_freeze() without it.

>  		if (!list_empty(page_deferred_list(head))) {
> @@ -2752,16 +2752,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
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
