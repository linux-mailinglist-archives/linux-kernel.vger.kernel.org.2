Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE58E341EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCSN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCSN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:59:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACCCC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:59:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b83so10146368lfd.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNIwjkC1S9o2xuElvHyMZN9mH83zWdQwYUBfBnqGovs=;
        b=EUJAmvbInnyEI94Eq1yJqB8E15rmGmxd0eGp7zoE+XyWeXOiuUQl/gTgforvibnFmx
         hiGgvaB527Ji9acOUTwCbLjnHOI7J4vzq86AFrM35DO4bpAfcfmHlSuAqoS9G8qPchZI
         y3yDbf3nyFuo7cOWKpKm0Ph3ki5Emui2ijrCnlOMG18pn2UrYt/vKicm4eW3b8667Mho
         aaoC4erUOR0/cUjxAofObB/A+7pGHsEOFfyZ45A8KDw8Cy6tLDi75/QbjCu8B80rI3xM
         3SLhOiMidT60OzSFpngLbdjcn9Pl7JFG/FwFdWEqC6DX6KQv4gWSRXxcE790tWHEF+zd
         LHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNIwjkC1S9o2xuElvHyMZN9mH83zWdQwYUBfBnqGovs=;
        b=btgP4pJvUSLDAegWB7HTqEIxfNixhnD0rvH0fDh6gBml0V3oh8jIvsne+Knyb8BoaP
         viSD+3sx99Oqyf/FpGiS8I89Y90Q5VUAJowcZtImraIow6TJfZFwTNGnFgJdUiqXpCeY
         u/hlvKkBognMy/PF/vxdeFW9jVw22Pkf6vt9zAzeDfKFE0aZErU1BYs9UzVPFLtuBI7w
         xEbHjfxEjnm8Y2vaNOxYjvXeL+10T52mpuhm53g9bbhxKKww+hi6EVPUbq+aRbxyJ6ea
         3rR3fh2pWcQ5ZJBh4qQr3lUAPoM2om6o8vHoSWFcqQ/XBq47E3enwDDWE2Pv5CoA0iMM
         3Sug==
X-Gm-Message-State: AOAM533qhsm4Op2hiXb0lQOvmpv/cwIOEZnPRRHFgCm/jR6RtjwRnag2
        SHybDmJK22sYNloXWsiozmNP2J6r3bBIkNxI0LFirg==
X-Google-Smtp-Source: ABdhPJxnob7NEKnE/oW7ZfcQUJDMcqfLGaOgMxiTJQSaqKoRAFOHIpsgwLehlAH+c2zqo8KRkaAae+5NHF4GP0n4zH8=
X-Received: by 2002:a19:e0d:: with SMTP id 13mr887724lfo.549.1616162365516;
 Fri, 19 Mar 2021 06:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210318110658.60892-1-songmuchun@bytedance.com>
 <20210318110658.60892-5-songmuchun@bytedance.com> <CALvZod5RSXiUHBkW4aaWOnak6LQ6QdSiGWMh9Wk_Q++dz6Y4_Q@mail.gmail.com>
 <CAMZfGtXSW8gX99SzYf7ourM5ZpsWYjWtiBL0MYpJXZeKB4HWXg@mail.gmail.com>
In-Reply-To: <CAMZfGtXSW8gX99SzYf7ourM5ZpsWYjWtiBL0MYpJXZeKB4HWXg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 06:59:13 -0700
Message-ID: <CALvZod5H-hL8myH1hy6YRis5vGT5JSYTQv5AeM0zagymCg0mcA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 4/5] mm: memcontrol: use obj_cgroup APIs
 to charge kmem pages
To:     Muchun Song <songmuchun@bytedance.com>
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

On Thu, Mar 18, 2021 at 9:05 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Fri, Mar 19, 2021 at 11:40 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, Mar 18, 2021 at 4:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > [...]
> > >
> > > +static inline struct mem_cgroup *get_obj_cgroup_memcg(struct obj_cgroup *objcg)
> >
> > I would prefer get_mem_cgroup_from_objcg().
>
> Inspired by obj_cgroup_memcg() which returns the memcg from objcg.
> So I introduce get_obj_cgroup_memcg() which obtains a reference of
> memcg on the basis of obj_cgroup_memcg().
>
> So that the names are more consistent. Just my thought.
>
> So should I rename it to get_mem_cgroup_from_objcg?
>

If you look at other functions which get reference on mem_cgroup, they
have the format of get_mem_cgroup_*. Similarly the current function to
get a reference on obj_cgroup is get_obj_cgroup_from_current().

So, from the name get_obj_cgroup_memcg(), it seems like we are getting
reference on obj_cgroup but the function is getting reference on
mem_cgroup.

> >
> > > +{
> > > +       struct mem_cgroup *memcg;
> > > +
> > > +       rcu_read_lock();
> > > +retry:
> > > +       memcg = obj_cgroup_memcg(objcg);
> > > +       if (unlikely(!css_tryget(&memcg->css)))
> > > +               goto retry;
> > > +       rcu_read_unlock();
> > > +
> > > +       return memcg;
> > > +}
> > > +
> > >  #ifdef CONFIG_MEMCG_KMEM
> > >  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> > >                                  gfp_t gfp, bool new_page)
> > > @@ -3070,15 +3088,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
> > >         struct mem_cgroup *memcg;
> > >         int ret;
> > >
> > > -       rcu_read_lock();
> > > -retry:
> > > -       memcg = obj_cgroup_memcg(objcg);
> > > -       if (unlikely(!css_tryget(&memcg->css)))
> > > -               goto retry;
> > > -       rcu_read_unlock();
> > > -
> > > +       memcg = get_obj_cgroup_memcg(objcg);
> > >         ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> >
> > Why not manually inline __memcg_kmem_charge() here? This is the only user.
> >
> > Similarly manually inline __memcg_kmem_uncharge() into
> > obj_cgroup_uncharge_pages() and call obj_cgroup_uncharge_pages() in
> > obj_cgroup_release().
>
> Good point. I will do this.
>
> >
> > > -
> > >         css_put(&memcg->css);
> > >
> > >         return ret;
> > > @@ -3143,18 +3154,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
> > >   */
> > >  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> > >  {
> > > -       struct mem_cgroup *memcg;
> > > +       struct obj_cgroup *objcg;
> > >         int ret = 0;
> > >
> > > -       memcg = get_mem_cgroup_from_current();
> >
> > This was the only use of get_mem_cgroup_from_current(). Why not remove it?
>
> I saw a potential user.
>
>     [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
>
> To avoid reintroducing them. So I did not remove it.
>

Don't worry about that. Most probably that user would be changing this
function, so it would to better to introduce from scratch.
