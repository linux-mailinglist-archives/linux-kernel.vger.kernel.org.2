Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5CB41612D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbhIWOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbhIWOke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:40:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:39:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p29so27181553lfa.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=21b0k6N9522huwD1D3UiPVs+eYwH7HdWgHDdKuhyH2I=;
        b=wjqslYxLsLqD0NNmIk13VnZkNZ8aZRqvCGd5J3hlaLZLdwY3eg2O188Vq0tnJx9gIU
         +eq+N8WmWrCjZeMDo8ODLmwAR1qCI/EThgtYhyIEhxt6PGzVURUNCxmT+QtsGbfrLVKc
         +tXxPBr2A5gEqZa8xotOloONAUzeVXy2mo3sTGlGjqP6wojBheytUc3aD1r5aG9IIHR3
         iXI2TVSkMpvGz5EG7uQOoD3SJzpSDmEvZsDKyGMQZoKNQNHznln65M+TE5fDAy2xMsxz
         HKX4sprwsJ/p8312p6HEJxBkkJK/AGZM+igOGOSJesayVRNJFs0PBzZi2vuOPiHwkK6B
         yVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21b0k6N9522huwD1D3UiPVs+eYwH7HdWgHDdKuhyH2I=;
        b=zpHPz8sKpwr32AAiGkMRV7oRD9zY4J1GkrV022hsKm+BmTLkSm75Qf+VZGEkvSRWSp
         Jfx6GJyuxnYk/XqdkAQpAXCbn1JN7xY4bW4NnmEb4zLr+ybbLDWTdThjaP9NuXVtRIh7
         0QQ5igeNlf9YV8EtrYLifF1FqWiKcf7of4T/UfgVbVmuYFK96zvPxfpnxu6aSvRFdEQw
         kd6cToEHMknj5aTmYFCvcKiiDYGErNwUFyIdUkGk4KQ8MhqLDb1MCKk52AwIsPoqwrot
         4mjYCRzl1alr1Hw0qkYEyai8xAaJ56hDYf0AD66s0kT0DVi4mwt0yNgVPZl7ajcYVOxs
         xGUg==
X-Gm-Message-State: AOAM530V6re2x1N0DIX8vZW1/2BvF6i9wC6Oz5QKbMW3FzgG0TLHIULf
        cKdRibNOxW+XPztu4oQFLjZiRA==
X-Google-Smtp-Source: ABdhPJwjmC/zbN0YHpPzPGyin8WcYkmUxmeaEAXkqeGBlVdE7uW7FNzgY5/6thLKNDfaHWv1sTAMCA==
X-Received: by 2002:ac2:46c8:: with SMTP id p8mr4476596lfo.158.1632407940111;
        Thu, 23 Sep 2021 07:39:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v5sm476208lfq.154.2021.09.23.07.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:38:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B39C110306C; Thu, 23 Sep 2021 17:39:01 +0300 (+03)
Date:   Thu, 23 Sep 2021 17:39:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        peterx@redhat.com, osalvador@suse.de, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 1/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <20210923143901.mdc6rejuh7hmr5vh@box.shutemov.name>
References: <20210923032830.314328-1-shy828301@gmail.com>
 <20210923032830.314328-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923032830.314328-2-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:28:26PM -0700, Yang Shi wrote:
> When handling shmem page fault the THP with corrupted subpage could be PMD
> mapped if certain conditions are satisfied.  But kernel is supposed to
> send SIGBUS when trying to map hwpoisoned page.
> 
> There are two paths which may do PMD map: fault around and regular fault.
> 
> Before commit f9ce0be71d1f ("mm: Cleanup faultaround and finish_fault() codepaths")
> the thing was even worse in fault around path.  The THP could be PMD mapped as
> long as the VMA fits regardless what subpage is accessed and corrupted.  After
> this commit as long as head page is not corrupted the THP could be PMD mapped.
> 
> In the regulat fault path the THP could be PMD mapped as long as the corrupted

s/regulat/regular/

> page is not accessed and the VMA fits.
> 
> This loophole could be fixed by iterating every subpage to check if any
> of them is hwpoisoned or not, but it is somewhat costly in page fault path.
> 
> So introduce a new page flag called HasHWPoisoned on the first tail page.  It
> indicates the THP has hwpoisoned subpage(s).  It is set if any subpage of THP
> is found hwpoisoned by memory failure and cleared when the THP is freed or
> split.
> 
> Cc: <stable@vger.kernel.org>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---

...

> diff --git a/mm/filemap.c b/mm/filemap.c
> index dae481293b5d..740b7afe159a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3195,12 +3195,14 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
>  	}
>  
>  	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> -	    vm_fault_t ret = do_set_pmd(vmf, page);
> -	    if (!ret) {
> -		    /* The page is mapped successfully, reference consumed. */
> -		    unlock_page(page);
> -		    return true;
> -	    }
> +		vm_fault_t ret = do_set_pmd(vmf, page);
> +		if (ret == VM_FAULT_FALLBACK)
> +			goto out;

Hm.. What? I don't get it. Who will establish page table in the pmd then?

> +		if (!ret) {
> +			/* The page is mapped successfully, reference consumed. */
> +			unlock_page(page);
> +			return true;
> +		}
>  	}
>  
>  	if (pmd_none(*vmf->pmd)) {
> @@ -3220,6 +3222,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
>  		return true;
>  	}
>  
> +out:
>  	return false;
>  }
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5e9ef0fc261e..0574b1613714 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2426,6 +2426,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
>  	lruvec = lock_page_lruvec(head);
>  
> +	ClearPageHasHWPoisoned(head);
> +

Do we serialize the new flag with lock_page() or what? I mean what
prevents the flag being set again after this point, but before
ClearPageCompound()?

-- 
 Kirill A. Shutemov
