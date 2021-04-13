Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B21135E043
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhDMNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:40:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhDMNkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:40:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618321219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w4n0cxlCyqS1x0LaC8rVG8ZjMbw0TbHzMdAFoDindWE=;
        b=sBgYpizxtCNbxKBgSKLT+CY/2ieNI+cQo/TrblBb1knak94bMJEQ02v5sLATc6Pcm5ZFph
        ANqaUcaBsDHz7AXFuHTsThYx1tqUpuZOzWScyLhwL0U2BxOe5PBEgEXa8T3f1VpJnpQ2Nc
        vn2sIQoOeVB/jpRcuE0zICPVn5pmNkE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C672AFAA;
        Tue, 13 Apr 2021 13:40:19 +0000 (UTC)
Date:   Tue, 13 Apr 2021 15:40:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/7] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YHWfQjegLi4xekhM@dhcp22.suse.cz>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-6-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413104747.12177-6-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-04-21 12:47:45, Oscar Salvador wrote:
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
> The free page replacement is done under hugetlb_lock, so no external
> users of hugetlb will notice the change.
> To allocate the new huge page, we use alloc_buddy_huge_page(), so we
> do not have to deal with any counters, and prep_new_huge_page() is not
> called. This is valulable because in case we need to free the new page,
> we only need to call __free_pages().
> 
> Once we know that the page to be replaced is a genuine 0-refcounted
> huge page, we remove the old page from the freelist by remove_hugetlb_page().
> Then, we can call __prep_new_huge_page() and __prep_account_new_huge_page()
> for the new huge page to properly initialize it and increment the
> hstate->nr_huge_pages counter (previously decremented by
> remove_hugetlb_page()).
> Once done, the page is enqueued by enqueue_huge_page() and it is ready
> to be used.
> 
> There is one tricky case when
> page's refcount is 0 because it is in the process of being released.
> A missing PageHugeFreed bit will tell us that freeing is in flight so
> we retry after dropping the hugetlb_lock. The race window should be
> small and the next retry should make a forward progress.
> 
> E.g:
> 
> CPU0				CPU1
> free_huge_page()		isolate_or_dissolve_huge_page
> 				  PageHuge() == T
> 				  alloc_and_dissolve_huge_page
> 				    alloc_buddy_huge_page()
> 				    spin_lock_irq(hugetlb_lock)
> 				    // PageHuge() && !PageHugeFreed &&
> 				    // !PageCount()
> 				    spin_unlock_irq(hugetlb_lock)
>   spin_lock_irq(hugetlb_lock)
>   1) update_and_free_page
>        PageHuge() == F
>        __free_pages()
>   2) enqueue_huge_page
>        SetPageHugeFreed()
>   spin_unlock(&hugetlb_lock)
> 				  spin_lock_irq(hugetlb_lock)
>                                    1) PageHuge() == F (freed by case#1 from CPU0)
> 				   2) PageHuge() == T
>                                        PageHugeFreed() == T
>                                        - proceed with replacing the page
> 
> In the case above we retry as the window race is quite small and we have high
> chances to succeed next time.
> 
> With regard to the allocation, we restrict it to the node the page belongs
> to with __GFP_THISNODE, meaning we do not fallback on other node's zones.
> 
> Note that gigantic hugetlb pages are fenced off since there is a cyclic
> dependency between them and alloc_contig_range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>

One minor nit below
[...]

> +		/*
> +		 * Ok, old_page is still a genuine free hugepage. Remove it from
> +		 * the freelist and decrease the counters. These will be
> +		 * incremented again when calling __prep_account_new_huge_page()
> +		 * and enqueue_huge_page() for new_page. The counters will remain
> +		 * stable since this happens under the lock.
> +		 */
> +		remove_hugetlb_page(h, old_page, false);
> +
> +		/*
> +		 * Call __prep_new_huge_page() to construct the hugetlb page, and
> +		 * enqueue it then to place it in the freelists. After this,
> +		 * counters are back on track. Free hugepages have a refcount of 0,
> +		 * so we need to decrease new_page's count as well.
> +		 */
> +		__prep_new_huge_page(new_page);
> +		__prep_account_new_huge_page(h, nid);

I think it would help to put something like the following into the
comment above this really strange construct.

		/*
		 * new_page needs to be initialized with the standard
		 * hugetlb state. This is normally done by
		 * prep_new_huge_page but that takes hugetlb_lock which
		 * is already held so we need to open code it here.
		 * Reference count trick is needed because allocator
		 * gives us referenced page but the pool requires pages
		 * with 0 refcount.
		 */

> +		page_ref_dec(new_page);
> +		enqueue_huge_page(h, new_page);
> +
> +		/*
> +		 * Pages have been replaced, we can safely free the old one.
> +		 */
> +		spin_unlock_irq(&hugetlb_lock);
> +		update_and_free_page(h, old_page);

-- 
Michal Hocko
SUSE Labs
