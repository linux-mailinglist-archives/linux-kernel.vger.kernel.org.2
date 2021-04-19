Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFC6363956
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 04:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbhDSCSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 22:18:31 -0400
Received: from shelob.surriel.com ([96.67.55.147]:55336 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhDSCSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 22:18:30 -0400
Received: from [2603:3005:d05:2b00:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1lYJU3-0001eJ-PD; Sun, 18 Apr 2021 22:17:55 -0400
Date:   Sun, 18 Apr 2021 22:17:51 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>
Subject: [PATCH] sched,fair: skip newidle_balance if a wakeup is pending
Message-ID: <20210418221751.7edfc03b@imladris.surriel.com>
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
 kernel/sched/fair.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69680158963f..19a92c48939f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7163,6 +7163,14 @@ done: __maybe_unused;
 	if (!rf)
 		return NULL;
 
+	/*
+	 * We have a woken up task pending here. No need to search for ones
+	 * elsewhere. This task will be enqueued the moment we unblock irqs
+	 * upon exiting the scheduler.
+	 */
+	if (rq->ttwu_pending)
+		return NULL;
+
 	new_tasks = newidle_balance(rq, rf);
 
 	/*
@@ -10661,7 +10669,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
 		 */
-		if (pulled_task || this_rq->nr_running > 0)
+		if (pulled_task || this_rq->nr_running > 0 ||
+						this_rq->ttwu_pending)
 			break;
 	}
 	rcu_read_unlock();
-- 
2.25.4


