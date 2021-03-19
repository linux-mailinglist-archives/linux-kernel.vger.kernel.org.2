Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D87342128
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 16:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhCSPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhCSPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 11:46:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:46:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v3so3956714pgq.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 08:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qONpO4rhVUGycYg/TRvqp7wSV44IcWoCAbGRlkLp9Ss=;
        b=rsTx4yyQbVw/axvuQK7riy8Ifnu/2vWnC+ipHqep+SkDFx7fxZGWhhFIMWg6OVsGvh
         zyNlDtgVGgHkwH5IoxwYKqzCkyRHUdMfK7fn06V6lsmUcm/3uPmOG7uUS6WGTQY4Bpd+
         WJV95QM9bXIgKyO4PxDQ4oC70Y43ZD1kvIdn+ikhfcGsgmgnvOadj91qkGxxuBPkSuLp
         v9DDfvpBKUr59vQCL5eUeTcDYyoyeT+fkdbOqQbcb8w63Hi2ci3ZkY4AIHc1igWN+6xe
         u9wTH9JnZ+EG0R8z4Ipx3rkZWiRk14cIpBSwHMfI5jpTVXe2HUNcRQLcl6DI11g+OPu5
         xD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qONpO4rhVUGycYg/TRvqp7wSV44IcWoCAbGRlkLp9Ss=;
        b=LrqiPIeGBlmB3gLmF5Lsj4O5TVGzglcyn1nnrbxfbYdvmR2yYXml7XGDyeo7ys+Rm2
         mWcYvPECnUzZ5l/uGvA+Rgz1YuCwHb5y0qdU/pE/jkrv9IbZkpoexgE4PKtZZSOQNLQG
         10HKJunRO2FFuXiMt2A5aHjx6TAXydbjbq+501OZ5E9J4tkEuHyyPnLvZRFtXRn6eTHa
         VRuFQVYUWnFDdvv+fvJp8q6g9UZDY7V/xMx/yuUydiasHE3s2M7ytQUeNooQYndtkdyN
         bA6xTpJWb3e83fhfidpkXFjSKQ0DkoJP4faV7NiCDKAhYNHWjZfTDlF52e5r5BstHqkD
         h/Yg==
X-Gm-Message-State: AOAM532dVdXdMqNTqFyH9ketCdWJR0YiEShux0tThjIjn5vYVlsODa0U
        EFiy+POh7yzdE28J2WAR54BO0vzgJJBPDyMKawg9TA==
X-Google-Smtp-Source: ABdhPJwwUIg8Pn8ujsnmmyz5LCe4Dmjkxby7QcP4D6KPoSbz3fTxSqAdZ1HACiuD0mvkzCmd32zZlBml8RGzzzJ/9tA=
X-Received: by 2002:a63:141e:: with SMTP id u30mr12262932pgl.31.1616168771346;
 Fri, 19 Mar 2021 08:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210318110658.60892-1-songmuchun@bytedance.com>
 <20210318110658.60892-5-songmuchun@bytedance.com> <CALvZod5RSXiUHBkW4aaWOnak6LQ6QdSiGWMh9Wk_Q++dz6Y4_Q@mail.gmail.com>
 <CAMZfGtXSW8gX99SzYf7ourM5ZpsWYjWtiBL0MYpJXZeKB4HWXg@mail.gmail.com> <CALvZod5H-hL8myH1hy6YRis5vGT5JSYTQv5AeM0zagymCg0mcA@mail.gmail.com>
In-Reply-To: <CALvZod5H-hL8myH1hy6YRis5vGT5JSYTQv5AeM0zagymCg0mcA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 19 Mar 2021 23:45:35 +0800
Message-ID: <CAMZfGtXHnaPFp67k4tD1Te4Y13wF5VHAQ5Vq_UyjzFCuTTe0+g@mail.gmail.com>
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

On Fri, Mar 19, 2021 at 9:59 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Mar 18, 2021 at 9:05 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Fri, Mar 19, 2021 at 11:40 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Thu, Mar 18, 2021 at 4:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > [...]
> > > >
> > > > +static inline struct mem_cgroup *get_obj_cgroup_memcg(struct obj_cgroup *objcg)
> > >
> > > I would prefer get_mem_cgroup_from_objcg().
> >
> > Inspired by obj_cgroup_memcg() which returns the memcg from objcg.
> > So I introduce get_obj_cgroup_memcg() which obtains a reference of
> > memcg on the basis of obj_cgroup_memcg().
> >
> > So that the names are more consistent. Just my thought.
> >
> > So should I rename it to get_mem_cgroup_from_objcg?
> >
>
> If you look at other functions which get reference on mem_cgroup, they
> have the format of get_mem_cgroup_*. Similarly the current function to
> get a reference on obj_cgroup is get_obj_cgroup_from_current().
>
> So, from the name get_obj_cgroup_memcg(), it seems like we are getting
> reference on obj_cgroup but the function is getting reference on
> mem_cgroup.

Make sense. I will use get_mem_cgroup_from_objcg(). Thanks.

>
> > >
> > > > +{
> > > > +       struct mem_cgroup *memcg;
> > > > +
> > > > +       rcu_read_lock();
> > > > +retry:
> > > > +       memcg = obj_cgroup_memcg(objcg);
> > > > +       if (unlikely(!css_tryget(&memcg->css)))
> > > > +               goto retry;
> > > > +       rcu_read_unlock();
> > > > +
> > > > +       return memcg;
> > > > +}
> > > > +
> > > >  #ifdef CONFIG_MEMCG_KMEM
> > > >  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
> > > >                                  gfp_t gfp, bool new_page)
> > > > @@ -3070,15 +3088,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
> > > >         struct mem_cgroup *memcg;
> > > >         int ret;
> > > >
> > > > -       rcu_read_lock();
> > > > -retry:
> > > > -       memcg = obj_cgroup_memcg(objcg);
> > > > -       if (unlikely(!css_tryget(&memcg->css)))
> > > > -               goto retry;
> > > > -       rcu_read_unlock();
> > > > -
> > > > +       memcg = get_obj_cgroup_memcg(objcg);
> > > >         ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> > >
> > > Why not manually inline __memcg_kmem_charge() here? This is the only user.
> > >
> > > Similarly manually inline __memcg_kmem_uncharge() into
> > > obj_cgroup_uncharge_pages() and call obj_cgroup_uncharge_pages() in
> > > obj_cgroup_release().
> >
> > Good point. I will do this.
> >
> > >
> > > > -
> > > >         css_put(&memcg->css);
> > > >
> > > >         return ret;
> > > > @@ -3143,18 +3154,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
> > > >   */
> > > >  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
> > > >  {
> > > > -       struct mem_cgroup *memcg;
> > > > +       struct obj_cgroup *objcg;
> > > >         int ret = 0;
> > > >
> > > > -       memcg = get_mem_cgroup_from_current();
> > >
> > > This was the only use of get_mem_cgroup_from_current(). Why not remove it?
> >
> > I saw a potential user.
> >
> >     [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
> >
> > To avoid reintroducing them. So I did not remove it.
> >
>
> Don't worry about that. Most probably that user would be changing this
> function, so it would to better to introduce from scratch.

OK. I will remove get_mem_cgroup_from_current(). Thanks for
your suggestions.
