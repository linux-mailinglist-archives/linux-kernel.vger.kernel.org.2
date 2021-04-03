Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5179353409
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhDCMiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 08:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhDCMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 08:37:57 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A5C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 05:37:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f17so3659579plr.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3znEsRlGP0N8fSB0MyPPdnv2DM9lRQ51vAjGcVokwdg=;
        b=wcY4VKKuD29nmfwYrc2MSjfDEufxBo6ateTTtXPw2mWsv4qKh8DHBWzrJbb42qGyx9
         tHDp5FrvWIESUQKiRlcTtc+QvWT80uq+FOcdaS6pOriq2VnDFYp71IBu3s17U09xO/aL
         +oLFDW7T5+l9hEHzmXGd7AWajtoh1Te/3bEI7fMEiXazVlSYIWf4q2vDnv2hoaYRJwz+
         vZMcrVQBzVNnKRfAYXiVQVuZ/27KAZXiJxBiFjdrF+iG7SwgxsIzHX9sCfR3puObgQZ6
         CQfVA3bIFHZ/PASoqHkgzMDOATWEEkJOLCvLTdQSA69bie8e4RAgQ2biUS/BRBLf51gm
         G82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3znEsRlGP0N8fSB0MyPPdnv2DM9lRQ51vAjGcVokwdg=;
        b=Uk/FQf1fmRAqpIGqxV8j/+xpVC70kTnpmkB+C6WGPxoAJdyP8DrotGuUbj3YKOixID
         JgGqzZlLRtdC3ydEINvGdwJchlL07D2lXyPM5xhR39dViNWzmepncddg3sWyZIJiwnUo
         3A2os7rb/EI5D7mCXgb17etCHjJDY+1s1XPkPVRQjzsvWscB3H66lom4m73IHCzPgUpk
         o3c2zZQkTHIOzBg5niRuNZncQYJxauCq0lXG3yod1V0W2/2jjuwQChiBstZqhhM0/0Mx
         bqYZrPVPfT4asqXSiSBPRIlul+hGN5xg+U+GHt/+UwQeS4dH0UrzA/olgcsrwK4WkCeS
         fgWw==
X-Gm-Message-State: AOAM531xn0UiGRBY1Qi15T3EFBFBcJfJlCXKu92nf9KDzdmLT5DCapPc
        7eLAY2XbKeVxOnoxFboRUKYq+Qxs4M+XEExDIGppNPl8y4cq91iY
X-Google-Smtp-Source: ABdhPJxy2yRuBIGJm+2kp2+JUFXvhF8YEcntMLHSjum5mCfeO9d5gq1hLYRoZtEDGiqEuIhm07Norq+7E1pHt5Wp0Y8=
X-Received: by 2002:a17:90b:14f:: with SMTP id em15mr5218709pjb.13.1617453472928;
 Sat, 03 Apr 2021 05:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210330101531.82752-1-songmuchun@bytedance.com>
 <20210330101531.82752-5-songmuchun@bytedance.com> <YGdEnN6WkKbNp1QJ@cmpxchg.org>
In-Reply-To: <YGdEnN6WkKbNp1QJ@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 3 Apr 2021 20:37:14 +0800
Message-ID: <CAMZfGtWi7RCyqK4Ns1i4k2mVww8tJdV4LQfZUycRu2k_eXsp9g@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 04/15] mm: memcontrol: use lruvec_memcg
 in lruvec_holds_page_lru_lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 12:21 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Mar 30, 2021 at 06:15:20PM +0800, Muchun Song wrote:
> > We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> > do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> > lruvec_memcg() instead.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index a35a22994cf7..6e3283828391 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -744,20 +744,20 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
> >       return mem_cgroup_lruvec(memcg, pgdat);
> >  }
> >
> > +static inline struct mem_cgroup *lruvec_memcg(struct lruvec *lruvec);
>
> Please reorder the functions instead to avoid forward decls.

OK. Will fix it in the next version.


>
> >  static inline bool lruvec_holds_page_lru_lock(struct page *page,
> >                                             struct lruvec *lruvec)
> >  {
> >       pg_data_t *pgdat = page_pgdat(page);
> >       const struct mem_cgroup *memcg;
> > -     struct mem_cgroup_per_node *mz;
> >
> >       if (mem_cgroup_disabled())
> >               return lruvec == &pgdat->__lruvec;
> >
> > -     mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> >       memcg = page_memcg(page) ? : root_mem_cgroup;
> >
> > -     return lruvec->pgdat == pgdat && mz->memcg == memcg;
> > +     return lruvec->pgdat == pgdat && lruvec_memcg(lruvec) == memcg;
>
> Looks reasonable to me, but I wonder if there is more we can do.
>
> lruvec_memcg() already handles CONFIG_MEMCG and mem_cgroup_disabled()
> combinations, and there is also a lruvec_pgdat() which does.
>
> One thing that is odd is page_memcg(page) ? : root_mem_cgroup. How can
> lruvec pages not have a page_memcg()? mem_cgroup_page_lruvec() has:

You are right. page_memcg() cannot be NULL.

>
>         memcg = page_memcg(page);
>         VM_WARN_ON_ONCE_PAGE(!memcg && !mem_cgroup_disabled(), page);
>
> Unless I'm missing something, we should be able to have a single
> definition for this function that works for !CONFIG_MEMCG,
> CONFIG_MEMCG + mem_cgroup_disabled() and CONFIG_MEMCG:
>
> lruvec_holds_page_lru_lock()
> {
>         return lruvec_pgdat(lruvec) == page_pgdat(page) &&
>                 lruvec_memcg(lruvec) == page_memcg(page);
> }

Aha, how wonderful! It is simpler than mine. I will use this.
Thanks for your suggestions.
