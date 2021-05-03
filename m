Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D833371340
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 11:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhECJye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhECJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 05:54:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47983C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hLPu0wpdmQKELX3cOXNLgsdlL7XHs8HLylrnei9aMfI=; b=bovjrGykvABavLuvniI2mznMyi
        RK//qQ5heBgB0/OX0vBLQaQLUmhbEX890z5CoOoUh9mGb2/UAhY1d3y1OC9B6XVNXYaO8elpQRmPj
        M2zTypFx7Zf8/9wQNdYTZlsrXjmmAvfujnehghvqsQGVp4VTi1YFxaqjkgcIgavGhVu8B2667Rje3
        ul5DGsdU5iA2vSvx/nAjjIo+EcpE+fiGhr1cZ88lndmNdUbERP8EcSUJo00SYbneoQMvVJvKlDfAN
        zv+42oRbxA0TVwiUE33A1bKVxgCmYebqpszvvRMPNv6VvybXNMQk480y2bizZP386LQl37rG0GVNL
        VyzS1SLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldVFb-00Euvl-QY; Mon, 03 May 2021 09:52:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 356D8300036;
        Mon,  3 May 2021 11:52:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E05522BC22561; Mon,  3 May 2021 11:52:25 +0200 (CEST)
Date:   Mon, 3 May 2021 11:52:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.comi>, Mel Gorman <mgorman@suse.de>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Quentin Perret <qperret@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2 3/4] sched/fair: Consider SMT in ASYM_PACKING load
 balance
Message-ID: <YI/H2dBB5M5da6ba@hirez.programming.kicks-ass.net>
References: <20210414020436.12980-1-ricardo.neri-calderon@linux.intel.com>
 <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414020436.12980-4-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:04:35PM -0700, Ricardo Neri wrote:
> +static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +	if (!static_branch_likely(&sched_smt_present))
> +		return false;
> +
> +	if (sg->group_weight == 1)
> +		return false;
> +
> +	return cpumask_equal(sched_group_span(sg), cpu_smt_mask(cpu));
> +#else
> +	return false;
> +#endif
> +}
> +
> +/**
> + * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
> + * @dst_cpu:	CPU doing the load balancing
> + * @sds:	Load-balancing data with statistics of the local group
> + * @sgs:	Load-balancing statistics of the candidate busiest group
> + * @sg:		The candidate busiet group
> + *
> + * Check the state of the SMT siblings of both @sds::local and @sg and decide
> + * if @dst_cpu can pull tasks. If @dst_cpu does not have SMT siblings, it can
> + * pull tasks if two or more of the SMT siblings of @sg are busy. If only one
> + * CPU in @sg is busy, pull tasks only if @dst_cpu has higher priority.
> + *
> + * If both @dst_cpu and @sg have SMT siblings. Even the number of idle CPUs
> + * between @sds::local and @sg. Thus, pull tasks from @sg if the difference
> + * between the number of busy CPUs is 2 or more. If the difference is of 1,
> + * only pull if @dst_cpu has higher priority. If @sg does not have SMT siblings
> + * only pull tasks if all of the SMT siblings of @dst_cpu are idle and @sg
> + * has lower priority.
> + */
> +static bool asym_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> +				struct sg_lb_stats *sgs, struct sched_group *sg)
> +{
> +#ifdef CONFIG_SCHED_SMT
> +	int cpu, local_busy_cpus, sg_busy_cpus;
> +	bool local_is_smt, sg_is_smt;
> +
> +	if (!arch_asym_check_smt_siblings())
> +		return true;
> +
> +	cpu = group_first_cpu(sg);
> +	local_is_smt = cpu_group_is_smt(dst_cpu, sds->local);
> +	sg_is_smt = cpu_group_is_smt(cpu, sg);

Would something like this make sense?

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8533,21 +8533,6 @@ static inline void update_sg_lb_stats(st
 				sgs->group_capacity;
 }
 
-static bool cpu_group_is_smt(int cpu, struct sched_group *sg)
-{
-#ifdef CONFIG_SCHED_SMT
-	if (!static_branch_likely(&sched_smt_present))
-		return false;
-
-	if (sg->group_weight == 1)
-		return false;
-
-	return cpumask_equal(sched_group_span(sg), cpu_smt_mask(cpu));
-#else
-	return false;
-#endif
-}
-
 /**
  * asym_can_pull_tasks - Check whether the load balancing CPU can pull tasks
  * @dst_cpu:	CPU doing the load balancing
@@ -8578,8 +8563,8 @@ static bool asym_can_pull_tasks(int dst_
 		return true;
 
 	cpu = group_first_cpu(sg);
-	local_is_smt = cpu_group_is_smt(dst_cpu, sds->local);
-	sg_is_smt = cpu_group_is_smt(cpu, sg);
+	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
+	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
 
 	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1795,6 +1795,7 @@ struct sched_group {
 	unsigned int		group_weight;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
+	int			flags;
 
 	/*
 	 * The CPUs this group covers.
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -916,10 +916,12 @@ build_group_from_child_sched_domain(stru
 		return NULL;
 
 	sg_span = sched_group_span(sg);
-	if (sd->child)
+	if (sd->child) {
 		cpumask_copy(sg_span, sched_domain_span(sd->child));
-	else
+		sg->flags = sd->child->flags;
+	} else {
 		cpumask_copy(sg_span, sched_domain_span(sd));
+	}
 
 	atomic_inc(&sg->ref);
 	return sg;
@@ -1169,6 +1171,7 @@ static struct sched_group *get_group(int
 	if (child) {
 		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
 		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
+		sg->flags = child->flags;
 	} else {
 		cpumask_set_cpu(cpu, sched_group_span(sg));
 		cpumask_set_cpu(cpu, group_balance_mask(sg));
