Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699EA3EDA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236836AbhHPPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 11:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbhHPPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:44:47 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED4C0617AD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 08:44:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629128652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wZOfG71ek7P3J0Y5q4vioyYHaOIo86xNbpEBIPvcq4M=;
        b=xmZ7spvQkIBAPpxyuyDC5DZMBIuaeCq2Tw3PNXn/3KK9seoMM0gyZQyw72qcA+nEKJ3tD3
        afFKwrMbf+XgYed5ITYemyfI+8m9vl1biNjrpH073wFC4hQr1t3s5nB44gngAI+gonyGqd
        NhaHW+uo+lk0kZbPWCMGBkepiSDzGOM=
From:   Tao Zhou <tao.zhou@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, tglx@linutronix.de, joel@joelfernandes.org,
        chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de, tao.zhou@linux.dev
Subject: [PATCH] sched/core: An optimization of pick_next_task() not sure
Date:   Mon, 16 Aug 2021 23:44:01 +0800
Message-Id: <20210816154401.23919-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When find a new candidate max, wipe the stale and start over.
Goto again: and use the new max to loop to pick the the task.

Here first want to get the max of the core and use this new
max to loop once to pick the task on each thread.

Not sure this is an optimization and just stop here a little
and move on..

Compiled.
---
 kernel/sched/core.c | 52 +++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc044134..bddcd328df96 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5403,7 +5403,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	const struct sched_class *class;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
-	int i, j, cpu, occ = 0;
+	int i, cpu, occ = 0;
 	bool need_sync;
 
 	if (!sched_core_enabled(rq))
@@ -5508,11 +5508,27 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * order.
 	 */
 	for_each_class(class) {
-again:
+		struct rq *rq_i;
+		struct task_struct *p;
+
 		for_each_cpu_wrap(i, smt_mask, cpu) {
-			struct rq *rq_i = cpu_rq(i);
-			struct task_struct *p;
+			rq_i = cpu_rq(i);
+			p = pick_task(rq_i, class, max, fi_before);
+			/*
+			 * If this new candidate is of higher priority than the
+			 * previous; and they're incompatible; pick_task makes
+			 * sure that p's priority is more than max if it doesn't
+			 * match max's cookie. Update max.
+			 *
+			 * NOTE: this is a linear max-filter and is thus bounded
+			 * in execution time.
+			 */
+			if (!max || !cookie_match(max, p))
+				max = p;
+		}
 
+		for_each_cpu_wrap(i, smt_mask, cpu) {
+			rq_i = cpu_rq(i);
 			if (rq_i->core_pick)
 				continue;
 
@@ -5536,34 +5552,6 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 					rq->core->core_forceidle_seq++;
 			}
 
-			/*
-			 * If this new candidate is of higher priority than the
-			 * previous; and they're incompatible; we need to wipe
-			 * the slate and start over. pick_task makes sure that
-			 * p's priority is more than max if it doesn't match
-			 * max's cookie.
-			 *
-			 * NOTE: this is a linear max-filter and is thus bounded
-			 * in execution time.
-			 */
-			if (!max || !cookie_match(max, p)) {
-				struct task_struct *old_max = max;
-
-				rq->core->core_cookie = p->core_cookie;
-				max = p;
-
-				if (old_max) {
-					rq->core->core_forceidle = false;
-					for_each_cpu(j, smt_mask) {
-						if (j == i)
-							continue;
-
-						cpu_rq(j)->core_pick = NULL;
-					}
-					occ = 1;
-					goto again;
-				}
-			}
 		}
 	}
 
-- 
2.31.1

