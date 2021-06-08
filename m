Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7BC39FFFB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhFHSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234677AbhFHSfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623177236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=delY2SS1lhupvaRgnNu9Xn4xsk68fX/j14ghIq7gu1s=;
        b=Typv4xLA1Wiiv3Nv97Od6KsrE+qL4WS5hkGMNPIIZfUiYFGOgVjQm2SJ1FHeJ7U4h75q3p
        vTPSn1Y1ioCiNefV0T6ky/peSjRrC7NVis4PU5txe9ZgGwHiusXBIJ2ZEZG/dSjVi907Mh
        yGf5vvbg5a0RuRNVm1K1HmzdJpUZOAo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-tzFEWqCwN_qEql8LVPonXQ-1; Tue, 08 Jun 2021 14:33:55 -0400
X-MC-Unique: tzFEWqCwN_qEql8LVPonXQ-1
Received: by mail-qk1-f197.google.com with SMTP id k125-20020a3788830000b02903a65618d46cso15675194qkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 11:33:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=delY2SS1lhupvaRgnNu9Xn4xsk68fX/j14ghIq7gu1s=;
        b=G9g1y3ldBjvyum0sBlINq4HBStRIG0jYhEGVuCorGqXC0cAiu7zMwKw0LIPNoZVrug
         bS7aMndVZNJOH0m05sZ3tTwB1XiUuES7M2HX/MVQuM+B7wY0c37EcB06kpZn4B49QQCf
         4tVjmKTNpW0HEVqe7/4wycnZlUqNkekWGe9GnU4j+ckroPrPRvg0T22glI5mlr9Hc08f
         j2exFMhRdhGIBnpfMlSOZFAFyeDmuBKfCYSdEaWmTlPxtCRb7Hl5amwAN8bFdU8Q/Dm1
         bytRuG6z1QLlt4V3RhDY/LmwqSHeYm1hwfmoTIcWgi7EBFFdCMEgLzlXQUet+C7lk4Uk
         geOA==
X-Gm-Message-State: AOAM530h/K3ebrsEgFM/RvXZz/FyMYMg0IQQkuxXUOLvwUOVzo85iNNq
        4aSdCSvMppBLmF5qlE5zWPFM6o7NLV+H6puNPaeTQEekPHS4tusyPXcTZ/eYlKs2Tdrp/ok3gJx
        jWj6U3UtyYSCfB41abHTUPMIz
X-Received: by 2002:ac8:74d3:: with SMTP id j19mr17841560qtr.208.1623177234623;
        Tue, 08 Jun 2021 11:33:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCzpIjpybZgCqNOGL7UtIAt5dTDg/VWSRnVpPRNFhhv0BAITQtxCHxRMSpNs30HAG02DhEqA==
X-Received: by 2002:ac8:74d3:: with SMTP id j19mr17841531qtr.208.1623177234325;
        Tue, 08 Jun 2021 11:33:54 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-88-174-93-75-200.dsl.bell.ca. [174.93.75.200])
        by smtp.gmail.com with ESMTPSA id i21sm12311627qkl.20.2021.06.08.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:33:53 -0700 (PDT)
Date:   Tue, 8 Jun 2021 14:33:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        rcampbell@nvidia.com, linux-doc@vger.kernel.org,
        nouveau@lists.freedesktop.org, hughd@google.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hch@infradead.org, bskeggs@redhat.com, jgg@nvidia.com,
        shakeelb@google.com, jhubbard@nvidia.com, willy@infradead.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v10 07/10] mm: Device exclusive memory access
Message-ID: <YL+4ENiwbn9QAa2V@t490s>
References: <20210607075855.5084-1-apopple@nvidia.com>
 <20210607075855.5084-8-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210607075855.5084-8-apopple@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 05:58:52PM +1000, Alistair Popple wrote:

[...]

> +static bool page_make_device_exclusive_one(struct page *page,
> +		struct vm_area_struct *vma, unsigned long address, void *priv)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	struct page_vma_mapped_walk pvmw = {
> +		.page = page,
> +		.vma = vma,
> +		.address = address,
> +	};
> +	struct make_exclusive_args *args = priv;
> +	pte_t pteval;
> +	struct page *subpage;
> +	bool ret = true;
> +	struct mmu_notifier_range range;
> +	swp_entry_t entry;
> +	pte_t swp_pte;
> +
> +	mmu_notifier_range_init_owner(&range, MMU_NOTIFY_EXCLUSIVE, 0, vma,
> +				      vma->vm_mm, address, min(vma->vm_end,
> +				      address + page_size(page)), args->owner);
> +	mmu_notifier_invalidate_range_start(&range);
> +
> +	while (page_vma_mapped_walk(&pvmw)) {
> +		/* Unexpected PMD-mapped THP? */
> +		VM_BUG_ON_PAGE(!pvmw.pte, page);

[1]

> +
> +		if (!pte_present(*pvmw.pte)) {
> +			ret = false;
> +			page_vma_mapped_walk_done(&pvmw);
> +			break;
> +		}
> +
> +		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> +		address = pvmw.address;

I raised a question here previously and didn't get an answer...

https://lore.kernel.org/linux-mm/YLDr%2FRyAdUR4q0kk@t490s/

I think I get your point now and it does look possible that the split page can
still be mapped somewhere else as thp, then having some subpage maintainance
looks necessary.  The confusing part is above [1] you've also got that
VM_BUG_ON_PAGE() assuming it must not be a mapped pmd at all..

Then I remembered these code majorly come from the try_to_unmap() so I looked
there.  I _think_ what's missing here is something like:

	if (flags & TTU_SPLIT_HUGE_PMD)
		split_huge_pmd_address(vma, address, false, page);

at the entry of page_make_device_exclusive_one()?

That !pte assertion in try_to_unmap() makes sense to me as long as it has split
the thp page first always.  However seems not the case for FOLL_SPLIT_PMD as
you previously mentioned.

Meanwhile, I also started to wonder whether it's even right to call rmap_walk()
with tail pages...  Please see below.

> +
> +		/* Nuke the page table entry. */
> +		flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
> +		pteval = ptep_clear_flush(vma, address, pvmw.pte);
> +
> +		/* Move the dirty bit to the page. Now the pte is gone. */
> +		if (pte_dirty(pteval))
> +			set_page_dirty(page);
> +
> +		/*
> +		 * Check that our target page is still mapped at the expected
> +		 * address.
> +		 */
> +		if (args->mm == mm && args->address == address &&
> +		    pte_write(pteval))
> +			args->valid = true;
> +
> +		/*
> +		 * Store the pfn of the page in a special migration
> +		 * pte. do_swap_page() will wait until the migration
> +		 * pte is removed and then restart fault handling.
> +		 */
> +		if (pte_write(pteval))
> +			entry = make_writable_device_exclusive_entry(
> +							page_to_pfn(subpage));
> +		else
> +			entry = make_readable_device_exclusive_entry(
> +							page_to_pfn(subpage));
> +		swp_pte = swp_entry_to_pte(entry);
> +		if (pte_soft_dirty(pteval))
> +			swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +		if (pte_uffd_wp(pteval))
> +			swp_pte = pte_swp_mkuffd_wp(swp_pte);
> +
> +		set_pte_at(mm, address, pvmw.pte, swp_pte);
> +
> +		/*
> +		 * There is a reference on the page for the swap entry which has
> +		 * been removed, so shouldn't take another.
> +		 */
> +		page_remove_rmap(subpage, false);
> +	}
> +
> +	mmu_notifier_invalidate_range_end(&range);
> +
> +	return ret;
> +}
> +
> +/**
> + * page_make_device_exclusive - mark the page exclusively owned by a device
> + * @page: the page to replace page table entries for
> + * @mm: the mm_struct where the page is expected to be mapped
> + * @address: address where the page is expected to be mapped
> + * @owner: passed to MMU_NOTIFY_EXCLUSIVE range notifier callbacks
> + *
> + * Tries to remove all the page table entries which are mapping this page and
> + * replace them with special device exclusive swap entries to grant a device
> + * exclusive access to the page. Caller must hold the page lock.
> + *
> + * Returns false if the page is still mapped, or if it could not be unmapped
> + * from the expected address. Otherwise returns true (success).
> + */
> +static bool page_make_device_exclusive(struct page *page, struct mm_struct *mm,
> +				unsigned long address, void *owner)
> +{
> +	struct make_exclusive_args args = {
> +		.mm = mm,
> +		.address = address,
> +		.owner = owner,
> +		.valid = false,
> +	};
> +	struct rmap_walk_control rwc = {
> +		.rmap_one = page_make_device_exclusive_one,
> +		.done = page_not_mapped,
> +		.anon_lock = page_lock_anon_vma_read,
> +		.arg = &args,
> +	};
> +
> +	/*
> +	 * Restrict to anonymous pages for now to avoid potential writeback
> +	 * issues.
> +	 */
> +	if (!PageAnon(page))
> +		return false;
> +
> +	rmap_walk(page, &rwc);

Here we call rmap_walk() on each page we've got.  If it was thp then IIUC it'll
become the tail pages to walk as the outcome of FOLL_SPLIT_PMD gup (please
refer to the last reply of mine).  However now I'm uncertain whether we can do
rmap_walk on tail page at all...  As rmap_walk_anon() has thp_nr_pages() which
has:

	VM_BUG_ON_PGFLAGS(PageTail(page), page);

So... for thp mappings, wondering whether we should do normal GUP (without
SPLIT), pass in always normal or head pages into rmap_walk(), but then
unconditionally split_huge_pmd_address() in page_make_device_exclusive_one()?

Please correct me if I made silly mistakes on above, as I am looking at the
code when/during trying to review the patch, so it's possible I missed
something again.  Neither does this code a huge matter since it's not in
general mm path, but still raise this question up.

Thanks,

> +
> +	return args.valid && !page_mapcount(page);
> +}
> +
> +/**
> + * make_device_exclusive_range() - Mark a range for exclusive use by a device
> + * @mm: mm_struct of assoicated target process
> + * @start: start of the region to mark for exclusive device access
> + * @end: end address of region
> + * @pages: returns the pages which were successfully marked for exclusive access
> + * @owner: passed to MMU_NOTIFY_EXCLUSIVE range notifier to allow filtering
> + *
> + * Returns: number of pages found in the range by GUP. A page is marked for
> + * exclusive access only if the page pointer is non-NULL.
> + *
> + * This function finds ptes mapping page(s) to the given address range, locks
> + * them and replaces mappings with special swap entries preventing userspace CPU
> + * access. On fault these entries are replaced with the original mapping after
> + * calling MMU notifiers.
> + *
> + * A driver using this to program access from a device must use a mmu notifier
> + * critical section to hold a device specific lock during programming. Once
> + * programming is complete it should drop the page lock and reference after
> + * which point CPU access to the page will revoke the exclusive access.
> + */
> +int make_device_exclusive_range(struct mm_struct *mm, unsigned long start,
> +				unsigned long end, struct page **pages,
> +				void *owner)
> +{
> +	long npages = (end - start) >> PAGE_SHIFT;
> +	unsigned long i;
> +
> +	npages = get_user_pages_remote(mm, start, npages,
> +				       FOLL_GET | FOLL_WRITE | FOLL_SPLIT_PMD,
> +				       pages, NULL, NULL);
> +	for (i = 0; i < npages; i++, start += PAGE_SIZE) {
> +		if (!trylock_page(pages[i])) {
> +			put_page(pages[i]);
> +			pages[i] = NULL;
> +			continue;
> +		}
> +
> +		if (!page_make_device_exclusive(pages[i], mm, start, owner)) {
> +			unlock_page(pages[i]);
> +			put_page(pages[i]);
> +			pages[i] = NULL;
> +		}
> +	}
> +
> +	return npages;
> +}
> +EXPORT_SYMBOL_GPL(make_device_exclusive_range);
> +#endif
> +
>  void __put_anon_vma(struct anon_vma *anon_vma)
>  {
>  	struct anon_vma *root = anon_vma->root;
> -- 
> 2.20.1
> 

-- 
Peter Xu

