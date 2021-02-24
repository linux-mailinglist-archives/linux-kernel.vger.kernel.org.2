Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF85324043
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhBXOqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbhBXNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA721C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:26 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id x16so1790944wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=023+xT2HavaWJVi6DJoAm8KfQzgaUPCo/MhbKmWWKc8=;
        b=CAjPCVWW+URgzdNTlLXJU9UB39WW8SGRg+Nw3l2LH6mpcDazXcxoaH9dXlwWH2vaJu
         1l85DXdeBB2oPttsN8YBIbksF9dRwiNAHn6JAdmiN5zmfczzt74DWuVf5EVC7XDuU3bJ
         cPUHqR8PqueSwDFKmUXhZS+5eGgszuan5l9EqRFyWCpuM0n9mqAyQuOyOtziPCfBtcNw
         M4/YXO8UVHIYSDwXrBFY2l4sWbLNDCBPEWdzMoUsf7vxipvXmqL5O7UemDtpRCFEOom9
         GTQvXGiBmAtXVfGFtRgLdTjs1f+CLTpmnyUxEsFb9m5E+SMQ9gwmpgPQHp5SrhSoY9sH
         iXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=023+xT2HavaWJVi6DJoAm8KfQzgaUPCo/MhbKmWWKc8=;
        b=QFvkbLxy/G0pw5kcIUz7DVYaolDd30GiR/Ja8eKn5cNW7g/3CJXYZ7oyo6AFMVFl+q
         Cm0PLfnpSlt6+ho51Zp0m5aYtjWTcznOPq4ff/1Oy215dkc9ytc6ica2+GaLq/qVx2W0
         oe1aaSMy8Lz5n2lkL1ewn+m1HIiBkfLSVKTpuV+B7pbIPLOS4Zdp7J8xhfRawPRCvwVI
         P2e0f/5hOEnWrMqtJhfSeem6H/+x9bu2SUd6dpChqCazBStamV1kB31BM56RjRWUxDG2
         i6eQHUA3Ra2dqWpoy9LsxfbO0HYP+rReIIY0Ozurop9YykvUZvan3eA4QqynKJN/JEPj
         etAw==
X-Gm-Message-State: AOAM531iCvI22Y2u0PxhYUloZ5ZyztThQsVYN19TlnfoIiotUuMJKcxQ
        OGJfcXthT1o1E0xqNwPDie3X2Q==
X-Google-Smtp-Source: ABdhPJx7KWDbiCfsQ2UoGhdFpWRyDtTkJqm5qCBwec1OO8uvaYqTnAD7CeFUrOOaQypo0gGgijx4+Q==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr3688182wmc.43.1614173425480;
        Wed, 24 Feb 2021 05:30:25 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:24 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/7 v4] sched/fair: remove update of blocked load from newidle_balance
Date:   Wed, 24 Feb 2021 14:30:01 +0100
Message-Id: <20210224133007.28644-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
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
index 8a8bd7b13634..0d45b7716384 100644
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

