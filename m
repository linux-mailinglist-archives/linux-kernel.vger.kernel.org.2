Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C74380775
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 12:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhENKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 06:39:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhENKjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 06:39:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21F251713;
        Fri, 14 May 2021 03:38:09 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E10C3F719;
        Fri, 14 May 2021 03:38:07 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
Date:   Fri, 14 May 2021 12:37:48 +0200
Message-Id: <20210514103748.737809-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The util_est internal UTIL_AVG_UNCHANGED flag which is used to prevent
unnecessary util_est updates uses the LSB of util_est.enqueued. It is
exposed via _task_util_est() (and task_util_est()).

Commit 92a801e5d5b7 ("sched/fair: Mask UTIL_AVG_UNCHANGED usages")
mentions that the LSB is lost for util_est resolution but
find_energy_efficient_cpu() checks if task_util_est() returns 0 to
return prev_cpu early.

_task_util_est() returns the max value of util_est.ewma and
util_est.enqueued or'ed w/ UTIL_AVG_UNCHANGED.
So task_util_est() returning the max of task_util() and
_task_util_est() will never return 0 under the default
SCHED_FEAT(UTIL_EST, true).

To fix this use the MSB of util_est.enqueued instead and keep the flag
util_est internal, i.e. don't export it via _task_util_est().

The maximal possible util_avg value for a task is 1024 so the MSB of
'unsigned int util_est.enqueued' isn't used to store a util value.

As a caveat the code behind the util_est_se trace point has to filter
UTIL_AVG_UNCHANGED to see the real util_est.enqueued value which should
be easy to do.

This also fixes an issue report by Xuewen Yan that util_est_update()
only used UTIL_AVG_UNCHANGED for the subtrahend of the equation:

  last_enqueued_diff = ue.enqueued - (task_util() | UTIL_AVG_UNCHANGED)

Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c |  5 +++--
 kernel/sched/pelt.h | 13 +++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..0150d440b0a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3856,7 +3856,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	struct util_est ue = READ_ONCE(p->se.avg.util_est);
 
-	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
+	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
 }
 
 static inline unsigned long task_util_est(struct task_struct *p)
@@ -3956,7 +3956,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
 	 */
-	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
+	ue.enqueued = task_util(p);
 	if (sched_feat(UTIL_EST_FASTUP)) {
 		if (ue.ewma < ue.enqueued) {
 			ue.ewma = ue.enqueued;
@@ -4005,6 +4005,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	ue.ewma  += last_ewma_diff;
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
+	ue.enqueued |= UTIL_AVG_UNCHANGED;
 	WRITE_ONCE(p->se.avg.util_est, ue);
 
 	trace_sched_util_est_se_tp(&p->se);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 9ed6d8c414ad..178290a8d150 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -43,13 +43,14 @@ static inline u32 get_pelt_divider(struct sched_avg *avg)
 }
 
 /*
- * When a task is dequeued, its estimated utilization should not be update if
- * its util_avg has not been updated at least once.
+ * When a task is dequeued, its estimated utilization should not be updated if
+ * its util_avg has not been updated in the meantime.
  * This flag is used to synchronize util_avg updates with util_est updates.
- * We map this information into the LSB bit of the utilization saved at
- * dequeue time (i.e. util_est.dequeued).
+ * We map this information into the MSB bit of util_est.enqueued at dequeue
+ * time. Since max value of util_est.enqueued for a task is 1024 (PELT
+ * util_avg for a task) it is safe to use MSB here.
  */
-#define UTIL_AVG_UNCHANGED 0x1
+#define UTIL_AVG_UNCHANGED 0x80000000
 
 static inline void cfs_se_util_change(struct sched_avg *avg)
 {
@@ -58,7 +59,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/* Avoid store if the flag has been already set */
+	/* Avoid store if the flag has been already reset */
 	enqueued = avg->util_est.enqueued;
 	if (!(enqueued & UTIL_AVG_UNCHANGED))
 		return;
-- 
2.25.1

