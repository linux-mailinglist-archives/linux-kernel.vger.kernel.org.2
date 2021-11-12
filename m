Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4274844E942
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbhKLO6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhKLO6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:58:34 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2821C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=03qa1X9jvFpv7oa51sCFcr+AEK1Zb4obuFzo1OPeexo=; b=eR4V+mmWQXx5Kb6GvcCGl7ijHl
        4rb2N5yTX8asXI6GiB9Vy8zfS1/MpkBCGb7rOT+MZT2kIkwEAFAAxlG5MLw7u+Em06a4g8PXW9ZQK
        ahq7cVHil7KXN2JS8qJP5ue1Zx9LZXg5CZyOAL/fKHgCTOI+VDcnchNc71nOzMthw7vUPl9yfNe9s
        10pqOv4Q0TSKNSythioKOHAS11ha8yJX3R8vzyVErWNq/j5ttJ3XtwWqqxWm2TxU6skMsbCoz4zgL
        EImHj9zZKa7Ru5tsuy7DPzi+iRv2tkMLiteBeOOqgINYFMZrrjNVy9PhPduAsvS9K14CJjUDb1yJ/
        fiLG5fpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlXxf-00Fdyw-Ia; Fri, 12 Nov 2021 14:55:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2B43630001B;
        Fri, 12 Nov 2021 15:55:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BD24209F2A7A; Fri, 12 Nov 2021 15:55:27 +0100 (CET)
Date:   Fri, 12 Nov 2021 15:55:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joel@joelfernandes.org
Subject: Re: [PATCH 1/2] sched/fair: skip newidle update stats
Message-ID: <YY6AXx2lhJ27IBuJ@hirez.programming.kicks-ass.net>
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
 <20211112095857.7016-2-vincent.guittot@linaro.org>
 <YY6ARaFrpuWYqege@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YY6ARaFrpuWYqege@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Subject: sched/fair: Reflow newidle_balance()
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Nov 12 15:46:08 CET 2021

The control flow in newidle_balance() is a little convoluted, attempt
simplification.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10858,10 +10858,10 @@ static inline void nohz_newidle_balance(
 static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
+	int pulled_task = 0, timeout = 0;
 	int this_cpu = this_rq->cpu;
 	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
-	int pulled_task = 0, early_stop = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10889,17 +10889,9 @@ static int newidle_balance(struct rq *th
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		if (sd) {
+		if (sd)
 			update_next_balance(sd, &next_balance);
 
-			/*
-			 * We skip new idle LB because there is not enough
-			 * time before next wake up. Make sure that we will
-			 * not kick NOHZ_NEWILB_KICK
-			 */
-			early_stop = 1;
-		}
-
 		goto out;
 	}
 
@@ -10922,7 +10914,7 @@ static int newidle_balance(struct rq *th
 		update_next_balance(sd, &next_balance);
 
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
-			early_stop = 1;
+			timeout = 1;
 			break;
 		}
 
@@ -10967,6 +10959,11 @@ static int newidle_balance(struct rq *th
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
+	if (pulled_task || timeout)
+		goto out;
+
+	nohz_newidle_balance(this_rq);
+
 out:
 	/* Move the next balance forward */
 	if (time_after(this_rq->next_balance, next_balance))
@@ -10974,8 +10971,6 @@ static int newidle_balance(struct rq *th
 
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
-	else if (!early_stop)
-		nohz_newidle_balance(this_rq);
 
 	return pulled_task;
 }
