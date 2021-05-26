Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5658C390E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhEZCvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhEZCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:51:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08BCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:49:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x18so20829364pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BepZnCkcUmGhQ5OjwD1VB02wV2VKA/owewc6BO/X1Y=;
        b=DDmq7hQ0ghVGWObwNW2j54M3a6BBUK6YgYXiFDgE/1LUF3TVDNic2ox+7j6NRkepE2
         yI2s7tDtlPv+f4cgn59M8gGrFY5oNNnCcbyliWqRSntAZdz8z8T/P20djEyMlPywkkHv
         rdrJdzQ5OhY1mFFg9t0VUcpzEe1ZraHVLxID29+JvKSDjihPv+sf4AZDr3pcobUya5Sy
         /fcBeRb2bjpH9JIP36gkbwERmQeXtSRV4jKVLC5jqkaqirTNObH4b7GjjNjZL5J98kHX
         e/WFuuJpP6ayvJzZdkd73crm5jHJOqGrRVzcQfF80up3W/jn2ny9nZbzX4Ka9ELQwJvI
         QJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BepZnCkcUmGhQ5OjwD1VB02wV2VKA/owewc6BO/X1Y=;
        b=XplOSMVia9D8OJG2fyQmTHhy8h9Ayg7LIZWONANy0XT27/JOjxJU0AWVmRsxh9o7PP
         Kk/lP887969r1hYzHtdnFKEeG9t1eo/Qv/5Q/vUNbLnYG6YYAFC7A4OjucYxMWyT9uJp
         DGfHVGcPXYM2Y30DqWVeLgBgM2Ims1wk/WwONmMPf0Q1U6Yz4RZl+37ewRFUCeQR+wUr
         0CfqJKjHNuD5RfyafCzMyP87lTXxcvIH/N7iI9otbs+oxqHzBQ0lw7Avk2uiUG53waz5
         Sf8dmiHv3vFfwdgfLOh6nl7ASW88/N7htb7zuHA/sa/69HoCHgrazbJsK5cpiJC5doYz
         C98Q==
X-Gm-Message-State: AOAM530yYadVohwdjwsFNkHndc43hY34kclThl4TXq58qungQ5Yqkavr
        EtPF5EvJQgSu5qQ1kSvPwouwnt7M65DSZBB/9jX+Fg==
X-Google-Smtp-Source: ABdhPJx7cPc0O2UrFrGyIQ+PbMrQwFRfUkTEdyu0u54IUeYn/MLLF/V39FIJVJEulczW9iJpLwXOLxLq7cKeyiXb+Zg=
X-Received: by 2002:a63:6547:: with SMTP id z68mr15614319pgb.341.1621997384564;
 Tue, 25 May 2021 19:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <20210421070059.69361-3-songmuchun@bytedance.com> <YK0yBhDj+9zJlz/d@carbon.dhcp.thefacebook.com>
In-Reply-To: <YK0yBhDj+9zJlz/d@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 May 2021 10:49:08 +0800
Message-ID: <CAMZfGtXEJv1mU5CHZV3H7Qkkmq0mEugQpOpDM7Q=K-Sr1L3ydQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v3 02/12] mm: memcontrol: introduce compact_lock_page_lruvec_irqsave
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

On Wed, May 26, 2021 at 1:21 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Apr 21, 2021 at 03:00:49PM +0800, Muchun Song wrote:
> > If we reuse the objcg APIs to charge LRU pages, the page_memcg()
> > can be changed when the LRU pages reparented. In this case, we need
> > to acquire the new lruvec lock.
> >
> >     lruvec = mem_cgroup_page_lruvec(page);
> >
> >     // The page is reparented.
> >
> >     compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> >
> >     // Acquired the wrong lruvec lock and need to retry.
> >
> > But compact_lock_irqsave() only take lruvec lock as the parameter,
> > we cannot aware this change. If it can take the page as parameter
> > to acquire the lruvec lock. When the page memcg is changed, we can
> > use the page_memcg() detect whether we need to reacquire the new
> > lruvec lock. So compact_lock_irqsave() is not suitable for us.
> > Similar to lock_page_lruvec_irqsave(), introduce
> > compact_lock_page_lruvec_irqsave() to acquire the lruvec lock in
> > the compaction routine.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Roman Gushchin <guro@fb.com>

Thanks.

>
> > ---
> >  mm/compaction.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 1c500e697c88..082293587cc6 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -511,6 +511,29 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> >       return true;
> >  }
> >
> > +static struct lruvec *
> > +compact_lock_page_lruvec_irqsave(struct page *page, unsigned long *flags,
> > +                              struct compact_control *cc)
>
> Maybe compact_lock_page_irqsave() to make it more similar to
> compact_lock_irqsafe()? But it's up to you.

I like a more brief name, compact_lock_page_irqsave is a good and
brief name. Thanks.

>
> Thanks!
