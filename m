Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0CC33888A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhCLJYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbhCLJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:23:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46A9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:23:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so10474436pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 01:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26qB14f5N7ohF75H9aqLLsvkoHToTEccxcW0Z7uEKNg=;
        b=Aq9/6K3/OGRFRR7T2Vg9gTchrRkRQKbxs7ILwsSYD5WejwbSLDgRg8cVGez4VEPmdC
         m8nvU79XBqNllKmGqYyGzkz1/jqs0txwvK/UUMtkt8ENjkT9+3eh40bDDXb6jqG4gSoZ
         x1EHLFHZJ3duIbWIsj4mHHcbLx4jo6oX/f/DJAhX3PBwnWnuh0/yV2c4aUtuSCzxowKW
         kN57G2QkrNGNIJd/gAkWXIw7CWiyTmoyDnLnOVf93G7SbBbQGBttzfT3guxupI9mlGd7
         nk/L9cFS1GJT5ZHABevqF970v8uS4XeCoQlDVe30OPjm5d/fNzkJBh8bGi7JEd0X63Ks
         Afqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26qB14f5N7ohF75H9aqLLsvkoHToTEccxcW0Z7uEKNg=;
        b=fHWoVnNvdo+q6AciDY2Fh4YYlLlerJpUXUe+Z7hajCLj7zjPu1XsI86Wve/ceGOiU2
         /xAe+Pbt9KahQUuKh1MrDhmpQxc3uVATnLdI9BLhPow24kDwq7arTkRlUJ4RHvgiJR6P
         JeZObiRaejKyIK7WPYEJ3y+tlCa3uhcVkb8assuZqAy3MiExtSQEGKubnE+2h64/Ymtw
         hZXkbNUWwuclwGUMsaIxPz0xysJNLvzfxKal7t535bnzJFfx40DaE0b+M9LsxnYjtACb
         wymNtQ3Qk+NzbkD2piaUtiGidg2O1TUVM9UqQXpB65InkuZOUzclQ+/W5CVpIszYmFyF
         xTZw==
X-Gm-Message-State: AOAM530zl/yEioYMa9Lcp6TSWUaJJisxWErLqmYKR67o3mATOj4tzken
        uiJ1GYqrBsYZ6+13WUnTD60y9kC75GXfjOMtR9GwzA==
X-Google-Smtp-Source: ABdhPJx0DK9TvoXxbSqFH38Wn+o6fmv5Y9ZFBPATQS67rK5YLTb42JGEE+TPk0FyHD+43S3ZlQQYVTAPLo81O2rjDW8=
X-Received: by 2002:a17:90a:f008:: with SMTP id bt8mr13547708pjb.13.1615541013335;
 Fri, 12 Mar 2021 01:23:33 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-4-songmuchun@bytedance.com> <YElCxDzVgBBLAQhJ@cmpxchg.org>
In-Reply-To: <YElCxDzVgBBLAQhJ@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 12 Mar 2021 17:22:55 +0800
Message-ID: <CAMZfGtUqTBJ56eEj5CiFbHGMMaopP9k1Tq94R+M=W6P0HF83_A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 3/4] mm: memcontrol: use obj_cgroup APIs
 to charge kmem pages
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

On Thu, Mar 11, 2021 at 6:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Munchun,
>
> On Tue, Mar 09, 2021 at 06:07:16PM +0800, Muchun Song wrote:
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
> > +      */
> > +     if (mem_cgroup_is_root(ug->memcg))
> > +             nr_pages = ug->nr_kmem;
> > +     else
> > +             nr_pages = ug->nr_pages;
>
> Correct or not, I find this unreadable. We're uncharging nr_kmem on
> the root, and nr_pages against leaf groups?
>
> It implies several things that might not be immediately obvious to the
> reader of this function. Namely, that nr_kmem is a subset of nr_pages.
> Or that we don't *want* to account LRU pages for the root cgroup.
>
> The old code followed a very simple pattern: the root memcg's page
> counters aren't touched.
>
> This is no longer true: we modify them depending on very specific
> circumstances. But that's too clever for the stupid uncharge_batch()
> which is only supposed to flush a number of accumulators into their
> corresponding page counters.
>
> This distinction really needs to be moved down to uncharge_page() now.

OK. I will rework the code here to make it readable.

>
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
>
> Why is all this moved above the uncharge_batch() call?

Before calling obj_cgroup_put(), we need set page->memcg_data
to zero. So I move "page->memcg_data = 0" to here.

>
> It separates the pointer manipulations from the refcounting, which
> makes the code very difficult to follow.
>
> > +
> >       if (ug->memcg != memcg) {
> >               if (ug->memcg) {
> >                       uncharge_batch(ug);
> >                       uncharge_gather_clear(ug);
> >               }
> >               ug->memcg = memcg;
> > +             ug->dummy_page = page;
>
> Why this change?

Just like ug->memcg, we do not need to set
ug->dummy_page in every loop.


>
> >               /* pairs with css_put in uncharge_batch */
> >               css_get(&ug->memcg->css);
> >       }
> >
> > -     nr_pages = compound_nr(page);
> >       ug->nr_pages += nr_pages;
> > +     ug->nr_kmem += nr_kmem;
> > +     ug->pgpgout += !nr_kmem;
>
> Oof.
>
> Yes, this pgpgout line is an equivalent transformation for counting
> LRU compound pages. But unless you already know that, it's completely
> impossible to understand what the intent here is.
>
> Please avoid clever tricks like this. If you need to check whether the
> page is kmem, test PageMemcgKmem() instead of abusing the counters as
> boolean flags. This is supposed to be read by human beings, too.

Got it.

>
> > -     if (PageMemcgKmem(page))
> > -             ug->nr_kmem += nr_pages;
> > -     else
> > -             ug->pgpgout++;
> > -
> > -     ug->dummy_page = page;
> > -     page->memcg_data = 0;
> > -     css_put(&ug->memcg->css);
> > +     css_put(&memcg->css);
>
> Sorry, these two functions are no longer readable after your changes.
>
> Please retain the following sequence as discrete steps:
>
> 1. look up memcg from the page
> 2. flush existing batch if memcg changed
> 3. add page's various counts to the current batch
> 4. clear page->memcg and decrease the referece count to whatever it was pointing to

Got it.

>
> And as per above, step 3. is where we should check whether to uncharge
> the memcg's page counter at all:
>
>         if (PageMemcgKmem(page)) {
>                 ug->nr_pages += nr_pages;
>                 ug->nr_kmem += nr_pages;
>         } else {
>                 /* LRU pages aren't accounted at the root level */
>                 if (!mem_cgroup_is_root(memcg))
>                         ug->nr_pages += nr_pages;
>                 ug->pgpgout++;
>         }
>
> In fact, it might be a good idea to rename ug->nr_pages to
> ug->nr_memory to highlight how it maps to the page_counter.

I will rework the code in the next version. Thanks for your
suggestions.
