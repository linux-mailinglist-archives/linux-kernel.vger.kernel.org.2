Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C433C3AFA42
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 02:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhFVAnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 20:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231130AbhFVAm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 20:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624322442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xFCJpXtb6fmE4rs5vQsdx3/WsdSQQkmrrRY5UXNE4dM=;
        b=fg8Mo74j0BU1lPb6LwbHe9zLxHTKKTbxvwzu3DcG6iNChjdt65Pvz34EAucOIrZs8QyoaY
        R4KxjCLE2Ik2V7Gf87PkzjDVr3csTJ3SqfH2P1bysx6cLzdNtXDaiMAfCH5bEESE8rXohA
        FcV3nrqoov2khWZ+IxW17rCmgHhAoa8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-RvPpm4uwMeSN6GftFvCJVQ-1; Mon, 21 Jun 2021 20:40:41 -0400
X-MC-Unique: RvPpm4uwMeSN6GftFvCJVQ-1
Received: by mail-qv1-f69.google.com with SMTP id y17-20020ad445b10000b029027389e9530fso4624380qvu.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 17:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xFCJpXtb6fmE4rs5vQsdx3/WsdSQQkmrrRY5UXNE4dM=;
        b=EIOjZwHJFt8wbZb2OO4Dco5DTtYTyZ3agcn7mRXJj2QDAK1WCtpJ9/jZnTz/PLolv3
         Y0bq9KbAjH5OcRklt8ULH29ck8FJO9ZJFz/jPzgxh+XEHDe9zagMfywzOV8IOCxhQI3C
         rPw8znEsSpu84fnYpS94w6B0XmYEHDBtCBxkwtDbzkPv1Em9DcKC/CyJtG11UdcTXvdu
         WOYHFi2KRWK1zUqRORKNJB62KQFMgV2XCd+40igzRQyv2Os5/sxpFNgef+YKASKrIuCV
         +8vccSLYxV+9bnQAk/UThxg2JqVQyxnZJBVH5eK5u+unpqQKSkeAo0BhG/PTQpd6nmvp
         hEVQ==
X-Gm-Message-State: AOAM530TH4DhFxCiSUIO6BCm5srLsNjdvTcsiGCgm179wQW0Q7e7xUON
        AQ2A5w2g5fhn6Nu5HpdOgRA23hEhDUsBP7vL1qRO4F8iPW7smLYfIFZIR1l7qAwaC7Sxn9YWLr/
        W58XTzA2VQ7Zd52Cni1NVKJ8U
X-Received: by 2002:ac8:7699:: with SMTP id g25mr1166915qtr.309.1624322440840;
        Mon, 21 Jun 2021 17:40:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxm2aHrYS7jAD86EUVh/wbf63nFfUd/S0zKb8ljIY/R924XDnHSkAJ7va/pPzOgoOwamLf1Ew==
X-Received: by 2002:ac8:7699:: with SMTP id g25mr1166898qtr.309.1624322440514;
        Mon, 21 Jun 2021 17:40:40 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id k1sm525645qtu.84.2021.06.21.17.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:40:39 -0700 (PDT)
Date:   Mon, 21 Jun 2021 20:40:37 -0400
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
Message-ID: <YNExhdKPfIb9QlDe@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <20210527202214.31319-1-peterx@redhat.com>
 <2098802.ffhGrX9TH4@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2098802.ffhGrX9TH4@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 06:41:17PM +1000, Alistair Popple wrote:
> On Friday, 28 May 2021 6:22:14 AM AEST Peter Xu wrote:
> > File-backed memory is prone to being unmapped at any time.  It means all
> > information in the pte will be dropped, including the uffd-wp flag.
> > 
> > Since the uffd-wp info cannot be stored in page cache or swap cache, persist
> > this wr-protect information by installing the special uffd-wp marker pte when
> > we're going to unmap a uffd wr-protected pte.  When the pte is accessed again,
> > we will know it's previously wr-protected by recognizing the special pte.
> > 
> > Meanwhile add a new flag ZAP_FLAG_DROP_FILE_UFFD_WP when we don't want to
> > persist such an information.  For example, when destroying the whole vma, or
> > punching a hole in a shmem file.  For the latter, we can only drop the uffd-wp
> > bit when holding the page lock.  It means the unmap_mapping_range() in
> > shmem_fallocate() still reuqires to zap without ZAP_FLAG_DROP_FILE_UFFD_WP
> > because that's still racy with the page faults.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/mm.h        | 11 ++++++++++
> >  include/linux/mm_inline.h | 43 +++++++++++++++++++++++++++++++++++++++
> >  mm/memory.c               | 42 +++++++++++++++++++++++++++++++++++++-
> >  mm/rmap.c                 |  8 ++++++++
> >  mm/truncate.c             |  8 +++++++-
> >  5 files changed, 110 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index b1fb2826e29c..5989fc7ed00d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1725,6 +1725,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
> >  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> >  /* Whether to skip zapping swap entries */
> >  #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
> > +/* Whether to completely drop uffd-wp entries for file-backed memory */
> > +#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
> >  
> >  /*
> >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > @@ -1757,6 +1759,15 @@ zap_skip_swap(struct zap_details *details)
> >  	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> >  }
> >  
> > +static inline bool
> > +zap_drop_file_uffd_wp(struct zap_details *details)
> > +{
> > +	if (!details)
> > +		return false;
> > +
> > +	return details->zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP;
> > +}
> 
> Is this a good default having to explicitly specify that you don't want
> special pte's left in place?

I made it explicitly the default so we won't accidentally drop that bit without
being aware of it; because missing of the uffd-wp bit anywhere can directly
cause data corruption in the userspace.

> For example the OOM killer seems to call unmap_page_range() with details ==
> NULL (although in practice only for anonymous vmas so it wont actually cause
> an issue). Similarly in madvise for MADV_DONTNEED, although arguably I
> suppose that is the correct thing to do there?

So I must confess I'm not familiar with the oom code, it looks to me it's a
fast path to recycle pages that can have a better chance to be reclaimed.  Even
in exit_mmap() we'll do this first before unmap_vmas().  Then it still looks
the right thing to do if it's only a fast path, not to mention if we only runs
with anonymous then it's ignored.

Basically I followed this rule: the bit should never be cleared if (1) user
manually clear it using UFFDIO_WRITEPROTECT, (2) unmapping the whole region.
There can be special cases e.g. when unregister the vma with VM_UFFD_WP, but
that's a rare case, and we also have code to take care of those lazily (e.g.,
we'll restore such a uffd-wp special pte into none pte if we found we've got a
fault and the vma is not registered with uffd-wp at all, in do_swap_pte).
Otherwise I never clear the bit.

> 
> >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> >  			     pte_t pte);
> >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > index 355ea1ee32bd..c29a6ef3a642 100644
> > --- a/include/linux/mm_inline.h
> > +++ b/include/linux/mm_inline.h
> > @@ -4,6 +4,8 @@
> >  
> >  #include <linux/huge_mm.h>
> >  #include <linux/swap.h>
> > +#include <linux/userfaultfd_k.h>
> > +#include <linux/swapops.h>
> >  
> >  /**
> >   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> >  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
> >  			-thp_nr_pages(page));
> >  }
> > +
> > +/*
> > + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> > + * replace a none pte.  NOTE!  This should only be called when *pte is already
> > + * cleared so we will never accidentally replace something valuable.  Meanwhile
> > + * none pte also means we are not demoting the pte so if tlb flushed then we
> > + * don't need to do it again; otherwise if tlb flush is postponed then it's
> > + * even better.
> > + *
> > + * Must be called with pgtable lock held.
> > + */
> > +static inline void
> > +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> > +			      pte_t *pte, pte_t pteval)
> > +{
> > +#ifdef CONFIG_USERFAULTFD
> > +	bool arm_uffd_pte = false;
> > +
> > +	/* The current status of the pte should be "cleared" before calling */
> > +	WARN_ON_ONCE(!pte_none(*pte));
> > +
> > +	if (vma_is_anonymous(vma))
> > +		return;
> > +
> > +	/* A uffd-wp wr-protected normal pte */
> > +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> > +		arm_uffd_pte = true;
> > +
> > +	/*
> > +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> > +	 * pte_swp_uffd_wp_special() too.
> > +	 */
> 
> I'm probably missing something but when can we actually have this case and why
> would we want to leave a special pte behind? From what I can tell this is
> called from try_to_unmap_one() where this won't be true or from zap_pte_range()
> when not skipping swap pages.

Yes this is a good question..

Initially I made this function make sure I cover all forms of uffd-wp bit, that
contains both swap and present ptes; imho that's pretty safe.  However for
!anonymous cases we don't keep swap entry inside pte even if swapped out, as
they should reside in shmem page cache indeed.  The only missing piece seems to
be the device private entries as you also spotted below.

> 
> > +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
> > +		arm_uffd_pte = true;
> > +
> > +	if (unlikely(arm_uffd_pte))
> > +		set_pte_at(vma->vm_mm, addr, pte,
> > +			   pte_swp_mkuffd_wp_special(vma));
> > +#endif
> > +}
> > +
> >  #endif
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 319552efc782..3453b8ae5f4f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -73,6 +73,7 @@
> >  #include <linux/perf_event.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/mm_inline.h>
> >  
> >  #include <trace/events/kmem.h>
> >  
> > @@ -1298,6 +1299,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> >  	return ret;
> >  }
> >  
> > +/*
> > + * This function makes sure that we'll replace the none pte with an uffd-wp
> > + * swap special pte marker when necessary. Must be with the pgtable lock held.
> > + */
> > +static inline void
> > +zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> > +			      unsigned long addr, pte_t *pte,
> > +			      struct zap_details *details, pte_t pteval)
> > +{
> > +	if (zap_drop_file_uffd_wp(details))
> > +		return;
> > +
> > +	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> > +}
> > +
> >  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  				struct vm_area_struct *vma, pmd_t *pmd,
> >  				unsigned long addr, unsigned long end,
> > @@ -1335,6 +1351,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> >  							tlb->fullmm);
> >  			tlb_remove_tlb_entry(tlb, pte, addr);
> > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > +						      ptent);
> >  			if (unlikely(!page))
> >  				continue;
> >  
> > @@ -1359,6 +1377,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			continue;
> >  		}
> >  
> > +		/*
> > +		 * If this is a special uffd-wp marker pte... Drop it only if
> > +		 * enforced to do so.
> > +		 */
> > +		if (unlikely(is_swap_special_pte(ptent))) {
> > +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));
> 
> Why the WARN_ON and not just test pte_swp_uffd_wp_special() directly?
> 
> > +			/*
> > +			 * If this is a common unmap of ptes, keep this as is.
> > +			 * Drop it only if this is a whole-vma destruction.
> > +			 */
> > +			if (zap_drop_file_uffd_wp(details))
> > +				ptep_get_and_clear_full(mm, addr, pte,
> > +							tlb->fullmm);
> > +			continue;
> > +		}
> > +
> >  		entry = pte_to_swp_entry(ptent);
> >  		if (is_device_private_entry(entry) ||
> >  		    is_device_exclusive_entry(entry)) {
> > @@ -1373,6 +1407,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  				page_remove_rmap(page, false);
> >  
> >  			put_page(page);
> > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > +						      ptent);
> 
> Device entries only support anonymous vmas at present so should we drop this?
> I guess I'm also a little confused by this because I'm not sure in what
> scenarios you would want to zap swap entries but leave special swap ptes behind
> (see also my earlier question above as well).

If that's the case, maybe indeed this is not needed, and I can use a
WARN_ON_ONCE here instead, just in case some facts changes. E.g., would it be
possible one day to have !anonymous support for device private entries?
Frankly I have no solid idea on how device private is used, so some more
context would be nice too; since I think you should know much better than me,
so maybe it's a good chance to learn more about it. :)

> 
> >  			continue;
> >  		}
> >  
> > @@ -1390,6 +1426,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  		if (unlikely(!free_swap_and_cache(entry)))
> >  			print_bad_pte(vma, addr, ptent, NULL);
> >  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > +		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> >  	} while (pte++, addr += PAGE_SIZE, addr != end);
> >  
> >  	add_mm_rss_vec(mm, rss);
> > @@ -1589,12 +1626,15 @@ void unmap_vmas(struct mmu_gather *tlb,
> >  		unsigned long end_addr)
> >  {
> >  	struct mmu_notifier_range range;
> > +	struct zap_details details = {
> > +		.zap_flags = ZAP_FLAG_DROP_FILE_UFFD_WP,
> > +	};
> >  
> >  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> >  				start_addr, end_addr);
> >  	mmu_notifier_invalidate_range_start(&range);
> >  	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
> > -		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
> > +		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
> >  	mmu_notifier_invalidate_range_end(&range);
> >  }
> >  
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 0419c9a1a280..a94d9aed9d95 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -72,6 +72,7 @@
> >  #include <linux/page_idle.h>
> >  #include <linux/memremap.h>
> >  #include <linux/userfaultfd_k.h>
> > +#include <linux/mm_inline.h>
> >  
> >  #include <asm/tlbflush.h>
> >  
> > @@ -1509,6 +1510,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >  			pteval = ptep_clear_flush(vma, address, pvmw.pte);
> >  		}
> >  
> > +		/*
> > +		 * Now the pte is cleared.  If this is uffd-wp armed pte, we
> > +		 * may want to replace a none pte with a marker pte if it's
> > +		 * file-backed, so we don't lose the tracking information.
> > +		 */
> > +		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
> 
> From what I can tell we don't need to do this in try_to_migrate_one() (assuming
> that goes in) as well because the existing uffd wp code already deals with
> copying the pte bits over to the migration entries. Is that correct?

I agree try_to_migrate_one() shouldn't need it.  But I'm not sure about
try_to_unmap_one(), as e.g. I think we should rely on this to make shmem work
with when page got swapped out.

Thanks,

-- 
Peter Xu

