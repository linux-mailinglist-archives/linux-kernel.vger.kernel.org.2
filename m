Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767D13C885D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhGNQLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230427AbhGNQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626278888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HH+Au0Fkq26lvoJbZZLuQQG/8KQlhdV48YMU3sDbERU=;
        b=KR5mfYwBsAR9P7sFleWnVbw3JDCSnOjVFskqPgl5vnHxd6MQN9RaYOnU5KAp+8ExbOU3B/
        ZTW9nv5S4or1qXt7MHWAWbAPJSngYkX0EOf7zPz2nvl46VDQ+izxBJ+XLUlniDp0zEWhb+
        R4Cmils/d6yzDx/pvtX7tf5Q0ZGThSQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-jra4Mw0IO9KUgN43Tlx2DQ-1; Wed, 14 Jul 2021 12:08:06 -0400
X-MC-Unique: jra4Mw0IO9KUgN43Tlx2DQ-1
Received: by mail-qk1-f200.google.com with SMTP id u14-20020a05620a120eb02903b8bd5c7d95so1007432qkj.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HH+Au0Fkq26lvoJbZZLuQQG/8KQlhdV48YMU3sDbERU=;
        b=fk2zreQTFeH1PjsnQwRMYj2XQpeUqj9J6WqtiHXPsAJRv1vTbVEDCkG8PuonCKnqHJ
         rpwiL8KK6T1syNScYT9DWNLrhd68e2hA8tZ8AW91IU/UXXQFZ+Z+BvJ/J7I2SsAS1ilp
         CM6UvJKXj32EYDVSbW4ACdQAXQelLruHMuIQEKiCeKBgPddQFump/TXREdlc1jRtxhUz
         fLm4L1Rt4hED2fBwWr/GeOalpjGAJ+TOzSl8l7bV5So2lkUFnsJgl09QbtoSEqudD31v
         vnqguDa1DfM8pRB4WryWx/ies6y0KUANSRQU/E3kUpOCRWdK69cqUbbAtMPYZRNUzDox
         eEuQ==
X-Gm-Message-State: AOAM531h4dn57CVZzl9ozVeTpE6YnstPHO/kyDq5NFplDMHQqftyR6IZ
        DlngMEliT9dKDLgoJNEtotjtf//FUQcmi0BGAeXbAhdWWNlHuSB4H4ZfAk7eb74PSUaKEfscIL5
        VsBUSNH4qfFBS83dlY0i12XlB
X-Received: by 2002:a05:620a:1526:: with SMTP id n6mr10604719qkk.401.1626278886233;
        Wed, 14 Jul 2021 09:08:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMZJjNXTcEoRJLHQHgDwywge6lSCX8DuheHLeq3r6bZDLM0okim6nQAN5BonsmlTokGR4f0g==
X-Received: by 2002:a05:620a:1526:: with SMTP id n6mr10604690qkk.401.1626278885968;
        Wed, 14 Jul 2021 09:08:05 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id c190sm660936qkg.46.2021.07.14.09.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:08:05 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:08:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH 1/1] pagemap: report swap location for shared pages
Message-ID: <YO8L5PTdAs+vPeIx@t490s>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
 <20210714152426.216217-2-tiberiu.georgescu@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714152426.216217-2-tiberiu.georgescu@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 03:24:26PM +0000, Tiberiu Georgescu wrote:
> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
> entry is cleared. In many cases, there is no difference between swapped-out
> shared pages and newly allocated, non-dirty pages in the pagemap interface.
> 
> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
> make use of the XArray associated with the virtual memory area struct
> passed as an argument. The XArray contains the location of virtual pages
> in the page cache, swap cache or on disk. If they are on either of the
> caches, then the original implementation still works. If not, then the
> missing information will be retrieved from the XArray.
> 
> Co-developed-by: Florian Schmidt <florian.schmidt@nutanix.com>
> Signed-off-by: Florian Schmidt <florian.schmidt@nutanix.com>
> Co-developed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
> Signed-off-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
> Co-developed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
> Signed-off-by: Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
> ---
>  fs/proc/task_mmu.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index eb97468dfe4c..b17c8aedd32e 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1359,12 +1359,25 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
>  	return err;
>  }
>  
> +static void *get_xa_entry_at_vma_addr(struct vm_area_struct *vma,
> +		unsigned long addr)
> +{
> +	struct inode *inode = file_inode(vma->vm_file);
> +	struct address_space *mapping = inode->i_mapping;
> +	pgoff_t offset = linear_page_index(vma, addr);
> +
> +	return xa_load(&mapping->i_pages, offset);
> +}
> +
>  static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>  {
>  	u64 frame = 0, flags = 0;
>  	struct page *page = NULL;
>  
> +	if (vma->vm_flags & VM_SOFTDIRTY)
> +		flags |= PM_SOFT_DIRTY;
> +
>  	if (pte_present(pte)) {
>  		if (pm->show_pfn)
>  			frame = pte_pfn(pte);
> @@ -1374,13 +1387,22 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  			flags |= PM_SOFT_DIRTY;
>  		if (pte_uffd_wp(pte))
>  			flags |= PM_UFFD_WP;
> -	} else if (is_swap_pte(pte)) {
> +	} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
>  		swp_entry_t entry;
> -		if (pte_swp_soft_dirty(pte))
> -			flags |= PM_SOFT_DIRTY;
> -		if (pte_swp_uffd_wp(pte))
> -			flags |= PM_UFFD_WP;
> -		entry = pte_to_swp_entry(pte);
> +		if (is_swap_pte(pte)) {
> +			entry = pte_to_swp_entry(pte);
> +			if (pte_swp_soft_dirty(pte))
> +				flags |= PM_SOFT_DIRTY;
> +			if (pte_swp_uffd_wp(pte))
> +				flags |= PM_UFFD_WP;
> +		} else {
> +			void *xa_entry = get_xa_entry_at_vma_addr(vma, addr);
> +
> +			if (xa_is_value(xa_entry))
> +				entry = radix_to_swp_entry(xa_entry);
> +			else
> +				goto out;
> +		}
>  		if (pm->show_pfn)
>  			frame = swp_type(entry) |
>  				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> @@ -1393,9 +1415,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  		flags |= PM_FILE;
>  	if (page && page_mapcount(page) == 1)
>  		flags |= PM_MMAP_EXCLUSIVE;
> -	if (vma->vm_flags & VM_SOFTDIRTY)
> -		flags |= PM_SOFT_DIRTY;

IMHO moving this to the entry will only work for the initial iteration, however
it won't really help anything, as soft-dirty should always be used in pair with
clear_refs written with value "4" first otherwise all pages will be marked
soft-dirty then the pagemap data is meaningless.

After the "write 4" op VM_SOFTDIRTY will be cleared and I expect the test case
to see all zeros again even with the patch.

I think one way to fix this is to do something similar to uffd-wp: we leave a
marker in pte showing that this is soft-dirtied pte even if swapped out.
However we don't have a mechanism for that yet in current linux, and the
uffd-wp series is the first one trying to introduce something like that.

Thanks,

-- 
Peter Xu

