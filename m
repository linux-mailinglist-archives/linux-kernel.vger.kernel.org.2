Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E234342CF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJMXrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMXrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:47:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30926C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:45:49 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i24so18386750lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIPgO8yQiZn6tL7PQw0ynB/vmiHfdbnsw7Yxik4Gs5c=;
        b=Zo/oxYeUHUiu5epy5RMTUChC69BfvR/wzXIz5N5eUMfhimDPUDYzklPhtmFozV4kR2
         nql9Z92aM87i6pjK6Xmv7cDjU1nKQ8VNvISZjUcdFcl7sX54/5sivvQJF0112hHD5cAu
         6FSMFfQxpW8Bhe8w72Ns8DjQaO2vBG6jBTMjYQV4l81pQMst03i4Drd2f9IF2na682+u
         HpGrHoNfUa0Gg0sRUqFJbuOs+PoVDiErmce946h8Kc/RfXxI9lviBiTCLqjrAlsVcFt2
         tYwVoR5zv7LJqtTFU0rkKAiE4bscZAQWKs3CO77dpKj2PYCI1awVeJ1tAWTq6ZcVwPKh
         tq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIPgO8yQiZn6tL7PQw0ynB/vmiHfdbnsw7Yxik4Gs5c=;
        b=ILy8rP1w232C+5uyE2lyF32RT6X1YZx1uk0X89EUwSHDLfudmCRhVljAYSnXI7M0dm
         9EwS4uwb8AYQkmdCCuSO7EbnhKpe7e3uBjKs/AGKJNvgcyRsez2xhXrzQxSONfvmc2OF
         Tc7wHYcOYU/LyQXv0qMZomCrCzhQEExeiZySae3OR5Ip2Xd/+ogMML6rEQ6FUUS3E5XY
         22JXEsvKUfgTz7eNA/Ad+BG2HZKlJYhrEvtvlXWaJEEcvZAkyvJhPv3gXH6VW7NtOKVE
         iMSTtm4pvTvgV/Lj6OdBQSWO0q/udVlHqbCg7qYk5l7z3S4hndiP9/gwVeQeQpzKR6GR
         xhoA==
X-Gm-Message-State: AOAM5308TEYO8iyu+syBrjcX9IYRgR55R5U3drQQEZttLICjFW8d8MhD
        HIVeENewfqyTiUesJgZgxSD2AGSqTyEFKFLwJ4S/FA==
X-Google-Smtp-Source: ABdhPJyDl1zBaewozzQDXu7rBd1rwYDCVVOiWOdbVlTGe18dat8YOQKe98Nhwh+PQ2I1FOPDIsFZfw1RoMqyaWqm+x0=
X-Received: by 2002:a05:6512:131b:: with SMTP id x27mr1851832lfu.210.1634168747346;
 Wed, 13 Oct 2021 16:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211013194338.1804247-1-shakeelb@google.com> <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
 <CALvZod6ZppPNk2XfvKFfdPhrsSF6NbSBKrOOOc6UyJMfDEfKoQ@mail.gmail.com> <YWdoj9FZy2B4oLj8@carbon.DHCP.thefacebook.com>
In-Reply-To: <YWdoj9FZy2B4oLj8@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 16:45:35 -0700
Message-ID: <CALvZod7oYyGvHAQVO5fg5eCJefeU1J70iUS6-9k0gQ2S8-y7NQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 4:15 PM Roman Gushchin <guro@fb.com> wrote:
>
[...]
> > >
> > > Isn't it a bit too aggressive?
> > >
> > > How about
> > >     if (WARN_ON_ONCE(gfp & __GFP_ACCOUNT))
> >
> > We actually know that kvmalloc(__GFP_ACCOUNT) users exist and can
> > trigger bulk page allocator through vmalloc, so I don't think the
> > warning would be any helpful.
> >
> > >        gfp &= ~__GFP_ACCOUNT;
> >
> > Bulk allocator is best effort, so callers have adequate fallbacks.
> > Transparently disabling accounting would be unexpected.
>
> I see...
>
> Shouldn't we then move this check to an upper level?
>
> E.g.:
>
> if (!(gfp & __GFP_ACCOUNT))
>    call_into_bulk_allocator();
> else
>    call_into_per_page_allocator();
>

If we add this check in the upper level (e.g. in vm_area_alloc_pages()
) then I think we would need WARN_ON_ONCE(gfp & __GFP_ACCOUNT) in the
bulk allocator to detect future users.

At the moment I am more inclined towards this patch's approach. Let's
say in future we find there is a __GFP_ACCOUNT allocation which can
benefit from bulk allocator and we decide to add such support in bulk
allocator then we would not need to change the bulk allocator callers
at that time just the bulk allocator.
