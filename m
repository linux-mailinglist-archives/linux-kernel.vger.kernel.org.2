Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCB3C3B16
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 09:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhGKHoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 03:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 03:44:07 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7076FC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 00:41:20 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id j12so15660054ils.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QfVRiE2PbK2arujiv5b9YwZy1rW6n9MrUAZc+jz7eU8=;
        b=GkHF47GmBs3QPiRv51sD/8FCwv3it5DlHGumaWXIMR3ihV3rg8PTuI9TEVhIj5gL6o
         5FFyuz39t1ogTp/TAqlA8rGEFUaKtH6szA45O28dEDzq3ip9+AOTO9z9jpATHVG4sJed
         /8hjt79Kn+8dx3plTs5mm5w4B14+t2R0wfn2ruO5F62/+3/Ki4Gx7J7bbHQsj5zOvB/O
         OoqkKi1lofosqsRE/v+TRfPHnpCxXFku6p8rk0x/Doi8AExCDqHju6cJ8INkmcVLRyME
         yihHpE3JU6tYx3MP3FyCWNuczX2uPJpm6Nugmn0Q+oTmRot2+XN/zL+rG7ifyVcZXm+I
         s/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QfVRiE2PbK2arujiv5b9YwZy1rW6n9MrUAZc+jz7eU8=;
        b=FqZAzEaPtCHY9rtapkXqrBlK5dyZunCI7G5nRvg1v1xQ50QSS8BHdvvm5V/VkIruYx
         fRmuUjs70THJ8htKS9c0P87zQdG3u5vRkIViqfDL88pOgWLhhCHnl+AuLntDiBd44pue
         GZ1hxleJ/ZPihgXAZfJ4mlX4IftVoCabjP6aLUBqb84NkNFqJR88R3eLOfKUd0FryPGg
         sVkjCMr1aBp+ve9/wNcAVplRwwZ57LIgQZakZRZXlUeLOseUMRitIkgkj3+XyL9MnaUc
         B8DFR2O0i4tKITNfhtL30Yyz8g7AvO+wiYeyIiaccymNOjKMpqw8amQPVbAHKnXUbchX
         yEjg==
X-Gm-Message-State: AOAM53075txgm+oA6OjpbydRTsFUPok43c8qG0VfTdILo6Ts3o9ngmom
        0MTxxgtaR7nlL/nTs4+1/VaCQrKwxjgAiwC7Z90=
X-Google-Smtp-Source: ABdhPJySf3EsORz8Uuo/EU+y3jxh1SI3stqbd8skgVJLSFcrnzNESlSYrcQjDqHObEXRWYK/Oqe80daWLmmTqqAW2OM=
X-Received: by 2002:a05:6e02:1154:: with SMTP id o20mr15699063ill.168.1625989279802;
 Sun, 11 Jul 2021 00:41:19 -0700 (PDT)
MIME-Version: 1.0
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sun, 11 Jul 2021 15:40:44 +0800
Message-ID: <CALOAHbAS26LP2p9Fe7m6xynZmazYENmx_HfTV4LebwPWr7XLmA@mail.gmail.com>
Subject: [RFC PATCH 1/1] sched: do active load balance in balance callback
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The active load balance which means to migrate the CFS task running on
the busiest CPU to the new idle CPU has a known issue[1][2] that
there are some race window between waking up the migration thread on the
busiest CPU and it begins to preempt the current running CFS task.
These race window may cause unexpected behavior that the latency
sensitive RT tasks may be preempted by the migration thread as it has a
higher priority.

This RFC patch tries to improve this situation. Instead of waking up the
migration thread to do this work, this patch do it in the balance
callback as follows,

     The New idle CPUm                The target CPUn
     find the target task A           CFS task A is running
     queue it into the target CPUn    A is scheduling out
                                      do balance callback and migrate A to CPUm
It avoids two context switches - task A to migration/n and migration/n to
task B. And it avoids preempting the RT task if the RT task has already
preempted task A before we do the queueing.

TODO:
- I haven't done some benchmark to measure the impact on performance
- To avoid deadlock I have to unlock the busiest_rq->lock before
  calling attach_one_task() and lock it again after executing
  attach_one_task(). That may re-introduce the issue addressed by
  commit 565790d28b1e ("sched: Fix balance_callback()")

[1]. https://lore.kernel.org/lkml/CAKfTPtBygNcVewbb0GQOP5xxO96am3YeTZNP5dK9BxKHJJAL-g@mail.gmail.com/
[2]. https://lore.kernel.org/lkml/20210615121551.31138-1-laoar.shao@gmail.com/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 69 ++++++++++++++------------------------------
 kernel/sched/sched.h |  6 +++-
 3 files changed, 28 insertions(+), 48 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4ca80df205ce..a0a90a37e746 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8208,6 +8208,7 @@ void __init sched_init(void)
                rq->cpu_capacity = rq->cpu_capacity_orig = SCHED_CAPACITY_SCALE;
                rq->balance_callback = &balance_push_callback;
                rq->active_balance = 0;
+               rq->active_balance_target = NULL;
                rq->next_balance = jiffies;
                rq->push_cpu = 0;
                rq->cpu = i;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23663318fb81..9aaa75250cdc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7751,36 +7751,6 @@ static void detach_task(struct task_struct *p,
struct lb_env *env)
        set_task_cpu(p, env->dst_cpu);
 }

-/*
- * detach_one_task() -- tries to dequeue exactly one task from env->src_rq, as
- * part of active balancing operations within "domain".
- *
- * Returns a task if successful and NULL otherwise.
- */
-static struct task_struct *detach_one_task(struct lb_env *env)
-{
-       struct task_struct *p;
-
-       lockdep_assert_held(&env->src_rq->lock);
-
-       list_for_each_entry_reverse(p,
-                       &env->src_rq->cfs_tasks, se.group_node) {
-               if (!can_migrate_task(p, env))
-                       continue;
-
-               detach_task(p, env);
-
-               /*
-                * Right now, this is only the second place where
-                * lb_gained[env->idle] is updated (other is detach_tasks)
-                * so we can safely collect stats here rather than
-                * inside detach_tasks().
-                */
-               schedstat_inc(env->sd->lb_gained[env->idle]);
-               return p;
-       }
-       return NULL;
-}

 static const unsigned int sched_nr_migrate_break = 32;

@@ -9606,7 +9576,7 @@ static int need_active_balance(struct lb_env *env)
        return 0;
 }

-static int active_load_balance_cpu_stop(void *data);
+static void active_load_balance_cpu_stop(struct rq *busiest_rq);

 static int should_we_balance(struct lb_env *env)
 {
@@ -9640,6 +9610,8 @@ static int should_we_balance(struct lb_env *env)
        return group_balance_cpu(sg) == env->dst_cpu;
 }

+DEFINE_PER_CPU(struct callback_head, active_balance_head);
+
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -9845,15 +9817,14 @@ static int load_balance(int this_cpu, struct
rq *this_rq,
                        if (!busiest->active_balance) {
                                busiest->active_balance = 1;
                                busiest->push_cpu = this_cpu;
+                               busiest->active_balance_target = busiest->curr;
                                active_balance = 1;
                        }
-                       raw_spin_unlock_irqrestore(&busiest->lock, flags);

-                       if (active_balance) {
-                               stop_one_cpu_nowait(cpu_of(busiest),
-                                       active_load_balance_cpu_stop, busiest,
-                                       &busiest->active_balance_work);
-                       }
+                       if (active_balance)
+                               queue_balance_callback(busiest,
&per_cpu(active_balance_head, busiest->cpu),
active_load_balance_cpu_stop);
+
+                       raw_spin_unlock_irqrestore(&busiest->lock, flags);
                }
        } else {
                sd->nr_balance_failed = 0;
@@ -9953,17 +9924,14 @@ update_next_balance(struct sched_domain *sd,
unsigned long *next_balance)
  * least 1 task to be running on each physical CPU where possible, and
  * avoids physical / logical imbalances.
  */
-static int active_load_balance_cpu_stop(void *data)
+static void active_load_balance_cpu_stop(struct rq *busiest_rq)
 {
-       struct rq *busiest_rq = data;
        int busiest_cpu = cpu_of(busiest_rq);
        int target_cpu = busiest_rq->push_cpu;
        struct rq *target_rq = cpu_rq(target_cpu);
        struct sched_domain *sd;
        struct task_struct *p = NULL;
-       struct rq_flags rf;

-       rq_lock_irq(busiest_rq, &rf);
        /*
         * Between queueing the stop-work and running it is a hole in which
         * CPUs can become inactive. We should not move tasks from or to
@@ -10009,26 +9977,33 @@ static int active_load_balance_cpu_stop(void *data)
                schedstat_inc(sd->alb_count);
                update_rq_clock(busiest_rq);

-               p = detach_one_task(&env);
-               if (p) {
+               p = busiest_rq->active_balance_target;
+
+               if (p && p->sched_class == &fair_sched_class &&
+                   /* In case it goes into sleep.  */
+                   p->state == TASK_RUNNING &&
+                   /* In case it has already been migrated. */
+                   rq_of(task_cfs_rq(p)) == busiest_rq &&
+                   can_migrate_task(p, &env)) {
+                       detach_task(p, &env);
                        schedstat_inc(sd->alb_pushed);
                        /* Active balancing done, reset the failure counter. */
                        sd->nr_balance_failed = 0;
                } else {
                        schedstat_inc(sd->alb_failed);
+                       p = NULL;
                }
        }
        rcu_read_unlock();
 out_unlock:
        busiest_rq->active_balance = 0;
-       rq_unlock(busiest_rq, &rf);
+       busiest_rq->active_balance_target = NULL;
+       raw_spin_unlock(&busiest_rq->lock);

        if (p)
                attach_one_task(target_rq, p);

-       local_irq_enable();
-
-       return 0;
+       raw_spin_lock(&busiest_rq->lock);
 }

 static DEFINE_SPINLOCK(balancing);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec13729..667e058dc6de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 /*
  * Scheduler internal types and methods:
  */
@@ -999,6 +1000,7 @@ struct rq {
        int                     active_balance;
        int                     push_cpu;
        struct cpu_stop_work    active_balance_work;
+       struct task_struct      *active_balance_target;

        /* CPU of this runqueue: */
        int                     cpu;
@@ -1241,6 +1243,7 @@ struct rq_flags {
 };

 extern struct callback_head balance_push_callback;
+extern DEFINE_PER_CPU(struct callback_head, active_balance_head);

 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
@@ -1260,7 +1263,8 @@ static inline void rq_pin_lock(struct rq *rq,
struct rq_flags *rf)
        rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
        rf->clock_update_flags = 0;
 #ifdef CONFIG_SMP
-       SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
&balance_push_callback);
+       SCHED_WARN_ON(rq->balance_callback && (rq->balance_callback !=
&balance_push_callback &&
+                     rq->balance_callback !=
&per_cpu(active_balance_head, cpu_of(rq))));
 #endif
 #endif
 }
--
2.17.1
