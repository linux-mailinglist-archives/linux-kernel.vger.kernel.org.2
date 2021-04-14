Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0231335F12D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348750AbhDNKBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348630AbhDNKBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:01:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95529C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:01:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a85so12949953pfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 03:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oM3UOkNCezMjiEPLSqbUtWwjwRir2sVI9CJStf2+Is4=;
        b=rhjv0ZuhAtazcQOUb1eJY2IvHwhZz1bA7N5PVM7o+aT3T25vyS1PN1mUU95ATPaBJI
         RY4cIBkIz/v9jbeC5/v6bu7jA1MTxYH4qdNO711e1r4WGTO9f0QJ19Qf92GiIJ7t1AWr
         lG63XrIx+2T5RudUiNV8oJCo/XgdvvbFsIRMrgSVY26lj21qBW5Gmw6za+cdJAlHbDYF
         2SFsx6EqyAPN0PNGUvt7qOKIJ+GW+jCP4jcGD6gJzoifIImbyjlnYjd/0J1o/sotiIID
         QqkvZdB6+VJYJzidr27YDCwhZkMg6R85+nbBYhpwYLHOBZeongYye/eP0fyXY3+kET50
         BPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oM3UOkNCezMjiEPLSqbUtWwjwRir2sVI9CJStf2+Is4=;
        b=WZxZEgd2x9EoC0O4RG22r0WU3TCNKdyuJ2MhYMvOYH9J1Jd75fo4NwHXy8Mr2RfXoJ
         /J0j3nJKLc8KPTRWoPnGH+1EBsShJvjg7Uaf70ps+Jre5sAOmJu35TFaZEu5fyrCPmyB
         q0LtGtmFrSqvryZ/O24rWExKdPjH7z3vGMeyMaj6gOU/Ggyrj7ioGNNxPuPOsJjaO57g
         2WQnsdtTsj4yw1RFSgbcKbvs0hOmD07szzKzLElm81c0pPrhYOdYKbqr4WrRME0ox63A
         y7GU+2nnqRSEj7ka8wmUpRYlsentKRQb2VomKeH5E5pLh/XuFj5FdhxiscFVWLBGk9zF
         fbvQ==
X-Gm-Message-State: AOAM530eWFVEPBFzcPYtgDq5cZwtMPs5V+iIQsRfn6rZUEH6DCPqsmez
        EHUGg2HCoDbAiCqTImF0hDdrg+PyjODPIsdP9lls5A==
X-Google-Smtp-Source: ABdhPJx/Xz6/Qy9p2feD9c2q71a08v4/irn/LoCKOc74pl8CFJ99bxidUCILsasl29hfhSjf0g3N3T8C9CnEV4405Ag=
X-Received: by 2002:aa7:950d:0:b029:244:4dd5:cd0a with SMTP id
 b13-20020aa7950d0000b02902444dd5cd0amr29593080pfp.59.1618394480009; Wed, 14
 Apr 2021 03:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com>
 <20210413065153.63431-5-songmuchun@bytedance.com> <YHa5ao/JgoqHQh0Z@dhcp22.suse.cz>
In-Reply-To: <YHa5ao/JgoqHQh0Z@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 14 Apr 2021 18:00:42 +0800
Message-ID: <CAMZfGtXBqxxgNaB5dcNGvtoH7Gn-1+Ara1YOGS-OahNXaExhsQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/7] mm: memcontrol: simplify lruvec_holds_page_lru_lock
To:     Michal Hocko <mhocko@suse.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 5:44 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 13-04-21 14:51:50, Muchun Song wrote:
> > We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> > do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> > lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> > page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> > of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> > to simplify the code. We can have a single definition for this function
> > that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> > CONFIG_MEMCG.
>
> Neat. While you are at it wouldn't it make sesne to rename the function
> as well. I do not want to bikeshed but this is really a misnomer. it
> doesn't check anything about locking. page_belongs_lruvec?

Right. lruvec_holds_page_lru_lock is used to check whether
the page belongs to the lruvec. page_belongs_lruvec
obviously more clearer. I can rename it to
page_belongs_lruvec the next version.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> > ---
> >  include/linux/memcontrol.h | 31 +++++++------------------------
> >  1 file changed, 7 insertions(+), 24 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 4f49865c9958..38b8d3fb24ff 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -755,22 +755,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
> >       return mem_cgroup_lruvec(memcg, pgdat);
> >  }
> >
> > -static inline bool lruvec_holds_page_lru_lock(struct page *page,
> > -                                           struct lruvec *lruvec)
> > -{
> > -     pg_data_t *pgdat = page_pgdat(page);
> > -     const struct mem_cgroup *memcg;
> > -     struct mem_cgroup_per_node *mz;
> > -
> > -     if (mem_cgroup_disabled())
> > -             return lruvec == &pgdat->__lruvec;
> > -
> > -     mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > -     memcg = page_memcg(page) ? : root_mem_cgroup;
> > -
> > -     return lruvec->pgdat == pgdat && mz->memcg == memcg;
> > -}
> > -
> >  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
> >
> >  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
> > @@ -1229,14 +1213,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
> >       return &pgdat->__lruvec;
> >  }
> >
> > -static inline bool lruvec_holds_page_lru_lock(struct page *page,
> > -                                           struct lruvec *lruvec)
> > -{
> > -     pg_data_t *pgdat = page_pgdat(page);
> > -
> > -     return lruvec == &pgdat->__lruvec;
> > -}
> > -
> >  static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> >  {
> >  }
> > @@ -1518,6 +1494,13 @@ static inline void unlock_page_lruvec_irqrestore(struct lruvec *lruvec,
> >       spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> >  }
> >
> > +static inline bool lruvec_holds_page_lru_lock(struct page *page,
> > +                                           struct lruvec *lruvec)
> > +{
> > +     return lruvec_pgdat(lruvec) == page_pgdat(page) &&
> > +            lruvec_memcg(lruvec) == page_memcg(page);
> > +}
> > +
> >  /* Don't lock again iff page's lruvec locked */
> >  static inline struct lruvec *relock_page_lruvec_irq(struct page *page,
> >               struct lruvec *locked_lruvec)
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
