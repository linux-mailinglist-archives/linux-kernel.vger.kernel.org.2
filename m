Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04A32F884
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 06:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCFF1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 00:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhCFF1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 00:27:03 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF29C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 21:27:03 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 18so3611319pfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 21:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uc7mXQTuHDzk+aDNNzQQX07oTLDrDNn3MiGGfXF4/WM=;
        b=Zz2xJ5ConvofN2Q21zhivY2nUjs7UpEQtJDX+ho5tWKNNQWsl8uaQWjvzZWU5sPWls
         h/q1rJ+T+0r8fKS/PtoPtosFNzvyfUjfiBNF/M/ixYJQH4Qr+t0crXIRfDDzuZv8HmmM
         SOcGb/gTXeeOQSqfbgGY9rLn2Uj7xdxnvnvEPSanwO381L000gNKlGKZiZEDQ7McnPDj
         P31Bt0C4c2BlLo+XEF6Npy+TvweKxQZrhC4y0Mj4TaSbfVZCJn91OaGO/J0mWqq20ssZ
         M6hMb12AQ8+vtG3lw9pBIX6wsN/iYEoau8BVVQYgxEu6q1gTz3tWxmLC/QarZNuqZbV2
         vUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uc7mXQTuHDzk+aDNNzQQX07oTLDrDNn3MiGGfXF4/WM=;
        b=jojrdPo3qQLY4fOQDveYRmsYHBfF1SjMitr5ZSrNKkUY26YRykEnGNfBAETytC3uv/
         aGCOBWZQjm9l9JzkLbaymldpt9E6T1Zgko3MlBULI2qlHyReQn28LjkBKUcdGPUYP+Cg
         /JOBmbQQsswXfWCKXOmyDPvgtVLg4MSCNR+DOAlRuPONMxKfnGGElmRlOFu7zcZqL3hz
         k1tyDfm6y0XgLX1Jebgw5h6LIvTTt2mNOvg37ijR34lN3prleW7CtY5tjTMgDN6sDnDZ
         gqaxzkTWwGCPxD88WIBoawqdg5/e2ZdRkuL77FRVbvrJDYsB0WKDWcM3MxDdHgoQa7Te
         Tj2w==
X-Gm-Message-State: AOAM533/IAUUoZauskyBiftoyg1xxeRzN7F6EaYARELDLEfsNjHRJknw
        tDd7k2Za8RCIlycjFYPav0+gCP4oFQCuqsJP0XvTUQ==
X-Google-Smtp-Source: ABdhPJxiDBW/SysoysDGwuv3pMvN2NDBPV959/X5Vlh3+H1J5qHIM3V4hqpM6no/LkX8N8sC04Mx8Qz/Red7im6ikCM=
X-Received: by 2002:a63:141e:: with SMTP id u30mr11847397pgl.31.1615008422782;
 Fri, 05 Mar 2021 21:27:02 -0800 (PST)
MIME-Version: 1.0
References: <20210303055917.66054-1-songmuchun@bytedance.com>
 <20210303055917.66054-2-songmuchun@bytedance.com> <YEJ+7JM3YfjfVVNo@carbon.dhcp.thefacebook.com>
In-Reply-To: <YEJ+7JM3YfjfVVNo@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 6 Mar 2021 13:26:26 +0800
Message-ID: <CAMZfGtVE9QKeHaMxF0xRYwme1JSf_G5+vru_R=_iND5DBk3RvA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 1/5] mm: memcontrol: introduce obj_cgroup_{un}charge_page
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

On Sat, Mar 6, 2021 at 2:56 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Mar 03, 2021 at 01:59:13PM +0800, Muchun Song wrote:
> > We know that the unit of slab object charging is bytes, the unit of
> > kmem page charging is PAGE_SIZE. If we want to reuse obj_cgroup APIs
> > to charge the kmem pages, we should pass PAGE_SIZE (as third parameter)
> > to obj_cgroup_charge(). Because the size is already PAGE_SIZE, we can
> > skip touch the objcg stock. And obj_cgroup_{un}charge_page() are
> > introduced to charge in units of page level.
> >
> > In the later patch, we also can reuse those two helpers to charge or
> > uncharge a number of kernel pages to a object cgroup. This is just
> > a code movement without any functional changes.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> This patch looks good to me, even as a standalone refactoring.
> Please, rename obj_cgroup_charge_page() to obj_cgroup_charge_pages()
> and the same with uncharge. It's because _page suffix usually means
> we're dealing with a physical page (e.g. struct page * as an argument),
> here it's not the case.

Make sense.

>
> Please, add my Acked-by: Roman Gushchin <guro@fb.com>
> after the renaming.

Will do. Thanks for your review.

>
> Thank you!
>
> > ---
> >  mm/memcontrol.c | 46 +++++++++++++++++++++++++++++++---------------
> >  1 file changed, 31 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 845eec01ef9d..faae16def127 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3056,6 +3056,34 @@ static void memcg_free_cache_id(int id)
> >       ida_simple_remove(&memcg_cache_ida, id);
> >  }
> >
> > +static inline void obj_cgroup_uncharge_page(struct obj_cgroup *objcg,
> > +                                         unsigned int nr_pages)
> > +{
> > +     rcu_read_lock();
> > +     __memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
> > +     rcu_read_unlock();
> > +}
> > +
> > +static int obj_cgroup_charge_page(struct obj_cgroup *objcg, gfp_t gfp,
> > +                               unsigned int nr_pages)
> > +{
> > +     struct mem_cgroup *memcg;
> > +     int ret;
> > +
> > +     rcu_read_lock();
> > +retry:
> > +     memcg = obj_cgroup_memcg(objcg);
> > +     if (unlikely(!css_tryget(&memcg->css)))
> > +             goto retry;
> > +     rcu_read_unlock();
> > +
> > +     ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> > +
> > +     css_put(&memcg->css);
> > +
> > +     return ret;
> > +}
> > +
> >  /**
> >   * __memcg_kmem_charge: charge a number of kernel pages to a memcg
> >   * @memcg: memory cgroup to charge
> > @@ -3180,11 +3208,8 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
> >               unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> >               unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
> >
> > -             if (nr_pages) {
> > -                     rcu_read_lock();
> > -                     __memcg_kmem_uncharge(obj_cgroup_memcg(old), nr_pages);
> > -                     rcu_read_unlock();
> > -             }
> > +             if (nr_pages)
> > +                     obj_cgroup_uncharge_page(old, nr_pages);
> >
> >               /*
> >                * The leftover is flushed to the centralized per-memcg value.
> > @@ -3242,7 +3267,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> >
> >  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> >  {
> > -     struct mem_cgroup *memcg;
> >       unsigned int nr_pages, nr_bytes;
> >       int ret;
> >
> > @@ -3259,24 +3283,16 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> >        * refill_obj_stock(), called from this function or
> >        * independently later.
> >        */
> > -     rcu_read_lock();
> > -retry:
> > -     memcg = obj_cgroup_memcg(objcg);
> > -     if (unlikely(!css_tryget(&memcg->css)))
> > -             goto retry;
> > -     rcu_read_unlock();
> > -
> >       nr_pages = size >> PAGE_SHIFT;
> >       nr_bytes = size & (PAGE_SIZE - 1);
> >
> >       if (nr_bytes)
> >               nr_pages += 1;
> >
> > -     ret = __memcg_kmem_charge(memcg, gfp, nr_pages);
> > +     ret = obj_cgroup_charge_page(objcg, gfp, nr_pages);
> >       if (!ret && nr_bytes)
> >               refill_obj_stock(objcg, PAGE_SIZE - nr_bytes);
> >
> > -     css_put(&memcg->css);
> >       return ret;
> >  }
> >
> > --
> > 2.11.0
> >
