Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4115416AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 06:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhIXEQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 00:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhIXEQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 00:16:17 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4C9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 21:14:45 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q125so12074435qkd.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 21:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wo5+YT4FAEs3BsYTUC5laEd8fuRm8H2TtgaNzbZpkpw=;
        b=N6ooeHLc0YzrYjENakNJkiFKHQBUD0A91XgGgV/FMM+yMSYxMOsf9PjmzS3MeYW7GT
         MnpUcorzKpM3Bj2T6vBBB3B8/9KzbNXDgkEq4F3yxn51UFR/J0CYRRVqt6kzkdEGzfPW
         LN4FddN72EWn80Wlq4vsK7zaxqrTIeMWfz2rK9XjDxIlfcLimv1RxmGELSMHH0v89yPG
         NPW+X7CBxQLbUUoN3fjV7dELdjFqNBgZP7oMZkyAFRN2CHb4xJbQniG8aFow/tpC1Zz+
         ziQ4hE7iP5gpYTQI9wPNNo3zMoZVC1C/H0zb0H4bLPnMiKUkWlJ941PAJiApbrUG17Xe
         qZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wo5+YT4FAEs3BsYTUC5laEd8fuRm8H2TtgaNzbZpkpw=;
        b=qY+uGFlMeDUh9exnMR+xPRWneOA+7+1K9WH/iUslL50RA5+3LmOHsK7GnNuH7uApTk
         /vQSzgCmTAGXVexvgWsE3PFNuA7f0EjmpWQWl2vmAS1JsP76WwKhVBK40Ixto20Im6Lg
         sZwDqq/3mknavxr3Xh2wR4SbkgaiL995OVnuWCzepV+/hbvuM14oLHUm1HyREMLX9zyd
         dyVUKe4FMa/rjr4gzNSi+ss6g3Rz2fKnMWOSr08FExpklbNlxg2O2oBYLZ6CJOLHdqJQ
         MdnNUxt0sgtdukxIKm9oXSkBS67GxurKpoM1NjWI48XrqqZ41cdOjNqFRfPIUFUPxGyB
         +h9Q==
X-Gm-Message-State: AOAM530w9oYXDyCN32jzSEKQeTYIgGIukwXouwuPjINvcncZASrhra0B
        jyYB3dnRbyFcRSTb4hAHcjx8uw==
X-Google-Smtp-Source: ABdhPJxyMjL4tECiJ9L+FBKdrvjmDcTOGX+7UtU+6y/KusLb/hd9olMa99MMwXBbJf2NhPFhyKR0Uw==
X-Received: by 2002:ae9:dd83:: with SMTP id r125mr8757419qkf.159.1632456883903;
        Thu, 23 Sep 2021 21:14:43 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v17sm5590811qkp.75.2021.09.23.21.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 21:14:43 -0700 (PDT)
Date:   Thu, 23 Sep 2021 21:14:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Peter Xu <peterx@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v4 3/4] mm: Drop first_index/last_index in zap_details
In-Reply-To: <20210915181535.11238-1-peterx@redhat.com>
Message-ID: <11a5e5d0-5e91-312e-84ac-b62a153d738@google.com>
References: <20210915181456.10739-1-peterx@redhat.com> <20210915181535.11238-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021, Peter Xu wrote:

> The first_index/last_index parameters in zap_details are actually only used in
> unmap_mapping_range_tree().  At the meantime, this function is only called by
> unmap_mapping_pages() once.  Instead of passing these two variables through the
> whole stack of page zapping code, remove them from zap_details and let them
> simply be parameters of unmap_mapping_range_tree(), which is inlined.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Liam Howlett <liam.howlett@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

And this one is fine too, thanks.  I don't know whether it saves anything
(ah yes, with args in registers not on the stack, should save a little),
but it's helpful to limit the scope of those indices.

You may wonder how they came to be in zap_details: that dates from the
days of remap_file_pages(): nonlinear vmas, in which the zapper needed
to check each pte_file()'s offset against first and last index, to
decide whether to zap or not.  They should have been removed in 4.0.

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  include/linux/mm.h |  2 --
>  mm/memory.c        | 31 ++++++++++++++++++-------------
>  2 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a52aba448f..d1126f731221 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1722,8 +1722,6 @@ extern void user_shm_unlock(size_t, struct ucounts *);
>   */
>  struct zap_details {
>  	struct address_space *check_mapping;	/* Check page->mapping if set */
> -	pgoff_t	first_index;			/* Lowest page->index to unmap */
> -	pgoff_t last_index;			/* Highest page->index to unmap */
>  	struct page *single_page;		/* Locked page to be unmapped */
>  };
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 7b095f07c4ef..a7e427177817 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3321,20 +3321,20 @@ static void unmap_mapping_range_vma(struct vm_area_struct *vma,
>  }
>  
>  static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
> +					    pgoff_t first_index,
> +					    pgoff_t last_index,
>  					    struct zap_details *details)
>  {
>  	struct vm_area_struct *vma;
>  	pgoff_t vba, vea, zba, zea;
>  
> -	vma_interval_tree_foreach(vma, root,
> -			details->first_index, details->last_index) {
> -
> +	vma_interval_tree_foreach(vma, root, first_index, last_index) {
>  		vba = vma->vm_pgoff;
>  		vea = vba + vma_pages(vma) - 1;
> -		zba = details->first_index;
> +		zba = first_index;
>  		if (zba < vba)
>  			zba = vba;
> -		zea = details->last_index;
> +		zea = last_index;
>  		if (zea > vea)
>  			zea = vea;
>  
> @@ -3360,18 +3360,22 @@ void unmap_mapping_page(struct page *page)
>  {
>  	struct address_space *mapping = page->mapping;
>  	struct zap_details details = { };
> +	pgoff_t	first_index;
> +	pgoff_t	last_index;
>  
>  	VM_BUG_ON(!PageLocked(page));
>  	VM_BUG_ON(PageTail(page));
>  
> +	first_index = page->index;
> +	last_index = page->index + thp_nr_pages(page) - 1;
> +
>  	details.check_mapping = mapping;
> -	details.first_index = page->index;
> -	details.last_index = page->index + thp_nr_pages(page) - 1;
>  	details.single_page = page;
>  
>  	i_mmap_lock_write(mapping);
>  	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> -		unmap_mapping_range_tree(&mapping->i_mmap, &details);
> +		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
> +					 last_index, &details);
>  	i_mmap_unlock_write(mapping);
>  }
>  
> @@ -3391,16 +3395,17 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  		pgoff_t nr, bool even_cows)
>  {
>  	struct zap_details details = { };
> +	pgoff_t	first_index = start;
> +	pgoff_t	last_index = start + nr - 1;
>  
>  	details.check_mapping = even_cows ? NULL : mapping;
> -	details.first_index = start;
> -	details.last_index = start + nr - 1;
> -	if (details.last_index < details.first_index)
> -		details.last_index = ULONG_MAX;
> +	if (last_index < first_index)
> +		last_index = ULONG_MAX;
>  
>  	i_mmap_lock_write(mapping);
>  	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> -		unmap_mapping_range_tree(&mapping->i_mmap, &details);
> +		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
> +					 last_index, &details);
>  	i_mmap_unlock_write(mapping);
>  }
>  
> -- 
> 2.31.1
