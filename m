Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2B3323FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhBXOZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbhBXNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:18:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EC4C061797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zb3cUSX0cr4s9HTxNI/WSDswzH1kYneCgpBK06JSd0M=; b=WS8o8Q+heugAudEaiMAlbUikAB
        tI2PLlsCYfoCkFZqxxGuinuZy1Xk9FTkOr/D1gHudpEUuDLuwvaXHQGlXejJlNNomdzjpgCkrUO2x
        jvQUcNM/7+ReFeFqZzN6/k1NcexVqUusBkeysXxZj5SDDpu8hQLKzeE3oklN4HKvHW8IbJlW4KxM9
        mtV3KdJmdWdJgjxD8g0o8IuSBz7D4ZXCVcRR63swMUNKtfEZQlyNyWmKKe/GsoGLKUVLZxdR9xuoM
        E8wzx5iZf/1BrGR981xNZSMK4vMW1fnPmEPZb4bgj5tEPRkVDYZYQvkyLVUEPUnm9/iwrMzf/nyd1
        F3aUDusA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEu14-009Qtx-Pz; Wed, 24 Feb 2021 13:15:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 583493069B1;
        Wed, 24 Feb 2021 14:15:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E06B3207C3A75; Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Message-ID: <20210224131355.649146419@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Feb 2021 13:24:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 5/6] sched: Fix affine_move_task() self-concurrency
References: <20210224122439.176543586@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider:

   sched_setaffinity(p, X);		sched_setaffinity(p, Y);

Then the first will install p->migration_pending = &my_pending; and
issue stop_one_cpu_nowait(pending); and the second one will read
p->migration_pending and _also_ issue: stop_one_cpu_nowait(pending),
the _SAME_ @pending.

This causes stopper list corruption.

Add set_affinity_pending::stop_pending, to indicate if a stopper is in
progress.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1864,6 +1864,7 @@ struct migration_arg {
 
 struct set_affinity_pending {
 	refcount_t		refs;
+	unsigned int		stop_pending;
 	struct completion	done;
 	struct cpu_stop_work	stop_work;
 	struct migration_arg	arg;
@@ -1982,12 +1983,15 @@ static int migration_cpu_stop(void *data
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
 		 */
+		WARN_ON_ONCE(!pending->stop_pending);
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		return 0;
 	}
 out:
+	if (pending)
+		pending->stop_pending = false;
 	task_rq_unlock(rq, p, &rf);
 
 	if (complete)
@@ -2183,7 +2187,7 @@ static int affine_move_task(struct rq *r
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	bool complete = false;
+	bool stop_pending, complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
@@ -2256,14 +2260,19 @@ static int affine_move_task(struct rq *r
 		 * anything else we cannot do is_migration_disabled(), punt
 		 * and have the stopper function handle it all race-free.
 		 */
+		stop_pending = pending->stop_pending;
+		if (!stop_pending)
+			pending->stop_pending = true;
 
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
+		if (!stop_pending) {
+			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work);
+		}
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;


