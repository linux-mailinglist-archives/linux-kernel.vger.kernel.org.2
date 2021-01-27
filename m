Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28C5305AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhA0MGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:06:01 -0500
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:57601 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237550AbhA0MDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:03:39 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 0D45E1F0E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:02:47 +0000 (GMT)
Received: (qmail 29144 invoked from network); 27 Jan 2021 12:02:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Jan 2021 12:02:46 -0000
Date:   Wed, 27 Jan 2021 12:02:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210127120245.GC3592@techsingularity.net>
References: <20210125085909.4600-1-mgorman@techsingularity.net>
 <20210125085909.4600-5-mgorman@techsingularity.net>
 <CAKfTPtBhq25D8iZ67n+kkf9Mdyf+OradvVC5pG0MeZEMKZmU2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBhq25D8iZ67n+kkf9Mdyf+OradvVC5pG0MeZEMKZmU2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 11:43:22AM +0100, Vincent Guittot wrote:
> > @@ -6149,18 +6161,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >         }
> >
> >         for_each_cpu_wrap(cpu, cpus, target) {
> > -               if (!--nr)
> > -                       return -1;
> > -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > -                       break;
> > +               if (smt) {
> > +                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > +                       if ((unsigned int)i < nr_cpumask_bits)
> > +                               return i;
> > +
> > +               } else {
> > +                       if (!--nr)
> > +                               return -1;
> > +                       i = __select_idle_cpu(cpu);
> 
> you should use idle_cpu directly instead of this intermediate i variable
> 
> +                       idle_cpu = __select_idle_cpu(cpu);
> +                       if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +                               break;
> 
> Apart ths small comment above, the patch looks good to me and I
> haven't any performance regression anymore
> 

It's matching the code sequence in the SMT block. If we are going to make
that change, then go the full way with this?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52a650aa2108..01e40e36c386 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6129,7 +6129,7 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	int cpu, idle_cpu = -1, nr = INT_MAX;
 	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
@@ -6162,18 +6162,16 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (smt) {
-			i = select_idle_core(p, cpu, cpus, &idle_cpu);
-			if ((unsigned int)i < nr_cpumask_bits)
-				return i;
+			idle_cpu = select_idle_core(p, cpu, cpus, &idle_cpu);
+			if ((unsigned int)idle_cpu < nr_cpumask_bits)
+				return idle_cpu;
 
 		} else {
 			if (!--nr)
 				return -1;
-			i = __select_idle_cpu(cpu);
-			if ((unsigned int)i < nr_cpumask_bits) {
-				idle_cpu = i;
+			idle_cpu = __select_idle_cpu(cpu);
+			if ((unsigned int)idle_cpu < nr_cpumask_bits)
 				break;
-			}
 		}
 	}
 

-- 
Mel Gorman
SUSE Labs
