Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4A3BE608
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhGGJ7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhGGJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:59:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A936C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 02:56:33 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p21so3003118lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGW/nRoBu30tv7Ct47L5ywv9N9fYBMZBlHQ91yDyhbU=;
        b=Upf4p/aSFZlDnJglzlRV11YYUdXG1aXaYnzKeQzZIss5zA2u7SfVkTDcVKkDakIamk
         3hz/8kIuICcyAtvWcMQzs/+gcUuEsCGs35lchhqOnlVssZQyBP3NYNb4JxzCcknwoSmq
         YVXVpIdsnm70UFLYK3Jzz32MJSJwLHzzX7ENAxvNFX6jS48HbOq8c+tAx1gdmEi23CoS
         c2P7F+Yl4uyTAM/GjyGBtSGe1wy+wWu+1krKKo0433g4WIq/IWyws7lDwm9JyMSZzlka
         Crsv32GQiwI3CbQxFj9ThpqX69OtCisokCdxd/chNGQ2BUtzHEPNgnWxzmCltAosvpFo
         9Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGW/nRoBu30tv7Ct47L5ywv9N9fYBMZBlHQ91yDyhbU=;
        b=qpi3kF918IAJP6GYhXYYfAbGp27vEiFDwbsrMNkcSk93n1X9clXxpHk775qfbUcnqF
         1mJWeva0vI4BZkZhSGew+2xXMoxy2kCMBkAES7N3FfMRDyas4Jr9dnRnLtvb2g3xc0/w
         sriYf0tHU/se64VvitN7kQWTZhJjs/Kh4vxLE1RlIjpt9uw2tIDUpTfPTWMUF3J3jb1H
         Dd5FMilzOyk/bjL6sjfMMmHipMp9CKwHQQRgBf9Ymkz7m2FA1uGBrLt+moTtqHmGndhe
         1HvUTtSY6a5eE7Fi1lMUI8lZDTi+uSzTNN64wWB5+AxGC2//BfliBSSVeYVvv9kxKgM5
         EpvA==
X-Gm-Message-State: AOAM532WcYzSuqOuQoJvdFlGWSXvUe4YlzCuprVFL7lhwBkEjmNbZann
        PNxJC7UxpuA2MUk3eEsbmuM5MNReQtRNPhvDs9u2Iw==
X-Google-Smtp-Source: ABdhPJx+svSjwrHvWsHFEBkIsOkqsXhMX5eMxYYx+OBQhAYE0ztSw+T9AzeGelj7dReHN+I3vjq/c7CAAZQEqCgNq1M=
X-Received: by 2002:a19:505a:: with SMTP id z26mr17355505lfj.470.1625651791931;
 Wed, 07 Jul 2021 02:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210625152603.25960-1-lukasz.luba@arm.com> <20210625152603.25960-2-lukasz.luba@arm.com>
 <CAKfTPtAV9GjQaXc2FV0OuEzTGQw9hFiKpwMfAxP-JQ_QFCUC3w@mail.gmail.com>
 <a6a49480-7d5d-fd0e-3940-0b6baac5acc0@arm.com> <CAKfTPtAbck=mTR4g9L1hVGzN2dz4PjKNXoDZeMH19HGwpW3Buw@mail.gmail.com>
 <2f43b211-da86-9d48-4e41-1c63359865bb@arm.com> <CAKfTPtDk1ANfjR5h_EjErVfQ7=is3n9QOaKKxz81tMHtqUM7jA@mail.gmail.com>
 <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com>
In-Reply-To: <297df159-1681-f0a7-843d-f34d86e51d4c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 7 Jul 2021 11:56:20 +0200
Message-ID: <CAKfTPtCEo+gkV2TMhOHSnuUyu5BC54o-B4Hb=QbzgT6Dft-PhQ@mail.gmail.com>
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

On Wed, 7 Jul 2021 at 11:48, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/7/21 10:37 AM, Vincent Guittot wrote:
> > On Wed, 7 Jul 2021 at 10:23, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 7/7/21 9:00 AM, Vincent Guittot wrote:
> >>> On Wed, 7 Jul 2021 at 09:49, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 7/7/21 8:07 AM, Vincent Guittot wrote:
> >>>>> On Fri, 25 Jun 2021 at 17:26, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>>>>
> >>>>>> The Energy Aware Scheduler (EAS) tries to find best CPU for a waking up
> >>>>>> task. It probes many possibilities and compares the estimated energy values
> >>>>>> for different scenarios. For calculating those energy values it relies on
> >>>>>> Energy Model (EM) data and em_cpu_energy(). The precision which is used in
> >>>>>> EM data is in milli-Watts (or abstract scale), which sometimes is not
> >>>>>> sufficient. In some cases it might happen that two CPUs from different
> >>>>>> Performance Domains (PDs) get the same calculated value for a given task
> >>>>>> placement, but in more precised scale, they might differ. This rounding
> >>>>>> error has to be addressed. This patch prepares EAS code for better
> >>>>>> precision in the coming EM improvements.
> >>>>>
> >>>>> Could you explain why 32bits results are not enough and you need to
> >>>>> move to 64bits ?
> >>>>>
> >>>>> Right now the result is in the range [0..2^32[ mW. If you need more
> >>>>> precision and you want to return uW instead, you will have a result in
> >>>>> the range  [0..4kW[ which seems to be still enough
> >>>>>
> >>>>
> >>>> Currently we have the max value limit for 'power' in EM which is
> >>>> EM_MAX_POWER 0xffff (64k - 1). We allow to register such big power
> >>>> values ~64k mW (~64Watts) for an OPP. Then based on 'power' we
> >>>> pre-calculate 'cost' fields:
> >>>> cost[i] = power[i] * freq_max / freq[i]
> >>>> So, for max freq the cost == power. Let's use that in the example.
> >>>>
> >>>> Then the em_cpu_energy() calculates as follow:
> >>>> cost * sum_util / scale_cpu
> >>>> We are interested in the first part - the value of multiplication.
> >>>
> >>> But all these are internal computations of the energy model. At the
> >>> end, the computed energy that is returned by compute_energy() and
> >>> em_cpu_energy(), fits in a long
> >>
> >> Let's take a look at existing *10000 precision for x CPUs:
> >> cost * sum_util / scale_cpu =
> >> (64k *10000) * (x * 800) / 1024
> >> which is:
> >> x * ~500mln
> >>
> >> So to be close to overflowing u32 the 'x' has to be > (?=) 8
> >> (depends on sum_util).
> >
> > Sorry but I don't get your point.
> > This patch is about the return type of compute_energy() and
> > em_cpu_energy(). And even if we decide to return uW instead of mW,
> > there is still a lot of margin.
> >
> > It's not because you need u64 for computing intermediate value that
> > you must returns u64
>
> The example above shows the need of u64 return value for platforms
> which are:
> - 32bit
> - have e.g. 16 CPUs
> - has big power value e.g. ~64k mW
> Then let's to the calc:
> (64k * 10000) * (16 * 800) / 1024 = ~8000mln = ~8bln

so you return a power consumption of 8kW !!!

>
> The returned value after applying the whole patch set
> won't fit in u32 for such cluster.
>
> We might make *assumption* that the 32bit platforms will not
> have bigger number of CPUs in the cluster or won't report
> big power values. But I didn't wanted to make such assumption.
>
>
