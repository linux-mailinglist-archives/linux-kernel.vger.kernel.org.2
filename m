Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DB835694F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 12:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbhDGKUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 06:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhDGKUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:20:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954BFC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aigxBxAGqI94GU2Op6P5q+9WzSl1Evxrdu+LV5ODMUI=; b=swLXxDKdtVY3Ewf3VfRy8DbXYD
        C9f6D/mtkUeI9Nbn1FJPYINLNGoxW5N2xd5vq863cPw8YJLVocdrpXqPXMqFz9yU0hpbrHB1UnWwM
        qD3WpmQWpHHnqOUqZUuRPiafGiAA6vz+/OVEt4GsPQX1czVSuathWWknToPgq1aT208WUaLeZjC3Z
        PZi6obpyx+2ytZ9x9vcKPwDqX9JKvWLeiKxKiIhL/C6BslRkebklqopHBvbAuK5dmYIAH/bkOr5Gh
        iKBzx5SkLkTv5qVF6NUihLtvSXlZtXz2rGiCFnzYK+VeS+5hBQPPCb/1V16KmnROAWsibQkSF+ndL
        d/SlaRzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU5Hi-00EIuX-87; Wed, 07 Apr 2021 10:19:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACA7B300119;
        Wed,  7 Apr 2021 12:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9ABDB24403D94; Wed,  7 Apr 2021 12:19:41 +0200 (CEST)
Date:   Wed, 7 Apr 2021 12:19:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <YG2HPUfrb0YyB1SG@hirez.programming.kicks-ass.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
 <20210407094217.GA2926@vingu-book>
 <YG2BXRm60IhpumD8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG2BXRm60IhpumD8@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:54:37AM +0200, Peter Zijlstra wrote:

> Let me have another poke at it.

Pretty much what you did, except I also did s/smt/has_idle_core/ and
fixed that @sd thing.

Like so then?

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6038,11 +6038,9 @@ static inline bool test_idle_cores(int c
 {
 	struct sched_domain_shared *sds;
 
-	if (static_branch_likely(&sched_smt_present)) {
-		sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-		if (sds)
-			return READ_ONCE(sds->has_idle_cores);
-	}
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds)
+		return READ_ONCE(sds->has_idle_cores);
 
 	return def;
 }
@@ -6112,6 +6110,24 @@ static int select_idle_core(struct task_
 	return -1;
 }
 
+/*
+ * Scan the local SMT mask for idle CPUs.
+ */
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpu_smt_mask(target)) {
+		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
+		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
+			continue;
+		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
+			return cpu;
+	}
+
+	return -1;
+}
+
 #else /* CONFIG_SCHED_SMT */
 
 static inline void set_idle_cores(int cpu, int val)
@@ -6128,6 +6144,11 @@ static inline int select_idle_core(struc
 	return __select_idle_cpu(core);
 }
 
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	return -1;
+}
+
 #endif /* CONFIG_SCHED_SMT */
 
 /*
@@ -6135,11 +6156,10 @@ static inline int select_idle_core(struc
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
-	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6150,7 +6170,7 @@ static int select_idle_cpu(struct task_s
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
 
 		/*
@@ -6170,7 +6190,7 @@ static int select_idle_cpu(struct task_s
 	}
 
 	for_each_cpu_wrap(cpu, cpus, target) {
-		if (smt) {
+		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
 			if ((unsigned int)i < nr_cpumask_bits)
 				return i;
@@ -6184,10 +6204,10 @@ static int select_idle_cpu(struct task_s
 		}
 	}
 
-	if (smt)
+	if (has_idle_core)
 		set_idle_cores(this, false);
 
-	if (sched_feat(SIS_PROP) && !smt) {
+	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
@@ -6242,6 +6262,7 @@ static inline bool asym_fits_capacity(in
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
+	bool has_idle_core = false;
 	struct sched_domain *sd;
 	unsigned long task_util;
 	int i, recent_used_cpu;
@@ -6321,7 +6342,17 @@ static int select_idle_sibling(struct ta
 	if (!sd)
 		return target;
 
-	i = select_idle_cpu(p, sd, target);
+	if (static_branch_likely(&sched_smt_present)) {
+		has_idle_core = test_idle_cores(target, false);
+
+		if (!has_idle_core && cpus_share_cache(prev, target)) {
+			i = select_idle_smt(p, sd, prev);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+		}
+	}
+
+	i = select_idle_cpu(p, sd, has_idle_core, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
