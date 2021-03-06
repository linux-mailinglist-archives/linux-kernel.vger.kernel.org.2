Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE332F894
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 07:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhCFGDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 01:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhCFGCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 01:02:53 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546B6C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 22:02:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d11so2468138plo.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 22:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Fa3wUxza13qWVc7kJA4/5KkcDVBLcP6+IIZTNJ3Myk=;
        b=efj131eYYNFHCr7ePz3HMn0aL2RpEoFkfRUSaRgN8ykhiRgTcBqpxAxzk0g/9EXMSY
         Dt64Mtir/geDVaPmwz+VUDCFyTM994+uYBAkGASBHUSDSNs7JgEd1LUcF2Npfze71RQ+
         eMt4NmSgMvOB+gDCCzoy7XR6JOCqYP99uafUtEafriGGjAuk7gEZDoGPd9SdUQil7N5c
         QR/XUwB/0+G7RNhLs2JfGG+vvKsHVLFW5no1ctWntBr7CCr+2/p5ow51HSS/RTh5aito
         odNeRab4e9SVEIlUekjOH0qv1n9PS3kENO41m5fXYAhhs2rtZpe83Tm24x4qe69el5pn
         Txpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Fa3wUxza13qWVc7kJA4/5KkcDVBLcP6+IIZTNJ3Myk=;
        b=PwJ02eaYoLCrvgYbDklnANSE0ugvaoeIghZcgy5xif8bOgU2czwvjdoNDqY9DAcDQp
         75RthmFI82auU6ujHzdnZRHMAVTqzABBQTkzzIg58IBzO2lHLHRQM0tpjvXcyUvMJfqf
         YCsMzesDxlAvZzhyN/hx/iAF6YOmd7o6h7E3hHWusoBCALqT31OaDogOLsyg7JmLTXoD
         WuxSufPXN3i39JwM0xo2KjFIvQAPn8Si6oRJE7o+SHrvZTy1zzUzyhsWpcAszJtr5B6z
         lgR/2iTBJLRhZOu8BCRRNFNoXatLFZGM/Irk8KjkZK/72RgWZOGdX7k2b8JXcDybpjwc
         7P4Q==
X-Gm-Message-State: AOAM533omlqiLkb2XEBEjVt0m2cVXCM26QTU7a+bz3qakboPmpcRqZuW
        xdxOENKmHe45rfbwBobTVO+VkPQVwmSkH5fO8k0Xcg==
X-Google-Smtp-Source: ABdhPJznuoWZ5W2eD+Obr4DiJpOPc+iKSwo7xc+bFXcOrzoFPgQpSg/g1taKzuFZ6ZuIBlwdt5EGhEYLOeXddScUdw8=
X-Received: by 2002:a17:90a:1917:: with SMTP id 23mr14128230pjg.147.1615010572565;
 Fri, 05 Mar 2021 22:02:52 -0800 (PST)
MIME-Version: 1.0
References: <20210303055917.66054-1-songmuchun@bytedance.com>
 <20210303055917.66054-3-songmuchun@bytedance.com> <YEJ/w/FLVMbbedbG@carbon.dhcp.thefacebook.com>
In-Reply-To: <YEJ/w/FLVMbbedbG@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 6 Mar 2021 14:02:16 +0800
Message-ID: <CAMZfGtW7zpitVKD==cOArYPGC1uXrqibxKvPGqwHjndtEEJVyw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/5] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 3:00 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Mar 03, 2021 at 01:59:14PM +0800, Muchun Song wrote:
> > We want to reuse the obj_cgroup APIs to charge the kmem pages when
> > If we do that, we should store an object cgroup pointer to
> > page->memcg_data for the kmem pages.
> >
> > Finally, page->memcg_data can have 3 different meanings.
> >
> >   1) For the slab pages, page->memcg_data points to an object cgroups
> >      vector.
> >
> >   2) For the kmem pages (exclude the slab pages), page->memcg_data
> >      points to an object cgroup.
> >
> >   3) For the user pages (e.g. the LRU pages), page->memcg_data points
> >      to a memory cgroup.
> >
> > Currently we always get the memory cgroup associated with a page via
> > page_memcg() or page_memcg_rcu(). page_memcg_check() is special, it
> > has to be used in cases when it's not known if a page has an
> > associated memory cgroup pointer or an object cgroups vector. Because
> > the page->memcg_data of the kmem page is not pointing to a memory
> > cgroup in the later patch, the page_memcg() and page_memcg_rcu()
> > cannot be applicable for the kmem pages. In this patch, make
> > page_memcg() and page_memcg_rcu() no longer apply to the kmem pages.
> > We do not change the behavior of the page_memcg_check(), it is also
> > applicable for the kmem pages.
> >
> > In the end, there are 3 helpers to get the memcg associated with a page.
> > Usage is as follows.
> >
> >   1) Get the memory cgroup associated with a non-kmem page (e.g. the LRU
> >      pages).
> >
> >      - page_memcg()
> >      - page_memcg_rcu()
> >
> >   2) Get the memory cgroup associated with a page. It has to be used in
> >      cases when it's not known if a page has an associated memory cgroup
> >      pointer or an object cgroups vector. Returns NULL for slab pages or
> >      uncharged pages. Otherwise, returns memory cgroup for charged pages
> >      (e.g. the kmem pages, the LRU pages).
> >
> >      - page_memcg_check()
> >
> > In some place, we use page_memcg() to check whether the page is charged.
> > Now introduce page_memcg_charged() helper to do that.
> >
> > This is a preparation for reparenting the kmem pages.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> This patch also looks good to me, but, please, make it safe for adding
> new memcg_data flags. E.g. if someone will add a new flag with a completely
> new meaning, it shouldn't break the code.

I'm not thoughtful enough. Will do that in the next version.
Thanks for your suggestions.

>
> I'll ack it after another look at the final version, but overall it
> looks good.
>
> Thanks!
>
> > ---
> >  include/linux/memcontrol.h | 36 ++++++++++++++++++++++++++++--------
> >  mm/memcontrol.c            | 23 +++++++++++++----------
> >  mm/page_alloc.c            |  4 ++--
> >  3 files changed, 43 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index e6dc793d587d..049b80246cbf 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -358,14 +358,26 @@ enum page_memcg_data_flags {
> >
> >  #define MEMCG_DATA_FLAGS_MASK (__NR_MEMCG_DATA_FLAGS - 1)
> >
> > +/* Return true for charged page, otherwise false. */
> > +static inline bool page_memcg_charged(struct page *page)
> > +{
> > +     unsigned long memcg_data = page->memcg_data;
> > +
> > +     VM_BUG_ON_PAGE(PageSlab(page), page);
> > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > +
> > +     return !!memcg_data;
> > +}
> > +
> >  /*
> > - * page_memcg - get the memory cgroup associated with a page
> > + * page_memcg - get the memory cgroup associated with a non-kmem page
> >   * @page: a pointer to the page struct
> >   *
> >   * Returns a pointer to the memory cgroup associated with the page,
> >   * or NULL. This function assumes that the page is known to have a
> >   * proper memory cgroup pointer. It's not safe to call this function
> > - * against some type of pages, e.g. slab pages or ex-slab pages.
> > + * against some type of pages, e.g. slab pages, kmem pages or ex-slab
> > + * pages.
> >   *
> >   * Any of the following ensures page and memcg binding stability:
> >   * - the page lock
> > @@ -378,27 +390,30 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
> >       unsigned long memcg_data = page->memcg_data;
> >
> >       VM_BUG_ON_PAGE(PageSlab(page), page);
> > -     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_FLAGS_MASK, page);
> >
> > -     return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> > +     return (struct mem_cgroup *)memcg_data;
> >  }
> >
> >  /*
> > - * page_memcg_rcu - locklessly get the memory cgroup associated with a page
> > + * page_memcg_rcu - locklessly get the memory cgroup associated with a non-kmem page
> >   * @page: a pointer to the page struct
> >   *
> >   * Returns a pointer to the memory cgroup associated with the page,
> >   * or NULL. This function assumes that the page is known to have a
> >   * proper memory cgroup pointer. It's not safe to call this function
> > - * against some type of pages, e.g. slab pages or ex-slab pages.
> > + * against some type of pages, e.g. slab pages, kmem pages or ex-slab
> > + * pages.
> >   */
> >  static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> >  {
> > +     unsigned long memcg_data = READ_ONCE(page->memcg_data);
> > +
> >       VM_BUG_ON_PAGE(PageSlab(page), page);
> > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_FLAGS_MASK, page);
> >       WARN_ON_ONCE(!rcu_read_lock_held());
> >
> > -     return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
> > -                                  ~MEMCG_DATA_FLAGS_MASK);
> > +     return (struct mem_cgroup *)memcg_data;
> >  }
> >
> >  /*
> > @@ -1072,6 +1087,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
> >
> >  struct mem_cgroup;
> >
> > +static inline bool page_memcg_charged(struct page *page)
> > +{
> > +     return false;
> > +}
> > +
> >  static inline struct mem_cgroup *page_memcg(struct page *page)
> >  {
> >       return NULL;
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index faae16def127..86a8db937ec6 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -855,10 +855,11 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
> >                            int val)
> >  {
> >       struct page *head = compound_head(page); /* rmap on tail pages */
> > -     struct mem_cgroup *memcg = page_memcg(head);
> > +     struct mem_cgroup *memcg;
> >       pg_data_t *pgdat = page_pgdat(page);
> >       struct lruvec *lruvec;
> >
> > +     memcg = page_memcg_check(head);
> >       /* Untracked pages have no memcg, no lruvec. Update only the node */
> >       if (!memcg) {
> >               __mod_node_page_state(pgdat, idx, val);
> > @@ -3166,12 +3167,13 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> >   */
> >  void __memcg_kmem_uncharge_page(struct page *page, int order)
> >  {
> > -     struct mem_cgroup *memcg = page_memcg(page);
> > +     struct mem_cgroup *memcg;
> >       unsigned int nr_pages = 1 << order;
> >
> > -     if (!memcg)
> > +     if (!page_memcg_charged(page))
> >               return;
> >
> > +     memcg = page_memcg_check(page);
> >       VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
> >       __memcg_kmem_uncharge(memcg, nr_pages);
> >       page->memcg_data = 0;
> > @@ -6827,24 +6829,25 @@ static void uncharge_batch(const struct uncharge_gather *ug)
> >  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  {
> >       unsigned long nr_pages;
> > +     struct mem_cgroup *memcg;
> >
> >       VM_BUG_ON_PAGE(PageLRU(page), page);
> >
> > -     if (!page_memcg(page))
> > +     if (!page_memcg_charged(page))
> >               return;
> >
> >       /*
> >        * Nobody should be changing or seriously looking at
> > -      * page_memcg(page) at this point, we have fully
> > -      * exclusive access to the page.
> > +      * page memcg at this point, we have fully exclusive
> > +      * access to the page.
> >        */
> > -
> > -     if (ug->memcg != page_memcg(page)) {
> > +     memcg = page_memcg_check(page);
> > +     if (ug->memcg != memcg) {
> >               if (ug->memcg) {
> >                       uncharge_batch(ug);
> >                       uncharge_gather_clear(ug);
> >               }
> > -             ug->memcg = page_memcg(page);
> > +             ug->memcg = memcg;
> >
> >               /* pairs with css_put in uncharge_batch */
> >               css_get(&ug->memcg->css);
> > @@ -6877,7 +6880,7 @@ void mem_cgroup_uncharge(struct page *page)
> >               return;
> >
> >       /* Don't touch page->lru of any random page, pre-check: */
> > -     if (!page_memcg(page))
> > +     if (!page_memcg_charged(page))
> >               return;
> >
> >       uncharge_gather_clear(&ug);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index f10966e3b4a5..bcb58ae15e24 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1124,7 +1124,7 @@ static inline bool page_expected_state(struct page *page,
> >       if (unlikely((unsigned long)page->mapping |
> >                       page_ref_count(page) |
> >  #ifdef CONFIG_MEMCG
> > -                     (unsigned long)page_memcg(page) |
> > +                     page_memcg_charged(page) |
> >  #endif
> >                       (page->flags & check_flags)))
> >               return false;
> > @@ -1149,7 +1149,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >                       bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
> >       }
> >  #ifdef CONFIG_MEMCG
> > -     if (unlikely(page_memcg(page)))
> > +     if (unlikely(page_memcg_charged(page)))
> >               bad_reason = "page still charged to cgroup";
> >  #endif
> >       return bad_reason;
> > --
> > 2.11.0
> >
