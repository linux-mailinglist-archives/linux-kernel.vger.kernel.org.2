Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B7E36809F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhDVMif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbhDVMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D693C06138D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3/T0DZIFV1YxzTahdT76QsI+nGR+hXoMehH2C9Hs8wg=; b=EqVTXKN5z4Ov7vkDfaOfc9/ys/
        e8VCKxDYGo1ttaeKt9IQF8wf70UaE9eh5TYLeaxLa0yZGY6ylGGkKxugJVrIMroXUQ3bQEjDGLL2D
        /pvZx1TIGV7b9nvkKqiUUTc/1fH5dIYDqIpmdTV0w5BZzfjXdPrkXOWt98brIfdCP8g3MJAMm9P/T
        d04I2NrBboHM5x4H6lS5PJm0e/V4eL2ddP8zSi1FfYjgKIiy8agw8olz5HW7CcDn7yGoBg7Sm8wlL
        RYh2+DkwVMGw0TSGRQD7XK1oRKnUKJLRpaFJahlExUlBuWG8Ar8I2TG/bfVWO6pMaaPfIvbsAprxa
        G19073mg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZ2-000ICF-GU; Thu, 22 Apr 2021 12:36:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C33A30031E;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 589FE2C67A901; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123308.678425748@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 12/19] sched: Fix priority inversion of cookied task with sibling
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

The rationale is as follows. In the core-wide pick logic, even if
need_sync == false, we need to go look at other CPUs (non-local CPUs)
to see if they could be running RT.

Say the RQs in a particular core look like this:

Let CFS1 and CFS2 be 2 tagged CFS tags.
Let RT1 be an untagged RT task.

	rq0		rq1
	CFS1 (tagged)	RT1 (no tag)
	CFS2 (tagged)

Say schedule() runs on rq0. Now, it will enter the above loop and
pick_task(RT) will return NULL for 'p'. It will enter the above if()
block and see that need_sync == false and will skip RT entirely.

The end result of the selection will be (say prio(CFS1) > prio(CFS2)):

	rq0             rq1
	CFS1            IDLE

When it should have selected:

	rq0             rq1
	IDLE            RT

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   65 ++++++++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5425,6 +5425,15 @@ pick_next_task(struct rq *rq, struct tas
 	put_prev_task_balance(rq, prev, rf);
 
 	smt_mask = cpu_smt_mask(cpu);
+	need_sync = !!rq->core->core_cookie;
+
+	/* reset state */
+	rq->core->core_cookie = 0UL;
+	if (rq->core->core_forceidle) {
+		need_sync = true;
+		fi_before = true;
+		rq->core->core_forceidle = false;
+	}
 
 	/*
 	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
@@ -5437,14 +5446,25 @@ pick_next_task(struct rq *rq, struct tas
 	 * 'Fix' this by also increasing @task_seq for every pick.
 	 */
 	rq->core->core_task_seq++;
-	need_sync = !!rq->core->core_cookie;
 
-	/* reset state */
-	rq->core->core_cookie = 0UL;
-	if (rq->core->core_forceidle) {
+	/*
+	 * Optimize for common case where this CPU has no cookies
+	 * and there are no cookied tasks running on siblings.
+	 */
+	if (!need_sync) {
+		for_each_class(class) {
+			next = class->pick_task(rq);
+			if (next)
+				break;
+		}
+
+		if (!next->core_cookie) {
+			rq->core_pick = NULL;
+			goto done;
+		}
 		need_sync = true;
-		rq->core->core_forceidle = false;
 	}
+
 	for_each_cpu(i, smt_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
@@ -5474,31 +5494,8 @@ pick_next_task(struct rq *rq, struct tas
 			 * core.
 			 */
 			p = pick_task(rq_i, class, max);
-			if (!p) {
-				/*
-				 * If there weren't no cookies; we don't need to
-				 * bother with the other siblings.
-				 * If the rest of the core is not running a tagged
-				 * task, i.e.  need_sync == 0, and the current CPU
-				 * which called into the schedule() loop does not
-				 * have any tasks for this class, skip selecting for
-				 * other siblings since there's no point. We don't skip
-				 * for RT/DL because that could make CFS force-idle RT.
-				 */
-				if (i == cpu && !need_sync && class == &fair_sched_class)
-					goto next_class;
-
+			if (!p)
 				continue;
-			}
-
-			/*
-			 * Optimize the 'normal' case where there aren't any
-			 * cookies and we don't need to sync up.
-			 */
-			if (i == cpu && !need_sync && !p->core_cookie) {
-				next = p;
-				goto done;
-			}
 
 			rq_i->core_pick = p;
 
@@ -5526,19 +5523,9 @@ pick_next_task(struct rq *rq, struct tas
 						cpu_rq(j)->core_pick = NULL;
 					}
 					goto again;
-				} else {
-					/*
-					 * Once we select a task for a cpu, we
-					 * should not be doing an unconstrained
-					 * pick because it might starve a task
-					 * on a forced idle cpu.
-					 */
-					need_sync = true;
 				}
-
 			}
 		}
-next_class:;
 	}
 
 	rq->core->core_pick_seq = rq->core->core_task_seq;


