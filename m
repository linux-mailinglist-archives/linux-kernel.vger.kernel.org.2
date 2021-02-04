Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE130F270
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbhBDLhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:37:24 -0500
Received: from foss.arm.com ([217.140.110.172]:56552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235688AbhBDLfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:35:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98E7D6E;
        Thu,  4 Feb 2021 03:34:46 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5730B3F73B;
        Thu,  4 Feb 2021 03:34:45 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 5/8] sched/fair: Make check_misfit_status() only compare dynamic capacities
In-Reply-To: <f1ea5b53-5953-15dc-6b67-9b6d520c61fc@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com> <20210128183141.28097-6-valentin.schneider@arm.com> <20210203151546.rwkbdjxc2vgiodvx@e107158-lin> <f1ea5b53-5953-15dc-6b67-9b6d520c61fc@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 04 Feb 2021 11:34:38 +0000
Message-ID: <jhja6sk2hip.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 11:49, Dietmar Eggemann wrote:
> On 03/02/2021 16:15, Qais Yousef wrote:
>> On 01/28/21 18:31, Valentin Schneider wrote:
>
> [...]
>
>>> @@ -10238,7 +10236,7 @@ static void nohz_balancer_kick(struct rq *rq)
>>>  		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
>>>  		 * to run the misfit task on.
>>>  		 */
>>> -		if (check_misfit_status(rq, sd)) {
>>> +		if (check_misfit_status(rq)) {
>
> Since check_misfit_status() doesn't need sd anymore it looks like that
> rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu)) could be replaced by
> static_branch_unlikely(&sched_asym_cpucapacity)) in nohz_balancer_kick().
>
> But as you mentioned in an earlier conversation we do need to check sd
> because of asymmetric CPU capacity systems w/ exclusive cpusets which
> could create symmetric islands (unique capacity_orig among CPUs).
>
> Maybe worth putting a comment here (similar to the one in sis()) so
> people don't try to optimize?

How about:

--->8---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c2351b87824f..4b71f4d1d324 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6322,15 +6322,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 * sd_asym_cpucapacity rather than sd_llc.
 	 */
 	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+		/* See sd_has_asym_cpucapacity() */
 		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
-		/*
-		 * On an asymmetric CPU capacity system where an exclusive
-		 * cpuset defines a symmetric island (i.e. one unique
-		 * capacity_orig value through the cpuset), the key will be set
-		 * but the CPUs within that cpuset will not have a domain with
-		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
-		 * capacity path.
-		 */
 		if (sd) {
 			i = select_idle_capacity(p, sd, target);
 			return ((unsigned)i < nr_cpumask_bits) ? i : target;
@@ -10274,6 +10267,10 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
+	/*
+	 * Below checks don't actually use the sd, but they still hinge on its
+	 * presence. See sd_has_asym_cpucapacity().
+	 */
 	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 21bd71f58c06..ea7f0155e268 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1482,6 +1482,33 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 extern struct static_key_false sched_asym_cpucapacity;
 
+/*
+ * Note that the static key is system-wide, but the visibility of
+ * SD_ASYM_CPUCAPACITY isn't. Thus the static key being enabled does not
+ * imply all CPUs can see asymmetry.
+ *
+ * Consider an asymmetric CPU capacity system such as:
+ *
+ * MC [           ]
+ *     0 1 2 3 4 5
+ *     L L L L B B
+ *
+ * w/ arch_scale_cpu_capacity(L) < arch_scale_cpu_capacity(B)
+ *
+ * By default, booting this system will enable the sched_asym_cpucapacity
+ * static key, and all CPUs will see SD_ASYM_CPUCAPACITY set at their MC
+ * sched_domain.
+ *
+ * Further consider exclusive cpusets creating a "symmetric island":
+ *
+ * MC [   ][      ]
+ *     0 1  2 3 4 5
+ *     L L  L L B B
+ *
+ * Again, booting this will enable the static key, but CPUs 0-1 will *not* have
+ * SD_ASYM_CPUCAPACITY set in any of their sched_domain. This is the intending
+ * behaviour, as CPUs 0-1 should be treated as a regular, isolated SMP system.
+ */
 static inline bool sd_has_asym_cpucapacity(struct sched_domain *sd)
 {
 	return static_branch_unlikely(&sched_asym_cpucapacity) &&
