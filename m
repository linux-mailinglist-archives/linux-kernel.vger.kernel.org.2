Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823903B3D61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFYHch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFYHce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:32:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:30:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g192so7343933pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dk863fuzW21r4G77h5O77SvX4KOoOky/K7FqkqXXvqA=;
        b=P+hZ4H0VeB859TjMuIVl1zKuXnANOsqkQ+jKS7xhIpN7i4b0Eb5zgSUiqK8s82mHsc
         Dk6IjeAJemBp4GB/cZ+Hg62qc6XvUMp5iueM82lUygukZIVJjPkL+WDvrvDpbMtSzlGt
         gkaThWphg3pcmhDZ+DFvpu4IBoACoSOFULZmTLTeV/V2BrrCmMYdNagVd4DT4cbSCX/c
         M0/or4/1OaSJ9zrJilpLZuROTTV6m18Cp1O1Zvd576AsaI+bAiuLUcvHXwrig0trTXjV
         Q78rpBJyTLbo8r5AMKdWIrym0Nz9UI43nizDjm4yRdvCzERC4ISIG0EmDzcBHnyA1in5
         1BPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dk863fuzW21r4G77h5O77SvX4KOoOky/K7FqkqXXvqA=;
        b=JPNXLgByN8gJL7P7CUaJcL/JkOl3RcveBLNbn6rqzwk/lk6+aZHGeb7UytudiXV631
         vFper9xbl04GTuuIUHjMuwIFcW/tmXld6COU8Uoq1YG4kVq5oSUgryl5xlxuplkRJ/EW
         77Ty9D3iuXGVJYG3fcl343PglaGF2hMjsCE+QOQMH1WAzV+ViIlVvwRtXijeY2mNcrkt
         GNO3kW8w8+0Q2CYol1CdegywYC0y98vcGukYOpu4ya9GiaIoDi15MBqvk7K+aGyF/ZaH
         /5LbOLwDxws3zGFa8cLVdY/Z+uk7wQCBxrBG9rY8A4x2J7PR9elIPhiVGfYjffZsPn/y
         x++w==
X-Gm-Message-State: AOAM533TlxTXkr9yaSup6skywJi8602ieDMzCPFR/zkv9K1rm1zyjF3N
        lEh1tK1V/Gf2+dNSy2qata0hIVzhMBDOBuTZrzWdiA==
X-Google-Smtp-Source: ABdhPJwojrxOtYNSZ/h1aOkE1Huj/+abO15E/b7QA85zSXAzjcAkkCH60ACB4mUEEjEqbTh1wmgYQkcYr9+uWTYnxi4=
X-Received: by 2002:a65:63ce:: with SMTP id n14mr8327870pgv.273.1624606213877;
 Fri, 25 Jun 2021 00:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210624123930.1769093-1-linmiaohe@huawei.com>
 <20210624123930.1769093-3-linmiaohe@huawei.com> <CAMZfGtUNtR3ZPv4m5bBCGdE5GuMR5Bw18_n7YzqB4s6QHyV+Pg@mail.gmail.com>
 <1b38b33f-316e-1816-216f-9923f612ceb6@huawei.com>
In-Reply-To: <1b38b33f-316e-1816-216f-9923f612ceb6@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Jun 2021 15:29:37 +0800
Message-ID: <CAMZfGtXnYxumuNau2rvk+ivPEa-ows0KD4EWFBjCiM6e_iagtg@mail.gmail.com>
Subject: Re: [Phishing Risk] [External] [PATCH 2/3] mm/zsmalloc.c: combine two
 atomic ops in zs_pool_dec_isolated()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, ngupta@vflare.org,
        senozhatsky@chromium.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 2:32 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/6/25 13:01, Muchun Song wrote:
> > On Thu, Jun 24, 2021 at 8:40 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> atomic_long_dec_and_test() is equivalent to atomic_long_dec() and
> >> atomic_long_read() == 0. Use it to make code more succinct.
> >
> > Actually, they are not equal. atomic_long_dec_and_test implies a
> > full memory barrier around it but atomic_long_dec and atomic_long_read
> > don't.
> >
>
> Many thanks for comment. They are indeed not completely equal as you said.
> What I mean is they can do the same things we want in this specified context.
> Thanks again.

I don't think so. Using individual operations can eliminate memory barriers.
We will pay for the barrier if we use atomic_long_dec_and_test here.

>
> > That RMW operations that have a return value is equal to the following.
> >
> > smp_mb__before_atomic()
> > non-RMW operations or RMW operations that have no return value
> > smp_mb__after_atomic()
> >
> > Thanks.
> >
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/zsmalloc.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> >> index 1476289b619f..0b4b23740d78 100644
> >> --- a/mm/zsmalloc.c
> >> +++ b/mm/zsmalloc.c
> >> @@ -1828,13 +1828,12 @@ static void putback_zspage_deferred(struct zs_pool *pool,
> >>  static inline void zs_pool_dec_isolated(struct zs_pool *pool)
> >>  {
> >>         VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
> >> -       atomic_long_dec(&pool->isolated_pages);
> >>         /*
> >>          * There's no possibility of racing, since wait_for_isolated_drain()
> >>          * checks the isolated count under &class->lock after enqueuing
> >>          * on migration_wait.
> >>          */
> >> -       if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
> >> +       if (atomic_long_dec_and_test(&pool->isolated_pages) && pool->destroying)
> >>                 wake_up_all(&pool->migration_wait);
> >>  }
> >>
> >> --
> >> 2.23.0
> >>
> > .
> >
>
