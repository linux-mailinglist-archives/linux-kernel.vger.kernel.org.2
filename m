Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9883AB6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhFQPGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhFQPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:06:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471DBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:04:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l15so5227583lje.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zyx0RVLeDjEE/MMulYB8DBNSYDLEyhntkW6cb8NwdLY=;
        b=C8Fui3Pf2k95epN+6vm5R9FVNMaNVXPSg2AEfERrRIPGiY7HcaD+d2QX8DPmAZf3PQ
         Oy2ND+aXtfgY2yQV7E3foWkc9ETPaOmcGkyB9LKtfwkuzC3X4L7oy+QjJJXrThEFHlYj
         3AD8Ryluai+vERrDVzgGc7K5+m22Bc1diUsj8ODqrkXzHyvx6qnqfx4PWAbTs51OjEA9
         GfHFmX3WueqRZE8AZShS9xKQregHY5P8ApgHMldtkge7fdP9IWbLxMJS0B9WIYj5oHLA
         ph7e4fUap2hmazj12Nn3B1Q6asZj3JKnoQBWvBXQpZrkjl1ugQ9czPJPMCXgNzrXvZR7
         Sxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zyx0RVLeDjEE/MMulYB8DBNSYDLEyhntkW6cb8NwdLY=;
        b=uD9OaF2wwkVIyYmMKr0r91IgGiMgSxS7wzVW2AMSMjgvUptPfngB4FKAkKSeEXfkg8
         OGxADUk4MSkYRMTTuEWths9w0JEGbqGnP9xlXDD3gVFaWbJdEN9nJt0+xeg3dqojRQJ8
         EJqwg2oURrfw/cKaLxBPmGsqn3mxe/4lBt5FX+vkjw1u8wEPZm/WozGt7YIV0lwbM11x
         Ozcx9kKeGJ4wJw7dTj+5B9PjZJwhBMdKEmuy6yj+zFoxBDzEkgSTiuQZvj4mLvjC5wED
         CvKm9VV2C2nbjUSawkRW82XMhDPr05Zibg3erbvMVMP4Mkwn8sUf8JJ/ihUqrzU3g/+6
         e69A==
X-Gm-Message-State: AOAM530mNUqgzlR2DhbjxxclRzj0jQkAuxjn7xnDCP1rEvV5nc1e2tX5
        3poBiZs78TTYA7mYlHjLphXxrqXdVtwunSBhXMfJIQ==
X-Google-Smtp-Source: ABdhPJyK2k3h9Cxw5JFtSL9jXrmscf0Hf/5QcAnB5MDdp9WjuTKGtP+jinywgNGNcVEO7e4nW1RgxluwUyXQFLyGBgg=
X-Received: by 2002:a2e:910d:: with SMTP id m13mr3127822ljg.401.1623942246051;
 Thu, 17 Jun 2021 08:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210615111611.GH30378@techsingularity.net> <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com>
 <20210617074401.GL30378@techsingularity.net> <CAKfTPtC8d37ZrXfDF2jkgg=tDPb1qAvFQQGXHhTf9LLR59hd8Q@mail.gmail.com>
 <20210617094040.GM30378@techsingularity.net> <CAKfTPtB-UCduEiQ5e8NxbOwsfjYGj3ron5rAg4_5ag2Fne7v3A@mail.gmail.com>
 <20210617110548.GN30378@techsingularity.net>
In-Reply-To: <20210617110548.GN30378@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 17 Jun 2021 17:03:54 +0200
Message-ID: <CAKfTPtBJkpSMFFGwgdFLyO5aSnGuzQSPrtpwOFckMQa4xaex=Q@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2021 at 13:05, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Jun 17, 2021 at 12:02:56PM +0200, Vincent Guittot wrote:
> > > > >
> > > > > Fundamentally though, as the changelog notes "due to the nature of the
> > > > > patch, this is a regression magnet". There are going to be examples
> > > > > where a deep search is better even if a machine is fully busy or
> > > > > overloaded and examples where cutting off the search is better. I think
> > > > > it's better to have an idle estimate that gets updated if CPUs are fully
> > > > > busy even if it's not a universal win.
> > > >
> > > > Although I agree that using a stall average idle time value of local
> > > > is not good, I'm not sure this proposal is better. The main problem is
> > > > that we use the avg_idle of the local CPU to estimate how many times
> > > > we should loop and try to find another idle CPU. But there is no
> > > > direct relation between both.
> > >
> > > This is true. The idle time of the local CPU is used to estimate the
> > > idle time of the domain which is inevitably going to be inaccurate but
> >
> > I'm more and more convinced that using average idle time  (of the
> > local cpu or the full domain) is not the right metric. In
> > select_idle_cpu(), we looks for an idle CPU but we don't care about
> > how long it will be idle.
>
> Can we predict that accurately? cpufreq for intel_pstate used to try
> something like that but it was a bit fuzzy and I don't know if the
> scheduler could do much better. There is some idle prediction stuff but
> it's related to nohz which does not really help us if a machine is nearly
> fully busy or overloaded.
>
> I guess for tracking idle that revisiting
> https://lore.kernel.org/lkml/1615872606-56087-1-git-send-email-aubrey.li@intel.com/
> is an option now that the scan is somewhat unified. A two-pass scan
> could be used to check potentially idle CPUs first and if there is
> sufficient search depth left, scan other CPUs. There were some questions

I think it's the other way around:
a CPU is busy for sure if it is not set in the cpuidle_mask and we
don't need to check it. But a cpu might not be idle even if it is set
in the idle mask might because it's cleared during the tick

> on how accurate the idle mask was and how expensive it was to maintain.
> Unfortunately, it would not help with scan depth calculations, it just
> might reduce useless scanning.

Yes, we will not have to scan CPU which are busy

>
> Selecting based on avg idle time could be interesting but hazardous. If
> for example, we prioritised selecting a CPU that is mostly idle, it'll
> also pick CPUs that are potentially in a deep idle state incurring a
> larger wakeup cost. Right now we are not much better because we just
> select an idle CPU and hope for the best but always targetting the most
> idle CPU could have problems. There would also be the cost of tracking
> idle CPUs in priority order. It would eliminate the scan depth cost
> calculations but the overall cost would be much worse.
>
> Hence, I still think we can improve the scan depth costs in the short
> term until a replacement is identified that works reasonably well.
>
> > Even more, we can scan all CPUs whatever the
> > avg idle time if there is a chance that there is an idle core.
> >
>
> That is an important, but separate topic. It's known that the idle core
> detection can yield false positives. Putting core scanning under SIS_PROP
> had mixed results when we last tried but things change. Again, it doesn't
> help with scan depth calculations.

my point was mainly to highlight that the path can take opposite
decision for the same avg_idle value:
- scan all cpus if has_idle_core is true whatever avg_idle
- limit the depth if has_idle_core is false and avg_idle is short

>
> > > tracking idle time for the domain will be cache write intensive and
> > > potentially very expensive. I think this was discussed before but maybe
> > > it is my imaginaction.
> > >
> > > > Typically, a short average idle time on
> > > > the local CPU doesn't mean that there are less idle CPUs and that's
> > > > why we have a mix a gain and loss
> > > >
> > >
> > > Can you evaluate if scanning proportional to cores helps if applied on
> > > top? The patch below is a bit of pick&mix and has only seen a basic build
> >
> > I will queue it for some test later today
> >
>
> Thanks. The proposed patch since passed a build and boot test,
> performance evaluation is under way but as it's x86 and SMT2, I'm mostly
> just checking that it's neutral.

Results stay similar:
group  tip/sched/core      + this patch             + latest addon
1      13.358(+/- 1.82%)   12.850(+/- 2.21%) +4%    13.411(+/- 2.47%) -0%
4      4.286(+/- 2.77%)    4.114(+/- 2.25%)  +4%    4.163(+/- 1.88%)  +3%
16     3.175(+/- 0.55%)    3.559(+/- 0.43%)  -12%   3.535(+/- 0.52%)  -11%
32     2.912(+/- 0.79%)    3.165(+/- 0.95%)  -8%    3.153(+/- 0.76%)  -10%
64     2.859(+/- 1.12%)    2.937(+/- 0.91%)  -3%    2.919(+/- 0.73%)  -2%
128    3.092(+/- 4.75%)    3.003(+/-5.18%)   +3%    2.973(+/- 0.90%)  +4%
256    3.233(+/- 3.03%)    2.973(+/- 0.80%)  +8%    3.036(+/- 1.05%)  +6%

>
> --
> Mel Gorman
> SUSE Labs
