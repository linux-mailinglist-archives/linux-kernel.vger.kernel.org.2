Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483F35AF63
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhDJRsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJRso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:48:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F60FC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:48:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u4so10246691ljo.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFoH6NSNyfcllxZN9x7T5g5NvAfI0hR11J01wzi+Rak=;
        b=emMH1QS+ntGVOEoQCjkRSaiVYfOIXxsZAVWPA2MGa6XMik3AdWgQe0SryVA+QHUPzp
         XOvi4etlW95I/m9i34aOYC4SMQsb5KTxp6WCbSId/48q0S9g8FzTlEc8njKoIZdLihmE
         iZT6H5AZ/gyN0aVdSsYbUXFyrdNEprEAj0KT6RE/aoSZHVzhKSEVLzGirP9vQAb8HdQC
         OpyC4JlAqWTCaW+dnXwU2pXLMzLxZakFewNyqPnwe/9/yRqmzjzsXyL9Xw9IuHediXVg
         oiXZeX4mcb8DiaMAxUhWTxbFh2UCVWbuzwVhD+5Y+XC62vsTXf7VMEnW4uMb7CKr3Cvy
         IPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFoH6NSNyfcllxZN9x7T5g5NvAfI0hR11J01wzi+Rak=;
        b=BbuZs9BJE2oSKkZ4hlu1o0VefQ7+CDhYTry5KTRMBxw54nUaYoulqYGPqvkW6IPJfO
         stIrjZS4uMk1VLWzmkl3Kn+uAuN2yZMTifMPOpYPVTP0M2kFbViE+uU8lOmmDquXVDLE
         sKooM1TP4ZhgU3nRKi/+QOSKJbmSaCFNGzL9DtOxynHNX1PzDPrvcXlbLCInWe0k4REN
         /3dJEAHL1lUzkEBBDeiyCHqyhyHBcOzU+5lxDKkN/XYbwNnAZyXWALpqvWf1lXrwFdxp
         1hw01yVDzOUJ4+kWrgPOuXIQm1M9XAWzgDy9yAdBHvnJtPgPGDTviZB2L89KYLJDbccI
         rS3g==
X-Gm-Message-State: AOAM531cLPzReqIyuDVl00IHTxH6CBSA1u6WczthaDgkuF7ApTjSNvy1
        ApJ3FyxqYVQUfg0HS4bLkQlOL1pPhFx8yb1LCk+otw==
X-Google-Smtp-Source: ABdhPJxLufwnOXy37cZiWyWJfbYB1vHp9t55UdLiNPCWj3YOOiYNs7H1qWVwplBjsckKTMcCAbHkDXvZ4TD6kqJWtDs=
X-Received: by 2002:a05:651c:1248:: with SMTP id h8mr613628ljh.160.1618076908037;
 Sat, 10 Apr 2021 10:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-10-songmuchun@bytedance.com> <YHCdjgaB8IjOMq4z@cmpxchg.org>
 <CAMZfGtUMgSu8hw2UdxJPzXCXTXvC3Z=av2B2tqrJ4oTT11JgYw@mail.gmail.com>
In-Reply-To: <CAMZfGtUMgSu8hw2UdxJPzXCXTXvC3Z=av2B2tqrJ4oTT11JgYw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 10 Apr 2021 10:48:15 -0700
Message-ID: <CALvZod77DBJTDCjE0ZYYno3Q-jWvo5VLOa-0=g9N7tXPcx=_Uw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 09/18] mm: vmscan: remove noinline_for_stack
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Balbir Singh <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 9:34 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Sat, Apr 10, 2021 at 2:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, Apr 09, 2021 at 08:29:50PM +0800, Muchun Song wrote:
> > > The noinline_for_stack is introduced by commit 666356297ec4 ("vmscan:
> > > set up pagevec as late as possible in shrink_inactive_list()"), its
> > > purpose is to delay the allocation of pagevec as late as possible to
> > > save stack memory. But the commit 2bcf88796381 ("mm: take pagevecs off
> > > reclaim stack") replace pagevecs by lists of pages_to_free. So we do
> > > not need noinline_for_stack, just remove it (let the compiler decide
> > > whether to inline).
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Good catch.
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Since this patch is somewhat independent of the rest of the series,
> > you may want to put it in the very beginning, or even submit it
> > separately, to keep the main series as compact as possible. Reviewers
> > can be more hesitant to get involved with larger series ;)
>
> OK. I will gather all the cleanup patches into a separate series.
> Thanks for your suggestion.

That would be best.

For this patch:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
