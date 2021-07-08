Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD3E3BF7F8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 12:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhGHKJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 06:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhGHKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 06:09:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2832EC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sq7hOUwHqAjbRudakP2AUYldAzTp3kQs67P5kTg0O5w=; b=qv7TbU6zAs/QqMw8SpI4anC0B0
        DmerV5QdnqxfYWSCKweY6+4v1ClpcJwRorvPMzg3cmMYnwz/iYK4oU38Kh7+rYqhOxGltl1g0hTTW
        R8/XxUK6avKB97GPAAGn1yB78mCyJVrtinUSFG51rMvWmwAhn9Ub4sXcC7bBuVLsdK/0fzAEg8WC7
        ubwdbPD6Z0zriNRiq7KzEZdTaLS9G0oL9jHDiUlKiTdQRl+bM6541lwV2fpHd4CMEsEoVUeRlLZPt
        aaznz4M4PA3uRqwefjLivEc04BxrsquSvUzbcIBf4Rm+HgVGP38CDFU4jvGyZUwrNlYMlQ5S/3P6w
        xVp2ztJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m1QvN-00FbPD-GM; Thu, 08 Jul 2021 10:06:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 953D4300233;
        Thu,  8 Jul 2021 12:06:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56F54200F8B7A; Thu,  8 Jul 2021 12:06:27 +0200 (CEST)
Date:   Thu, 8 Jul 2021 12:06:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, bristot@redhat.com, bsegall@google.com,
        mgorman@suse.de, Mark Simmons <msimmons@redhat.com>
Subject: Re: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Message-ID: <YObOIwH7MbfagklQ@hirez.programming.kicks-ass.net>
References: <20210701091431.256457-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701091431.256457-1-juri.lelli@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 11:14:31AM +0200, Juri Lelli wrote:
> Double enqueues in rt runqueues (list) have been reported while running
> a simple test that spawns a number of threads doing a short sleep/run
> pattern while being concurrently setscheduled between rt and fair class.

> __sched_setscheduler() uses rt_effective_prio() to handle proper queuing
> of priority boosted tasks that are setscheduled while being boosted.
> rt_effective_prio() is however called twice per each
> __sched_setscheduler() call: first directly by __sched_setscheduler()
> before dequeuing the task and then by __setscheduler() to actually do
> the priority change. If the priority of the pi_top_task is concurrently
> being changed however, it might happen that the two calls return
> different results. If, for example, the first call returned the same rt
> priority the task was running at and the second one a fair priority, the
> task won't be removed by the rt list (on_list still set) and then
> enqueued in the fair runqueue. When eventually setscheduled back to rt
> it will be seen as enqueued already and the WARNING/BUG be issued.
> 
> Fix this by calling rt_effective_prio() only once and then reusing the
> return value. Concurrent priority inheritance handling is still safe and
> will eventually converge to a new state by following the inheritance
> chain(s).
> 
> Fixes: ff77e46853598 ("sched/rt: Fix PI handling vs. sched_setscheduler()")

You sure? AFAICT that commit only adds the warning that's triggered
here, but the double rt_effective_prio() call seems to predate that. Or
am I missing something about the on_rq changes in that patch?

Commit 0782e63bc6fe seems to introduce the double call..

> ---
>  kernel/sched/core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0c22cd026440..c84ac1d675f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6823,7 +6823,8 @@ static void __setscheduler_params(struct task_struct *p,
>  
>  /* Actually do priority change: must hold pi & rq lock. */
>  static void __setscheduler(struct rq *rq, struct task_struct *p,
> -			   const struct sched_attr *attr, bool keep_boost)
> +			   const struct sched_attr *attr, bool keep_boost,
> +			   int new_effective_prio)
>  {
>  	/*
>  	 * If params can't change scheduling class changes aren't allowed
> @@ -6840,7 +6841,7 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
>  	 */
>  	p->prio = normal_prio(p);
>  	if (keep_boost)
> -		p->prio = rt_effective_prio(p, p->prio);
> +		p->prio = new_effective_prio;
>  
>  	if (dl_prio(p->prio))
>  		p->sched_class = &dl_sched_class;
> @@ -6873,7 +6874,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
>  		      MAX_RT_PRIO - 1 - attr->sched_priority;
>  	int retval, oldprio, oldpolicy = -1, queued, running;
> -	int new_effective_prio, policy = attr->sched_policy;
> +	int new_effective_prio = newprio, policy = attr->sched_policy;
>  	const struct sched_class *prev_class;
>  	struct callback_head *head;
>  	struct rq_flags rf;
> @@ -7072,6 +7073,9 @@ static int __sched_setscheduler(struct task_struct *p,
>  	oldprio = p->prio;
>  
>  	if (pi) {
> +		newprio = fair_policy(attr->sched_policy) ?
> +			NICE_TO_PRIO(attr->sched_nice) : newprio;

*groan*.... That completes our local copy of normal_prio() based off of
attr.

>  		/*
>  		 * Take priority boosted tasks into account. If the new
>  		 * effective priority is unchanged, we just store the new
> @@ -7093,7 +7097,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  
>  	prev_class = p->sched_class;
>  
> -	__setscheduler(rq, p, attr, pi);
> +	__setscheduler(rq, p, attr, pi, new_effective_prio);
>  	__setscheduler_uclamp(p, attr);
>  
>  	if (queued) {

Slightly larger patch, but perhaps a little cleaner.. still pondering if
we can share a little more between __sched_setscheduler() and
rt_mutex_setprio().

---
 kernel/sched/core.c | 51 +++++++++++++++++++++------------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 970b95ff2952..ede10642612c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1983,12 +1983,18 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
-/*
- * __normal_prio - return the priority that is based on the static prio
- */
-static inline int __normal_prio(struct task_struct *p)
+static inline int __normal_prio(int policy, int rt_prio, int nice)
 {
-	return p->static_prio;
+	int prio;
+
+	if (dl_policy(policy))
+		prio = MAX_DL_PRIO - 1;
+	else if (rt_policy(policy))
+		prio = MAX_RT_PRIO - 1 - rt_prio;
+	else
+		prio = NICE_TO_PRIO(nice);
+
+	return prio;
 }
 
 /*
@@ -2000,15 +2006,7 @@ static inline int __normal_prio(struct task_struct *p)
  */
 static inline int normal_prio(struct task_struct *p)
 {
-	int prio;
-
-	if (task_has_dl_policy(p))
-		prio = MAX_DL_PRIO-1;
-	else if (task_has_rt_policy(p))
-		prio = MAX_RT_PRIO-1 - p->rt_priority;
-	else
-		prio = __normal_prio(p);
-	return prio;
+	return __normal_prio(p->policy, p->rt_priority, PRIO_TO_NICE(p->static_prio));
 }
 
 /*
@@ -4101,7 +4099,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		} else if (PRIO_TO_NICE(p->static_prio) < 0)
 			p->static_prio = NICE_TO_PRIO(0);
 
-		p->prio = p->normal_prio = __normal_prio(p);
+		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
 		/*
@@ -6828,7 +6826,7 @@ static void __setscheduler_params(struct task_struct *p,
 
 /* Actually do priority change: must hold pi & rq lock. */
 static void __setscheduler(struct rq *rq, struct task_struct *p,
-			   const struct sched_attr *attr, bool keep_boost)
+			   const struct sched_attr *attr, int newprio)
 {
 	/*
 	 * If params can't change scheduling class changes aren't allowed
@@ -6839,13 +6837,7 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
 
 	__setscheduler_params(p, attr);
 
-	/*
-	 * Keep a potential priority boosting if called from
-	 * sched_setscheduler().
-	 */
-	p->prio = normal_prio(p);
-	if (keep_boost)
-		p->prio = rt_effective_prio(p, p->prio);
+	p->prio = newprio;
 
 	if (dl_prio(p->prio))
 		p->sched_class = &dl_sched_class;
@@ -6875,10 +6867,8 @@ static int __sched_setscheduler(struct task_struct *p,
 				const struct sched_attr *attr,
 				bool user, bool pi)
 {
-	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
-		      MAX_RT_PRIO - 1 - attr->sched_priority;
-	int retval, oldprio, oldpolicy = -1, queued, running;
-	int new_effective_prio, policy = attr->sched_policy;
+	int oldpolicy = -1, policy = attr->sched_policy;
+	int retval, oldprio, newprio, queued, running;
 	const struct sched_class *prev_class;
 	struct callback_head *head;
 	struct rq_flags rf;
@@ -7076,6 +7066,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	p->sched_reset_on_fork = reset_on_fork;
 	oldprio = p->prio;
 
+	newprio = __normal_prio(policy, attr->sched_priority, attr->sched_nice);
 	if (pi) {
 		/*
 		 * Take priority boosted tasks into account. If the new
@@ -7084,8 +7075,8 @@ static int __sched_setscheduler(struct task_struct *p,
 		 * the runqueue. This will be done when the task deboost
 		 * itself.
 		 */
-		new_effective_prio = rt_effective_prio(p, newprio);
-		if (new_effective_prio == oldprio)
+		newprio = rt_effective_prio(p, newprio);
+		if (newprio == oldprio)
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
@@ -7098,7 +7089,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	prev_class = p->sched_class;
 
-	__setscheduler(rq, p, attr, pi);
+	__setscheduler(rq, p, attr, newprio);
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
