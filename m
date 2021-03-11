Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2881E336C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhCKGqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCKGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:46:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0855FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:46:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so1235856pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 22:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8OEv9CtHZX9CeuXdj3tOxkz/Rkq6bikinKfOj6Yzbg=;
        b=GMBcumA3hm7KzfSXr0WMjf1AwlpzDktqGHIuBiH7ZbOp3PY3zQCuO4s/CtNSfiZxSf
         KelgnFIQE4yBiCDWdfjZ28lykCMTp8n4eUW+fZLUNCxL0e715hQQFD4ZHF0NLNk5ym4k
         C7aDDDoMTDjR0It9uU+AzGHLD4lCMR2oAJ58q08Ozc8BN8dBlFnsb1fW8gIuu+hNYv/h
         LApyQ/MzRZ0uG0lIquijiwUbmxz4D9NN4FcFFZ1Dx6GXNMohwQphL1aRJRbCgqhM4zcd
         C/Siq9r+VhwDtqouxyy7UWKvRC6Ful6KAK33Bwl0ogYkgy0VCHsZZqlj32LULCUb1msX
         a3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8OEv9CtHZX9CeuXdj3tOxkz/Rkq6bikinKfOj6Yzbg=;
        b=SuE3TcabgZaQTgRO3qWI2474wPgW7AGC1dxiiDvv2h6BB5ORLQFvyNsv02S4NxbcBZ
         n5v0G0RDG/8+YGHEMX3+Q6F+FVxhF/ndNTKe/OXEgzy7rqWbOh++iE6T9gFPeCw1nk2y
         AyvhZKQ+2173MBxzpYxI2GHZD4y/WhMjvsR5dj5Tp7c2Dp+uiwteS/93RIhxlc3I6JDk
         ZdI2JTd+HIFREZSDdB70QR8QOlC3ZuCkMlW4gfwvGzG5EXpTkaE6Wl2X7b6F8/y6Ao9y
         anlpFC7jF/wglTZuZ3Bl4IoISmtjX3WhaYL4RuPB2ZD+CoT29gnGfsrWrWCIdfGdLKIn
         V9Xw==
X-Gm-Message-State: AOAM532jeSv1z0JIp5QKXsAKwg454AI7II83dBXEAvfz9836BbtS8ecs
        WJa/dOEfWF+ukUC1Yb4sJi5ag9VBF4cEC8pa2hoGXw==
X-Google-Smtp-Source: ABdhPJzxxJGYESOBDgdBnMLsc0UL33Tf1MMWj2LcWjAIHR0AxV+qKF7QTCoqb3Aw6EZ4S3JKmApeEu7kAPn6RRG0ZRI=
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr7619544pjb.13.1615445191447;
 Wed, 10 Mar 2021 22:46:31 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com> <YEkkvuIZ/0+LD/9s@carbon.dhcp.thefacebook.com>
In-Reply-To: <YEkkvuIZ/0+LD/9s@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 11 Mar 2021 14:45:54 +0800
Message-ID: <CAMZfGtXbTOeRub-vQTA4CTYODEuZYoEBiQtaekeOLL=6j=eqbA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
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

On Thu, Mar 11, 2021 at 3:58 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Mar 09, 2021 at 06:07:15PM +0800, Muchun Song wrote:
> > We want to reuse the obj_cgroup APIs to charge the kmem pages.
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
> > ---
> >  include/linux/memcontrol.h | 33 +++++++++++++++++++++++++++------
> >  mm/memcontrol.c            | 23 +++++++++++++----------
> >  mm/page_alloc.c            |  4 ++--
> >  3 files changed, 42 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index e6dc793d587d..83cbcdcfcc92 100644
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
> > @@ -378,27 +390,31 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
> >       unsigned long memcg_data = page->memcg_data;
> >
> >       VM_BUG_ON_PAGE(PageSlab(page), page);
> > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
> >       VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_OBJCGS, page);
> >
> >       return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
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
> > +     VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
> >       WARN_ON_ONCE(!rcu_read_lock_held());
> >
> > -     return (struct mem_cgroup *)(READ_ONCE(page->memcg_data) &
> > -                                  ~MEMCG_DATA_FLAGS_MASK);
> > +     return (struct mem_cgroup *)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
> >  }
> >
> >  /*
> > @@ -1072,6 +1088,11 @@ void mem_cgroup_split_huge_fixup(struct page *head);
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
> > index fc22da9805fb..e1dc73ceb98a 100644
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
>
> In general, this and the next patch look good to me (aside from some small things,
> commented separately).
>
> But I wonder if it's better to have two separate versions of __mod_lruvec_page_state()
> for kmem and non-kmem pages, rather then rely on PageMemcgKmem flag. It's a hot path,
> so if we can have fewer conditions here, that would be nice.
> I take a brief look (and could be wrong), but it seems like we know in advance
> which version should be used.

Right. The user should know whether the page is kmem.
IIUC,  __mod_lruvec_kmem_state is the version of the
kmem. It is enough to reuse it. And make __mod_lruvec_page_state()
only suitable for non-kmem page.

>
> Thanks!
>
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
