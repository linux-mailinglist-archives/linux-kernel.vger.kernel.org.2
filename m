Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA831CE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBPQk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:40:27 -0500
Received: from foss.arm.com ([217.140.110.172]:38804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhBPQkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:40:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36CD101E;
        Tue, 16 Feb 2021 08:39:32 -0800 (PST)
Received: from e124901.arm.com (unknown [10.57.9.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D72E3F73D;
        Tue, 16 Feb 2021 08:39:31 -0800 (PST)
From:   vincent.donnefort@arm.com
To:     peterz@infradead.org, tglx@linutronix.de,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched/pelt: Fix task util_est update filtering
Date:   Tue, 16 Feb 2021 16:39:21 +0000
Message-Id: <20210216163921.572228-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

Being called for each dequeue, util_est reduces the number of its updates
by filtering out when the EWMA signal is different from the task util_avg
by less than 1%. It is a problem for a sudden util_avg ramp-up. Due to the
decay from a previous high util_avg, EWMA might now be close enough to
the new util_avg. No update would then happen while it would leave
ue.enqueued with an out-of-date value.

Taking into consideration the two util_est members, EWMA and enqueued for
the filtering, ensures, for both, an up-to-date value.

This is for now an issue only for the trace probe that might return the
stale value. Functional-wise, it isn't (yet) a problem, as the value is
always accessed through max(enqueued, ewma).

This problem has been observed using LISA's UtilConvergence:test_means on
the sd845c board.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..9008e0c42def 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3941,24 +3941,27 @@ static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
+#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
+
 /*
- * Check if a (signed) value is within a specified (unsigned) margin,
+ * Check if a (signed) value is within the (unsigned) util_est margin,
  * based on the observation that:
  *
  *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
  *
- * NOTE: this only works when value + maring < INT_MAX.
+ * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
  */
-static inline bool within_margin(int value, int margin)
+static inline bool util_est_within_margin(int value)
 {
-	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
+	return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
+		(2 * UTIL_EST_MARGIN - 1));
 }
 
 static inline void util_est_update(struct cfs_rq *cfs_rq,
 				   struct task_struct *p,
 				   bool task_sleep)
 {
-	long last_ewma_diff;
+	long last_ewma_diff, last_enqueued_diff;
 	struct util_est ue;
 
 	if (!sched_feat(UTIL_EST))
@@ -3979,6 +3982,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (ue.enqueued & UTIL_AVG_UNCHANGED)
 		return;
 
+	last_enqueued_diff = ue.enqueued;
+
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
@@ -3992,12 +3997,19 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	}
 
 	/*
-	 * Skip update of task's estimated utilization when its EWMA is
+	 * Skip update of task's estimated utilization when its members are
 	 * already ~1% close to its last activation value.
 	 */
 	last_ewma_diff = ue.enqueued - ue.ewma;
-	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
+	last_enqueued_diff -= ue.enqueued;
+	if (util_est_within_margin(last_ewma_diff)) {
+		if (!util_est_within_margin(last_enqueued_diff)) {
+			ue.ewma = ue.enqueued;
+			goto done;
+		}
+
 		return;
+	}
 
 	/*
 	 * To avoid overestimation of actual task utilization, skip updates if
-- 
2.25.1

