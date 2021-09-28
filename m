Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E928B41A5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhI1Coc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbhI1Cob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:44:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF22CC061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:42:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x4so5654982pln.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcZUk01AmOiNGBqm3bwH5OUg5lIXll9emOour941K2Y=;
        b=xCJ6k7FbVBdK/P2m3lVGtjFfm68Jw6+5ovLifdpkAuxwlz2fNmulDdTfM8NMRhGRuD
         SD7ezYQWV7QTZPJ7+knQt8svjcZF6YzyZlLuRgO6VeI1sAYxmre1JEuPtiaSsJBU1Ndm
         xf1WNI26pAMW8AFwBKzK5FWoWK7hNwwWFkNsLEDgZ0Zkb76oAZVbDqNI8wG3rn5jMDQB
         vZqmZsSSrFXa4YA+tccpmgP/fhwh29DK5kyzf1kA12V3AU9ew1VYMRUeIyrVQSmq1jXX
         W/sqLrd6AwL7SFgkhhgZCkiJ61qRsX6CAdG3xGaaZzQM43hkrkcf4TFBX+ajbdGljlaI
         3D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcZUk01AmOiNGBqm3bwH5OUg5lIXll9emOour941K2Y=;
        b=tAXOCCJ1ZBRuWMkNVfmVwmrfoTVNxATp2/tVYgkS2vLAvWgizHYGaZ56vNoadn3wia
         8YlHW2Ehf8AOvFQNbIHaPiyJduGV6GUAiOIZJ5QjadZLRbRIhCqE2dBZIlUDMEkwyX75
         qd46Kp6ezJjhnsbdzxxypRLhxYcyu4o1lhIsM1pyrhsVSQd2aDMavwZyfyqYivnzZjik
         uJuXf1j+hunnujxdqAijzPY3RCyNqFMm9rweGPYrQJT87lrHtGsopXrk6oeqQxPQeutv
         IaBFaajGpYNqEziz3EyETEBCmMD45ZR5n9e2ZjwuNyhWZf3V1FScstW2us8mbuG/ugzT
         +q9g==
X-Gm-Message-State: AOAM531+V0V2+2QpppSGLDk8/bSSWu/qgj+rCG8Be0gjTovGgZLgkNWQ
        /kgShYwhWON4b3kMeFUsDAEUdVEfNhqtrn8vP6vKFA==
X-Google-Smtp-Source: ABdhPJzPsHrm1ihPzZl9la3p6UIONTP6xuaHTQ/Qi95CqU6TyEX5qzI6aeJyNBEbp9fLB3WeJQ0xT/RW/gXWbugLTy8=
X-Received: by 2002:a17:90b:4f8a:: with SMTP id qe10mr2685263pjb.5.1632796972231;
 Mon, 27 Sep 2021 19:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210926031339.40043-1-songmuchun@bytedance.com>
 <20210926031339.40043-2-songmuchun@bytedance.com> <CAGsJ_4ztDHPmAdnx_H_1S7ZkDR9QpiG=MqZ-XdAqiYK7=WwpKg@mail.gmail.com>
In-Reply-To: <CAGsJ_4ztDHPmAdnx_H_1S7ZkDR9QpiG=MqZ-XdAqiYK7=WwpKg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 28 Sep 2021 10:42:15 +0800
Message-ID: <CAMZfGtVahadNpgTT1BQrcomAC9Kpj2R7NtygC7CLcQbp9g-Qew@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] mm: hugetlb: free the 2nd vmemmap page associated
 with each HugeTLB page
To:     Barry Song <21cnbao@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Chen Huang <chenhuang5@huawei.com>,
        "Bodeddula, Balasubramaniam" <bodeddub@amazon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 4:25 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Sun, Sep 26, 2021 at 4:14 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Currently, we only free 6 vmemmap pages associated with a 2MB HugeTLB
> > page. However, we can remap all tail vmemmap pages to the page frame
> > mapped to with the head vmemmap page. Finally, we can free 7 vmemmap
> > pages for a 2MB HugeTLB page. It is a fine gain (e.g. we can save
> > extra 2GB memory when there is 1TB HugeTLB pages in the system
> > compared with the current implementation).
> >
> > But the head vmemmap page is not freed to the buddy allocator and all
> > tail vmemmap pages are mapped to the head vmemmap page frame. So we
> > can see more than one struct page struct with PG_head (e.g. 8 per 2 MB
> > HugeTLB page) associated with each HugeTLB page. We should adjust
> > compound_head() to make it returns the real head struct page when the
> > parameter is the tail struct page but with PG_head flag.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  2 +-
> >  include/linux/page-flags.h                      | 78 +++++++++++++++++++++++--
> >  mm/hugetlb_vmemmap.c                            | 60 ++++++++++---------
> >  mm/sparse-vmemmap.c                             | 21 +++++++
> >  4 files changed, 129 insertions(+), 32 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 91ba391f9b32..5aaf2f271980 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1617,7 +1617,7 @@
> >                         [KNL] Reguires CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> >                         enabled.
> >                         Allows heavy hugetlb users to free up some more
> > -                       memory (6 * PAGE_SIZE for each 2MB hugetlb page).
> > +                       memory (7 * PAGE_SIZE for each 2MB hugetlb page).
> >                         Format: { on | off (default) }
> >
> >                         on:  enable the feature
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 70bf0ec29ee3..b49808e748ce 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -184,13 +184,69 @@ enum pageflags {
> >
> >  #ifndef __GENERATING_BOUNDS_H
> >
> > +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> > +extern bool hugetlb_free_vmemmap_enabled;
> > +
> > +/*
> > + * If the feature of freeing some vmemmap pages associated with each HugeTLB
> > + * page is enabled, the head vmemmap page frame is reused and all of the tail
> > + * vmemmap addresses map to the head vmemmap page frame (furture details can
> > + * refer to the figure at the head of the mm/hugetlb_vmemmap.c).  In other
> > + * words, there are more than one page struct with PG_head associated with each
> > + * HugeTLB page.  We __know__ that there is only one head page struct, the tail
> > + * page structs with PG_head are fake head page structs.  We need an approach
> > + * to distinguish between those two different types of page structs so that
> > + * compound_head() can return the real head page struct when the parameter is
> > + * the tail page struct but with PG_head.
> > + *
> > + * The page_fixed_fake_head() returns the real head page struct if the @page is
> > + * fake page head, otherwise, returns @page which can either be a true page
> > + * head or tail.
> > + */
> > +static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
> > +{
> > +       if (!hugetlb_free_vmemmap_enabled)
> > +               return page;
> > +
> > +       /*
> > +        * Only addresses aligned with PAGE_SIZE of struct page may be fake head
> > +        * struct page. The alignment check aims to avoid access the fields (
> > +        * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
> > +        * cold cacheline in some cases.
> > +        */
> > +       if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
> > +           test_bit(PG_head, &page->flags)) {
> > +               /*
> > +                * We can safely access the field of the @page[1] with PG_head
> > +                * because the @page is a compound page composed with at least
> > +                * two contiguous pages.
> > +                */
> > +               unsigned long head = READ_ONCE(page[1].compound_head);
> > +
> > +               if (likely(head & 1))
> > +                       return (const struct page *)(head - 1);
> > +       }
> > +       return page;
> > +}
> > +#else
> > +static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
> > +{
> > +       return page;
> > +}
> > +#endif
> > +
> > +static __always_inline int page_is_fake_head(struct page *page)
> > +{
> > +       return page_fixed_fake_head(page) != page;
> > +}
> > +
> >  static inline unsigned long _compound_head(const struct page *page)
> >  {
> >         unsigned long head = READ_ONCE(page->compound_head);
> >
> >         if (unlikely(head & 1))
> >                 return head - 1;
> > -       return (unsigned long)page;
> > +       return (unsigned long)page_fixed_fake_head(page);
> >  }
> >
> >  #define compound_head(page)    ((typeof(page))_compound_head(page))
> > @@ -225,12 +281,13 @@ static inline unsigned long _compound_head(const struct page *page)
> >
> >  static __always_inline int PageTail(struct page *page)
> >  {
> > -       return READ_ONCE(page->compound_head) & 1;
> > +       return READ_ONCE(page->compound_head) & 1 || page_is_fake_head(page);
> >  }
> >
> >  static __always_inline int PageCompound(struct page *page)
> >  {
> > -       return test_bit(PG_head, &page->flags) || PageTail(page);
> > +       return test_bit(PG_head, &page->flags) ||
> > +              READ_ONCE(page->compound_head) & 1;
> >  }
> >
> >  #define        PAGE_POISON_PATTERN     -1l
> > @@ -675,7 +732,20 @@ static inline bool test_set_page_writeback(struct page *page)
> >         return set_page_writeback(page);
> >  }
> >
> > -__PAGEFLAG(Head, head, PF_ANY) CLEARPAGEFLAG(Head, head, PF_ANY)
> > +static __always_inline bool folio_test_head(struct folio *folio)
> > +{
> > +       return test_bit(PG_head, folio_flags(folio, FOLIO_PF_ANY));
> > +}
> > +
> > +static __always_inline int PageHead(struct page *page)
> > +{
> > +       PF_POISONED_CHECK(page);
> > +       return test_bit(PG_head, &page->flags) && !page_is_fake_head(page);
> > +}
> > +
> > +__SETPAGEFLAG(Head, head, PF_ANY)
> > +__CLEARPAGEFLAG(Head, head, PF_ANY)
> > +CLEARPAGEFLAG(Head, head, PF_ANY)
> >
> >  /* Whether there are one or multiple pages in a folio */
> >  static inline bool folio_test_single(struct folio *folio)
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index c540c21e26f5..f4a8fca691ee 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -124,9 +124,9 @@
> >   * page of page structs (page 0) associated with the HugeTLB page contains the 4
> >   * page structs necessary to describe the HugeTLB. The only use of the remaining
> >   * pages of page structs (page 1 to page 7) is to point to page->compound_head.
> > - * Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
> > + * Therefore, we can remap pages 1 to 7 to page 0. Only 1 page of page structs
> >   * will be used for each HugeTLB page. This will allow us to free the remaining
> > - * 6 pages to the buddy allocator.
> > + * 7 pages to the buddy allocator.
> >   *
> >   * Here is how things look after remapping.
> >   *
> > @@ -134,30 +134,30 @@
> >   * +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
> >   * |           |                     |     0     | -------------> |     0     |
> >   * |           |                     +-----------+                +-----------+
> > - * |           |                     |     1     | -------------> |     1     |
> > - * |           |                     +-----------+                +-----------+
> > - * |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
> > - * |           |                     +-----------+                   | | | | |
> > - * |           |                     |     3     | ------------------+ | | | |
> > - * |           |                     +-----------+                     | | | |
> > - * |           |                     |     4     | --------------------+ | | |
> > - * |    PMD    |                     +-----------+                       | | |
> > - * |   level   |                     |     5     | ----------------------+ | |
> > - * |  mapping  |                     +-----------+                         | |
> > - * |           |                     |     6     | ------------------------+ |
> > - * |           |                     +-----------+                           |
> > - * |           |                     |     7     | --------------------------+
> > + * |           |                     |     1     | ---------------^ ^ ^ ^ ^ ^ ^
> > + * |           |                     +-----------+                  | | | | | |
> > + * |           |                     |     2     | -----------------+ | | | | |
> > + * |           |                     +-----------+                    | | | | |
> > + * |           |                     |     3     | -------------------+ | | | |
> > + * |           |                     +-----------+                      | | | |
> > + * |           |                     |     4     | ---------------------+ | | |
> > + * |    PMD    |                     +-----------+                        | | |
> > + * |   level   |                     |     5     | -----------------------+ | |
> > + * |  mapping  |                     +-----------+                          | |
> > + * |           |                     |     6     | -------------------------+ |
> > + * |           |                     +-----------+                            |
> > + * |           |                     |     7     | ---------------------------+
> >   * |           |                     +-----------+
> >   * |           |
> >   * |           |
> >   * |           |
> >   * +-----------+
> >   *
> > - * When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> > + * When a HugeTLB is freed to the buddy system, we should allocate 7 pages for
> >   * vmemmap pages and restore the previous mapping relationship.
> >   *
> >   * For the HugeTLB page of the pud level mapping. It is similar to the former.
> > - * We also can use this approach to free (PAGE_SIZE - 2) vmemmap pages.
> > + * We also can use this approach to free (PAGE_SIZE - 1) vmemmap pages.
> >   *
> >   * Apart from the HugeTLB page of the pmd/pud level mapping, some architectures
> >   * (e.g. aarch64) provides a contiguous bit in the translation table entries
> > @@ -166,7 +166,13 @@
> >   *
> >   * The contiguous bit is used to increase the mapping size at the pmd and pte
> >   * (last) level. So this type of HugeTLB page can be optimized only when its
> > - * size of the struct page structs is greater than 2 pages.
> > + * size of the struct page structs is greater than 1 page.
> > + *
> > + * Notice: The head vmemmap page is not freed to the buddy allocator and all
> > + * tail vmemmap pages are mapped to the head vmemmap page frame. So we can see
> > + * more than one struct page struct with PG_head (e.g. 8 per 2 MB HugeTLB page)
> > + * associated with each HugeTLB page. The compound_head() can handle this
> > + * correctly (more details refer to the comment above compound_head()).
> >   */
> >  #define pr_fmt(fmt)    "HugeTLB: " fmt
> >
> > @@ -175,14 +181,16 @@
> >  /*
> >   * There are a lot of struct page structures associated with each HugeTLB page.
> >   * For tail pages, the value of compound_head is the same. So we can reuse first
> > - * page of tail page structures. We map the virtual addresses of the remaining
> > - * pages of tail page structures to the first tail page struct, and then free
> > - * these page frames. Therefore, we need to reserve two pages as vmemmap areas.
> > + * page of head page structures. We map the virtual addresses of all the pages
> > + * of tail page structures to the head page struct, and then free these page
> > + * frames. Therefore, we need to reserve one pages as vmemmap areas.
> >   */
> > -#define RESERVE_VMEMMAP_NR             2U
> > +#define RESERVE_VMEMMAP_NR             1U
> >  #define RESERVE_VMEMMAP_SIZE           (RESERVE_VMEMMAP_NR << PAGE_SHIFT)
> >
> > -bool hugetlb_free_vmemmap_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> > +bool hugetlb_free_vmemmap_enabled __read_mostly =
> > +       IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
> > +EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled);
> >
> >  static int __init early_hugetlb_free_vmemmap_param(char *buf)
> >  {
> > @@ -236,7 +244,6 @@ int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> >          */
> >         ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> >                                   GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
> > -
> >         if (!ret)
> >                 ClearHPageVmemmapOptimized(head);
> >
> > @@ -282,9 +289,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
> >
> >         vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
> >         /*
> > -        * The head page and the first tail page are not to be freed to buddy
> > -        * allocator, the other pages will map to the first tail page, so they
> > -        * can be freed.
> > +        * The head page is not to be freed to buddy allocator, the other tail
> > +        * pages will map to the head page, so they can be freed.
> >          *
> >          * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
> >          * on some architectures (e.g. aarch64). See Documentation/arm64/
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index db6df27c852a..54784d60f19d 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -53,6 +53,17 @@ struct vmemmap_remap_walk {
> >         struct list_head *vmemmap_pages;
> >  };
> >
> > +/*
> > + * How many struct page structs need to be reset. When we reuse the head
> > + * struct page, the special metadata (e.g. page->flags or page->mapping)
> > + * cannot copy to the tail struct page structs. The invalid value will be
> > + * checked in the free_tail_pages_check(). In order to avoid the message
> > + * of "corrupted mapping in tail page". We need to reset at least 3 (one
> > + * head struct page struct and two tail struct page structs) struct page
> > + * structs.
> > + */
> > +#define NR_RESET_STRUCT_PAGE           3
> > +
> >  static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
> >                                   struct vmemmap_remap_walk *walk)
> >  {
> > @@ -245,6 +256,15 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> >         set_pte_at(&init_mm, addr, pte, entry);
> >  }
> >
> > +static inline void reset_struct_pages(struct page *start)
> > +{
> > +       int i;
> > +       struct page *from = start + NR_RESET_STRUCT_PAGE;
> > +
> > +       for (i = 0; i < NR_RESET_STRUCT_PAGE; i++)
> > +               memcpy(start + i, from, sizeof(*from));
>
> better to move the MACRO into this function or just before
> vmemmap_restore_pte() if nobody else cares about it.

Got it.

>
> +/*
> + * How many struct page structs need to be reset. When we reuse the head
> + * struct page, the special metadata (e.g. page->flags or page->mapping)
> + * cannot copy to the tail struct page structs. The invalid value will be
> + * checked in the free_tail_pages_check(). In order to avoid the message
> + * of "corrupted mapping in tail page". We need to reset at least 3 (one
> + * head struct page struct and two tail struct page structs) struct page
> + * structs.
> + */
> +#define NR_RESET_STRUCT_PAGE           3
>
> for example, highmem.c:
>
> /*
>  * With DEBUG_KMAP_LOCAL the stack depth is doubled and every second
>  * slot is unused which acts as a guard page
>  */
> #ifdef CONFIG_DEBUG_KMAP_LOCAL
> # define KM_INCR        2
> #else
> # define KM_INCR        1
> #endif
>
> static inline int kmap_local_idx_push(void)
> {
>         WARN_ON_ONCE(in_hardirq() && !irqs_disabled());
>         current->kmap_ctrl.idx += KM_INCR;
>         BUG_ON(current->kmap_ctrl.idx >= KM_MAX_IDX);
>         return current->kmap_ctrl.idx - 1;
> }
>
> static inline int kmap_local_idx(void)
> {
>         return current->kmap_ctrl.idx - 1;
> }
>
> static inline void kmap_local_idx_pop(void)
> {
>         current->kmap_ctrl.idx -= KM_INCR;
>         BUG_ON(current->kmap_ctrl.idx < 0);
> }
>
> it is usually better to put one macro to where it will be used if the
> macro is not global.

Thanks for your example.

>
> With the change,
> Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

Thanks.

>
> +
> > +}
> > +
> >  static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> >                                 struct vmemmap_remap_walk *walk)
> >  {
> > @@ -258,6 +278,7 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> >         list_del(&page->lru);
> >         to = page_to_virt(page);
> >         copy_page(to, (void *)walk->reuse_addr);
> > +       reset_struct_pages(to);
> >
> >         set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> >  }
> > --
> > 2.11.0
> >
>
> Thanks
> barry
