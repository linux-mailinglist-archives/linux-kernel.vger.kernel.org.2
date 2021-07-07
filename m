Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3C3BE62E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhGGKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:14:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E7BC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:11:41 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id u25so1970593ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuEZ3jVwrZtFCL3Zmrw9iRdslo4LWzfGrwGrKzCDfNM=;
        b=AAdlg8dWvWETI7yrZa9aa6Hdro1l4MMrDxlZvCQPrdjBC6Lu8L5XpdJ8kF5j24k5y4
         Y5k9ZiS9AhCI3B+YaLG3W0oohu90Vkdido2p8x/H1GJAMDXVMdk+eqpNknpqulTNZPUp
         iFDT45h0qeyqGVewt3oXb7mNoi8U5l9D/xqB6N5ZUc3F1WdoLxBqkq31e+I4LvDmv9P5
         YtYG4rsvQm4ySrLFLX7oBWpYMaTKeYZFWRs4c1lt2bnfiAgW1TjOKhUlzQ3Hr7Nloat2
         dG+EDQJWtWEuOkhjrWP3stTaGex5ZK7ShYH+yo5peV1Gp4O3/YemPXWuW/xCpsiIvp6f
         RHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuEZ3jVwrZtFCL3Zmrw9iRdslo4LWzfGrwGrKzCDfNM=;
        b=SHNaTMxg1FJlPXQQGyeDqm8/dGpCIxNJ37wp1eNta4QitXY39bT/TNjG19VghglfEv
         q/NWkLTIw8ecrIxivHYduV9Nw7z6VKyTMACNiw4+6jxzxyjLAjlfCH3ptCd7MCft33kQ
         CHWi7Ehi5FYnq0OvPXbNjMuO6r4E6ne+g3eGbhGDLRmhRt0I33pPrULQ3TEXE5AXekGq
         I/znAmG9uf46XsiDdcdxQG063pqm6C4KCmEBbgiDvEZai3Xzq+NyIK21CrPyw0oe2kD4
         VxjNp8/3arPs09aXU9QSzkCS24fLer/vaV5fVCPLJwhb4HoWEFEGYqcVXK3FBpm+SXUb
         0nrQ==
X-Gm-Message-State: AOAM5326WW1c3ctI0+M353ORmrXv5Px6XAPxqwdZ8YUBNRk5HyfX8J2n
        k91SWC3l/9mKyD0JXeizMWgn5LQaMcWyRl7coJ8SOw==
X-Google-Smtp-Source: ABdhPJzgZG6YjG/0gLEf7Rrqwsbi9ls6vUnvFowYrhuar9Mwt4w6AamkBtUmy3LIlciesWPf1pZWoMLm9/LjXjMn0q4=
X-Received: by 2002:a2e:8941:: with SMTP id b1mr19097509ljk.284.1625652699360;
 Wed, 07 Jul 2021 03:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com> <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com> <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
 <27916860-33b1-f0a0-acff-4722a733c81b@arm.com>
In-Reply-To: <27916860-33b1-f0a0-acff-4722a733c81b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 12:11:28 +0200
Message-ID: <CAKfTPtB2ogGbGBjJNRBB5jvN24q-tXFR+BpJ31fzsTd2=pDTHQ@mail.gmail.com>
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

On Wed, 7 Jul 2021 at 12:06, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 10:56 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 11:48, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 7/7/21 10:37 AM, Vincent Guittot wrote:
> >>> On Wed, 7 Jul 2021 at 10:23, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/7/21 9:00 AM, Vincent Guittot wrote:
> >>>>> On Wed, 7 Jul 2021 at 09:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 7/7/21 8:07 AM, Vincent Guittot wrote:
> >>>>>>> On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>>>>
> >>>>>>>> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
> >>>>>>>> task. It probes many possibilities and compares the estimated energy values
> >>>>>>>> for different scenarios. For calculating those energy values it relies on
> >>>>>>>> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
> >>>>>>>> EM data is in milli-Watts (or abstract scale), which sometimes is not
> >>>>>>>> sufficient. In some cases it might happen that two CPUs from different
> >>>>>>>> Performance Domains (PDs) get the same calculated value for a given task
> >>>>>>>> placement, but in more precised scale, they might differ. This rounding
> >>>>>>>> error has to be addressed. This patch prepares EAS code for better
> >>>>>>>> precision in the coming EM improvements.
> >>>>>>>
> >>>>>>> Could you explain why 32bits results are not enough and you need to
> >>>>>>> move to 64bits ?
> >>>>>>>
> >>>>>>> Right now the result is in the range [0..2^32[ mW. If you need more
> >>>>>>> precision and you want to return uW instead, you will have a result in
> >>>>>>> the range  [0..4kW[ which seems to be still enough
> >>>>>>>
> >>>>>>
> >>>>>> Currently we have the max value limit for 'power' in EM which is
> >>>>>> EM_MAX_POWER 0xffff (64k - 1). We allow to register such big power
> >>>>>> values ~64k mW (~64Watts) for an OPP. Then based on 'power' we
> >>>>>> pre-calculate 'cost' fields:
> >>>>>> cost[i] = power[i] * freq_max / freq[i]
> >>>>>> So, for max freq the cost == power. Let's use that in the example.
> >>>>>>
> >>>>>> Then the em_cpu_energy() calculates as follow:
> >>>>>> cost * sum_util / scale_cpu
> >>>>>> We are interested in the first part - the value of multiplication.
> >>>>>
> >>>>> But all these are internal computations of the energy model. At the
> >>>>> end, the computed energy that is returned by compute_energy() and
> >>>>> em_cpu_energy(), fits in a long
> >>>>
> >>>> Let's take a look at existing *10000 precision for x CPUs:
> >>>> cost * sum_util / scale_cpu =
> >>>> (64k *10000) * (x * 800) / 1024
> >>>> which is:
> >>>> x * ~500mln
> >>>>
> >>>> So to be close to overflowing u32 the 'x' has to be > (?=) 8
> >>>> (depends on sum_util).
> >>>
> >>> Sorry but I don't get your point.
> >>> This patch is about the return type of compute_energy() and
> >>> em_cpu_energy(). And even if we decide to return uW instead of mW,
> >>> there is still a lot of margin.
> >>>
> >>> It's not because you need u64 for computing intermediate value that
> >>> you must returns u64
> >>
> >> The example above shows the need of u64 return value for platforms
> >> which are:
> >> - 32bit
> >> - have e.g. 16 CPUs
> >> - has big power value e.g. ~64k mW
> >> Then let's to the calc:
> >> (64k * 10000) * (16 * 800) / 1024 = ~8000mln = ~8bln
> >
> > so you return a power consumption of 8kW !!!
> >
>
> No. It's in 0.1uW scale, so 800Watts. Which is 16 CPUs * 64Watts

Oh! you want 0.1uW precision .... This doesn't seem realistic at all.
I'm not even sure that the power model can even reach an accuracy of
1mW

> each at max freq and 80% load.
>
> Max power can be < 64Watts, which is 64k milli-Watts (< EM_MAX_POWER)
> 64k mW * 10000 --> is the 0.1uW precision
>
