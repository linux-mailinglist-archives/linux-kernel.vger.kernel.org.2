Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A2F3F6914
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhHXS3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhHXS3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 14:29:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F998C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:29:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z9so32598303wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qm8sdUluZvm64ONsBKm+UDVYTpFAlujmWCI3IdJ5PIA=;
        b=KGwKiUH5ocMerMsUmCrP0fm+g7p8GNkzNVnbzb6KJa3iTo7qS9QLl5AuDdmHGD5Yot
         hteGEdGBavcvWIyBwMs/gIIWXtZJR8ibo89cPiA828o04c2rIQJ1itJnjjRORczr1GiI
         cOyK6+uC/NBzvShNSsrA/65wtQoWzsJ3zPQ1crilSfJ4rBm9ZGHjS0fKfzNQEd2OxDi8
         HUaVenbQSAOnpesL+1KTPRvEe3eJmpMgiOnzpkXBrzuumB75q1/fw00hopYBCQ7coflC
         cZMRhzy4a6UREhMGfE5xs8F+gGmUD9JVfzgcolWHcrJMQhX9z6ICifn0h6Ga0v+fL/YF
         WtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qm8sdUluZvm64ONsBKm+UDVYTpFAlujmWCI3IdJ5PIA=;
        b=ADhxcoGBB+WUQYdxBPTkeeOUCD4GvdfG/xG8kkrhaQmpi2hxdpW8wDAJP5d7dFW7Hc
         S0wSgJmsHyh1DWcs8OEidJm5TvA6gtG8Ax/26COgmXzUeY5wQ8vjFxzmfb2lQbO7ZShM
         wJor1EqhR3d/AyEj0jT7ZzHR/xLWlf6XfQl+5OZz2nx1IRdZdM5WyyT8WIg+HhNKXGjR
         qZV8GwI57UyvhTYN0hDS5OPtRyX2+Qdj7L+f8Ly7QqN+G71TCBdpfXvZKHy0UtYfTsPi
         r/OmnrKL2ZWcRWsrsX6RVlsZK/72fDKj298T+ZCWRqNXeKLreegkMVDAU1XU9as1XXfp
         2uTA==
X-Gm-Message-State: AOAM5304K29yOxZ6gPXMOasc2TuYPapu2IBeEkeWNiiBoXU8FcStAXMB
        VshDZ+pM6iVXmXNpN5MuReixrN0fl1XGjGPc4KA=
X-Google-Smtp-Source: ABdhPJzTBVXwQq+Bgftscspz+4t5DSvKT3iaa+tYl/+d6Cawx+nfAfkV9NuTyd2TNgLX3L+LF7ZKBnXll1R5dPUe56I=
X-Received: by 2002:a05:6000:1864:: with SMTP id d4mr21810371wri.250.1629829747482;
 Tue, 24 Aug 2021 11:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210818005615.138527-1-joshdon@google.com> <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
 <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
 <YSS1/rqqsGaBX/yQ@hirez.programming.kicks-ass.net> <YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net>
In-Reply-To: <YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net>
From:   Vineeth Pillai <vineethrp@gmail.com>
Date:   Tue, 24 Aug 2021 14:28:54 -0400
Message-ID: <CAOBnfPjOLCxc5UUKTpP29j8CP9GgtMYvgFmjp6OaUGNaf+sN1Q@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Simplify core-wide task selection
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, tao.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Vineeth Pillai (Microsoft) <vineethrp@gmail.com>


On Tue, Aug 24, 2021 at 5:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Aug 24, 2021 at 11:03:58AM +0200, Peter Zijlstra wrote:
> > Let me go do that and also attempt a Changelog to go with it ;-)
>
> How's this then?
>
> ---
> Subject: sched/core: Simplify core-wide task selection
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue Aug 24 11:05:47 CEST 2021
>
> Tao suggested a two-pass task selection to avoid the retry loop.
>
> Not only does it avoid the retry loop, it results in *much* simpler
> code.
>
> This also fixes an issue spotted by Josh Don where, for SMT3+, we can
> forget to update max on the first pass and get to do an extra round.
>
> Suggested-by: Tao Zhou <tao.zhou@linux.dev>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c | 156 +++++++++++++++-------------------------------------
>  1 file changed, 45 insertions(+), 111 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ceae25ea8a0e..8a9a32df5f38 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5381,8 +5381,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                         return p;
>         }
>
> -       /* The idle class should always have a runnable task: */
> -       BUG();
> +       BUG(); /* The idle class should always have a runnable task. */
>  }
>
>  #ifdef CONFIG_SCHED_CORE
> @@ -5404,54 +5403,18 @@ static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
>         return a->core_cookie == b->core_cookie;
>  }
>
> -// XXX fairness/fwd progress conditions
> -/*
> - * Returns
> - * - NULL if there is no runnable task for this class.
> - * - the highest priority task for this runqueue if it matches
> - *   rq->core->core_cookie or its priority is greater than max.
> - * - Else returns idle_task.
> - */
> -static struct task_struct *
> -pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max, bool in_fi)
> +static inline struct task_struct *pick_task(struct rq *rq)
>  {
> -       struct task_struct *class_pick, *cookie_pick;
> -       unsigned long cookie = rq->core->core_cookie;
> -
> -       class_pick = class->pick_task(rq);
> -       if (!class_pick)
> -               return NULL;
> -
> -       if (!cookie) {
> -               /*
> -                * If class_pick is tagged, return it only if it has
> -                * higher priority than max.
> -                */
> -               if (max && class_pick->core_cookie &&
> -                   prio_less(class_pick, max, in_fi))
> -                       return idle_sched_class.pick_task(rq);
> +       const struct sched_class *class;
> +       struct task_struct *p;
>
> -               return class_pick;
> +       for_each_class(class) {
> +               p = class->pick_task(rq);
> +               if (p)
> +                       return p;
>         }
>
> -       /*
> -        * If class_pick is idle or matches cookie, return early.
> -        */
> -       if (cookie_equals(class_pick, cookie))
> -               return class_pick;
> -
> -       cookie_pick = sched_core_find(rq, cookie);
> -
> -       /*
> -        * If class > max && class > cookie, it is the highest priority task on
> -        * the core (so far) and it must be selected, otherwise we must go with
> -        * the cookie pick in order to satisfy the constraint.
> -        */
> -       if (prio_less(cookie_pick, class_pick, in_fi) &&
> -           (!max || prio_less(max, class_pick, in_fi)))
> -               return class_pick;
> -
> -       return cookie_pick;
> +       BUG(); /* The idle class should always have a runnable task. */
>  }
>
>  extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
> @@ -5459,11 +5422,12 @@ extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_f
>  static struct task_struct *
>  pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
> -       struct task_struct *next, *max = NULL;
> -       const struct sched_class *class;
> +       struct task_struct *next, *p, *max = NULL;
>         const struct cpumask *smt_mask;
>         bool fi_before = false;
> -       int i, j, cpu, occ = 0;
> +       unsigned long cookie;
> +       int i, cpu, occ = 0;
> +       struct rq *rq_i;
>         bool need_sync;
>
>         if (!sched_core_enabled(rq))
> @@ -5536,12 +5500,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>          * and there are no cookied tasks running on siblings.
>          */
>         if (!need_sync) {
> -               for_each_class(class) {
> -                       next = class->pick_task(rq);
> -                       if (next)
> -                               break;
> -               }
> -
> +               next = pick_task(rq);
>                 if (!next->core_cookie) {
>                         rq->core_pick = NULL;
>                         /*
> @@ -5554,76 +5513,51 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>                 }
>         }
>
> -       for_each_cpu(i, smt_mask) {
> -               struct rq *rq_i = cpu_rq(i);
> -
> -               rq_i->core_pick = NULL;
> +       /*
> +        * For each thread: do the regular task pick and find the max prio task
> +        * amongst them.
> +        *
> +        * Tie-break prio towards the current CPU
> +        */
> +       for_each_cpu_wrap(i, smt_mask, cpu) {
> +               rq_i = cpu_rq(i);
>
>                 if (i != cpu)
>                         update_rq_clock(rq_i);
> +
> +               p = rq_i->core_pick = pick_task(rq_i);
> +               if (!max || prio_less(max, p, fi_before))
> +                       max = p;
>         }
>
> +       cookie = rq->core->core_cookie = max->core_cookie;
> +
>         /*
> -        * Try and select tasks for each sibling in descending sched_class
> -        * order.
> +        * For each thread: try and find a runnable task that matches @max or
> +        * force idle.
>          */
> -       for_each_class(class) {
> -again:
> -               for_each_cpu_wrap(i, smt_mask, cpu) {
> -                       struct rq *rq_i = cpu_rq(i);
> -                       struct task_struct *p;
> -
> -                       if (rq_i->core_pick)
> -                               continue;
> +       for_each_cpu(i, smt_mask) {
> +               rq_i = cpu_rq(i);
> +               p = rq_i->core_pick;
>
> -                       /*
> -                        * If this sibling doesn't yet have a suitable task to
> -                        * run; ask for the most eligible task, given the
> -                        * highest priority task already selected for this
> -                        * core.
> -                        */
> -                       p = pick_task(rq_i, class, max, fi_before);
> +               if (!cookie_equals(p, cookie)) {
> +                       p = NULL;
> +                       if (cookie)
> +                               p = sched_core_find(rq_i, cookie);
>                         if (!p)
> -                               continue;
> +                               p = idle_sched_class.pick_task(rq_i);
> +               }
>
> -                       if (!is_task_rq_idle(p))
> -                               occ++;
> +               rq_i->core_pick = p;
>
> -                       rq_i->core_pick = p;
> -                       if (rq_i->idle == p && rq_i->nr_running) {
> +               if (p == rq_i->idle) {
> +                       if (rq_i->nr_running) {
>                                 rq->core->core_forceidle = true;
>                                 if (!fi_before)
>                                         rq->core->core_forceidle_seq++;
>                         }
> -
> -                       /*
> -                        * If this new candidate is of higher priority than the
> -                        * previous; and they're incompatible; we need to wipe
> -                        * the slate and start over. pick_task makes sure that
> -                        * p's priority is more than max if it doesn't match
> -                        * max's cookie.
> -                        *
> -                        * NOTE: this is a linear max-filter and is thus bounded
> -                        * in execution time.
> -                        */
> -                       if (!max || !cookie_match(max, p)) {
> -                               struct task_struct *old_max = max;
> -
> -                               rq->core->core_cookie = p->core_cookie;
> -                               max = p;
> -
> -                               if (old_max) {
> -                                       rq->core->core_forceidle = false;
> -                                       for_each_cpu(j, smt_mask) {
> -                                               if (j == i)
> -                                                       continue;
> -
> -                                               cpu_rq(j)->core_pick = NULL;
> -                                       }
> -                                       occ = 1;
> -                                       goto again;
> -                               }
> -                       }
> +               } else {
> +                       occ++;
>                 }
>         }
>
> @@ -5643,7 +5577,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>          * non-matching user state.
>          */
>         for_each_cpu(i, smt_mask) {
> -               struct rq *rq_i = cpu_rq(i);
> +               rq_i = cpu_rq(i);
>
>                 /*
>                  * An online sibling might have gone offline before a task



--
Cheers,
~Vineeth

## "Its not the load that breaks you, but the way u carry it!" ##
