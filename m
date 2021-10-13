Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777FB42CA77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhJMT6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJMT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:58:06 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A22C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:56:03 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c29so3444636pfp.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccxD0qNeOeY4gSB3C/LzDiuYmAlSnm9Q2TA3WA13E9w=;
        b=qM0RicvFlcjd/JqyQ4Fl4lRFJukkBXbr+Aq8HeDdZbfs3mKJcIZZb/l6TdSgrLoBaU
         DNnBrDOniYEdWR3/MzuXJ4f6z1mqYY8xJP4P5ilNeco+jrmZWZlLrdj4uUHM6AlLC3MP
         gcIsdIXCkwj361i5DmWDXtkWkVc1kaQJwIYMZKJoXNVimpATKM4ayXQbAcSxu5bJQMDR
         h22YqTvGKtveTnqooArkkz3C+THoKRUvof+LeX16d81YQiwZhO0UdA5zDXkRgV4FsDst
         pn3JdgnzmXG2xEICHdOtxQkkNvntdMkvR5J35hVXeBBWhJEB3urP6Cni/3G6mIvbtLB7
         SFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccxD0qNeOeY4gSB3C/LzDiuYmAlSnm9Q2TA3WA13E9w=;
        b=22pkKQCK0bLPoVwZm/cUCD7x3fLxmpVJS+wYLQa0c6/1fQQtlwRP1rl10KHJpczkgq
         bU76ejoiepzStF+vF0my/rOWiEaQmk8mcH9W4gojPF3r3zwVFicUATk+rY6AOGS1UT+O
         X4ln/R5hxREbN+5B0EpaaGWXVGysbFHYgYuVyvuNSCYzrJNLFYHYu/O9Vd7FqQQNTWXT
         k1wOx8lVNRJq0b9tSPIjV6BEVxjJ3W6VVKfTCGcL6dT5gWJxzDfd9Sh8SX0JfsoLr6ZZ
         Y5IISinokYc9HeFJx7mTyx8zmFUCn6DvSIiBeDSy1tKymv0Huf9Frn6Kd7OrNAfjpJ5o
         Ev6A==
X-Gm-Message-State: AOAM530tUlecSHymS6vwWDOLoWibTqn7h0WGDgzpqZmnpFlyFX4fDWLi
        ptCdi8q+z+kSNH8vT+NsHNm9nJulQNRwHbhjh25Jtg==
X-Google-Smtp-Source: ABdhPJxIFc59FWmoIzTWkBTZjqu8jdRRD0wzLpnVVkFhAb7L9rfwI7WfzpKPOaf/MlZBck58Junx1yrqulRT9YqKXq4=
X-Received: by 2002:a05:6a00:214d:b0:44d:35e9:4ce2 with SMTP id
 o13-20020a056a00214d00b0044d35e94ce2mr1326528pfk.13.1634154962252; Wed, 13
 Oct 2021 12:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211012011728.646120-1-almasrymina@google.com> <8ade8697-3f03-c2d4-f7a9-e64cb600ad33@oracle.com>
In-Reply-To: <8ade8697-3f03-c2d4-f7a9-e64cb600ad33@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 13 Oct 2021 12:55:51 -0700
Message-ID: <CAHS8izOaywTt3wDD0i+PJiq+Hmpdr3RwMrB8HpiZ4gEVyO2Y3g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm, hugepages: add mremap() support for hugepage
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

On Tue, Oct 12, 2021 at 4:51 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/11/21 6:17 PM, Mina Almasry wrote:
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
>
> Thanks!
>
> Just some minor nits below.  If you agree with the suggestions and make
> the changes, you can add:
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>

Thank you as always for your review and patience. I've applied the
changes and uploaded v7 with the reviewed-by. Any chance I can get an
Ack at least on the associated test patch? Or should I send these
somewhere else for review?

> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index ebaba02706c87..c6b70f1ede6bf 100644
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
> > @@ -132,6 +133,10 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
> >  int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
> >               loff_t *);
> >
> > +int move_hugetlb_page_tables(struct vm_area_struct *vma,
> > +                          struct vm_area_struct *new_vma,
> > +                          unsigned long old_addr, unsigned long new_addr,
> > +                          unsigned long len);
> >  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
> >  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
> >                        struct page **, struct vm_area_struct **,
> > @@ -215,6 +220,10 @@ static inline void reset_vma_resv_huge_pages(struct vm_area_struct *vma)
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
> > @@ -262,6 +271,12 @@ static inline int copy_hugetlb_page_range(struct mm_struct *dst,
> >       return 0;
> >  }
> >
> > +#define move_hugetlb_page_tables(vma, new_vma, old_addr, new_addr, len)        \
> > +     ({                                                                     \
> > +             BUG();                                                         \
> > +             0;                                                             \
> > +     })
> > +
>
> Any reason why you did not make this a static inline?  Trying to save
> code in the !CONFIG_HUGETLB case?  macros seem to end up causing more
> issues down the line.  I would suggest making this a static inline
> unless there is a good reason to keep as a macro.
>

No good reason. I converted to static inline.

> >  static inline void hugetlb_report_meminfo(struct seq_file *m)
> >  {
> >  }
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6d2f4c25dd9fb..6e91cd3905e73 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> ...
> > +int move_hugetlb_page_tables(struct vm_area_struct *vma,
> > +                          struct vm_area_struct *new_vma,
> > +                          unsigned long old_addr, unsigned long new_addr,
> > +                          unsigned long len)
> > +{
> > +     struct hstate *h = hstate_vma(vma);
> > +     struct address_space *mapping = vma->vm_file->f_mapping;
> > +     unsigned long sz = huge_page_size(h);
> > +     struct mm_struct *mm = vma->vm_mm;
> > +     unsigned long old_end = old_addr + len;
> > +     unsigned long old_addr_copy;
> > +     pte_t *src_pte, *dst_pte;
> > +     struct mmu_notifier_range range;
> > +
> > +     mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, old_addr,
> > +                             old_end);
> > +     adjust_range_if_pmd_sharing_possible(vma, &range.start, &range.end);
> > +     mmu_notifier_invalidate_range_start(&range);
> > +     /* Prevent race with file truncation */
> > +     i_mmap_lock_write(mapping);
> > +     for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
> > +             src_pte = huge_pte_offset(mm, old_addr, sz);
> > +             if (!src_pte)
> > +                     continue;
> > +             if (huge_pte_none(huge_ptep_get(src_pte)))
> > +                     continue;
> > +
> > +             /* old_addr arg to huge_pmd_unshare() is a pointer and so the
> > +              * arg may be modified. Pass a copy instead to preserve the
> > +              * value in old_arg.
>
>                    value in old_addr.
>

Fixed.

> > +              */
> > +             old_addr_copy = old_addr;
> > +
> > +             if (huge_pmd_unshare(mm, vma, &old_addr_copy, src_pte))
> > +                     continue;
> > +
> > +             dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
> > +             if (!dst_pte)
> > +                     break;
> > +
> > +             move_huge_pte(vma, old_addr, new_addr, src_pte);
> > +     }
> > +     i_mmap_unlock_write(mapping);
> > +     flush_tlb_range(vma, old_end - len, old_end);
> > +     mmu_notifier_invalidate_range_end(&range);
> > +
> > +     return len + old_addr - old_end;
> > +}
> > +
> >  static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >                                  unsigned long start, unsigned long end,
> >                                  struct page *ref_page)
> > @@ -6280,7 +6385,8 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
> >       return saddr;
> >  }
> >
> > -static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
> > +static bool hugetlb_vma_shareable(struct vm_area_struct *vma,
> > +                               unsigned long addr)
> >  {
> >       unsigned long base = addr & PUD_MASK;
> >       unsigned long end = base + PUD_SIZE;
> > @@ -6299,7 +6405,7 @@ bool want_pmd_share(struct vm_area_struct *vma, unsigned long addr)
> >       if (uffd_disable_huge_pmd_share(vma))
> >               return false;
> >  #endif
> > -     return vma_shareable(vma, addr);
> > +     return hugetlb_vma_shareable(vma, addr);
> >  }
> >
> >  /*
>
> In an earlier version of the patch, vma_shareable was renamed
> hugetlb_vma_shareable because it was going to be used outside hugetlb.c.
> Therefore the hugetlb_* name would provide some context.  That is no
> longer the case.  So, there really is no need to change the name.  In
> fact, none of the remap code even calls this routine.  Sugggest you
> drop the name change.

Fixed.

> --
> Mike Kravetz
