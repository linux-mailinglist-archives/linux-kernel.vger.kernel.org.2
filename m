Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188D33413FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhCSEFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhCSEFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:05:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627E9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:05:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v8so2345305plz.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYi9Qg9yr4V8R5aYx8PJVkXRXyqwMY0VG8jHb+8am/I=;
        b=xRWZDFzfprinXahtnSweIMsXMeIi6/Rwl+7F8Df6UxSCzQmiveuXazIwP4hYV30il3
         2PFzOYJ+vihsEKDb49QpLFsYpFxjZ7KMO0v+L8TudkB2PpHYQKtcWTg2nIn7yUuVo39p
         52eQKVk+XqSvrkrLneasQJ7agJ7z9FqYWUoCVAcXSx3GSB0P9karVADk0b8tPj8G37vT
         d7Qj/L4n3K4AFqA+Kc0Vl47zjmCjsMO17BQACW7Utzy2734uB89aiAAPvIvbTwxLCjKn
         /uLNmUpgQ9r5bPM+pJMN9N1uJJu7hitprKmghRhob6ivarQr4NolTVTyc8VTGiIaEBrE
         LHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYi9Qg9yr4V8R5aYx8PJVkXRXyqwMY0VG8jHb+8am/I=;
        b=qdmclkvkK+XeQCPetNpwRXQLKkywmdeGmzsEd0cUdcp7rAbsqJQGIII639dxeydNUp
         dU+VYhSAco8MgSNtG5j3eeBheBrDxu/lr+JB8p73Wja+7MuyjHw53d6D4b9Mepr1d0Gl
         ++NoMAsRWBWbjwhb2dGygwr27B3PFKupsyZjuAbR/x8mzATWPJBbBTSLpNEEFC6MeZw1
         MrHWiVn8pIw7sKkCulFyWxX3jns8YgLeWYikSgZMn3RmnzeZ1b0ahTlbE7+BPb7KE1lC
         wwmDgVOYVS5ZdHAxtRVW7QhHPLsmLY1UMOhXWCSoB2j3ZqcRUhbtXCcu30ek1Zg5Khri
         /F7w==
X-Gm-Message-State: AOAM5306zVJhdI9sR0I1lSIvg1GTJyMX7rT9KrZhgIxJzib4W3l//Ykd
        YfLhiwwurND94ecdySe+mZxljAAkBjamT736ju1wtQ==
X-Google-Smtp-Source: ABdhPJyF29np5PINIDguA1JJfOiJFzSKm34ukhDoT/pLTxUKbP64uzY1Bqz22n/BveR8LbQm2u48PWGUqAVs8wrG+Ek=
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr7883812pjb.13.1616126746950;
 Thu, 18 Mar 2021 21:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210318110658.60892-1-songmuchun@bytedance.com>
 <20210318110658.60892-5-songmuchun@bytedance.com> <CALvZod5RSXiUHBkW4aaWOnak6LQ6QdSiGWMh9Wk_Q++dz6Y4_Q@mail.gmail.com>
In-Reply-To: <CALvZod5RSXiUHBkW4aaWOnak6LQ6QdSiGWMh9Wk_Q++dz6Y4_Q@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 19 Mar 2021 12:05:10 +0800
Message-ID: <CAMZfGtXSW8gX99SzYf7ourM5ZpsWYjWtiBL0MYpJXZeKB4HWXg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/5] mm: memcontrol: use obj_cgroup APIs
 to charge kmem pages
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 11:40 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 4:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> [...]
> >
> > +static inline struct mem_cgroup *get_obj_cgroup_memcg(struct obj_cgroup *objcg)
>
> I would prefer get_mem_cgroup_from_objcg().

Inspired by obj_cgroup_memcg() which returns the memcg from objcg.
So I introduce get_obj_cgroup_memcg() which obtains a reference of
memcg on the basis of obj_cgroup_memcg().

So that the names are more consistent. Just my thought.

So should I rename it to get_mem_cgroup_from_objcg?

>
> > +{
> > +       struct mem_cgroup *memcg;
> > +
> > +       rcu_read_lock();
> > +retry:
> > +       memcg = obj_cgroup_memcg(objcg);
> > +       if (unlikely(!css_tryget(&memcg->css)))
> > +               goto retry;
> > +       rcu_read_unlock();
> > +
> > +       return memcg;
> > +}
> > +
> >  #ifdef CONFIG_MEMCG_KMEM
> >  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> >                                  gfp_t gfp, bool new_page)
> > @@ -3070,15 +3088,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
> >         struct mem_cgroup *memcg;
> >         int ret;
> >
> > -       rcu_read_lock();
> > -retry:
> > -       memcg = obj_cgroup_memcg(objcg);
> > -       if (unlikely(!css_tryget(&memcg->css)))
> > -               goto retry;
> > -       rcu_read_unlock();
> > -
> > +       memcg = get_obj_cgroup_memcg(objcg);
> >         ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
>
> Why not manually inline __memcg_kmem_charge() here? This is the only user.
>
> Similarly manually inline __memcg_kmem_uncharge() into
> obj_cgroup_uncharge_pages() and call obj_cgroup_uncharge_pages() in
> obj_cgroup_release().

Good point. I will do this.

>
> > -
> >         css_put(&memcg->css);
> >
> >         return ret;
> > @@ -3143,18 +3154,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
> >   */
> >  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> >  {
> > -       struct mem_cgroup *memcg;
> > +       struct obj_cgroup *objcg;
> >         int ret = 0;
> >
> > -       memcg = get_mem_cgroup_from_current();
>
> This was the only use of get_mem_cgroup_from_current(). Why not remove it?

I saw a potential user.

    [PATCH v10 0/3] Charge loop device i/o to issuing cgroup

To avoid reintroducing them. So I did not remove it.

>
> > -       if (memcg && !mem_cgroup_is_root(memcg)) {
> > -               ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
> > +       objcg = get_obj_cgroup_from_current();
> > +       if (objcg) {
> > +               ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
> >                 if (!ret) {
> > -                       page->memcg_data = (unsigned long)memcg |
> > +                       page->memcg_data = (unsigned long)objcg |
> >                                 MEMCG_DATA_KMEM;
> >                         return 0;
> >                 }
> > -               css_put(&memcg->css);
> > +               obj_cgroup_put(objcg);
> >         }
> >         return ret;
> >  }
> [...]
> >  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  {
> >         unsigned long nr_pages;
> > +       struct mem_cgroup *memcg;
> > +       struct obj_cgroup *objcg;
> >
> >         VM_BUG_ON_PAGE(PageLRU(page), page);
> >
> > -       if (!page_memcg(page))
> > -               return;
> > -
> >         /*
> >          * Nobody should be changing or seriously looking at
> > -        * page_memcg(page) at this point, we have fully
> > +        * page memcg or objcg at this point, we have fully
> >          * exclusive access to the page.
> >          */
> > +       if (PageMemcgKmem(page)) {
> > +               objcg = __page_objcg(page);
> > +               memcg = get_obj_cgroup_memcg(objcg);
>
> Can you add a comment that this get matches the put at the end of the
> function and kmem pages do not hold memcg references anymore.

Make sense. Will do.

Thanks for your suggestions.

>
> > +       } else {
> > +               memcg = __page_memcg(page);
> > +       }
> > +
> > +       if (!memcg)
> > +               return;
> >
> > -       if (ug->memcg != page_memcg(page)) {
> > +       if (ug->memcg != memcg) {
> >                 if (ug->memcg) {
> >                         uncharge_batch(ug);
> >                         uncharge_gather_clear(ug);
> >                 }
> > -               ug->memcg = page_memcg(page);
> > +               ug->memcg = memcg;
> >                 ug->dummy_page = page;
> >
> >                 /* pairs with css_put in uncharge_batch */
> > -               css_get(&ug->memcg->css);
> > +               css_get(&memcg->css);
> >         }
> >
> >         nr_pages = compound_nr(page);
> > -       ug->nr_pages += nr_pages;
> >
> > -       if (PageMemcgKmem(page))
> > +       if (PageMemcgKmem(page)) {
> > +               ug->nr_memory += nr_pages;
> >                 ug->nr_kmem += nr_pages;
> > -       else
> > +
> > +               page->memcg_data = 0;
> > +               obj_cgroup_put(objcg);
> > +       } else {
> > +               /* LRU pages aren't accounted at the root level */
> > +               if (!mem_cgroup_is_root(memcg))
> > +                       ug->nr_memory += nr_pages;
> >                 ug->pgpgout++;
> >
> > -       page->memcg_data = 0;
> > -       css_put(&ug->memcg->css);
> > +               page->memcg_data = 0;
> > +       }
> > +
> > +       css_put(&memcg->css);
> >  }
> >
> >  /**
> > --
> > 2.11.0
> >
