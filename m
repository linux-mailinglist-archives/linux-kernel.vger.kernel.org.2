Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD342C68F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhJMQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJMQnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 12:43:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55CC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:41:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j21so14854430lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPgT6NXkn4m3r7Gqf6Xmq+r6xoZWYcfKJwECpES7gkc=;
        b=j68WJ+Mb8FMm8l4fHho6NGTbOMBz8V0Esm2L6IrXhNA4GrhqPjtC5bpmOiBZd6f/SJ
         hVygO36l2sFF8R34+9Q8XkwmIi0piebgNava8RuVeQwHa6bCvsGFsLpTEmNn7aHZX3wI
         eyD+/2xd6PmgZZLbIh2rCbvv2q/TsOiRUsaa25+sW5t+RjDNFiFduRI4g4CO/4XbeHrm
         PB31+y8sTL3/fi58B0snsJWsdDDf4qlvvs5PshkrUWq2pk64SvvtcNLGNa6x+QHh83od
         GFap54IAUwgcHkV6ZdM6uPMGnIiXsZa67MZH0t1OysgFihi8CYe/q7+/lvQ58teM0na0
         cgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPgT6NXkn4m3r7Gqf6Xmq+r6xoZWYcfKJwECpES7gkc=;
        b=xO5mdRl7aGoV0RGNvXHH/Eq6f6b81FpMR0fLPKWMrjXiCA7C23Qd9VdXFD6RQpfeoc
         w5YD6O9oQddwUkjlWCy+eU/qCQqiIzH33qeh/zl1+yfkJdKm6+cDzj8w7b0sUo8nzTM0
         GF18kBTQSwoMruI7Rhw8+WOzWJqnzccQ+BvqcwzRxCi2tT9OOFfyFL39qBBIBjThNil2
         0sS2Ti5UuXlyuT7+SwK4t+QxDUnZfAf+pR97MfqWWn7UAes8MneTsxuhoZ35/nBNd2Jg
         ta5ZXIpCFfO9mafeXT0uET46rcWIxQl7PBFlC8IykLGvYk8pBeIoEmLcRaI82BvRUqYX
         KJCw==
X-Gm-Message-State: AOAM532GJVsZqaff7DigiyfLhXfU9pOKtmJVcnN44kEp6DuVZNyXuhi/
        u0I01tZwCMZ5v8F6bNFiOVLgZZxgQwZH4OrvwhktxA==
X-Google-Smtp-Source: ABdhPJxQ7dROOW3GwYwJZv5cEP72W9nSPXf3G+FjF80FpcnyLSbosTXFRKMtNJ72yGKJsFPgIFJuaApet6UQxb5ou5s=
X-Received: by 2002:ac2:4e02:: with SMTP id e2mr113350lfr.264.1634143286611;
 Wed, 13 Oct 2021 09:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com> <YWWrai/ChIgycgCo@dhcp22.suse.cz>
 <CALvZod7LpEY98r=pD-k=WbOT-z=Ux16Mfmv3s7PDtJg6=ZStgw@mail.gmail.com> <YWXS09ZBhZSy6FQQ@dhcp22.suse.cz>
In-Reply-To: <YWXS09ZBhZSy6FQQ@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 09:41:15 -0700
Message-ID: <CALvZod6K6UXxDrkHp=mVDV7O-fAtmRkgMDngPazBhcyDUNxy_Q@mail.gmail.com>
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in __alloc_pages_bulk
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:24 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-10-21 09:08:38, Shakeel Butt wrote:
> > On Tue, Oct 12, 2021 at 8:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 12-10-21 17:58:21, Vasily Averin wrote:
> > > > Enable memory accounting for bulk page allocator.
> > >
> > > ENOCHANGELOG
> > >
> > > And I have to say I am not very happy about the solution. It adds a very
> > > tricky code where it splits different charging steps apart.
> > >
> > > Would it be just too inefficient to charge page-by-page once all pages
> > > are already taken away from the pcp lists? This bulk should be small so
> > > this shouldn't really cause massive problems. I mean something like
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index b37435c274cf..8bcd69195ef5 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5308,6 +5308,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> > >
> > >         local_unlock_irqrestore(&pagesets.lock, flags);
> > >
> > > +       if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) {
> > > +               /* charge pages here */
> > > +       }
> >
> > It is not that simple because __alloc_pages_bulk only allocate pages
> > for empty slots in the page_array provided by the caller.
> >
> > The failure handling for post charging would be more complicated.
>
> If this is really that complicated (I haven't tried) then it would be
> much more simple to completely skip the bulk allocator for __GFP_ACCOUNT
> rather than add a tricky code. The bulk allocator is meant to be used
> for ultra hot paths and memcg charging along with the reclaim doesn't
> really fit into that model anyway. Or are there any actual users who
> really need bulk allocator optimization and also need memcg accounting?

Bulk allocator is being used for vmalloc and we have several
kvmalloc() with __GFP_ACCOUNT allocations.

It seems like Vasily has some ideas, so let's wait for his next version.
