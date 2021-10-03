Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5942007F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhJCHg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 03:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhJCHgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 03:36:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2CC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 00:35:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v18so50845320edc.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mx4MhWrEzUDOeyNntdKwp9cYdvsXNKvp/3DKWDO5O4w=;
        b=Q9zhPlIAltm3zgBL7y2A9Ya2kB6Vwt2JaABn9xIb3WmbQAmeVUe4HtELD0iXYQxPN3
         x9be4Sf7kbnFB+QY2FjHUEpp0W2fdVUpj3eBezJpLr48MrQLWIhENsac5eyeZkZZ2WU+
         QCtdvHSsoyKmmJo+1KzVJQs5ct8VjJsksU7ZD7Wdt1m043GqOTL51kDWJSgCJ0THp7RE
         EBFUOlNBiI6Vw004bDJgR0vnLMJLbFhlFuOYOoJYA9iR+PykpsPAZZ6Qdjv+XqqaCN9j
         MV6LFJLxlk9XetCNRJRKnYdqMssefvjVYi00e9J583tXV2DkbmAIQyrDZEiY6P/nwRlA
         1Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mx4MhWrEzUDOeyNntdKwp9cYdvsXNKvp/3DKWDO5O4w=;
        b=o826Y3lEetCpPbL2UQv3QaJPV1MQfVVOGqkDlLZDpyabLzAqtbkzYGifF3fmu/aocX
         ehPuh2iC/ovEhtD0Bxi+9RAn/jNYxJawVt3JhONthuV4vDE5H38H70rrFof3jh8HLK7R
         DRNKuHjDW5jUFXcBkLkfKnqp14jmBh06NUoJ5tYrZKyJJ3Mrve8XHYqTF0gRXWpMw3PQ
         x/X5NqvDvf8ygBBZeY9UMbypg7icO3M7HVDmKgcbpige21t/bEogQDlDEeRRxDjvN6sJ
         mvzJ4xSNKQk+x5J7XKXvdlT9FIAaXhuTtNMzxIk9nGL1Cw0V9zUGY9hPASQnink4gRMI
         sUuQ==
X-Gm-Message-State: AOAM531yTiC1F5KOhB+cGdu9BPksmJDvXkFSmp0VnSgcF9Yfpwd8ZfWc
        9cVF1OBPEsCPP++kvlGu1YY47S10jf176uhmdto=
X-Google-Smtp-Source: ABdhPJzDIuHLl0Eh359itL2X+8316+u8Lt3QlsfxLS+aPqsa9GdpGXNqM3GG6GAkwbqAMqTdo5pPaRCNGsgylHX7EIk=
X-Received: by 2002:a17:906:280f:: with SMTP id r15mr8478581ejc.559.1633246501040;
 Sun, 03 Oct 2021 00:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net> <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net> <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
In-Reply-To: <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 3 Oct 2021 20:34:49 +1300
Message-ID: <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
To:     Mike Galbraith <efault@gmx.de>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 3, 2021 at 4:11 PM Mike Galbraith <efault@gmx.de> wrote:
>
> On Wed, 2021-09-22 at 07:22 +0200, Mike Galbraith wrote:
> > On Tue, 2021-09-21 at 11:36 +0100, Mel Gorman wrote:
> > > On Tue, Sep 21, 2021 at 05:52:32AM +0200, Mike Galbraith wrote:
> > >
> > >
> > > > Preemption does rapidly run into diminishing return as load climbs for
> > > > a lot of loads, but as you know, it's a rather sticky wicket because
> > > > even when over-committed, preventing light control threads from slicing
> > > > through (what can be a load's own work crew of) hogs can seriously
> > > > injure performance.
> > > >
> > >
> > > Turning this into a classic Rob Peter To Pay Paul problem. We don't know
> > > if there is a light control thread that needs to run or not that affects
> > > overall performance. It all depends on whether that control thread needs
> > > to make progress for the overall workload or whether there are a mix of
> > > workloads resulting in overloading.
> >
> > WRT overload, and our good buddies Peter and Paul :) I added...
> >         if (gran >= sysctl_sched_latency >> 1)
> >                 trace_printk("runnable:%d preempt disabled\n",cfs_rq->nr_running);
> > ...to watch, and met the below when I.. logged in.
> >
> > homer:..debug/tracing # tail -20 trace
> >                X-2229    [002] d..5.    60.690322: wakeup_gran: runnable:9 preempt disabled
> >                X-2229    [002] d..5.    60.690325: wakeup_gran: runnable:10 preempt disabled
> >                X-2229    [002] d..5.    60.690330: wakeup_gran: runnable:11 preempt disabled
> >                X-2229    [002] d..5.    60.690363: wakeup_gran: runnable:13 preempt disabled
> >                X-2229    [002] d..5.    60.690377: wakeup_gran: runnable:14 preempt disabled
> >                X-2229    [002] d..5.    60.690390: wakeup_gran: runnable:15 preempt disabled
> >                X-2229    [002] d..5.    60.690404: wakeup_gran: runnable:16 preempt disabled
> >                X-2229    [002] d..5.    60.690425: wakeup_gran: runnable:9 preempt disabled
> >        ksmserver-2694    [003] d..3.    60.690432: wakeup_gran: runnable:6 preempt disabled
> >        ksmserver-2694    [003] d..3.    60.690436: wakeup_gran: runnable:7 preempt disabled
> >                X-2229    [002] d..5.    60.690451: wakeup_gran: runnable:6 preempt disabled
> >                X-2229    [002] d..5.    60.690465: wakeup_gran: runnable:7 preempt disabled
> >             kmix-2736    [000] d..3.    60.690491: wakeup_gran: runnable:6 preempt disabled
> >                X-2229    [004] d..5.    92.889635: wakeup_gran: runnable:6 preempt disabled
> >                X-2229    [004] d..5.    92.889675: wakeup_gran: runnable:6 preempt disabled
> >                X-2229    [004] d..5.    92.889863: wakeup_gran: runnable:6 preempt disabled
> >                X-2229    [004] d..5.    92.889944: wakeup_gran: runnable:6 preempt disabled
> >                X-2229    [004] d..5.    92.889957: wakeup_gran: runnable:7 preempt disabled
> >                X-2229    [004] d..5.    92.889968: wakeup_gran: runnable:8 preempt disabled
> >   QXcbEventQueue-2740    [000] d..4.    92.890025: wakeup_gran: runnable:6 preempt disabled
> > homer:..debug/tracing
> >
> > Watching 'while sleep 1; do clear;tail trace; done' with nothing but a
> > kbuild running is like watching top.  There's enough stacking during
> > routine use of my desktop box that it runs into the tick granularity
> > wall pretty much continuously, so 'overload' may want redefining.
>
> I looked into that crazy stacking depth...
>
> static int
> wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
>                    int this_cpu, int prev_cpu, int sync)
> {
>         s64 this_eff_load, prev_eff_load;
>         unsigned long task_load;
>
>         this_eff_load = cpu_load(cpu_rq(this_cpu));
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^ the butler didit!
>
> That's pretty darn busted as it sits.  Between load updates, X, or any
> other waker of many, can stack wakees to a ludicrous depth.  Tracing
> kbuild vs firefox playing a youtube clip, I watched X stack 20 of the
> zillion firefox minions while their previous CPUs all had 1 lousy task
> running but a cpu_load() higher than the cpu_load() of X's CPU.  Most
> of those prev_cpus were where X had left them when it migrated. Each
> and every crazy depth migration was wake_affine_weight() deciding we
> should pull based on crappy data.  As instantaneous load on the waker
> CPU blew through the roof in my trace snapshot, its cpu_load() did
> finally budge.. a tiny bit.. downward.  No idea where the stack would
> have topped out, my tracing_off() limit was 20.

Mike, not quite sure I caught your point. It seems you mean x wakes up
many firefoxes within a short period, so it pulls them to the CPU where x
is running. Technically those pulling should increase cpu_load of x' CPU.
But due to some reason, the cpu_load is not increased in time on x' CPU,
So this makes a lot of firefoxes piled on x' CPU, but at that time,  the load
of the cpu which firefox was running on is still larger than x' cpu with a lot
of firefoxes?

I am wondering if this should be the responsibility of wake_wide()?

>
> Hohum, my box grew a WA_INST companion to SIS_MIN_LAT cache cold task
> distribulator feature ;-)  Not particularly lovely, but it knocks over
> the leaning tower of minions.
>
>         -Mike

Thanks
barry
