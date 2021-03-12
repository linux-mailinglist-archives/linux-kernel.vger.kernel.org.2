Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E042339296
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhCLP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbhCLP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:59:08 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC95C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:59:08 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id a9so24674572qkn.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e2ZA0A/mOLsi4lzgGZoMS7/RbeyMMKnDrF1tb/HRetE=;
        b=g2iED/s19RmA5nzvph9txgSZopnCVj4H7+WPCv953RbGRj2eG4tOWSQsqpEmWz9o16
         MaM+EMwIejJ6ftMqZHsyZfRyYpa443askoYUy0Qd10n0PAZdnCUwhgXtA3FdKRhPk1ky
         AQ5DB2UR094shT0mFAMg60khBPiAFuUJZEjUEQGiekCFQ647ezr/UJ41JCrz5T30MI0J
         6L0TyeIM0ybtNOZzaDEc1h8rWAisJtVD+aPX4dAe8Cg1QHrRHMy9CbfkALRNIDzHTO8Z
         ct1Oqh80qtMJrC3PrD0hPBkacrA6+MUbPkWJPiq4JYlmpTQ1UMlFejksJGQkWulN9NZY
         xxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e2ZA0A/mOLsi4lzgGZoMS7/RbeyMMKnDrF1tb/HRetE=;
        b=nrPRS2iZuKod1+iGi87hqwlKW5ewPg9Acjs2WW1vExdQqiQK/ZcYxLOkAePzqRqdNy
         aaepF+feHbj3GW79DYg43H/R532C+vD/Nq9V2zcHa60DZYIfNfmv/ni2Fx0cg2FhrsI0
         4RySn8bpUvqfxt7RVr0pg4HOeDFuH7U++Wf54qIiMt/u/J7pToAhKcoQXzHtraLyekvZ
         L5T2WUvL82EO4jPy9gQ5m60u4pNYzemoOqUIcwSkWk/sRetptNlak/XgIV1a1VAD3lWH
         sHC3CUuWpdcfIlAa7cJQf3kE4kcw3dWYcsrKy1iZoe4z47KDHlin+FlR7/LOhWSgrimz
         HNBg==
X-Gm-Message-State: AOAM531fLGXdMIIP7wN77Dc1PACWefLe3Q9ssG40BgE7ds0w6lgiMMIl
        MtTWQ+77jxSt+SuxVDfC0ugPFA==
X-Google-Smtp-Source: ABdhPJxjNKGObpsyxinzAr9Md1Fh10M1E3z8ULPFZAtWDOs2kC1FYHd2gJHrCXtKAPvoRNB2/j4RsQ==
X-Received: by 2002:a37:a416:: with SMTP id n22mr13293775qke.259.1615564747182;
        Fri, 12 Mar 2021 07:59:07 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k28sm4748130qki.101.2021.03.12.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:59:06 -0800 (PST)
Date:   Fri, 12 Mar 2021 10:59:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Subject: Re: [External] Re: [PATCH v3 3/4] mm: memcontrol: use obj_cgroup
 APIs to charge kmem pages
Message-ID: <YEuPydlPkq87TO5H@cmpxchg.org>
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-4-songmuchun@bytedance.com>
 <YElCxDzVgBBLAQhJ@cmpxchg.org>
 <CAMZfGtUqTBJ56eEj5CiFbHGMMaopP9k1Tq94R+M=W6P0HF83_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtUqTBJ56eEj5CiFbHGMMaopP9k1Tq94R+M=W6P0HF83_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 05:22:55PM +0800, Muchun Song wrote:
> On Thu, Mar 11, 2021 at 6:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > @@ -6828,7 +6857,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
> > >
> > >  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> > >  {
> > > -     unsigned long nr_pages;
> > > +     unsigned long nr_pages, nr_kmem;
> > >       struct mem_cgroup *memcg;
> > >
> > >       VM_BUG_ON_PAGE(PageLRU(page), page);
> > > @@ -6836,34 +6865,44 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> > >       if (!page_memcg_charged(page))
> > >               return;
> > >
> > > +     nr_pages = compound_nr(page);
> > >       /*
> > >        * Nobody should be changing or seriously looking at
> > > -      * page memcg at this point, we have fully exclusive
> > > -      * access to the page.
> > > +      * page memcg or objcg at this point, we have fully
> > > +      * exclusive access to the page.
> > >        */
> > > -     memcg = page_memcg_check(page);
> > > +     if (PageMemcgKmem(page)) {
> > > +             struct obj_cgroup *objcg;
> > > +
> > > +             objcg = page_objcg(page);
> > > +             memcg = obj_cgroup_memcg_get(objcg);
> > > +
> > > +             page->memcg_data = 0;
> > > +             obj_cgroup_put(objcg);
> > > +             nr_kmem = nr_pages;
> > > +     } else {
> > > +             memcg = page_memcg(page);
> > > +             page->memcg_data = 0;
> > > +             nr_kmem = 0;
> > > +     }
> >
> > Why is all this moved above the uncharge_batch() call?
> 
> Before calling obj_cgroup_put(), we need set page->memcg_data
> to zero. So I move "page->memcg_data = 0" to here.

Yeah, it makes sense to keep those together, but we can move them both
down to after the uncharge, right?

> > It separates the pointer manipulations from the refcounting, which
> > makes the code very difficult to follow.
> >
> > > +
> > >       if (ug->memcg != memcg) {
> > >               if (ug->memcg) {
> > >                       uncharge_batch(ug);
> > >                       uncharge_gather_clear(ug);
> > >               }
> > >               ug->memcg = memcg;
> > > +             ug->dummy_page = page;
> >
> > Why this change?
> 
> Just like ug->memcg, we do not need to set
> ug->dummy_page in every loop.

Ah, okay. That's a reasonable change, it's just confusing because I
thought this was a requirement for the new code to work. But I didn't
see how it relied on that, and it made me think I'm not understanding
your code ;) It's better to split that into a separate patch.

> I will rework the code in the next version.

Thanks!
