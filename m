Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF31A423237
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhJEUoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbhJEUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:43:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE0C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AVGImL3ruvNVzq5YKsJUM70rWAZqgEPHIFsXGBpnEZg=; b=U6f7ldqCZ7L6klTifV0lNLLrp9
        FLXWjtlk7Qbm3kt7RHxLNXed3wLj+IA5SqacDKcPvNUD+WVPhrB9L3Hs2KJ9uV6UdKTFVxNdHQCb5
        Z3yPruOCxIEVMacTvXczgnnyab+B8vymUfHPIpMQTM2Ki2WYXZwanX9mv4/ehf4vpSpn373WsKLLK
        PlJl2/MRh2BwT8sPqx8yyAsMfFDQkpIkHaZnfNixTlzFLdRWkNi3lliYXa9sZzy6ldcLPwlxx1Hs6
        FR9ANbI22TiSEiIKzp/uK5p5DfeDN8IbAGvml0l7MGpvD6eNjo9r+QRCgaO2BEQ9h2rU/+P1hGv/7
        F1E2D4kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXrEg-000G77-At; Tue, 05 Oct 2021 20:40:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90354981AAA; Tue,  5 Oct 2021 22:40:26 +0200 (CEST)
Date:   Tue, 5 Oct 2021 22:40:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/2] sched/fair: account update_blocked_averages in
 newidle_balance cost
Message-ID: <20211005204026.GD174703@worktop.programming.kicks-ass.net>
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
 <20211004171451.24090-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004171451.24090-2-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 07:14:50PM +0200, Vincent Guittot wrote:
> The time spent to update the blocked load can be significant depending of
> the complexity fo the cgroup hierarchy. Take this time into account when
> deciding to stop newidle_balance() because it exceeds the expected idle
> time.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8943dbb94365..1f78b2e3b71c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10810,7 +10810,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	int this_cpu = this_rq->cpu;
>  	struct sched_domain *sd;
>  	int pulled_task = 0;
> -	u64 curr_cost = 0;
> +	u64 t0, domain_cost, curr_cost = 0;
>  
>  	update_misfit_status(NULL, this_rq);
>  
> @@ -10855,11 +10855,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	raw_spin_rq_unlock(this_rq);
>  
> +	t0 = sched_clock_cpu(this_cpu);
>  	update_blocked_averages(this_cpu);
> +	domain_cost = sched_clock_cpu(this_cpu) - t0;
> +	curr_cost += domain_cost;
> +
>  	rcu_read_lock();
>  	for_each_domain(this_cpu, sd) {
>  		int continue_balancing = 1;
> -		u64 t0, domain_cost;
>  
>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
>  			update_next_balance(sd, &next_balance);

Does this make sense? It avoids a bunch of clock calls (and thereby
accounts more actual time).

Also, perhaps we should some asymmetric IIR instead of a strict MAX
filter for max_newidle_lb_cost.

---
Index: linux-2.6/kernel/sched/fair.c
===================================================================
--- linux-2.6.orig/kernel/sched/fair.c
+++ linux-2.6/kernel/sched/fair.c
@@ -10759,9 +10759,9 @@ static int newidle_balance(struct rq *th
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
+	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
 	int pulled_task = 0;
-	u64 t0, domain_cost, curr_cost = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10808,8 +10808,9 @@ static int newidle_balance(struct rq *th
 
 	t0 = sched_clock_cpu(this_cpu);
 	update_blocked_averages(this_cpu);
-	domain_cost = sched_clock_cpu(this_cpu) - t0;
-	curr_cost += domain_cost;
+	t1 = sched_clock_cpu(this_cpu);
+	curr_cost += t1 - t0;
+	t0 = t1;
 
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
@@ -10821,17 +10822,19 @@ static int newidle_balance(struct rq *th
 		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
-			t0 = sched_clock_cpu(this_cpu);
+			u64 domain_cost;
 
 			pulled_task = load_balance(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
 						   &continue_balancing);
 
-			domain_cost = sched_clock_cpu(this_cpu) - t0;
+			t1 = sched_clock_cpu(this_cpu);
+			domain_cost = t1 - t0;
 			if (domain_cost > sd->max_newidle_lb_cost)
 				sd->max_newidle_lb_cost = domain_cost;
 
 			curr_cost += domain_cost;
+			t0 = t1;
 		}
 
 		update_next_balance(sd, &next_balance);
