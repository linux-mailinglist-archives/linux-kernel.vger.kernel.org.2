Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01903393D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbhCLQqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhCLQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:46:48 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D130C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:46:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so10997716pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jLAXn4aYpz32jNMagQDm0wpaA4aWgAFhxqORZ7JmIA=;
        b=Dv9KFMukGJ8sphdRaBO8gtHhv7TABbRb60verndQm+G/beqfhOxT9dy6dfVie6/H6m
         NoKELrKXVDA4mn4vsnVdXaFpsqejK5CMYZgLhyVRpdkH79VNRG2aPRAvcARf0dLEcG0h
         DC70zGJHjt/98Vc5Pe4RI7oDXam+5YTzQS/si9aV0Sw9DQCwJdz9iZsVn9mqMEZ5a+MF
         nfd1g9/OFhh7odWZaPPRLXA9Z3uBfMxOK05ZTj0kb2X0sqjWn/IKRUWTEOWNLYG517T0
         z0/3Dz27LoEVe3LVIkS9FUP9KnqQ8pGK8ZxnmvhmsziMWIgDET/SRvZy6syfPefdv1Ql
         5apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jLAXn4aYpz32jNMagQDm0wpaA4aWgAFhxqORZ7JmIA=;
        b=S9S+FDDLyg6Rzzi3ZzKDZeaSxHf8M++D6H7C8OYhKLeQMKDxKgHAUPe58BlYG61cjr
         BCKvc6yZqEGmLM9YtiPDlx8W6/OfzGsck/oCFLSvq4R0cPDhPBx+zgbXmWX61H4ZwGEv
         RVjSs3bucSZck3AC215cFI9rXCtxhrsc6P0muDMLp8uDbhphR6XK7AMsH3TCmJFBUvlT
         QAV9j5b7jOb39UsytYn1PTQfWrtL0FUfSTIZ7PnjfK+YE0sKtt5TF/S72S7p0TtkJt36
         GHw+F0snfHoxoaqpuNQ5/RZLYW86+VHuY6Bs46+YR3amao8ZJD5HarEZrnbd/d9g7Ot2
         YlRg==
X-Gm-Message-State: AOAM533isQFlN8vN1vdzkhctbhCaZ+mFrsPg3Gl1rSWmjeRxOHslwX79
        q4k6M2Vq1QZj9Abj5hn2kg9xPVql7wkijMSRbBgNAQ==
X-Google-Smtp-Source: ABdhPJxgQsLhKqhiH0ayfAGSlfGohtPwCqhQxOwr9KB/1M1c611iD9s+klmbs/jBtCUTyXnFLAagnt92yyhIObinBd8=
X-Received: by 2002:a17:902:d4cb:b029:e5:f608:6d5e with SMTP id
 o11-20020a170902d4cbb02900e5f6086d5emr14093760plg.20.1615567607771; Fri, 12
 Mar 2021 08:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-4-songmuchun@bytedance.com> <YElCxDzVgBBLAQhJ@cmpxchg.org>
 <CAMZfGtUqTBJ56eEj5CiFbHGMMaopP9k1Tq94R+M=W6P0HF83_A@mail.gmail.com> <YEuPydlPkq87TO5H@cmpxchg.org>
In-Reply-To: <YEuPydlPkq87TO5H@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 13 Mar 2021 00:46:11 +0800
Message-ID: <CAMZfGtWQ2HrV2Sw8K_vBJ5c9U+V2Q7AOha9aV6fR3RwrtbPZvA@mail.gmail.com>
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

On Fri, Mar 12, 2021 at 11:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Mar 12, 2021 at 05:22:55PM +0800, Muchun Song wrote:
> > On Thu, Mar 11, 2021 at 6:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > @@ -6828,7 +6857,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
> > > >
> > > >  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> > > >  {
> > > > -     unsigned long nr_pages;
> > > > +     unsigned long nr_pages, nr_kmem;
> > > >       struct mem_cgroup *memcg;
> > > >
> > > >       VM_BUG_ON_PAGE(PageLRU(page), page);
> > > > @@ -6836,34 +6865,44 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> > > >       if (!page_memcg_charged(page))
> > > >               return;
> > > >
> > > > +     nr_pages = compound_nr(page);
> > > >       /*
> > > >        * Nobody should be changing or seriously looking at
> > > > -      * page memcg at this point, we have fully exclusive
> > > > -      * access to the page.
> > > > +      * page memcg or objcg at this point, we have fully
> > > > +      * exclusive access to the page.
> > > >        */
> > > > -     memcg = page_memcg_check(page);
> > > > +     if (PageMemcgKmem(page)) {
> > > > +             struct obj_cgroup *objcg;
> > > > +
> > > > +             objcg = page_objcg(page);
> > > > +             memcg = obj_cgroup_memcg_get(objcg);
> > > > +
> > > > +             page->memcg_data = 0;
> > > > +             obj_cgroup_put(objcg);
> > > > +             nr_kmem = nr_pages;
> > > > +     } else {
> > > > +             memcg = page_memcg(page);
> > > > +             page->memcg_data = 0;
> > > > +             nr_kmem = 0;
> > > > +     }
> > >
> > > Why is all this moved above the uncharge_batch() call?
> >
> > Before calling obj_cgroup_put(), we need set page->memcg_data
> > to zero. So I move "page->memcg_data = 0" to here.
>
> Yeah, it makes sense to keep those together, but we can move them both
> down to after the uncharge, right?

Right. I am doing this.

>
> > > It separates the pointer manipulations from the refcounting, which
> > > makes the code very difficult to follow.
> > >
> > > > +
> > > >       if (ug->memcg != memcg) {
> > > >               if (ug->memcg) {
> > > >                       uncharge_batch(ug);
> > > >                       uncharge_gather_clear(ug);
> > > >               }
> > > >               ug->memcg = memcg;
> > > > +             ug->dummy_page = page;
> > >
> > > Why this change?
> >
> > Just like ug->memcg, we do not need to set
> > ug->dummy_page in every loop.
>
> Ah, okay. That's a reasonable change, it's just confusing because I
> thought this was a requirement for the new code to work. But I didn't
> see how it relied on that, and it made me think I'm not understanding
> your code ;) It's better to split that into a separate patch.

Sorry for confusing you. I will split that into a separate patch.
Thanks.

>
> > I will rework the code in the next version.
>
> Thanks!
