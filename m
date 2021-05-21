Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1437138BDB7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 07:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbhEUFIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 01:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbhEUFIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 01:08:04 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E782C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:06:42 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id v13-20020a4aa40d0000b02902052145a469so4318085ool.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=s+VuTlZeIH9o28vK8h9TdUYDVV++CmHp4RflpswR/6E=;
        b=NPSQFL2WVD8VlBGL5MZ1DCIGCJXNfmnRQUdbWcSRoGqjhIAMMzj6G4gUmKeJH74EWD
         zNvQWqUtywM7js7hYzUZ99reYPH8Endr8EJR2Lb2Hhulz4qlopgnAT/7j8TTnu77q/YP
         bDOeMpjHaRN7EHz5T8DTifvMQfR3C/n+lMa2Io5inus4cHxUmsGRNrOWJlIeYpdzmDrd
         YA63NQeweCZzIx668dZXOOVXxKZCz6RZQ+3R5pRvTWr4XHxMQE8EZ5XHMPMfI/qHmfDd
         TOdZ4CsC2UL1erjQ2RdMAdW26kW7ZhvdwIkQNnvO5UQwdIamhV8FdLsUffzpMNGCLrGR
         EVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=s+VuTlZeIH9o28vK8h9TdUYDVV++CmHp4RflpswR/6E=;
        b=YBjPUncg4r7G6tYgeIJ/P8C6KO87OaVVV2slIKDnceB7o6piB9Y7o1yKasPAnqM0Q1
         rdo87bgBRUAfRAz6K4l//1+vAXlD3+sULMcH7xtmJddUOX49K0QUwigmbG+mcNDbII2e
         eNbDxMHZ3hn0RLlxKAsgLRO4H27mS3l7WdICN0lxrLQ0q3JrEXB8QCaSJpzBYfKdrCQX
         WZrPoulHWzD7bbXqSISEKmL/WU4nvSWv1SP3Lf1QxC3uQyYK9zPpTpDv78FZn/AIHPVW
         mnv/If2CW4j7nD6ysFlEsHvu+1vZzsINGRu0JsvSTVDOgmA/eaGwssmHGWjn+bqW6N37
         XSRg==
X-Gm-Message-State: AOAM5322s7BVksGorh6THjMnWHQ4Xgjlziakj0vmIEWDw5LHpA+ZnFa7
        kiPVXBkuIarKeRxkg66FQEhg+w==
X-Google-Smtp-Source: ABdhPJwAkuQMTYRc+nOSsO4fKCKFlpc6ELjC3Fq4YKhgX//o3ZesTZrDZSDGGLy9EDXWaE/yrzCX2A==
X-Received: by 2002:a4a:d41a:: with SMTP id n26mr6689565oos.66.1621573601095;
        Thu, 20 May 2021 22:06:41 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w10sm1028951ott.75.2021.05.20.22.06.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 20 May 2021 22:06:40 -0700 (PDT)
Date:   Thu, 20 May 2021 22:06:29 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        wangyugui@e16-tech.com, hughd@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: thp: check total_mapcount instead of
 page_mapcount
In-Reply-To: <20210513212334.217424-1-shy828301@gmail.com>
Message-ID: <alpine.LSU.2.11.2105202120220.6466@eggly.anvils>
References: <20210513212334.217424-1-shy828301@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021, Yang Shi wrote:

> When debugging the bug reported by Wang Yugui [1], try_to_unmap() may
> return false positive for PTE-mapped THP since page_mapcount() is used
> to check if the THP is unmapped, but it just checks compound mapount and
> head page's mapcount.  If the THP is PTE-mapped and head page is not
> mapped, it may return false positive.
> 
> Use total_mapcount() instead of page_mapcount() for try_to_unmap() and
> do so for the VM_BUG_ON_PAGE in split_huge_page_to_list as well.
> 
> This changed the semantic of try_to_unmap(), but I don't see there is
> any usecase that expects try_to_unmap() just unmap one subpage of a huge
> page.  So using page_mapcount() seems like a bug.
> 
> [1] https://lore.kernel.org/linux-mm/20210412180659.B9E3.409509F4@e16-tech.com/
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

I don't object to this patch, I've no reason to NAK it; but I'll
point out a few deficiencies which might make you want to revisit it.

> ---
> v2: Removed dead code and updated the comment of try_to_unmap() per Zi
>     Yan.
> 
>  mm/huge_memory.c | 11 +----------
>  mm/rmap.c        | 10 ++++++----
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..3b08b9ba1578 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2348,7 +2348,6 @@ static void unmap_page(struct page *page)
>  		ttu_flags |= TTU_SPLIT_FREEZE;
>  
>  	unmap_success = try_to_unmap(page, ttu_flags);
> -	VM_BUG_ON_PAGE(!unmap_success, page);

The unused variable unmap_success has already been reported and
dealt with.  But I couldn't tell what you intended: why change
try_to_unmap()'s output, if you then ignore it?

>  }
>  
>  static void remap_page(struct page *page, unsigned int nr)
> @@ -2718,7 +2717,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>  	}
>  
>  	unmap_page(head);
> -	VM_BUG_ON_PAGE(compound_mapcount(head), head);
> +	VM_BUG_ON_PAGE(total_mapcount(head), head);

And having forced try_to_unmap() to do the expensive-on-a-THP
total_mapcount() calculation, you now repeat it here.  Better
to stick with the previous VM_BUG_ON_PAGE(!unmap_success).

Or better a VM_WARN_ONCE(), accompanied by dump_page()s as before,
to get some perhaps useful info out, which this patch has deleted.
Probably better inside unmap_page() than cluttering up here.

VM_WARN_ONCE() because nothing in this patch fixes whatever Wang
Yugui is suffering from; and (aside from the BUG()) it's harmless,
because there are other ways in which the page_ref_freeze() can fail,
and that is allowed for.  We would like to know when this problem
occurs: there is something wrong, but no reason to crash.

>  
>  	/* block interrupt reentry in xa_lock and spinlock */
>  	local_irq_disable();
> @@ -2758,14 +2757,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
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

This has always looked ugly (as if Kirill had hit an unsolved case),
so it is nice to remove it; but you're losing the dump_page() info,
and not really gaining anything more than a cosmetic cleanup.

>  		spin_unlock(&ds_queue->split_queue_lock);
>  fail:		if (mapping)
>  			xa_unlock(&mapping->i_pages);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 693a610e181d..f52825b1330d 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1742,12 +1742,14 @@ static int page_not_mapped(struct page *page)
>  }
>  
>  /**
> - * try_to_unmap - try to remove all page table mappings to a page
> - * @page: the page to get unmapped
> + * try_to_unmap - try to remove all page table mappings to a page and the
> + *                compound page it belongs to
> + * @page: the page or the subpages of compound page to get unmapped
>   * @flags: action and flags
>   *
>   * Tries to remove all the page table entries which are mapping this
> - * page, used in the pageout path.  Caller must hold the page lock.
> + * page and the compound page it belongs to, used in the pageout path.
> + * Caller must hold the page lock.
>   *
>   * If unmap is successful, return true. Otherwise, false.
>   */
> @@ -1777,7 +1779,7 @@ bool try_to_unmap(struct page *page, enum ttu_flags flags)
>  	else
>  		rmap_walk(page, &rwc);
>  
> -	return !page_mapcount(page) ? true : false;
> +	return !total_mapcount(page) ? true : false;

That always made me wince: "return !total_mapcount(page);" surely.

Or slightly better, "return !page_mapped(page);", since at least that
one breaks out as soon as it sees a mapcount.  Though I guess I'm
being silly there, since that case should never occur, so both
total_mapcount() and page_mapped() scan through all pages.

Or better, change try_to_unmap() to void: most callers ignore its
return value anyway, and make their own decisions; the remaining
few could be changed to do the same.  Though again, I may be
being silly, since the expensive THP case is not the common case.

>  }
>  
>  /**
> -- 
> 2.26.2
