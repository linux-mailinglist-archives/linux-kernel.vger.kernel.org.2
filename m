Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650713AA85B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFQBEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhFQBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:04:19 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6684FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:02:11 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id u20so3473356qtx.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V60FAIdwpRuq7i04YiGCgFlyof6pScSFtvGQvRXWUdk=;
        b=BI53e5Dlvr281LKLOlpIuAolvA0Y7t9NryNGS9dc8HvcR+eIOcXZeaESFKfvWgHpCg
         8AJpxgc6EAI1cdYUY///BpVT9F1F2Yx6emJQrRdYeYckCCmiVBtjYI+1JLNLnZWuxXD4
         wzc9vZABt4WH0Hr7L64R134+gqb+Wibt4GvkWiawOBkbfzYwtsOyDz7SYZnUFr/FYPoh
         wijyqLcnvSoLLsEPImDCyXkn7y11VSIhdRYt4+47Q/GaUxC6W7dgaW+7fnyIS9xSqi/f
         f8LwcLloAgWWLqUsSb2k4LHGwmJt/Qz8BcTdxXNhxEDb4Kj9LUs9YNROVPK6UCwG8dbB
         0HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V60FAIdwpRuq7i04YiGCgFlyof6pScSFtvGQvRXWUdk=;
        b=XbuFvl3CMRu3iM1E1z3JkXvpMnZ6xmCQBDwNSVypAEVZMtl54pcrYBrAxjx3UQfdZ6
         j5qi2/uqaLsVIP05PLVGvE1IrRYdnHHP9Ju6TNiPqK23vYgZsGjv+nmJMTiPRilAf46r
         wWNxUmLF6DNquyylnSOfE8iMrFYKh1at9q3SNwbvk/HMD2jETbTOsIGqefbWAQvtK86U
         Q6jDqWCa3DGWkTjFd4b1F1DLvPu8C/1gtw2NIivesoYZeusvgyfGb7dJ458ezaEQ0Sw/
         wPtyxpnRbbb6GsytfibMS2O3mnkP02rJutbyY71QoYD002IZXuMILPAk1zeJzA4DDWoq
         HgTA==
X-Gm-Message-State: AOAM532v7Zd5Gu3EPTkQSUo+26l5PDS/lc90INGwnQf36SV+SRwsmtav
        nrDPCK44wjnSS8c2V02PV9rXH93bh42hENilKQcskg==
X-Google-Smtp-Source: ABdhPJxssU4BEEs8oDkkNcTl7zTEvFfaLouKo/5hp9PLxFb4AorucmdYnxwMqNkRXpz/PQNMcwun+XOLeK8Zm3hiQZM=
X-Received: by 2002:ac8:5d55:: with SMTP id g21mr2615210qtx.101.1623891730223;
 Wed, 16 Jun 2021 18:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210608231132.32012-1-joshdon@google.com> <YMobzbLecaFYuLtq@slm.duckdns.org>
In-Reply-To: <YMobzbLecaFYuLtq@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Wed, 16 Jun 2021 18:01:59 -0700
Message-ID: <CABk29NtcRUwskBjrvLKkEKQ0hpNPSrdzrGAGZy+bHSfnznOUSg@mail.gmail.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tejun,

Thanks for taking a look.

On Wed, Jun 16, 2021 at 8:42 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jun 08, 2021 at 04:11:32PM -0700, Josh Don wrote:
> > This extends SCHED_IDLE to cgroups.
> >
> > Interface: cgroup/cpu.idle.
> >  0: default behavior
> >  1: SCHED_IDLE
> >
> > Extending SCHED_IDLE to cgroups means that we incorporate the existing
> > aspects of SCHED_IDLE; a SCHED_IDLE cgroup will count all of its
> > descendant threads towards the idle_h_nr_running count of all of its
> > ancestor cgroups. Thus, sched_idle_rq() will work properly.
> > Additionally, SCHED_IDLE cgroups are configured with minimum weight.
> >
> > There are two key differences between the per-task and per-cgroup
> > SCHED_IDLE interface:
> >
> > - The cgroup interface allows tasks within a SCHED_IDLE hierarchy to
> > maintain their relative weights. The entity that is "idle" is the
> > cgroup, not the tasks themselves.
> >
> > - Since the idle entity is the cgroup, our SCHED_IDLE wakeup preemption
> > decision is not made by comparing the current task with the woken task,
> > but rather by comparing their matching sched_entity.
> >
> > A typical use-case for this is a user that creates an idle and a
> > non-idle subtree. The non-idle subtree will dominate competition vs
> > the idle subtree, but the idle subtree will still be high priority
> > vs other users on the system. The latter is accomplished via comparing
> > matching sched_entity in the waken preemption path (this could also be
> > improved by making the sched_idle_rq() decision dependent on the
> > perspective of a specific task).
>
> A high-level problem that I see with the proposal is that this would bake
> the current recursive implementation into the interface. The semantics of
> the currently exposed interface, at least the weight based part, is abstract
> and doesn't necessarily dictate how the scheduling is actually performed.
> Adding this would mean that we're now codifying the current behavior of
> fully nested scheduling into the interface.
>
> There are several practical challenges with the current implementation
> caused by the full nesting - e.g. nesting levels are expensive for context
> switch heavy applicaitons often going over >1% per level, and heuristics
> which assume global queue may behave unexpectedly - ie. we can create
> conditions where things like idle-wakeup boost behave very differently
> depending on whether tasks are inside a cgroup or not even when the eventual
> relative weights and past usages are similar.

To be clear, are you talking mainly about the idle_h_nr_running
accounting? The fact that setting cpu.idle propagates changes upwards
to ancestor cgroups?

The goal is to match the SCHED_IDLE semantics here, which requires
this behavior. The end result is no different than a nested cgroup
with SCHED_IDLE tasks. One possible alternative would be to only count
root-level cpu.idle cgroups towards the overall idle_h_nr_running.
I've not opted for that, in order to make this work more similarly to
the task interface. Also note that there isn't additional overhead
from the accounting, since enqueue/dequeue already traverses these
nesting levels.

Could you elaborate a bit more on your statement here?

> Can you please give more details on why this is beneficial? Is the benefit
> mostly around making configuration easy or are there actual scheduling
> behaviors that you can't achieve otherwise?

There are actual scheduling behaviors that cannot be achieved without
the cgroup interface. The task SCHED_IDLE mechanism is a combination
of special SCHED_IDLE handling (idle_h_nr_running,
check_preempt_wakeup), and minimum scheduling weight.

Consider a tree like

                  root
             /             \
            A              C
        /      \             |
      B       idle       t4
     |           |     \
     t1         t2   t3

Here, 'idle' is our cpu.idle cgroup. The following properties would
not be possible if we moved t2/t3 into SCHED_IDLE without the cgroup
interface:
- t1 always preempts t2/t3 on wakeup, but t4 does not
- t2 and t3 have different, non-minimum weights. Technically we could
also achieve this by adding another layer of nested cgroups, but that
starts to make the hierarchy much more complex.
- I've also discussed with Peter a possible extension (vruntime
adjustments) to the current SCHED_IDLE semantics. Similarly to the
first bullet here, we'd need a cgroup idle toggle to achieve certain
scheduling behaviors with this.

Thanks,
Josh
