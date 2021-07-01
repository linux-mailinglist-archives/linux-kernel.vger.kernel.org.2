Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5296C3B9563
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhGARYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGARYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:24:02 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DECC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 10:21:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a11so13095873lfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrOIndfEpXpDR3CulNU6X+syK13a8d1317xXG38sabs=;
        b=HNUrTS/dZWqH1ixKNyoQDUO9L+qqWbqqnPAlBx0DUx9rnz/OKZ0kzWWxZZ4TIsxq6q
         qLbiucXLKKN23yY8Xy8hbEYh/5ryRpX1gjuVfBmyiwlfMpvQa0t+sOtpiQLcobWzzX3u
         MOl7XLhioB5tLS5NaQ+6crCQVhswQGDhlCI2BnEtD6HvbacbW+Ubpsn2tV6dOLBcQkcR
         lAPM0Zn6wS4ozV/J3w8Tx7D8qVD+rLVbPtCDGgQyEHUykNY1IObma+/3UV13obAIHcWM
         OQLLhXEL9Qtyh+rmixWglh5M5vFLDtZNP/qbkbwpeTCxf8nmf+Z+7kCfHfF7jlkhhepk
         8DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrOIndfEpXpDR3CulNU6X+syK13a8d1317xXG38sabs=;
        b=dyAinLTl60PzIDdP/HLHja0TxottpnsGMkCoeu14ACsGTDDVKtBq4r1OMDgIQ0pG5r
         t2NUszPXI9/fWCYM3PlTKwgGyh/ImetCOnqnNY0lhHn5hDH6XwqAprEoBiQg/tQvNJNA
         nJvUdZBdyTgyLEga29TUnzGa32rPQQojd1djUBOwZwKDizr9ksrhuwytmE5UptSNL1m4
         RP6Cm2txyCQHONTbd0a7bs5qZQjs0dQ0OWo8o/UKbArbPvNfPMFaG/yxXyTCW9o1kOOq
         nb+BpwdgIG84hb9gPrGvqGCA/kxxG/CKsIfbmtPY3Ob+efIAPpIcvyKNv/tqzhg/hAyX
         vZ+Q==
X-Gm-Message-State: AOAM5332kw4Es8AIR1sH7wU1/hQWc6Yd3/zSTIvPgVtXb8gYIWc1V5wR
        PD/z/NFmWcrAnTrfKmhD10azZGn1pZxyWwcPk76Fdw==
X-Google-Smtp-Source: ABdhPJw642ItORxta0qayZ9gTVkoOup3jVT3SWO0EGctey8s13l7YdYikYe2Mz+wWHITZAuTtFGWczvjpyWoOnPJ9rI=
X-Received: by 2002:ac2:4949:: with SMTP id o9mr542805lfi.254.1625160090454;
 Thu, 01 Jul 2021 10:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210624111815.57937-1-odin@uged.al> <E16E71B3-E941-4522-AFF1-ABDF918FED19@linux.vnet.ibm.com>
 <20210701103448.GL3840@techsingularity.net> <CAFpoUr1mpErE1Soa05p36wL1uTeojQ2mqNLJ1GKVnpJ+x-3itw@mail.gmail.com>
 <C253482E-0B1E-4F38-92D6-6F00AFFA7DEF@linux.vnet.ibm.com>
In-Reply-To: <C253482E-0B1E-4F38-92D6-6F00AFFA7DEF@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 1 Jul 2021 19:21:18 +0200
Message-ID: <CAKfTPtBKt0Nrr79-v_HGvB-VRnsgntbX0hPx9rt_Ka_xt=RP9w@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
To:     Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc:     Odin Ugedal <odin@uged.al>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 at 13:51, Sachin Sant <sachinp@linux.vnet.ibm.com> wrote:
>
>
>
> > On 01-Jul-2021, at 4:39 PM, Odin Ugedal <odin@uged.al> wrote:
> >
> > tor. 1. jul. 2021 kl. 12:34 skrev Mel Gorman <mgorman@techsingularity.net>:
> >>
> >> What was HEAD when you checked this? 1c35b07e6d39 was merged in the
> >> 5.14-rc1 merge window so would not be in 5.13.
> >
> > From the kernel log it looks like he used commit dbe69e433722
> > (somewhere in Linus' tree), and that should include my patch. I don't
> > think the patches from Vincent in the previous thread have been posted
> > properly, and I think those can fix the edge case you are seeing.
> >
> Sorry about the confusion. Yes I am using this code level.
>
> commit dbe69e43372212527abf48609aba7fc39a6daa27 (HEAD -> master, origin/master, origin/HEAD)
> Merge: a6eaf3850cb1 b6df00789e28
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Wed Jun 30 15:51:09 2021 -0700
>
> This does contain the patch from Odin.
>
> > This should mitigate some issues:
> > https://lore.kernel.org/lkml/20210622143154.GA804@vingu-book/
> >
> > while
> > https://lore.kernel.org/lkml/20210623071935.GA29143@vingu-book/
> > might also help in some cases as well.
> >
> > Both of those are needed to make sure that *_avg is zero whenever *_sum is zero.
>
> Okay, so additional patches are required to fix this problem completely.
> I can help test these.

I just sent a clean version of the 1st patch :
https://lore.kernel.org/lkml/20210701171837.32156-1-vincent.guittot@linaro.org/

>
> Thanks
> -Sachin
>
