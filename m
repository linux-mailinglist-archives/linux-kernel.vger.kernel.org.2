Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5E310797
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhBEJSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBEJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:15:48 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EB3C061797
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 01:15:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g3so3259899plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53pDsjk4dsfRxbD/kmYDiUVFcJx5hI2GOqEILwRUysY=;
        b=lI6xNbyP7s/yr16Sg6aC5FlliprvUbrxjSsyUrxMaPEP1KqYYQyRHtd9K0UqINg26g
         QmTgj8Spi3UKo86zeJGV83yXawxMbYM9CVFSrujTaGLXq/82Y0Ayv6njyfjK2fGS486s
         aK97+eddmJcU79YSI2w/3NYY8Cz5dFwUkAM0cps0WLK3XdhrzxC9i+UYWwr1A8prvV8X
         RP1T+YqbYhVSnYMEpWju7n9oT1AD5a3+cjb6SGUlmT1rX1pqmxW2MlNQEMuS1c1aXhPC
         acMS102YFmfhPAkrdrIGjnj//Ku6/enRZpVxSIW/x5r9lGBvP3E6a4a3x/IPrwui2Jbe
         D88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53pDsjk4dsfRxbD/kmYDiUVFcJx5hI2GOqEILwRUysY=;
        b=FLbYwxMdT/UPlM9nFW4unK1cadChpkBKKyxnJNToQP/KjW11wWQILdR3hfIGhSu5dl
         DpacTQSB7DGMA/wgLUVsALg/EB2AHpiDbLsxDwLR91Hy2NeE/jHwK3v8pdrRx0pEVwZB
         SPAxlNiNLkf3KyXRyCpEp/zRf8FbV2XKdEoFv9nc+bTDmtzicFmiQW+Mg4vVmummq5oZ
         q5eNx9M5CVVH+f0EGryiU1IMivniNsk3rPJn2ANaywTdhAfjj6U8oAKpCtzXUIeg2TiA
         5pvms77yl0mogORjE+qGIs1fn7IyEx1zSKqJ/2HOpYusNpmSqvGKTsCiH7FHcGIQP+Bk
         rHUQ==
X-Gm-Message-State: AOAM5330Y5Pl3MCda1BK5k8h6AHtPzmw5vp8OyRjuEO/o4VKehpACsHu
        Wat67/OnqZdMqaY0+yja6MzxjR46lGGpr+AuLIYeAQ==
X-Google-Smtp-Source: ABdhPJxMGYIycGAi3Uj9lQkUIgQRunnV305CBd9rmYFIKTOmtfjshvUBHb8MsZSHh3bzL9Wh6v8UWUN4E/B3LOdY1Co=
X-Received: by 2002:a17:902:b7c7:b029:e1:6cbe:db19 with SMTP id
 v7-20020a170902b7c7b02900e16cbedb19mr3444327plz.20.1612516507874; Fri, 05 Feb
 2021 01:15:07 -0800 (PST)
MIME-Version: 1.0
References: <20210205062719.74431-1-songmuchun@bytedance.com> <YB0DnAlCaQza4Uf9@dhcp22.suse.cz>
In-Reply-To: <YB0DnAlCaQza4Uf9@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 17:14:30 +0800
Message-ID: <CAMZfGtVhBrwgkJVwiah6eDsppSf8fYp+uZ=tZmHBLDFeTmQX3w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: remove rcu_read_lock from get_mem_cgroup_from_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:36 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 05-02-21 14:27:19, Muchun Song wrote:
> > The get_mem_cgroup_from_page() is called under page lock, so the page
> > memcg cannot be changed under us.
>
> Where is the page lock enforced?

Because it is called from alloc_page_buffers(). This path is under
page lock.

>
> > Also, css_get is enough because page
> > has a reference to the memcg.
>
> tryget used to be there to guard against offlined memcg but we have
> concluded this is impossible in this path. tryget stayed there to catch
> some unexpected cases IIRC.

Yeah, it can catch some unexpected cases. But why is this path
special so that we need a tryget?

>
> > If we really want to make the get_mem_cgroup_from_page() suitable for
> > arbitrary page, we should use page_memcg_rcu() instead of page_memcg()
> > and call it after rcu_read_lock().
>
> What is the primary motivation to change this code? is the overhead of
> tryget/RCU something that needs optimizing?

Actually, the rcu_read_lock() is not necessary here. So it is better to
remove it (indeed reduce some code).

Thanks.


>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 87f01bc05d1f..6c7f1ea3955e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1063,16 +1063,15 @@ EXPORT_SYMBOL(get_mem_cgroup_from_mm);
> >   */
> >  struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> >  {
> > -     struct mem_cgroup *memcg = page_memcg(page);
> > +     struct mem_cgroup *memcg;
> >
> >       if (mem_cgroup_disabled())
> >               return NULL;
> >
> > -     rcu_read_lock();
> >       /* Page should not get uncharged and freed memcg under us. */
> > -     if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> > -             memcg = root_mem_cgroup;
> > -     rcu_read_unlock();
> > +     memcg = page_memcg(page) ? : root_mem_cgroup;
> > +     css_get(&memcg->css);
> > +
> >       return memcg;
> >  }
> >  EXPORT_SYMBOL(get_mem_cgroup_from_page);
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
