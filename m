Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234713B1DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhFWPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 11:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhFWPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624462290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LeFs9AGF87ucZtFdUIWiOqdnDBPWe6N9LLLDArhqbwA=;
        b=g9tkrzj5fnO+RTJ+4tJ3PjiZk9vgO1qQBTj5hEENZTjnH4PZqNeusQIOHMv1XBfIj32oD1
        /2BvLIpDMdIXDTTrwjCGTY5geUYWotKb5iLBKU/1X9PG4P3QtXyPfjOFqPrlS8fwbWTKvk
        ZxxNX1uTPy3jyjRzwVFIKYF+liav/lY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-9TiLQwurPuOGdbX4NM_AkA-1; Wed, 23 Jun 2021 11:31:28 -0400
X-MC-Unique: 9TiLQwurPuOGdbX4NM_AkA-1
Received: by mail-qk1-f197.google.com with SMTP id 81-20020a370e540000b02903aacdbd70b7so2868458qko.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 08:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LeFs9AGF87ucZtFdUIWiOqdnDBPWe6N9LLLDArhqbwA=;
        b=tEWxFqR88r1c4x09O4rdSIOJaqTXaaLILt7i8NvM3BTvicrDuEx/OllcWTnXxX64qW
         TyeWnbSalXknf+AccORvCJ+Nfq8+i78uParteqXUTze386wuipizB9O+P5lvCBJh6n/y
         69gXkpyuDdwWFshRawFJMrsBIqHC9v2Id8zWTko+SK6+JUMaPtwDCvS26qfCpe5nwv7D
         ZTXqaXTz/WiGAbM5UnytAKpsYDxHkY1g0s87jPbU0ifrrtvYiVSsVIdwOGmvqCuaU/SM
         43zXdpmG36WDriyqOSfuwWkT1zLdB4BwKH6i9hs4R4YZUklWKqWYZS9icQaO3o7NEVNR
         S4Bw==
X-Gm-Message-State: AOAM531oznfrfvHkUXrLyTIgciA/6ikFDBAzOoG/uLzCdtlybratgMP8
        CGcmlS2V2dY+4rdDOFljpRJhBZJTXsmAEa+4LFJjQtqv/XCNfXoxT9kufX/2BqMWn6K/5E0ypaC
        X3GpcvGjfblznmW72GR4Cs1XU
X-Received: by 2002:ad4:5aeb:: with SMTP id c11mr520230qvh.34.1624462288435;
        Wed, 23 Jun 2021 08:31:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYb18KKgT8DZAB4uvnffne6IxQAbTbn1/GusYHgStOdb7Tqf6ka4QBcDesMFH/MHjpikgogQ==
X-Received: by 2002:ad4:5aeb:: with SMTP id c11mr520198qvh.34.1624462288121;
        Wed, 23 Jun 2021 08:31:28 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id h9sm105371qkj.66.2021.06.23.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:31:27 -0700 (PDT)
Date:   Wed, 23 Jun 2021 11:31:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 11/27] shmem/userfaultfd: Persist uffd-wp bit across
 zapping for file-backed
Message-ID: <YNNTzau6cjx6UGDk@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <14377897.UNNPvh25YO@nvdebian>
 <YNIFVesUeezHvbl8@t490s>
 <1857347.At2d1zFpmm@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1857347.At2d1zFpmm@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 04:04:03PM +1000, Alistair Popple wrote:
> On Wednesday, 23 June 2021 1:44:21 AM AEST Peter Xu wrote:
> > On Tue, Jun 22, 2021 at 10:47:11PM +1000, Alistair Popple wrote:
> > > On Tuesday, 22 June 2021 10:40:37 AM AEST Peter Xu wrote:
> > > > On Mon, Jun 21, 2021 at 06:41:17PM +1000, Alistair Popple wrote:
> > > > > On Friday, 28 May 2021 6:22:14 AM AEST Peter Xu wrote:
> > > > > > File-backed memory is prone to being unmapped at any time.  It means all
> > > > > > information in the pte will be dropped, including the uffd-wp flag.
> > > > > > 
> > > > > > Since the uffd-wp info cannot be stored in page cache or swap cache, persist
> > > > > > this wr-protect information by installing the special uffd-wp marker pte when
> > > > > > we're going to unmap a uffd wr-protected pte.  When the pte is accessed again,
> > > > > > we will know it's previously wr-protected by recognizing the special pte.
> > > > > > 
> > > > > > Meanwhile add a new flag ZAP_FLAG_DROP_FILE_UFFD_WP when we don't want to
> > > > > > persist such an information.  For example, when destroying the whole vma, or
> > > > > > punching a hole in a shmem file.  For the latter, we can only drop the uffd-wp
> > > > > > bit when holding the page lock.  It means the unmap_mapping_range() in
> > > > > > shmem_fallocate() still reuqires to zap without ZAP_FLAG_DROP_FILE_UFFD_WP
> > > > > > because that's still racy with the page faults.
> > > > > > 
> > > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > > ---
> > > > > >  include/linux/mm.h        | 11 ++++++++++
> > > > > >  include/linux/mm_inline.h | 43 +++++++++++++++++++++++++++++++++++++++
> > > > > >  mm/memory.c               | 42 +++++++++++++++++++++++++++++++++++++-
> > > > > >  mm/rmap.c                 |  8 ++++++++
> > > > > >  mm/truncate.c             |  8 +++++++-
> > > > > >  5 files changed, 110 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > > > index b1fb2826e29c..5989fc7ed00d 100644
> > > > > > --- a/include/linux/mm.h
> > > > > > +++ b/include/linux/mm.h
> > > > > > @@ -1725,6 +1725,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
> > > > > >  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > > > > >  /* Whether to skip zapping swap entries */
> > > > > >  #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
> > > > > > +/* Whether to completely drop uffd-wp entries for file-backed memory */
> > > > > > +#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
> > > > > >  
> > > > > >  /*
> > > > > >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > > > > > @@ -1757,6 +1759,15 @@ zap_skip_swap(struct zap_details *details)
> > > > > >  	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> > > > > >  }
> > > > > >  
> > > > > > +static inline bool
> > > > > > +zap_drop_file_uffd_wp(struct zap_details *details)
> > > > > > +{
> > > > > > +	if (!details)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	return details->zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP;
> > > > > > +}
> > > > > 
> > > > > Is this a good default having to explicitly specify that you don't want
> > > > > special pte's left in place?
> > > > 
> > > > I made it explicitly the default so we won't accidentally drop that bit without
> > > > being aware of it; because missing of the uffd-wp bit anywhere can directly
> > > > cause data corruption in the userspace.
> > > 
> > > Ok, I think that makes sense. I was just a little concerned about leaving
> > > special pte's behind everywhere by accident and whether there would be any
> > > unforeseen side effects from that. As you point out below though we do expect
> > > that to happen occasionally and to clean them up when found.
> > 
> > Right, that's a valid concern which I had too, but I found that it's
> > non-trivial to avoid those leftover uffd-wp bits.  Since we need to take care
> > of them anyways, so I let it just be like that, which looks not that bad so far.
> > 
> > One example is shmem file truncation, where we have some optimized path to drop
> > the mappings before taking the page lock - see shmem_fallocate() where we've
> > called unmap_mapping_range() (with no page lock, so not safe to drop uffd-wp as
> > page fault could happen in parallel!  that'll cause the page be written before
> > dropped, so data potentially lost), before calling shmem_truncate_range()
> > (which will take the page lock; it's the only safe place to drop the uffd-wp
> > bit).  These are very trivial cases but very important too - as I used to spend
> > days debugging a data corruption with it, only until then I notice it's
> > unavoidable to have those leftover ptes with these corner cases.
> > 
> > > 
> > > > > For example the OOM killer seems to call unmap_page_range() with details ==
> > > > > NULL (although in practice only for anonymous vmas so it wont actually cause
> > > > > an issue). Similarly in madvise for MADV_DONTNEED, although arguably I
> > > > > suppose that is the correct thing to do there?
> > > > 
> > > > So I must confess I'm not familiar with the oom code, it looks to me it's a
> > > > fast path to recycle pages that can have a better chance to be reclaimed.  Even
> > > > in exit_mmap() we'll do this first before unmap_vmas().  Then it still looks
> > > > the right thing to do if it's only a fast path, not to mention if we only runs
> > > > with anonymous then it's ignored.
> > > 
> > > Don't confuse my ability to grep with understanding of the OOM killer :-)
> > > 
> > > I was just reviewing cases where we might leave behind unwanted special ptes.
> > > I don't think I really found any but wanted to ask about them anyway to learn
> > > more about the rules for them (which you have answered below, thanks!).
> > 
> > Yes, actually thanks for raising it too; I didn't really look closely on the
> > oom side before.  It's good to double-check.
> > 
> > > 
> > > > Basically I followed this rule: the bit should never be cleared if (1) user
> > > > manually clear it using UFFDIO_WRITEPROTECT, (2) unmapping the whole region.
> > 
> > (So obviously when I said "unmapping the whole region", it should include the
> >  case when we truncate the pages; basically I'll let case (2) to cover all
> >  cases that we're certain the page can be dropped, so is the uffd-wp bit)
> > 
> > > > There can be special cases e.g. when unregister the vma with VM_UFFD_WP, but
> > > > that's a rare case, and we also have code to take care of those lazily (e.g.,
> > > > we'll restore such a uffd-wp special pte into none pte if we found we've got a
> > > > fault and the vma is not registered with uffd-wp at all, in do_swap_pte).
> > > > Otherwise I never clear the bit.
> > > > 
> > > > > 
> > > > > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > > > > >  			     pte_t pte);
> > > > > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > > > > index 355ea1ee32bd..c29a6ef3a642 100644
> > > > > > --- a/include/linux/mm_inline.h
> > > > > > +++ b/include/linux/mm_inline.h
> > > > > > @@ -4,6 +4,8 @@
> > > > > >  
> > > > > >  #include <linux/huge_mm.h>
> > > > > >  #include <linux/swap.h>
> > > > > > +#include <linux/userfaultfd_k.h>
> > > > > > +#include <linux/swapops.h>
> > > > > >  
> > > > > >  /**
> > > > > >   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > > > > > @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> > > > > >  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
> > > > > >  			-thp_nr_pages(page));
> > > > > >  }
> > > > > > +
> > > > > > +/*
> > > > > > + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> > > > > > + * replace a none pte.  NOTE!  This should only be called when *pte is already
> > > > > > + * cleared so we will never accidentally replace something valuable.  Meanwhile
> > > > > > + * none pte also means we are not demoting the pte so if tlb flushed then we
> > > > > > + * don't need to do it again; otherwise if tlb flush is postponed then it's
> > > > > > + * even better.
> > > > > > + *
> > > > > > + * Must be called with pgtable lock held.
> > > > > > + */
> > > > > > +static inline void
> > > > > > +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> > > > > > +			      pte_t *pte, pte_t pteval)
> > > > > > +{
> > > > > > +#ifdef CONFIG_USERFAULTFD
> > > > > > +	bool arm_uffd_pte = false;
> > > > > > +
> > > > > > +	/* The current status of the pte should be "cleared" before calling */
> > > > > > +	WARN_ON_ONCE(!pte_none(*pte));
> > > > > > +
> > > > > > +	if (vma_is_anonymous(vma))
> > > > > > +		return;
> > > > > > +
> > > > > > +	/* A uffd-wp wr-protected normal pte */
> > > > > > +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> > > > > > +		arm_uffd_pte = true;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> > > > > > +	 * pte_swp_uffd_wp_special() too.
> > > > > > +	 */
> > > > > 
> > > > > I'm probably missing something but when can we actually have this case and why
> > > > > would we want to leave a special pte behind? From what I can tell this is
> > > > > called from try_to_unmap_one() where this won't be true or from zap_pte_range()
> > > > > when not skipping swap pages.
> > > > 
> > > > Yes this is a good question..
> > > > 
> > > > Initially I made this function make sure I cover all forms of uffd-wp bit, that
> > > > contains both swap and present ptes; imho that's pretty safe.  However for
> > > > !anonymous cases we don't keep swap entry inside pte even if swapped out, as
> > > > they should reside in shmem page cache indeed.  The only missing piece seems to
> > > > be the device private entries as you also spotted below.
> > > 
> > > Yes, I think it's *probably* safe although I don't yet have a strong opinion
> > > here ...
> > > 
> > > > > > +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
> > > 
> > > ... however if this can never happen would a WARN_ON() be better? It would also
> > > mean you could remove arm_uffd_pte.
> > 
> > Hmm, after a second thought I think we can't make it a WARN_ON_ONCE().. this
> > can still be useful for private mapping of shmem files: in that case we'll have
> > swap entry stored in pte not page cache, so after page reclaim it will contain
> > a valid swap entry, while it's still "!anonymous".
> 
> There's something (probably obvious) I must still be missing here. During
> reclaim won't a private shmem mapping still have a present pteval here?
> Therefore it won't trigger this case - the uffd wp bit is set when the swap
> entry is established further down in try_to_unmap_one() right?

I agree if it's at the point when it get reclaimed, however what if we zap a
pte of a page already got reclaimed?  It should have the swap pte installed,
imho, which will have "is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)"==true.

> 
> > > 
> > > > > > +		arm_uffd_pte = true;
> > > > > > +
> > > > > > +	if (unlikely(arm_uffd_pte))
> > > > > > +		set_pte_at(vma->vm_mm, addr, pte,
> > > > > > +			   pte_swp_mkuffd_wp_special(vma));
> > > > > > +#endif
> > > > > > +}
> > > > > > +
> > > > > >  #endif
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index 319552efc782..3453b8ae5f4f 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -73,6 +73,7 @@
> > > > > >  #include <linux/perf_event.h>
> > > > > >  #include <linux/ptrace.h>
> > > > > >  #include <linux/vmalloc.h>
> > > > > > +#include <linux/mm_inline.h>
> > > > > >  
> > > > > >  #include <trace/events/kmem.h>
> > > > > >  
> > > > > > @@ -1298,6 +1299,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> > > > > >  	return ret;
> > > > > >  }
> > > > > >  
> > > > > > +/*
> > > > > > + * This function makes sure that we'll replace the none pte with an uffd-wp
> > > > > > + * swap special pte marker when necessary. Must be with the pgtable lock held.
> > > > > > + */
> > > > > > +static inline void
> > > > > > +zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> > > > > > +			      unsigned long addr, pte_t *pte,
> > > > > > +			      struct zap_details *details, pte_t pteval)
> > > > > > +{
> > > > > > +	if (zap_drop_file_uffd_wp(details))
> > > > > > +		return;
> > > > > > +
> > > > > > +	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> > > > > > +}
> > > > > > +
> > > > > >  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > >  				struct vm_area_struct *vma, pmd_t *pmd,
> > > > > >  				unsigned long addr, unsigned long end,
> > > > > > @@ -1335,6 +1351,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > > > > >  							tlb->fullmm);
> > > > > >  			tlb_remove_tlb_entry(tlb, pte, addr);
> > > > > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > > > > +						      ptent);
> > > > > >  			if (unlikely(!page))
> > > > > >  				continue;
> > > > > >  
> > > > > > @@ -1359,6 +1377,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > >  			continue;
> > > > > >  		}
> > > > > >  
> > > > > > +		/*
> > > > > > +		 * If this is a special uffd-wp marker pte... Drop it only if
> > > > > > +		 * enforced to do so.
> > > > > > +		 */
> > > > > > +		if (unlikely(is_swap_special_pte(ptent))) {
> > > > > > +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));
> > > > > 
> > > > > Why the WARN_ON and not just test pte_swp_uffd_wp_special() directly?
> > > > > 
> > > > > > +			/*
> > > > > > +			 * If this is a common unmap of ptes, keep this as is.
> > > > > > +			 * Drop it only if this is a whole-vma destruction.
> > > > > > +			 */
> > > > > > +			if (zap_drop_file_uffd_wp(details))
> > > > > > +				ptep_get_and_clear_full(mm, addr, pte,
> > > > > > +							tlb->fullmm);
> > > > > > +			continue;
> > > > > > +		}
> > > > > > +
> > > > > >  		entry = pte_to_swp_entry(ptent);
> > > > > >  		if (is_device_private_entry(entry) ||
> > > > > >  		    is_device_exclusive_entry(entry)) {
> > > > > > @@ -1373,6 +1407,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > > > >  				page_remove_rmap(page, false);
> > > > > >  
> > > > > >  			put_page(page);
> > > > > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > > > > +						      ptent);
> > > > > 
> > > > > Device entries only support anonymous vmas at present so should we drop this?
> > > > > I guess I'm also a little confused by this because I'm not sure in what
> > > > > scenarios you would want to zap swap entries but leave special swap ptes behind
> > > > > (see also my earlier question above as well).
> > > > 
> > > > If that's the case, maybe indeed this is not needed, and I can use a
> > > > WARN_ON_ONCE here instead, just in case some facts changes. E.g., would it be
> > > > possible one day to have !anonymous support for device private entries?
> > > > Frankly I have no solid idea on how device private is used, so some more
> > > > context would be nice too; since I think you should know much better than me,
> > > > so maybe it's a good chance to learn more about it. :)
> > > 
> > > Yes, a WARN_ON_ONCE() would be good if you remove it. We are planning to add
> > > support for !anonymous device private entries at some point.
> > > 
> > > There's nothing too special about device private entries. They exist to store
> > > some state and look up a device driver callback that gets called when the CPU
> > > tries to access the page. For example see how do_swap_page() handles them:
> > > 
> > >                 } else if (is_device_private_entry(entry)) {
> > >                         vmf->page = pfn_swap_entry_to_page(entry);
> > >                         ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
> > > 
> > > Normally a device driver provides the implementation of migrate_to_ram() which
> > > will copy the page back to CPU addressable memory and restore the PTE to a
> > > normal functioning PTE using the migrate_vma_*() interfaces. Typically this is
> > > used to allow migration of a page to memory that is not directly CPU addressable
> > > (eg. GPU memory). Hopefully that goes some way to explaining what they are, but
> > > if you have more questions let me know!
> > 
> > Thanks for offering these details!  So one thing I'm still uncertain is what
> > exact type of memory is allowed to be mapped to device private.  E.g., would
> > "anonymous shared" allowed as "anonymous"?  I saw there seems to have one ioctl
> > defined that's used to bind these things:
> > 
> > 	DRM_IOCTL_DEF_DRV(NOUVEAU_SVM_BIND, nouveau_svmm_bind, DRM_RENDER_ALLOW),
> > 
> > Then nouveau_dmem_migrate_chunk() will initiates the device private entries, am
> > I right?  Then to ask my previous question in another form: if the vaddr range
> > is coming from an userspace extention driver, would it be allowed to pass in
> > some vaddr range mapped with MAP_ANONYMOUS|MAP_SHARED?
> 
> I should have been more specific - device private pages currently only support
> non-file/shmem backed pages. In other words the migrate_vma_*() calls will fail
> for MAP_ANONYMOUS | MAP_SHARED when the target page is a device private page.
> 
> For a present page this is enforced in migrate_vma_pages() when trying to
> migrate to a device private page:
> 
>                 mapping = page_mapping(page);
> 
>                 if (is_zone_device_page(newpage)) {
>                         if (is_device_private_page(newpage)) {
>                                 /*
>                                  * For now only support private anonymous when
>                                  * migrating to un-addressable device memory.
>                                  */
>                                 if (mapping) {
>                                         migrate->src[i] &= ~MIGRATE_PFN_MIGRATE;
>                                         continue;
>                                 }

Ah fair enough. :)

When I looked again, I did also see that there's vma_is_anonymous() check right
at the entry of migrate_vma_insert_page() too.

I'll convert this device private call to a WARN_ON_ONCE() then, with proper
comments explaining why.

Thanks,

-- 
Peter Xu

