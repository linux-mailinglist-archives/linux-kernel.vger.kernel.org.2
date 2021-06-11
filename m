Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093263A4B43
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 01:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFKXh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 19:37:56 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:46906 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFKXht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 19:37:49 -0400
Received: by mail-qk1-f176.google.com with SMTP id f70so17531133qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4qZf12D8W9yRdYaj3C8cSY/uNFZwCJrTHaVjY/XCRw=;
        b=ipexf1WfSqTSigpJIAqWcZ5Ye8IVPeBLkVKvrmCxmMyzi+efAgucuvp/5srXci7Sb0
         BQGkXAo5Ea25cYm/98RmfUM8jw3DFu1D+yB6clmD4OdoEnjcgJv7dt2Ld9yfCPC7dqs5
         DiToSNCr4dGCsobEOu23KhBdiEEvAyvTT7lqZ33E8Z+JCj7AEzLfWmDMGd+jWC5hlPnw
         RL844vPi1AMDMg7V8espJidZGxbiJTVK6mwK8ijFWqb4fOhtV96O1SgcZ/20cRnKC0F9
         ZW4ckMcgwWv6MN2ONrXfOXAsCo9ENlBG1R/uj8f21SV0Yk1ZqXCOd3byMTvOA4sFGjwJ
         WT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4qZf12D8W9yRdYaj3C8cSY/uNFZwCJrTHaVjY/XCRw=;
        b=au6FhGsvTGt1alaTUSWuhS8iSorl8gPyvonAFmt36Occgo24Cz2U5Zg5GPB+oXbD91
         iNind8uSOm/rKszT4tuIVgtleq3D9bpAqZOu264rfLgioHw6Niyo5i8TQtn2e+t8CtYA
         p8XnsTeT3gqsS2x8TsQ1p+mvJsKcKXU4/tnyUtmTss28D4St0QAYpd/3sqqqQ5Vsgcz9
         e873bnaBleF9oAltyQO8ochyBaHB2RRPqqu7Xq+vvAZEeVa6eTeb3vURG7fu7dZpjkSG
         RkJHNAsih3MtWUbdLl5Y82ikDY2TCVLQJsdK+zXZ/0hP9NcyfJSfGcrUtT7kEd5XDqKS
         2v1A==
X-Gm-Message-State: AOAM532vEYeUoZamN3jmBct9z7GumVh1MS0y0nF/stmQuLVrlxaSJ7AI
        EPufZC5/T0GrO1XciDrsExC1NdBSemInqmWP2UzC1Q==
X-Google-Smtp-Source: ABdhPJyBCg4hbLYR7Ob02mn9olvwahPRTIPrX3NizTVs4qE4MwGGjb7WUBzPPZwoFbAEivu/2ku21uKs56Ctm8N1cAo=
X-Received: by 2002:a37:59c7:: with SMTP id n190mr6470074qkb.146.1623454478447;
 Fri, 11 Jun 2021 16:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210608231132.32012-1-joshdon@google.com> <e3fc3338-c469-0c0c-ada2-a0bbc9f969fe@arm.com>
 <CABk29Nu=mxz3tugjhDV9xCF7DRsMi9U747H+BqubviEva36RUw@mail.gmail.com> <7222c20a-5cbb-d443-a2fd-19067652a38e@arm.com>
In-Reply-To: <7222c20a-5cbb-d443-a2fd-19067652a38e@arm.com>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 11 Jun 2021 16:34:27 -0700
Message-ID: <CABk29NtVRG8cotfbK=R0kKXuKCnkEG514H=6ncri=CM8Qr9uiQ@mail.gmail.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 9:43 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 10/06/2021 21:14, Josh Don wrote:
> > Hey Dietmar,
> >
> > On Thu, Jun 10, 2021 at 5:53 AM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> Any reason why this should only work on cgroup-v2?
> >
> > My (perhaps incorrect) assumption that new development should not
> > extend v1. I'd actually prefer making this work on v1 as well; I'll
> > add that support.
> >
> >> struct cftype cpu_legacy_files[] vs. cpu_files[]
> >>
> >> [...]
> >>
> >>> @@ -11340,10 +11408,14 @@ void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
> >>>
> >>>  static DEFINE_MUTEX(shares_mutex);
> >>>
> >>> -int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> >>> +#define IDLE_WEIGHT sched_prio_to_weight[ARRAY_SIZE(sched_prio_to_weight) - 1]
> >>
> >> Why not 3 ? Like for tasks (WEIGHT_IDLEPRIO)?
> >>
> >> [...]
> >
> > Went back and forth on this; on second look, I do think it makes sense
> > to use the IDLEPRIO weight of 3 here. This gets converted to a 0,
> > rather than a 1 for display of cpu.weight, which is also actually a
> > nice property.
>
> I'm struggling to see the benefit here.
>
> For a taskgroup A: Why setting A/cpu.idle=1 to force a minimum A->shares
> when you can set it directly via A/cpu.weight (to 1 (minimum))?
>
> WEIGHT     cpu.weight   tg->shares
>
> 3          0            3072
>
> 15         1            15360
>
>            1            10240
>
> `A/cpu.weight` follows cgroup-v2's `weights` `resource distribution
> model`* but I can only see `A/cpu.idle` as a layer on top of it forcing
> `A/cpu.weight` to get its minimum value?
>
> *Documentation/admin-guide/cgroup-v2.rst

Setting cpu.idle carries additional properties in addition to just the
weight. Currently, it primarily includes (a) special wakeup preemption
handling, and (b) contribution to idle_h_nr_running for the purpose of
marking a cpu as a sched_idle_cpu(). Essentially, the current
SCHED_IDLE mechanics. I've also discussed with Peter a potential
extension to SCHED_IDLE to manipulate vruntime.

We set the cgroup weight here, since by definition SCHED_IDLE entities
have the least scheduling weight. From the perspective of your
question, the analogous statement for tasks would be that we set task
weight to the min when doing setsched(SCHED_IDLE), even though we
already have a renice mechanism.
