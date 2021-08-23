Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5D3F4982
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbhHWLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:17:51 -0400
Received: from foss.arm.com ([217.140.110.172]:51990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234953AbhHWLRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:17:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC18F13A1;
        Mon, 23 Aug 2021 04:17:06 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D6D763F66F;
        Mon, 23 Aug 2021 04:17:05 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 1/2] sched/fair: Add NOHZ balancer flag for nohz.next_balance updates
Date:   Mon, 23 Aug 2021 12:16:59 +0100
Message-Id: <20210823111700.2842997-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823111700.2842997-1-valentin.schneider@arm.com>
References: <20210823111700.2842997-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A following patch will trigger NOHZ idle balances as a means to update
nohz.next_balance. Vincent noted that blocked load updates can have
non-negligible overhead, which should be avoided if the intent is to only
update nohz.next_balance.

Add a new NOHZ balance kick flag, NOHZ_NEXT_KICK. Gate NOHZ blocked load
update by the presence of NOHZ_STATS_KICK - currently all NOHZ balance
kicks will have the NOHZ_STATS_KICK flag set, so no change in behaviour is
expected.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c  | 24 ++++++++++++++----------
 kernel/sched/sched.h |  8 +++++++-
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6cd05f1d77ef..4a91f3027c92 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10342,7 +10342,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		goto out;
 
 	if (rq->nr_running >= 2) {
-		flags = NOHZ_KICK_MASK;
+		flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 		goto out;
 	}
 
@@ -10356,7 +10356,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * on.
 		 */
 		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
-			flags = NOHZ_KICK_MASK;
+			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 	}
@@ -10370,7 +10370,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
-				flags = NOHZ_KICK_MASK;
+				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
 		}
@@ -10383,7 +10383,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * to run the misfit task on.
 		 */
 		if (check_misfit_status(rq, sd)) {
-			flags = NOHZ_KICK_MASK;
+			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 
@@ -10410,7 +10410,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 */
 		nr_busy = atomic_read(&sds->nr_busy_cpus);
 		if (nr_busy > 1) {
-			flags = NOHZ_KICK_MASK;
+			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 	}
@@ -10572,7 +10572,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
 	 */
-	WRITE_ONCE(nohz.has_blocked, 0);
+	if (flags & NOHZ_STATS_KICK)
+		WRITE_ONCE(nohz.has_blocked, 0);
 
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
@@ -10594,13 +10595,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		 * balancing owner will pick it up.
 		 */
 		if (need_resched()) {
-			has_blocked_load = true;
+			if (flags & NOHZ_STATS_KICK)
+				has_blocked_load = true;
 			goto abort;
 		}
 
 		rq = cpu_rq(balance_cpu);
 
-		has_blocked_load |= update_nohz_stats(rq);
+		if (flags & NOHZ_STATS_KICK)
+			has_blocked_load |= update_nohz_stats(rq);
 
 		/*
 		 * If time for next balance is due,
@@ -10631,8 +10634,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (likely(update_next_balance))
 		nohz.next_balance = next_balance;
 
-	WRITE_ONCE(nohz.next_blocked,
-		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
+	if (flags & NOHZ_STATS_KICK)
+		WRITE_ONCE(nohz.next_blocked,
+			   now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
 abort:
 	/* There is still blocked load, enable periodic update */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e7e2bba5b520..30b7bd2ef25d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2706,12 +2706,18 @@ extern void cfs_bandwidth_usage_dec(void);
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
 #define NOHZ_NEWILB_KICK_BIT	2
+#define NOHZ_NEXT_KICK_BIT	3
 
+/* Run rebalance_domains() */
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
+/* Update blocked load */
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)
+/* Update blocked load when entering idle */
 #define NOHZ_NEWILB_KICK	BIT(NOHZ_NEWILB_KICK_BIT)
+/* Update nohz.next_balance */
+#define NOHZ_NEXT_KICK		BIT(NOHZ_NEXT_KICK_BIT)
 
-#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
+#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
 
 #define nohz_flags(cpu)	(&cpu_rq(cpu)->nohz_flags)
 
-- 
2.25.1

