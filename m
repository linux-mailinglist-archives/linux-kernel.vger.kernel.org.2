Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4818A35F139
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348803AbhDNKFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhDNKFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:05:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39966C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:05:13 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l76so14040712pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNtB4o+0je6m6Iv/hxpsZ7k1lBzZu9C3dQfxcFge/sY=;
        b=K2suukuNiVkLANxIkI3yCx5pOloVIYD8+TW6JJAGH7k9zrO0/A+tXKSMs1r8qgYHom
         dKbXsUqNx28Q1ZC8G+CqSgBLdX/6p97YfgyLWtPv37D/rqB4Sn5HjJFW2vgyxEyR/6rv
         KfdYTYJFgCb3TUdmWTr+qXWg6r8FlYO5GvL7FjU0O/4CSHXO99VPHM8FXvmOjPlTOWYt
         Qah3E3fu04pTj1qB0Q6sOAt3dsQCAKxKpfgfN8zHRKSqlI6bjeDoRZwXNWDd2Iezhb+G
         2n5xuyRPsm7In+XuOJKGE5csNq5ddTP5NFsWGLCFD5LckfegyRDWdcTUiDz8yJK80jcr
         dqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNtB4o+0je6m6Iv/hxpsZ7k1lBzZu9C3dQfxcFge/sY=;
        b=AbeuUwGKubrPXSo3/c8HnDHu3/9OrNK/FMMkr7e3L9nlqlilJ+9F7J2WmBBwXw7Xrz
         U/2wJK2ZnI7fCnUBHRhAYss85ZZzPvEMUwbd3rGPcG8Wtp2xXcdzRQgEfqKlMqzUCCy2
         lWtJmaGSBaaJtM6OvJ2OXft8i0U540JiIg4NQJowfBejAoWit/K3C7vJ65kaPRU8+QHJ
         QzjysCrsRBRc2k2tkh1pAhVqxDkGVxaX/G0ptJtPrgb5gn490L+sMKRU0tQGw9gxOdMx
         AjTHEPYAijtnCqX8aV61Y5ofYeKwS9a95E19ZGP+BmsoEAUPkCL6MZP9CygTXMFUgqxi
         fK3A==
X-Gm-Message-State: AOAM5337LL86LDUa4ViHBs/h1mDVEJJXF+x2ukHMyx/VOKwGo+DvuD7X
        3xK5amrlsc6WyL/qCwXUvaexCSGvqcIgJd6I+Ayt7Q==
X-Google-Smtp-Source: ABdhPJykKLm23kCH/wnmdc/CWEONNuwxGeR3Xxpl2OWhmqxsoBzGI44cwtF1IAS9iuYGqAXyf3SGdk4LKH9dNCqdSYk=
X-Received: by 2002:a65:6645:: with SMTP id z5mr35991057pgv.273.1618394712780;
 Wed, 14 Apr 2021 03:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-3-songmuchun@bytedance.com> <YHa00lx7ACWcS1/h@dhcp22.suse.cz>
In-Reply-To: <YHa00lx7ACWcS1/h@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 14 Apr 2021 18:04:35 +0800
Message-ID: <CAMZfGtVpUW1=Zvys7J=gW1xqkuUVLuPYcQbwJoe=TEkBa6qqQw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/7] mm: memcontrol: bail out early when
 !mm in get_mem_cgroup_from_mm
To:     Michal Hocko <mhocko@suse.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 5:24 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 13-04-21 14:51:48, Muchun Song wrote:
> > When mm is NULL, we do not need to hold rcu lock and call css_tryget for
> > the root memcg. And we also do not need to check !mm in every loop of
> > while. So bail out early when !mm.
>
> mem_cgroup_charge and other callers unconditionally drop the reference
> so how come this does not underflow reference count?

For the root memcg, the CSS_NO_REF flag is set, so css_get
and css_put do not get or put reference.

Thanks.


>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  mm/memcontrol.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f229de925aa5..9cbfff59b171 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -901,20 +901,19 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
> >       if (mem_cgroup_disabled())
> >               return NULL;
> >
> > +     /*
> > +      * Page cache insertions can happen without an
> > +      * actual mm context, e.g. during disk probing
> > +      * on boot, loopback IO, acct() writes etc.
> > +      */
> > +     if (unlikely(!mm))
> > +             return root_mem_cgroup;
> > +
> >       rcu_read_lock();
> >       do {
> > -             /*
> > -              * Page cache insertions can happen without an
> > -              * actual mm context, e.g. during disk probing
> > -              * on boot, loopback IO, acct() writes etc.
> > -              */
> > -             if (unlikely(!mm))
> > +             memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> > +             if (unlikely(!memcg))
> >                       memcg = root_mem_cgroup;
> > -             else {
> > -                     memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> > -                     if (unlikely(!memcg))
> > -                             memcg = root_mem_cgroup;
> > -             }
> >       } while (!css_tryget(&memcg->css));
> >       rcu_read_unlock();
> >       return memcg;
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
