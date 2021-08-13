Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85D13EBEE6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhHMX4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 19:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbhHMX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:56:09 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598C2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:55:42 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z128so21835756ybc.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 16:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Hza+cZiqC9XzItENxitG0eHLg/qkhDpg0M92+ngjKE=;
        b=IowVmiqz9W4nGo9+xQXGxJhoa1M+RONhN4l79NEfW0xTGx5gNNhLIKXfwLyYC8u4YR
         44mSAS8UZArbJqnVF+cSH0OyCYcSvS8TY8Xe6guCUOlFozksRc/xux1TNGCVmMacAsKJ
         3e5WdZvKzMhaF383b3gkcVMpUO+QLE3cez097HyA5adz5bRtcHPS8hIsICLIBHykTaHU
         X014zBe1Xob9Nrw2ZA082+QAhbYmsdtfpkvQ+a4yG3mZR8B6qI5FC7bP6Y4PKT6D0VgI
         Fss42lg2Xr/YUowKDy/vgl0jKq21RiHaQB3BYo5/AYi/3meufiyVvikluz0mC4NNdOid
         Z/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Hza+cZiqC9XzItENxitG0eHLg/qkhDpg0M92+ngjKE=;
        b=Y49nN+11FnXIM1MOre+9lGIJJfZssc94uq8tVsr8CAZbgzWO33KMhhS8L0F0rb3ip+
         sNfNe25kIodpfvPjUahJH8h+cQ5eE109+LsO7HoK1SLGaLsG4cxlHbDFuFibOEefMO1Q
         zPhDXT8wGwM3KDWTzm+vS1ARZFRczuTWlUd9qILFy8KmSER0ZnChgt1a4fQ4O8PDeaM1
         lkeGL3AR4x6y/PwnLNEwucCicQzpToCnWd7DhbD9GpxfrzU/fwh0uytUTpYXLMaH/MJi
         j2sI+EgURzOVd/mA74p24CTPUerZ74Z//06pwYIZvJ0wLN2zFXuoYLBS5aLZRg7cZZew
         Hbag==
X-Gm-Message-State: AOAM532FYOoTLv22R5NUbN3WpkeSuuHdl8F662lSMaaEMzX/skk+NB3r
        n4RDHKFThRFshuzBIrws7eiTuDEeGFKa4O3NqB/Tqw==
X-Google-Smtp-Source: ABdhPJy6EX2LTFKvpwLgwc+nWeGl0+trx7LHktLUrINKrTHUqJLH4Lnzndks7rKcu/iM4267UbsvRh2lmYfVt8KH5s0=
X-Received: by 2002:a5b:7c4:: with SMTP id t4mr5934445ybq.368.1628898941326;
 Fri, 13 Aug 2021 16:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
 <CABk29Ns8P9AGy7Tpo6duOeEh=ZFWM1jO8FnvhZhktfcA0GWOpw@mail.gmail.com> <CAKfTPtB=ao5yrE3OtEj7mZYPNeMGCEB4rGMRb=vN5QfF=ySGiw@mail.gmail.com>
In-Reply-To: <CAKfTPtB=ao5yrE3OtEj7mZYPNeMGCEB4rGMRb=vN5QfF=ySGiw@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 13 Aug 2021 16:55:30 -0700
Message-ID: <CABk29NvOFsZYq6C0h4hRpd=CvoVxtYypgTx9neG4SKzUMQy2Tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 5:43 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
[snip]
> > >
> > > The 1ms of your test comes from the tick which could be a good
> > > candidate for a min value or the
> > > normalized_sysctl_sched_min_granularity which has the advantage of not
> > > increasing with number of CPU
> >
> > Fair point, this shouldn't completely ignore min granularity. Something like
> >
> > unsigned int sysctl_sched_idle_min_granularity = NSEC_PER_MSEC;
> >
> > (and still only using this value instead of the default
> > min_granularity when the SCHED_IDLE entity is competing with normal
> > entities)
>
> Yes that looks like a good option
>
> Also note that with a NSEC_PER_MSEC default value, the sched_idle
> entity will most probably run 2 ticks instead of the 1 tick (HZ=1000)
> that you have with your proposal because a bit less than a full tick
> is accounted to the running thread (the time spent in interrupt is not
> accounted as an example) so sysctl_sched_idle_min_granularity of 1ms
> with HZ=1000 will most propably run 2 ticks. Instead you could reuse
> the default 750000ULL value of sched_idle_min_granularity

Yes, great point. That's a better value here, with sufficient margin.

> That being said sysctl_sched_idle_min_granularity =
> normalized_sysctl_sched_min_granularity * scale_factor which means
> that normalized_sysctl_sched_min_granularity stays the same
> (750000ULL) whatever the number of cpus
>
> >
> > > > @@ -4216,7 +4228,15 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > > >                 if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > >                         thresh >>= 1;
> > > >
> > > > -               vruntime -= thresh;
> > > > +               /*
> > > > +                * Don't give sleep credit to a SCHED_IDLE entity if we're
> > > > +                * placing it onto a cfs_rq with non SCHED_IDLE entities.
> > > > +                */
> > > > +               if (!se_is_idle(se) ||
> > > > +                   cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)
> > >
> > > Can't this condition above create unfairness between idle entities ?
> > > idle thread 1 wake up while normal thread is running
> > > normal thread thread sleeps immediately after
> > > idle thread 2 wakes up just after and gets some credits compared to the 1st one.
> >
> > Yes, this sacrifices some idle<->idle fairness when there is a normal
> > thread that comes and goes. One alternative is to simply further
> > reduce thresh for idle entities. That will interfere with idle<->idle
> > fairness when there are no normal threads, which is why I opted for
> > the former. On second thought though, the former fairness issue seems
> > more problematic. Thoughts on applying a smaller sleep credit
> > threshold universally to idle entities?
>
> This one is a bit more complex to set.
> With adding 1, you favor the already runnable tasks by ensuring that
> they have or will run a slice during this period before sched_idle
> task
> But as soon as you subtract something to min_vruntime, the task will
> most probably be scheduled at the next tick if other tasks already run
> for a while (at least a sched period). If we use
> sysctl_sched_min_granularity for sched_idle tasks that wake up instead
> of sysctl_sched_latency, we will ensure that a sched_idle task will
> not preempt a normal task, which woke up few ms before, and we will
> keep some fairness for sched_idle task that sleeps compare to other.
>
> so a thresh of sysctl_sched_min_granularity (3.75ms with 16 cpus )
> should not disturb your UC and keep some benefit for newly wake up
> sched_ide task

If the normal task has already been running for at least a period, it
should be ok to preempt.
A thresh around the min_granularity seems like a good order of
magnitude; I'll experiment a bit.
