Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665F9429AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhJLBXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhJLBXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:23:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC0C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:21:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pf6-20020a17090b1d8600b0019fa884ab85so672837pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 18:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPoscquxjIb2AeDUSXUKVfU6+dDnudQArTvMu9Qs840=;
        b=dD4lXSjQIOkMIOZ5hkbI0As/8rhccuPxt+Bt5ZM0xA7AKE5luhxiqYhUIVwjqcbycy
         /F4GlFCY6fr2Nhqo/vz+MwZG3TSskBWN4ogLGV9YLhxbVcNVZ6L2xXQ3dS64f0aRA8+p
         8+0uttdf8HefKMA0J0Tb3r4HJfQHvcLtXOf+ZUiCKHaZ7vdBm1zA6fzuGLbcTEQ4DEbR
         nsEGfNyeC5wI782IuPKT3xA6Wpr7pCt+2Hk2x83BbdGu90yyENJuolD8CzIj5mHddHvL
         9LThohDe/YqYNGKl7T495Wxdki7W3+Qn/ThQf85plXIyhFwhS+mvAWNqTJaGk3Bo7vNV
         g25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPoscquxjIb2AeDUSXUKVfU6+dDnudQArTvMu9Qs840=;
        b=eHH1t/F2TZro0mvJC74qQ33RnShQqFk+Ujr6x+jd3kEWqKtpxd/Gbw/jWGKVNgkUeS
         QajQEVCwX+4/FE+iyNr2IHN5tsqsP6NFStfCsO2AhQ/D1jdtG8ijk3ZdY7uM0Mh5A+6z
         160rVW69tzR/pa1rMa5hUXpZeZgDVGBG7gae+ZQn3aXGDb9ZdwqS1An38OBfbF+oXdji
         XKJ7MXbOpKY+OA3ZjqjxJ321oZ9vUtTAWb0j89jRTf3/XYnwJc/glN86c5LJRHL78XWh
         5U1d1tM7QqTJjXYf7Y7Q+T+dfCl2EC/523dz2ilEdvT0v1/X+N9mVScrQHlslAw3EPMr
         KqCw==
X-Gm-Message-State: AOAM533EmZVBSKZLnrqhJhqLAXF55MzNiJG/pfHO4g8SPTabqhDElccJ
        LVG7xoYU5cJNmQx+FD/Fyol43C6hCXDFGYRaU+HXNQ==
X-Google-Smtp-Source: ABdhPJyc9fvpBx2zXVPF/JGgtN+qX9uTdF68t25f0qveOndhtTzMoQHZub/nZw0Pt/FTnJa8Mq9Nhou735ZXl/y5dcM=
X-Received: by 2002:a17:903:41c2:b0:13f:f26:d6b9 with SMTP id
 u2-20020a17090341c200b0013f0f26d6b9mr23228927ple.14.1634001702062; Mon, 11
 Oct 2021 18:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211008183256.1558105-1-almasrymina@google.com> <b889652d-7050-a721-367c-dcf3ff084daa@oracle.com>
In-Reply-To: <b889652d-7050-a721-367c-dcf3ff084daa@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 11 Oct 2021 18:21:31 -0700
Message-ID: <CAHS8izPjCJf=qotNMKdpzrRtR78nUux1mAUUY8SPW+ydj56QyA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm, hugepages: add mremap() support for hugepage
 backed vma
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 5:18 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/8/21 11:32 AM, Mina Almasry wrote:
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
> > During the mremap() operation we detect pmd_share'd mappings and we
> > unshare those during the mremap(). On access and fault the sharing is
> > established again.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> ...
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6d2f4c25dd9fb..8200b4c8d09d8 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1015,6 +1015,35 @@ void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
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
> > +     /*
> > +      * Clear the old hugetlb private page reservation.
> > +      * It has already been transferred to new_vma.
> > +      *
> > +      * During a mremap() operation of a hugetlb vma we call move_vma()
> > +      * which copies *vma* into *new_vma* and unmaps *vma*. After the copy
> > +      * operation both *new_vma* and *vma* share a reference to the resv_map
> > +      * struct, and at that point *vma* is about to be unmapped. We don't
> > +      * want to return the reservation to the pool at unmap of *vma* because
> > +      * the reservation still lives on in new_vma, so simply decrement the
> > +      * ref here and remove the resv_map reference from this vma.
> > +      */
>
> Are the *...* for special formatting of the words somewhere?  Or, just
> for simple added emphasis?  This convention is not used anywhere else in
> the file.  Unless there is a good reason for doing so, I would prefer to
> to drop the *...* convention here.
>

It was just emphasis, removed!

> > +     struct resv_map *reservations = vma_resv_map(vma);
> > +
> > +     if (reservations && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
> > +             kref_put(&reservations->refs, resv_map_release);
> > +
> > +     reset_vma_resv_huge_pages(vma);
> > +}
> ...
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index c0b6c41b7b78f..6a3f7d38b7539 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -489,6 +489,10 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
> >       old_end = old_addr + len;
> >       flush_cache_range(vma, old_addr, old_end);
> >
> > +     if (is_vm_hugetlb_page(vma))
> > +             return move_hugetlb_page_tables(vma, new_vma, old_addr,
> > +                                             new_addr, len);
> > +
> >       mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> >                               old_addr, old_end);
> >       mmu_notifier_invalidate_range_start(&range);
> > @@ -646,6 +650,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
> >               mremap_userfaultfd_prep(new_vma, uf);
> >       }
> >
> > +     if (is_vm_hugetlb_page(vma)) {
> > +             clear_vma_resv_huge_pages(vma);
> > +     }
> > +
> >       /* Conceal VM_ACCOUNT so old reservation is not undone */
> >       if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
> >               vma->vm_flags &= ~VM_ACCOUNT;
> > @@ -739,9 +747,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
> >                       (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> >               return ERR_PTR(-EINVAL);
> >
> > -     if (is_vm_hugetlb_page(vma))
> > -             return ERR_PTR(-EINVAL);
> > -
> >       /* We can't remap across vm area boundaries */
> >       if (old_len > vma->vm_end - addr)
> >               return ERR_PTR(-EFAULT);
> > @@ -937,6 +942,27 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
> >
> >       if (mmap_write_lock_killable(current->mm))
> >               return -EINTR;
> > +     vma = find_vma(mm, addr);
> > +     if (!vma || vma->vm_start > addr) {
> > +             ret = EFAULT;
> > +             goto out;
> > +     }
> > +
> > +     if (is_vm_hugetlb_page(vma)) {
> > +             struct hstate *h __maybe_unused = hstate_vma(vma);
> > +
> > +             old_len = ALIGN(old_len, huge_page_size(h));
> > +             new_len = ALIGN(new_len, huge_page_size(h));
> > +             addr = ALIGN(addr, huge_page_size(h));
> > +             new_addr = ALIGN(new_addr, huge_page_size(h));
>
> Instead of aligning addr and new_addr, we should be checking for huge
> page alignment and returning error.  This makes it consistent with the
> requirement that they be PAGE aligned in the non-hugetlb case.  Sorry if
> that was unclear in previous comments.
>
>                 /* addrs must be huge page aligned */
>                 if (addr & ~huge_page_mask(h))
>                         goto out;
>                 if (new_addr & ~huge_page_mask(h))
>                         goto out;
>

Sorry I misunderstood. Added!
