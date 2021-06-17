Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9893E3AAFF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhFQJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:42:50 -0400
Received: from outbound-smtp24.blacknight.com ([81.17.249.192]:33604 "EHLO
        outbound-smtp24.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229716AbhFQJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:42:49 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp24.blacknight.com (Postfix) with ESMTPS id A3F9982009
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:40:41 +0100 (IST)
Received: (qmail 19081 invoked from network); 17 Jun 2021 09:40:41 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2021 09:40:41 -0000
Date:   Thu, 17 Jun 2021 10:40:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Age the average idle time
Message-ID: <20210617094040.GM30378@techsingularity.net>
References: <20210615111611.GH30378@techsingularity.net>
 <20210615204228.GB4272@worktop.programming.kicks-ass.net>
 <CAKfTPtAZ_Aq_S-O2qh5LPyxExkBq3G0kxh51fT7sSC_z8He4+w@mail.gmail.com>
 <20210617074401.GL30378@techsingularity.net>
 <CAKfTPtC8d37ZrXfDF2jkgg=tDPb1qAvFQQGXHhTf9LLR59hd8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtC8d37ZrXfDF2jkgg=tDPb1qAvFQQGXHhTf9LLR59hd8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:30:09AM +0200, Vincent Guittot wrote:
> > > > I'm tempted to give it a go.. anyone object?
> > >
> > > Just finished running some tests on my large arm64 system.
> > > Tbench tests are a mixed between small gain and loss
> > >
> >
> > Same for tbench on three x86 machines I reran tests for
> >
> > <SNIP>
> >
> > For your arm machine, how many logical CPUs are online, what is the level
> > of SMT if any and is the machine NUMA?
> 
> It's a SMT4 x 28 cores x 2 NUMA nodes = 224 CPUs
> 

Ok, SMT4 is what I was interested in. I suspected this was the case but
was not sure. I wondered about the possibility that SMT4 should be
accounted for in the scan depth.

> >
> > Fundamentally though, as the changelog notes "due to the nature of the
> > patch, this is a regression magnet". There are going to be examples
> > where a deep search is better even if a machine is fully busy or
> > overloaded and examples where cutting off the search is better. I think
> > it's better to have an idle estimate that gets updated if CPUs are fully
> > busy even if it's not a universal win.
> 
> Although I agree that using a stall average idle time value of local
> is not good, I'm not sure this proposal is better. The main problem is
> that we use the avg_idle of the local CPU to estimate how many times
> we should loop and try to find another idle CPU. But there is no
> direct relation between both.

This is true. The idle time of the local CPU is used to estimate the
idle time of the domain which is inevitably going to be inaccurate but
tracking idle time for the domain will be cache write intensive and
potentially very expensive. I think this was discussed before but maybe
it is my imaginaction.

> Typically, a short average idle time on
> the local CPU doesn't mean that there are less idle CPUs and that's
> why we have a mix a gain and loss
> 

Can you evaluate if scanning proportional to cores helps if applied on
top? The patch below is a bit of pick&mix and has only seen a basic build
test with a distro config. While I will queue this, I don't expect it to
have an impact on SMT2.

--8--
sched/fair: Make select_idle_cpu() proportional to cores

From: Peter Zijlstra (Intel) <peterz@infradead.org>

Instead of calculating how many (logical) CPUs to scan, compute how
many cores to scan.

This changes behaviour for anything !SMT2.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c  | 17 ++++++++++++-----
 kernel/sched/fair.c  | 11 +++++++++--
 kernel/sched/sched.h |  2 ++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6a3fdb9f4380..1773e0707a5d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7846,11 +7846,18 @@ int sched_cpu_activate(unsigned int cpu)
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
-	/*
-	 * When going up, increment the number of cores with SMT present.
-	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
+	do {
+		int weight = cpumask_weight(cpu_smt_mask(cpu));
+
+		if (weight > sched_smt_weight)
+			sched_smt_weight = weight;
+
+		/*
+		 * When going up, increment the number of cores with SMT present.
+		 */
+		if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+			static_branch_inc_cpuslocked(&sched_smt_present);
+	} while (0);
 #endif
 	set_cpu_active(cpu, true);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cc7d1144a356..4fc4e1f2eaae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6037,6 +6037,8 @@ static inline int __select_idle_cpu(int cpu)
 DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 EXPORT_SYMBOL_GPL(sched_smt_present);
 
+int __read_mostly sched_smt_weight = 1;
+
 static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
@@ -6151,6 +6153,8 @@ static inline bool test_idle_cores(int cpu, bool def)
 	return def;
 }
 
+#define sched_smt_weight 1
+
 static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
 {
 	return __select_idle_cpu(core);
@@ -6163,6 +6167,8 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 
 #endif /* CONFIG_SCHED_SMT */
 
+#define sis_min_cores	2
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
@@ -6203,11 +6209,12 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		avg_cost = this_sd->avg_scan_cost + 1;
 
 		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > sis_min_cores * avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-			nr = 4;
+			nr = sis_min_cores;
 
+		nr *= sched_smt_weight;
 		time = cpu_clock(this);
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7bc20e5541cf..440a2bbc19d5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1119,6 +1119,8 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
+extern int sched_smt_weight;
+
 static inline void update_idle_core(struct rq *rq)
 {
 	if (static_branch_unlikely(&sched_smt_present))
