Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E363D41961A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhI0OUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhI0OUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:20:49 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:19:12 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id h2so24356621ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 07:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQEMNeRv4mBdT9ho0m3aUfzNGnkBbJuUqVubKyrhDGE=;
        b=QYVAtmCjh9RKFsdWBSe7Aux5RIdioHmyMPy6oK/rHS8PNOnJnmNG/T/C4FG+4cuacu
         Ukdjsst/QUfbjDv79Dgx0Mp3xTmR3Z+xSFKFQSAUuJFzowkDtcf3O05ht1phHO7wjMc/
         hDXQe9zJDD3jXcNtn2ukT+Mubx7m5DIXI3U2m/gdzTH0rBQ0WXA7z1dpm5GQc2qV+RLK
         VsVmK55E/gI48kzIcQcd48tmnPa/j8k+MI0yWyPZGcNIyL0j+QPELAHf0yxJsAMGvMre
         utCH/YEidtYFG158oVAbifXUFEy5FI4yrkPHlBRggWOZAu7qyP21KRifL2DkW99JK8GH
         vbkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQEMNeRv4mBdT9ho0m3aUfzNGnkBbJuUqVubKyrhDGE=;
        b=l9T1v2qPt3oeQuFhq546RJXxM1NonlipK0tv0ZIiaEZyR/Ym/Ne1c6mvXsibeFm1QZ
         WxrJNB7fNn9S7UOMjZaIJ73HWPhJturYjIEFVJ+Rqwt25PJufLRMP0UxahjMw884oZCP
         t6Cp3ptadhm9FcMlyNKtYsUu3ciUH4/D/6uM3yQs5S4p7TKoZH0N7hcKUz6h6srY4v7L
         gIN3gqcJI+Qw8Ngizgijq5DnKR8bKrvSICGuUIvDN4yEnsSulpSK8Ju4eNJdYNTeXYeW
         h4xob4zXA7F4GnLfQA5KEiQnXmdFxv4c0i8E2x/biuhJQmSU6Urvusl20pkgTmQjkFZ8
         GR0g==
X-Gm-Message-State: AOAM530hfYRwDh9X1qCCF9B05vJ/BIOxud6OAmHUv8d9UDDhtnui35YW
        RXyWCZZtGm7BtnP6BH0axftM0aUtgOqsP4Ejbx4mb/fG29QteA==
X-Google-Smtp-Source: ABdhPJxUbO4VaLnAWw2JrePoQUQWKhYmatpI3o3peypDKmt+bc5Ako0RfT1GpAfS1qkPtN4pdBLw7jwNzpCW3BcN/cE=
X-Received: by 2002:a25:3248:: with SMTP id y69mr80656yby.402.1632752351212;
 Mon, 27 Sep 2021 07:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210922132002.GX3959@techsingularity.net> <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net> <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net> <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de> <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de> <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
 <20210927111730.GG3959@techsingularity.net>
In-Reply-To: <20210927111730.GG3959@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Sep 2021 16:19:00 +0200
Message-ID: <CAKfTPtDETjTEno8XURNVqzkqOONuAYRnhvNXmHzC7Hc_crwA_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to nr_running
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sept 2021 at 13:17, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Sep 23, 2021 at 02:41:06PM +0200, Vincent Guittot wrote:
> > On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
> > >
> > > On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> > > >
> > > > a 100us value should even be enough to fix Mel's problem without
> > > > impacting common wakeup preemption cases.
> > >
> > > It'd be nice if it turn out to be something that simple, but color me
> > > skeptical.  I've tried various preemption throttling schemes, and while
> >
> > Let's see what the results will show. I tend to agree that this will
> > not be enough to cover all use cases and I don't see any other way to
> > cover all cases than getting some inputs from the threads about their
> > latency fairness which bring us back to some kind of latency niceness
> > value
> >
>
> Unfortunately, I didn't get a complete set of results but enough to work
> with. The missing tests have been requeued. The figures below are based
> on a single-socket Skylake machine with 8 CPUs as it had the most set of
> results and is the basic case.
>
> The reported kernels are
>
> vanilla:                        vanilla 5.15-rc1
> sched-scalewakegran-v2r4:       My patch
> sched-moveforward-v1r1:         Vincent's patch

I imagine that this is the results for the 1st version which scales
with the number of CPUs


>
>
>
> hackbench-process-pipes
>                           5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
>                              vanilla sched-scalewakegran-v2r4 sched-moveforward-v1r1
> Amean     1        0.3253 (   0.00%)      0.3330 (  -2.36%)      0.3257 (  -0.10%)
> Amean     4        0.8300 (   0.00%)      0.7570 (   8.80%)      0.7560 (   8.92%)
> Amean     7        1.1003 (   0.00%)      1.1457 *  -4.12%*      1.1163 (  -1.45%)
> Amean     12       1.7263 (   0.00%)      1.6393 *   5.04%*      1.5963 *   7.53%*
> Amean     21       3.0063 (   0.00%)      2.6590 *  11.55%*      2.4487 *  18.55%*
> Amean     30       4.2323 (   0.00%)      3.5657 *  15.75%*      3.3410 *  21.06%*
> Amean     48       6.5657 (   0.00%)      5.4180 *  17.48%*      5.0857 *  22.54%*
> Amean     79      10.4867 (   0.00%)      8.4357 *  19.56%*      7.9563 *  24.13%*
> Amean     110     14.8880 (   0.00%)     11.0423 *  25.83%*     10.7407 *  27.86%*
> Amean     141     19.2083 (   0.00%)     14.0820 *  26.69%*     13.3780 *  30.35%*
> Amean     172     23.4847 (   0.00%)     16.9880 *  27.66%*     16.4293 *  30.04%*
> Amean     203     27.3763 (   0.00%)     20.2480 *  26.04%*     19.6430 *  28.25%*
> Amean     234     31.3707 (   0.00%)     23.2477 *  25.89%*     22.8287 *  27.23%*
> Amean     265     35.4663 (   0.00%)     26.2483 *  25.99%*     25.8683 *  27.06%*
> Amean     296     39.2380 (   0.00%)     29.4237 *  25.01%*     28.8727 *  26.42%*
>
> For hackbench, either Vincent or my patch has a similar impact.
>
> tbench4
>                          5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
>                             vanillasched-scalewakegran-v2r4 sched-moveforward-v1r1
> Hmean     1       598.71 (   0.00%)      608.31 *   1.60%*      586.05 *  -2.11%*
> Hmean     2      1096.74 (   0.00%)     1110.07 *   1.22%*     1106.70 *   0.91%*
> Hmean     4      1529.35 (   0.00%)     1531.20 *   0.12%*     1551.11 *   1.42%*
> Hmean     8      2824.32 (   0.00%)     2847.96 *   0.84%*     2684.21 *  -4.96%*
> Hmean     16     2573.30 (   0.00%)     2591.77 *   0.72%*     2445.41 *  -4.97%*
> Hmean     32     2518.77 (   0.00%)     2532.70 *   0.55%*     2409.30 *  -4.35%*
>
> For tbench, it's ok for lower thread counts for 8 threads (machine
> overloaded), Vincent's patch regresses slightly. With these test runs,
> I don't have detailed information as to why but the most likely solution
> is that preemption gets disabled prematurely.
>
> specjbb
>                              5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
>                                 vanillasched-scalewakegran-v2r4 sched-moveforward-v1r1
> Hmean     tput-1    71199.00 (   0.00%)    69492.00 *  -2.40%*    71126.00 *  -0.10%*
> Hmean     tput-2   154478.00 (   0.00%)   146060.00 *  -5.45%*   153073.00 *  -0.91%*
> Hmean     tput-3   211889.00 (   0.00%)   209386.00 *  -1.18%*   219434.00 *   3.56%*
> Hmean     tput-4   257842.00 (   0.00%)   248012.00 *  -3.81%*   262903.00 *   1.96%*
> Hmean     tput-5   253506.00 (   0.00%)   242511.00 *  -4.34%*   250828.00 *  -1.06%*
> Hmean     tput-6   246202.00 (   0.00%)   236480.00 *  -3.95%*   244236.00 *  -0.80%*
> Hmean     tput-7   241133.00 (   0.00%)   230905.00 *  -4.24%*   237619.00 *  -1.46%*
> Hmean     tput-8   237983.00 (   0.00%)   230010.00 *  -3.35%*   235275.00 *  -1.14%*
>
> For specjbb, it's different again, Vincent's patch is better for the
> overloaded case but both patches show light regressions.
>
> --
> Mel Gorman
> SUSE Labs
