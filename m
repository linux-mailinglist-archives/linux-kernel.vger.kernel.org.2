Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B136488C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239300AbhDSQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:52:16 -0400
Received: from shelob.surriel.com ([96.67.55.147]:32784 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhDSQwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:52:11 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lYX7X-00053n-AQ; Mon, 19 Apr 2021 12:51:35 -0400
Date:   Mon, 19 Apr 2021 12:51:34 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched,fair: skip newidle_balance if a wakeup is pending
Message-ID: <20210419125134.5cab12ea@imladris.surriel.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The try_to_wake_up function has an optimization where it can queue
a task for wakeup on its previous CPU, if the task is still in the
middle of going to sleep inside schedule().

Once schedule() re-enables IRQs, the task will be woken up with an
IPI, and placed back on the runqueue.

If we have such a wakeup pending, there is no need to search other
CPUs for runnable tasks. Just skip (or bail out early from) newidle
balancing, and run the just woken up task.

For a memcache like workload test, this reduces total CPU use by
about 2%, proportionally split between user and system time,
and p99 and p95 application response time by 2-3% on average.
The schedstats run_delay number shows a similar improvement.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
v2:
 - fix !SMP build error and prev-not-CFS case by moving check into newidle_balance
 - fix formatting of if condition
 - audit newidle_balance return value use to make sure we get that right
 - reset idle_stamp when breaking out of the loop due to ->ttwu_pending

 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69680158963f..5e26f013e182 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10594,6 +10594,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	u64 curr_cost = 0;
 
 	update_misfit_status(NULL, this_rq);
+
+	/*
+	 * There is a task waiting to run. No need to search for one.
+	 * Return 0; the task will be enqueued when switching to idle.
+	 */
+	if (this_rq->ttwu_pending)
+		return 0;
+
 	/*
 	 * We must set idle_stamp _before_ calling idle_balance(), such that we
 	 * measure the duration of idle_balance() as idle time.
@@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
 		 */
-		if (pulled_task || this_rq->nr_running > 0)
+		if (pulled_task || this_rq->nr_running > 0 ||
+		    this_rq->ttwu_pending)
 			break;
 	}
 	rcu_read_unlock();
@@ -10688,7 +10697,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
-	if (pulled_task)
+	if (pulled_task || this_rq->ttwu_pending)
 		this_rq->idle_stamp = 0;
 
 	rq_repin_lock(this_rq, rf);
-- 
2.25.4


