Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E80A30EF6F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhBDJOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhBDJOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:14:14 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D26C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 01:13:33 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id w8so3040224oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 01:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcZr/lXOtFtdlVQFOf0O+ERf98wRvIkOP/xyvZUm54o=;
        b=Bnnen8yiBU+K8PYVDd7zG3RPsHggkh5OAm8UCFxkCeNMfELGiXS0iAimTdU1oDcOR0
         mfXw66KeJE3FVmtnb+tA4FoHZ0Gyx/GS9iO9f8Hw96Z80R9RHPxZhF1YM1EcwH95GKFw
         3XPXeosqWPSJ/pA3hQAzQSfIPInv6LnlpGT5BNdIN+a8PcR0bZ9dCLjFPXqy6HTYKs06
         AOMiNlrBR8t4GnouUOlw4eXlnb+yp7Rgjlcmsg9/Rbr6PZ19dp1oGRtnWmcrasvNuQlM
         pMYZwb4rC3VFt3HF+KX9xVgcOenO6fspdIvHjf5V/DhFKgww7cejCMaWNMX0K//K6Z81
         wPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcZr/lXOtFtdlVQFOf0O+ERf98wRvIkOP/xyvZUm54o=;
        b=G0K2FDKjAK2gnxbx6v/58TAS6Ij4dfNSThz+lK3LFtiHwHz85+ZM2YV1Xig8hsrfzk
         883QRSjBEJ48LOl5i1WNTDvMsdG3GHgDdzQtu1xgIOX2kfkUeHQ9m6QZCyfqtBazjjup
         uzDdSGk/ahbVTVmYomafRoOg3iuLNobnlLFN7ICAJDfPxPjIE3faYZ+LwsSk0bVoURg9
         VGkmKHpSfYxzP/+9hmcD6FFDxVGX474dKeVZcHPlbtkUDEPAPp8yg0U8j/FX2B6RITUu
         G31lp/ZYjgDhW5lmrzEgJuqRMws5+fdCmp62VBNDNqvv7RJhMfc2UcE+dY2aOwnQlJc4
         j8Mg==
X-Gm-Message-State: AOAM533lmfTuQVK5BZ20WnJAZuy8bUMTYdr8KqA4/0xkn/cbwnJGv0qI
        Rbg8saoXcKmCtAtBm5howx+X3OyW1BuaPHthntk=
X-Google-Smtp-Source: ABdhPJxFqvY2nylLMNXzuk22H5R4RcNMz1OUdPqMumY5F8MN/t0xFKprcKPpriIuXmcdPQ6+x+TG9Nr8ehb4+Cqa5y0=
X-Received: by 2002:aca:1808:: with SMTP id h8mr4702477oih.150.1612430013306;
 Thu, 04 Feb 2021 01:13:33 -0800 (PST)
MIME-Version: 1.0
References: <1608710968-31475-1-git-send-email-ultrachin@163.com>
 <CAKfTPtA9zdU76Q6AyjB8_gqvAm8SP_N0rJuydQdNFbDAKSb2jw@mail.gmail.com>
 <1fefea2e.70bf.176f08d9fae.Coremail.ultrachin@163.com> <CAKfTPtDWARbx=xqwr47iFkEMVo7=+5_o_gMX+h=gAcXZP341oA@mail.gmail.com>
 <61e22917.538b.176f56231f6.Coremail.ultrachin@163.com> <CAKfTPtCSra_kfncR7J_7ona+8MoO0ZX8uTEXvZ7PU7C0pYiM5w@mail.gmail.com>
 <38c1aeee.2d5f.176f9bb0cfb.Coremail.ultrachin@163.com> <CAKfTPtAYoBm1se=HAcsyxwZTQ=XW+HcQJsP3maZy6CNgLSfLZA@mail.gmail.com>
 <4e2f3ac4.2b66.17761bc6eb9.Coremail.ultrachin@163.com> <CAKfTPtBCrzLUnwVv6ExcUgScE9_q2ZZs4SyzV58ASBTY_ZPpyg@mail.gmail.com>
In-Reply-To: <CAKfTPtBCrzLUnwVv6ExcUgScE9_q2ZZs4SyzV58ASBTY_ZPpyg@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 4 Feb 2021 17:13:22 +0800
Message-ID: <CAPJCdB=KSuES_=ctaj2D3UggQr-Exi=Hfffd_MU3UCp_ygtkPQ@mail.gmail.com>
Subject: Re: [PATCH] sched: pull tasks when CPU is about to run SCHED_IDLE tasks
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     chin <ultrachin@163.com>,
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

Hi, Vincent

On Thu, 4 Feb 2021 at 16:04, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Tue, 2 Feb 2021 at 08:56, chin <ultrachin@163.com> wrote:
> >
> >
> >
> >
> > At 2021-01-13 16:30:14, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> > >On Wed, 13 Jan 2021 at 04:14, chin <ultrachin@163.com> wrote:
> > >>
> > >>
> > >>
> > >>
> > >> At 2021-01-12 16:18:51, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> > >> >On Tue, 12 Jan 2021 at 07:59, chin <ultrachin@163.com> wrote:
> > >> >>
> > >> >>
> > >> >>
> > >> >>
> > >> >> At 2021-01-11 19:04:19, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> > >> >> >On Mon, 11 Jan 2021 at 09:27, chin <ultrachin@163.com> wrote:
> > >> >> >>
> > >> >> >>
> > >> >> >> At 2020-12-23 19:30:26, "Vincent Guittot" <vincent.guittot@linaro.org> wrote:
> > >> >> >> >On Wed, 23 Dec 2020 at 09:32, <ultrachin@163.com> wrote:
> > >> >> >> >>
> > >> >> >> >> From: Chen Xiaoguang <xiaoggchen@tencent.com>
> > >> >> >> >>
> > >> >> >> >> Before a CPU switches from running SCHED_NORMAL task to
> > >> >> >> >> SCHED_IDLE task, trying to pull SCHED_NORMAL tasks from other
> > >> >> >> >
> > >> >> >> >Could you explain more in detail why you only care about this use case
> > >> >> >>
> > >> >> >> >in particular and not the general case?
> > >> >> >>
> > >> >> >>
> > >> >> >> We want to run online tasks using SCHED_NORMAL policy and offline tasks
> > >> >> >> using SCHED_IDLE policy. The online tasks and the offline tasks run in
> > >> >> >> the same computer in order to use the computer efficiently.
> > >> >> >> The online tasks are in sleep in most times but should responce soon once
> > >> >> >> wake up. The offline tasks are in low priority and will run only when no online
> > >> >> >> tasks.
> > >> >> >>
> > >> >> >> The online tasks are more important than the offline tasks and are latency
> > >> >> >> sensitive we should make sure the online tasks preempt the offline tasks
> > >> >> >> as soon as possilbe while there are online tasks waiting to run.
> > >> >> >> So in our situation we hope the SCHED_NORMAL to run if has any.
> > >> >> >>
> > >> >> >> Let's assume we have 2 CPUs,
> > >> >> >> In CPU1 we got 2 SCHED_NORMAL tasks.
> > >> >> >> in CPU2 we got 1 SCHED_NORMAL task and 2 SCHED_IDLE tasks.
> > >> >> >>
> > >> >> >>              CPU1                      CPU2
> > >> >> >>         curr       rq1            curr          rq2
> > >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> > >> >> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> > >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> > >> >> >>
> > >> >> >>                                  NORMAL exits or blocked
> > >> >> >>       +------+ | +------+                | +----+ +----+
> > >> >> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> > >> >> >>       +------+ | +------+                | +----+ +----+
> > >> >> >>
> > >> >> >>                                  pick_next_task_fair
> > >> >> >>       +------+ | +------+         +----+ | +----+
> > >> >> >> t2    |NORMAL| | |NORMAL|         |IDLE| | |IDLE|
> > >> >> >>       +------+ | +------+         +----+ | +----+
> > >> >> >>
> > >> >> >>                                  SCHED_IDLE running
> > >> >> >> t3    +------+ | +------+        +----+  | +----+
> > >> >> >>       |NORMAL| | |NORMAL|        |IDLE|  | |IDLE|
> > >> >> >>       +------+ | +------+        +----+  | +----+
> > >> >> >>
> > >> >> >>                                  run_rebalance_domains
> > >> >> >>       +------+ |                +------+ | +----+ +----+
> > >> >> >> t4    |NORMAL| |                |NORMAL| | |IDLE| |IDLE|
> > >> >> >>       +------+ |                +------+ | +----+ +----+
> > >> >> >>
> > >> >> >> As we can see
> > >> >> >> t1: NORMAL task in CPU2 exits or blocked
> > >> >> >> t2: CPU2 pick_next_task_fair would pick a SCHED_IDLE to run while
> > >> >> >> another SCHED_NORMAL in rq1 is waiting.
> > >> >> >> t3: SCHED_IDLE run in CPU2 while a SCHED_NORMAL wait in CPU1.
> > >> >> >> t4: after a short time, periodic load_balance triggerd and pull
> > >> >> >> SCHED_NORMAL in rq1 to rq2, and SCHED_NORMAL likely preempts SCHED_IDLE.
> > >> >> >>
> > >> >> >> In this scenario, SCHED_IDLE is running while SCHED_NORMAL is waiting to run.
> > >> >> >> The latency of this SCHED_NORMAL will be high which is not acceptble.
> > >> >> >>
> > >> >> >> Do a load_balance before running the SCHED_IDLE may fix this problem.
> > >> >> >>
> > >> >> >> This patch works as below:
> > >> >> >>
> > >> >> >>              CPU1                      CPU2
> > >> >> >>         curr       rq1            curr          rq2
> > >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> > >> >> >> t0    |NORMAL| | |NORMAL|       |NORMAL| | |IDLE| |IDLE|
> > >> >> >>       +------+ | +------+       +------+ | +----+ +----+
> > >> >> >>
> > >> >> >>                                  NORMAL exits or blocked
> > >> >> >>       +------+ | +------+                | +----+ +----+
> > >> >> >> t1    |NORMAL| | |NORMAL|                | |IDLE| |IDLE|
> > >> >> >>       +------+ | +------+                | +----+ +----+
> > >> >> >>
> > >> >> >> t2                            pick_next_task_fair (all se are SCHED_IDLE)
> > >> >> >>
> > >> >> >>                                  newidle_balance
> > >> >> >>       +------+ |                 +------+ | +----+ +----+
> > >> >> >> t3    |NORMAL| |                 |NORMAL| | |IDLE| |IDLE|
> > >> >> >>       +------+ |                 +------+ | +----+ +----+
> > >> >> >>
> > >> >> >>
> > >> >> >> t1: NORMAL task in CPU2 exits or blocked
> > >> >> >> t2: pick_next_task_fair check all se in rbtree are SCHED_IDLE and calls
> > >> >> >> newidle_balance who tries to pull a SCHED_NORMAL(if has).
> > >> >> >> t3: pick_next_task_fair would pick a SCHED_NORMAL to run instead of
> > >> >> >> SCHED_IDLE(likely).
> > >> >> >>
> > >> >> >> >
> > >> >> >> >> CPU by doing load_balance first.
> > >> >> >> >>
> > >> >> >> >> Signed-off-by: Chen Xiaoguang <xiaoggchen@tencent.com>
> > >> >> >> >> Signed-off-by: Chen He <heddchen@tencent.com>
> > >> >> >> >> ---
> > >> >> >> >>  kernel/sched/fair.c | 5 +++++
> > >> >> >> >>  1 file changed, 5 insertions(+)
> > >> >> >> >>
> > >> >> >> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >> >> >> >> index ae7ceba..0a26132 100644
> > >> >> >> >> --- a/kernel/sched/fair.c
> > >> >> >> >> +++ b/kernel/sched/fair.c
> > >> >> >> >> @@ -7004,6 +7004,11 @@ struct task_struct *
> > >> >> >> >>         struct task_struct *p;
> > >> >> >> >>         int new_tasks;
> > >> >> >> >>
> > >> >> >> >> +       if (prev &&
> > >> >> >> >> +           fair_policy(prev->policy) &&
> > >> >> >> >
> > >> >> >> >Why do you need a prev and fair task  ? You seem to target the special
> > >> >> >> >case of pick_next_task  but in this case why not only testing rf!=null
> > >> >> >> > to make sure to not return immediately after jumping to the idle
> > >> >> >>
> > >> >> >> >label?
> > >> >> >> We just want to do load_balance only when CPU switches from SCHED_NORMAL
> > >> >> >> to SCHED_IDLE.
> > >> >> >> If not check prev, when the running tasks are all SCHED_IDLE, we would
> > >> >> >> do newidle_balance everytime in pick_next_task_fair, it makes no sense
> > >> >> >> and kind of wasting.
> > >> >> >
> > >> >> >I agree that calling newidle_balance every time pick_next_task_fair is
> > >> >> >called when there are only sched_idle tasks is useless.
> > >> >> >But you also have to take into account cases where there was another
> > >> >> >class of task running on the cpu like RT one. In your example above,
> > >> >> >if you replace the normal task on CPU2 by a RT task, you still want to
> > >> >>
> > >> >> >pick the normal task on CPU1 once RT task goes to sleep.
> > >> >> Sure, this case should be taken into account,  we should also try to
> > >> >> pick normal task in this case.
> > >> >>
> > >> >> >
> > >> >> >Another point that you will have to consider the impact on
> > >> >> >rq->idle_stamp because newidle_balance is assumed to be called before
> > >> >>
> > >> >> >going idle which is not the case anymore with your use case
> > >> >> Yes. rq->idle_stamp should not be changed in this case.
> > >> >>
> > >> >>
> > >> >>
> > >> >> Actually we want to pull a SCHED_NORMAL task (if possible) to run when a cpu is
> > >> >> about to run SCHED_IDLE task. But currently newidle_balance is not
> > >> >> designed for SCHED_IDLE  so SCHED_IDLE can also be pulled which
> > >> >> is useless in our situation.
> > >> >
> > >> >newidle_balance will pull a sched_idle task only if there is an
> > >> >imbalance which is the right thing to do IMO to ensure fairness
> > >> >between sched_idle tasks.  Being a sched_idle task doesn't mean that
> > >> >we should break the fairness
> > >> >
> > >> >>
> > >> >> So we plan to add a new function sched_idle_balance which only try to
> > >> >> pull SCHED_NORMAL tasks from the busiest cpu. And we will call
> > >> >> sched_idle_balance when the previous task is normal or RT and
> > >> >> hoping we can pull a SCHED_NORMAL task to run.
> > >> >>
> > >> >> Do you think it is ok to add a new sched_idle_balance?
> > >> >
> > >> >I don't see any reason why the scheduler should not pull a sched_idle
> > >> >task if there is an imbalance. That will happen anyway during the next
> > >>
> > >> >periodic load balance
> > >> OK. We should not pull the SCHED_IDLE tasks only in load_balance.
> > >>
> > >>
> > >> Do you think it make sense to do an extra load_balance when cpu is
> > >> about to run SCHED_IDLE task (switched from normal/RT)?
> > >
> > >I'm not sure to get your point here.
> > >Do you mean if a sched_idle task is picked to become the running task
> > >whereas there are runnable normal tasks ? This can happen if normal
> > >tasks are long running tasks. We should not in this case. The only
> > >case is when the running task, which is not a sched_idle task but a
> > >normal/rt/deadline one, goes to sleep and there are only sched_idle
> > >tasks enqueued. In this case and only in this case, we should trigger
> > >a load_balance to get a chance to pull a waiting normal task from
> > >another CPU.
> > >
> > >This means checking this state in pick_next_task_fair() and in balance_fair()
> >
> > We made another change would you please give some comments?
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04a3ce2..2357301 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7029,6 +7029,10 @@ struct task_struct *
> >         struct task_struct *p;
> >         int new_tasks;
> >
> > +       if (sched_idle_rq(rq) && prev && prev->state &&
> > +           prev->policy != SCHED_IDLE)
>
> This need a comment to explain what it want to achieve
>
> Why do you need to test prev->state ?
Just to avoid triggering load_balance for the case if prev normal
tasks are long running tasks, as you said. :)
Or could testing (prev->state & TASK_NORMAL) be better?

Thx.
Jiang,
Regards
