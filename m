Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E493B096F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhFVPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59611 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231876AbhFVPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624376665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eVf64iJeycw0SXyKWR4c2jbUasrA04Wc/uJ85tdObIU=;
        b=FX7LV6y3U7pMmbaW7GH4OTB5v7qK1nRS19We4QnuNYdNG8JsCG2Q5vGNzekVQLTRrudb1P
        yhkBO2oq6U4aQ30ZMClNv7bW3K08LqO/JAk4F+HZe6WIp9ZDBEthTWc/i2684823cam19D
        0XcI7erbn2RV2qUXIgdky/wcaAAG12A=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-wgE6wA9LOFuD6Suo4Ho3tQ-1; Tue, 22 Jun 2021 11:44:24 -0400
X-MC-Unique: wgE6wA9LOFuD6Suo4Ho3tQ-1
Received: by mail-qt1-f197.google.com with SMTP id w1-20020ac87a610000b02902433332a0easo19290051qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVf64iJeycw0SXyKWR4c2jbUasrA04Wc/uJ85tdObIU=;
        b=VK/Lx1avNK66ij1rYPUMdHoXGGmnDORnfxsOVO1uZyZk0o6igd10hYAq7kVAstT5yY
         fSCgexlQ3XyfbxE3kVONMUJh8iZdRN9VInnNpKNjgsFAua2t9gXlcoYByKqlgtyuDuOX
         8kX5d7hWjMDvxGsoB650PIHg5Qv+rdWMAL7XcfBipwCjhVmwvSEddB9BeVIX/790q4jP
         2uxDwgroKdsn9a34mP5qrL7uZRS3q7ASEinlUFWP9fyO0EonpJT8dYTY+m2hWoj+UkBh
         AsTDiXj80iXuF0Q0Y0jFgZKgZHDWdCTgZn9q1MZMpppqflfuONUJX18O5PYKXmj/uClO
         FuNA==
X-Gm-Message-State: AOAM5333LU71gJef4C+wTyCMFw9m3DnyJN7c8v6PTocxo+E7OXdnFLUu
        FzSB/xZxy0wx7x5RoZmnm1aTCZqAdi/WDj5gJVoC06xTPlZKRWjXje6rF+yS5BjCTO1n1R0Li4B
        rEAzSHB17qgF8h4kdCMf4w+my
X-Received: by 2002:a37:6cc3:: with SMTP id h186mr4951856qkc.349.1624376663999;
        Tue, 22 Jun 2021 08:44:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVFrdqeXZTB+pRl9Et7r4qjIft4Gw04AkHvY9897yUa5vapwfyxhIMoSf1uIZLteSN8rn4JQ==
X-Received: by 2002:a37:6cc3:: with SMTP id h186mr4951792qkc.349.1624376663588;
        Tue, 22 Jun 2021 08:44:23 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id u15sm2351125qku.33.2021.06.22.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:44:22 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:44:21 -0400
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
Message-ID: <YNIFVesUeezHvbl8@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <2098802.ffhGrX9TH4@nvdebian>
 <YNExhdKPfIb9QlDe@t490s>
 <14377897.UNNPvh25YO@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14377897.UNNPvh25YO@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:47:11PM +1000, Alistair Popple wrote:
> On Tuesday, 22 June 2021 10:40:37 AM AEST Peter Xu wrote:
> > On Mon, Jun 21, 2021 at 06:41:17PM +1000, Alistair Popple wrote:
> > > On Friday, 28 May 2021 6:22:14 AM AEST Peter Xu wrote:
> > > > File-backed memory is prone to being unmapped at any time.  It means all
> > > > information in the pte will be dropped, including the uffd-wp flag.
> > > > 
> > > > Since the uffd-wp info cannot be stored in page cache or swap cache, persist
> > > > this wr-protect information by installing the special uffd-wp marker pte when
> > > > we're going to unmap a uffd wr-protected pte.  When the pte is accessed again,
> > > > we will know it's previously wr-protected by recognizing the special pte.
> > > > 
> > > > Meanwhile add a new flag ZAP_FLAG_DROP_FILE_UFFD_WP when we don't want to
> > > > persist such an information.  For example, when destroying the whole vma, or
> > > > punching a hole in a shmem file.  For the latter, we can only drop the uffd-wp
> > > > bit when holding the page lock.  It means the unmap_mapping_range() in
> > > > shmem_fallocate() still reuqires to zap without ZAP_FLAG_DROP_FILE_UFFD_WP
> > > > because that's still racy with the page faults.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  include/linux/mm.h        | 11 ++++++++++
> > > >  include/linux/mm_inline.h | 43 +++++++++++++++++++++++++++++++++++++++
> > > >  mm/memory.c               | 42 +++++++++++++++++++++++++++++++++++++-
> > > >  mm/rmap.c                 |  8 ++++++++
> > > >  mm/truncate.c             |  8 +++++++-
> > > >  5 files changed, 110 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > > index b1fb2826e29c..5989fc7ed00d 100644
> > > > --- a/include/linux/mm.h
> > > > +++ b/include/linux/mm.h
> > > > @@ -1725,6 +1725,8 @@ extern void user_shm_unlock(size_t, struct user_struct *);
> > > >  #define  ZAP_FLAG_CHECK_MAPPING             BIT(0)
> > > >  /* Whether to skip zapping swap entries */
> > > >  #define  ZAP_FLAG_SKIP_SWAP                 BIT(1)
> > > > +/* Whether to completely drop uffd-wp entries for file-backed memory */
> > > > +#define  ZAP_FLAG_DROP_FILE_UFFD_WP         BIT(2)
> > > >  
> > > >  /*
> > > >   * Parameter block passed down to zap_pte_range in exceptional cases.
> > > > @@ -1757,6 +1759,15 @@ zap_skip_swap(struct zap_details *details)
> > > >  	return details->zap_flags & ZAP_FLAG_SKIP_SWAP;
> > > >  }
> > > >  
> > > > +static inline bool
> > > > +zap_drop_file_uffd_wp(struct zap_details *details)
> > > > +{
> > > > +	if (!details)
> > > > +		return false;
> > > > +
> > > > +	return details->zap_flags & ZAP_FLAG_DROP_FILE_UFFD_WP;
> > > > +}
> > > 
> > > Is this a good default having to explicitly specify that you don't want
> > > special pte's left in place?
> > 
> > I made it explicitly the default so we won't accidentally drop that bit without
> > being aware of it; because missing of the uffd-wp bit anywhere can directly
> > cause data corruption in the userspace.
> 
> Ok, I think that makes sense. I was just a little concerned about leaving
> special pte's behind everywhere by accident and whether there would be any
> unforeseen side effects from that. As you point out below though we do expect
> that to happen occasionally and to clean them up when found.

Right, that's a valid concern which I had too, but I found that it's
non-trivial to avoid those leftover uffd-wp bits.  Since we need to take care
of them anyways, so I let it just be like that, which looks not that bad so far.

One example is shmem file truncation, where we have some optimized path to drop
the mappings before taking the page lock - see shmem_fallocate() where we've
called unmap_mapping_range() (with no page lock, so not safe to drop uffd-wp as
page fault could happen in parallel!  that'll cause the page be written before
dropped, so data potentially lost), before calling shmem_truncate_range()
(which will take the page lock; it's the only safe place to drop the uffd-wp
bit).  These are very trivial cases but very important too - as I used to spend
days debugging a data corruption with it, only until then I notice it's
unavoidable to have those leftover ptes with these corner cases.

> 
> > > For example the OOM killer seems to call unmap_page_range() with details ==
> > > NULL (although in practice only for anonymous vmas so it wont actually cause
> > > an issue). Similarly in madvise for MADV_DONTNEED, although arguably I
> > > suppose that is the correct thing to do there?
> > 
> > So I must confess I'm not familiar with the oom code, it looks to me it's a
> > fast path to recycle pages that can have a better chance to be reclaimed.  Even
> > in exit_mmap() we'll do this first before unmap_vmas().  Then it still looks
> > the right thing to do if it's only a fast path, not to mention if we only runs
> > with anonymous then it's ignored.
> 
> Don't confuse my ability to grep with understanding of the OOM killer :-)
> 
> I was just reviewing cases where we might leave behind unwanted special ptes.
> I don't think I really found any but wanted to ask about them anyway to learn
> more about the rules for them (which you have answered below, thanks!).

Yes, actually thanks for raising it too; I didn't really look closely on the
oom side before.  It's good to double-check.

> 
> > Basically I followed this rule: the bit should never be cleared if (1) user
> > manually clear it using UFFDIO_WRITEPROTECT, (2) unmapping the whole region.

(So obviously when I said "unmapping the whole region", it should include the
 case when we truncate the pages; basically I'll let case (2) to cover all
 cases that we're certain the page can be dropped, so is the uffd-wp bit)

> > There can be special cases e.g. when unregister the vma with VM_UFFD_WP, but
> > that's a rare case, and we also have code to take care of those lazily (e.g.,
> > we'll restore such a uffd-wp special pte into none pte if we found we've got a
> > fault and the vma is not registered with uffd-wp at all, in do_swap_pte).
> > Otherwise I never clear the bit.
> > 
> > > 
> > > >  struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> > > >  			     pte_t pte);
> > > >  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
> > > > diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> > > > index 355ea1ee32bd..c29a6ef3a642 100644
> > > > --- a/include/linux/mm_inline.h
> > > > +++ b/include/linux/mm_inline.h
> > > > @@ -4,6 +4,8 @@
> > > >  
> > > >  #include <linux/huge_mm.h>
> > > >  #include <linux/swap.h>
> > > > +#include <linux/userfaultfd_k.h>
> > > > +#include <linux/swapops.h>
> > > >  
> > > >  /**
> > > >   * page_is_file_lru - should the page be on a file LRU or anon LRU?
> > > > @@ -104,4 +106,45 @@ static __always_inline void del_page_from_lru_list(struct page *page,
> > > >  	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
> > > >  			-thp_nr_pages(page));
> > > >  }
> > > > +
> > > > +/*
> > > > + * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
> > > > + * replace a none pte.  NOTE!  This should only be called when *pte is already
> > > > + * cleared so we will never accidentally replace something valuable.  Meanwhile
> > > > + * none pte also means we are not demoting the pte so if tlb flushed then we
> > > > + * don't need to do it again; otherwise if tlb flush is postponed then it's
> > > > + * even better.
> > > > + *
> > > > + * Must be called with pgtable lock held.
> > > > + */
> > > > +static inline void
> > > > +pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
> > > > +			      pte_t *pte, pte_t pteval)
> > > > +{
> > > > +#ifdef CONFIG_USERFAULTFD
> > > > +	bool arm_uffd_pte = false;
> > > > +
> > > > +	/* The current status of the pte should be "cleared" before calling */
> > > > +	WARN_ON_ONCE(!pte_none(*pte));
> > > > +
> > > > +	if (vma_is_anonymous(vma))
> > > > +		return;
> > > > +
> > > > +	/* A uffd-wp wr-protected normal pte */
> > > > +	if (unlikely(pte_present(pteval) && pte_uffd_wp(pteval)))
> > > > +		arm_uffd_pte = true;
> > > > +
> > > > +	/*
> > > > +	 * A uffd-wp wr-protected swap pte.  Note: this should even work for
> > > > +	 * pte_swp_uffd_wp_special() too.
> > > > +	 */
> > > 
> > > I'm probably missing something but when can we actually have this case and why
> > > would we want to leave a special pte behind? From what I can tell this is
> > > called from try_to_unmap_one() where this won't be true or from zap_pte_range()
> > > when not skipping swap pages.
> > 
> > Yes this is a good question..
> > 
> > Initially I made this function make sure I cover all forms of uffd-wp bit, that
> > contains both swap and present ptes; imho that's pretty safe.  However for
> > !anonymous cases we don't keep swap entry inside pte even if swapped out, as
> > they should reside in shmem page cache indeed.  The only missing piece seems to
> > be the device private entries as you also spotted below.
> 
> Yes, I think it's *probably* safe although I don't yet have a strong opinion
> here ...
> 
> > > > +	if (unlikely(is_swap_pte(pteval) && pte_swp_uffd_wp(pteval)))
> 
> ... however if this can never happen would a WARN_ON() be better? It would also
> mean you could remove arm_uffd_pte.

Hmm, after a second thought I think we can't make it a WARN_ON_ONCE().. this
can still be useful for private mapping of shmem files: in that case we'll have
swap entry stored in pte not page cache, so after page reclaim it will contain
a valid swap entry, while it's still "!anonymous".

> 
> > > > +		arm_uffd_pte = true;
> > > > +
> > > > +	if (unlikely(arm_uffd_pte))
> > > > +		set_pte_at(vma->vm_mm, addr, pte,
> > > > +			   pte_swp_mkuffd_wp_special(vma));
> > > > +#endif
> > > > +}
> > > > +
> > > >  #endif
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 319552efc782..3453b8ae5f4f 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -73,6 +73,7 @@
> > > >  #include <linux/perf_event.h>
> > > >  #include <linux/ptrace.h>
> > > >  #include <linux/vmalloc.h>
> > > > +#include <linux/mm_inline.h>
> > > >  
> > > >  #include <trace/events/kmem.h>
> > > >  
> > > > @@ -1298,6 +1299,21 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +/*
> > > > + * This function makes sure that we'll replace the none pte with an uffd-wp
> > > > + * swap special pte marker when necessary. Must be with the pgtable lock held.
> > > > + */
> > > > +static inline void
> > > > +zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> > > > +			      unsigned long addr, pte_t *pte,
> > > > +			      struct zap_details *details, pte_t pteval)
> > > > +{
> > > > +	if (zap_drop_file_uffd_wp(details))
> > > > +		return;
> > > > +
> > > > +	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
> > > > +}
> > > > +
> > > >  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > >  				struct vm_area_struct *vma, pmd_t *pmd,
> > > >  				unsigned long addr, unsigned long end,
> > > > @@ -1335,6 +1351,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > >  			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > > >  							tlb->fullmm);
> > > >  			tlb_remove_tlb_entry(tlb, pte, addr);
> > > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > > +						      ptent);
> > > >  			if (unlikely(!page))
> > > >  				continue;
> > > >  
> > > > @@ -1359,6 +1377,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > >  			continue;
> > > >  		}
> > > >  
> > > > +		/*
> > > > +		 * If this is a special uffd-wp marker pte... Drop it only if
> > > > +		 * enforced to do so.
> > > > +		 */
> > > > +		if (unlikely(is_swap_special_pte(ptent))) {
> > > > +			WARN_ON_ONCE(!pte_swp_uffd_wp_special(ptent));
> > > 
> > > Why the WARN_ON and not just test pte_swp_uffd_wp_special() directly?
> > > 
> > > > +			/*
> > > > +			 * If this is a common unmap of ptes, keep this as is.
> > > > +			 * Drop it only if this is a whole-vma destruction.
> > > > +			 */
> > > > +			if (zap_drop_file_uffd_wp(details))
> > > > +				ptep_get_and_clear_full(mm, addr, pte,
> > > > +							tlb->fullmm);
> > > > +			continue;
> > > > +		}
> > > > +
> > > >  		entry = pte_to_swp_entry(ptent);
> > > >  		if (is_device_private_entry(entry) ||
> > > >  		    is_device_exclusive_entry(entry)) {
> > > > @@ -1373,6 +1407,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > >  				page_remove_rmap(page, false);
> > > >  
> > > >  			put_page(page);
> > > > +			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
> > > > +						      ptent);
> > > 
> > > Device entries only support anonymous vmas at present so should we drop this?
> > > I guess I'm also a little confused by this because I'm not sure in what
> > > scenarios you would want to zap swap entries but leave special swap ptes behind
> > > (see also my earlier question above as well).
> > 
> > If that's the case, maybe indeed this is not needed, and I can use a
> > WARN_ON_ONCE here instead, just in case some facts changes. E.g., would it be
> > possible one day to have !anonymous support for device private entries?
> > Frankly I have no solid idea on how device private is used, so some more
> > context would be nice too; since I think you should know much better than me,
> > so maybe it's a good chance to learn more about it. :)
> 
> Yes, a WARN_ON_ONCE() would be good if you remove it. We are planning to add
> support for !anonymous device private entries at some point.
> 
> There's nothing too special about device private entries. They exist to store
> some state and look up a device driver callback that gets called when the CPU
> tries to access the page. For example see how do_swap_page() handles them:
> 
>                 } else if (is_device_private_entry(entry)) {
>                         vmf->page = pfn_swap_entry_to_page(entry);
>                         ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
> 
> Normally a device driver provides the implementation of migrate_to_ram() which
> will copy the page back to CPU addressable memory and restore the PTE to a
> normal functioning PTE using the migrate_vma_*() interfaces. Typically this is
> used to allow migration of a page to memory that is not directly CPU addressable
> (eg. GPU memory). Hopefully that goes some way to explaining what they are, but
> if you have more questions let me know!

Thanks for offering these details!  So one thing I'm still uncertain is what
exact type of memory is allowed to be mapped to device private.  E.g., would
"anonymous shared" allowed as "anonymous"?  I saw there seems to have one ioctl
defined that's used to bind these things:

	DRM_IOCTL_DEF_DRV(NOUVEAU_SVM_BIND, nouveau_svmm_bind, DRM_RENDER_ALLOW),

Then nouveau_dmem_migrate_chunk() will initiates the device private entries, am
I right?  Then to ask my previous question in another form: if the vaddr range
is coming from an userspace extention driver, would it be allowed to pass in
some vaddr range mapped with MAP_ANONYMOUS|MAP_SHARED?

> 
> As far as I know there should already be support for userfaultfd-wp on device
> private pages, and given they can only currently exist in anon vmas I think we
> should be safe to not install a special pte when unmapping. On the other hand
> I suppose it doesn't mater if we do install one right?

For this series, I wanted to make sure that even if there's unexpected leftover
uffd-wp special ptes we'll take care of them too indeed.  But let's see how you
would answer above question first.

> 
> > > 
> > > >  			continue;
> > > >  		}
> > > >  
> > > > @@ -1390,6 +1426,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > > >  		if (unlikely(!free_swap_and_cache(entry)))
> > > >  			print_bad_pte(vma, addr, ptent, NULL);
> > > >  		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> > > > +		zap_install_uffd_wp_if_needed(vma, addr, pte, details, ptent);
> > > >  	} while (pte++, addr += PAGE_SIZE, addr != end);
> > > >  
> > > >  	add_mm_rss_vec(mm, rss);
> > > > @@ -1589,12 +1626,15 @@ void unmap_vmas(struct mmu_gather *tlb,
> > > >  		unsigned long end_addr)
> > > >  {
> > > >  	struct mmu_notifier_range range;
> > > > +	struct zap_details details = {
> > > > +		.zap_flags = ZAP_FLAG_DROP_FILE_UFFD_WP,
> > > > +	};
> > > >  
> > > >  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> > > >  				start_addr, end_addr);
> > > >  	mmu_notifier_invalidate_range_start(&range);
> > > >  	for ( ; vma && vma->vm_start < end_addr; vma = vma->vm_next)
> > > > -		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
> > > > +		unmap_single_vma(tlb, vma, start_addr, end_addr, &details);
> > > >  	mmu_notifier_invalidate_range_end(&range);
> > > >  }
> > > >  
> > > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > > index 0419c9a1a280..a94d9aed9d95 100644
> > > > --- a/mm/rmap.c
> > > > +++ b/mm/rmap.c
> > > > @@ -72,6 +72,7 @@
> > > >  #include <linux/page_idle.h>
> > > >  #include <linux/memremap.h>
> > > >  #include <linux/userfaultfd_k.h>
> > > > +#include <linux/mm_inline.h>
> > > >  
> > > >  #include <asm/tlbflush.h>
> > > >  
> > > > @@ -1509,6 +1510,13 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > > >  			pteval = ptep_clear_flush(vma, address, pvmw.pte);
> > > >  		}
> > > >  
> > > > +		/*
> > > > +		 * Now the pte is cleared.  If this is uffd-wp armed pte, we
> > > > +		 * may want to replace a none pte with a marker pte if it's
> > > > +		 * file-backed, so we don't lose the tracking information.
> > > > +		 */
> > > > +		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);
> > > 
> > > From what I can tell we don't need to do this in try_to_migrate_one() (assuming
> > > that goes in) as well because the existing uffd wp code already deals with
> > > copying the pte bits over to the migration entries. Is that correct?
> > 
> > I agree try_to_migrate_one() shouldn't need it.  But I'm not sure about
> > try_to_unmap_one(), as e.g. I think we should rely on this to make shmem work
> > with when page got swapped out.
> 
> Oh for sure I agree you need it in try_to_unmap_one(), my code didn't change
> the unmap path. It just split the migration cases (ie. replacing mappings with
> migration entries instaed of unmapping) into a different function so I just
> wanted to make sure we didn't need it in try_to_migrate_one() (and I think we
> agree it isn't needed there).

Ah so I misunderstood - yes I think we're on the same page then!

Thanks,

-- 
Peter Xu

