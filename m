Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537523B737C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhF2Nw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:52:59 -0400
Received: from foss.arm.com ([217.140.110.172]:51666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233050AbhF2Nwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:52:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 435CF106F;
        Tue, 29 Jun 2021 06:50:28 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9432C3F718;
        Tue, 29 Jun 2021 06:50:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        zhang.lyra@gmail.com
Subject: Re: [PATCH] sched/uclamp: Fix getting unreasonable ucalmp_max when rq is idle
In-Reply-To: <20210618072349.503-1-xuewen.yan94@gmail.com>
References: <20210618072349.503-1-xuewen.yan94@gmail.com>
Date:   Tue, 29 Jun 2021 14:50:21 +0100
Message-ID: <87fsx093vm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+Cc Patrick's current address

On 18/06/21 15:23, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
> uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
> uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
> uclamp_max = max{uc_rq_max, uc_eff_max};
>
> Consider the following scenario:
> (1)the rq is idle, the uc_rq_max is last task's UCLAMP_MAX;
> (2)the p's uc_eff_max < uc_rq_max.
>
> The result is the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.
>
> The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.
>
> Inserts whether the rq is idle in the uclamp_rq_util_with().
>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/sched.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a189bec13729..0feef6af89f2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2550,7 +2550,10 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>
>       if (p) {
>               min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
> -		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
> +		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
> +			max_util = uclamp_eff_value(p, UCLAMP_MAX);
> +		else
> +			max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));

That makes sense to me - enqueuing the task will lift UCLAMP_FLAG_IDLE and
set the rq clamp as the task's via uclamp_idle_reset().

Does this want a

  Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")

?

Also, when we have UCLAMP_FLAG_IDLE, we don't even need to read the rq max
- and I'm pretty sure the same applies to the rq min. What about something like:

---
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6510f0a46789..a2c6f6ae6392 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2833,23 +2833,27 @@ static __always_inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 				  struct task_struct *p)
 {
-	unsigned long min_util;
-	unsigned long max_util;
+	unsigned long min_util = 0;
+	unsigned long max_util = 0;
 
 	if (!static_branch_likely(&sched_uclamp_used))
 		return util;
 
-	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
-	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
-
 	if (p) {
-		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
+		min_util = uclamp_eff_value(p, UCLAMP_MIN);
+		max_util = uclamp_eff_value(p, UCLAMP_MAX);
+
+		/*
+		 * Ignore last runnable task's max clamp, as this task will
+		 * reset it. Similarly, no need to read the rq's min clamp.
+		 */
 		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
-			max_util = uclamp_eff_value(p, UCLAMP_MAX);
-		else
-			max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+			goto out;
 	}
 
+	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
+	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
+out:
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
 	 * RUNNABLE tasks with _different_ clamps, we can end up with an
