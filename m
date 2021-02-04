Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAAD30F6FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbhBDP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbhBDP5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:57:02 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC6FC061788
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:56:21 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id n10so2383471pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCCaUVi9BPMivSd/JjnmDZicqO5VGVuxEY7PUQjIT88=;
        b=rlZgV+XQhv7Yhfg2tHnSnXCKKbzm84eznk312M6PxgAwzfTh4Ik7suX8rLMrd8rXzW
         ELbY53/nujaDFMiP14r3bJRXJe2SLOoDDm7sffhsqmt4GKW+wmpKq6Gdtfj2QdFO17T+
         WrG64+XjOEDDvget+WoHZdNRbg5IRNW8ARaNBPxIRGcCFwjnSRzV0hu2+Sg9n5s1otFy
         dIe6RG99T8b1bYWd9JqmT4Sgzp+tBEy+/04B4IeuCr5ItLShwKeV6hjbqyEvOKR40jJe
         PdJGOuMShSOj8Gf4D32HY3XPIV4w8c5fUSBIfYPjxjpKYoZdYKnWF1oTvlasKNpW/y0T
         fP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCCaUVi9BPMivSd/JjnmDZicqO5VGVuxEY7PUQjIT88=;
        b=l7crNAk8CHX7f8GnWCC7lgM9ylDE8yHhwY4qROfgrabZAhwa6aFVqC1rIrlQGFz/dW
         hGlmPYiJqlT85ATJ5NziVxqVwEpzh+LGKmKQ+7zZV2cT801lz8TXLEyafEsYj/EyKMiO
         ElchnWW8T9PwckxbOiXKZNmm6cbJ9rEXRfIr/z9ByDPI0pOndzXUcNl6j2ndHagBuf1o
         62D5R0nQ/QOiylIcvK/Y5c6iD9s0TK/ABmf42+XeUzc14wYhtHsIHZI2rC4GlDP08XKO
         PwXSS6QikKL20S34UJwAMMjo4V3mMEUYLxFcuH0UW6mBBdncIzvTLxiUmsl4s8J6v613
         X7ZA==
X-Gm-Message-State: AOAM532zzIvkNfh6kl/Co0FAszjjGycNwo0axHyJwKqXGrVQXU96kC1Z
        uXrj2VFtTdL9gorz6YC8zdoK+IJIrijLdSflCjA7Tw==
X-Google-Smtp-Source: ABdhPJzXtbVw14PHJVJ/P6K8tkRvunxd2TP14mtVIL9yWCyPsjhzxjQLtCgjheeh3TtrPvDyiMiinT+N4rjzr0uQEhw=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr9775637pgf.31.1612454181401;
 Thu, 04 Feb 2021 07:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20210204105320.46072-1-songmuchun@bytedance.com> <YBwPQUwLQ6hAbdSV@cmpxchg.org>
In-Reply-To: <YBwPQUwLQ6hAbdSV@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 4 Feb 2021 23:55:45 +0800
Message-ID: <CAMZfGtX6VKKyBNhUJk+a2NTub8nfHbET=N_1ERHAqjUDEVJnZg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: replace the loop with a list_for_each_entry()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 11:14 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Feb 04, 2021 at 06:53:20PM +0800, Muchun Song wrote:
> > The rule of list walk has gone since:
> >
> >  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
> >
> > So remove the strange comment and replace the loop with a
> > list_for_each_entry().
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 17 ++---------------
> >  1 file changed, 2 insertions(+), 15 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6c7f1ea3955e..43341bd7ea1c 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6891,24 +6891,11 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >  static void uncharge_list(struct list_head *page_list)
> >  {
> >       struct uncharge_gather ug;
> > -     struct list_head *next;
> > +     struct page *page;
> >
> >       uncharge_gather_clear(&ug);
> > -
> > -     /*
> > -      * Note that the list can be a single page->lru; hence the
> > -      * do-while loop instead of a simple list_for_each_entry().
> > -      */
> > -     next = page_list->next;
> > -     do {
> > -             struct page *page;
> > -
> > -             page = list_entry(next, struct page, lru);
> > -             next = page->lru.next;
> > -
> > +     list_for_each_entry(page, page_list, lru)
> >               uncharge_page(page, &ug);
> > -     } while (next != page_list);
> > -
> >       uncharge_batch(&ug);
>
> Good catch, this makes things much simpler.
>
> Looking at the surrounding code, there also seems to be no reason
> anymore to have uncharge_list() as a separate function: there is only
> one caller after the mentioned commit, and it's trivial after your
> change. Would you mind folding it into mem_cgroup_uncharge_list()?

Will do. Thanks.

>
> The list_empty() check in that one is also unnecessary now: the
> do-while loop required at least one page to be on the list or it would
> crash, but list_for_each() will be just fine on an empty list.

Right. It makes things more simple.

>
> Thanks
