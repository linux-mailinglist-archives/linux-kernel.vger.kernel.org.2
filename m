Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB336685B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhDUJvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhDUJvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:51:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDECC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:50:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c17so28266421pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 02:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FofhuHim/yAjLcyzSZ2t1K4ha+04WQhQ6veF6EUmaCw=;
        b=wyV+20cNMljrH/90JfzzMkjbjWp2UDqI8qqA1ZTIFgwWhvrHsDzuUJkRC1r6qx16q7
         V06CvlnKq9hFEGaxgbFRnkd8tkDiYGuYEVlua4TE1Z6neZRKv74cAs+8Wt24tSxxp1Aj
         HsLrO0U2l5E6WIm+4h14LnFuMVUIhxFfUZ/hpLzdzIatdHNDZ4oQ3BBTn+U/PhPGWoPr
         HQuOInxzzDxhyQ7hnypn0+PFLQ06nYub9SHheHA9GBIw5KFEe6QSl5M3VM1VR72Oy585
         +pzsyRDmY8WbVeCVHtCN+S3iBYYfRjbic0CfkgDZc1omxHABftLywiHkqR53ndQtQyqZ
         lpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FofhuHim/yAjLcyzSZ2t1K4ha+04WQhQ6veF6EUmaCw=;
        b=cbb6ShuoEl7iQ9Q9MizDUrScatFDjIR5Nghxn4Zrcdacd3v9eovoGXcF4djY21Ho0A
         Q/EAfO7Zc1ZRLvenmcOQVd36feAmp01iTmzwPD1UEqAXCB00df1D34AWLj8LkIgPXDCe
         06NScNy6txnhE6wOsfHesHXx3go5kOwwokGex70PJNpLGOFSPxRkmjpitf7OJsKUiE0k
         rsLZvPgj5z3QMMXZ+/hNO0FBSeWcyDCfVH5LwpVVV8e10lQ6Nw0xUvIIh2D+fYAwBqd1
         A+BaLpLTjw3qY5UpfoFRd69v8ctSn6JOEXOiDAtmwpIBRE5lOgu19nHTsFxJvA7NbBoU
         T2kQ==
X-Gm-Message-State: AOAM533cTa5oeJ3wpUoQAlMmk41fz4KI0eQ72b+/ZTD8TCy5odUOD9KW
        RLl0+pZDCWG3oVeg6ZJdEabwCW/z9GSOl0va8xCFEDEHl9PXcg==
X-Google-Smtp-Source: ABdhPJzflLOYb7RSqIdpU6cNT1PnBtbHHmAc9zSIUPhCxdW9TODj+DCrWgD4U4R8hHHOFB8fQpCZhQO+Ic3CfL2BGtA=
X-Received: by 2002:a05:6a00:228a:b029:264:1ec7:7c3 with SMTP id
 f10-20020a056a00228ab02902641ec707c3mr6848675pfe.2.1618998643807; Wed, 21 Apr
 2021 02:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210421062644.68331-1-songmuchun@bytedance.com> <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
In-Reply-To: <YH/Vf8SDRy7VR7ur@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 21 Apr 2021 17:50:06 +0800
Message-ID: <CAMZfGtVpz1FvzmhWFzXAJE3wWBMJwdwU+JqQ6a8KeOhV3FGJ4Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 3:34 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 21-04-21 14:26:44, Muchun Song wrote:
> > The below scenario can cause the page counters of the root_mem_cgroup
> > to be out of balance.
> >
> > CPU0:                                   CPU1:
> >
> > objcg = get_obj_cgroup_from_current()
> > obj_cgroup_charge_pages(objcg)
> >                                         memcg_reparent_objcgs()
> >                                             // reparent to root_mem_cgroup
> >                                             WRITE_ONCE(iter->memcg, parent)
> >     // memcg == root_mem_cgroup
> >     memcg = get_mem_cgroup_from_objcg(objcg)
> >     // do not charge to the root_mem_cgroup
> >     try_charge(memcg)
> >
> > obj_cgroup_uncharge_pages(objcg)
> >     memcg = get_mem_cgroup_from_objcg(objcg)
> >     // uncharge from the root_mem_cgroup
> >     page_counter_uncharge(&memcg->memory)
> >
> > This can cause the page counter to be less than the actual value,
> > Although we do not display the value (mem_cgroup_usage) so there
> > shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> > the page_counter_cancel(). Who knows if it will trigger? So it
> > is better to fix it.
>
> The changelog doesn't explain the fix and why you have chosen to charge
> kmem objects to root memcg and left all other try_charge users intact.

The object cgroup is special (because the page can reparent). Only the
user of objcg APIs should be fixed.

> The reason is likely that those are not reparented now but that just
> adds an inconsistency.
>
> Is there any reason you haven't simply matched obj_cgroup_uncharge_pages
> to check for the root memcg and bail out early?

Because obj_cgroup_uncharge_pages() uncharges pages from the
root memcg unconditionally. Why? Because some pages can be
reparented to root memcg, in order to ensure the correctness of
page counter of root memcg. We have to uncharge pages from
root memcg. So we do not check whether the page belongs to
the root memcg when it uncharges. Based on this, we have
to make sure that the root memcg page counter is increased
when the page charged. I think the diagram (in the commit log) can
illustrate this problem well.

Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1e68a9992b01..81b54bd9b9e0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2686,8 +2686,8 @@ void mem_cgroup_handle_over_high(void)
> >       css_put(&memcg->css);
> >  }
> >
> > -static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > -                   unsigned int nr_pages)
> > +static int __try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > +                     unsigned int nr_pages)
> >  {
> >       unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
> >       int nr_retries = MAX_RECLAIM_RETRIES;
> > @@ -2699,8 +2699,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       bool drained = false;
> >       unsigned long pflags;
> >
> > -     if (mem_cgroup_is_root(memcg))
> > -             return 0;
> >  retry:
> >       if (consume_stock(memcg, nr_pages))
> >               return 0;
> > @@ -2880,6 +2878,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       return 0;
> >  }
> >
> > +static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > +                          unsigned int nr_pages)
> > +{
> > +     if (mem_cgroup_is_root(memcg))
> > +             return 0;
> > +
> > +     return __try_charge(memcg, gfp_mask, nr_pages);
> > +}
> > +
> >  #if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
> >  static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
> >  {
> > @@ -3125,7 +3132,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
> >
> >       memcg = get_mem_cgroup_from_objcg(objcg);
> >
> > -     ret = try_charge(memcg, gfp, nr_pages);
> > +     ret = __try_charge(memcg, gfp, nr_pages);
> >       if (ret)
> >               goto out;
> >
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
