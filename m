Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9126544E941
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 15:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbhKLO6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 09:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhKLO6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:58:14 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C4C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 06:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sSTlqEqVyFN0rDOCb7kaZNs7CaBfwerBRghmXFsGs3Y=; b=BUSvOg7lubYe71hUFGWgXBwMWL
        JAi84DFrGmzWF/oLa3YoBufaqvLNVLO24lpBsKuxjJjrVipWKimVW+9+eC46z41iIl0Hf1l+URvQE
        JSEX3VFGOnTEgYOGYuE4j8dftMSlZaWmXyLSUr0WuiPUwySpi5sOwI+jdIWFH+eYIQ1VCStFjt6Rx
        bPFMsGgC8aHn46J0P6HPj6aL1JKDKUyHvYnWPhxwn8exxTIm781NZT+ELMC0AKDJspMo8hJ9aLisV
        T52AzK90xKu0EvWWMIv/98ybKllkewL2EUCChVqlae3x2klqoDzubobfomi6wxPNeKU1w8p8oucRu
        ww9mnrbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlXxH-00FdyU-Ev; Fri, 12 Nov 2021 14:55:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 103C430001B;
        Fri, 12 Nov 2021 15:55:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E27B8209F2A7A; Fri, 12 Nov 2021 15:55:01 +0100 (CET)
Date:   Fri, 12 Nov 2021 15:55:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, joel@joelfernandes.org
Subject: Re: [PATCH 1/2] sched/fair: skip newidle update stats
Message-ID: <YY6ARaFrpuWYqege@hirez.programming.kicks-ass.net>
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
 <20211112095857.7016-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112095857.7016-2-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Subject: sched/fair: Simplify newidle_balance()
From: Peter Zijlstra <peterz@infradead.org>
Date: Fri Nov 12 15:46:26 CET 2021

Move rq_{un,re}pin_lock() next to raw_spin_rq_{un,}lock().

Remove all rcu_read_{,un}lock(), since we have preempt/irqs disabled
over the whole function and those hold off RCU (again).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10884,15 +10884,6 @@ static int newidle_balance(struct rq *th
 	if (!cpu_active(this_cpu))
 		return 0;
 
-	/*
-	 * This is OK, because current is on_cpu, which avoids it being picked
-	 * for load-balance and preemption/IRQs are still disabled avoiding
-	 * further scheduler activity on it and we're being very careful to
-	 * re-start the picking loop.
-	 */
-	rq_unpin_lock(this_rq, rf);
-
-	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
@@ -10908,18 +10899,22 @@ static int newidle_balance(struct rq *th
 			 */
 			early_stop = 1;
 		}
-		rcu_read_unlock();
 
 		goto out;
 	}
-	rcu_read_unlock();
 
+	/*
+	 * This is OK, because current is on_cpu, which avoids it being picked
+	 * for load-balance and preemption/IRQs are still disabled avoiding
+	 * further scheduler activity on it and we're being very careful to
+	 * re-start the picking loop.
+	 */
+	rq_unpin_lock(this_rq, rf);
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
 	update_blocked_averages(this_cpu);
 
-	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
 		u64 domain_cost;
@@ -10953,9 +10948,9 @@ static int newidle_balance(struct rq *th
 		    this_rq->ttwu_pending)
 			break;
 	}
-	rcu_read_unlock();
 
 	raw_spin_rq_lock(this_rq);
+	rq_repin_lock(this_rq, rf);
 
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
@@ -10982,8 +10977,6 @@ static int newidle_balance(struct rq *th
 	else if (!early_stop)
 		nohz_newidle_balance(this_rq);
 
-	rq_repin_lock(this_rq, rf);
-
 	return pulled_task;
 }
 
