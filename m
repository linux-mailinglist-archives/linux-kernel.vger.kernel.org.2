Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC031CEDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhBPRSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhBPRSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:18:43 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:18:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u4so10059837lfs.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAIlfyj1+vl6wEY03t8gQIxJzlIrwjx8g7cV2iEl46I=;
        b=ajc+Ly1Kl3BQHBgTjkn+/wNh48GTRtZTdxzUnLJIhxY4ZFdqnb9AYLaI2XXT/ZVLrv
         jyngOR5w7dsP5aWWRcFYUODEcZN65i1edh1DfsByO6EIB6AZ32Cuj5vOz3wZdy9r1zNg
         Y1RHti10VjznC2eoihl0UL/cr+IAYRk25Oczds3MyxDy/ygc6AF2oSQvlGSgLRUMpRT6
         uFlUP8t+nHMnChWyq4NleRHpwctatl95VSvcqZDV/sKZrHxa/2AT/Si5DDZkL/fAhjxt
         c/Fyll05dd/xV/YbRAi7tz/eBZ8bA2MyA50QOh9upkC1Ic6UaOz9uHizMUsD+L4RszQ6
         Mfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAIlfyj1+vl6wEY03t8gQIxJzlIrwjx8g7cV2iEl46I=;
        b=WblKG1V7rAVY2P8wvoMZnTX7IKZSYGEWmSbQloGy5h7G+aM5dFZCRyg+p3cEX6sssW
         i1yD89mRMfACjTmHYrN5duVhiC0CrRfYx2ZhWzJCyQynV4K5KZc6dTN5zUpFbxp9KfXU
         5rAQeJkoKFlheTQtKXwTgHdwWQIIFeeJgskObmcwuAbfGu/pVhlxBFay3Q24+YtdxTeP
         HhlxHCx2AnKv+RHXOwgCvjmYbPmgGDWmUSr/UuY+PXT6Mffs1fJcY6yMAQN8PVw0Ewhw
         4rlhCgeB9CK4SH0mDj+5wA7Z1Xlcbc8uM1UCftmFyC8ZJiYHmG7tYyabIgVdiUxnsA4C
         /lLQ==
X-Gm-Message-State: AOAM533j445pEjhGuAAceoR6JZFNgoah1MQK8CE32U+2wcT74RjCMwtM
        NFwYWN+xZYN1W2gpsPkwL2k1KWYiGL/RjM6VKUZCnw==
X-Google-Smtp-Source: ABdhPJwONFMMXGr4fcY9J8n+r2ABk3IrHz+j4bqcUiSnw+UBoHcr+mheWKHCl5jqA0yctFSkbQDCLgqmr3CiqcS7MUw=
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr12389695lff.347.1613495879192;
 Tue, 16 Feb 2021 09:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com> <YCv51LgGIWxVjLHT@cmpxchg.org>
In-Reply-To: <YCv51LgGIWxVjLHT@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Feb 2021 09:17:45 -0800
Message-ID: <CALvZod6RPUFnA4zZR20e7M=GriYwWob3DMQqUfhqUMd9aJUq2w@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on cgroup v2
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 9:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hello Muchun,
>
> On Sat, Feb 13, 2021 at 01:01:59AM +0800, Muchun Song wrote:
> > The swap charges the actual number of swap entries on cgroup v2.
> > If a swap cache page is charged successful, and then we uncharge
> > the swap counter. It is wrong on cgroup v2. Because the swap
> > entry is not freed.
>
> The patch makes sense to me. But this code is a bit tricky, we should
> add more documentation to how it works and what the problem is.
>
> How about this for the changelog?
>
> ---
> mm: memcontrol: fix swap undercounting for shared pages in cgroup2
>
> When shared pages are swapped in partially, we can have some page
> tables referencing the in-memory page and some referencing the swap
> slot. Cgroup1 and cgroup2 handle these overlapping lifetimes slightly
> differently due to the nature of how they account memory and swap:
>
> Cgroup1 has a unified memory+swap counter that tracks a data page
> regardless whether it's in-core or swapped out. On swapin, we transfer
> the charge from the swap entry to the newly allocated swapcache page,
> even though the swap entry might stick around for a while. That's why
> we have a mem_cgroup_uncharge_swap() call inside mem_cgroup_charge().
>
> Cgroup2 tracks memory and swap as separate, independent resources and
> thus has split memory and swap counters. On swapin, we charge the
> newly allocated swapcache page as memory, while the swap slot in turn
> must remain charged to the swap counter as long as its allocated too.
>
> The cgroup2 logic was broken by commit 2d1c498072de ("mm: memcontrol:
> make swap tracking an integral part of memory control"), because it
> accidentally removed the do_memsw_account() check in the branch inside
> mem_cgroup_uncharge() that was supposed to tell the difference between
> the charge transfer in cgroup1 and the separate counters in cgroup2.
>
> As a result, cgroup2 currently undercounts consumed swap when shared
> pages are partially swapped back in. This in turn allows a cgroup to
> consume more swap than its configured limit intends.
>
> Add the do_memsw_account() check back to fix this problem.
> ---
>
> > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

With Johannes's suggestions:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c737c8f05992..be6bc5044150 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> >       memcg_check_events(memcg, page);
> >       local_irq_enable();
> >
> > -     if (PageSwapCache(page)) {
> > +     if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
>
> It's more descriptive to use do_memsw_account() here, IMO.
>
> We should also add a comment. How about this above the branch?
>
>         /*
>          * Cgroup1's unified memory+swap counter has been charged with the
>          * new swapcache page, finish the transfer by uncharging the swap
>          * slot. The swap slot would also get uncharged when it dies, but
>          * for shared pages it can stick around indefinitely and we'd count
>          * the page twice the entire time.
>          *
>          * Cgroup2 has separate resource counters for memory and swap,
>          * so this is a non-issue here. Memory and swap charge lifetimes
>          * correspond 1:1 to page and swap slot lifetimes: we charge the
>          * page to memory here, and uncharge swap when the slot is freed.
>          */
