Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5007930CDE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhBBVYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhBBVYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:24:34 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E469FC0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:23:53 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id n2so22977826iom.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lzMAl5+qLTmBp1f6Ub1UuM/DYWx8qizOQNUGBPnqABs=;
        b=NuGsVyz611xeol+A8+9BulKrYLJDBMW83OE+4b9CUq4ElLv8ajZdYYNjozFIMqArfo
         nzx4qTgvJkwU/4LlyjRjmt3uuIIMFqhbDx32+VZo4i7kLn+q5aZIv/EqkMOBBXv+tas9
         k1B0puJKMOsvOTpv5Z9JlGtgLVx6ojdkpu0lLY0d0ZP6WuufatqN5nBPrL4drrpTJg2A
         rs2pZPTvxZIu1aA366Ap3g8D87QiI0fzIBRVeiXHY6glYTD2SHzjbu9RryfF3rCGxF3z
         oihoe12lKw39qeGlUOE3N6AGZTKG+qZbjbgzd6t+RD0pJ/sERNk5Ra17wDkWZF90UK2L
         /Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lzMAl5+qLTmBp1f6Ub1UuM/DYWx8qizOQNUGBPnqABs=;
        b=l9Q6SgxrVjTXe2yhAFTFl1p/5TfozuLSO5Z/Dk9wQZEay7KrGmRAJGROhYAF3Pe/aX
         1oQAD7ypaxEuBy4Y24eD9D/R/U63oyQzi5NMFDqKF3bFidDZOKshLpCdeZLR5jtYk2AS
         oaipA5H0f5XGnfcXwiELVEnKuleDgrPCMJP70eGZumjhJ8iBckLrIpHFdLWH715JdP23
         kt18Y6aD33x+21DPyPaI7xJDcBIoZa4PGxkMQZU0tJcHp7VcvvQKXZT6irblr2i0fg0z
         0/uimussoNNbpy4fvPqaBOAL1N//BMMCp3RlZRncIGoeSJg/i9875dAUFgAy96aYSE5+
         fWhg==
X-Gm-Message-State: AOAM530vkEqIHMA9JcgE6lgHRB3NCf5JWevibVMZrxi1WFyDAk47YC0h
        9KiAnIIKDg/W2YFVIB3YZ8kE41GGaqMGzDGeA4px3SqT/qm9WA==
X-Google-Smtp-Source: ABdhPJwUpfcPHVhyluje7+uuiNZeFYJFpItaxp753gw9mG5YZIj1FbNN8jnSPX6oCtSwTHjJasdjoSqz3b4+9HRhUv0=
X-Received: by 2002:a02:3844:: with SMTP id v4mr151276jae.1.1612301032996;
 Tue, 02 Feb 2021 13:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20210202203127.3596707-1-axelrasmussen@google.com> <alpine.LSU.2.11.2102021248250.2436@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2102021248250.2436@eggly.anvils>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 2 Feb 2021 13:23:16 -0800
Message-ID: <CAJHvVchxb3bemEZSKmUhPhyWmd8rQBT3UEchV38H8vWj1f=aTg@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: hugetlbfs: only compile UFFD helpers if
 config enabled
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 1:03 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 2 Feb 2021, Axel Rasmussen wrote:
>
> > For background, mm/userfaultfd.c provides a general mcopy_atomic
> > implementation. But some types of memory (e.g., hugetlb and shmem) need
> > a slightly different implementation, so they provide their own helpers
> > for this. In other words, userfaultfd is the only caller of this
> > function.
> >
> > This patch achieves two things:
> >
> > 1. Don't spend time compiling code which will end up never being
> > referenced anyway (a small build time optimization).
> >
> > 2. In future patches (e.g. [1]), we plan to extend the signature of
> > these helpers with UFFD-specific state (e.g., enums or structs defined
> > conditionally in userfaultfd_k.h). Once this happens, this patch will be
> > needed to avoid build errors (or, we'd need to define more UFFD-only
> > stuff unconditionally, which seems messier to me).
> >
> > Peter Xu suggested this be sent as a standalone patch, in the mailing
> > list discussion for [1].
> >
> > [1] https://patchwork.kernel.org/project/linux-mm/list/?series=424091
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  include/linux/hugetlb.h | 4 ++++
> >  mm/hugetlb.c            | 2 ++
> >  2 files changed, 6 insertions(+)
>
> Hi Axel, please also do the same to mm/shmem.c (perhaps you missed
> it because I did that long ago to our internal copy of mm/shmem.c).

I had been largely ignoring shmem up to this point because my minor
fault handling series doesn't (yet) deal with it. But, I'll need to do
this later when I support shmem anyway, so happy to add it here.

> But please also comment the endifs
> #endif /* CONFIG_USERFAULTFD */
> to help find one's way around them.

Done. :)

>
> I see you've done include/linux/hugetlb.h: okay, that's not necessary,
> but a matter of taste; up to you whether to do include/linux/shmem_fs.h.

Ah, so it is not strictly needed in the current world, but later when
the signature contains UFFD-specific things like the mode enumeration
I'm proposing, it becomes necessary, or else we get many build
warnings about implicitly declaring the argument's type.

Sorry for misunderstanding Peter's recommendation; this would be more
apparent if this patch was part of the larger series. Perhaps the
right thing to do is just abandon this separate patch and move it back
into the larger series (keeping your suggestions, of course). I
suppose I'll do that - you'll see this in v4 of
https://patchwork.kernel.org/project/linux-mm/list/?series=424091
unless someone tells me to do otherwise. :P

Thanks for reviewing, all.

>
> Thanks,
> Hugh
>
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index ebca2ef02212..749701b5c153 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -134,11 +134,13 @@ void hugetlb_show_meminfo(void);
> >  unsigned long hugetlb_total_pages(void);
> >  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >                       unsigned long address, unsigned int flags);
> > +#ifdef CONFIG_USERFAULTFD
> >  int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
> >                               struct vm_area_struct *dst_vma,
> >                               unsigned long dst_addr,
> >                               unsigned long src_addr,
> >                               struct page **pagep);
> > +#endif
> >  int hugetlb_reserve_pages(struct inode *inode, long from, long to,
> >                                               struct vm_area_struct *vma,
> >                                               vm_flags_t vm_flags);
> > @@ -308,6 +310,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> >       BUG();
> >  }
> >
> > +#ifdef CONFIG_USERFAULTFD
> >  static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >                                               pte_t *dst_pte,
> >                                               struct vm_area_struct *dst_vma,
> > @@ -318,6 +321,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       BUG();
> >       return 0;
> >  }
> > +#endif
> >
> >  static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
> >                                       unsigned long sz)
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 18f6ee317900..821bfa9c0c80 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -4615,6 +4615,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_USERFAULTFD
> >  /*
> >   * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
> >   * modifications for huge pages.
> > @@ -4745,6 +4746,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       put_page(page);
> >       goto out;
> >  }
> > +#endif
> >
> >  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
> >                        struct page **pages, struct vm_area_struct **vmas,
> > --
> > 2.30.0.365.g02bc693789-goog
