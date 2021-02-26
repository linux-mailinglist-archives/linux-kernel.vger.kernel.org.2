Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212A0325F39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZIig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:38:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:40266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhBZIgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:36:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614328510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=74SXgFDetdDnTjCogr3wnRnxhW795+mhCDQ0YLlgLUE=;
        b=rWjplX1CjleXy+CBLkaMOvcu0jiGKu9PyZZOjv2DYZqFmd1zuQOBDDsuaWfz1VBCfiK4KM
        B8ZYdL84LMp8SyTdmpJq24SJlr716PICGhtvUomJCM8KvpINBSdifCECIJHuOx6wxUuEPP
        iuFrb5IehTwGrE+ZyLYDoR1LhDYE2bQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 247A4AC6E;
        Fri, 26 Feb 2021 08:35:10 +0000 (UTC)
Date:   Fri, 26 Feb 2021 09:35:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YDiyvQ2SCXxCjPJ2@dhcp22.suse.cz>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222135137.25717-2-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22-02-21 14:51:36, Oscar Salvador wrote:
> alloc_contig_range will fail if it ever sees a HugeTLB page within the
> range we are trying to allocate, even when that page is free and can be
> easily reallocated.
> This has proved to be problematic for some users of alloc_contic_range,
> e.g: CMA and virtio-mem, where those would fail the call even when those
> pages lay in ZONE_MOVABLE and are free.
> 
> We can do better by trying to replace such page.
> 
> Free hugepages are tricky to handle so as to no userspace application
> notices disruption, we need to replace the current free hugepage with
> a new one.
> 
> In order to do that, a new function called alloc_and_dissolve_huge_page
> is introduced.
> This function will first try to get a new fresh hugepage, and if it
> succeeds, it will replace the old one in the free hugepage pool.
> 
> All operations are being handled under hugetlb_lock, so no races are
> possible. The only exception is when page's refcount is 0, but it still
> has not been flagged as PageHugeFreed.

I think it would be helpful to call out that specific case explicitly
here. I can see only one scenario (are there more?)
__free_huge_page()		isolate_or_dissolve_huge_page
				  PageHuge() == T
				  alloc_and_dissolve_huge_page
				    alloc_fresh_huge_page()
				    spin_lock(hugetlb_lock)
				    // PageHuge() && !PageHugeFreed &&
				    // !PageCount()
				    spin_unlock(hugetlb_lock)
  spin_lock(hugetlb_lock)
  1) update_and_free_page
       PageHuge() == F
       __free_pages()
  2) enqueue_huge_page
       SetPageHugeFreed()
  spin_unlock(&hugetlb_lock)			    

> In this case we retry as the window race is quite small and we have high
> chances to succeed next time.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Thanks this looks much better than the initial version. One nit below.
Acked-by: Michal Hocko <mhocko@suse.com>

[...]
> +bool isolate_or_dissolve_huge_page(struct page *page)
> +{
> +	struct hstate *h = NULL;
> +	struct page *head;
> +	bool ret = false;
> +
> +	spin_lock(&hugetlb_lock);
> +	if (PageHuge(page)) {
> +		head = compound_head(page);
> +		h = page_hstate(head);
> +	}
> +	spin_unlock(&hugetlb_lock);
> +
> +	/*
> +	 * The page might have been dissolved from under our feet.
> +	 * If that is the case, return success as if we dissolved it ourselves.
> +	 */
> +	if (!h)
> +		return true;

I am still fighting with this construct a bit. It is not really clear
what the lock is protecting us from here. alloc_fresh_huge_page deals
with all potential races and this looks like an optimistic check to save
some work. But in fact the lock is really necessary for correctness
because hstate might be completely bogus without the lock or us holding
a reference on the poage. The following construct would be more
explicit and compact. What do you think?

	struct hstate *h;

	/*
	 * The page might have been dissloved from under our feet
	 * so make sure to carefully check the state under the lock.
	 * Return success on when racing as if we dissloved the page
	 * ourselves.
	 */
	spin_lock(&hugetlb_lock);
	if (PageHuge(page)) {
		head = compound_head(page);
		h = page_hstate(head);
	} else {
		spin_unlock(&hugetlb_lock);
		return true;
	}
	spin_unlock(&hugetlb_lock);

> +
> +	/*
> +	 * Fence off gigantic pages as there is a cyclic dependency
> +	 * between alloc_contig_range and them.
> +	 */
> +	if (hstate_is_gigantic(h))
> +		return ret;
> +
> +	if (!page_count(head) && alloc_and_dissolve_huge_page(h, head))
> +		ret = true;
> +
> +	return ret;
> +}
> +
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				    unsigned long addr, int avoid_reserve)
>  {
> -- 
> 2.16.3

-- 
Michal Hocko
SUSE Labs
