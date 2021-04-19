Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8339B364697
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbhDSPBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbhDSPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:01:06 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E582FC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:00:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id z8so39706133ljm.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wJcxPKcW0Veo1gCFL+CuNN37VW8R09vglUBE4v/xI9U=;
        b=AT/Bs0Z5qEWwjLyYLiTX6W0h7JJDDXlbbH1gNiMaQcF+icW/iFjk2BO/NlULM5/k3R
         FIQOadrNxR/LQZ/E6LpXhxDsllaWOUj3r7nH7N38qaGsdwqtn2qT6PVPZ+82bMRXeDVE
         4qkn/DA4HLAd+C+uF7pMGzGwH+1eAqsf2gXlNaEA05Eing9VFkTd9LdNsVdfhWgvaEwS
         USrRJT6rrfxCyqkI9J5XlVd41fifaNVinnCF7lVTQD93EsE4R6NqIpt16bxDZBqS+cB4
         cbzzwsMtySElnFgVXYuTAZh/XOp9KBm+yIyWffMzHqtYTKkGMryd1+0PQvmmZabjeCHC
         AGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wJcxPKcW0Veo1gCFL+CuNN37VW8R09vglUBE4v/xI9U=;
        b=GgjDeAo/oThBX6iOPeKrQ5Nl7+qDxM9j/FuCzagfNQ3rcMkvrMO/I9E95/ikb8fV9K
         OAoBDh/M9oqPE26MFUHLWgdEeEDxwnaZqr3I6wXfNkCAcLLeLf1SAq93H04bGDvk5scV
         myXRbUpabMgdbfPo3ug2c5iVl1FTdnQ/abrLUDTzwD+Yy30s6X0k8+fzy9LxiVcLkAfF
         DvxxlcNMdHiQIKeUYyAPU2y0s/hgHN1bs5H5gEuHZ+bKTtn9qL35DXJYLKq2AuRz2xj+
         Gq2aLXYVzUzTa6TpWx+JcZeqNmvInaB2GCM/EJaJsBqWWw+Rfgk22j9uHN9Q0LgRwb4E
         KRhA==
X-Gm-Message-State: AOAM533K9kobR3WKcDj8LLMgpDhz6YsXj2xSOJCcVbwzILTmaDHjKXu7
        3NAVXBYBkHFdEzEVXlO1CzB4iNFLTz2XJA3LCeubrQ==
X-Google-Smtp-Source: ABdhPJywEFDuUbOfS0rzoNWPrDTgirejFKtS/mXoxad8jVvyEBJGI384Qq3EN3fcHWo71sojwD5zaZv8adgeTx7Q6Yc=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr11824695ljj.34.1618844432793;
 Mon, 19 Apr 2021 08:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210419000032.5432-1-longman@redhat.com> <20210419000032.5432-6-longman@redhat.com>
 <CAMZfGtWX-Gik3i9_wmipuQZf0c-O-Yo_ejJYoN6-sf25vMLfog@mail.gmail.com>
In-Reply-To: <CAMZfGtWX-Gik3i9_wmipuQZf0c-O-Yo_ejJYoN6-sf25vMLfog@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 19 Apr 2021 08:00:21 -0700
Message-ID: <CALvZod70htGEyUm0vfOMpufrW4b2c18U3wR8TxsErKpkn=+CGw@mail.gmail.com>
Subject: Re: [External] [PATCH v4 5/5] mm/memcg: Improve refill_obj_stock() performance
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 11:07 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Mon, Apr 19, 2021 at 8:01 AM Waiman Long <longman@redhat.com> wrote:
> >
> > There are two issues with the current refill_obj_stock() code. First of
> > all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
> > atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
> > and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
> > be used again which leads to another call to drain_obj_stock() and
> > obj_cgroup_get() as well as atomically retrieve the available byte from
> > obj_cgroup. That is costly. Instead, we should just uncharge the excess
> > pages, reduce the stock bytes and be done with it. The drain_obj_stock()
> > function should only be called when obj_cgroup changes.
> >
> > Secondly, when charging an object of size not less than a page in
> > obj_cgroup_charge(), it is possible that the remaining bytes to be
> > refilled to the stock will overflow a page and cause refill_obj_stock()
> > to uncharge 1 page. To avoid the additional uncharge in this case,
> > a new overfill flag is added to refill_obj_stock() which will be set
> > when called from obj_cgroup_charge().
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
> >  mm/memcontrol.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a6dd18f6d8a8..d13961352eef 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3357,23 +3357,34 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> >         return false;
> >  }
> >
> > -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> > +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
> > +                            bool overfill)
> >  {
> >         unsigned long flags;
> >         struct obj_stock *stock = get_obj_stock(&flags);
> > +       unsigned int nr_pages = 0;
> >
> >         if (stock->cached_objcg != objcg) { /* reset if necessary */
> > -               drain_obj_stock(stock);
> > +               if (stock->cached_objcg)
> > +                       drain_obj_stock(stock);
> >                 obj_cgroup_get(objcg);
> >                 stock->cached_objcg = objcg;
> >                 stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
> >         }
> >         stock->nr_bytes += nr_bytes;
> >
> > -       if (stock->nr_bytes > PAGE_SIZE)
> > -               drain_obj_stock(stock);
> > +       if (!overfill && (stock->nr_bytes > PAGE_SIZE)) {
> > +               nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> > +               stock->nr_bytes &= (PAGE_SIZE - 1);
> > +       }
> >
> >         put_obj_stock(flags);
> > +
> > +       if (nr_pages) {
> > +               rcu_read_lock();
> > +               __memcg_kmem_uncharge(obj_cgroup_memcg(objcg), nr_pages);
> > +               rcu_read_unlock();
> > +       }
>
> It is not safe to call __memcg_kmem_uncharge() under rcu lock
> and without holding a reference to memcg. More details can refer
> to the following link.
>
> https://lore.kernel.org/linux-mm/20210319163821.20704-2-songmuchun@bytedance.com/
>
> In the above patchset, we introduce obj_cgroup_uncharge_pages to
> uncharge some pages from object cgroup. You can use this safe
> API.
>

I would recommend just rebase the patch series over the latest mm tree.
