Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CDB35AAE3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 06:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhDJEeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 00:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhDJEeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 00:34:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34EBC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 21:34:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso4211654pje.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FW1Qa2Pww1tEjlyfwRyqPFS3bdetO5szAzOdgn/LNKs=;
        b=cPT5KTO9NK/LC19lH63RuMviNJtAyfY2N86QrNDR6sKsVMNLfz4RWwozZ6wBTf1uc0
         PRrrhpXOE0i2ImCkMGKX9VoGtfJZs5F32WcMM3Y4TDwY67/S6Mqxs+TmYV2UnND8Hmj2
         cHU9x5fbtVUfMpMfZWUN29VV9o0EQi3Yy+iSd7g3e7rm0c3/3agO37V2z5PiOOyt5Ddo
         IRnmSsbCMtvsOdmdVs7gQf9XHa1wtA2j6rOQ8X7h1NsocjgF0R6MphRgx9oE9XMBW9J+
         AUYGMF6wjdrD0dJGWf6Rc2faxdRoYmXDr0Tvv/g2C4uCBbskRZE8IuEcB2x4SlUl74iI
         oblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FW1Qa2Pww1tEjlyfwRyqPFS3bdetO5szAzOdgn/LNKs=;
        b=Vn6L/zPHZVwQzmSHcLPyjZC+BtByHjSIpJgHowfgJYNLlo3yT81LxC00axiHepnB3C
         Ymt9yvV56o5/na8tfD7jIN0J+SLtdoXqN+EhLohNYGiLVglsYstfP9vR3enCXwc8Kgpw
         QTQLi3Qb4LdAR4BzTmN1wkRxNI07imspOB70vyaysVkGeo1QMawhEj28MbFx62xDUuMp
         0Jnw8x2YTL9I85hVV/LyA0prUDlHwS9L0H6/9TPpyGx8ZkNbUKOSLfGPxDW5fSZdjgII
         ORv5uFuZC8ut3KKI0IxPZUZ3yhukLnt75mlBXYm6Ti9QvHPB8+Lgd926SvOeRhTSC7hR
         7nNg==
X-Gm-Message-State: AOAM530zc7W2OpjpZLA983SOSRXKyKVhEb6E3wLzYpOMJ4MVLdENDPoK
        e4CGq2Ed2wIxNfOpVj1bcmPkud7h39nbrsl4Ay2uBg==
X-Google-Smtp-Source: ABdhPJxZhzgitiiSg64+M/hoJTMFSjRogSq/t3z8Bht8t1xPnJcWBgx28PAULBfXXSYhJbGHyiLHH4BDecMclMAyCjY=
X-Received: by 2002:a17:902:8308:b029:e9:d69:a2f with SMTP id
 bd8-20020a1709028308b02900e90d690a2fmr15961107plb.20.1618029242417; Fri, 09
 Apr 2021 21:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-10-songmuchun@bytedance.com> <YHCdjgaB8IjOMq4z@cmpxchg.org>
In-Reply-To: <YHCdjgaB8IjOMq4z@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 10 Apr 2021 12:33:26 +0800
Message-ID: <CAMZfGtUMgSu8hw2UdxJPzXCXTXvC3Z=av2B2tqrJ4oTT11JgYw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 09/18] mm: vmscan: remove noinline_for_stack
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 2:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Apr 09, 2021 at 08:29:50PM +0800, Muchun Song wrote:
> > The noinline_for_stack is introduced by commit 666356297ec4 ("vmscan:
> > set up pagevec as late as possible in shrink_inactive_list()"), its
> > purpose is to delay the allocation of pagevec as late as possible to
> > save stack memory. But the commit 2bcf88796381 ("mm: take pagevecs off
> > reclaim stack") replace pagevecs by lists of pages_to_free. So we do
> > not need noinline_for_stack, just remove it (let the compiler decide
> > whether to inline).
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Good catch.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Since this patch is somewhat independent of the rest of the series,
> you may want to put it in the very beginning, or even submit it
> separately, to keep the main series as compact as possible. Reviewers
> can be more hesitant to get involved with larger series ;)

OK. I will gather all the cleanup patches into a separate series.
Thanks for your suggestion.
