Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448F2324CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhBYJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbhBYJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:28:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B96C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AHoPDVhpKZAnD0ljNCwup9IQjWudOt5+EhKa+9ZFDLs=; b=DLLyju+hUQd3ZBFU5dJMo96qSJ
        4MmmRUfXVzq57pUOZUpjMfGYrV9gBQGeRDfYWgRU+HLg5nPO+wVX+fJpsfZhp5gEXqRl/zRisZqst
        /Q1QJFBoF93s83JOyQEFs0R3cw0ujvK1wCVrRWcGIRQqr/c1Btk1/774ROOHK6YkhKRlU1tjSGpGm
        0EXcsqME8nO960A+3YWvyhRHQuvJhMEYpbDdHddXuMnXw9cfsN8A2NYEI/9FICHBo7FrPel8++8su
        sI1tsHq4hU32sijGayjRVCHwoTL7COqL5MkGL3A18e0X7CB8nyfknBQOLQwy50mOnBj2K0MaFBMgk
        FWkMtTXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFCw0-00061o-Ca; Thu, 25 Feb 2021 09:27:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 432B83010D2;
        Thu, 25 Feb 2021 10:27:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2501420BC9284; Thu, 25 Feb 2021 10:27:46 +0100 (CET)
Date:   Thu, 25 Feb 2021 10:27:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 6/6] sched: Simplify set_affinity_pending refcounts
Message-ID: <YDdtkvUFxLs6zlyu@hirez.programming.kicks-ass.net>
References: <20210224122439.176543586@infradead.org>
 <20210224131355.724130207@infradead.org>
 <YDZyIugiyxAq0tVz@hirez.programming.kicks-ass.net>
 <jhjeeh55ouy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjeeh55ouy.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 05:59:01PM +0000, Valentin Schneider wrote:

> Your change reinstores the "triple SCA" pattern, where a stopper can run
> with arg->pending && arg->pending != p->migration_pending, which I was
> kinda happy to see go away...

Right, fair enough. Any workload that can tell the difference is doing
it wrong anyway :-)

OK, I've munged your two patches together into the below.

---
Subject: sched: Simplify migration_cpu_stop()
From: Valentin Schneider <valentin.schneider@arm.com>
Date: Thu Feb 25 10:22:30 CET 2021

Since, when ->stop_pending, only the stopper can uninstall
p->migration_pending. This could simplify a few ifs, because:

  (pending != NULL) => (pending == p->migration_pending)

Also, the fatty comment above affine_move_task() probably needs a bit
of gardening.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1927,6 +1927,12 @@ static int migration_cpu_stop(void *data
 	rq_lock(rq, &rf);
 
 	/*
+	 * If we were passed a pending, then ->stop_pending was set, thus
+	 * p->migration_pending must have remained stable.
+	 */
+	WARN_ON_ONCE(pending && pending != p->migration_pending);
+
+	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
 	 * we're holding p->pi_lock.
@@ -1936,8 +1942,7 @@ static int migration_cpu_stop(void *data
 			goto out;
 
 		if (pending) {
-			if (p->migration_pending == pending)
-				p->migration_pending = NULL;
+			p->migration_pending = NULL;
 			complete = true;
 		}
 
@@ -1976,8 +1981,7 @@ static int migration_cpu_stop(void *data
 		 * somewhere allowed, we're done.
 		 */
 		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			if (p->migration_pending == pending)
-				p->migration_pending = NULL;
+			p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
@@ -2165,16 +2169,21 @@ void do_set_cpus_allowed(struct task_str
  *
  * (1) In the cases covered above. There is one more where the completion is
  * signaled within affine_move_task() itself: when a subsequent affinity request
- * cancels the need for an active migration. Consider:
+ * occurs after the stopper bailed out due to the targeted task still being
+ * Migrate-Disable. Consider:
  *
  *     Initial conditions: P0->cpus_mask = [0, 1]
  *
- *     P0@CPU0            P1                             P2
- *
- *     migrate_disable();
- *     <preempted>
+ *     CPU0		  P1				P2
+ *     <P0>
+ *       migrate_disable();
+ *       <preempted>
  *                        set_cpus_allowed_ptr(P0, [1]);
  *                          <blocks>
+ *     <migration/0>
+ *       migration_cpu_stop()
+ *         is_migration_disabled()
+ *           <bails>
  *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
  *                                                         <signal completion>
  *                          <awakes>
