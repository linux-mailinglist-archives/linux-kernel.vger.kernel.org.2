Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D32387E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351124AbhERR3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351108AbhERR3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621358867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q/hLyvLFOp4tg4lt1Rp8WVHoY+JWyb8vMSiqZhIebpg=;
        b=XzO2Pg2MKKe9mxGVHIAFiBarKoMB4hJuJmGhmGoMYibKNmcqIveGMM55hmOSXD+ae8yG9J
        eOjjRmXl1rowLICSmCJrG7djxmbPDyyU8fx3rD37U8xcuEbXMvjrInGz2PAsMbTq2VdOwy
        qG0uEzCLe4loUh8BDnZcqOEudCRtHwY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-rdPguSDnM12FKUpXzdUl8Q-1; Tue, 18 May 2021 13:27:46 -0400
X-MC-Unique: rdPguSDnM12FKUpXzdUl8Q-1
Received: by mail-qv1-f70.google.com with SMTP id t1-20020a0ca6810000b029019e892416e6so7933774qva.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 10:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q/hLyvLFOp4tg4lt1Rp8WVHoY+JWyb8vMSiqZhIebpg=;
        b=GdsCzEjnCPspa/YF6A7oRgy6gYH8To/v+onAHOdpJ7VVKqFDQT7x9LtBpY1RCN4IIv
         1S6QT6oKfZ5vBPemWL7gGzl54YLcN4EovNVMMni2YuIpr6ysw4g0mLzRYstCRRqD4ps/
         dYWygNVFPUYZ35CJbVRH1kq9l01SRFFmgp5EKaEGPH1K+obZhU52Ssh0M1LsxaiXzAC8
         Wm/D5XSd+VCDD9DJQj2F8dkr714eqxCTLjp0eYrALSH/Xk+vusjI8tYAW3BGte2XGCbR
         SLShdcpe3nuP5St+mogaIaZeHnohwAyiTjvZU5JVpcePft36sRe5wE4QG1Hhxm6U3Xs5
         ZXvw==
X-Gm-Message-State: AOAM531gO2+uG2Ap7RItubbCcVTUfJ2aee8cUcEd/wxZEfNOD98I6FAd
        fVkAr4kedg9yd0aTOzUYiAmQP58/cuOUJlWofjpsrSZ16fV7VrfgS4OMgl0HnTPodTyWriMoqbw
        7u9F7PIT8TON/0U0A3fZnr+lQ
X-Received: by 2002:a05:6214:c2d:: with SMTP id a13mr6691393qvd.37.1621358865287;
        Tue, 18 May 2021 10:27:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1yaYzXnDKYPG68C6GPD30pklE9Wu2acl8wqmHdsosv44s5ztpPrKuqRJgtxOITZemGZLnfw==
X-Received: by 2002:a05:6214:c2d:: with SMTP id a13mr6691334qvd.37.1621358864834;
        Tue, 18 May 2021 10:27:44 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id h7sm13038913qtj.35.2021.05.18.10.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:27:44 -0700 (PDT)
Date:   Tue, 18 May 2021 13:27:42 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, jgg@nvidia.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKP5Dj4Q/riGGc43@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210407084238.20443-6-apopple@nvidia.com>
 <YKMhorngO2DVrxac@t490s>
 <47694715.suB6H4Uo8R@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47694715.suB6H4Uo8R@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair,

While I got one reply below to your previous email, I also looked at the rest
code (majorly restore and fork sides) today and added a few more comments.

On Tue, May 18, 2021 at 11:19:05PM +1000, Alistair Popple wrote:

[...]

> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 3a5705cfc891..556ff396f2e9 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -700,6 +700,84 @@ struct page *vm_normal_page_pmd(struct vm_area_struct
> > > *vma, unsigned long addr,> 
> > >  }
> > >  #endif
> > > 
> > > +static void restore_exclusive_pte(struct vm_area_struct *vma,
> > > +                               struct page *page, unsigned long address,
> > > +                               pte_t *ptep)
> > > +{
> > > +     pte_t pte;
> > > +     swp_entry_t entry;
> > > +
> > > +     pte = pte_mkold(mk_pte(page, READ_ONCE(vma->vm_page_prot)));
> > > +     if (pte_swp_soft_dirty(*ptep))
> > > +             pte = pte_mksoft_dirty(pte);
> > > +
> > > +     entry = pte_to_swp_entry(*ptep);
> > > +     if (pte_swp_uffd_wp(*ptep))
> > > +             pte = pte_mkuffd_wp(pte);
> > > +     else if (is_writable_device_exclusive_entry(entry))
> > > +             pte = maybe_mkwrite(pte_mkdirty(pte), vma);
> > > +
> > > +     set_pte_at(vma->vm_mm, address, ptep, pte);
> > > +
> > > +     /*
> > > +      * No need to take a page reference as one was already
> > > +      * created when the swap entry was made.
> > > +      */
> > > +     if (PageAnon(page))
> > > +             page_add_anon_rmap(page, vma, address, false);
> > > +     else
> > > +             page_add_file_rmap(page, false);

This seems to be another leftover; maybe WARN_ON_ONCE(!PageAnon(page))?

> > > +
> > > +     if (vma->vm_flags & VM_LOCKED)
> > > +             mlock_vma_page(page);
> > > +
> > > +     /*
> > > +      * No need to invalidate - it was non-present before. However
> > > +      * secondary CPUs may have mappings that need invalidating.
> > > +      */
> > > +     update_mmu_cache(vma, address, ptep);
> > > +}

[...]

> > >  /*
> > >  
> > >   * copy one vm_area from one task to the other. Assumes the page tables
> > >   * already present in the new task to be cleared in the whole range
> > > 
> > > @@ -781,6 +859,12 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct
> > > mm_struct *src_mm,> 
> > >                               pte = pte_swp_mkuffd_wp(pte);
> > >                       
> > >                       set_pte_at(src_mm, addr, src_pte, pte);
> > >               
> > >               }
> > > 
> > > +     } else if (is_device_exclusive_entry(entry)) {
> > > +             /* COW mappings should be dealt with by removing the entry
> > > */

Here the comment says "removing the entry" however I think it didn't remove the
pte, instead it keeps it (as there's no "return", so set_pte_at() will be
called below), so I got a bit confused.

> > > +             VM_BUG_ON(is_cow_mapping(vm_flags));

Also here, if PageAnon() is the only case to support so far, doesn't that
easily satisfy is_cow_mapping()? Maybe I missed something..

I also have a pure and high level question regarding a process fork() when
there're device exclusive ptes: would the two processes then own the device
together?  Is this a real usecase?

Indeed it'll be odd for a COW page since for COW page then it means after
parent/child writting to the page it'll clone into two, then it's a mistery on
which one will be the one that "exclusived owned" by the device..

> > > +             page = pfn_swap_entry_to_page(entry);
> > > +             get_page(page);
> > > +             rss[mm_counter(page)]++;
> > > 
> > >       }
> > >       set_pte_at(dst_mm, addr, dst_pte, pte);
> > >       return 0;
> > > 
> > > @@ -947,6 +1031,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct
> > > vm_area_struct *src_vma,> 
> > >       int rss[NR_MM_COUNTERS];
> > >       swp_entry_t entry = (swp_entry_t){0};
> > >       struct page *prealloc = NULL;
> > > 
> > > +     struct page *locked_page = NULL;
> > > 
> > >  again:
> > >       progress = 0;
> > > 
> > > @@ -980,13 +1065,36 @@ copy_pte_range(struct vm_area_struct *dst_vma,
> > > struct vm_area_struct *src_vma,> 
> > >                       continue;
> > >               
> > >               }
> > >               if (unlikely(!pte_present(*src_pte))) {
> > > 
> > > -                     entry.val = copy_nonpresent_pte(dst_mm, src_mm,
> > > -                                                     dst_pte, src_pte,
> > > -                                                     src_vma, addr, rss);
> > > -                     if (entry.val)
> > > -                             break;
> > > -                     progress += 8;
> > > -                     continue;
> > > +                     swp_entry_t swp_entry = pte_to_swp_entry(*src_pte);

(Just a side note to all of us: this will be one more place that I'll need to
 look after in my uffd-wp series if this series lands first, as after that
 series we can only call pte_to_swp_entry after a pte_has_swap_entry check, as
 sometimes non-present pte won't contain a swap entry at all)

> > > +
> > > +                     if (unlikely(is_cow_mapping(src_vma->vm_flags) &&
> > > +                         is_device_exclusive_entry(swp_entry))) {
> > > +                             /*
> > > +                              * Normally this would require sending mmu
> > > +                              * notifiers, but copy_page_range() has
> > > already +                              * done that for COW mappings.
> > > +                              */
> > > +                             ret = try_restore_exclusive_pte(src_mm,
> > > src_pte, +                                                            
> > > src_vma, addr, +                                                         
> > >    &locked_page); +                             if (ret == -EBUSY)
> > > +                                     break;

Would it be possible that we put all the handling of device exclusive ptes into
copy_nonpresent_pte()?  As IMHO all device exclusive ptes should still be one
kind of non-present pte.  Splitting the cases really make it (at least to
me...) even harder to read.

Maybe you wanted to avoid the rework of copy_nonpresent_pte() as it currently
returns a entry.val which is indeed not straightforward already.. I wanted to
clean that up but not yet.

An easier option is perhaps failing the fork() directly when trylock_page()
failed when restoring the pte? So the userspace could try again the whole
fork(). However that'll also depend on my previous question on whether this is
a valid scenario after all.  If "maintaining fork correctness" is the only
thing we persue for, maybe still worth to consider?

> > > +                     } else {
> > > +                             entry.val = copy_nonpresent_pte(dst_mm,
> > > src_mm, +                                                            
> > > dst_pte, src_pte, +                                                      
> > >       src_vma, addr, +                                                   
> > >          rss); +                             if (entry.val)
> > > +                                     break;
> > > +                             progress += 8;
> > > +                             continue;
> > > +                     }
> > > +             }
> > > +             /* a non-present pte became present after dropping the ptl
> > > */
> > > +             if (unlikely(locked_page)) {
> > > +                     unlock_page(locked_page);
> > > +                     put_page(locked_page);
> > > +                     locked_page = NULL;
> > > 
> > >               }
> > >               /* copy_present_pte() will clear `*prealloc' if consumed */
> > >               ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
> > > 

[...]

> > > +static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
> > > +{
> > > +     struct page *page = vmf->page;
> > > +     struct vm_area_struct *vma = vmf->vma;
> > > +     struct page_vma_mapped_walk pvmw = {
> > > +             .page = page,
> > > +             .vma = vma,
> > > +             .address = vmf->address,
> > > +             .flags = PVMW_SYNC,
> > > +     };
> > > +     vm_fault_t ret = 0;
> > > +     struct mmu_notifier_range range;
> > > +
> > > +     if (!lock_page_or_retry(page, vma->vm_mm, vmf->flags))
> > > +             return VM_FAULT_RETRY;
> > > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma,
> > > vma->vm_mm,
> > > +                             vmf->address & PAGE_MASK,
> > > +                             (vmf->address & PAGE_MASK) + PAGE_SIZE);
> > > +     mmu_notifier_invalidate_range_start(&range);
> > 
> > I looked at MMU_NOTIFIER_CLEAR document and it tells me:
> > 
> >  * @MMU_NOTIFY_CLEAR: clear page table entry (many reasons for this like
> >  * madvise() or replacing a page by another one, ...).
> > 
> > Does MMU_NOTIFIER_CLEAR suite for this case?  Normally I think for such a
> > case (existing pte is invalid) we don't need to notify at all.  However
> > from what I read from the whole series, this seems to be a critical point
> > where we'd like to kick the owner/driver to synchronously stop doing atomic
> > operations from the device.  Not sure whether we'd like a new notifier
> > type, or maybe at least comment on why to use CLEAR?
> 
> Right, notifying the owner/driver when it no longer has exclusive access to 
> the page and allowing it to stop atomic operations is the critical point and 
> why it notifies when we ordinarily wouldn't (ie. invalid -> valid).
> 
> I did consider adding a new type, but in the driver implementation it ends up 
> being treated the same as a CLEAR notification anyway so didn't think it was 
> necessary. But I suppose adding a different type would allow other listening 
> notifiers to filter these which might be worthwhile.

Sounds good to me.

[...]

> > > +             /*
> > > +              * Check that our target page is still mapped at the
> > > expected
> > > +              * address.
> > > +              */
> > > +             if (ttp->mm == mm && ttp->address == address &&
> > > +                 pte_write(pteval))
> > > +                     ttp->valid = true;
> > 
> > I think I get the point of doing this (as after GUP the pte could have been
> > changed to point to another page), however it smells a bit odd to me (or
> > it's also possible that I'm not familiar enough with the code base..). 
> > IIUC this is the _only_ reason that we passed in "address" into
> > try_to_protect() too, and further into the ttp_args.
> 
> Yes, this is why "address" is passed up to ttp_args.
> 
> > The odd part is the remote GUP should have walked the page table already, so
> > since the target here is the vaddr to replace, the 1st page table walk
> > should be able to both trylock/lock the page, then modify the pte with
> > pgtable lock held, return the locked page, then walk the rmap again to
> > remove all the rest of the ptes that are mapping to this page.  In that
> > case before we call the rmap_walk() we know this must be the page we want
> > to take care of, and no one will be able to restore the original mm pte
> > either (as we're with the page lock).  Then we don't need this check,
> > neither do we need ttp->address.
> 
> If I am understanding you correctly I think this would be similar to the 
> approach that was taken in v2. However it pretty much ended up being just an 
> open-coded version of gup which is useful anyway to fault the page in.

I see.  For easier reference this is v2 patch 1:

https://lore.kernel.org/lkml/20210219020750.16444-2-apopple@nvidia.com/

Indeed that looks like it, it's just that instead of grabbing the page only in
hmm_exclusive_pmd() we can do the pte modification along the way to seal the
whole thing (address/pte & page).  I saw Christoph and Jason commented in that
patch, but not regarding to this approach.  So is there a reason that you
switched?  Do you think it'll work?

I have no strong opinion either, it's just not crystal clear why we'd need that
ttp->address at all for a rmap walk along with that "valid" field. Meanwhile it
should be slightly less efficient too to go with current approach, especially
when the page array gets huge, I think: since there'll be longer time we do GUP
before doing the rmap walk, so higher possibility that the GUPed pages got
replaced for whatever reason.  Then the call to make_device_exclusive_range()
will fail as a whole just for a single page replacement within the range.

Thanks,

-- 
Peter Xu

