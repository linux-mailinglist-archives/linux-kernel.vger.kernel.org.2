Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EC13EF64B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 01:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbhHQXtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 19:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbhHQXtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 19:49:03 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE233C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:48:29 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i8so1651593ybt.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 16:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ruCuBgidAKme8j3gKc5mm5PTWGKuwLs1uxQ0UycwARs=;
        b=THv5BQZE/OYwcyNNTfXu+dW4fBPaVUfJYfaovW/nID1gkcDO5mRLCwDSIA2cTJD9Gy
         yZLjRyEGVQ83tQI/EOSLd9d1N3RVt77StJUxAO0Lnc2p2N1SU+GuVAjToYIADH5ZNBIO
         hKufPQTZ5ZfCTRKmjMJXKqWrkeLgrdCS22/o8GQaTjtRpAKjMBSDo4kfwxY/F/hL9cMz
         YlQeLb49Y3URBO+OzLxKOV15dAqfc0qndjUctR1acum4mqM2ICQUeJK0eZtOG1FMF/r4
         nQGhGlZ6+xYFvH1WVOTiSPe/kFIiZBSE7qrL9cIlyddJA7XiN2VnzLVV6Tst6iZ+F88P
         ZWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ruCuBgidAKme8j3gKc5mm5PTWGKuwLs1uxQ0UycwARs=;
        b=KrXPBwiv/mBmSCl4dAYz30PJo/3rCms4srNjVD2CNMSptBl5TdnnYKcc7lWyWluamz
         yUmdEgQS2GHH2SOtM3NdlQ0V9uwXEbEFrk3A2b2ULMRQ7OgIywj73jhbE/hINqhv0pdS
         QA6AENk0Dq32ea7EMEebl5xbGKiPAFMHF6ZbUKIlVly4GGcWkAAE1yu+K0gRtgSP1j3a
         DPRsEx5OCxY9b1K8tK7gE3ojBKKhQeeIR/6oUi2MWLZ+HROv4yppl+OHwEeP+PBjE8fb
         uzRlYleYrICAstUJuN1zEbuiMUX1MrG1g4I3WqLPmC2TmNi0jgbli3D+32z7DTQnXGGh
         iV8Q==
X-Gm-Message-State: AOAM533PMjrPuaGKhI4VmEVKPRQ6LFRIjm75jNyC1a2hB4yjNwH9mGxD
        4cdZETdk54ziv+iOxZsF3c2dX3o6ftQg7N798iiKYQ==
X-Google-Smtp-Source: ABdhPJzKVdrAX/aQ1RvLfYTVEQaTDkz0hKV9E7sZH+LihTXH1Nk/VKataicUZ0hJMp7gBwARsS3M29c6p6hu+VeAc6k=
X-Received: by 2002:a5b:7c4:: with SMTP id t4mr7267675ybq.368.1629244108670;
 Tue, 17 Aug 2021 16:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-3-joshdon@google.com>
 <CAKfTPtCTjhpkYz_eVr0LxcJavh__KHn2zOudD=QB5gKYZK8DtQ@mail.gmail.com>
 <CABk29Ns8P9AGy7Tpo6duOeEh=ZFWM1jO8FnvhZhktfcA0GWOpw@mail.gmail.com> <YRpavaMk09iw0fkE@hirez.programming.kicks-ass.net>
In-Reply-To: <YRpavaMk09iw0fkE@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 17 Aug 2021 16:48:17 -0700
Message-ID: <CABk29NsVf9rLz_2k+aM8Uw29_Xm+J54=dUtWdHBD4+V+hRG+wA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched: adjust SCHED_IDLE interactions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
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

Hi Peter,

On Mon, Aug 16, 2021 at 5:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Aug 12, 2021 at 02:09:15PM -0700, Josh Don wrote:
> > > > @@ -697,8 +699,18 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > >                 slice = __calc_delta(slice, se->load.weight, load);
> > > >         }
> > > >
> > > > -       if (sched_feat(BASE_SLICE))
> > > > -               slice = max(slice, (u64)w);
> > > > +       if (sched_feat(BASE_SLICE)) {
> > > > +               /*
> > > > +                * SCHED_IDLE entities are not subject to min_granularity if
> > > > +                * they are competing with non SCHED_IDLE entities. As a result,
> > > > +                * non SCHED_IDLE entities will have reduced latency to get back
> > > > +                * on cpu, at the cost of increased context switch frequency of
> > > > +                * SCHED_IDLE entities.
> > > > +                */
> > >
> > > Ensuring that the entity will have a minimum runtime has been added to
> > > ensure that we let enough time to move forward.
> > > If you exclude sched_idle entities from this min runtime, the
> > > sched_slice of an idle_entity will be really small.
> > > I don't have details of your example above but I can imagine that it's
> > > a 16 cpus system which means a sysctl_sched_min_granularity=3.75ms
> > > which explains the 4ms running time of an idle entity
> > > For a 16 cpus system, the sched_slice of an idle_entity in your
> > > example in the cover letter is: 6*(1+log2(16))*3/1027=87us. Of course
> > > this become even worse with more threads and cgroups or thread with
> > > ncie prio -19
> > >
> > > This value is then used to set the next hrtimer event in SCHED_HRTICK
> > > and 87us is too small to make any progress
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
> TICK_NSEC ?

Based on discussion with Vincent, added a separate
sched_idle_min_granularity. Didn't make sense to me to define in terms
of TICK_NSEC, since e.g. we wouldn't necessarily want a smaller slice
on a higher HZ machine.
