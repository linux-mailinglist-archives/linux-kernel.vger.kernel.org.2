Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA0319FED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhBLNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhBLNcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:32:13 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE127C06121E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id u16so949494wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuvjDRxLLmwWWCuP7dXT6YMvw5PAEgG+5y2jF3EuRh4=;
        b=g19ozPYMBx+RxW+IARoINzkoov/cis+CtMFNNU9DdWtsOx0sO+36yIONPdXw/nT564
         h7+ipHrRDP7skdSOi0p1Ls//XgqtIrAXeFfOuyK16SHxJAXFIFyAN+Fwv/VoLX5EA6/+
         OH2tvRWir2CFh9LS3/Yikre8W3g2PZhMxaxWBP8OKLVXykb/GGHv5mRp+O6d+BKrzCMu
         /xxBhN0FTVwxQp9DaLsP7SQtagq74twEoj8UA8VMGTiQOMzYYdIR54xXL+0+WSPQP1kZ
         eW7vlikA4q2T99D1gM9b3Ndnz1DZZlrRxzBu9tlWwiNF0jNOO4PG+vMRA+a9yGqR+FsN
         2HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuvjDRxLLmwWWCuP7dXT6YMvw5PAEgG+5y2jF3EuRh4=;
        b=dlKNYwofhITdnVlzEPh8QG+IzyGEml2/QCzItbq2cB5RKQlKY61YUgNQdurorW5oU4
         GtsM5HPtnM7Zp5xV96OZfW681J8JSnvWHAKXfX4mawv3yFB6/mwyRfatxSquIxPqSx5W
         qI5YsTn2FokSpmcWGOFTks2GGLhfnmOLMqPk1YPl0B11B853AQ1Srzxs27deDYbLIhdn
         UzdpDHJEEtsO5XG9Bxuv7A4OkyZ43lQPKGUZh3pOLexECjt9Y8U6xKFdWVPLRN0zfXKL
         3Ny7/4aDrobUohV7kHBtiqr5mDRQPbepfn/RBnPynY175fc7iDzJYX70/bKikBMKT3rO
         rJ+Q==
X-Gm-Message-State: AOAM533SdR+gdnK1um3rwT0AOHeWHioIb2NuYdnyDM5BxDPS1iv7PBXX
        NIPDy0ja2J/ktzMbrYEjyXwA8A==
X-Google-Smtp-Source: ABdhPJxEnJKJdzIJhShf9cuwgRqcGFUWTSQcWX1I/aTSgdmVZT7Z0k7GkTGuXjT6UOsoP2moyPCM9A==
X-Received: by 2002:a1c:8096:: with SMTP id b144mr2780537wmd.169.1613136606419;
        Fri, 12 Feb 2021 05:30:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id h13sm10470773wrv.20.2021.02.12.05.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:05 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/7 v2] sched/fair: trigger the update of blocked load on newly idle cpu
Date:   Fri, 12 Feb 2021 14:28:48 +0100
Message-Id: <20210212132849.32515-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212132849.32515-1-vincent.guittot@linaro.org>
References: <20210212132849.32515-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of waking up a random and already idle CPU, we can take advantage
of this_cpu being about to enter idle to run the ILB and update the
blocked load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 20 +++++++++++++++++---
 kernel/sched/idle.c  |  6 ++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5d285d93e433..d11a632ea276 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10453,6 +10453,20 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	return true;
 }
 
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
@@ -10474,10 +10488,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
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
index 6edc67df3554..a11ec9110992 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2370,8 +2370,11 @@ extern void cfs_bandwidth_usage_dec(void);
 #define nohz_flags(cpu)	(&cpu_rq(cpu)->nohz_flags)
 
 extern void nohz_balance_exit_idle(struct rq *rq);
+extern void nohz_run_idle_balance(int cpu);
 #else
+
 static inline void nohz_balance_exit_idle(struct rq *rq) { }
+static inline void nohz_run_idle_balance(int cpu) { }
 #endif
 
 
-- 
2.17.1

