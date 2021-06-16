Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2BB3A8F58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFPD0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPD0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:26:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC753C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:24:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h16so879016pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JyDs0OMCH+Ypmba5CrMs+O02aKFGnR/7AHIpLJO2r28=;
        b=RcA38uWKSbRLJRYyS+GJhfX/olyKQhiD20+S7PXsyH9z4U8DaeEz6a8Qamg4AetEmh
         EPTnt9omV1bWmA0wupjQ9ed+9Y/aG+FXNZNivgo/3lFxYglDpdMTng2TLfKK3jqtKUAJ
         rGJohx/qnc8DTUK83IJDF3zgs3igPHNaL/6a5Ov2D4ofmdwLqOK5SWX280kXQ1/YcWBc
         2pGq6LFQVQ1erAGu3C2LxrB2nOVm7WYkgkE2PRafY9EMSdxVPhb5a/Xx5dtN1MiyGSXj
         SnCeY4DPGBFiSKBezFudbxcLIjihMDu5j/9cPGBFQGRkpb8bip0nmRgkz4ps2Qxzmfs1
         Rn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JyDs0OMCH+Ypmba5CrMs+O02aKFGnR/7AHIpLJO2r28=;
        b=Mj9tYjBKV6McpqYrjGqBBJbddB37wu5rgCDBP83RAEibIFrROyGUnuHplSya4KlQbN
         MLzC1aTIAMEeBL0kdDf+oj8wBveqcvf2gCgVE1R/KeNZ5cFVmuAyiFK4ohDGMlR/a1w4
         IuZScy7i2i2pmjVka/y9qkH5dJIuJ3WP3hjtf7ibmnxRiQBE1nw7S8bWEXbktqIpFGaH
         2JYAakHELyPtL7nD0xElWU2tYkxfnghsuVG7emhZOMF0RJmr0ESakpydW8wv2p3M0sZ7
         i3/JiGEEC4upDaVBzTBEBjJUB77i9Zuk+Mj1tKGDJcgOvGsB34m7S4U/7+6NfkX0HqlN
         KQ6Q==
X-Gm-Message-State: AOAM531pQxRm+sGXPFZUEUhknQ4RNS1/HQejs/iONeQ+6w3rNwkmM6Xf
        crt5R48gbNQJNnwrqGA15DW5/c5NMBq3LUDcFux7Ow==
X-Google-Smtp-Source: ABdhPJzfu6MJb9y5ZgfFToO3/TR4gurd2s7AGJyXNi0mivW+L/EmFmYBmpyHvfB09a6s5QiZkVmbA5eVvIN5FMgfcEI=
X-Received: by 2002:a17:90a:9b13:: with SMTP id f19mr2613183pjp.229.1623813850163;
 Tue, 15 Jun 2021 20:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210612094555.71344-1-songmuchun@bytedance.com>
 <20210612094555.71344-2-songmuchun@bytedance.com> <d951d312-cbe8-ceed-6932-ee20de260aeb@oracle.com>
In-Reply-To: <d951d312-cbe8-ceed-6932-ee20de260aeb@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 16 Jun 2021 11:23:32 +0800
Message-ID: <CAMZfGtXq_LpEB791BJ0P4SWSftU8t2CyD8vv52fO=j4P6AX1aQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/3] mm: sparsemem: split the huge PMD
 mapping of vmemmap pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 6:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 6/12/21 2:45 AM, Muchun Song wrote:
> > Currently, we disable huge PMD mapping of vmemmap pages when that feature
> > of "Free some vmemmap pages of HugeTLB pages" is enabled. If the vmemmap
> > is huge PMD mapped when we walk the vmemmap page tables, we split the
> > huge PMD firstly and then we move to PTE mappings. When HugeTLB pages are
> > freed from the pool we do not attempt coalasce and move back to a PMD
> > mapping because it is much more complex.
>
> Possible rewording of commit message:
>
> In [1], PMD mappings of vmemmap pages were disabled if the the feature
> hugetlb_free_vmemmap was enabled.  This was done to simplify the initial
> implementation of vmmemap freeing for hugetlb pages.  Now, remove this
> simplification by allowing PMD mapping and switching to PTE mappings as
> needed for allocated hugetlb pages.
>
> When a hugetlb page is allocated, the vmemmap page tables are walked to
> free vmemmap pages.  During this walk, split huge PMD mappings to PTE
> mappings as required.  In the unlikely case PTE pages can not be allocated,
> return error(ENOMEM) and do not optimize vmemmap of the hugetlb page.
>
> When HugeTLB pages are freed from the pool, we do not attempt to coalesce
> and move back to a PMD mapping because it is much more complex.
>
> [1] https://lkml.kernel.org/r/20210510030027.56044-8-songmuchun@bytedance.com

Thanks, Mike, I'll reuse this.

>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/mm.h   |   4 +-
> >  mm/hugetlb_vmemmap.c |   5 +-
> >  mm/sparse-vmemmap.c  | 157 ++++++++++++++++++++++++++++++++++++++-------------
> >  3 files changed, 123 insertions(+), 43 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index cadc8cc2c715..8284e8ed30c9 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3055,8 +3055,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
> >  }
> >  #endif
> >
> > -void vmemmap_remap_free(unsigned long start, unsigned long end,
> > -                     unsigned long reuse);
> > +int vmemmap_remap_free(unsigned long start, unsigned long end,
> > +                    unsigned long reuse);
> >  int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> >                       unsigned long reuse, gfp_t gfp_mask);
> >
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index f9f9bb212319..06802056f296 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -258,9 +258,8 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> >        * to the page which @vmemmap_reuse is mapped to, then free the pages
> >        * which the range [@vmemmap_addr, @vmemmap_end] is mapped to.
> >        */
> > -     vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
> > -
> > -     SetHPageVmemmapOptimized(head);
> > +     if (!vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse))
> > +             SetHPageVmemmapOptimized(head);
> >  }
> >
> >  void __init hugetlb_vmemmap_init(struct hstate *h)
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index 693de0aec7a8..7f73c37f742d 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -38,6 +38,7 @@
> >   * vmemmap_remap_walk - walk vmemmap page table
> >   *
> >   * @remap_pte:               called for each lowest-level entry (PTE).
> > + * @walked_pte:              the number of walked pte.
>
> Suggest name change to 'nr_walked_pte' or just 'nr_walked'?  walked_pte
> could be confused with a pointer to pte.

Make sense. Will update.

>
> >   * @reuse_page:              the page which is reused for the tail vmemmap pages.
> >   * @reuse_addr:              the virtual address of the @reuse_page page.
> >   * @vmemmap_pages:   the list head of the vmemmap pages that can be freed
> > @@ -46,11 +47,44 @@
> >  struct vmemmap_remap_walk {
> >       void (*remap_pte)(pte_t *pte, unsigned long addr,
> >                         struct vmemmap_remap_walk *walk);
> > +     unsigned long walked_pte;
> >       struct page *reuse_page;
> >       unsigned long reuse_addr;
> >       struct list_head *vmemmap_pages;
> >  };
> >
> > +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
> > +                               struct vmemmap_remap_walk *walk)
> > +{
> > +     pmd_t __pmd;
> > +     int i;
> > +     unsigned long addr = start;
> > +     struct page *page = pmd_page(*pmd);
> > +     pte_t *pgtable = pte_alloc_one_kernel(&init_mm);
> > +
> > +     if (!pgtable)
> > +             return -ENOMEM;
> > +
> > +     pmd_populate_kernel(&init_mm, &__pmd, pgtable);
> > +
> > +     for (i = 0; i < PMD_SIZE / PAGE_SIZE; i++, addr += PAGE_SIZE) {
> > +             pte_t entry, *pte;
> > +             pgprot_t pgprot = PAGE_KERNEL;
> > +
> > +             entry = mk_pte(page + i, pgprot);
> > +             pte = pte_offset_kernel(&__pmd, addr);
> > +             set_pte_at(&init_mm, addr, pte, entry);
> > +     }
> > +
> > +     /* Make pte visible before pmd. See comment in __pte_alloc(). */
> > +     smp_wmb();
> > +     pmd_populate_kernel(&init_mm, pmd, pgtable);
> > +
> > +     flush_tlb_kernel_range(start, start + PMD_SIZE);
> > +
> > +     return 0;
> > +}
> > +
> >  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> >                             unsigned long end,
> >                             struct vmemmap_remap_walk *walk)
> > @@ -68,59 +102,81 @@ static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> >                * walking, skip the reuse address range.
> >                */
> >               addr += PAGE_SIZE;
> > +             walk->walked_pte++;
> >               pte++;
> >       }
> >
> > -     for (; addr != end; addr += PAGE_SIZE, pte++)
> > +     for (; addr != end; addr += PAGE_SIZE, pte++) {
> >               walk->remap_pte(pte, addr, walk);
> > +             walk->walked_pte++;
> > +     }
> >  }
> >
> > -static void vmemmap_pmd_range(pud_t *pud, unsigned long addr,
> > -                           unsigned long end,
> > -                           struct vmemmap_remap_walk *walk)
> > +static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
> > +                          unsigned long end,
> > +                          struct vmemmap_remap_walk *walk)
> >  {
> >       pmd_t *pmd;
> >       unsigned long next;
> >
> >       pmd = pmd_offset(pud, addr);
> >       do {
> > -             BUG_ON(pmd_leaf(*pmd));
> > +             if (pmd_leaf(*pmd)) {
> > +                     int ret;
> >
> > +                     ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> >               next = pmd_addr_end(addr, end);
> >               vmemmap_pte_range(pmd, addr, next, walk);
> >       } while (pmd++, addr = next, addr != end);
> > +
> > +     return 0;
> >  }
> >
> > -static void vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
> > -                           unsigned long end,
> > -                           struct vmemmap_remap_walk *walk)
> > +static int vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
> > +                          unsigned long end,
> > +                          struct vmemmap_remap_walk *walk)
> >  {
> >       pud_t *pud;
> >       unsigned long next;
> >
> >       pud = pud_offset(p4d, addr);
> >       do {
> > +             int ret;
> > +
> >               next = pud_addr_end(addr, end);
> > -             vmemmap_pmd_range(pud, addr, next, walk);
> > +             ret = vmemmap_pmd_range(pud, addr, next, walk);
> > +             if (ret)
> > +                     return ret;
> >       } while (pud++, addr = next, addr != end);
> > +
> > +     return 0;
> >  }
> >
> > -static void vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
> > -                           unsigned long end,
> > -                           struct vmemmap_remap_walk *walk)
> > +static int vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
> > +                          unsigned long end,
> > +                          struct vmemmap_remap_walk *walk)
> >  {
> >       p4d_t *p4d;
> >       unsigned long next;
> >
> >       p4d = p4d_offset(pgd, addr);
> >       do {
> > +             int ret;
> > +
> >               next = p4d_addr_end(addr, end);
> > -             vmemmap_pud_range(p4d, addr, next, walk);
> > +             ret = vmemmap_pud_range(p4d, addr, next, walk);
> > +             if (ret)
> > +                     return ret;
> >       } while (p4d++, addr = next, addr != end);
> > +
> > +     return 0;
> >  }
> >
> > -static void vmemmap_remap_range(unsigned long start, unsigned long end,
> > -                             struct vmemmap_remap_walk *walk)
> > +static int vmemmap_remap_range(unsigned long start, unsigned long end,
> > +                            struct vmemmap_remap_walk *walk)
> >  {
> >       unsigned long addr = start;
> >       unsigned long next;
> > @@ -131,8 +187,12 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
> >
> >       pgd = pgd_offset_k(addr);
> >       do {
> > +             int ret;
> > +
> >               next = pgd_addr_end(addr, end);
> > -             vmemmap_p4d_range(pgd, addr, next, walk);
> > +             ret = vmemmap_p4d_range(pgd, addr, next, walk);
> > +             if (ret)
> > +                     return ret;
> >       } while (pgd++, addr = next, addr != end);
> >
> >       /*
> > @@ -141,6 +201,8 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
> >        * belongs to the range.
> >        */
> >       flush_tlb_kernel_range(start + PAGE_SIZE, end);
> > +
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -179,10 +241,27 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> >       pte_t entry = mk_pte(walk->reuse_page, pgprot);
> >       struct page *page = pte_page(*pte);
> >
> > -     list_add(&page->lru, walk->vmemmap_pages);
> > +     list_add_tail(&page->lru, walk->vmemmap_pages);
> >       set_pte_at(&init_mm, addr, pte, entry);
> >  }
> >
> > +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> > +                             struct vmemmap_remap_walk *walk)
> > +{
> > +     pgprot_t pgprot = PAGE_KERNEL;
> > +     struct page *page;
> > +     void *to;
> > +
> > +     BUG_ON(pte_page(*pte) != walk->reuse_page);
> > +
> > +     page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> > +     list_del(&page->lru);
> > +     to = page_to_virt(page);
> > +     copy_page(to, (void *)walk->reuse_addr);
> > +
> > +     set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> > +}
> > +
> >  /**
> >   * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> >   *                   to the page which @reuse is mapped to, then free vmemmap
> > @@ -193,12 +272,12 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> >   *           remap.
> >   * @reuse:   reuse address.
> >   *
> > - * Note: This function depends on vmemmap being base page mapped. Please make
> > - * sure that we disable PMD mapping of vmemmap pages when calling this function.
> > + * Return: %0 on success, negative error code otherwise.
> >   */
> > -void vmemmap_remap_free(unsigned long start, unsigned long end,
> > -                     unsigned long reuse)
> > +int vmemmap_remap_free(unsigned long start, unsigned long end,
> > +                    unsigned long reuse)
> >  {
> > +     int ret;
> >       LIST_HEAD(vmemmap_pages);
> >       struct vmemmap_remap_walk walk = {
> >               .remap_pte      = vmemmap_remap_pte,
> > @@ -221,25 +300,25 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
> >        */
> >       BUG_ON(start - reuse != PAGE_SIZE);
> >
> > -     vmemmap_remap_range(reuse, end, &walk);
> > -     free_vmemmap_page_list(&vmemmap_pages);
> > -}
> > +     mmap_write_lock(&init_mm);
> > +     ret = vmemmap_remap_range(reuse, end, &walk);
> > +     mmap_write_downgrade(&init_mm);
> >
> > -static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> > -                             struct vmemmap_remap_walk *walk)
> > -{
> > -     pgprot_t pgprot = PAGE_KERNEL;
> > -     struct page *page;
> > -     void *to;
> > +     if (ret && walk.walked_pte) {
> > +             end = reuse + walk.walked_pte * PAGE_SIZE;
>
> Might be good to have a comment saying:
>
>                 /*
>                  * vmemmap_pages contains pages from the previous
>                  * vmemmap_remap_range call which failed.  These
>                  * are pages which were removed from the vmemmap.
>                  * They will be restored in the following call.
>                  */

More clear. Will do.

>
> Code looks good and I like that changes were mostly isolated to
> sparse-vmemmap.c.
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks Mike.

>
> It still would be good if someone else takes a look at these changes.
> --
> Mike Kravetz
>
> > +             walk = (struct vmemmap_remap_walk) {
> > +                     .remap_pte      = vmemmap_restore_pte,
> > +                     .reuse_addr     = reuse,
> > +                     .vmemmap_pages  = &vmemmap_pages,
> > +             };
> >
> > -     BUG_ON(pte_page(*pte) != walk->reuse_page);
> > +             vmemmap_remap_range(reuse, end, &walk);
> > +     }
> > +     mmap_read_unlock(&init_mm);
> >
> > -     page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> > -     list_del(&page->lru);
> > -     to = page_to_virt(page);
> > -     copy_page(to, (void *)walk->reuse_addr);
> > +     free_vmemmap_page_list(&vmemmap_pages);
> >
> > -     set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> > +     return ret;
> >  }
> >
> >  static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> > @@ -273,6 +352,8 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
> >   *           remap.
> >   * @reuse:   reuse address.
> >   * @gpf_mask:        GFP flag for allocating vmemmap pages.
> > + *
> > + * Return: %0 on success, negative error code otherwise.
> >   */
> >  int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> >                       unsigned long reuse, gfp_t gfp_mask)
> > @@ -287,12 +368,12 @@ int vmemmap_remap_alloc(unsigned long start, unsigned long end,
> >       /* See the comment in the vmemmap_remap_free(). */
> >       BUG_ON(start - reuse != PAGE_SIZE);
> >
> > -     might_sleep_if(gfpflags_allow_blocking(gfp_mask));
> > -
> >       if (alloc_vmemmap_page_list(start, end, gfp_mask, &vmemmap_pages))
> >               return -ENOMEM;
> >
> > +     mmap_read_lock(&init_mm);
> >       vmemmap_remap_range(reuse, end, &walk);
> > +     mmap_read_unlock(&init_mm);
> >
> >       return 0;
> >  }
> >
