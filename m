Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF4336D01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhCKHWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhCKHWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:22:36 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE042C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:22:35 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id u62so6340766oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 23:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=RsQ39ePrjlJasxWu8MVkxDuRqN5EB8evI6SJn9j1EnU=;
        b=AIjzzh9q2zyaY726QVOjA0aj0rGQPJH+obw7Et0eMFaYLT9ts1idc51z/32DpIkAkp
         wct/7+bN30NLOf6F0le39pV/ZfXAqH4YF2dwflp7qM6Sy0G+MEM0lW+D6F032XxRrdPT
         /iTQl3oOjVtXDm4vo/BejdUg8nWfPMs2u+Nnu+P+P76JKxrukV6y8jFRHgJzHxzLPkZu
         A0oO0uD2WoGXE/IF5RtQBRCTCG6701xx2T77SAlX2YPeFT7oAArK13LvdfDzhBI8Hp69
         HarO3zmmtdDwqPWjBnw/ErP3MtPYZon2Y+4nLPPYvYGtlRApiD04xoJgg2VgkFY/KKVk
         /Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=RsQ39ePrjlJasxWu8MVkxDuRqN5EB8evI6SJn9j1EnU=;
        b=c/Da/xv0XIQwSvGleRoyquEu28Xy1SZ88kShxr6DMY6Csqobif8PvT59DMxBndBBQH
         ehcxU+H9cUz3lXNphd+NT2/QLhWLUxSkSauj0kP5yTKmlDCRepL32lx+rUfCHmBDcava
         Wf46CtPLm2uHpXwRj3keXPSsqDwIGvZoEhPDTAizw0bwjY3TlUjP5z8BkgKdVz3RhFrd
         D0IejwkoY1E/XducLmjgsSV9T+UhXC0c3eb/ih8vGZDTYyLHegsC9ibXKiXVplOGMMrW
         K5mMCXswIw2eJkYnYjetqFn0wdzH5UU2Y1OPkneKo9QeXHCMpip0yK9o8abBFbCgUtro
         07Yw==
X-Gm-Message-State: AOAM530S/sg8ETkCK4YEbl5bNKqV7+1PmAl3JYzbfNHSn21pzqpntcWH
        WhKW+pAGpu3dtTCZdmxU+yN0bA==
X-Google-Smtp-Source: ABdhPJzdIpyPXOpylsYda1l/POaA65Jwuh+iDDw6Ir/wtgpFbG80Sue/PDNHHrIkwAG/gpyV7Dh+rg==
X-Received: by 2002:aca:7543:: with SMTP id q64mr5416901oic.100.1615447355057;
        Wed, 10 Mar 2021 23:22:35 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w5sm424095oig.24.2021.03.10.23.22.33
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 10 Mar 2021 23:22:34 -0800 (PST)
Date:   Wed, 10 Mar 2021 23:22:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1] mm, hwpoison: enable error handling on shmem thp
In-Reply-To: <20210209062128.453814-1-nao.horiguchi@gmail.com>
Message-ID: <alpine.LSU.2.11.2103102214170.7159@eggly.anvils>
References: <20210209062128.453814-1-nao.horiguchi@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Feb 2021, Naoya Horiguchi wrote:

> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Currently hwpoison code checks PageAnon() for thp and refuses to handle
> errors on non-anonymous thps (just for historical reason).  We now
> support non-anonymou thp like shmem one, so this patch suggests to enable
> to handle shmem thps. Fortunately, we already have can_split_huge_page()
> to check if a give thp is splittable, so this patch relies on it.

Fortunately? I don't understand. Why call can_split_huge_page()
at all, instead of simply trying split_huge_page() directly?
And could it do better than -EBUSY when split_huge_page() fails?

> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thanks for trying to add shmem+file THP support, but I think this
does not work as intended - Andrew, if Naoya agrees, please drop from
mmotm for now, the fixup needed will be more than a line or two.

I'm not much into memory-failure myself, but Jue discovered that the
SIGBUS never arrives: because split_huge_page() on a shmem or file
THP unmaps all its pmds and ptes, and (unlike with anon) leaves them
unmapped - in normal circumstances, to be faulted back on demand.
So the page_mapped() check in hwpoison_user_mappings() fails,
and the intended SIGBUS is not delivered.

(Or, is it acceptable that the SIGBUS is not delivered to those who
have the huge page mapped: should it get delivered later, to anyone
who faults back in the bad 4k?)

We believe the tokill list has to be set up earlier, before
split_huge_page() is called, then passed in to hwpoison_user_mappings().

Sorry, we don't have a proper patch for that right now, but I expect
you can see what needs to be done.  But something we found on the way,
we do have a patch for: add_to_kill() uses page_address_in_vma(), but
that has not been used on file THP tails before - fix appended at the
end below, so as not to waste your time on that bit.

> ---
>  mm/memory-failure.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git v5.11-rc6/mm/memory-failure.c v5.11-rc6_patched/mm/memory-failure.c
> index e9481632fcd1..8c1575de0507 100644
> --- v5.11-rc6/mm/memory-failure.c
> +++ v5.11-rc6_patched/mm/memory-failure.c
> @@ -956,20 +956,6 @@ static int __get_hwpoison_page(struct page *page)
>  {
>  	struct page *head = compound_head(page);
>  
> -	if (!PageHuge(head) && PageTransHuge(head)) {
> -		/*
> -		 * Non anonymous thp exists only in allocation/free time. We
> -		 * can't handle such a case correctly, so let's give it up.
> -		 * This should be better than triggering BUG_ON when kernel
> -		 * tries to touch the "partially handled" page.
> -		 */
> -		if (!PageAnon(head)) {
> -			pr_err("Memory failure: %#lx: non anonymous thp\n",
> -				page_to_pfn(page));
> -			return 0;
> -		}
> -	}
> -
>  	if (get_page_unless_zero(head)) {
>  		if (head == compound_head(page))
>  			return 1;
> @@ -1197,21 +1183,19 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>  
>  static int try_to_split_thp_page(struct page *page, const char *msg)
>  {
> -	lock_page(page);
> -	if (!PageAnon(page) || unlikely(split_huge_page(page))) {
> -		unsigned long pfn = page_to_pfn(page);
> +	struct page *head;
>  
> +	lock_page(page);
> +	head = compound_head(page);
> +	if (PageTransHuge(head) && can_split_huge_page(head, NULL) &&
> +	    !split_huge_page(page)) {
>  		unlock_page(page);
> -		if (!PageAnon(page))
> -			pr_info("%s: %#lx: non anonymous thp\n", msg, pfn);
> -		else
> -			pr_info("%s: %#lx: thp split failed\n", msg, pfn);
> -		put_page(page);
> -		return -EBUSY;
> +		return 0;
>  	}
> +	pr_info("%s: %#lx: thp split failed\n", msg, page_to_pfn(page));
>  	unlock_page(page);
> -
> -	return 0;
> +	put_page(page);
> +	return -EBUSY;
>  }
>  
>  static int memory_failure_hugetlb(unsigned long pfn, int flags)
> -- 
> 2.25.1

[PATCH] mm: fix page_address_in_vma() on file THP tails
From: Jue Wang <juew@google.com>

Anon THP tails were already supported, but memory-failure now needs to use
page_address_in_vma() on file THP tails, which its page->mapping check did
not permit: fix it.

Signed-off-by: Jue Wang <juew@google.com>
Signed-off-by: Hugh Dickins <hughd@google.com>
---

 mm/rmap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 5.12-rc2/mm/rmap.c	2021-02-28 16:58:57.950450151 -0800
+++ linux/mm/rmap.c	2021-03-10 20:29:21.591475177 -0800
@@ -717,11 +717,11 @@ unsigned long page_address_in_vma(struct
 		if (!vma->anon_vma || !page__anon_vma ||
 		    vma->anon_vma->root != page__anon_vma->root)
 			return -EFAULT;
-	} else if (page->mapping) {
-		if (!vma->vm_file || vma->vm_file->f_mapping != page->mapping)
-			return -EFAULT;
-	} else
+	} else if (!vma->vm_file) {
+		return -EFAULT;
+	} else if (vma->vm_file->f_mapping != compound_head(page)->mapping) {
 		return -EFAULT;
+	}
 	address = __vma_address(page, vma);
 	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
 		return -EFAULT;
