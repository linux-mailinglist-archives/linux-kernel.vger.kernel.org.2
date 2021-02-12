Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62631A088
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhBLOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhBLOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:19:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DDC06178B
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:18:01 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 190so1091785wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iYyALTL+gpEMdsmg88qwfZDPjg83upcS6cTAeXaGChs=;
        b=yIiL8jVw0HbTk0v5elgUuMARrxS/SK09OrSZ0LZ+7/wQTTvKgmgR21vj+TBoSKfF1P
         xer1yCsG2Uh+NS0xP24gCEJjY//3SHyhlarGWm7zFsWUnKVxVzLVNu34CiIahMf/rA7B
         ktw0Sq8JBp5IGQg/gDf6czUbp1jy2Z33SzCUt8HHMf4e+Ha38FS5DLWli+QsA1XwV4VK
         f4hzpZX3gJRoIheYrPwRHI0FvhCvWGIp4c2xcbmh+zzAwbWFQDalHRk0Ip83QTxaTzn1
         LI3TEK0MUYqhtL0vuh63pzQIDBvqPsGksPDb4TbrPj4k9wR2VfrVvGsls9+0g66+WLd3
         bcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iYyALTL+gpEMdsmg88qwfZDPjg83upcS6cTAeXaGChs=;
        b=igzlmJ7WY44ULy2TmwZUqcfJFFMVD0Fmpujt9IlCM/daPbp6dGivJxGaqLlTV9IMh3
         N/MJiVci23V1GpFFS3HP7ffjjfxGqQiKwXBZ2HojZlca75tgcUHQQnTGXVx7rnWjgN0R
         rVCaorIufjBncx85FgV+AO2KpL02LUMuWTDclaPxP/rSgiDGa5DmYwi4xUYTN3/EAChC
         8I1ELRV6qvoJR+1twP+TPW7oxUXMtJWd7iH7ZqJuwk3WLnKeksFid9mVjwCLpTLvSDW3
         COWd+NicgGSMQCaUgoZL4baoyegIR0hOanmXieFtKTaMtFteQWqbrybZPX10emRcR5O3
         D8vA==
X-Gm-Message-State: AOAM5313FK+VF+ohwPPxafSUmPk7ModyJ8U9Q7b2FrB/TCe0MqXLlQkx
        44BvDnALwHP6etlHvRQBYZJnnw==
X-Google-Smtp-Source: ABdhPJyypM/EHu/COFAwSuzE5H4x+RjZIA0a/9fpVONcPiC3ZprroV5xHrmp4F52px4X4OdsjlL5FA==
X-Received: by 2002:a1c:67c4:: with SMTP id b187mr2911595wmc.17.1613139478896;
        Fri, 12 Feb 2021 06:17:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id f14sm14254156wmj.30.2021.02.12.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:17:58 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/7 v3] sched/fair: trigger the update of blocked load on newly idle cpu
Date:   Fri, 12 Feb 2021 15:17:43 +0100
Message-Id: <20210212141744.24284-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212141744.24284-1-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of waking up a random and already idle CPU, we can take advantage
of this_cpu being about to enter idle to run the ILB and update the
blocked load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 24 +++++++++++++++++++++---
 kernel/sched/idle.c  |  6 ++++++
 kernel/sched/sched.h |  5 +++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5d285d93e433..cd0ea635225e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10453,6 +10453,24 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	return true;
 }
 
+/*
+ * Check if we need to run the ILB for updating blocked load before entering
+ * idle state.
+ */
+void nohz_run_idle_balance(int cpu)
+{
+	unsigned int flags;
+
+	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
+
+	if (flags && !need_resched()) {
+		struct rq *rq = cpu_rq(cpu);
+
+		rq->nohz_idle_balance = flags;
+		nohz_idle_balance(rq, CPU_IDLE);
+	}
+}
+
 static void nohz_newidle_balance(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu;
@@ -10474,10 +10492,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
 		return;
 
 	/*
-	 * Blocked load of idle CPUs need to be updated.
-	 * Kick an ILB to update statistics.
+	 * Set the need to trigger ILB in order to update blocked load
+	 * before entering idle state.
 	 */
-	kick_ilb(NOHZ_STATS_KICK);
+	atomic_or(NOHZ_STATS_KICK, nohz_flags(this_cpu));
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 305727ea0677..52a4e9ce2f9b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -261,6 +261,12 @@ static void cpuidle_idle_call(void)
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+
+	/*
+	 * Check if we need to update some blocked load
+	 */
+	nohz_run_idle_balance(cpu);
+
 	/*
 	 * If the arch has a polling bit, we maintain an invariant:
 	 *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6edc67df3554..17de50acb88d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2374,6 +2374,11 @@ extern void nohz_balance_exit_idle(struct rq *rq);
 static inline void nohz_balance_exit_idle(struct rq *rq) { }
 #endif
 
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern void nohz_run_idle_balance(int cpu);
+#else
+static inline void nohz_run_idle_balance(int cpu) { }
+#endif
 
 #ifdef CONFIG_SMP
 static inline
-- 
2.17.1

