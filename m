Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979583EAC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 23:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhHLVJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhHLVJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 17:09:54 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3DDC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:09:28 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x5so6593986ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzXodZIvo99nif4/uO2l0vGH+4OrRkEZY+iwXxMdnBM=;
        b=oUMnOR3FqO3n452BiuGaT2bq3JvamVONMQOVRemcSqQGxAmoGJvcS8KlEb5HfAeZ7b
         DPVU3SluO9Pc6ftO6BGRRaTiLyWs1JyYsFF5AbNaYCZBfrVCI08d2vaHWIc5XiKDzMd6
         a9o4o+/J0Bcmm5PDCQxlqqmuqCiUw9pIcl8CbDzVotdqCdzn64IU0KfypLJkjyZi8JO6
         JKVjn3mpp6bHHlX63k/JOLY4S+/EKoFNc8rZpp6BQ/u5lT3KyxuMUhVPfPt+6K1rrF7Q
         Q57sq2fFWym3aCZpu/zkPNjEnX0i3VAuDfHC6+nnL9dov64d00vxR3CyNO2quAnLUQMw
         tnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzXodZIvo99nif4/uO2l0vGH+4OrRkEZY+iwXxMdnBM=;
        b=SorFtJPc4E6HfV7jOrgEPSpyybkarAwfN04cQchz1flaQ5cflJ2zcueDd8axwPta5U
         yndlXjsVzknnO3ELvAY6+uIQGGsxwZzNg1k2N/XtpKqH6uU/7DaUvqQTlXycvhZoEg5u
         8kK4OaafmVCVLPzK3WDJVntEXFl7OyqgTj80/sVvXAP5qWmEanHnhrBAjkFGNtHOCh3E
         1L2CKbs5LptAOI17frWY3VIacAV3/cTstNPPd6sMC2JM2C9jk8irvOVrDm8QHC4M0W0j
         Ng9ZilY8hDNvzp7Rh4+MZSeMes5WRBvDiqTmhac2Ae7ltYJG2/6Iw/FR2h5f9j4vsERr
         yibg==
X-Gm-Message-State: AOAM530XFW7Yvx2Oj1QRfNvga268aZmPDqbjiJTI0EcVwlT2c2Ijs23b
        XiAJLGxlJt0Pc+Wj+affgbUpF5QivkEvaLoJ1jM35A==
X-Google-Smtp-Source: ABdhPJwRTuh6FQhXxTiC76/Wl+dIoYJ4gSpt3M/EPd6X8sNVnJPHX8ClET9eQg9/SNGPB/JvGm2kuI/WJLyrrg0Ak0s=
X-Received: by 2002:a25:2155:: with SMTP id h82mr6879793ybh.177.1628802567530;
 Thu, 12 Aug 2021 14:09:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
In-Reply-To: <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 12 Aug 2021 14:09:15 -0700
Message-ID: <CABk29Ns8P9AGy7Tpo6duOeEh=ZFWM1jO8FnvhZhktfcA0GWOpw@mail.gmail.com>
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

> > @@ -697,8 +699,18 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >                 slice = __calc_delta(slice, se->load.weight, load);
> >         }
> >
> > -       if (sched_feat(BASE_SLICE))
> > -               slice = max(slice, (u64)w);
> > +       if (sched_feat(BASE_SLICE)) {
> > +               /*
> > +                * SCHED_IDLE entities are not subject to min_granularity if
> > +                * they are competing with non SCHED_IDLE entities. As a result,
> > +                * non SCHED_IDLE entities will have reduced latency to get back
> > +                * on cpu, at the cost of increased context switch frequency of
> > +                * SCHED_IDLE entities.
> > +                */
>
> Ensuring that the entity will have a minimum runtime has been added to
> ensure that we let enough time to move forward.
> If you exclude sched_idle entities from this min runtime, the
> sched_slice of an idle_entity will be really small.
> I don't have details of your example above but I can imagine that it's
> a 16 cpus system which means a sysctl_sched_min_granularity=3.75ms
> which explains the 4ms running time of an idle entity
> For a 16 cpus system, the sched_slice of an idle_entity in your
> example in the cover letter is: 6*(1+log2(16))*3/1027=87us. Of course
> this become even worse with more threads and cgroups or thread with
> ncie prio -19
>
> This value is then used to set the next hrtimer event in SCHED_HRTICK
> and 87us is too small to make any progress
>
> The 1ms of your test comes from the tick which could be a good
> candidate for a min value or the
> normalized_sysctl_sched_min_granularity which has the advantage of not
> increasing with number of CPU

Fair point, this shouldn't completely ignore min granularity. Something like

unsigned int sysctl_sched_idle_min_granularity = NSEC_PER_MSEC;

(and still only using this value instead of the default
min_granularity when the SCHED_IDLE entity is competing with normal
entities)

> > @@ -4216,7 +4228,15 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> >                 if (sched_feat(GENTLE_FAIR_SLEEPERS))
> >                         thresh >>= 1;
> >
> > -               vruntime -= thresh;
> > +               /*
> > +                * Don't give sleep credit to a SCHED_IDLE entity if we're
> > +                * placing it onto a cfs_rq with non SCHED_IDLE entities.
> > +                */
> > +               if (!se_is_idle(se) ||
> > +                   cfs_rq->h_nr_running == cfs_rq->idle_h_nr_running)
>
> Can't this condition above create unfairness between idle entities ?
> idle thread 1 wake up while normal thread is running
> normal thread thread sleeps immediately after
> idle thread 2 wakes up just after and gets some credits compared to the 1st one.

Yes, this sacrifices some idle<->idle fairness when there is a normal
thread that comes and goes. One alternative is to simply further
reduce thresh for idle entities. That will interfere with idle<->idle
fairness when there are no normal threads, which is why I opted for
the former. On second thought though, the former fairness issue seems
more problematic. Thoughts on applying a smaller sleep credit
threshold universally to idle entities?
