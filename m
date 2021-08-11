Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ECD3E8772
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 02:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhHKAxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 20:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbhHKAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 20:53:13 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF831C06179F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:52:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g12-20020a17090a7d0cb0290178f80de3d8so1812810pjl.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 17:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7g/azwNSb2nzwqD5yBJYYUQTVhPxYHG3cmXgYanZRQ=;
        b=k4yuECZra+4aPtmSFYJBabuc0bFTW/s0TYgUugpXy1I/N2NoUeO/U/AwKMG6fItRFe
         mck6CmrevrPcfznxMEH+R9p5LONGg5GSSzxMv0KYapPTyY0MyR7RyGrYNnSDbLSsWi46
         Q8VPBmv9UvUKcKpVMQ/f3v3nLvTSAY/lHNqrFv9l3fWoltyPwL6URMsDI2h+RakuD5HF
         cEJ69+TCvjpOJ5tUJ3TJl5eFIynfMMn71Fy1JZMzRvbUX5VROXbVxMwqP8XS0jSkAg4o
         AqpZBfTIvSn9Y50FJYRo6v7+uAMH4kDa29sh96j9CgCGUiQdPVfPaEe2invCD1cHDI8P
         bzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7g/azwNSb2nzwqD5yBJYYUQTVhPxYHG3cmXgYanZRQ=;
        b=JujRjQ2pBUTIW4v46PCb01A0xKhfqbkyq9nR8l2EVwBJEd9lWSncHimDdg1Rt4WAjJ
         hy9q79i3HeBbdRYdi8gF4P8//rRLxPYTCwY8V7dmFjve89ofBBE2HxZPW4ML+QMN6uUT
         zFoFtEMcETcbXgmMxcLt/4g4tjgSfuGRcEySIxLRHo3uco+C7AHSSZ4v6ojJMKSB4GlU
         rev2FhSJawzufyjcaCndnkipfi6U41WAgjrroTyKPhnInrsIgmVSZBohb90DJg0E2qgT
         kuhC4ZuhB8VTHc1oXzI/pv0OdKI+8vGNfY6bH1IN4RW8mHNT0Sw4ISCYjkZssYn+8wSx
         48ag==
X-Gm-Message-State: AOAM533ZD9F2koc+e636442Dt4vx2auhllVpraRxU/Sdepstzi+d9/Kn
        XX/FyjlyM/xwDNlWDbANJ7jSwluFHCEZr4bzX4oNxw==
X-Google-Smtp-Source: ABdhPJzshygBaVpw8RQk5Cpcl1zbQDSGy//5ltjxQg7m9jU+fJ7e7r8CQuiU3oXeFdy0Ev4zsMXVhJK4nFLrPQ/XeRA=
X-Received: by 2002:a17:90a:73cb:: with SMTP id n11mr7007867pjk.24.1628643170012;
 Tue, 10 Aug 2021 17:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210730221522.524256-1-almasrymina@google.com>
 <1b970f88-ea8a-18bc-3643-f0e81062f569@oracle.com> <CAHS8izOCAq-UG1xcSDi2y3N-Cvb0xFnJi5Qcyr_DwPn63VW3VA@mail.gmail.com>
In-Reply-To: <CAHS8izOCAq-UG1xcSDi2y3N-Cvb0xFnJi5Qcyr_DwPn63VW3VA@mail.gmail.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 10 Aug 2021 17:52:38 -0700
Message-ID: <CAHS8izMOYG-XQnJKb=5Bjm4FyZVoR=hq9Z7kqkUgvLPY+c5T1w@mail.gmail.com>
Subject: Re: [PATCH v1] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Ken Chen <kenchen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Kennelly <ckennelly@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > --- a/mm/mremap.c
> > > +++ b/mm/mremap.c
> > > @@ -489,6 +489,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> > >       old_end = old_addr + len;
> > >       flush_cache_range(vma, old_addr, old_end);
> > >
> > > +     if (is_vm_hugetlb_page(vma))
> > > +             return move_hugetlb_page_tables(vma, old_addr, new_addr, len);
> > > +
> > >       mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> > >                               old_addr, old_end);
> > >       mmu_notifier_invalidate_range_start(&range);
> > > @@ -642,6 +645,57 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> > >               mremap_userfaultfd_prep(new_vma, uf);
> > >       }
> > >
> > > +     if (is_vm_hugetlb_page(vma)) {
> > > +             /*
> > > +              * Clear the old hugetlb private page reservation.
> > > +              * It has already been transferred to new_vma.
> > > +              *
> > > +              * The reservation tracking for hugetlb private mapping is
> > > +              * done in two places:
> > > +              * 1. implicit vma size, e.g. vma->vm_end - vma->vm_start
> > > +              * 2. tracking of hugepages that has been faulted in already,
> > > +              *    this is done via a linked list hanging off
> > > +              *    vma_resv_map(vma).
> > > +              *
> > > +              * Each hugepage vma also has hugepage specific vm_ops method
> > > +              * and there is an imbalance in the open() and close method.
> > > +              *
> > > +              * In the open method (hugetlb_vm_op_open), a ref count is
> > > +              * obtained on the structure that tracks faulted in pages.
> > > +              *
> > > +              * In the close method, it unconditionally returns pending
> > > +              * reservation on the vma as well as release a kref count and
> > > +              * calls release function upon last reference.
> > > +              *
> > > +              * Because of this unbalanced operation in the open/close
> > > +              * method, this code runs into trouble in the mremap() path:
> > > +              * copy_vma will copy the pointer to the reservation structure,
> > > +              * then calls vma->vm_ops->open() method, which only increments
> > > +              * ref count on the tracking structure and does not do actual
> > > +              * reservation.  In the same code sequence from move_vma(), the
> > > +              * close() method is called as a result of cleaning up original
> > > +              * vma segment from a call to do_munmap().  At this stage, the
> > > +              * tracking and reservation is out of balance, e.g. the
> > > +              * reservation is returned, however there is an active ref on
> > > +              * the tracking structure.
> > > +              *
> > > +              * When the remap'ed vma unmaps (either implicit at process
> > > +              * exit or explicit munmap), the reservation will be returned
> > > +              * again because hugetlb_vm_op_close calculate pending
> > > +              * reservation unconditionally based on size of vma.  This
> > > +              * cause h->resv_huge_pages. to underflow and no more hugepages
> > > +              * can be allocated to application in certain situation.
> > > +              *
> > > +              * We need to reset and clear the tracking reservation, such
> > > +              * that we don't prematurely returns hugepage reservation at
> > > +              * mremap time.  The reservation should only be returned at
> > > +              * munmap() time.  This is totally undesired, however, we
> > > +              * don't want to re-factor hugepage reservation code at this
> > > +              * stage for prod kernel. Resetting is the least risky method.
> > > +              */
> >
> > We never had remapping support before, so we never had to deal with this
> > situation.  This new code just throws away reservations when remapping
> > an anon vma area.  Correct?  I would like to at least think about how to
> > preserve the reservations.  In the move case, we know the vma will be
> > the same size.  So we would not even need to adjust reht reserve map,
> > just preserve it for the new mapping.
> >
> > The explanation is helpful.  However, it might make more sense to put
> > it at the beginning of clear_vma_resv_huge_pages in hugetlb.c.  It is a
> > big comment in mremap.c that is very hugetlb specific.
> >
>
> For v2 I moved the comment locally. Let me see if I can preserve the
> reservation like you described.
>

So I took a deeper look, and AFAICT the resv_map is actually already
preserved across the mremap() operation, the comment maybe is a little
misleading and needs to be clearer.

Basically during the mremap(), the private hugetlb vma is is copied in
mremap.c:move_vma(); after that call, both vma (the old vma) and
new_vma are private hugetlb vma's which share the same resv_map.

Then, the mremap.c:move_vma() will unmap the old vma. Now, since the
old vma has a resv_map struct hanging off of it, the reservation will
get uncharged. Later, when new_vma is unmapped, the same reservation
gets uncharged again, causing the underflow and the double
hugetlb_cgroup uncharging of the reserved memory.

To counter this we simply call clear_vma_resv_huge_pages(old vma)
after the resv_map has been copied to the new vma but before the old
vma has been unmapped. This seems like a good solution to me. The only
other solution I can think of is to do the uncharging in
resv_map_release() rather in hugetlb_vm_op_close(), such that whatever
vma drops the last ref causes the reservation to be uncharged. This
seems marginally cleaner but a big problem is that I don't know the
vma start and end offsets inside of resv_map_release(), so seems like
a much messier fix to the same problem anyway.


> > > +             clear_vma_resv_huge_pages(vma);
> > > +     }
> > > +
> > >       /* Conceal VM_ACCOUNT so old reservation is not undone */
> > >       if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
> > >               vma->vm_flags &= ~VM_ACCOUNT;
> > > @@ -736,9 +790,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
> > >                       (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> > >               return ERR_PTR(-EINVAL);
> > >
> > > -     if (is_vm_hugetlb_page(vma))
> > > -             return ERR_PTR(-EINVAL);
> > > -
> > >       /* We can't remap across vm area boundaries */
> > >       if (old_len > vma->vm_end - addr)
> > >               return ERR_PTR(-EFAULT);
> > > @@ -949,6 +1000,24 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> > >
> > >       if (mmap_write_lock_killable(current->mm))
> > >               return -EINTR;
> > > +     vma = find_vma(mm, addr);
> > > +     if (!vma || vma->vm_start > addr)
> > > +             goto out;
> >
> > It looks like previously we would have returned EFAULT for this condition
> > on non-hugetlb vmas?
> >
>
> Should be fixed in v2.
>
> > I see all the special handling for vmas with userfaultfd ranges that are
> > remapped.  Did you look into the details to see if that still works with
> > hugetlb mappings?
>
> No, my test case currently (which I will include with v2) is quite
> simple and doesn't do anything related to userfaultfd. Let me see if I
> can add some userfaultfd usage to the test to detect any issues.
>

Ran userfaultfd tests with my patch, and added to my test some code
that registers the mremapped ranges with userfaultfd; none showed any
issues. Looking at userfaultfd docs and some of the code it looks like
we notify the userspace that there is a mremap() happening but I don't
see anything that requires changes here. I might be wrong though, I'm
not that familiar with userfaultfd.

On Thu, Aug 5, 2021 at 9:56 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 8/4/21 11:03 AM, Mina Almasry wrote:
> > On Mon, Aug 2, 2021 at 4:51 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >> On 7/30/21 3:15 PM, Mina Almasry wrote:
> >>> From: Ken Chen <kenchen@google.com>
> >>> +static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
> >>> +                       unsigned long new_addr, pte_t *src_pte)
> >>> +{
> >>> +     struct address_space *mapping = vma->vm_file->f_mapping;
> >>> +     struct hstate *h = hstate_vma(vma);
> >>> +     struct mm_struct *mm = vma->vm_mm;
> >>> +     pte_t *dst_pte, pte;
> >>> +     spinlock_t *src_ptl, *dst_ptl;
> >>> +
> >>> +     /* Shared pagetables need more thought here if we re-enable them */
> >>> +     BUG_ON(vma_shareable(vma, old_addr));
> >>
> >> I agree that shared page tables will complicate the code.  Where do you
> >> actually prevent mremap on mappings which can share page tables?  I
> >> don't see anything before this BUG.
> >>
> >
> > Sorry, I added a check in mremap to return early if
> > hugetlb_vma_sharable() in v2.
> >
>
> After thinking about this a bit, I am not sure if this is a good idea.
> My assumption is that you will make mremap will return an error if
> vma_shareable().  We will then need to document that behavior in the
> mremap man page.  I 'think' that will require documenting hugetlb pmd
> sharing which is not documented anywhere today.
>
> Another option is to 'unshare' early in mremap.  However, unshare will
> have the same effect as throwing away all the page table entries for the
> shared area.  So, copying page table entries may be very fast.  And, the
> first fault on the new vma would theoretically establish sharing again
> (assuming all conditions are met).  Otherwise, the new vma will not be
> populated until pages are faulted in.  I know mremap wants to preserve
> page tables when it remaps.  Does this move us too far from that design
> goal?
>
> The last option would be to fully support pmd sharing in the page table
> copying code.  It is a bit of a pain, but already accounted for in
> routines like copy_hugetlb_page_range.
>
> Just some things to consider.  I would prefer unsharing or fully
> supporting sharing rather than return an error.

Ah, sorry for the late reply, it took me a while to figure this out.

I initially thought hugetlb_vma_shareable() refers to MAP_SHARED VMAs,
which is not true, it refers to pmd_shared() vmas, and now I
understand that it's an undocumented optimization and so we have to
handle it.

I tried the unshare route and that seems to work (passes my test) so
I'm going to put that in V2. To be completely honest for our use case
we only ever mremap() MAP_PRIVATE vma and that's why we never cared
about handling the pmd_shared() case - we just never ran into that
issue and never hit the BUG() in PATCH V1. But I would like the
mremap() support to work for everyone, so I gave it a shot anyway.
Please let me know if it looks good to you. I personally don't see an
issue with the unshare() but I'm not an expert and like I said we
don't actually use the mremap() MAP_SHARED case ourselves, but it
seems fine to me.
