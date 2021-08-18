Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718AE3F07DB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbhHRPSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbhHRPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:18:05 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3295C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:17:29 -0700 (PDT)
Date:   Wed, 18 Aug 2021 23:18:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629299847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3YlFb+4eLIBsHD2njGWNtgCir4gcnrhVJ4c0ZJ9EjjI=;
        b=SyDEyQpervkYhLWQ7Gy2V74NH0oljCTaVZi5O2NGHvQslNNrSq+bhGE+b6TiVNASR3QLdO
        deIJeMY4+efIZ604w5w3JWI3N6jbSn3Im+0bmyUANPgOpPY2E41fLTIt/Y96PbfOroqkvZ
        AFCBfFQmAuDhPCmRLGAaJyrCLdsUFJ8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Josh Don <joshdon@google.com>, Tao Zhou <tao.zhou@linux.dev>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: fix pick_next_task 'max' tracking
Message-ID: <YR0ks1/0EPkhFsYZ@geo.homenetwork>
References: <20210818005615.138527-1-joshdon@google.com>
 <YRyOAUGn7AplmHZW@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRyOAUGn7AplmHZW@geo.homenetwork>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 18, 2021 at 12:35:13PM +0800, Tao Zhou wrote:
> Hi Josh,
> 
> On Tue, Aug 17, 2021 at 05:56:15PM -0700, Josh Don wrote:
> > For core-sched, pick_next_task will update the 'max' task if there is a
> > cookie mismatch (since in this case the new task must be of higher
> > priority than the current max). However, we fail to update 'max' if
> > we've found a task with a matching cookie and higher priority than
> > 'max'.
> > 
> > This can result in extra iterations on SMT-X machines, where X > 2.
> > 
> > As an example, on a machine with SMT=3, on core 0, SMT-0 might pick
> > the following, in order:
> > 
> > - SMT-0: p1, with cookie A, and priority 10 (max = p1)
> > - SMT-1: p2, with cookie A, and priority 30 (max not updated here)
> 
> Thanks for your illustration. Good catch.
> The guilty is 'cookie_equals(class_pick, cookie))' condition in pick_task()
> 
> > - SMT-2: p3, with cookie B, and priority 20 (max = p2)
> > 	> invalidate the other picks and retry
> > 
> > Here, we should have instead updated 'max' when picking for SMT-1. Note
> > that this code would eventually have righted itself, since the retry
> > loop would re-pick p2, and update 'max' accordingly. However, this patch
> > avoids the extra round-trip.
> 
> This is correct then may increase the chance to retry. That means it is
> more possible to filter the max first(not sure).
> 
> > Signed-off-by: Josh Don <joshdon@google.com>
> > ---
> >  kernel/sched/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3431939699dc..110ea7582a33 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5623,6 +5623,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  					occ = 1;
> >  					goto again;
> >  				}
> > +			} else if (prio_less(max, p, fi_before)) {
> > +				max = p;
> >  			}
> >  		}
> >  	}
> > -- 
> > 2.33.0.rc1.237.g0d66db33f3-goog
> > 

My ugly patch need to continue, not compiled.
Rebase on the previous patch.

From 79f25599486c79ecb2e78875498b24f1320060b8 Mon Sep 17 00:00:00 2001
From: Tao Zhou <tao.zhou@linux.dev>
Date: Wed, 18 Aug 2021 00:07:38 +0800
Subject: [PATCH] optimize pick_next_task()

sched/core: Optimize pick_next_task() not sure

---
 kernel/sched/core.c  | 78 ++++++++++++++++++++++++++++++--------------
 kernel/sched/sched.h |  1 +
 2 files changed, 54 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc044134..18f236f75170 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5370,28 +5370,42 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
 		if (max && class_pick->core_cookie &&
 		    prio_less(class_pick, max, in_fi))
 			return idle_sched_class.pick_task(rq);
-
-		return class_pick;
 	}
 
-	/*
-	 * If class_pick is idle or matches cookie, return early.
-	 */
-	if (cookie_equals(class_pick, cookie))
-		return class_pick;
+	return class_pick;
+}
+
+static task_struct *
+filter_max_prio(struct rq *rq, struct task_struct *class_pick, struct task_struct *max, bool in_fi)
+{
+	unsigned long cookie = rq->core->core_cookie;
+	struct task_struct *cookie_pick = NULL;
+	bool cookie_core_temp = false;
 
-	cookie_pick = sched_core_find(rq, cookie);
+	rq->core_temp = class_pick;
 
-	/*
-	 * If class > max && class > cookie, it is the highest priority task on
-	 * the core (so far) and it must be selected, otherwise we must go with
-	 * the cookie pick in order to satisfy the constraint.
-	 */
-	if (prio_less(cookie_pick, class_pick, in_fi) &&
-	    (!max || prio_less(max, class_pick, in_fi)))
-		return class_pick;
+	if (cookie) {
+		if (!cookie_equals(class_pick, cookie)) {
+			cookie_pick = sched_core_find(rq, cookie);
+			/*
+			 * If class > max && class > cookie, it is the
+			 * highest priority task on the core (so far)
+			 * and it must be selected, otherwise we must
+			 * go with the cookie pick in order to satisfy
+			 * the constraint.
+			 */
+			if (prio_less(cookie_pick, class_pick, in_fi) &&
+			    (!max || prio_less(max, class_pick, in_fi)))
+				return class_pick;
+			cookie_core_temp = true;
+		} else if (prio_less(max, class_pick, fi_before))
+				return class_pick;
+	}
 
-	return cookie_pick;
+	if (cookie_core_temp)
+		rq->core_temp = cookie_pick;
+
+	return NULL;
 }
 
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
@@ -5508,24 +5522,37 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * order.
 	 */
 	for_each_class(class) {
-again:
+		struct task_struct *class_pick, *cookie_pick;
+		struct rq *rq_i;
+
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			rq_i = cpu_rq(i);
+			class_pick = pick_task(rq_i, class, max, fi_before);
+			/*
+			 * This sibling doesn't yet have a suitable task to run.
+			 */
+			if (!class_pick)
+				continue;
+
+			if (filter_max_prio(rq_i, class_pick, max, fi_before))
+				max = class_pick;
+		}
+
 		for_each_cpu_wrap(i, smt_mask, cpu) {
-			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
+			rq_i = cpu_rq(i);
 
 			if (rq_i->core_pick)
 				continue;
 
 			/*
-			 * If this sibling doesn't yet have a suitable task to
-			 * run; ask for the most eligible task, given the
-			 * highest priority task already selected for this
-			 * core.
+			 * This sibling doesn't yet have a suitable task to run.
 			 */
-			p = pick_task(rq_i, class, max, fi_before);
-			if (!p)
+			if (!rq_i->core_temp)
 				continue;
 
+			p = rq_i->core_temp;
+
 			if (!is_task_rq_idle(p))
 				occ++;
 
@@ -9024,6 +9051,7 @@ void __init sched_init(void)
 #ifdef CONFIG_SCHED_CORE
 		rq->core = NULL;
 		rq->core_pick = NULL;
+		rq->core_temp = NULL;
 		rq->core_enabled = 0;
 		rq->core_tree = RB_ROOT;
 		rq->core_forceidle = false;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a243f7b..2b21a3846b8e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1089,6 +1089,7 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	struct task_struct	*core_pick;
+	struct task_struct	*core_temp;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
-- 
2.31.1



Thanks,
Tao
