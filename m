Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306F442FA70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbhJORoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhJORob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:44:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC9C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Z3h947/PvpyKAKMNll9nfg4MmCHM64lXzrnCKpR5RUU=; b=gfueFQc5mp9D0LAkcd1gl06gf3
        vpOLTJBEtliv7HJc+KqbsKdeyBma0wjyI6M3q7Mvcc+QlFgSt2XRtq2jkC1tSyvOVcZYKgBydSX6g
        /y689Imqc38zBUPDrQTsYGPqbSOkDyQm7vOS2kGqPIghbzMZ6FbZ322eEcE5XazKlXOpG7HcAIcxN
        F/Xb5Yb1YXycbY+qYatJ3Vv5TH+JwIYeZoQ8rpmCwV3lgqCxaW7nsBGqq7veOnVdKjNbGwfpTkDA2
        PUmjtVS2TuIo38+Zn3zKpZIQNJ/G3z53bCez5oAoCI54s8Gx3T08B717xkjlLsMd0towwaCKSQfa0
        J+mb4mpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbRCH-009B2J-So; Fri, 15 Oct 2021 17:40:57 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51EED9857C7; Fri, 15 Oct 2021 19:40:45 +0200 (CEST)
Date:   Fri, 15 Oct 2021 19:40:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 3/4] sched/fair: Wait before decaying
 max_newidle_lb_cost
Message-ID: <20211015174045.GI174703@worktop.programming.kicks-ass.net>
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
 <20211015124654.18093-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015124654.18093-4-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 02:46:53PM +0200, Vincent Guittot wrote:
> Decay max_newidle_lb_cost only when it has not been updated for a while
> and ensure to not decay a recently changed value.

I was more thinking something long these lines; ofcourse, no idea how
well it actually behaves.

Index: linux-2.6/include/linux/sched/topology.h
===================================================================
--- linux-2.6.orig/include/linux/sched/topology.h
+++ linux-2.6/include/linux/sched/topology.h
@@ -98,7 +98,6 @@ struct sched_domain {
 
 	/* idle_balance() stats */
 	u64 max_newidle_lb_cost;
-	unsigned long next_decay_max_lb_cost;
 
 	u64 avg_scan_cost;		/* select_idle_sibling */
 
Index: linux-2.6/kernel/sched/fair.c
===================================================================
--- linux-2.6.orig/kernel/sched/fair.c
+++ linux-2.6/kernel/sched/fair.c
@@ -10241,6 +10241,17 @@ void update_max_interval(void)
 }
 
 /*
+ * Asymmetric IIR filter, 1/4th down, 3/4th up.
+ */
+static void update_newidle_cost(u64 *cost, u64 new)
+{
+	s64 diff = new - *cost;
+	if (diff > 0)
+		diff *= 3;
+	*cost += diff / 4;
+}
+
+/*
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
@@ -10256,33 +10267,18 @@ static void rebalance_domains(struct rq
 	/* Earliest time when we have to do rebalance again */
 	unsigned long next_balance = jiffies + 60*HZ;
 	int update_next_balance = 0;
-	int need_serialize, need_decay = 0;
-	u64 max_cost = 0;
+	int need_serialize;
 
 	rcu_read_lock();
 	for_each_domain(cpu, sd) {
-		/*
-		 * Decay the newidle max times here because this is a regular
-		 * visit to all the domains. Decay ~1% per second.
-		 */
-		if (time_after(jiffies, sd->next_decay_max_lb_cost)) {
-			sd->max_newidle_lb_cost =
-				(sd->max_newidle_lb_cost * 253) / 256;
-			sd->next_decay_max_lb_cost = jiffies + HZ;
-			need_decay = 1;
-		}
-		max_cost += sd->max_newidle_lb_cost;
 
 		/*
 		 * Stop the load balance at this level. There is another
 		 * CPU in our sched group which is doing load balancing more
 		 * actively.
 		 */
-		if (!continue_balancing) {
-			if (need_decay)
-				continue;
+		if (!continue_balancing)
 			break;
-		}
 
 		interval = get_sd_balance_interval(sd, busy);
 
@@ -10313,14 +10309,7 @@ out:
 			update_next_balance = 1;
 		}
 	}
-	if (need_decay) {
-		/*
-		 * Ensure the rq-wide value also decays but keep it at a
-		 * reasonable floor to avoid funnies with rq->avg_idle.
-		 */
-		rq->max_idle_balance_cost =
-			max((u64)sysctl_sched_migration_cost, max_cost);
-	}
+
 	rcu_read_unlock();
 
 	/*
@@ -10909,8 +10898,7 @@ static int newidle_balance(struct rq *th
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			if (domain_cost > sd->max_newidle_lb_cost)
-				sd->max_newidle_lb_cost = domain_cost;
+			update_newidle_cost(&sd->max_newidle_lb_cost, domain_cost);
 
 			curr_cost += domain_cost;
 			t0 = t1;
@@ -10930,8 +10918,7 @@ static int newidle_balance(struct rq *th
 
 	raw_spin_rq_lock(this_rq);
 
-	if (curr_cost > this_rq->max_idle_balance_cost)
-		this_rq->max_idle_balance_cost = curr_cost;
+	update_newidle_cost(&this_rq->max_idle_balance_cost, curr_cost);
 
 	/*
 	 * While browsing the domains, we released the rq lock, a task could

