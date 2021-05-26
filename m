Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E08390E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 05:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhEZDDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 23:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEZDDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 23:03:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:02:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x18so20848346pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 20:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ispGwrZyOkLcLokLfDTklwnT3S2zfpijrNq/+3Yb1oo=;
        b=K6y9IFTgpzx75/3GUC8pYV2qy6+0Cfs7Wd+um/VLcfOo6GG17W/nUJ03vwJNMHo+4x
         qxNFb6F7Yvki98yE2edv/l3D9ZqOXH12a51RKsu79Kqn2rU0cGng/IXkH/qu+HBQjWGz
         tlXupAzvikjEtYhRAqifcrQFVSDH+1+e3WNEc6aN5QdiQViQcionTdWsX1TrRDlqsoBR
         /6uRFGyb1NWFCZGiGGRNK5MifqkBAuK9ufG+i2vFaXa0GJ7V6HU3SaEY9XQW/OvuoMWc
         U7+L12kYp5OfU84suvjOYmWEd8PtPqvDkeVa4KsyRNHKO8l/hsZAwS8EK4Us6YBtmhji
         Pn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ispGwrZyOkLcLokLfDTklwnT3S2zfpijrNq/+3Yb1oo=;
        b=MoOxgAkR1dvp4ymlAeneSCgrD+hcAQ8GftGh5Q30dt0WV6f6zMRhJfGqBX7F6kvBfD
         6J05xQIx3mC91zChe2oeRiYixd+gXUf+QWJ4EhNE3WYHNggi9g2v86yzhhSTtpRuYFuT
         PApToLcaatAjlU6FN1Htm75MwYIQ1qP+7NFdPGVEPfPwQM0d4hSOiH610AWfGqNPFVEd
         Gel9nbuDnJYPfnQkxCH8nO6Y8BkV9UXvSQSUCA0JL2a7itHJfQ1Jqa4yfFK9KrEtHbqX
         fKzhikLX0JKYafNbyshXwUBLAfdupCBXvusxZS44tSf30n5X2Rp/P10BaOsPulW4fWvE
         cLSw==
X-Gm-Message-State: AOAM530zdGraqd21V8/bybGuN9y8V6BsH9gG8Gz1tF3NXEQ2DRt+kSWB
        aSffwmIgys9cpU6OgleHh/FMe5pRGo6VqJzQAenQLw==
X-Google-Smtp-Source: ABdhPJyT8PbK6O+mhRnB55VUYtuwkVtOQ4pIYd8a3oHC9BRBYwEjM2hH7IF784rGLEfQZWSUKm9iRc2CPz1xOfFKWb8=
X-Received: by 2002:a05:6a00:2493:b029:2c4:b6dd:d389 with SMTP id
 c19-20020a056a002493b02902c4b6ddd389mr33537895pfv.2.1621998133816; Tue, 25
 May 2021 20:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <20210421070059.69361-9-songmuchun@bytedance.com> <YK0398uCuWuAuSF7@carbon.dhcp.thefacebook.com>
In-Reply-To: <YK0398uCuWuAuSF7@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 May 2021 11:01:37 +0800
Message-ID: <CAMZfGtVCQ0sQkD5B6WQFKd-66ekYo_7sYtOaOPbam5-50=wBKw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v3 08/12] mm: memcontrol: introduce memcg_reparent_ops
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 1:46 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Apr 21, 2021 at 03:00:55PM +0800, Muchun Song wrote:
> > In the previous patch, we know how to make the lruvec lock safe when the
> > LRU pages reparented. We should do something like following.
> >
> >     memcg_reparent_objcgs(memcg)
> >         1) lock
> >         // lruvec belongs to memcg and lruvec_parent belongs to parent memcg.
> >         spin_lock(&lruvec->lru_lock);
> >         spin_lock(&lruvec_parent->lru_lock);
> >
> >         2) do reparent
> >         // Move all the pages from the lruvec list to the parent lruvec list.
> >
> >         3) unlock
> >         spin_unlock(&lruvec_parent->lru_lock);
> >         spin_unlock(&lruvec->lru_lock);
> >
> > Apart from the page lruvec lock, the deferred split queue lock (THP only)
> > also needs to do something similar. So we extracted the necessary 3 steps
> > in the memcg_reparent_objcgs().
> >
> >     memcg_reparent_objcgs(memcg)
> >         1) lock
> >         memcg_reparent_ops->lock(memcg, parent);
> >
> >         2) reparent
> >         memcg_reparent_ops->reparent(memcg, reparent);
> >
> >         3) unlock
> >         memcg_reparent_ops->unlock(memcg, reparent);
> >
> > Now there are two different locks (e.g. lruvec lock and deferred split
> > queue lock) need to use this infrastructure. In the next patch, we will
> > use those APIs to make those locks safe when the LRU pages reparented.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h | 11 +++++++++++
> >  mm/memcontrol.c            | 49 ++++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 58 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 228263f2c82b..b12847b0be09 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -355,6 +355,17 @@ struct mem_cgroup {
> >       /* WARNING: nodeinfo must be the last member here */
> >  };
> >
> > +struct memcg_reparent_ops {
> > +     struct list_head list;
> > +
> > +     /* Irq is disabled before calling those functions. */
> > +     void (*lock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
> > +     void (*unlock)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
> > +     void (*reparent)(struct mem_cgroup *memcg, struct mem_cgroup *parent);
> > +};
> > +
> > +void __init register_memcg_repatent(struct memcg_reparent_ops *ops);
> > +
> >  /*
> >   * size of first charge trial. "32" comes from vmscan.c's magic value.
> >   * TODO: maybe necessary to use big numbers in big irons.
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index a48403e5999c..f88fe2f06f5b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -330,6 +330,41 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
> >       return objcg;
> >  }
> >
> > +static LIST_HEAD(reparent_ops_head);
>
> Because this list is completely static, why not make a build-time initialized
> array instead?

I didn't think of using an array before. The first idea that popped out
was a list. But you remind me of the array. I'd love to replace it with
the array.

Thanks, Roman.

> I guess it's a more canonical way of solving problems like this.
> The proposed API looks good to me.
