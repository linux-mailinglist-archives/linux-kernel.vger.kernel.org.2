Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1591A336C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhCKGvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCKGuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:50:50 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9371CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:50:50 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o10so13067755pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gy8z+iDVmbujI7kny+ZI/Ozlau0l7pUtmfyXuQSj6Hk=;
        b=1E4+i/zMPc+3v7kSJcsh3DUr+LeT/2BaxlDvP/jRXyNu14oc/A79BTgQ8XQ0YmaKjP
         hTrZlSsOMe2SyW5xQ05PsD8g+CQgyoSfJhzCvSYFlUiEYjJwsRoif67G/mRYDnXax1QK
         pMAVCeakgTsGe/gR5i1H5sJIowFKncKEr8NNiDSB/KqtFz3QsRLB3ukZnNtMX1fw7+Pa
         VSx8KEPyXV06f6U3EHyToWof0IJpqLCFHT2feQ3QT7Xx+doHeArel4q+IbOUv+p2Wl08
         VL/pYPylqPAcEBb2f0DjijoU0uNC1HkfvMFBX3t2TzAwkfgfxf0LEJisQP6590iqnfGl
         V6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gy8z+iDVmbujI7kny+ZI/Ozlau0l7pUtmfyXuQSj6Hk=;
        b=e9gjrX7eLShcANKhSG51LzCh6UgLHKgQV4XGuXbJ87De2syD5JFdfHXUPLmsNZVvnt
         1DF5QX42N2wtSlI70VeMX917qnof/dR+LqGAcOVL08+Cq17H/P/owbrwUCG7HDBrM92U
         0Jr7rQdRrS2zxjnFHEZN4q3H8nCdtavTEd17opWZ/iL4GgcSfdpUit9nqNSyDDNUJRsR
         xMDEBTodpH8lJ4l+TZ10U2aEQPc08ngsEk6BV48ZaMZfM+Bn196Pq0+6DD6PwnaWUujU
         YX67LYEW+ai11GHijPvyTWChx+WQh0HnP1Z243wnBp9536ZBocdWMHHfNl0rDob3oVCs
         q/FQ==
X-Gm-Message-State: AOAM531UWwy4K+8KWjmaJygXgnC4aqTl17f3GiZukmQtCKBR67cPXdqj
        L+fzmEdZ9xgnzJvzHsuZvm3Bn6oYFQ9nTC0qmyH2Bw==
X-Google-Smtp-Source: ABdhPJwOPsLr32TFsxyUO77tkAG/MDUIVAH4TSbihapuytRTDI5Hxc0VTOnkqrfd5vqbuQOdfX9ht0d1/3vOjK5KmXc=
X-Received: by 2002:a63:161c:: with SMTP id w28mr6138181pgl.341.1615445448808;
 Wed, 10 Mar 2021 22:50:48 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-4-songmuchun@bytedance.com> <YEkjyZr7Sle+adUJ@carbon.dhcp.thefacebook.com>
In-Reply-To: <YEkjyZr7Sle+adUJ@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 14:50:11 +0800
Message-ID: <CAMZfGtW01P3MxLEcTUU5Wqcd=Rbepr6FLtaOQUmdrgnaxEccDg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 3/4] mm: memcontrol: use obj_cgroup APIs
 to charge kmem pages
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

On Thu, Mar 11, 2021 at 3:53 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Mar 09, 2021 at 06:07:16PM +0800, Muchun Song wrote:
> > Since Roman series "The new cgroup slab memory controller" applied. All
> > slab objects are charged via the new APIs of obj_cgroup. The new APIs
> > introduce a struct obj_cgroup to charge slab objects. It prevents
> > long-living objects from pinning the original memory cgroup in the memory.
> > But there are still some corner objects (e.g. allocations larger than
> > order-1 page on SLUB) which are not charged via the new APIs. Those
> > objects (include the pages which are allocated from buddy allocator
> > directly) are charged as kmem pages which still hold a reference to
> > the memory cgroup.
> >
> > This patch aims to charge the kmem pages by using the new APIs of
> > obj_cgroup. Finally, the page->memcg_data of the kmem page points to
> > an object cgroup. We can use the page_objcg() to get the object
> > cgroup associated with a kmem page. Or we can use page_memcg_check()
> > to get the memory cgroup associated with a kmem page, but caller must
> > ensure that the returned memcg won't be released (e.g. acquire the
> > rcu_read_lock or css_set_lock).
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h |  63 ++++++++++++++++++------
> >  mm/memcontrol.c            | 119 ++++++++++++++++++++++++++++++---------------
> >  2 files changed, 128 insertions(+), 54 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 83cbcdcfcc92..07c449af9c0f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -370,6 +370,18 @@ static inline bool page_memcg_charged(struct page *page)
> >  }
> >
> >  /*
> > + * After the initialization objcg->memcg is always pointing at
> > + * a valid memcg, but can be atomically swapped to the parent memcg.
> > + *
> > + * The caller must ensure that the returned memcg won't be released:
> > + * e.g. acquire the rcu_read_lock or css_set_lock.
> > + */
> > +static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
> > +{
> > +     return READ_ONCE(objcg->memcg);
> > +}
> > +
> > +/*
> >   * page_memcg - get the memory cgroup associated with a non-kmem page
> >   * @page: a pointer to the page struct
> >   *
> > @@ -422,15 +434,19 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> >   * @page: a pointer to the page struct
> >   *
> >   * Returns a pointer to the memory cgroup associated with the page,
> > - * or NULL. This function unlike page_memcg() can take any  page
> > + * or NULL. This function unlike page_memcg() can take any page
> >   * as an argument. It has to be used in cases when it's not known if a page
> > - * has an associated memory cgroup pointer or an object cgroups vector.
> > + * has an associated memory cgroup pointer or an object cgroups vector or
> > + * an object cgroup.
> >   *
> >   * Any of the following ensures page and memcg binding stability:
> >   * - the page lock
> >   * - LRU isolation
> >   * - lock_page_memcg()
> >   * - exclusive reference
> > + *
> > + * Should be called under rcu lock which can protect memcg associated with a
> > + * kmem page from being released.
>
> How about this:
>
> For a non-kmem page any of the following ensures page and memcg binding stability:
> - the page lock
> - LRU isolation
> - lock_page_memcg()
> - exclusive reference
>
> For a kmem page a caller should hold an rcu read lock to protect memcg associated
> with a kmem page from being released.

OK. I will use this. Thanks Roman.

>
> >   */
> >  static inline struct mem_cgroup *page_memcg_check(struct page *page)
> >  {
> > @@ -443,6 +459,13 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
> >       if (memcg_data & MEMCG_DATA_OBJCGS)
> >               return NULL;
> >
> > +     if (memcg_data & MEMCG_DATA_KMEM) {
> > +             struct obj_cgroup *objcg;
> > +
> > +             objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> > +             return obj_cgroup_memcg(objcg);
> > +     }
> > +
> >       return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> >  }
> >
> > @@ -501,6 +524,25 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
> >       return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> >  }
> >
> > +/*
> > + * page_objcg - get the object cgroup associated with a kmem page
> > + * @page: a pointer to the page struct
> > + *
> > + * Returns a pointer to the object cgroup associated with the kmem page,
> > + * or NULL. This function assumes that the page is known to have an
> > + * associated object cgroup. It's only safe to call this function
> > + * against kmem pages (PageMemcgKmem() returns true).
> > + */
> > +static inline struct obj_cgroup *page_objcg(struct page *page)
> > +{
> > +     unsigned long memcg_data = page->memcg_data;
> > +
> > +     VM_BUG_ON_PAGE(PageSlab(page), page);
> > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > +     VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
> > +
> > +     return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> > +}
> >  #else
> >  static inline struct obj_cgroup **page_objcgs(struct page *page)
> >  {
> > @@ -511,6 +553,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
> >  {
> >       return NULL;
> >  }
> > +
> > +static inline struct obj_cgroup *page_objcg(struct page *page)
> > +{
> > +     return NULL;
> > +}
> >  #endif
> >
> >  static __always_inline bool memcg_stat_item_in_bytes(int idx)
> > @@ -729,18 +776,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> >       percpu_ref_put(&objcg->refcnt);
> >  }
> >
> > -/*
> > - * After the initialization objcg->memcg is always pointing at
> > - * a valid memcg, but can be atomically swapped to the parent memcg.
> > - *
> > - * The caller must ensure that the returned memcg won't be released:
> > - * e.g. acquire the rcu_read_lock or css_set_lock.
> > - */
> > -static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
> > -{
> > -     return READ_ONCE(objcg->memcg);
> > -}
> > -
> >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> >  {
> >       if (memcg)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e1dc73ceb98a..38376f9d6659 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -859,15 +859,26 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
> >       pg_data_t *pgdat = page_pgdat(page);
> >       struct lruvec *lruvec;
> >
> > -     memcg = page_memcg_check(head);
> > -     /* Untracked pages have no memcg, no lruvec. Update only the node */
> > -     if (!memcg) {
> > -             __mod_node_page_state(pgdat, idx, val);
> > -             return;
> > +     if (PageMemcgKmem(head)) {
> > +             rcu_read_lock();
> > +             memcg = obj_cgroup_memcg(page_objcg(page));
> > +     } else {
> > +             memcg = page_memcg(head);
> > +             /*
> > +              * Untracked pages have no memcg, no lruvec. Update only the
> > +              * node.
> > +              */
> > +             if (!memcg) {
> > +                     __mod_node_page_state(pgdat, idx, val);
> > +                     return;
> > +             }
> >       }
> >
> >       lruvec = mem_cgroup_lruvec(memcg, pgdat);
> >       __mod_lruvec_state(lruvec, idx, val);
> > +
> > +     if (PageMemcgKmem(head))
> > +             rcu_read_unlock();
> >  }
> >  EXPORT_SYMBOL(__mod_lruvec_page_state);
> >
> > @@ -2906,6 +2917,20 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
> >       page->memcg_data = (unsigned long)memcg;
> >  }
> >
> > +static inline struct mem_cgroup *obj_cgroup_memcg_get(struct obj_cgroup *objcg)
>
> I'd prefer get_obj_cgroup_memcg(), if you don't mind.

LGTM, will do.

>
> > +{
> > +     struct mem_cgroup *memcg;
> > +
> > +     rcu_read_lock();
> > +retry:
> > +     memcg = obj_cgroup_memcg(objcg);
> > +     if (unlikely(!css_tryget(&memcg->css)))
> > +             goto retry;
> > +     rcu_read_unlock();
> > +
> > +     return memcg;
> > +}
> > +
> >  #ifdef CONFIG_MEMCG_KMEM
> >  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> >                                gfp_t gfp, bool new_page)
> > @@ -3071,15 +3096,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
> >       struct mem_cgroup *memcg;
> >       int ret;
> >
> > -     rcu_read_lock();
> > -retry:
> > -     memcg = obj_cgroup_memcg(objcg);
> > -     if (unlikely(!css_tryget(&memcg->css)))
> > -             goto retry;
> > -     rcu_read_unlock();
> > -
> > +     memcg = obj_cgroup_memcg_get(objcg);
> >       ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> > -
> >       css_put(&memcg->css);
> >
> >       return ret;
> > @@ -3144,18 +3162,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
> >   */
> >  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> >  {
> > -     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *objcg;
> >       int ret = 0;
> >
> > -     memcg = get_mem_cgroup_from_current();
> > -     if (memcg && !mem_cgroup_is_root(memcg)) {
> > -             ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
> > +     objcg = get_obj_cgroup_from_current();
> > +     if (objcg) {
> > +             ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
> >               if (!ret) {
> > -                     page->memcg_data = (unsigned long)memcg |
> > +                     page->memcg_data = (unsigned long)objcg |
> >                               MEMCG_DATA_KMEM;
> >                       return 0;
> >               }
> > -             css_put(&memcg->css);
> > +             obj_cgroup_put(objcg);
> >       }
> >       return ret;
> >  }
> > @@ -3167,17 +3185,16 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> >   */
> >  void __memcg_kmem_uncharge_page(struct page *page, int order)
> >  {
> > -     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *objcg;
> >       unsigned int nr_pages = 1 << order;
> >
> >       if (!page_memcg_charged(page))
> >               return;
> >
> > -     memcg = page_memcg_check(page);
> > -     VM_BUG_ON_PAGE(mem_cgroup_is_root(memcg), page);
> > -     __memcg_kmem_uncharge(memcg, nr_pages);
> > +     objcg = page_objcg(page);
> > +     obj_cgroup_uncharge_pages(objcg, nr_pages);
> >       page->memcg_data = 0;
> > -     css_put(&memcg->css);
> > +     obj_cgroup_put(objcg);
> >  }
> >
> >  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> > @@ -6806,11 +6823,23 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
> >  static void uncharge_batch(const struct uncharge_gather *ug)
> >  {
> >       unsigned long flags;
> > +     unsigned long nr_pages;
> >
> > -     if (!mem_cgroup_is_root(ug->memcg)) {
> > -             page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
> > +     /*
> > +      * The kmem pages can be reparented to the root memcg, in
> > +      * order to prevent the memory counter of root memcg from
> > +      * increasing indefinitely. We should decrease the memory
> > +      * counter when unchange.
>
> I guess the correct syntax is
> "The kmem pages can be reparented to the root memcg. In
> order to prevent the memory counter of root memcg from
> increasing indefinitely, we should decrease the memory
> counter when unchange."

Right. I will combine your and Johannes suggestions about
how to rework the code here.

>
> > +      */
> > +     if (mem_cgroup_is_root(ug->memcg))
> > +             nr_pages = ug->nr_kmem;
> > +     else
> > +             nr_pages = ug->nr_pages;
> > +
> > +     if (nr_pages) {
> > +             page_counter_uncharge(&ug->memcg->memory, nr_pages);
> >               if (do_memsw_account())
> > -                     page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
> > +                     page_counter_uncharge(&ug->memcg->memsw, nr_pages);
> >               if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
> >                       page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
> >               memcg_oom_recover(ug->memcg);
> > @@ -6828,7 +6857,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
> >
> >  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  {
> > -     unsigned long nr_pages;
> > +     unsigned long nr_pages, nr_kmem;
> >       struct mem_cgroup *memcg;
> >
> >       VM_BUG_ON_PAGE(PageLRU(page), page);
> > @@ -6836,34 +6865,44 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >       if (!page_memcg_charged(page))
> >               return;
> >
> > +     nr_pages = compound_nr(page);
> >       /*
> >        * Nobody should be changing or seriously looking at
> > -      * page memcg at this point, we have fully exclusive
> > -      * access to the page.
> > +      * page memcg or objcg at this point, we have fully
> > +      * exclusive access to the page.
> >        */
> > -     memcg = page_memcg_check(page);
> > +     if (PageMemcgKmem(page)) {
> > +             struct obj_cgroup *objcg;
> > +
> > +             objcg = page_objcg(page);
> > +             memcg = obj_cgroup_memcg_get(objcg);
> > +
> > +             page->memcg_data = 0;
> > +             obj_cgroup_put(objcg);
> > +             nr_kmem = nr_pages;
> > +     } else {
> > +             memcg = page_memcg(page);
> > +             page->memcg_data = 0;
> > +             nr_kmem = 0;
> > +     }
> > +
> >       if (ug->memcg != memcg) {
> >               if (ug->memcg) {
> >                       uncharge_batch(ug);
> >                       uncharge_gather_clear(ug);
> >               }
> >               ug->memcg = memcg;
> > +             ug->dummy_page = page;
> >
> >               /* pairs with css_put in uncharge_batch */
> >               css_get(&ug->memcg->css);
> >       }
> >
> > -     nr_pages = compound_nr(page);
> >       ug->nr_pages += nr_pages;
> > +     ug->nr_kmem += nr_kmem;
> > +     ug->pgpgout += !nr_kmem;
> >
> > -     if (PageMemcgKmem(page))
> > -             ug->nr_kmem += nr_pages;
> > -     else
> > -             ug->pgpgout++;
> > -
> > -     ug->dummy_page = page;
> > -     page->memcg_data = 0;
> > -     css_put(&ug->memcg->css);
> > +     css_put(&memcg->css);
> >  }
> >
> >  /**
> > --
> > 2.11.0
> >
