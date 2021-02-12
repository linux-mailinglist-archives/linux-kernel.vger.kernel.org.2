Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C383B31A080
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhBLOSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhBLOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:18:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B925C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:53 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l17so1087687wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SK6ZKYQhoxc/9qFXR2hMAG1f6VvVXc8X+Tu1akX9MNM=;
        b=c5ZDkU1w7f9rIpV19hGAIjl2nx2S+Ufp86qDwnPfexK+7XF8XuKrFOY4EPe1QgdjHN
         vomyIrMEksobQylE5+mEnS7AZ5YcxXA7ClE0Kqk73f1rtI1FoYkJrmMtd9xz1GxsgYIm
         Htf888sjH7MMLXyrjpP9M8myv85AUy9vd6xTpB1zL2Vcxnsvwv3g7cy3jom9B17mXhK6
         Me5HXBIMH0m5tOrGsCu07rJbtGXEoTjQWfEVYiGv3pv3YuyXlwBiYNunpq01RvCsdcWg
         ox0juWcz8lfE9LvN+Gau25zd4AOfG6Z7ZJi1sJc1guz4jxL9ww9OHu+GtwvUDribQsur
         H0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SK6ZKYQhoxc/9qFXR2hMAG1f6VvVXc8X+Tu1akX9MNM=;
        b=ly565WSdpSsh06CFMhRNYb4RyHL0uelaHPIGASHjoqTf2M38OIsB/0JZ3v3ZTa2j96
         IUYEZy/DEIK9bhacowGqWSOODgEkPsgvdgDEBsoYrSjOcCyE0FgW/ee7C7JLc4ytBMvZ
         gbaiYqW5OjVh/wuZVcnsCbnAGxAFj0RRq67twXVj8nziOgoVF4CbWXON/oeF+0mnDn+j
         PPNvdQx1AriV+BeCmsSZdWXXkc4YnOTyhJg3pSn83+OSeMev8Zz6k643tB7I8f4xUt6m
         q/15Z2ypo91b525/aBzGRGS49AQsHUvVKnOgIF8tMsOqKWPIEkVMqzLbjLZs6GfDojGM
         YEhg==
X-Gm-Message-State: AOAM532B+mnDyZ7+mfAsjE6kVgvVSt4dA7YhbC1oMZj7BIgXb06ytY1K
        HZ1RqPEedxbRRD5GtjLZckeBMg==
X-Google-Smtp-Source: ABdhPJx4/6y1QLr0DnfOaD+ISKijD4eZhr0hlpi+eDZXtC1GOSuTOALT3G0hFadpsr3FjOY1vUPPqw==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr2873334wme.20.1613139470504;
        Fri, 12 Feb 2021 06:17:50 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id f14sm14254156wmj.30.2021.02.12.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:17:49 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/7 v3] sched/fair: remove update of blocked load from newidle_balance
Date:   Fri, 12 Feb 2021 15:17:38 +0100
Message-Id: <20210212141744.24284-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212141744.24284-1-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

newidle_balance runs with both preempt and irq disabled which prevent
local irq to run during this period. The duration for updating the
blocked load of CPUs varies according to the number of CPU cgroups
with non-decayed load and extends this critical period to an uncontrolled
level.

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

