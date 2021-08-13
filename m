Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52E03EB5B1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 14:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhHMMny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 08:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbhHMMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 08:43:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E803CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:43:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id n7so15553607ljq.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ZNlAjENA2bFRL5ukc9SNEeDM49cwNgXF7CAbZW5lhw=;
        b=JwW0PaTqivKeUarTjtR7Qrd5ehlWETYoAX9dNE7fBxYzG5C0wVlUYbguWcJqyDtr4P
         xbaQPJpc7KiZqsDa2OZGxhWct9GPq7zxjxeS1kXppAkno9smmi1axOuQk0bdB0b7sso/
         QSWxdTsVv0bwE/b/JhOQBFTq66tx5cGb//RyRN1YXxpdkSSCNiLh5wZC91W4g9TKL3b/
         8Dsbt5uOEM/ASVVA+zLjiEW4adlP352L+oCei+fQ0HVrJtICv+h1N+vGsEZYn0WSHzJL
         za7Pt1sbcQ+AIpnzoVU+nuRm/0fnLnYtrq9kCdhp99EUxg2fxkjOFIYLzv99eWzN0KK3
         Sv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ZNlAjENA2bFRL5ukc9SNEeDM49cwNgXF7CAbZW5lhw=;
        b=bf19pt0jPKAsSZAUIKH01pm9UpIo8anUbknVh/2phOgqSSy0yBiWUh98lnbVl6X4ln
         i9bOtDMoihufCTuCCBHFUOpAcWLODG8Q+AUF6/vr/blROBVkxI5mJq6RyHjXNowz+iLl
         jEFRe01QRcbRG09yI3CVJ+3WmBf5jDC3t/ECde/VDq0OfyC4MafFMBfoKNymv454P3c1
         xBdUrYp18BUBelq74QCh2chk10e4nNAeBUqwcOeDVvHjf+npfv3XbsXbx1LKNFgYFvM9
         ACsVbXErG3UmPKGWoAG/IXRUacdS9JBVvtsZFK7ygApscT+nnUUUX2SHhLwIWNDfxEM3
         k/YQ==
X-Gm-Message-State: AOAM532WH9VaGY2FL6IsK+kdTyRB3AW9W2bkynfwgFtKSSxrUAehJXqt
        zh/MwrCSNZ+J4iAiJhEdnWkVZTBs7ZddXxEn8U2Yzg==
X-Google-Smtp-Source: ABdhPJw6eP6Q/68ondEsb2sZsMJUsFRF2uY1u6Qft1IDEex3BdVyUdZ0IOkvFkEaoODqoz8fRerQ6XCgquLv5MA9v3U=
X-Received: by 2002:a2e:9355:: with SMTP id m21mr1684169ljh.445.1628858604219;
 Fri, 13 Aug 2021 05:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com> <CABk29Ns8P9AGy7Tpo6duOeEh=ZFWM1jO8FnvhZhktfcA0GWOpw@mail.gmail.com>
In-Reply-To: <CABk29Ns8P9AGy7Tpo6duOeEh=ZFWM1jO8FnvhZhktfcA0GWOpw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Aug 2021 14:43:12 +0200
Message-ID: <CAKfTPtB=ao5yrE3OtEj7mZYPNeMGCEB4rGMRb=vN5QfF=ySGiw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
To:     Josh Don <joshdon@google.com>
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

On Thu, 12 Aug 2021 at 23:09, Josh Don <joshdon@google.com> wrote:
>
> > > @@ -697,8 +699,18 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > >                 slice = __calc_delta(slice, se->load.weight, load);
> > >         }
> > >
> > > -       if (sched_feat(BASE_SLICE))
> > > -               slice = max(slice, (u64)w);
> > > +       if (sched_feat(BASE_SLICE)) {
> > > +               /*
> > > +                * SCHED_IDLE entities are not subject to min_granularity if
> > > +                * they are competing with non SCHED_IDLE entities. As a result,
> > > +                * non SCHED_IDLE entities will have reduced latency to get back
> > > +                * on cpu, at the cost of increased context switch frequency of
> > > +                * SCHED_IDLE entities.
> > > +                */
> >
> > Ensuring that the entity will have a minimum runtime has been added to
> > ensure that we let enough time to move forward.
> > If you exclude sched_idle entities from this min runtime, the
> > sched_slice of an idle_entity will be really small.
> > I don't have details of your example above but I can imagine that it's
> > a 16 cpus system which means a sysctl_sched_min_granularity=3.75ms
> > which explains the 4ms running time of an idle entity
> > For a 16 cpus system, the sched_slice of an idle_entity in your
> > example in the cover letter is: 6*(1+log2(16))*3/1027=87us. Of course
> > this become even worse with more threads and cgroups or thread with
> > ncie prio -19
> >
> > This value is then used to set the next hrtimer event in SCHED_HRTICK
> > and 87us is too small to make any progress
> >
> > The 1ms of your test comes from the tick which could be a good
> > candidate for a min value or the
> > normalized_sysctl_sched_min_granularity which has the advantage of not
> > increasing with number of CPU
>
> Fair point, this shouldn't completely ignore min granularity. Something like
>
> unsigned int sysctl_sched_idle_min_granularity = NSEC_PER_MSEC;
>
> (and still only using this value instead of the default
> min_granularity when the SCHED_IDLE entity is competing with normal
> entities)

Yes that looks like a good option

Also note that with a NSEC_PER_MSEC default value, the sched_idle
entity will most probably run 2 ticks instead of the 1 tick (HZ=1000)
that you have with your proposal because a bit less than a full tick
is accounted to the running thread (the time spent in interrupt is not
accounted as an example) so sysctl_sched_idle_min_granularity of 1ms
with HZ=1000 will most propably run 2 ticks. Instead you could reuse
the default 750000ULL value of sched_idle_min_granularity

That being said sysctl_sched_idle_min_granularity =
normalized_sysctl_sched_min_granularity * scale_factor which means
that normalized_sysctl_sched_min_granularity stays the same
(750000ULL) whatever the number of cpus

>
> > > @@ -4216,7 +4228,15 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > >                 if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > >                         thresh >>= 1;
> > >
> > > -               vruntime -= thresh;
> > > +               /*
> > > +                * Don't give sleep credit to a SCHED_IDLE entity if we're
> > > +                * placing it onto a cfs_rq with non SCHED_IDLE entities.
> > > +                */
> > > +               if (!se_is_idle(se) ||
> > > +                   cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)
> >
> > Can't this condition above create unfairness between idle entities ?
> > idle thread 1 wake up while normal thread is running
> > normal thread thread sleeps immediately after
> > idle thread 2 wakes up just after and gets some credits compared to the 1st one.
>
> Yes, this sacrifices some idle<->idle fairness when there is a normal
> thread that comes and goes. One alternative is to simply further
> reduce thresh for idle entities. That will interfere with idle<->idle
> fairness when there are no normal threads, which is why I opted for
> the former. On second thought though, the former fairness issue seems
> more problematic. Thoughts on applying a smaller sleep credit
> threshold universally to idle entities?

This one is a bit more complex to set.
With adding 1, you favor the already runnable tasks by ensuring that
they have or will run a slice during this period before sched_idle
task
But as soon as you subtract something to min_vruntime, the task will
most probably be scheduled at the next tick if other tasks already run
for a while (at least a sched period). If we use
sysctl_sched_min_granularity for sched_idle tasks that wake up instead
of sysctl_sched_latency, we will ensure that a sched_idle task will
not preempt a normal task, which woke up few ms before, and we will
keep some fairness for sched_idle task that sleeps compare to other.

so a thresh of sysctl_sched_min_granularity (3.75ms with 16 cpus )
should not disturb your UC and keep some benefit for newly wake up
sched_ide task
