Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23913324048
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhBXOsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbhBXNdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:33:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A3C06121C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:35 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j187so1804255wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x3DZPVMqMe5IsoUl4Vd0CNaarS2R8YmSAL4wfZrBejE=;
        b=I8w9y8g649aKff41Ubj9aOy6CiH50Qnby94mku9ntJAlTGDtRZFo+1kufsSKQykzBW
         VwHlbY457YO49hwv3JjYwYJR3wBZQ9n5jUaacy27sNsLGWK0LlMJdmkfWLKJOYSYRfJF
         c4mxXyuroV3XfaxY8Yu/xXnghsTmvG5+kU+Qvb6ZlMI1igKr4UH6Rn3A4JEV+YiP0fgf
         sONQH9CDlO3eRcqua2n6XXNmsuK31Hibarj9mjxMDR9e798VAtnU4AWeTukO3mksYQSH
         0jbYg9feboSd8DXPANqFazkUU4A0rrE9nvROvw1Wuu1Cu3dehL6TDCcoPeM0WE/TtHX+
         YF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x3DZPVMqMe5IsoUl4Vd0CNaarS2R8YmSAL4wfZrBejE=;
        b=eHrY2qFLpCW2n4l1exy+kQKRhdM4FphmtZDBuuDhbLIkSCm250fZdWanKKn567Ejcc
         O0E8X47JySoGTBytqU5ppPYw657LNlMcLlKiTJK6m08UNcsuJfoTv8+xWv2fGpCNvDr1
         ci/PHRcxqE8/ZEukF3tO1x4DAEOsn5LBbgJ+OR2AILM4Mhe7oXGIib/iGHn5O8VY83NK
         IAePPFuitfhI65Syt/aCChNr7ABNqRM6b1/QTvdu/dDa36h8EDXF0q+cBAqgIMLhKIO3
         Tnrf+VrumPqe3Uhn9i7kdeicIMaX/K6bqMJ0KKUVZsfHtyIuu/cf15Ky4rCh+1DxuTKP
         FeEA==
X-Gm-Message-State: AOAM531vnGzEZCB4Wa0EEMvYENRDnhjCRMAvXNYOrWRyCFJmW4PGT9vV
        RrwVBARH2ciLD6U6z8yX0mVFs8u5JXgoFw==
X-Google-Smtp-Source: ABdhPJzpg7YR07bwyVjj5iyNZmTvIwH/VEb413D8p03vrpjlLQVUZ/r9rX466yQJ8NB+toCpr2upug==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr3833587wmj.46.1614173434333;
        Wed, 24 Feb 2021 05:30:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:33 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/7 v4] sched/fair: trigger the update of blocked load on newly idle cpu
Date:   Wed, 24 Feb 2021 14:30:06 +0100
Message-Id: <20210224133007.28644-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of waking up a random and already idle CPU, we can take advantage
of this_cpu being about to enter idle to run the ILB and update the
blocked load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 24 +++++++++++++++++++++---
 kernel/sched/idle.c  |  6 ++++++
 kernel/sched/sched.h |  7 +++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88a2e2bdbabe..61ec83e52a08 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -737,7 +737,7 @@ static void nohz_csd_func(void *info)
 	/*
 	 * Release the rq::nohz_csd.
 	 */
-	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
+	flags = atomic_fetch_andnot(NOHZ_KICK_MASK | NOHZ_NEWILB_KICK, nohz_flags(cpu));
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
 	rq->idle_balance = idle_cpu(cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 586f6ce0d302..46c220a4f7ed 100644
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
+	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
+
+	/*
+	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
+	 * (ie NOHZ_STATS_KICK set) and will do the same.
+	 */
+	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
+		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
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
+	atomic_or(NOHZ_NEWILB_KICK, nohz_flags(this_cpu));
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7199e6f23789..7a92d6054aba 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -261,6 +261,12 @@ static void cpuidle_idle_call(void)
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+
+	/*
+	 * Check if we need to update blocked load
+	 */
+	nohz_run_idle_balance(cpu);
+
 	/*
 	 * If the arch has a polling bit, we maintain an invariant:
 	 *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..0ddc9a6ff03a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2385,9 +2385,11 @@ extern void cfs_bandwidth_usage_dec(void);
 #ifdef CONFIG_NO_HZ_COMMON
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
+#define NOHZ_NEWILB_KICK_BIT	2
 
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)
+#define NOHZ_NEWILB_KICK	BIT(NOHZ_NEWILB_KICK_BIT)
 
 #define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
 
@@ -2398,6 +2400,11 @@ extern void nohz_balance_exit_idle(struct rq *rq);
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

