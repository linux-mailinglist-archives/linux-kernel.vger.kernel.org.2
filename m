Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11EC30C4AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbhBBP6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbhBBPzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:55:10 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F512C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 07:54:29 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id m22so17101428ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGytnLtnxqh7JiX+DkpOLlQRPcJydT52TgqG19B19Zs=;
        b=mUwgBRRroiz9lXwTy0FwfVkBk/oikUgsD9NUa2+AVsURZLc8fa7G1yjkygP5XvUZf3
         8KV6V3iptxmPNK3dF2GkqEC0cUgj7UPJwvNT1yZmcpQ/njizEK59XSw2zwFRVOrShzoQ
         HwCEDCW8CXaWVFmW7rO+AcVLRmKCPtjdyhvWL/h/ngl90EA4u8iXWHBwG1JjUIUzJNdf
         Vj26h2xiekS/h0MSa4Vcy/wbn3jgUyfUzajrpGchyD/Vy74mv273HZ47jxQjh5dj0VWV
         8D1VKtwLK/V94nFGbL25pEOtR7D9GfIxu9X7AwxpSZb7ZKr2mCuHuqFhhTg5dlFNP3BT
         Kx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGytnLtnxqh7JiX+DkpOLlQRPcJydT52TgqG19B19Zs=;
        b=NGnfgqocbCtIPCwt4vypi8cbcSbKDmAOCtXlRm+pmoSZNiqG8clSRXmFljFDFAmIQZ
         +zhnzF9NOnVCSbACsU/mImWlVYoxiTcaTCLGQhcxSpq3iOnlwxO2LkT8/vebRB7Gh3oy
         v5whXK8pRnAHAudquEFrIek5OWwxJ+uY2kF0vF4wRBe3BbCwJqoUlAnwzN8WxCcz1aGi
         gYP/laA/ug0egGc/sTY9Bhul38UbqDv+IfZ/BjZus537Gd4t9l0WMhsfW21gCANDTRmi
         OpQknAlSR0HA8c1dSvlGsCw5WoC7KT88qg9qpDuaZMf2OyzJrwWUrxQAUeGQubZ5rLoK
         D7fg==
X-Gm-Message-State: AOAM533XloHfGDs6HU09w7aC1+WYiXi9jOEL+zxsfI1Ayyl2tPzN9cP4
        6LUDxEfXKZJ3Ea1iQ3unh7Ada3lRnxPXENFczl7WykevyTxy1g==
X-Google-Smtp-Source: ABdhPJx4PwBHuiPZDgOmoKZEQpbI0e/n6rpSfnl6OdocPYvfS1bPxq2tQegfbQ8L/xvLexkXkI5ng6B8KjPZz3Dzvr0=
X-Received: by 2002:a2e:9857:: with SMTP id e23mr13419832ljj.209.1612281266807;
 Tue, 02 Feb 2021 07:54:26 -0800 (PST)
MIME-Version: 1.0
References: <1608710968-31475-1-git-send-email-ultrachin@163.com>
 <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com>
 <1fefea2e.70bf.176f08d9fae.Coremail.ultrachin@163.com> <CAKfTPtDWARbx=xqwr47iFkEMVo7=+5_o_gMX+h=gAcXZP341oA@mail.gmail.com>
 <61e22917.538b.176f56231f6.Coremail.ultrachin@163.com> <CAKfTPtCSra_kfncR7J_7ona+8MoO0ZX8uTEXvZ7PU7C0pYiM5w@mail.gmail.com>
 <38c1aeee.2d5f.176f9bb0cfb.Coremail.ultrachin@163.com> <CAKfTPtAYoBm1se=HAcsyxwZTQ=XW+HcQJsP3maZy6CNgLSfLZA@mail.gmail.com>
 <4e2f3ac4.2b66.17761bc6eb9.Coremail.ultrachin@163.com>
In-Reply-To: <4e2f3ac4.2b66.17761bc6eb9.Coremail.ultrachin@163.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 2 Feb 2021 16:54:15 +0100
Message-ID: <CAKfTPtByO+GD9rcjJKA8FKuJrSCiobXt8FqoEsBPP0hUvSd-FQ@mail.gmail.com>
Subject: Re: [PATCH] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
To:     chin <ultrachin@163.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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

On Tue, 2 Feb 2021 at 08:56, chin <ultrachin@163.com> wrote:
>
>
>
>
> At 2021-01-13 16:30:14, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >On Wed, 13 Jan 2021 at 04:14, chin <ultrachin@163.com> wrote:
> >>
> >>
> >>
> >>
> >> At 2021-01-12 16:18:51, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >On Tue, 12 Jan 2021 at 07:59, chin <ultrachin@163.com> wrote:
> >> >>
> >> >>
> >> >>
> >> >>
> >> >> At 2021-01-11 19:04:19, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >> >On Mon, 11 Jan 2021 at 09:27, chin <ultrachin@163.com> wrote:
> >> >> >>
> >> >> >>
> >> >> >> At 2020-12-23 19:30:26, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> >> >> >> >On Wed, 23 Dec 2020 at 09:32, <ultrachin@163.com> wrote:
> >> >> >> >>
> >> >> >> >> From: Chen Xiaoguang <xiaoggchen@tencent.com>
> >> >> >> >>
> >> >> >> >> Before a CPU switches from running SCHED_NORMAL task to
> >> >> >> >> SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other
> >> >> >> >
> >> >> >> >Could you explain more in detail why you only care about this use case
> >> >> >>
> >> >> >> >in particular and not the general case?
> >> >> >>
> >> >> >>
> >> >> >> We want to run online tasks using SCHED_NORMAL policy and offline tasks
> >> >> >> using SCHED_IDLE policy. The online tasks and the offline tasks run in
> >> >> >> the same computer in order to use the computer efficiently.
> >> >> >> The online tasks are in sleep in most times but should responce soon once
> >> >> >> wake up. The offline tasks are in low priority and will run only when no online
> >> >> >> tasks.
> >> >> >>
> >> >> >> The online tasks are more important than the offline tasks and are latency
> >> >> >> sensitive we should make sure the online tasks preempt the offline tasks
> >> >> >> as soon as possilbe while there are online tasks waiting to run.
> >> >> >> So in our situation we hope the SCHED_NORMAL to run if has any.
> >> >> >>
> >> >> >> Let's assume we have 2 CPUs,
> >> >> >> In CPU1 we got 2 SCHED_NORMAL tasks.
> >> >> >> in CPU2 we got 1 SCHED_NORMAL task and 2 SCHED_IDLE tasks.
> >> >> >>
> >> >> >>              CPU1                      CPU2
> >> >> >>         curr       rq1            curr          rq2
> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >>
> >> >> >>                                  NORMAL exits or blocked
> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >>
> >> >> >>                                  pick_next_task_fair
> >> >> >>       +------+ | +------+         +----+ | +----+
> >> >> >> t2    |NORMAL| | |NORMAL|         |IDLE| | |IDLE|
> >> >> >>       +------+ | +------+         +----+ | +----+
> >> >> >>
> >> >> >>                                  SCHED_IDLE running
> >> >> >> t3    +------+ | +------+        +----+  | +----+
> >> >> >>       |NORMAL| | |NORMAL|        |IDLE|  | |IDLE|
> >> >> >>       +------+ | +------+        +----+  | +----+
> >> >> >>
> >> >> >>                                  run_rebalance_domains
> >> >> >>       +------+ |                +------+ | +----+ +----+
> >> >> >> t4    |NORMAL| |                |NORMAL| | |IDLE| |IDLE|
> >> >> >>       +------+ |                +------+ | +----+ +----+
> >> >> >>
> >> >> >> As we can see
> >> >> >> t1: NORMAL task in CPU2 exits or blocked
> >> >> >> t2: CPU2 pick_next_task_fair would pick a SCHED_IDLE to run while
> >> >> >> another SCHED_NORMAL in rq1 is waiting.
> >> >> >> t3: SCHED_IDLE run in CPU2 while a SCHED_NORMAL wait in CPU1.
> >> >> >> t4: after a short time, periodic load_balance triggerd and pull
> >> >> >> SCHED_NORMAL in rq1 to rq2, and SCHED_NORMAL likely preempts SCHED_IDLE.
> >> >> >>
> >> >> >> In this scenario, SCHED_IDLE is running while SCHED_NORMAL is waiting to run.
> >> >> >> The latency of this SCHED_NORMAL will be high which is not acceptble.
> >> >> >>
> >> >> >> Do a load_balance before running the SCHED_IDLE may fix this problem.
> >> >> >>
> >> >> >> This patch works as below:
> >> >> >>
> >> >> >>              CPU1                      CPU2
> >> >> >>         curr       rq1            curr          rq2
> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> >> >> >>
> >> >> >>                                  NORMAL exits or blocked
> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> >> >> >>       +------+ | +------+                | +----+ +----+
> >> >> >>
> >> >> >> t2                            pick_next_task_fair (all se are SCHED_IDLE)
> >> >> >>
> >> >> >>                                  newidle_balance
> >> >> >>       +------+ |                 +------+ | +----+ +----+
> >> >> >> t3    |NORMAL| |                 |NORMAL| | |IDLE| |IDLE|
> >> >> >>       +------+ |                 +------+ | +----+ +----+
> >> >> >>
> >> >> >>
> >> >> >> t1: NORMAL task in CPU2 exits or blocked
> >> >> >> t2: pick_next_task_fair check all se in rbtree are SCHED_IDLE and calls
> >> >> >> newidle_balance who tries to pull a SCHED_NORMAL(if has).
> >> >> >> t3: pick_next_task_fair would pick a SCHED_NORMAL to run instead of
> >> >> >> SCHED_IDLE(likely).
> >> >> >>
> >> >> >> >
> >> >> >> >> CPU by doing load_balance first.
> >> >> >> >>
> >> >> >> >> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> >> >> >> >> Signed-off-by: Chen He <heddchen@tencent.com>
> >> >> >> >> ---
> >> >> >> >>  kernel/sched/fair.c | 5 +++++
> >> >> >> >>  1 file changed, 5 insertions(+)
> >> >> >> >>
> >> >> >> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> >> >> >> index ae7ceba..0a26132 100644
> >> >> >> >> --- a/kernel/sched/fair.c
> >> >> >> >> +++ b/kernel/sched/fair.c
> >> >> >> >> @@ -7004,6 +7004,11 @@ struct task_struct *
> >> >> >> >>         struct task_struct *p;
> >> >> >> >>         int new_tasks;
> >> >> >> >>
> >> >> >> >> +       if (prev &&
> >> >> >> >> +           fair_policy(prev->policy) &&
> >> >> >> >
> >> >> >> >Why do you need a prev and fair task  ? You seem to target the special
> >> >> >> >case of pick_next_task  but in this case why not only testing rf!=null
> >> >> >> > to make sure to not return immediately after jumping to the idle
> >> >> >>
> >> >> >> >label?
> >> >> >> We just want to do load_balance only when CPU switches from SCHED_NORMAL
> >> >> >> to SCHED_IDLE.
> >> >> >> If not check prev, when the running tasks are all SCHED_IDLE, we would
> >> >> >> do newidle_balance everytime in pick_next_task_fair, it makes no sense
> >> >> >> and kind of wasting.
> >> >> >
> >> >> >I agree that calling newidle_balance every time pick_next_task_fair is
> >> >> >called when there are only sched_idle tasks is useless.
> >> >> >But you also have to take into account cases where there was another
> >> >> >class of task running on the cpu like RT one. In your example above,
> >> >> >if you replace the normal task on CPU2 by a RT task, you still want to
> >> >>
> >> >> >pick the normal task on CPU1 once RT task goes to sleep.
> >> >> Sure, this case should be taken into account,  we should also try to
> >> >> pick normal task in this case.
> >> >>
> >> >> >
> >> >> >Another point that you will have to consider the impact on
> >> >> >rq->idle_stamp because newidle_balance is assumed to be called before
> >> >>
> >> >> >going idle which is not the case anymore with your use case
> >> >> Yes. rq->idle_stamp should not be changed in this case.
> >> >>
> >> >>
> >> >>
> >> >> Actually we want to pull a SCHED_NORMAL task (if possible) to run when a cpu is
> >> >> about to run SCHED_IDLE task. But currently newidle_balance is not
> >> >> designed for SCHED_IDLE  so SCHED_IDLE can also be pulled which
> >> >> is useless in our situation.
> >> >
> >> >newidle_balance will pull a sched_idle task only if there is an
> >> >imbalance which is the right thing to do IMO to ensure fairness
> >> >between sched_idle tasks.  Being a sched_idle task doesn't mean that
> >> >we should break the fairness
> >> >
> >> >>
> >> >> So we plan to add a new function sched_idle_balance which only try to
> >> >> pull SCHED_NORMAL tasks from the busiest cpu. And we will call
> >> >> sched_idle_balance when the previous task is normal or RT and
> >> >> hoping we can pull a SCHED_NORMAL task to run.
> >> >>
> >> >> Do you think it is ok to add a new sched_idle_balance?
> >> >
> >> >I don't see any reason why the scheduler should not pull a sched_idle
> >> >task if there is an imbalance. That will happen anyway during the next
> >>
> >> >periodic load balance
> >> OK. We should not pull the SCHED_IDLE tasks only in load_balance.
> >>
> >>
> >> Do you think it make sense to do an extra load_balance when cpu is
> >> about to run SCHED_IDLE task (switched from normal/RT)?
> >
> >I'm not sure to get your point here.
> >Do you mean if a sched_idle task is picked to become the running task
> >whereas there are runnable normal tasks ? This can happen if normal
> >tasks are long running tasks. We should not in this case. The only
> >case is when the running task, which is not a sched_idle task but a
> >normal/rt/deadline one, goes to sleep and there are only sched_idle
> >tasks enqueued. In this case and only in this case, we should trigger
> >a load_balance to get a chance to pull a waiting normal task from
> >another CPU.
> >
> >This means checking this state in pick_next_task_fair() and in balance_fair()
>
> We made another change would you please give some comments?
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04a3ce2..2357301 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7029,6 +7029,10 @@ struct task_struct *
>         struct task_struct *p;
>         int new_tasks;
>
> +       if (sched_idle_rq(rq) && prev && prev->state &&
> +           prev->policy != SCHED_IDLE)
> +               goto idle;
> +
>  again:
>         if (!sched_fair_runnable(rq))
>                 goto idle;
> @@ -10571,7 +10575,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>          * We must set idle_stamp _before_ calling idle_balance(), such that we
>          * measure the duration of idle_balance() as idle time.
>          */
> -       this_rq->idle_stamp = rq_clock(this_rq);
> +       if (!rq->nr_running)
> +               this_rq->idle_stamp = rq_clock(this_rq);

I know that I asked you to take care of not setting idle_stamp during
the last review. But I forgot that it was cleared anyway at the end of
newidle_balance() if there is some tasks running on the cpu so this is
not needed and make the code less readable

>
>         /*
>          * Do not pull tasks towards !active CPUs...
>

I don't see the change for balance_fair()
When a rt task goes back to sleep and there is only sched_idle tasks
as an example


> >
> >> By doing this SCHED_NORMAL tasks waiting on other cpus would get
> >> a chance to be pulled to this cpu and run, it is helpful to reduce the latency
> >> of SCHED_NORMAL tasks.
> >>
> >>
> >> >>>
> >> >> >
> >> >> >>
> >> >> >> >
> >> >> >>
> >> >> >> >Also why not doing that for default case too ? i.e. balance_fair() ?
> >> >> >> You are right, if you think this scenario makes sense, we will send a
> >> >> >> refined patch soon :-)
> >> >> >>
> >> >> >> >
> >> >> >> >> +           sched_idle_cpu(rq->cpu))
> >> >> >> >> +               goto idle;
> >> >> >> >> +
> >> >> >> >>  again:
> >> >> >> >>         if (!sched_fair_runnable(rq))
> >> >> >> >>                 goto idle;
> >> >> >> >> --
> >> >> >> >> 1.8.3.1
> >> >> >> >>
> >> >> >> >>
