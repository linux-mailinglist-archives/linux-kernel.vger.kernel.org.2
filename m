Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D310416B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 06:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhIXEqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 00:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhIXEqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 00:46:04 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9219C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 21:44:30 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d8so8404100qtd.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 21:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=gPYCuDbvMf79tood1FE9hbAIqwGfw8AvWs2PSHrUP8o=;
        b=MQ1By/FYcRqrJFVcfIJGhCzjmDszrwSAaqQFDn1/gQGouwH3HYOpSD99NH659wh8xr
         ew9MRvm8WsUzGDCYsUThcQyfw1nqULNGEjPujVeUDWZiB70M5Lj06tBfEA/EC2grdItn
         qVU08IUDBy7/SZgV1oXjIJWqzGY3aKrBw3pnViFtoaPhOOyeYWFik64BfZU3nDFrvfG2
         TpUlBkPAyi2XuKHDUnET8Ps/Nj3Pya/ztiSR8Iz2PVE4cdtOwLBMDQ1g7zErlagII2ZN
         UdzCjWPOnO0i94N0y1p3W6DmiMxX0bGU9d6SWwGtGGxhCFl+Uk5bHYLD3uc/AkKfRgSG
         gl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=gPYCuDbvMf79tood1FE9hbAIqwGfw8AvWs2PSHrUP8o=;
        b=w1ttYIRS/v7BgpuUSpCkVRd0c+lSR/m+wTq6yPkwwu0HoxplqSxyqMW2VKjpjPeYCE
         jHm/N2Jr6jfCITr7VmZDmpHHvTeJBzxAbFQdp4XiaHWuki+3af2VKDU6zMd3iEs1+4bC
         X4VxixnfYwO3GM/T6/+fqwJRqopxEko/eN0kIXgTQ1BS+iIFFG9/P9gZjtZ+G5nAK9np
         r+pSohwky/yQq0revsRNLJbsguI2SfMyR9bsdMnbBh0YnI9wRs+FvcBAZUc3EH3F4pgp
         uFlMVNR/iWCmvjw+3rbH7FDbEe4qKpDyrMP0q2No0O+outHiU6geeO1KXUw8oFsrELwq
         NLvA==
X-Gm-Message-State: AOAM5336gP2FKZsEPqGHNcHVYq0CYS34dbBMKyRcYDNh31MxKdO+A/0o
        vYuEazGX/JofGBw9tnhtFO1KvQ==
X-Google-Smtp-Source: ABdhPJz0Jk6U9SixoASSKntjzJqscl0+BZsorWyeWOkuooX+jtgVtPnjzWRtZ3vV4tgLFctUDPGr3w==
X-Received: by 2002:ac8:13c4:: with SMTP id i4mr2254076qtj.350.1632458669817;
        Thu, 23 Sep 2021 21:44:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s18sm4888880qtn.46.2021.09.23.21.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 21:44:29 -0700 (PDT)
Date:   Thu, 23 Sep 2021 21:44:27 -0700 (PDT)
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
Subject: Re: [PATCH v4 4/4] mm: Add zap_skip_check_mapping() helper
In-Reply-To: <20210915181538.11288-1-peterx@redhat.com>
Message-ID: <4746b58e-34e9-619d-fb16-afa1fb7fff8c@google.com>
References: <20210915181456.10739-1-peterx@redhat.com> <20210915181538.11288-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2021, Peter Xu wrote:

> Use the helper for the checks.  Rename "check_mapping" into "zap_mapping"
> because "check_mapping" looks like a bool but in fact it stores the mapping
> itself.  When it's set, we check the mapping (it must be non-NULL).  When it's
> cleared we skip the check, which works like the old way.
> 
> Move the duplicated comments to the helper too.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Again, I won't NAK, but I have no enthusiasm for this at all: our tastes
clearly differ.  I don't find the new name helpful, I don't find the
separated "helper" helpful, and you have hidden the helpful comment
(but I'd be on firmer ground if the unmap_shared_mapping_pages() it
referred to had ever existed! perhaps it was in an intermediate tree).

But then I would feel this way, wouldn't I?
See dd9fd0e03de ("[PATCH] rmap: nonlinear truncation") in
//git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

I'm glad to see that you have dropped 5/5 for now:
I was not keen on that one either.

Hugh

> ---
>  include/linux/mm.h | 16 +++++++++++++++-
>  mm/memory.c        | 29 ++++++-----------------------
>  2 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d1126f731221..ed44f31615d9 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1721,10 +1721,24 @@ extern void user_shm_unlock(size_t, struct ucounts *);
>   * Parameter block passed down to zap_pte_range in exceptional cases.
>   */
>  struct zap_details {
> -	struct address_space *check_mapping;	/* Check page->mapping if set */
> +	struct address_space *zap_mapping;	/* Check page->mapping if set */
>  	struct page *single_page;		/* Locked page to be unmapped */
>  };
>  
> +/*
> + * We set details->zap_mappings when we want to unmap shared but keep private
> + * pages. Return true if skip zapping this page, false otherwise.
> + */
> +static inline bool
> +zap_skip_check_mapping(struct zap_details *details, struct page *page)
> +{
> +	if (!details || !page)
> +		return false;
> +
> +	return details->zap_mapping &&
> +	    (details->zap_mapping != page_rmapping(page));
> +}
> +
>  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> diff --git a/mm/memory.c b/mm/memory.c
> index a7e427177817..8db8ce0ca6ce 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1333,16 +1333,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			struct page *page;
>  
>  			page = vm_normal_page(vma, addr, ptent);
> -			if (unlikely(details) && page) {
> -				/*
> -				 * unmap_shared_mapping_pages() wants to
> -				 * invalidate cache without truncating:
> -				 * unmap shared but keep private pages.
> -				 */
> -				if (details->check_mapping &&
> -				    details->check_mapping != page_rmapping(page))
> -					continue;
> -			}
> +			if (unlikely(zap_skip_check_mapping(details, page)))
> +				continue;
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			tlb_remove_tlb_entry(tlb, pte, addr);
> @@ -1375,17 +1367,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		    is_device_exclusive_entry(entry)) {
>  			struct page *page = pfn_swap_entry_to_page(entry);
>  
> -			if (unlikely(details && details->check_mapping)) {
> -				/*
> -				 * unmap_shared_mapping_pages() wants to
> -				 * invalidate cache without truncating:
> -				 * unmap shared but keep private pages.
> -				 */
> -				if (details->check_mapping !=
> -				    page_rmapping(page))
> -					continue;
> -			}
> -
> +			if (unlikely(zap_skip_check_mapping(details, page)))
> +				continue;
>  			pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>  			rss[mm_counter(page)]--;
>  
> @@ -3369,7 +3352,7 @@ void unmap_mapping_page(struct page *page)
>  	first_index = page->index;
>  	last_index = page->index + thp_nr_pages(page) - 1;
>  
> -	details.check_mapping = mapping;
> +	details.zap_mapping = mapping;
>  	details.single_page = page;
>  
>  	i_mmap_lock_write(mapping);
> @@ -3398,7 +3381,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  	pgoff_t	first_index = start;
>  	pgoff_t	last_index = start + nr - 1;
>  
> -	details.check_mapping = even_cows ? NULL : mapping;
> +	details.zap_mapping = even_cows ? NULL : mapping;
>  	if (last_index < first_index)
>  		last_index = ULONG_MAX;
>  
> -- 
> 2.31.1
