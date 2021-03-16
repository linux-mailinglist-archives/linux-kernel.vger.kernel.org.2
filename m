Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A733D1ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhCPKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236752AbhCPKlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:41:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40667C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 03:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Za9d4mYKlmTYAcsUaNg5XsP5rEazNpyEw99LFyb5Cbc=; b=gax3tqXfmeFBxjzTdKOl4wn59k
        Cf7pETJZ/S4OGH7fyXLvTEONyRE+3DLdfJ45/CrC2/a76QAmLIOarRGlaYtC5PdPFfzrUfzjN9k8j
        sZOvBpo5SSek/vdt6ombYQyALTm2/iwvb9mVoSb6gE7SlpnW+ZaCz+aWC+DejKOY9E7bajPVWyvgb
        IkhSLZhQx/VYC2TFe4vUnqgsfIa3Zlj0uZVHhDjoXMYYes7GMAQiejTV2jOmUTU9m0oKrUUgHAAA2
        d6nw6CjdMQy4UKcLRyX9uuroE+4a/MLz526O2ItNP8XYiCXKUjWaaLvOK2egpKqTqC48HnhpTWKXk
        Z9a702og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM780-000QeY-R5; Tue, 16 Mar 2021 10:40:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24E50301324;
        Tue, 16 Mar 2021 11:40:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 090C320160BD6; Tue, 16 Mar 2021 11:40:36 +0100 (CET)
Date:   Tue, 16 Mar 2021 11:40:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        odin@uged.al, odin@ugedal.com, pauld@redhead.com, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com, tj@kernel.org,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: Re: [PATCH v4 1/4] sched/fair: Introduce primitives for CFS
 bandwidth burst
Message-ID: <YFCLI79Tm0i8uaxH@hirez.programming.kicks-ass.net>
References: <20210316044931.39733-1-changhuaixin@linux.alibaba.com>
 <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316044931.39733-2-changhuaixin@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:49:28PM +0800, Huaixin Chang wrote:
> And the maximun amount of CPU a group can consume in
> a given period is "buffer" which is equivalent to "quota" + "burst in
> case that this group has done enough accumulation.

I'm confused as heck about cfs_b->buffer. Why do you need that? What's
wrong with cfs_b->runtime ?

Currently, by being strict, we ignore any remaining runtime and the
period timer resets runtime to quota and life goes on. What you want to
do is instead of resetting runtime, add quota and limit the total.

That is, currently it does:

	runtime = min(runtime + quota, quota);

which by virtue of runtime not being allowed negative, it the exact same
as:

	runtime = quota;

Which is what we have in refill.

Fix that to be something like:

	runtime = min(runtime + quota, quota + burst)

and you're basically done. And that seems *much* simpler.

What am I missing, why have you made it so complicated?


/me looks again..

Oooh, I think I see, all this is because you don't do your constraints
right. Removing static from max_cfs_runtime is a big clue you did that
wrong.

Something like this on top of the first two. Much simpler!

Now I just need to figure out wth you mucked about with where we call
refill.

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8954,7 +8954,7 @@ static DEFINE_MUTEX(cfs_constraints_mute
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
 static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 /* More than 203 days if BW_SHIFT equals 20. */
-const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
+static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -8989,10 +8989,10 @@ static int tg_set_cfs_bandwidth(struct t
 	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
 		return -EINVAL;
 
-	/*
-	 * Bound burst to defend burst against overflow during bandwidth shift.
-	 */
-	if (burst > max_cfs_runtime)
+	if (burst > quota)
+		return -EINVAL;
+
+	if (quota + burst > max_cfs_runtime)
 		return -EINVAL;
 
 	/*
@@ -9019,8 +9019,6 @@ static int tg_set_cfs_bandwidth(struct t
 	cfs_b->burst = burst;
 
 	if (runtime_enabled) {
-		cfs_b->buffer = min(max_cfs_runtime, quota + burst);
-		cfs_b->max_overrun = DIV_ROUND_UP_ULL(max_cfs_runtime, quota);
 		cfs_b->runtime = cfs_b->quota;
 
 		/* Restart the period timer (if active) to handle new period expiry: */
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4621,23 +4621,22 @@ static inline u64 sched_cfs_bandwidth_sl
  *
  * requires cfs_b->lock
  */
-static void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b,
-					   u64 overrun)
+static void
+__refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b, u64 overrun)
 {
-	u64 refill;
-
-	if (cfs_b->quota != RUNTIME_INF) {
-
-		if (!sysctl_sched_cfs_bw_burst_enabled) {
-			cfs_b->runtime = cfs_b->quota;
-			return;
-		}
+	if (unlikely(cfs_b->quota == RUNTIME_INF))
+		return;
 
-		overrun = min(overrun, cfs_b->max_overrun);
-		refill = cfs_b->quota * overrun;
-		cfs_b->runtime += refill;
-		cfs_b->runtime = min(cfs_b->runtime, cfs_b->buffer);
+	if (!sysctl_sched_cfs_bw_burst_enabled) {
+		cfs_b->runtime = cfs_b->quota;
+		return;
 	}
+
+	/*
+	 * Ignore @overrun since burst <= quota.
+	 */
+	cfs_b->runtime += cfs_b->quota;
+	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -5226,7 +5225,6 @@ static enum hrtimer_restart sched_cfs_sl
 }
 
 extern const u64 max_cfs_quota_period;
-extern const u64 max_cfs_runtime;
 
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
@@ -5256,18 +5254,7 @@ static enum hrtimer_restart sched_cfs_pe
 			new = old * 2;
 			if (new < max_cfs_quota_period) {
 				cfs_b->period = ns_to_ktime(new);
-				cfs_b->quota = min(cfs_b->quota * 2,
-						   max_cfs_runtime);
-
-				cfs_b->buffer = min(cfs_b->quota + cfs_b->burst,
-						    max_cfs_runtime);
-				/*
-				 * Add 1 in case max_overrun becomes 0.
-				 * 0 max_overrun will cause no runtime being
-				 * refilled in __refill_cfs_bandwidth_runtime().
-				 */
-				cfs_b->max_overrun >>= 1;
-				cfs_b->max_overrun++;
+				cfs_b->quota *= 2;
 
 				pr_warn_ratelimited(
 	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
@@ -5300,7 +5287,6 @@ void init_cfs_bandwidth(struct cfs_bandw
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
 	cfs_b->burst = 0;
-	cfs_b->buffer = RUNTIME_INF;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -366,8 +366,6 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			runtime;
 	u64			burst;
-	u64			buffer;
-	u64			max_overrun;
 	s64			hierarchical_quota;
 
 	u8			idle;
