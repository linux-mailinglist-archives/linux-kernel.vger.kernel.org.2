Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3103338673
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhCLHPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhCLHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:14:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F1DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:14:47 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q204so1221035pfq.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 23:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGrsAfdegRZOoY4BGSVekkGKX0Vz1TyDoUrIi5LD18Y=;
        b=Fb4EcZpZkPTJRu9au+Rmpv3z7zhNxv7AJlyx4sQlsGb97HqId1onjRzbajRE1t4Cj6
         cJNStTV0jLFrT7w7LdT8a0xvGN+rXExeMpEUDiRV9ss8ySay0mw+Qlyi/MvZ7UtxPHOe
         CYTdqRsAI70Q9nyorcb5Mpm/8YgTUFs/1Stoi8R4co5RVkrBYjatIsir7gyDagdQ3uQ1
         1CRRmxW4nA2PngDRLV1ofh3WSFdXzPZAXtm39GveSiIG76oh8pDT/nlkx63WggUMBQIQ
         r3wS0uXVDZeOEPnNuEgHPooh19JYKcn1rt3RkAnrVlrOWqrz99JL/PVXv3Qk/Jgpx6kA
         19kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGrsAfdegRZOoY4BGSVekkGKX0Vz1TyDoUrIi5LD18Y=;
        b=HJuR/NEJIh2Qpz4QP1kxU5ObpDxQ+ysyucQta79hG2z0tEoqfpgydNWA9bbbv26c6p
         44HAWdtppmuRY+ZsCSXAQH9TJBDMNR8+eEW/DsYrgFK6cPsxtPx9sIm1reWY2fdumf/W
         OVXmPK2WxIriIXZjB6/VskOnwa7idU0PwlrLKSLxRz46kqOnBcpvAvx+W/xtkxfF3EBk
         vG9zpWhAex8IILmBh4nDMagUoeRo9B/EyDvcEshA3SVn48Hp9YqrMPpd7+9GJobpgvs2
         JOM9w8YLs8h5hvyDtI1hjAbJzI4Z0jf5Cyz+7oTBkgJPJaBINjq3b5aTmInS0cYY0pkN
         3xvg==
X-Gm-Message-State: AOAM531gUDYBRa0hGIc84yu5rT71rfxqXr5XXGNHTtX3hK1advD7VMOn
        IbdxUGwx7LhGhIUwJLfXT5mhsePZGIwmfoCMoZkVzA==
X-Google-Smtp-Source: ABdhPJxfGSSUe6OZGY2GSeCs3r/YxxwAzOk6PBa1+EjXnIftP1RfoTlSGHYOS351s0ZyduY+3BaJ++UVEsc3MmY0Bx8=
X-Received: by 2002:a63:141e:: with SMTP id u30mr10785647pgl.31.1615533286462;
 Thu, 11 Mar 2021 23:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com> <YEoXLX37sVgULO4A@cmpxchg.org>
In-Reply-To: <YEoXLX37sVgULO4A@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 12 Mar 2021 15:14:07 +0800
Message-ID: <CAMZfGtXZqe7g6e4wf=tUZqxBs-F1QkS2=01Td4Rv3_qTuF0bPA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
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

On Thu, Mar 11, 2021 at 9:12 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
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
>
> I'm pretty excited about the direction this series is taking us. The
> direct/raw pinning of memcgs from objects and allocations of various
> lifetimes has been causing chronic problems with dying cgroups piling
> up, consuming memory, and gumming up the works in everything that
> needs to iterate the cgroup tree (page reclaim comes to mind).
>
> The more allocation types we can convert to objcg, the better.
>
> This patch in particular looks mostly good to me too. Some comments
> inline:

Hi Johannes,

Very thanks for your suggestions. But I have some questions as below.


>
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
>
> This is mosntly used right before a page_memcg_check(), which makes it
> somewhat redundant except for the VM_BUG_ON_PAGE() for slab pages.

Should I rename page_memcg_charged to page_memcg_raw?
And use page_memcg_raw to check whether the page is charged.

static inline bool page_memcg_charged(struct page *page)
{
        return page->memcg_data;
}

>
> But it's also a bit of a confusing name: slab pages are charged too,
> but this function would crash if you called it on one.
>
> In light of this, and in light of what I wrote above about hopefully
> converting more and more allocations from raw memcg pins to
> reparentable objcg, it would be bettor to have
>
>         page_memcg() for 1:1 page-memcg mappings, i.e. LRU & kmem

Sorry. I do not get the point. Because in the next patch, the kmem
page will use objcg to charge memory. So the page_memcg()
should not be suitable for the kmem pages. So I add a VM_BUG_ON
in the page_memcg() to catch invalid usage.

So I changed some page_memcg() calling to page_memcg_check()
in this patch, but you suggest using page_memcg(). I am very
confused. Are you worried about the extra overhead brought by calling
page_memcg_rcu()? In the next patch, I will remove page_memcg_check()
calling and use objcg APIs.

>         page_objcg() for 1:n page-memcg mappings, i.e. slab pages
>         page_memcg_check() for the very rare ambiguous cases
>         drop page_memcg_rcu() since page_memcg() is now rcu-safe
                                         ^^^
                                      page_memcg_check()

Here you mean page_memcg_check()? Right? I see a READ_ONCE
in page_memcg_check(), but page_memcg() doesn't.


>
> If we wanted to optimize, we could identify places that could do a
> page_memcg_raw() that does page->memcg_data & ~MEMCG_DATA_FLAGS_MASK -
> without READ_ONCE and without the kmem branch. However, I think the
> stat functions are probably the hottest path when it comes to that,
> and they now already include the kmem branch*.
>
> * Roman mentioned splitting up the stats interface to optimize that,
>   but I think we should be careful optimizing prematurely here. It's a
>   bit of a maintainability concern, and it would also get in the way
>   of easily converting more allocation types to objcg.
>
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
> With the proposed variants above, this should be page_memcg() and
> actually warn/crash when we pass a slab page to this function.
>
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
>
> This would remain unchanged:
>
>         memcg = page_memcg(page);
>         if (!memcg)
>                 return;
>
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
>
> Same situation here:
>
>         memcg = page_memcg(page);
>         if (!memcg)
>                 return;
>
> > @@ -6877,7 +6880,7 @@ void mem_cgroup_uncharge(struct page *page)
> >               return;
> >
> >       /* Don't touch page->lru of any random page, pre-check: */
> > -     if (!page_memcg(page))
> > +     if (!page_memcg_charged(page))
> >               return;
>
> Same:
>
>         if (!page_memcg(page))
>                 return;
>
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
>
> Actually, I think we might want to just check the raw
>
>                         page->memcg_data
>
> here, as neither lru, nor kmem, nor slab page should have anything
> left in there by the time the page is freed.
>
> > @@ -1149,7 +1149,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
> >                       bad_reason = "PAGE_FLAGS_CHECK_AT_FREE flag(s) set";
> >       }
> >  #ifdef CONFIG_MEMCG
> > -     if (unlikely(page_memcg(page)))
> > +     if (unlikely(page_memcg_charged(page)))
> >               bad_reason = "page still charged to cgroup";
>
> Same here.
