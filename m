Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB1D3F6889
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhHXSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbhHXR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:59:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2893C08ED8A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:40:25 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id x140so8276096ybe.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UwVp3TaTrsW4yFZIGDaaNefCtZpYijG6P9cNfIiRWFs=;
        b=JVU8DDJfmYOaTtEs7m7fMk+Zp/gcPMpZrtO3FuN+pWzA1ygtP52hhITN4j+0V/ftQE
         Omanc4vfr2kxM0K+VFSppJ5SIbDcKyy+a1XSGSkhyQwhNadvTlCz/nd8JhOIX78D32tQ
         RzfUnfl8+5z+RT/sdtBsQ4/QTtg1PLQZ+IV4DRZNHYvaoLXsoEDDadKPHhs7KUX+ZlDq
         QJg+3DCdUJrgcXpT0rDbXfZQunT34Q5BdSmy9RnXXQARPauPY4srtIXpTi6p716rq5is
         SYdGZAfUzzebA7T2xKdiS6w7CdGJ1NjR8W3sanC2T5ASk0Jfi7rHfFX+KQ+Y8/1sSFgO
         Kiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UwVp3TaTrsW4yFZIGDaaNefCtZpYijG6P9cNfIiRWFs=;
        b=KfJJS9E8jbLsPqgvBrx6Ilb7vPJ6gybp094pDX3avYRVwiL28xwGI3VkyVvmENGMhw
         DttK4+u13ayfXtZ0WCbS103HJ0NjeS/HJR+T6ZUYDEcuv5SrygAxi6U6MZ0jKvS5O9wW
         AcqlbvvwVnCYaYLnSfnsm+WSW0qZ9MIHJF7wj6Yy07ZLpvwF3/aHJGLdKB/u4WIoO+El
         paR3qrkzVxRgG1iK9xlGIVDXjpgRk82RoDSag4SRPalWhQQArvaDWgi6tDRdAbXUhCdg
         pe4kNWNjL4ZeTuckFkd1zVlWcVxY2l7B3wEdZpfAZToij+K7eEaZ7YyAT5yLriUH5Ilr
         udyg==
X-Gm-Message-State: AOAM532t6QZZO51wxpFhqDNggkoGZ8yjpmefWBjfvJpev0b/EP64bDLi
        PAaYnHUnFuaJkFzs1Vl3fQliqiBTW4oZ3AGYZwPLqw==
X-Google-Smtp-Source: ABdhPJzF+Mlo7BQh5YVf/svCpx69TquFepkJPwJfpzkEgAtDfvMJl66TlEpJePEwAJEE4ucYOE+byat9Qk9zlYt2N4o=
X-Received: by 2002:a5b:391:: with SMTP id k17mr53684767ybp.152.1629826824711;
 Tue, 24 Aug 2021 10:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210818005615.138527-1-joshdon@google.com> <YSODqN9G7VuV+kNR@hirez.programming.kicks-ass.net>
 <CAOBnfPjH=y3Lk7AukLeG4mNcJnf5cgV260=PZCbF9u69-T+Q6Q@mail.gmail.com>
 <YSS1/rqqsGaBX/yQ@hirez.programming.kicks-ass.net> <YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net>
In-Reply-To: <YSS9+k1teA9oPEKl@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 24 Aug 2021 10:40:13 -0700
Message-ID: <CABk29Nt7413WKqhYDdA5qwPAiwUr7mWWpE02J5aaYSTbOoEzOQ@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Simplify core-wide task selection
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Pillai <vineethrp@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tao Zhou <tao.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 2:38 AM Peter Zijlstra <peterz@infradead.org> wrote:
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

Reviewed-by: Josh Don <joshdon@google.com>

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
