Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8D3EB9B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241526AbhHMQCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241152AbhHMQCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628870506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJEd93w7CrzTFiEx49OWLYwQ7+M/L3Fm8Ku2R7kCPMo=;
        b=CQkcURA0+PJoztAXvp72QPrIyFNUj/ZMEmxZex5G+JOmtfmF+8aGYbBO++CeH1AQCTFp1t
        DkgOnlkBAImbmodiOoF/MArJnQenKIdWTo1XIP2kUoAYJ6uAVJ4MZ9r0PdmI/EDBnD4URd
        /ydi4tiHHF/C3+N9cZxbIbrK0Agl4Kw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-k0HZlwjiNAq_-FhpvGBoWw-1; Fri, 13 Aug 2021 12:01:45 -0400
X-MC-Unique: k0HZlwjiNAq_-FhpvGBoWw-1
Received: by mail-qv1-f72.google.com with SMTP id a3-20020a0cb3430000b02903432d100232so7450107qvf.16
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJEd93w7CrzTFiEx49OWLYwQ7+M/L3Fm8Ku2R7kCPMo=;
        b=bXMwOh1GjK6a9+RZ+j3mK87A3bfrCcUx4T3Am4ZNlYs43YSOqaYHJDyw6YIswhkaHr
         y1HK43sGzksqXTJT632oS7JmpHrgB+xu9dpYc2UWp5j9AgSmv1WSqxdIEI6OXdH3WWl9
         6o4hOawVfybKpByrKqKYaaLg3c6sFcqr6UBpiJ1rwDdt4V6q0+IfZNJjFCTag6TYAtW/
         3+vc3NBR7kFZTq1ewkG3462acyQcpRAsLdVbc3iPMZh1aJRvf/IyrQsUsyt2uQ0M/6dF
         F0487RqM07WBICjPBym/du8FxTdBX5Ivz1ZCpHHCXWIm6ZnaXIdQyVl35mIeWcmAdxub
         vSOA==
X-Gm-Message-State: AOAM533/uYEwJD+rhNdBWdMMcSKU9NG373t+J4rl90gyGSwcyShGf8nn
        7p/H0mtyrAswL7Suh737xHHdrZ+hxOC/kmcIiKAHszOkzJ1vjk1Bu83jrmLjYlcaDgkN/F+3K8l
        /dQyb4N/tBmFopPx9jEp892Rb
X-Received: by 2002:a05:620a:2019:: with SMTP id c25mr2983241qka.449.1628870505175;
        Fri, 13 Aug 2021 09:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+ssyXwa8oXlwvKty0Y/P8Zj3pEBNhAyDAedYrWzFYlcoW2r5uGttNZzcXZ243EXS5htIWPA==
X-Received: by 2002:a05:620a:2019:: with SMTP id c25mr2983203qka.449.1628870504880;
        Fri, 13 Aug 2021 09:01:44 -0700 (PDT)
Received: from xz-m1.local (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id x7sm977051qtw.24.2021.08.13.09.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:01:44 -0700 (PDT)
Date:   Fri, 13 Aug 2021 12:01:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 4/4] mm: Install marker pte when page out for shmem
 pages
Message-ID: <YRaXZgBuoYX0sPhS@xz-m1.local>
References: <20210807032521.7591-1-peterx@redhat.com>
 <20210807032521.7591-5-peterx@redhat.com>
 <C0DB3FED-F779-4838-9697-D05BE96C3514@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <C0DB3FED-F779-4838-9697-D05BE96C3514@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 03:18:22PM +0000, Tiberiu Georgescu wrote:
> Hello Peter,

Hi, Tiberiu,

> 
> Sorry for commenting so late.

No worry on that.  I appreciate a lot your follow up on this problem.

> 
> > On 7 Aug 2021, at 04:25, Peter Xu <peterx@redhat.com> wrote:
> > 
> > When shmem pages are swapped out, instead of clearing the pte entry, we leave a
> > marker pte showing that this page is swapped out as a hint for pagemap.  A new
> > TTU flag is introduced to identify this case.
> > 
> > This can be useful for detecting swapped out cold shmem pages.  Then after some
> > memory background scanning work (which will fault in the shmem page and
> > confusing page reclaim), we can do MADV_PAGEOUT explicitly on this page to swap
> > it out again as we know it was cold.
> > 
> > For pagemap, we don't need to explicitly set PM_SWAP bit, because by nature
> > SWP_PTE_MARKER ptes are already counted as PM_SWAP due to it's format as swap.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > fs/proc/task_mmu.c   |  1 +
> > include/linux/rmap.h |  1 +
> > mm/rmap.c            | 19 +++++++++++++++++++
> > mm/vmscan.c          |  2 +-
> > 4 files changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index eb97468dfe4c..21b8594abc1d 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1384,6 +1384,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> > 		if (pm->show_pfn)
> > 			frame = swp_type(entry) |
> > 				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
> > +		/* NOTE: this covers PTE_MARKER_PAGEOUT too */
> > 		flags |= PM_SWAP;
> > 		if (is_pfn_swap_entry(entry))
> > 			page = pfn_swap_entry_to_page(entry);
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index c976cc6de257..318a0e95c7fb 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -95,6 +95,7 @@ enum ttu_flags {
> > 					 * do a final flush if necessary */
> > 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
> > 					 * caller holds it */
> > +	TTU_HINT_PAGEOUT	= 0x100, /* Hint for pageout operation */
> > };
> > 
> > #ifdef CONFIG_MMU
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index b9eb5c12f3fe..24a70b36b6da 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1384,6 +1384,22 @@ void page_remove_rmap(struct page *page, bool compound)
> > 	unlock_page_memcg(page);
> > }
> > 
> > +static inline void
> > +pte_marker_install(struct vm_area_struct *vma, pte_t *pte,
> > +		   struct page *page, unsigned long address)
> > +{
> > +#ifdef CONFIG_PTE_MARKER_PAGEOUT
> > +	swp_entry_t entry;
> > +	pte_t pteval;
> > +
> > +	if (vma_is_shmem(vma) && !PageAnon(page) && pte_none(*pte)) {
> > +		entry = make_pte_marker_entry(PTE_MARKER_PAGEOUT);
> > +		pteval = swp_entry_to_pte(entry);
> > +		set_pte_at(vma->vm_mm, address, pte, pteval);
> > +	}
> > +#endif
> > +}
> > +
> > /*
> >  * @arg: enum ttu_flags will be passed to this argument
> >  */
> > @@ -1628,6 +1644,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > 			 */
> > 			dec_mm_counter(mm, mm_counter_file(page));
> > 		}
> > +
> > +		if (flags & TTU_HINT_PAGEOUT)
> > +			pte_marker_install(vma, pvmw.pte, page, address);
> > discard:
> > 		/*
> > 		 * No need to call mmu_notifier_invalidate_range() it has be
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 4620df62f0ff..4754af6fa24b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1493,7 +1493,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
> > 		 * processes. Try to unmap it here.
> > 		 */
> > 		if (page_mapped(page)) {
> > -			enum ttu_flags flags = TTU_BATCH_FLUSH;
> > +			enum ttu_flags flags = TTU_BATCH_FLUSH | TTU_HINT_PAGEOUT;
> > 			bool was_swapbacked = PageSwapBacked(page);
> > 
> > 			if (unlikely(PageTransHuge(page)))
> > -- 
> > 2.32.0
> > 
> The RFC looks good to me. It makes it much cleaner to verify whether the page
> is in swap or not, and there is great performance benefit compared to my patch.
> 
> Currently, your patch does not have a way of putting the swap offset onto the
> entry when a shared page is swapped, so it does not cover all use cases
> IMO.

Could you remind me on why you need the swap offset?  I was trying to
understand your scenaior and I hope I summarized it right: what we want to do
is being able to MADV_PAGEOUT pages that was swapped out.  Then IIUC the
PM_SWAP bit should be enough for it.  Did I miss something important?

> 
> To counter that, I added my patch on top of yours. By making use of your
> mechanism, we don't need to read the page cache xarray when we pages
> are definitely none. This reduces much unnecessary overhead.
> 
> Main diff in fs/proc/task_mmu.c:pte_to_pagemap_entry():
>         } else if (is_swap_pte(pte)) {
>                 swp_entry_t entry;
>                 ...
>                 entry = pte_to_swp_entry(pte);
> +               if (is_pte_marker_entry(entry)) {
> +                       void *xa_entry = get_xa_entry_at_vma_addr(vma, addr);
>                 ...
> 
> For reference: https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutanix.com/.
> 
> After some preliminary performance tests on VMs, I noticed a significant
> performance improvement in my patch, when yours is added. Here is the
> most interesting result:
> 
> Program I tested it on: Same as https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutanix.com/
> 
> Specs:
>     Memory: 32GB memory, 64GB swap
>     Params: 16GB allocated shmem, 50% dirty, 4GB cgroup, no batching
> 
> In short, the pagemap read deals with 
>     * ~4GB of physical memory (present pages), 
>     * ~4GB in swap (swapped pages)
>     * 8GB non-dirty (none pages).
> 
> Results:
> +------------+-------+-------+
> | Peter\Tibi |  Pre  | Post  | (in seconds)
> +------------+-------+-------+
> | Pre        | 11.82 | 38.44 |
> | Post       | 13.28 | 22.34 |
> +------------+-------+-------+
> 
> With your patch, mine yields the results in twice the time, compared to 4x.
> I am aware it is not ideal, but until it is decided whether a whole different
> system is preferred to PTE markers, our solutions together currently deliver
> the best performance for correctness. Thank you for finding this solution.

Thanks for trying that out!  It's great to know these test results.

> 
> I am happy to introduce a configuration variable to enable my pagemap
> patch only if necessary.

Right.  We can use a config for that, but I didn't mention when replying to
your previous patchset because I thought w/ or w/o the config it should still
be better to use the pte markers because it should be more efficient.

However I think I need to double check I didn't miss anything that you're
looking for. E.g. I need to understand why swp offset matters here as I asked.
I must confess that cannot be trivially done with pte markers yet - keeping a
swap hint is definitely not the same story as keeping a swp entry.

> Either way, if performance is a must, batching is still the best way to
> access multiple pagemap entries.

I agree, especially when we have pmd pgtable locks things can happen
concurrently.

It's just that it's a pity the major overhead comparing to the old way is at
page cache look up, especially as you pointed out - the capability to identify
used ptes with empty ptes matters.  That's kind of orthogonal to batching to me.

Thanks,

-- 
Peter Xu

