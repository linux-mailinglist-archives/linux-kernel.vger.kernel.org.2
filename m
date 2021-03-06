Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C00332F8DE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhCFIEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhCFIE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:04:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978FCC06175F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 00:04:26 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z5so2575149plg.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwJdP/jXLB2WvbOlm69YJYh1MXCSG+adzlb+6kWG5zc=;
        b=V8E1w1MCf/cEnmQOLZzuOoNI4Ud5ct1slOA2SUtNfCQvXRLQj8PLHIMrEKdqhmrtN7
         KU/y1Te+gdiJNww0J8x1DXl9kutc4J+o8A+Rzy+0LM9E3KpeLeg5uNjXGB4rA2D5JPTX
         VC8AFO3A/oowkc5cCsukFaXA1ZZdUCBdWXoxjPxwio9ohNC3TJwy7ed3m+CFo280Yy2w
         QFcZsk6H1g1TYIxwfHfUUFELvYc4NcA4MvbdltYAnZClR8XbSz/9rDOMiLkK1kmBrqei
         zoIaY1Xr57/tonBSoIcqFobgSFv0pmZkcwnR2FlnMtmXn1+2KaVyIiBDcTJUAyhp1FCi
         HSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwJdP/jXLB2WvbOlm69YJYh1MXCSG+adzlb+6kWG5zc=;
        b=EbUL68iHQWCSG2klcgOFdmz4hhAMlfVLKl82XZ4f30L21aYXASCDpr+XSZjgjnZHpk
         Als47mqv+5NUu9AjY5IDW1N/kPWBHIXmmnOPUx2uMZlBv7/DMcNQvOengYk+XcBOfGBe
         YZilEu6LzReb1RdLFdLejZwKZXPkg27UQZDavgFhbAWqFS4XtHxA57hapSjZLh7sVWBZ
         ENp8RL9BSvYzdPZFNvsodtUQrL0FPzyjDMLg8ssKBsdOoL9dUeM/OH6y270wLcbqbeLT
         vYV/WFzLUybYkd1WU7v09et4knFJPdwv39sytzi1t1bgL2/1LHCTJY0s/xXn+4IlUH4c
         3ViA==
X-Gm-Message-State: AOAM533e3fbhTsMhm0PIBuSP/VjujH72W7oYFfMXlp4C/qSlWyYOigrG
        bdQeaWfcVYVBnA/iVT+0FHAuGfAdSrPEcPu3JeIaRg==
X-Google-Smtp-Source: ABdhPJxv46I/DF0/xZuhoVEZ8qSRS1lYNTIxNw/Wzmi3xo3GkaJc8FAibVL7PrdtAD+kDfV4xEJELDkFE6EAxPNl41g=
X-Received: by 2002:a17:90a:778a:: with SMTP id v10mr14072538pjk.229.1615017865870;
 Sat, 06 Mar 2021 00:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20210303055917.66054-1-songmuchun@bytedance.com>
 <20210303055917.66054-4-songmuchun@bytedance.com> <YEKJRpv8ppFEEQ4B@carbon.dhcp.thefacebook.com>
In-Reply-To: <YEKJRpv8ppFEEQ4B@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 6 Mar 2021 16:03:49 +0800
Message-ID: <CAMZfGtVe=Km8a21cePnK1suHhsGuGhg3Gb2_k8VmUN1W=nTDWQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/5] mm: memcontrol: charge kmem pages
 by using obj_cgroup APIs
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

On Sat, Mar 6, 2021 at 3:41 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Mar 03, 2021 at 01:59:15PM +0800, Muchun Song wrote:
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
>
> I believe it's a good direction, but there are still things which
> need to be figured out first.
>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h |  63 +++++++++++++++++------
> >  mm/memcontrol.c            | 123 +++++++++++++++++++++++++++++++--------------
> >  2 files changed, 133 insertions(+), 53 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 049b80246cbf..5911b9d107b0 100644
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
> > @@ -421,9 +433,10 @@ static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> >   * @page: a pointer to the page struct
> >   *
> >   * Returns a pointer to the memory cgroup associated with the page,
> > - * or NULL. This function unlike page_memcg() can take any  page
> > + * or NULL. This function unlike page_memcg() can take any non-kmem page
> >   * as an argument. It has to be used in cases when it's not known if a page
> > - * has an associated memory cgroup pointer or an object cgroups vector.
> > + * has an associated memory cgroup pointer or an object cgroups vector or
> > + * an object cgroup.
> >   *
> >   * Any of the following ensures page and memcg binding stability:
> >   * - the page lock
> > @@ -442,6 +455,17 @@ static inline struct mem_cgroup *page_memcg_check(struct page *page)
> >       if (memcg_data & MEMCG_DATA_OBJCGS)
> >               return NULL;
> >
> > +     if (memcg_data & MEMCG_DATA_KMEM) {
>
> This is confusing: the comment above says it can't take kmem pages?

It is my fault. I will fix the comment.

>
> > +             struct obj_cgroup *objcg;
> > +
> > +             /*
> > +              * The caller must ensure that the returned memcg won't be
> > +              * released: e.g. acquire the rcu_read_lock or css_set_lock.
> > +              */
> > +             objcg = (void *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> > +             return obj_cgroup_memcg(objcg);
> > +     }
> > +
> >       return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
>
> Also, the comment about page<->memcg binding stability is not correct anymore.
> Taking page_lock, for example, won't protect memcg from being released,
> if this a kmem page.

I also have a question: Will the page lock of the kmem page be taken
somewhere?

>
> _Maybe_ it's ok to just say that page_memcg_check() requires a rcu lock,
> but I'm not yet quite sure. The calling convention is already complicated,
> we should avoid making it even more complicated, if we can.

In most scenarios, we can distinguish what page it is. So we can see
that there are only 2 users of it. I think that it may be acceptable to just
complicate page_memcg_check(). Document it requires a rcu lock.

>
> >  }
> >
> > @@ -500,6 +524,24 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
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
> > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> > +     VM_BUG_ON_PAGE(!(memcg_data & MEMCG_DATA_KMEM), page);
> > +
> > +     return (struct obj_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> > +}
> >  #else
> >  static inline struct obj_cgroup **page_objcgs(struct page *page)
> >  {
> > @@ -510,6 +552,11 @@ static inline struct obj_cgroup **page_objcgs_check(struct page *page)
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
> > @@ -728,18 +775,6 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
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
> > index 86a8db937ec6..0cf342d22547 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -856,10 +856,16 @@ void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
> >  {
> >       struct page *head = compound_head(page); /* rmap on tail pages */
> >       struct mem_cgroup *memcg;
> > -     pg_data_t *pgdat = page_pgdat(page);
> > +     pg_data_t *pgdat;
> >       struct lruvec *lruvec;
> >
> > -     memcg = page_memcg_check(head);
> > +     if (PageMemcgKmem(head)) {
> > +             __mod_lruvec_kmem_state(page_to_virt(head), idx, val);
> > +             return;
> > +     }
>
> This is a very confusing part: we're converting the page to the virtual address
> to run mem_cgroup_from_obj() inside __mod_lruvec_kmem_state() to get back the page.

OK. I will rework the code here.


>
> > +
> > +     pgdat = page_pgdat(head);
> > +     memcg = page_memcg(head);
> >       /* Untracked pages have no memcg, no lruvec. Update only the node */
> >       if (!memcg) {
> >               __mod_node_page_state(pgdat, idx, val);
> > @@ -3144,18 +3150,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
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
> > +             ret = obj_cgroup_charge_page(objcg, gfp, 1 << order);
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
> > @@ -3167,17 +3173,18 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
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
> > +     VM_BUG_ON_PAGE(!PageMemcgKmem(page), page);
> > +
> > +     objcg = page_objcg(page);
> > +     obj_cgroup_uncharge_page(objcg, nr_pages);
> >       page->memcg_data = 0;
> > -     css_put(&memcg->css);
> > +     obj_cgroup_put(objcg);
> >  }
> >
> >  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> > @@ -6794,8 +6801,12 @@ struct uncharge_gather {
> >       struct mem_cgroup *memcg;
> >       unsigned long nr_pages;
> >       unsigned long pgpgout;
> > -     unsigned long nr_kmem;
> >       struct page *dummy_page;
> > +
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     struct obj_cgroup *objcg;
> > +     unsigned long nr_kmem;
> > +#endif
> >  };
> >
> >  static inline void uncharge_gather_clear(struct uncharge_gather *ug)
> > @@ -6807,12 +6818,21 @@ static void uncharge_batch(const struct uncharge_gather *ug)
> >  {
> >       unsigned long flags;
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +     if (ug->objcg) { > +#endif
>
> Hm, an obvious question here is why do we need to double the ug infrastructure
> if we can just get kmem page's memcg and use the infra for user pages?
> Because ug is holding a reference to memcg, it will not go away.
> Maybe I'm missing something, but it seems that there is a simpler implementation.

Yeah. There is a simpler implementation. I will do a try. Thanks for your
suggestions.

>
> Thanks!
>
> > +
> > +     if (!ug->memcg)
> > +             return;
> > +
> >       if (!mem_cgroup_is_root(ug->memcg)) {
> >               page_counter_uncharge(&ug->memcg->memory, ug->nr_pages);
> >               if (do_memsw_account())
> >                       page_counter_uncharge(&ug->memcg->memsw, ug->nr_pages);
> > -             if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && ug->nr_kmem)
> > -                     page_counter_uncharge(&ug->memcg->kmem, ug->nr_kmem);
> >               memcg_oom_recover(ug->memcg);
> >       }
> >
> > @@ -6822,26 +6842,40 @@ static void uncharge_batch(const struct uncharge_gather *ug)
> >       memcg_check_events(ug->memcg, ug->dummy_page);
> >       local_irq_restore(flags);
> >
> > -     /* drop reference from uncharge_page */
> > +     /* drop reference from uncharge_user_page */
> >       css_put(&ug->memcg->css);
> >  }
> >
> > -static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> > +#ifdef CONFIG_MEMCG_KMEM
> > +static void uncharge_kmem_page(struct page *page, struct uncharge_gather *ug)
> >  {
> > -     unsigned long nr_pages;
> > -     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *objcg = page_objcg(page);
> >
> > -     VM_BUG_ON_PAGE(PageLRU(page), page);
> > +     if (ug->objcg != objcg) {
> > +             if (ug->objcg) {
> > +                     uncharge_batch(ug);
> > +                     uncharge_gather_clear(ug);
> > +             }
> > +             ug->objcg = objcg;
> >
> > -     if (!page_memcg_charged(page))
> > -             return;
> > +             /* pairs with obj_cgroup_put in uncharge_batch */
> > +             obj_cgroup_get(ug->objcg);
> > +     }
> > +
> > +     ug->nr_kmem += compound_nr(page);
> > +     page->memcg_data = 0;
> > +     obj_cgroup_put(ug->objcg);
> > +}
> > +#else
> > +static void uncharge_kmem_page(struct page *page, struct uncharge_gather *ug)
> > +{
> > +}
> > +#endif
> > +
> > +static void uncharge_user_page(struct page *page, struct uncharge_gather *ug)
> > +{
> > +     struct mem_cgroup *memcg = page_memcg(page);
> >
> > -     /*
> > -      * Nobody should be changing or seriously looking at
> > -      * page memcg at this point, we have fully exclusive
> > -      * access to the page.
> > -      */
> > -     memcg = page_memcg_check(page);
> >       if (ug->memcg != memcg) {
> >               if (ug->memcg) {
> >                       uncharge_batch(ug);
> > @@ -6852,18 +6886,30 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >               /* pairs with css_put in uncharge_batch */
> >               css_get(&ug->memcg->css);
> >       }
> > +     ug->pgpgout++;
> > +     ug->dummy_page = page;
> > +
> > +     ug->nr_pages += compound_nr(page);
> > +     page->memcg_data = 0;
> > +     css_put(&ug->memcg->css);
> > +}
> >
> > -     nr_pages = compound_nr(page);
> > -     ug->nr_pages += nr_pages;
> > +static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> > +{
> > +     VM_BUG_ON_PAGE(PageLRU(page), page);
> >
> > +     if (!page_memcg_charged(page))
> > +             return;
> > +
> > +     /*
> > +      * Nobody should be changing or seriously looking at
> > +      * page memcg at this point, we have fully exclusive
> > +      * access to the page.
> > +      */
> >       if (PageMemcgKmem(page))
> > -             ug->nr_kmem += nr_pages;
> > +             uncharge_kmem_page(page, ug);
> >       else
> > -             ug->pgpgout++;
> > -
> > -     ug->dummy_page = page;
> > -     page->memcg_data = 0;
> > -     css_put(&ug->memcg->css);
> > +             uncharge_user_page(page, ug);
> >  }
> >
> >  /**
> > @@ -6906,8 +6952,7 @@ void mem_cgroup_uncharge_list(struct list_head *page_list)
> >       uncharge_gather_clear(&ug);
> >       list_for_each_entry(page, page_list, lru)
> >               uncharge_page(page, &ug);
> > -     if (ug.memcg)
> > -             uncharge_batch(&ug);
> > +     uncharge_batch(&ug);
> >  }
> >
> >  /**
> > --
> > 2.11.0
> >
