Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3B3DE446
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhHCCOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 22:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbhHCCOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:14:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB93C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 19:14:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k4-20020a17090a5144b02901731c776526so1734869pjm.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 19:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hx9SnOjy+MkP0Qqmf0NOirNZrSn4MwTJRn/myjPsuoU=;
        b=jXPH2pYsLMvt2tLami4yLq5hGqPkMSV0C3VQyZchpwqTDiy9MJZPSZK6zF7O8//pPS
         yJj6L9Unhplek9D2M/xneUjSD6Q5VRa42HTx9kPH9XuvYFUv57OlybmJiHXhSr6puXvH
         4l2KueXLo4ZU6QydSjNKpO9CJSTfrYsRUbuidDL5kLAmfRDbGf45J06D8bYxB/efN9Yj
         HtgMHi3SRDetG7/F+BQ13fPyW2EX8BCrxTJjHKSZTIwFCDdIGcQdmUSGRH/ajRRp2yHC
         qyGKAeseW0VHt9ghMgdSd4EMWbejwr8ha3JpOzSkDPFB3d6ep2LIzsCrs/DMEbTu613r
         vJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hx9SnOjy+MkP0Qqmf0NOirNZrSn4MwTJRn/myjPsuoU=;
        b=YvzplHh2ntOEIQAi6eJ73fXFmqMATy2QK8DcIb7Dh6FsQB8BYfXAemiBi/t9mPMeMw
         NdFStzrK3RB95DUJE0oCSfugnaxnQ/R05h63FnuRevUqKeyihz1y/bi3qZnk/dS98/8P
         M8c/35GPyS4hJ7kKyjrfNfAEMyx2avhs56dFN0Pj7eAifiYaKPu4/oWzIDPJJK/Jd7uU
         IxcGyyf/yKkmZcLNjzi4A5QKMJZ0z5UEo0elNzkjukOg1TK+vvuJlhHVCJuGffcKGcG0
         LNRR1TqZodnReDhUepjVJXWtk8NYNbUZEHsSAO6FTcrRGplwUN9jwLYWJZoWo6FQP2ZF
         7bZA==
X-Gm-Message-State: AOAM532SxyY8UStH3HYxlixqPGinnHr6mno8EFii+pcYM2zfPDla9k5k
        cNEI2uNNOH47DEBFGa6G7CebZUtmTBdAz1/zeOU=
X-Google-Smtp-Source: ABdhPJw0FwyYHbUvzDEY1LecQXV1urVJA8MgT3r14pMEzFjpDq5A2a2MVQwqJwd1+G+t6FZJ8Z8pqCiCrhWRZMYfN9A=
X-Received: by 2002:aa7:96fc:0:b029:3ab:8eff:ca39 with SMTP id
 i28-20020aa796fc0000b02903ab8effca39mr20016438pfq.62.1627956872019; Mon, 02
 Aug 2021 19:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210730020019.1487127-1-joshdon@google.com> <20210730020019.1487127-2-joshdon@google.com>
In-Reply-To: <20210730020019.1487127-2-joshdon@google.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Tue, 3 Aug 2021 10:14:20 +0800
Message-ID: <CAKc596LT=zntozT6D2kPyfSiqdt1KfbrAX8PSvHxCPKRNuq1pA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched: cgroup SCHED_IDLE support
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Josh

Josh Don <joshdon@google.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=8830=E6=97=A5=
=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8810:03=E5=86=99=E9=81=93=EF=BC=9A
>
> This extends SCHED_IDLE to cgroups.
>
> Interface: cgroup/cpu.idle.
>  0: default behavior
>  1: SCHED_IDLE
>
> Extending SCHED_IDLE to cgroups means that we incorporate the existing
> aspects of SCHED_IDLE; a SCHED_IDLE cgroup will count all of its
> descendant threads towards the idle_h_nr_running count of all of its
> ancestor cgroups. Thus, sched_idle_rq() will work properly.
> Additionally, SCHED_IDLE cgroups are configured with minimum weight.
>
> There are two key differences between the per-task and per-cgroup
> SCHED_IDLE interface:
>
> - The cgroup interface allows tasks within a SCHED_IDLE hierarchy to
> maintain their relative weights. The entity that is "idle" is the
> cgroup, not the tasks themselves.
>
> - Since the idle entity is the cgroup, our SCHED_IDLE wakeup preemption
> decision is not made by comparing the current task with the woken task,
> but rather by comparing their matching sched_entity.
>
> A typical use-case for this is a user that creates an idle and a
> non-idle subtree. The non-idle subtree will dominate competition vs
> the idle subtree, but the idle subtree will still be high priority
> vs other users on the system. The latter is accomplished via comparing
> matching sched_entity in the waken preemption path (this could also be
> improved by making the sched_idle_rq() decision dependent on the
> perspective of a specific task).
>
> For now, we maintain the existing SCHED_IDLE semantics. Future patches
> may make improvements that extend how we treat SCHED_IDLE entities.
>
> The per-task_group idle field is an integer that currently only holds
> either a 0 or a 1. This is explicitly typed as an integer to allow for
> further extensions to this API. For example, a negative value may
> indicate a highly latency-sensitive cgroup that should be preferred for
> preemption/placement/etc.
>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
> v2:
> - Use WEIGHT_IDLEPRIO for the idle cgroup weight
> - Add cgroup-v1 support
>
>  kernel/sched/core.c  |  25 ++++++
>  kernel/sched/debug.c |   3 +
>  kernel/sched/fair.c  | 197 +++++++++++++++++++++++++++++++++++++------
>  kernel/sched/sched.h |   8 ++
>  4 files changed, 208 insertions(+), 25 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index cd004d542419..0e1fb9206c02 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10120,6 +10120,20 @@ static u64 cpu_rt_period_read_uint(struct cgroup=
_subsys_state *css,
>  }
>  #endif /* CONFIG_RT_GROUP_SCHED */
>
> +#ifdef CONFIG_FAIR_GROUP_SCHED
> +static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
> +                              struct cftype *cft)
> +{
> +       return css_tg(css)->idle;
> +}
> +
> +static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
> +                               struct cftype *cft, s64 idle)
> +{
> +       return sched_group_set_idle(css_tg(css), idle);
> +}
> +#endif
> +
>  static struct cftype cpu_legacy_files[] =3D {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         {
> @@ -10127,6 +10141,11 @@ static struct cftype cpu_legacy_files[] =3D {
>                 .read_u64 =3D cpu_shares_read_u64,
>                 .write_u64 =3D cpu_shares_write_u64,
>         },
> +       {
> +               .name =3D "idle",
> +               .read_s64 =3D cpu_idle_read_s64,
> +               .write_s64 =3D cpu_idle_write_s64,
> +       },
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>         {
> @@ -10334,6 +10353,12 @@ static struct cftype cpu_files[] =3D {
>                 .read_s64 =3D cpu_weight_nice_read_s64,
>                 .write_s64 =3D cpu_weight_nice_write_s64,
>         },
> +       {
> +               .name =3D "idle",
> +               .flags =3D CFTYPE_NOT_ON_ROOT,
> +               .read_s64 =3D cpu_idle_read_s64,
> +               .write_s64 =3D cpu_idle_write_s64,
> +       },
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>         {
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 7e08e3d947c2..49716228efb4 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -607,6 +607,9 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct=
 cfs_rq *cfs_rq)
>         SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
>                         cfs_rq->nr_spread_over);
>         SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running)=
;
> +       SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_runn=
ing);
> +       SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
> +                       cfs_rq->idle_h_nr_running);
>         SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
>  #ifdef CONFIG_SMP
>         SEQ_printf(m, "  .%-30s: %lu\n", "load_avg",
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6bf0889efced..a7feae1cb0f0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -431,6 +431,23 @@ find_matching_se(struct sched_entity **se, struct sc=
hed_entity **pse)
>         }
>  }
>
> +static int tg_is_idle(struct task_group *tg)
> +{
> +       return tg->idle > 0;
> +}
> +
> +static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
> +{
> +       return cfs_rq->idle > 0;
> +}
> +
> +static int se_is_idle(struct sched_entity *se)
> +{
> +       if (entity_is_task(se))
> +               return task_has_idle_policy(task_of(se));
> +       return cfs_rq_is_idle(group_cfs_rq(se));
> +}
> +
>  #else  /* !CONFIG_FAIR_GROUP_SCHED */
>
>  #define for_each_sched_entity(se) \
> @@ -468,6 +485,21 @@ find_matching_se(struct sched_entity **se, struct sc=
hed_entity **pse)
>  {
>  }
>
> +static int tg_is_idle(struct task_group *tg)
> +{
> +       return 0;
> +}
> +
> +static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
> +{
> +       return 0;
> +}
> +
> +static int se_is_idle(struct sched_entity *se)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
>  static __always_inline
> @@ -4841,6 +4873,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>
>                 dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
>
> +               if (cfs_rq_is_idle(group_cfs_rq(se)))
> +                       idle_task_delta =3D cfs_rq->h_nr_running;
> +
>                 qcfs_rq->h_nr_running -=3D task_delta;
>                 qcfs_rq->idle_h_nr_running -=3D idle_task_delta;
>
> @@ -4860,6 +4895,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>                 update_load_avg(qcfs_rq, se, 0);
>                 se_update_runnable(se);
>
> +               if (cfs_rq_is_idle(group_cfs_rq(se)))
> +                       idle_task_delta =3D cfs_rq->h_nr_running;
> +
>                 qcfs_rq->h_nr_running -=3D task_delta;
>                 qcfs_rq->idle_h_nr_running -=3D idle_task_delta;
>         }
> @@ -4904,39 +4942,45 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>         task_delta =3D cfs_rq->h_nr_running;
>         idle_task_delta =3D cfs_rq->idle_h_nr_running;
>         for_each_sched_entity(se) {
> +               struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);
> +
>                 if (se->on_rq)
>                         break;
> -               cfs_rq =3D cfs_rq_of(se);
> -               enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> +               enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
> +
> +               if (cfs_rq_is_idle(group_cfs_rq(se)))
> +                       idle_task_delta =3D cfs_rq->h_nr_running;
>
> -               cfs_rq->h_nr_running +=3D task_delta;
> -               cfs_rq->idle_h_nr_running +=3D idle_task_delta;
> +               qcfs_rq->h_nr_running +=3D task_delta;
> +               qcfs_rq->idle_h_nr_running +=3D idle_task_delta;
>
>                 /* end evaluation on encountering a throttled cfs_rq */
> -               if (cfs_rq_throttled(cfs_rq))
> +               if (cfs_rq_throttled(qcfs_rq))
>                         goto unthrottle_throttle;
>         }
>
>         for_each_sched_entity(se) {
> -               cfs_rq =3D cfs_rq_of(se);
> +               struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);
>
> -               update_load_avg(cfs_rq, se, UPDATE_TG);
> +               update_load_avg(qcfs_rq, se, UPDATE_TG);
>                 se_update_runnable(se);
>
> -               cfs_rq->h_nr_running +=3D task_delta;
> -               cfs_rq->idle_h_nr_running +=3D idle_task_delta;
> +               if (cfs_rq_is_idle(group_cfs_rq(se)))
> +                       idle_task_delta =3D cfs_rq->h_nr_running;
>
> +               qcfs_rq->h_nr_running +=3D task_delta;
> +               qcfs_rq->idle_h_nr_running +=3D idle_task_delta;
>
>                 /* end evaluation on encountering a throttled cfs_rq */
> -               if (cfs_rq_throttled(cfs_rq))
> +               if (cfs_rq_throttled(qcfs_rq))
>                         goto unthrottle_throttle;
>
>                 /*
>                  * One parent has been throttled and cfs_rq removed from =
the
>                  * list. Add it back to not break the leaf list.
>                  */
> -               if (throttled_hierarchy(cfs_rq))
> -                       list_add_leaf_cfs_rq(cfs_rq);
> +               if (throttled_hierarchy(qcfs_rq))
> +                       list_add_leaf_cfs_rq(qcfs_rq);
>         }
>
>         /* At this point se is NULL and we are at root level*/
> @@ -4949,9 +4993,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>          * assertion below.
>          */
>         for_each_sched_entity(se) {
> -               cfs_rq =3D cfs_rq_of(se);
> +               struct cfs_rq *qcfs_rq =3D cfs_rq_of(se);
>
> -               if (list_add_leaf_cfs_rq(cfs_rq))
> +               if (list_add_leaf_cfs_rq(qcfs_rq))
>                         break;
>         }
>
> @@ -5574,6 +5618,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>                 cfs_rq->h_nr_running++;
>                 cfs_rq->idle_h_nr_running +=3D idle_h_nr_running;
>
> +               if (cfs_rq_is_idle(cfs_rq))
> +                       idle_h_nr_running =3D 1;
> +
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
> @@ -5591,6 +5638,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct=
 *p, int flags)
>                 cfs_rq->h_nr_running++;
>                 cfs_rq->idle_h_nr_running +=3D idle_h_nr_running;
>
> +               if (cfs_rq_is_idle(cfs_rq))
> +                       idle_h_nr_running =3D 1;
> +
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto enqueue_throttle;
> @@ -5668,6 +5718,9 @@ static void dequeue_task_fair(struct rq *rq, struct=
 task_struct *p, int flags)
>                 cfs_rq->h_nr_running--;
>                 cfs_rq->idle_h_nr_running -=3D idle_h_nr_running;
>
> +               if (cfs_rq_is_idle(cfs_rq))
> +                       idle_h_nr_running =3D 1;
> +
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto dequeue_throttle;
> @@ -5697,6 +5750,9 @@ static void dequeue_task_fair(struct rq *rq, struct=
 task_struct *p, int flags)
>                 cfs_rq->h_nr_running--;
>                 cfs_rq->idle_h_nr_running -=3D idle_h_nr_running;
>
> +               if (cfs_rq_is_idle(cfs_rq))
> +                       idle_h_nr_running =3D 1;
> +
>                 /* end evaluation on encountering a throttled cfs_rq */
>                 if (cfs_rq_throttled(cfs_rq))
>                         goto dequeue_throttle;
> @@ -7041,24 +7097,22 @@ wakeup_preempt_entity(struct sched_entity *curr, =
struct sched_entity *se)
>
>  static void set_last_buddy(struct sched_entity *se)
>  {
> -       if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(s=
e))))
> -               return;
> -
>         for_each_sched_entity(se) {
>                 if (SCHED_WARN_ON(!se->on_rq))
>                         return;
> +               if (se_is_idle(se))
> +                       return;
>                 cfs_rq_of(se)->last =3D se;
>         }
>  }
>
>  static void set_next_buddy(struct sched_entity *se)
>  {
> -       if (entity_is_task(se) && unlikely(task_has_idle_policy(task_of(s=
e))))
> -               return;
> -
>         for_each_sched_entity(se) {
>                 if (SCHED_WARN_ON(!se->on_rq))
>                         return;
> +               if (se_is_idle(se))
> +                       return;
>                 cfs_rq_of(se)->next =3D se;
>         }
>  }
> @@ -7079,6 +7133,7 @@ static void check_preempt_wakeup(struct rq *rq, str=
uct task_struct *p, int wake_
>         struct cfs_rq *cfs_rq =3D task_cfs_rq(curr);
>         int scale =3D cfs_rq->nr_running >=3D sched_nr_latency;
>         int next_buddy_marked =3D 0;
> +       int cse_is_idle, pse_is_idle;
>
>         if (unlikely(se =3D=3D pse))
>                 return;
> @@ -7123,8 +7178,21 @@ static void check_preempt_wakeup(struct rq *rq, st=
ruct task_struct *p, int wake_
>                 return;
>
>         find_matching_se(&se, &pse);
> -       update_curr(cfs_rq_of(se));
>         BUG_ON(!pse);
> +
> +       cse_is_idle =3D se_is_idle(se);
> +       pse_is_idle =3D se_is_idle(pse);
> +
> +       /*
> +        * Preempt an idle group in favor of a non-idle group (and don't =
preempt
> +        * in the inverse case).
> +        */
> +       if (cse_is_idle && !pse_is_idle)
> +               goto preempt;

In the next schedule, it will pick next entity, How do we ensure that
the entity selected next time will not be an idle
entity. So I think we need to do something to idle group when picking
next entity, For example, when we pick next
entity, we try to choose normal group as much as possible.

> +       if (cse_is_idle !=3D pse_is_idle)
> +               return;
> +
> +       update_curr(cfs_rq_of(se));
>         if (wakeup_preempt_entity(se, pse) =3D=3D 1) {
>                 /*
>                  * Bias pick_next to pick the sched entity that is
> @@ -11418,10 +11486,12 @@ void init_tg_cfs_entry(struct task_group *tg, s=
truct cfs_rq *cfs_rq,
>
>  static DEFINE_MUTEX(shares_mutex);
>
> -int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> +static int __sched_group_set_shares(struct task_group *tg, unsigned long=
 shares)
>  {
>         int i;
>
> +       lockdep_assert_held(&shares_mutex);
> +
>         /*
>          * We can't change the weight of the root cgroup.
>          */
> @@ -11430,9 +11500,8 @@ int sched_group_set_shares(struct task_group *tg,=
 unsigned long shares)
>
>         shares =3D clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_S=
HARES));
>
> -       mutex_lock(&shares_mutex);
>         if (tg->shares =3D=3D shares)
> -               goto done;
> +               return 0;
>
>         tg->shares =3D shares;
>         for_each_possible_cpu(i) {
> @@ -11450,10 +11519,88 @@ int sched_group_set_shares(struct task_group *t=
g, unsigned long shares)
>                 rq_unlock_irqrestore(rq, &rf);
>         }
>
> -done:
> +       return 0;
> +}
> +
> +int sched_group_set_shares(struct task_group *tg, unsigned long shares)
> +{
> +       int ret;
> +
> +       mutex_lock(&shares_mutex);
> +       if (tg_is_idle(tg))
> +               ret =3D -EINVAL;
> +       else
> +               ret =3D __sched_group_set_shares(tg, shares);
> +       mutex_unlock(&shares_mutex);
> +
> +       return ret;
> +}
> +
> +int sched_group_set_idle(struct task_group *tg, long idle)
> +{
> +       int i;
> +
> +       if (tg =3D=3D &root_task_group)
> +               return -EINVAL;
> +
> +       if (idle < 0 || idle > 1)
> +               return -EINVAL;
> +
> +       mutex_lock(&shares_mutex);
> +
> +       if (tg->idle =3D=3D idle) {
> +               mutex_unlock(&shares_mutex);
> +               return 0;
> +       }
> +
> +       tg->idle =3D idle;
> +
> +       for_each_possible_cpu(i) {
> +               struct rq *rq =3D cpu_rq(i);
> +               struct sched_entity *se =3D tg->se[i];
> +               struct cfs_rq *grp_cfs_rq =3D tg->cfs_rq[i];
> +               bool was_idle =3D cfs_rq_is_idle(grp_cfs_rq);
> +               long idle_task_delta;
> +               struct rq_flags rf;
> +
> +               rq_lock_irqsave(rq, &rf);
> +
> +               grp_cfs_rq->idle =3D idle;
> +               if (WARN_ON_ONCE(was_idle =3D=3D cfs_rq_is_idle(grp_cfs_r=
q)))
> +                       goto next_cpu;
> +
> +               idle_task_delta =3D grp_cfs_rq->h_nr_running -
> +                                 grp_cfs_rq->idle_h_nr_running;
> +               if (!cfs_rq_is_idle(grp_cfs_rq))
> +                       idle_task_delta *=3D -1;
> +
> +               for_each_sched_entity(se) {
> +                       struct cfs_rq *cfs_rq =3D cfs_rq_of(se);
> +
> +                       if (!se->on_rq)
> +                               break;
> +
> +                       cfs_rq->idle_h_nr_running +=3D idle_task_delta;
> +
> +                       /* Already accounted at parent level and above. *=
/
> +                       if (cfs_rq_is_idle(cfs_rq))
> +                               break;
> +               }
> +
> +next_cpu:
> +               rq_unlock_irqrestore(rq, &rf);
> +       }
> +
> +       /* Idle groups have minimum weight. */
> +       if (tg_is_idle(tg))
> +               __sched_group_set_shares(tg, scale_load(WEIGHT_IDLEPRIO))=
;
> +       else
> +               __sched_group_set_shares(tg, NICE_0_LOAD);
> +
>         mutex_unlock(&shares_mutex);
>         return 0;
>  }
> +
>  #else /* CONFIG_FAIR_GROUP_SCHED */
>
>  void free_fair_sched_group(struct task_group *tg) { }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d9f8d73a1d84..8dfad8fb756c 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -396,6 +396,9 @@ struct task_group {
>         struct cfs_rq           **cfs_rq;
>         unsigned long           shares;
>
> +       /* A positive value indicates that this is a SCHED_IDLE group. */
> +       int                     idle;
> +
>  #ifdef CONFIG_SMP
>         /*
>          * load_avg can be heavily contended at clock tick time, so put
> @@ -505,6 +508,8 @@ extern void sched_move_task(struct task_struct *tsk);
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  extern int sched_group_set_shares(struct task_group *tg, unsigned long s=
hares);
>
> +extern int sched_group_set_idle(struct task_group *tg, long idle);
> +
>  #ifdef CONFIG_SMP
>  extern void set_task_rq_fair(struct sched_entity *se,
>                              struct cfs_rq *prev, struct cfs_rq *next);
> @@ -601,6 +606,9 @@ struct cfs_rq {
>         struct list_head        leaf_cfs_rq_list;
>         struct task_group       *tg;    /* group that "owns" this runqueu=
e */
>
> +       /* Locally cached copy of our task_group's idle value */
> +       int                     idle;
> +
>  #ifdef CONFIG_CFS_BANDWIDTH
>         int                     runtime_enabled;
>         s64                     runtime_remaining;
> --
> 2.32.0.554.ge1b32706d8-goog
>

Do we need to do something in the sched tick for the situation with
idle entities?

Thanks
