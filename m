Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88055310AA7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhBELv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhBELtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD1AC061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:48:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g10so7394212wrx.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8sBw6OyNzMHIsovQo6Z8EWSHMKCpttsL3U6XUEB76ig=;
        b=xYrXamM0J1hJ35siIMv9jb5zlYISjWWUrR4kzUzsiijjhZuZyrvIqjASdfNssfvJ+a
         dmaY0nlukdMwT4ED8OGL+eWR0LldphObLz1gH13TVPDtg8uelWV2HdddhV36wmnN2Yr7
         cqJ62bd+p6H44cByUgKF0GNHjeWtg5eM1/wLA2/4tLunXn+0IKUQM38/32SV5Q1ITLAR
         eQiSsGCtx79BcZ4YQaQ1yEhhf6Z5BIH+Gc4kFAuDlXap6ymQFHb2Ku3k5gNbVWVeOFph
         71kefGBVheHel2KsP/M5fje8fn5d1F/mkVgYcOGj21fQj+5VBPwHaVLnl9vYIoyTjYdP
         uHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8sBw6OyNzMHIsovQo6Z8EWSHMKCpttsL3U6XUEB76ig=;
        b=aorOFwWInyY7LEbPyyjb57qWIJdvQnetrneR1QQHZY6FsWrYsXttFPguVeClul77NH
         tmRBQoQkp/q9QkRiFAM3LZ5Mtbi1WSeMDBUbHKtm4HYn5LtZgP/MwFjci/NSU5clUTQU
         32CZXmMyKCuybLfpnuhFwP5qowLp3DTBQOIdzclOoH/PeyPJ01lBUbJOm8eLazwyQeKV
         XzR/er0j1CHtHwjDyAow90VuX5g1S3FZeQlbcftfTc+8On7Mmkx/tSHbIQzSOz/0SLou
         1bqao6Ga6uftFgDqOYeGANVASXo8MFj/Sf5Mr0kgMP3g4QmEOdhHx6zZdQHZ+7zsVLDM
         /aSg==
X-Gm-Message-State: AOAM533hAk3CyDMipYwf7rDnqTJ4UOV9boPWW+f/jlJPrCtXe4f/goM6
        afGVrQhx3USkBqTeS/3U4wpMYQ==
X-Google-Smtp-Source: ABdhPJzh7cK0Xv9l4zvwEUfqDQQ/MF6jZCBMhPaxeCdjmrXohx27CmVkOTcDkBPfvn7BKZ52UioU/g==
X-Received: by 2002:a5d:6510:: with SMTP id x16mr4428750wru.175.1612525717231;
        Fri, 05 Feb 2021 03:48:37 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id z4sm11647586wrw.38.2021.02.05.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:48:36 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/6] sched/fair: remove update of blocked load from newidle_balance
Date:   Fri,  5 Feb 2021 12:48:25 +0100
Message-Id: <20210205114830.781-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205114830.781-1-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

newidle_balance runs with both preempt and irq disabled which prevent
local irq to run during this period. The duration for updating of the
blocked load of CPUs varies according to the number of cgroups and
extends this critical period to an uncontrolled level.

Remove the update from newidle_balance and trigger a normal ILB that
will take care of the update instead.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59b645e3c4fd..bfe1e235fe01 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7392,8 +7392,6 @@ enum migration_type {
 #define LBF_NEED_BREAK	0x02
 #define LBF_DST_PINNED  0x04
 #define LBF_SOME_PINNED	0x08
-#define LBF_NOHZ_STATS	0x10
-#define LBF_NOHZ_AGAIN	0x20
 
 struct lb_env {
 	struct sched_domain	*sd;
@@ -8397,9 +8395,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
 
-		if ((env->flags & LBF_NOHZ_STATS) && update_nohz_stats(rq, false))
-			env->flags |= LBF_NOHZ_AGAIN;
-
 		sgs->group_load += cpu_load(rq);
 		sgs->group_util += cpu_util(i);
 		sgs->group_runnable += cpu_runnable(rq);
@@ -8940,11 +8935,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats tmp_sgs;
 	int sg_status = 0;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
-		env->flags |= LBF_NOHZ_STATS;
-#endif
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -8981,14 +8971,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	/* Tag domain that child domain prefers tasks go to siblings first */
 	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
 
-#ifdef CONFIG_NO_HZ_COMMON
-	if ((env->flags & LBF_NOHZ_AGAIN) &&
-	    cpumask_subset(nohz.idle_cpus_mask, sched_domain_span(env->sd))) {
-
-		WRITE_ONCE(nohz.next_blocked,
-			   jiffies + msecs_to_jiffies(LOAD_AVG_PERIOD));
-	}
-#endif
 
 	if (env->sd->flags & SD_NUMA)
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
@@ -10517,16 +10499,11 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
 
-	raw_spin_unlock(&this_rq->lock);
 	/*
-	 * This CPU is going to be idle and blocked load of idle CPUs
-	 * need to be updated. Run the ilb locally as it is a good
-	 * candidate for ilb instead of waking up another idle CPU.
-	 * Kick an normal ilb if we failed to do the update.
+	 * Blocked load of idle CPUs need to be updated.
+	 * Kick an ILB to update statistics.
 	 */
-	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
-		kick_ilb(NOHZ_STATS_KICK);
-	raw_spin_lock(&this_rq->lock);
+	kick_ilb(NOHZ_STATS_KICK);
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -10587,8 +10564,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
-		nohz_newidle_balance(this_rq);
-
 		goto out;
 	}
 
@@ -10654,6 +10629,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
+	else
+		nohz_newidle_balance(this_rq);
 
 	rq_repin_lock(this_rq, rf);
 
-- 
2.17.1

