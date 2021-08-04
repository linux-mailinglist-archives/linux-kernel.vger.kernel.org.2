Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1EC3E071D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbhHDSDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbhHDSDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:03:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CD5C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 11:03:36 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ca5so4154643pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8EB7R95BOlvfMCt8F8n1gK9asCxOLvlKK7iRn801fI=;
        b=PAukNBUieA6ydQu5RSwpg7LG6ucgB3KEbBfe/NsG+4LjHr0q0IzzdllTbpF0BQUMIq
         FB5K6IqoUwd7uprm/qcH1hzO7q1ZJ4K9dPuGpMUH6b4Smk1HThkgB0F2o3x07V8RBy6T
         eZZkirWww8rFJswOuJ7iKVsgda30rXV+PNd2NlmzHJHyzZ8WsjN+HSXfWJjPIeHsFNhP
         i1J3G7rLZhI8Hjjln1cI2IcggeycqZiAy+yjltGSl0qznbh57/4NM5z4ZaSGj56qFist
         nF6T6UK2r0Jp9sreuIt9wLRa+zxPyvbLjkL1rn5wG/uSCOtUII5idh0DO3Q+VMbCjqLE
         udhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8EB7R95BOlvfMCt8F8n1gK9asCxOLvlKK7iRn801fI=;
        b=iyfDEAdJ4jWvpdgyGO2VtwMerVRaiTeYI/IhTTGTtCo8qsDJtTzUBoUuQd4KrD+488
         nqOeQMUJ8eSTDOkJsO+EC1cyE1gKVc+feLlfMZoTBXqiuCBDZYOh5llG4ViZ+gPNVrQJ
         DVS1ehFNbsfr30vHbrzRN5SRxovKMSF8Sxjm9WQtBo4WzRVVMlOc6/lMqNknOWoXWUN2
         V14CvrIsFksNpWqBc1VLM9hjFu9bLEFJXziXyS56C7dwavUjlD7ABZP+gqpQCr18fUe9
         PPoOSOtyDur5NcnurFOv4b+8UqNzeBHEcKi+G+eFUWtQBmq4TdswNDtzDbdPmX1NqR0q
         Qz6Q==
X-Gm-Message-State: AOAM532UzLoEwulVb0+SttdxESVwIJuejDd286dmujz64QirFRp6+Qrl
        Sa8yiyixW/2nwRaLiqZnuBMpZFxsr5wGFhSC22IvQw==
X-Google-Smtp-Source: ABdhPJwNtJSosOUf3tnGvyd7Qf/hSHRVJbmETHwPeVv3Mv1qnWwC5BFqUbl/mRSTX9SfBFgIu3tIdppjkqCcFfjQP5M=
X-Received: by 2002:a17:902:ea11:b029:12c:a226:167e with SMTP id
 s17-20020a170902ea11b029012ca226167emr401594plg.82.1628100215752; Wed, 04 Aug
 2021 11:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210730221522.524256-1-almasrymina@google.com> <1b970f88-ea8a-18bc-3643-f0e81062f569@oracle.com>
In-Reply-To: <1b970f88-ea8a-18bc-3643-f0e81062f569@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 4 Aug 2021 11:03:24 -0700
Message-ID: <CAHS8izOCAq-UG1xcSDi2y3N-Cvb0xFnJi5Qcyr_DwPn63VW3VA@mail.gmail.com>
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

On Mon, Aug 2, 2021 at 4:51 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 7/30/21 3:15 PM, Mina Almasry wrote:
> > From: Ken Chen <kenchen@google.com>
> >
> > Support mremap() for hugepage backed vma segment by simply repositioning
> > page table entries. The page table entries are repositioned to the new
> > virtual address on mremap().
> >
> > Hugetlb mremap() support is of course generic; my motivating use case
> > is a library (hugepage_text), which reloads the ELF text of executables
> > in hugepages. This significantly increases the execution performance of
> > said executables.
> >
> > Restricts the mremap operation on hugepages to up to the size of the
> > original mapping as the underlying hugetlb reservation is not yet
> > capable of handling remapping to a larger size.
> >
> > Tested with a simple mmap/mremap test case, roughly:
> >
> > void* haddr = mmap(NULL, size, PROT_READ | PROT_WRITE | PROT_EXEC,
> >               MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> >
> > void* taddr = mmap(NULL, size, PROT_NONE,
> >               MAP_HUGETLB | MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> >
> > void* raddr = mremap(haddr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, taddr);
>
> Agree with Andrew that adding actual tests would help.
>

Fixed in upcoming v2.

> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Ken Chen <kenchen@google.com>
> > Cc: Chris Kennelly <ckennelly@google.com>
> >
> > ---
> >  include/linux/hugetlb.h | 13 ++++++
> >  mm/hugetlb.c            | 89 +++++++++++++++++++++++++++++++++++++++++
> >  mm/mremap.c             | 75 ++++++++++++++++++++++++++++++++--
> >  3 files changed, 174 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index f7ca1a3870ea5..685a289b58401 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -124,6 +124,7 @@ struct hugepage_subpool *hugepage_new_subpool(struct hstate *h, long max_hpages,
> >  void hugepage_put_subpool(struct hugepage_subpool *spool);
> >
> >  void reset_vma_resv_huge_pages(struct vm_area_struct *vma);
> > +void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
> >  int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
> >  int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
> >               loff_t *);
> > @@ -132,6 +133,8 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
> >  int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
> >               loff_t *);
> >
> > +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
> > +                          unsigned long new_addr, unsigned long len);
> >  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
> >  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
> >                        struct page **, struct vm_area_struct **,
> > @@ -218,6 +221,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
> >  {
> >  }
> >
> > +static inline void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> > +{
> > +}
> > +
> >  static inline unsigned long hugetlb_total_pages(void)
> >  {
> >       return 0;
> > @@ -265,6 +272,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
> >       return 0;
> >  }
> >
> > +#define move_hugetlb_page_tables(vma, old_addr, new_addr, len)                 \
> > +     ({                                                                     \
> > +             BUG();                                                         \
> > +             0;                                                             \
> > +     })
> > +
> >  static inline void hugetlb_report_meminfo(struct seq_file *m)
> >  {
> >  }
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 528947da65c8f..bd26b00caf3cf 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1004,6 +1004,23 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
> >               vma->vm_private_data = (void *)0;
> >  }
> >
> > +/*
> > + * Reset and decrement one ref on hugepage private reservation.
> > + * Called with mm->mmap_sem writer semaphore held.
> > + * This function should be only used by move_vma() and operate on
> > + * same sized vma. It should never come here with last ref on the
> > + * reservation.
> > + */
> > +void clear_vma_resv_huge_pages(struct vm_area_struct *vma)
> > +{
> > +     struct resv_map *reservations = vma_resv_map(vma);
> > +
> > +     if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
> > +             kref_put(&reservations->refs, resv_map_release);
> > +
> > +     reset_vma_resv_huge_pages(vma);
> > +}
> > +
> >  /* Returns true if the VMA has associated reserve pages */
> >  static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
> >  {
> > @@ -4429,6 +4446,73 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >       return ret;
> >  }
> >
> > +static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr);
> > +
> > +static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
> > +                       unsigned long new_addr, pte_t *src_pte)
> > +{
> > +     struct address_space *mapping = vma->vm_file->f_mapping;
> > +     struct hstate *h = hstate_vma(vma);
> > +     struct mm_struct *mm = vma->vm_mm;
> > +     pte_t *dst_pte, pte;
> > +     spinlock_t *src_ptl, *dst_ptl;
> > +
> > +     /* Shared pagetables need more thought here if we re-enable them */
> > +     BUG_ON(vma_shareable(vma, old_addr));
>
> I agree that shared page tables will complicate the code.  Where do you
> actually prevent mremap on mappings which can share page tables?  I
> don't see anything before this BUG.
>

Sorry, I added a check in mremap to return early if
hugetlb_vma_sharable() in v2.

> > +
> > +     /* Prevent race with file truncation */
> > +     i_mmap_lock_write(mapping);
>
> It may not apply as long as you really prevent remap of mappings which
> can share page tables, but i_mmap_lock_write also protects against pmd
> unsharing.  In a mapping with sharing possible, src_pte is not stable
> until i_mmap_rwsem is held in write mode.
>
> > +
> > +     dst_pte = huge_pte_offset(mm, new_addr, huge_page_size(h));
> > +     dst_ptl = huge_pte_lock(h, mm, dst_pte);
> > +     src_ptl = huge_pte_lockptr(h, mm, src_pte);
> > +     /*
> > +      * We don't have to worry about the ordering of src and dst ptlocks
> > +      * because exclusive mmap_sem (or the i_mmap_lock) prevents deadlock.
> > +      */
> > +     if (src_ptl != dst_ptl)
> > +             spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> > +
> > +     pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
> > +     set_huge_pte_at(mm, new_addr, dst_pte, pte);
> > +
> > +     if (src_ptl != dst_ptl)
> > +             spin_unlock(src_ptl);
> > +     spin_unlock(dst_ptl);
> > +     i_mmap_unlock_write(mapping);
> > +}
> > +
> > +int move_hugetlb_page_tables(struct vm_area_struct *vma, unsigned long old_addr,
> > +                          unsigned long new_addr, unsigned long len)
> > +{
> > +     struct hstate *h = hstate_vma(vma);
> > +     unsigned long sz = huge_page_size(h);
> > +     struct mm_struct *mm = vma->vm_mm;
> > +     unsigned long old_end = old_addr + len;
> > +     pte_t *src_pte, *dst_pte;
> > +     struct mmu_notifier_range range;
> > +
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
> > +                             old_end);
> > +     mmu_notifier_invalidate_range_start(&range);
> > +     for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
> > +             src_pte = huge_pte_offset(mm, old_addr, sz);
> > +             if (!src_pte)
> > +                     continue;
> > +             if (huge_pte_none(huge_ptep_get(src_pte)))
> > +                     continue;
> > +             dst_pte = huge_pte_alloc(mm, vma, new_addr, sz);
> > +             if (!dst_pte)
> > +                     break;
> > +
> > +             move_huge_pte(vma, old_addr, new_addr, src_pte);
> > +     }
> > +     flush_tlb_range(vma, old_end - len, old_end);
>
> Isn't 'old_end - len' == old_addr?  If so, I think old_addr is more
> clear here.
>

old_addr is getting modified in the for loop to continually point to
the old address that's being moved in the iteration. 'old_addr += sz'.

> > +     mmu_notifier_invalidate_range_end(&range);
> > +
> > +     return len + old_addr - old_end;
> > +}
> > +
> >  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >                           unsigned long start, unsigned long end,
> >                           struct page *ref_page)
> > @@ -6043,6 +6127,11 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> >  }
> >
> >  #else /* !CONFIG_ARCH_WANT_HUGE_PMD_SHARE */
> > +static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> > +{
> > +     return false;
> > +}
> > +
> >  pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> >                     unsigned long addr, pud_t *pud)
> >  {
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index badfe17ade1f0..3c0ee2bb9c439 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -489,6 +489,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >       old_end = old_addr + len;
> >       flush_cache_range(vma, old_addr, old_end);
> >
> > +     if (is_vm_hugetlb_page(vma))
> > +             return move_hugetlb_page_tables(vma, old_addr, new_addr, len);
> > +
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> >                               old_addr, old_end);
> >       mmu_notifier_invalidate_range_start(&range);
> > @@ -642,6 +645,57 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >               mremap_userfaultfd_prep(new_vma, uf);
> >       }
> >
> > +     if (is_vm_hugetlb_page(vma)) {
> > +             /*
> > +              * Clear the old hugetlb private page reservation.
> > +              * It has already been transferred to new_vma.
> > +              *
> > +              * The reservation tracking for hugetlb private mapping is
> > +              * done in two places:
> > +              * 1. implicit vma size, e.g. vma->vm_end - vma->vm_start
> > +              * 2. tracking of hugepages that has been faulted in already,
> > +              *    this is done via a linked list hanging off
> > +              *    vma_resv_map(vma).
> > +              *
> > +              * Each hugepage vma also has hugepage specific vm_ops method
> > +              * and there is an imbalance in the open() and close method.
> > +              *
> > +              * In the open method (hugetlb_vm_op_open), a ref count is
> > +              * obtained on the structure that tracks faulted in pages.
> > +              *
> > +              * In the close method, it unconditionally returns pending
> > +              * reservation on the vma as well as release a kref count and
> > +              * calls release function upon last reference.
> > +              *
> > +              * Because of this unbalanced operation in the open/close
> > +              * method, this code runs into trouble in the mremap() path:
> > +              * copy_vma will copy the pointer to the reservation structure,
> > +              * then calls vma->vm_ops->open() method, which only increments
> > +              * ref count on the tracking structure and does not do actual
> > +              * reservation.  In the same code sequence from move_vma(), the
> > +              * close() method is called as a result of cleaning up original
> > +              * vma segment from a call to do_munmap().  At this stage, the
> > +              * tracking and reservation is out of balance, e.g. the
> > +              * reservation is returned, however there is an active ref on
> > +              * the tracking structure.
> > +              *
> > +              * When the remap'ed vma unmaps (either implicit at process
> > +              * exit or explicit munmap), the reservation will be returned
> > +              * again because hugetlb_vm_op_close calculate pending
> > +              * reservation unconditionally based on size of vma.  This
> > +              * cause h->resv_huge_pages. to underflow and no more hugepages
> > +              * can be allocated to application in certain situation.
> > +              *
> > +              * We need to reset and clear the tracking reservation, such
> > +              * that we don't prematurely returns hugepage reservation at
> > +              * mremap time.  The reservation should only be returned at
> > +              * munmap() time.  This is totally undesired, however, we
> > +              * don't want to re-factor hugepage reservation code at this
> > +              * stage for prod kernel. Resetting is the least risky method.
> > +              */
>
> We never had remapping support before, so we never had to deal with this
> situation.  This new code just throws away reservations when remapping
> an anon vma area.  Correct?  I would like to at least think about how to
> preserve the reservations.  In the move case, we know the vma will be
> the same size.  So we would not even need to adjust reht reserve map,
> just preserve it for the new mapping.
>
> The explanation is helpful.  However, it might make more sense to put
> it at the beginning of clear_vma_resv_huge_pages in hugetlb.c.  It is a
> big comment in mremap.c that is very hugetlb specific.
>

For v2 I moved the comment locally. Let me see if I can preserve the
reservation like you described.

> > +             clear_vma_resv_huge_pages(vma);
> > +     }
> > +
> >       /* Conceal VM_ACCOUNT so old reservation is not undone */
> >       if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
> >               vma->vm_flags &= ~VM_ACCOUNT;
> > @@ -736,9 +790,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
> >                       (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> >               return ERR_PTR(-EINVAL);
> >
> > -     if (is_vm_hugetlb_page(vma))
> > -             return ERR_PTR(-EINVAL);
> > -
> >       /* We can't remap across vm area boundaries */
> >       if (old_len > vma->vm_end - addr)
> >               return ERR_PTR(-EFAULT);
> > @@ -949,6 +1000,24 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> >
> >       if (mmap_write_lock_killable(current->mm))
> >               return -EINTR;
> > +     vma = find_vma(mm, addr);
> > +     if (!vma || vma->vm_start > addr)
> > +             goto out;
>
> It looks like previously we would have returned EFAULT for this condition
> on non-hugetlb vmas?
>

Should be fixed in v2.

> I see all the special handling for vmas with userfaultfd ranges that are
> remapped.  Did you look into the details to see if that still works with
> hugetlb mappings?

No, my test case currently (which I will include with v2) is quite
simple and doesn't do anything related to userfaultfd. Let me see if I
can add some userfaultfd usage to the test to detect any issues.


> --
> Mike Kravetz
>
> > +
> > +     if (is_vm_hugetlb_page(vma)) {
> > +             struct hstate *h __maybe_unused = hstate_vma(vma);
> > +
> > +             if (old_len & ~huge_page_mask(h) ||
> > +                 new_len & ~huge_page_mask(h))
> > +                     goto out;
> > +
> > +             /*
> > +              * Don't allow remap expansion, because the underlying hugetlb
> > +              * reservation is not yet capable to handle split reservation.
> > +              */
> > +             if (new_len > old_len)
> > +                     goto out;
> > +     }
> >
> >       if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
> >               ret = mremap_to(addr, old_len, new_addr, new_len,
> > --
> > 2.32.0.554.ge1b32706d8-goog
> >
