Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F019C30EB54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhBDD6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhBDD6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:58:01 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A9C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 19:57:21 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id z36so452202ooi.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 19:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gn+Te2Ddy1Q0da3d3CM9woO7q+MYTHqhAiqy7SXb4z8=;
        b=VYaOLAZIeewqGowClu7AVM4MGmSO83FmIs7L0PQ8iBl4Ryk6Re5NGf7r3yuTnvmw8C
         DwApXybLf73Ordk0hpaLMePLwABZAFJ2I6jdebCEA3mO0kCdrKmgFgPEQa72PsOl2n9D
         TDpyNnSwdLzrY8ICaZur8zXG1DEgHh9dKXCzgMtSPHNFEZdTGBiys6LspdYs6yyjTru0
         aRZYny4r+amaWA7dIgx+XTv9pHkxhYLJ6z9YFpcNY5u+DJNYeuFIxN/UtpVWCr0G2rkt
         WjM/q8263WcBzaMzmM5F6Q18vDWFtCgKTpqGYCTeh8X4Gjrpe3SLKVp9xZEWf9jMfhj5
         gFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gn+Te2Ddy1Q0da3d3CM9woO7q+MYTHqhAiqy7SXb4z8=;
        b=O5To2mgf5sQ8pAQkZV4zDX8QNRxmY2fAcEu0wCcX6LVt1+3LF6a51hBKUYLjbYTRBB
         QXFcTjjKmve4P+bzVY5SepobtcK/GR0ReqXlibt8qWJ67DsAuFxCPyFstz5WOsKUUo2S
         WKbEtvZAgSClcthA9nilIgsqTti+j+PUZSOjH7HqkOQU8cL8kTtgUY/Q6DmCdNuPsStv
         mTNbFRql9WSFrca8S8s/KDTIPfURbcHHnpFPHaWE2ILUYJ4NRHozF+imFkZiiauBFL+j
         z8T+KXB5ikrDjJoJlmpDkhE0+nzK/z/nh23Ma0iWHitq77o8JDOVxRm/vBgoNIT9vnKJ
         Sb4Q==
X-Gm-Message-State: AOAM530b4wOry3mDTlBRERtHrx7a+y8RaIYh9kYcB53+BXedAX6mlNtA
        2GJIscJQb/s2FnSnp3QIJpmH8iwEWKYqil2WzYs=
X-Google-Smtp-Source: ABdhPJzLQJMI+j7aLhyt96EpRSUPgghilK1vvoGZGqCOEUHhkWslPwERMgG/GKy8l52GIbfkk6U1JaGhL8K73TwrmrI=
X-Received: by 2002:a4a:b387:: with SMTP id p7mr4359953ooo.82.1612411040627;
 Wed, 03 Feb 2021 19:57:20 -0800 (PST)
MIME-Version: 1.0
References: <1608710968-31475-1-git-send-email-ultrachin@163.com>
 <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com>
 <1fefea2e.70bf.176f08d9fae.Coremail.ultrachin@163.com> <CAKfTPtDWARbx=xqwr47iFkEMVo7=+5_o_gMX+h=gAcXZP341oA@mail.gmail.com>
 <61e22917.538b.176f56231f6.Coremail.ultrachin@163.com> <CAKfTPtCSra_kfncR7J_7ona+8MoO0ZX8uTEXvZ7PU7C0pYiM5w@mail.gmail.com>
 <38c1aeee.2d5f.176f9bb0cfb.Coremail.ultrachin@163.com> <CAKfTPtAYoBm1se=HAcsyxwZTQ=XW+HcQJsP3maZy6CNgLSfLZA@mail.gmail.com>
 <4e2f3ac4.2b66.17761bc6eb9.Coremail.ultrachin@163.com> <CAKfTPtByO+GD9rcjJKA8FKuJrSCiobXt8FqoEsBPP0hUvSd-FQ@mail.gmail.com>
 <1b6af75a.106e.17765cee3ad.Coremail.ultrachin@163.com>
In-Reply-To: <1b6af75a.106e.17765cee3ad.Coremail.ultrachin@163.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 4 Feb 2021 11:57:09 +0800
Message-ID: <CAPJCdBkUUOf+88i19ekOLOoYDQJi9VCk3MYTZBVZYshQN-bEaQ@mail.gmail.com>
Subject: Re: [PATCH] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
To:     chin <ultrachin@163.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        heddchen@tencent.com,
        =?UTF-8?B?eGlhb2dnY2hlbijpmYjlsI/lhYkp?= <xiaoggchen@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 3 Feb 2021 at 19:17, chin <ultrachin@163.com> wrote:
>
>
>
>
> At 2021-02-02 23:54:15, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >On Tue, 2 Feb 2021 at 08:56, chin <ultrachin@163.com> wrote:
> >>
> >>
> >>
> >>
> >> At 2021-01-13 16:30:14, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >On Wed, 13 Jan 2021 at 04:14, chin <ultrachin@163.com> wrote:
> >> >>
> >> >>
> >> >>
> >> >>
> >> >> At 2021-01-12 16:18:51, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >> >On Tue, 12 Jan 2021 at 07:59, chin <ultrachin@163.com> wrote:
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >> At 2021-01-11 19:04:19, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >> >> >On Mon, 11 Jan 2021 at 09:27, chin <ultrachin@163.com> wrote:
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> At 2020-12-23 19:30:26, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >> >> >> >On Wed, 23 Dec 2020 at 09:32, <ultrachin@163.com> wrote:
> >> >> >> >> >>
> >> >> >> >> >> From: Chen Xiaoguang <xiaoggchen@tencent.com>
> >> >> >> >> >>
> >> >> >> >> >> Before a CPU switches from running SCHED_NORMAL task to
> >> >> >> >> >> SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other
> >> >> >> >> >
> >> >> >> >> >Could you explain more in detail why you only care about this use case
> >> >> >> >>
> >> >> >> >> >in particular and not the general case?
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> We want to run online tasks using SCHED_NORMAL policy and offline tasks
> >> >> >> >> using SCHED_IDLE policy. The online tasks and the offline tasks run in
> >> >> >> >> the same computer in order to use the computer efficiently.
> >> >> >> >> The online tasks are in sleep in most times but should responce soon once
> >> >> >> >> wake up. The offline tasks are in low priority and will run only when no online
> >> >> >> >> tasks.
> >> >> >> >>
> >> >> >> >> The online tasks are more important than the offline tasks and are latency
> >> >> >> >> sensitive we should make sure the online tasks preempt the offline tasks
> >> >> >> >> as soon as possilbe while there are online tasks waiting to run.
> >> >> >> >> So in our situation we hope the SCHED_NORMAL to run if has any.
> >> >> >> >>
> >> >> >> >> Let's assume we have 2 CPUs,
> >> >> >> >> In CPU1 we got 2 SCHED_NORMAL tasks.
> >> >> >> >> in CPU2 we got 1 SCHED_NORMAL task and 2 SCHED_IDLE tasks.
> >> >> >> >>
> >> >> >> >>              CPU1                      CPU2
> >> >> >> >>         curr       rq1            curr          rq2
> >> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> >> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >> >>
> >> >> >> >>                                  NORMAL exits or blocked
> >> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> >> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >> >>
> >> >> >> >>                                  pick_next_task_fair
> >> >> >> >>       +------+ | +------+         +----+ | +----+
> >> >> >> >> t2    |NORMAL| | |NORMAL|         |IDLE| | |IDLE|
> >> >> >> >>       +------+ | +------+         +----+ | +----+
> >> >> >> >>
> >> >> >> >>                                  SCHED_IDLE running
> >> >> >> >> t3    +------+ | +------+        +----+  | +----+
> >> >> >> >>       |NORMAL| | |NORMAL|        |IDLE|  | |IDLE|
> >> >> >> >>       +------+ | +------+        +----+  | +----+
> >> >> >> >>
> >> >> >> >>                                  run_rebalance_domains
> >> >> >> >>       +------+ |                +------+ | +----+ +----+
> >> >> >> >> t4    |NORMAL| |                |NORMAL| | |IDLE| |IDLE|
> >> >> >> >>       +------+ |                +------+ | +----+ +----+
> >> >> >> >>
> >> >> >> >> As we can see
> >> >> >> >> t1: NORMAL task in CPU2 exits or blocked
> >> >> >> >> t2: CPU2 pick_next_task_fair would pick a SCHED_IDLE to run while
> >> >> >> >> another SCHED_NORMAL in rq1 is waiting.
> >> >> >> >> t3: SCHED_IDLE run in CPU2 while a SCHED_NORMAL wait in CPU1.
> >> >> >> >> t4: after a short time, periodic load_balance triggerd and pull
> >> >> >> >> SCHED_NORMAL in rq1 to rq2, and SCHED_NORMAL likely preempts SCHED_IDLE.
> >> >> >> >>
> >> >> >> >> In this scenario, SCHED_IDLE is running while SCHED_NORMAL is waiting to run.
> >> >> >> >> The latency of this SCHED_NORMAL will be high which is not acceptble.
> >> >> >> >>
> >> >> >> >> Do a load_balance before running the SCHED_IDLE may fix this problem.
> >> >> >> >>
> >> >> >> >> This patch works as below:
> >> >> >> >>
> >> >> >> >>              CPU1                      CPU2
> >> >> >> >>         curr       rq1            curr          rq2
> >> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> >> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >> >>
> >> >> >> >>                                  NORMAL exits or blocked
> >> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> >> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >> >>
> >> >> >> >> t2                            pick_next_task_fair (all se are SCHED_IDLE)
> >> >> >> >>
> >> >> >> >>                                  newidle_balance
> >> >> >> >>       +------+ |                 +------+ | +----+ +----+
> >> >> >> >> t3    |NORMAL| |                 |NORMAL| | |IDLE| |IDLE|
> >> >> >> >>       +------+ |                 +------+ | +----+ +----+
> >> >> >> >>
> >> >> >> >>
> >> >> >> >> t1: NORMAL task in CPU2 exits or blocked
> >> >> >> >> t2: pick_next_task_fair check all se in rbtree are SCHED_IDLE and calls
> >> >> >> >> newidle_balance who tries to pull a SCHED_NORMAL(if has).
> >> >> >> >> t3: pick_next_task_fair would pick a SCHED_NORMAL to run instead of
> >> >> >> >> SCHED_IDLE(likely).
> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> >> CPU by doing load_balance first.
> >> >> >> >> >>
> >> >> >> >> >> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> >> >> >> >> >> Signed-off-by: Chen He <heddchen@tencent.com>
> >> >> >> >> >> ---
> >> >> >> >> >>  kernel/sched/fair.c | 5 +++++
> >> >> >> >> >>  1 file changed, 5 insertions(+)
> >> >> >> >> >>
> >> >> >> >> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> >> >> >> >> index ae7ceba..0a26132 100644
> >> >> >> >> >> --- a/kernel/sched/fair.c
> >> >> >> >> >> +++ b/kernel/sched/fair.c
> >> >> >> >> >> @@ -7004,6 +7004,11 @@ struct task_struct *
> >> >> >> >> >>         struct task_struct *p;
> >> >> >> >> >>         int new_tasks;
> >> >> >> >> >>
> >> >> >> >> >> +       if (prev &&
> >> >> >> >> >> +           fair_policy(prev->policy) &&
> >> >> >> >> >
> >> >> >> >> >Why do you need a prev and fair task  ? You seem to target the special
> >> >> >> >> >case of pick_next_task  but in this case why not only testing rf!=null
> >> >> >> >> > to make sure to not return immediately after jumping to the idle
> >> >> >> >>
> >> >> >> >> >label?
> >> >> >> >> We just want to do load_balance only when CPU switches from SCHED_NORMAL
> >> >> >> >> to SCHED_IDLE.
> >> >> >> >> If not check prev, when the running tasks are all SCHED_IDLE, we would
> >> >> >> >> do newidle_balance everytime in pick_next_task_fair, it makes no sense
> >> >> >> >> and kind of wasting.
> >> >> >> >
> >> >> >> >I agree that calling newidle_balance every time pick_next_task_fair is
> >> >> >> >called when there are only sched_idle tasks is useless.
> >> >> >> >But you also have to take into account cases where there was another
> >> >> >> >class of task running on the cpu like RT one. In your example above,
> >> >> >> >if you replace the normal task on CPU2 by a RT task, you still want to
> >> >> >>
> >> >> >> >pick the normal task on CPU1 once RT task goes to sleep.
> >> >> >> Sure, this case should be taken into account,  we should also try to
> >> >> >> pick normal task in this case.
> >> >> >>
> >> >> >> >
> >> >> >> >Another point that you will have to consider the impact on
> >> >> >> >rq->idle_stamp because newidle_balance is assumed to be called before
> >> >> >>
> >> >> >> >going idle which is not the case anymore with your use case
> >> >> >> Yes. rq->idle_stamp should not be changed in this case.
> >> >> >>
> >> >> >>
> >> >> >>
> >> >> >> Actually we want to pull a SCHED_NORMAL task (if possible) to run when a cpu is
> >> >> >> about to run SCHED_IDLE task. But currently newidle_balance is not
> >> >> >> designed for SCHED_IDLE  so SCHED_IDLE can also be pulled which
> >> >> >> is useless in our situation.
> >> >> >
> >> >> >newidle_balance will pull a sched_idle task only if there is an
> >> >> >imbalance which is the right thing to do IMO to ensure fairness
> >> >> >between sched_idle tasks.  Being a sched_idle task doesn't mean that
> >> >> >we should break the fairness
> >> >> >
> >> >> >>
> >> >> >> So we plan to add a new function sched_idle_balance which only try to
> >> >> >> pull SCHED_NORMAL tasks from the busiest cpu. And we will call
> >> >> >> sched_idle_balance when the previous task is normal or RT and
> >> >> >> hoping we can pull a SCHED_NORMAL task to run.
> >> >> >>
> >> >> >> Do you think it is ok to add a new sched_idle_balance?
> >> >> >
> >> >> >I don't see any reason why the scheduler should not pull a sched_idle
> >> >> >task if there is an imbalance. That will happen anyway during the next
> >> >>
> >> >> >periodic load balance
> >> >> OK. We should not pull the SCHED_IDLE tasks only in load_balance.
> >> >>
> >> >>
> >> >> Do you think it make sense to do an extra load_balance when cpu is
> >> >> about to run SCHED_IDLE task (switched from normal/RT)?
> >> >
> >> >I'm not sure to get your point here.
> >> >Do you mean if a sched_idle task is picked to become the running task
> >> >whereas there are runnable normal tasks ? This can happen if normal
> >> >tasks are long running tasks. We should not in this case. The only
> >> >case is when the running task, which is not a sched_idle task but a
> >> >normal/rt/deadline one, goes to sleep and there are only sched_idle
> >> >tasks enqueued. In this case and only in this case, we should trigger
> >> >a load_balance to get a chance to pull a waiting normal task from
> >> >another CPU.
> >> >
> >> >This means checking this state in pick_next_task_fair() and in balance_fair()
> >>
> >> We made another change would you please give some comments?
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 04a3ce2..2357301 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -7029,6 +7029,10 @@ struct task_struct *
> >>         struct task_struct *p;
> >>         int new_tasks;
> >>
> >> +       if (sched_idle_rq(rq) && prev && prev->state &&
> >> +           prev->policy != SCHED_IDLE)
> >> +               goto idle;
> >> +
> >>  again:
> >>         if (!sched_fair_runnable(rq))
> >>                 goto idle;
> >> @@ -10571,7 +10575,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> >>          * We must set idle_stamp _before_ calling idle_balance(), such that we
> >>          * measure the duration of idle_balance() as idle time.
> >>          */
> >> -       this_rq->idle_stamp = rq_clock(this_rq);
> >> +       if (!rq->nr_running)
> >> +               this_rq->idle_stamp = rq_clock(this_rq);
> >
> >I know that I asked you to take care of not setting idle_stamp during
> >the last review. But I forgot that it was cleared anyway at the end of
> >newidle_balance() if there is some tasks running on the cpu so this is
>
> >not needed and make the code less readable
> Yes, the idle_stamp was cleared.
>
> >
> >>
> >>         /*
> >>          * Do not pull tasks towards !active CPUs...
> >>
> >
> >I don't see the change for balance_fair()
> >When a rt task goes back to sleep and there is only sched_idle tasks
>
> >as an example
>
>
> Yes, we should consider this situation too.
> How about this one ?
>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce2..982b842 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6849,6 +6849,9 @@ static void task_dead_fair(struct task_struct *p)
>  static int
>  balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> +       if (sched_idle_rq(rq))
> +               return newidle_balance(rq, rf) != 0;
> +
>         if (rq->nr_running)
>                 return 1;
>
Maybe we'd better merge the branches? like,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ac950ac950bc..259deda79c06 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6852,7 +6852,7 @@ static void task_dead_fair(struct task_struct *p)
 static int
 balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-       if (rq->nr_running)
+       if (rq->nr_running && !sched_idle_rq(rq))
                return 1;

        return newidle_balance(rq, rf) != 0;

Thx.
Regards,
Jiang
