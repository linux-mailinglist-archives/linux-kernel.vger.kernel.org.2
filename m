Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35EB3BE5B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhGGJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhGGJkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:40:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5E0C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 02:37:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so2963767lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 02:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=deNkM43HVrzzox3/O3Vf0dj4Yd0AsDTSqL5zXDoRHrQ=;
        b=j9VDxZYoMcJ9CKs8I3W2QKoYU1FWDBYA+P9rAg5P0WjqmAHy8IkqVJz/4Te+OPOZaV
         HQUZO7OaFwMr/zN/a3f/ofcSSv54xCFaSH3jh4V7pMaeJqiXIY3SO6c/aoBBBT1hiZqr
         Zi7TwZY30QNnzaXazHbvKjHZqBr3+FWqrCa7qfoAjBm13MHLW2zOqEAjvQvcKqqUBdb7
         hh8c7IPUt76uko5dYfti2tcsXmjK3AkxBneuK3fP9INu8Gyxg1N/MTmsFlzEMj9P02/q
         8nkp5FPHlF4tfg/UoLTq6OFYLgyBu9JfAd1NZNDEt6jKJEpIbjXEuJE/h6MJ7AE/6cr2
         Y5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=deNkM43HVrzzox3/O3Vf0dj4Yd0AsDTSqL5zXDoRHrQ=;
        b=Gstm4h+j/ffVxHxyaEHiVDqKh9cH2DUkrlov1s5u/wAbqzMv3bW5przRwJg8ZwcPvg
         Eom/3U8E0gLl0ASro3XBt1P3sQMm6V6fyyANbKgEi38OF3jf/EC50hll7HwoxZIM6Lpk
         C/o9Y4y+B6oStYFoQx3CJ02qNU3fBjgObeQmWkfSWYxCPW2wbKa7UCKxC6iNAJgQGiDx
         rYMa1MaXbyoRqzdCJUCeDWDzAKGJU23fei4588c1d4dgLA07rAW1odTOU19zb7h7XamA
         69YN9Syedn7zMQ/9+ZeMBwWYzaBWLOQfuLni5izGcT2bB8byclQfPAbifY6ItMExMpl+
         f4dA==
X-Gm-Message-State: AOAM5309h1X4vNWi4onOf13C702nZidOcVMcFwS/o0wD5KMUcy/gvRL6
        P+xM/nBi7a3YmSpoY4Q0z+JeCeSJ7pOuA8aQnVJYJA==
X-Google-Smtp-Source: ABdhPJzYccMNM8M2j+Gtfgi11USPxzJNhiNtBRZWdYhl5aVN++I+dSz8KMcogNb7tmtIg4pAuamzEyPHZha3pdTsUf8=
X-Received: by 2002:a05:6512:3d11:: with SMTP id d17mr6100684lfv.254.1625650660885;
 Wed, 07 Jul 2021 02:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
In-Reply-To: <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 11:37:29 +0200
Message-ID: <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Prepare variables for increased precision
 of EAS estimated energy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Redpath <Chris.Redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, segall@google.com,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        CCj.Yeh@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jul 2021 at 10:23, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 9:00 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 09:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 7/7/21 8:07 AM, Vincent Guittot wrote:
> >>> On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
> >>>> task. It probes many possibilities and compares the estimated energy values
> >>>> for different scenarios. For calculating those energy values it relies on
> >>>> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
> >>>> EM data is in milli-Watts (or abstract scale), which sometimes is not
> >>>> sufficient. In some cases it might happen that two CPUs from different
> >>>> Performance Domains (PDs) get the same calculated value for a given task
> >>>> placement, but in more precised scale, they might differ. This rounding
> >>>> error has to be addressed. This patch prepares EAS code for better
> >>>> precision in the coming EM improvements.
> >>>
> >>> Could you explain why 32bits results are not enough and you need to
> >>> move to 64bits ?
> >>>
> >>> Right now the result is in the range [0..2^32[ mW. If you need more
> >>> precision and you want to return uW instead, you will have a result in
> >>> the range  [0..4kW[ which seems to be still enough
> >>>
> >>
> >> Currently we have the max value limit for 'power' in EM which is
> >> EM_MAX_POWER 0xffff (64k - 1). We allow to register such big power
> >> values ~64k mW (~64Watts) for an OPP. Then based on 'power' we
> >> pre-calculate 'cost' fields:
> >> cost[i] = power[i] * freq_max / freq[i]
> >> So, for max freq the cost == power. Let's use that in the example.
> >>
> >> Then the em_cpu_energy() calculates as follow:
> >> cost * sum_util / scale_cpu
> >> We are interested in the first part - the value of multiplication.
> >
> > But all these are internal computations of the energy model. At the
> > end, the computed energy that is returned by compute_energy() and
> > em_cpu_energy(), fits in a long
>
> Let's take a look at existing *10000 precision for x CPUs:
> cost * sum_util / scale_cpu =
> (64k *10000) * (x * 800) / 1024
> which is:
> x * ~500mln
>
> So to be close to overflowing u32 the 'x' has to be > (?=) 8
> (depends on sum_util).

Sorry but I don't get your point.
This patch is about the return type of compute_energy() and
em_cpu_energy(). And even if we decide to return uW instead of mW,
there is still a lot of margin.

It's not because you need u64 for computing intermediate value that
you must returns u64

>
> >
> >>
> >> The sum_util values that we can see for x CPUs which have scale_cap=1024
> >> can be close to 800, let's use it in the example:
> >> cost * sum_util = 64k * (x * 800), where
> >> x=4: ~200mln
> >> x=8: ~400mln
> >> x=16: ~800mln
> >> x=64: ~3200mln (last one which would fit in u32)
> >>
> >> When we increase the precision by even 100, then the above values won't
> >> fit in the u32. Even a max cost of e.g. 10k mW and 100 precision has
> >> issues:
> >> cost * sum_util = (10k *100) * (x * 800), where
> >> x=4: ~3200mln
> >> x=8: ~6400mln
> >>
> >> For *1000 precision even a power of 1Watt becomes an issue:
> >> cost * sum_util = (1k *1000) * (x * 800), where
> >> x=4: ~3200mln
> >> x=8: ~6400mln
> >>
> >> That's why to make the code safe for bigger power values, I had to use
> >> the u64 on 32bit machines.
