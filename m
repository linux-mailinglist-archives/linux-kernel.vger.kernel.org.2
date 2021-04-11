Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20B935B1D6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 07:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhDKFiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 01:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhDKFiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 01:38:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F31FC06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 22:38:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d8so4650716plh.11
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 22:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgAD+2Nb2JOJjFZwnbACnpjZOW/zFycvAp8/3df7DPY=;
        b=cuz0Au2QXG8fhErH3AfTOSYHsD+gIFbdCcOB0h574oKDLmARFTvqPTGBVpUX0IcvrQ
         g7wQmLffrnYVoGggC+OGhNkRcfTkm1cWqfQ6Mem5qAtMU8jBl0L5pSSW7dWKTcaI0jUd
         8tNiE0m/SQU3IzslT7sYKtBHVh5zAVAJQQ8Af/ggHKKSB9WPbd9XudD+MOxbeyDo/ZET
         90c+PoH/UmZVXgT3xV6fXJZmoUbyT5/C1Y2+unLAmGmk+uefwdtz7t4a5ESbDkgbx6cO
         I13sXTf2NIAkIRqCmhcRt+EBtnAuuNGKs8d4XUvZIFCOTBZaRkqwOesAWwx9x+T7MuUf
         HAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgAD+2Nb2JOJjFZwnbACnpjZOW/zFycvAp8/3df7DPY=;
        b=RCivvMbhwOncKw2hup1rqsE4SlTY2tus0uWM6YqBaHpMbm5lYGepKb7B4QcXuCxByc
         5wdhOpewGqIRRdBSxhxcNsFNe2IqgUsW+R8Bw9XViy8YdDp2ZDwAmIgAQ83rDEbWZQbo
         BgF6+Tm+G46KqvNTlrPIk/09BREUU5WDfJI3iAV8JD/i4Z77bEJi6Y7yrgC6LCC+lY5D
         EdeMsGBahpsf6E3heTeokBaS9G8xusFTj5g+JzJTFENaUDLHKRQSXTlskXeXcSN2IKEE
         Hj7aH7giXvKy8/hTXkK7QJ/TXJ/EDO5/7nB9gNSoRpkFgG9uWDbtmTwIFck5LZfPMwmN
         IlLQ==
X-Gm-Message-State: AOAM531sbu9b+YL9qN+4mUNRv9ejFZzpx2uYuhJO7HUiwwKjfN386fpE
        aXPrLtiKN4A/ngp9ERHvloGTN2sNuVsqGOQu3SzQYQ==
X-Google-Smtp-Source: ABdhPJwOLfxJ2QLvRIEhyvQbdZZ1zjB0OonB//U83Y9DhfQj6Dfxj+tt9z6tMR6zZtWkckfVgRJmL+Cc6Q2km5cTFN0=
X-Received: by 2002:a17:90a:a895:: with SMTP id h21mr12221893pjq.13.1618119483172;
 Sat, 10 Apr 2021 22:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-5-songmuchun@bytedance.com> <YHB6FQ40Xn9E4psq@cmpxchg.org>
In-Reply-To: <YHB6FQ40Xn9E4psq@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 11 Apr 2021 13:37:26 +0800
Message-ID: <CAMZfGtVnmcuVqqg13pkL=72YwuyjVZDNE81-_d7S61e4a1kXGQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 04/18] mm: memcontrol: simplify lruvec_holds_page_lru_lock
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

On Sat, Apr 10, 2021 at 12:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Apr 09, 2021 at 08:29:45PM +0800, Muchun Song wrote:
> > We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> > do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> > lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> > page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> > of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> > to simplify the code. We can have a single definition for this function
> > that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> > CONFIG_MEMCG.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Looks good to me.
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for your review.

>
> If you haven't done so yet, please make sure to explicitly test with
> all three config combinations, just because the dummy abstractions for
> memcg disabled or compiled out tend to be paper thin and don't always
> behave the way you might expect when you do more complicated things.

I have tested. There is no problem. Thanks :-)


>
> Something like
>
> boot
> echo sparsefile >/dev/null (> ram size to fill memory and reclaim)
> echo 1 >/proc/sys/vm/compact_memory
>
> should exercise this new function in a couple of important scenarios.
