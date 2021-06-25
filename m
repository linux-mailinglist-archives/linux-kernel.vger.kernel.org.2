Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC63B41DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFYKnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFYKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:43:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A644C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:41:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 21so7723875pfp.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHJbYA6bbS+Rn1vMcZPcer89nM3y6eLuvzQ4DpVNe4g=;
        b=DbOMbmrTXCIGPSyTPRlDQ2Gt4wxvzQ+PuqZoZ3l24O2N+LCxnScqPt/uqSTF4pE1KC
         Bb4Zr/TwkdJL/G2vjrZhJWKAinpmz1Tjo0UwkKEfyiZ0cEGtf9Cj2LURFUi0Hr3Xbfqv
         +T/hezLmZ5GFlq2Hu8nmoyKsaNx1+MOTEt0D0S6td0XqTuO3wQjBPER8JyJb/EujFrWN
         pdI5Q7TwWRIf5k9kN64WRgTbHXx/BdMXJVDX3FS6eE+f97rq5yAyYcB9KC9Ha6QGWPc0
         wpz0fa8WbWHXG26tNmbDi/D8ztAXaJFhgXacuN++7hwWwjtTh/efYf76NssAiZR0CO6i
         MKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHJbYA6bbS+Rn1vMcZPcer89nM3y6eLuvzQ4DpVNe4g=;
        b=SU6OJCa7NZJunf6ASw4od9uY2/bcsn3QC3o8c0ZbjxJhEefLSxrJinVob+Ptld9Hcf
         SfQ8vJ40BK9FmP09t1c4KPbRJr+46vazfZFrv0fokr5e9gro2292O1nhyzEjjxLYJZTv
         zUoi88oUmHYQRqxesG56I0QvXyjj60HzD8mGcMb08DF2Q35x7NmDCxiGJKLahU2/pNIT
         eQ6G/kU+Euo5+2bMv0+mFQiTdqwpo3BgBR5YOgolg6Rg0GfgoiavSyP4ZUAfnuEyzqxz
         WslN5PrZcT7g/12u0Y7qrTw+0Y8V2dlYARM0ayNE+owLgXvfCLH4dyR87dC7kdba5hMx
         pE2g==
X-Gm-Message-State: AOAM532Sv8RlLsWDjCAQt1u9Xs4nCsJqA+762i4tsxGVJG8A/4pYrWyA
        /fWzIxgtmNr31s8CPIo7LmptgXmvcwlqUd7uA6iIXw==
X-Google-Smtp-Source: ABdhPJzNFdimxcH+hedzqw2q/ehH4P2k1STjQ7cFSMt7KGDcDuAx8yYqyWBJx4FP/SSvlHfuSow3ThQjEVe5500M7jM=
X-Received: by 2002:a05:6a00:2162:b029:308:9346:2f55 with SMTP id
 r2-20020a056a002162b029030893462f55mr6289438pff.49.1624617668717; Fri, 25 Jun
 2021 03:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210624123930.1769093-1-linmiaohe@huawei.com>
 <20210624123930.1769093-3-linmiaohe@huawei.com> <CAMZfGtUNtR3ZPv4m5bBCGdE5GuMR5Bw18_n7YzqB4s6QHyV+Pg@mail.gmail.com>
 <1b38b33f-316e-1816-216f-9923f612ceb6@huawei.com> <CAMZfGtXnYxumuNau2rvk+ivPEa-ows0KD4EWFBjCiM6e_iagtg@mail.gmail.com>
 <01117bc0-53b1-d81a-a4d8-2a1dbe5dcd94@huawei.com> <97fdc2f3-6757-7ca1-6323-02b618b85894@huawei.com>
In-Reply-To: <97fdc2f3-6757-7ca1-6323-02b618b85894@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 25 Jun 2021 18:40:30 +0800
Message-ID: <CAMZfGtUq72KULin=9onhf=7o5XwzR79E7QBdgg+ny1gYQGRvzw@mail.gmail.com>
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

On Fri, Jun 25, 2021 at 5:32 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/6/25 16:46, Miaohe Lin wrote:
> > On 2021/6/25 15:29, Muchun Song wrote:
> >> On Fri, Jun 25, 2021 at 2:32 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>>
> >>> On 2021/6/25 13:01, Muchun Song wrote:
> >>>> On Thu, Jun 24, 2021 at 8:40 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>>>>
> >>>>> atomic_long_dec_and_test() is equivalent to atomic_long_dec() and
> >>>>> atomic_long_read() == 0. Use it to make code more succinct.
> >>>>
> >>>> Actually, they are not equal. atomic_long_dec_and_test implies a
> >>>> full memory barrier around it but atomic_long_dec and atomic_long_read
> >>>> don't.
> >>>>
> >>>
> >>> Many thanks for comment. They are indeed not completely equal as you said.
> >>> What I mean is they can do the same things we want in this specified context.
> >>> Thanks again.
> >>
> >> I don't think so. Using individual operations can eliminate memory barriers.
> >> We will pay for the barrier if we use atomic_long_dec_and_test here.
> >
> > The combination of atomic_long_dec and atomic_long_read usecase is rare and looks somehow
> > weird. I think it's worth to do this with the cost of barrier.
> >
>
> It seems there is race between zs_pool_dec_isolated and zs_unregister_migration if pool->destroying
> is reordered before the atomic_long_dec and atomic_long_read ops. So this memory barrier is necessary:
>
> zs_pool_dec_isolated                            zs_unregister_migration
>   pool->destroying != true
>                                                   pool->destroying = true;
>                                                   smp_mb();
>                                                   wait_for_isolated_drain
>                                                     wait_event with atomic_long_read(&pool->isolated_pages) != 0
>   atomic_long_dec(&pool->isolated_pages);
>   atomic_long_read(&pool->isolated_pages) == 0

I am not familiar with zsmalloc. So I do not know whether the race
that you mentioned above exists. But If it exists, the fix also does
not make sense to me. If there should be inserted a smp_mb between
atomic_long_dec and atomic_long_read, you should insert
smp_mb__after_atomic instead of using atomic_long_dec_and_test.
Because smp_mb__after_atomic can be optimized on certain architecture
(e.g. x86_64).

Thanks.

>
> Thus wake_up_all is missed.
> And the comment in zs_pool_dec_isolated() said:
> /*
>  * There's no possibility of racing, since wait_for_isolated_drain()
>  * checks the isolated count under &class->lock after enqueuing
>  * on migration_wait.
>  */
>
> But I found &class->lock is indeed not acquired for wait_for_isolated_drain(). So I think the above race
> is possible. Does this make senses for you ?
> Thanks.
>
> >>
> >>>
> >>>> That RMW operations that have a return value is equal to the following.
> >>>>
> >>>> smp_mb__before_atomic()
> >>>> non-RMW operations or RMW operations that have no return value
> >>>> smp_mb__after_atomic()
> >>>>
> >>>> Thanks.
> >>>>
> >>>>>
> >>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >>>>> ---
> >>>>>  mm/zsmalloc.c | 3 +--
> >>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> >>>>> index 1476289b619f..0b4b23740d78 100644
> >>>>> --- a/mm/zsmalloc.c
> >>>>> +++ b/mm/zsmalloc.c
> >>>>> @@ -1828,13 +1828,12 @@ static void putback_zspage_deferred(struct zs_pool *pool,
> >>>>>  static inline void zs_pool_dec_isolated(struct zs_pool *pool)
> >>>>>  {
> >>>>>         VM_BUG_ON(atomic_long_read(&pool->isolated_pages) <= 0);
> >>>>> -       atomic_long_dec(&pool->isolated_pages);
> >>>>>         /*
> >>>>>          * There's no possibility of racing, since wait_for_isolated_drain()
> >>>>>          * checks the isolated count under &class->lock after enqueuing
> >>>>>          * on migration_wait.
> >>>>>          */
> >>>>> -       if (atomic_long_read(&pool->isolated_pages) == 0 && pool->destroying)
> >>>>> +       if (atomic_long_dec_and_test(&pool->isolated_pages) && pool->destroying)
> >>>>>                 wake_up_all(&pool->migration_wait);
> >>>>>  }
> >>>>>
> >>>>> --
> >>>>> 2.23.0
> >>>>>
> >>>> .
> >>>>
> >>>
> >> .
> >>
> >
>
