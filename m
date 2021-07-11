Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC03C3C3CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhGKNfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 09:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhGKNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 09:35:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C79C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:32:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id go30so708221ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 06:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+aAsbsrr0Mf/fn7P6F3yzksEKv/NFu6Yq0FFcE8ThQk=;
        b=HUxKUlTRJqdpkqhHJOg1qpNGpj6eg/5zSScscEJQcN77M1FBcGlpq3EtSqfey75z9v
         tdtPwhRqe7zPu4Zdi2URsXEzyk10hdIHId1IxJLQH79HltaS58IFSIXwCT3WApy0XSsN
         7cqDldw70oSGaKXqq67sp4xn7SP6uLplzxrXyGDb7AGLie+nu8egm/OUpwpvmHL1x9gh
         rWng5Z6arZ4H6Hv6zoXLVOFkH3NOElz1oSRNQp1QYjVozXr9unqbqKcg1RRcL4VtId/X
         voRkNyOfn0yftYw4Zd0l+N7kytvf24AtSCAzc0+zyvIp0ftggJZiL6wtjvoqjbpROPpw
         bpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=+aAsbsrr0Mf/fn7P6F3yzksEKv/NFu6Yq0FFcE8ThQk=;
        b=N0RnNz8iqOrpcXxXfYP9ERJrygsjveE5Ffi0g68+rmfGnlUBxCqs9ta5vZOyhsacDk
         1oiGGN8L+fvD4BTSlHWIujkOdx+2H7X3Wtde6zw08riUfZhYtepXwDTHy5rtr0S5pkJR
         ZqydF+ZP1GRZVDuvcfkMVS7oPU+3vEKdY36YkhAZ4BQLt6rgV5hK/98rfcLivkdt5cvU
         rKxMv5O4Jetzby2jGtZ51qW26ylHvLRerf8ozQIFq0A+yhxSv1m83gvx9hYzrGHanGDz
         0+LvH+RBBByCOC5up+e7snQfdAjR2Lrq14wNBGLpWk70BorGXVWpHfRxyM2Y/X0FJKc7
         5tfw==
X-Gm-Message-State: AOAM533wX0dVlagmeEbkyyYF4GD3YI40ClewQEocReVxTPo83h6DmMBR
        c9EIr0mQCXngrHu951gJe8wohVpGkYQ=
X-Google-Smtp-Source: ABdhPJzNoxe8NNz/S1PzxdIGajf3XRaDc0n73z3d1dQ70GwmE28hkkp1c61PkPpOoHzjnRftekuhCw==
X-Received: by 2002:a17:906:a0a:: with SMTP id w10mr48256378ejf.416.1626010376727;
        Sun, 11 Jul 2021 06:32:56 -0700 (PDT)
Received: from gmail.com (77-234-64-154.pool.digikabel.hu. [77.234.64.154])
        by smtp.gmail.com with ESMTPSA id p23sm6192415edt.71.2021.07.11.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 06:32:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 11 Jul 2021 15:32:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] scheduler fixes
Message-ID: <YOrzBvSv4xoU3OAX@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-07-11

   # HEAD: 3e1493f46390618ea78607cb30c58fc19e2a5035 sched/uclamp: Ignore max aggregation if rq is idle

Three fixes:

 - Fix load tracking bug/inconsistency
 - Fix a sporadic CFS bandwidth constraints enforcement bug
 - Fix a uclamp utilization tracking bug for newly woken tasks

 Thanks,

	Ingo

------------------>
Odin Ugedal (1):
      sched/fair: Fix CFS bandwidth hrtimer expiry type

Vincent Guittot (1):
      sched/fair: Sync load_sum with load_avg after dequeue

Xuewen Yan (1):
      sched/uclamp: Ignore max aggregation if rq is idle


 kernel/sched/fair.c  |  7 ++++---
 kernel/sched/sched.h | 21 ++++++++++++++-------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 45edf61eed73..1b15a19910a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3037,8 +3037,9 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	u32 divider = get_pelt_divider(&se->avg);
 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
+	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
 }
 #else
 static inline void
@@ -5053,7 +5054,7 @@ static const u64 cfs_bandwidth_slack_period = 5 * NSEC_PER_MSEC;
 static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
 {
 	struct hrtimer *refresh_timer = &cfs_b->period_timer;
-	u64 remaining;
+	s64 remaining;
 
 	/* if the call-back is running a quota refresh is already occurring */
 	if (hrtimer_callback_running(refresh_timer))
@@ -5061,7 +5062,7 @@ static int runtime_refresh_within(struct cfs_bandwidth *cfs_b, u64 min_expire)
 
 	/* is a quota refresh about to occur? */
 	remaining = ktime_to_ns(hrtimer_expires_remaining(refresh_timer));
-	if (remaining < min_expire)
+	if (remaining < (s64)min_expire)
 		return 1;
 
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c80d42e9589b..14a41a243f7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2818,20 +2818,27 @@ static __always_inline
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
-		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+		min_util = uclamp_eff_value(p, UCLAMP_MIN);
+		max_util = uclamp_eff_value(p, UCLAMP_MAX);
+
+		/*
+		 * Ignore last runnable task's max clamp, as this task will
+		 * reset it. Similarly, no need to read the rq's min clamp.
+		 */
+		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+			goto out;
 	}
 
+	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
+	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
+out:
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
 	 * RUNNABLE tasks with _different_ clamps, we can end up with an
