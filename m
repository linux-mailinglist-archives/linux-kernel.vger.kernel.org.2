Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5025D35683A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244045AbhDGJmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbhDGJmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:42:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2DC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 02:42:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a12so7437785wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 02:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xb27NCncv/GAk0Yv/0MlOewwu09tsDyowI6eFugj4IE=;
        b=Gl/QrDY43wtWOf4YnE9lMm+/Wux3DRQJSXCslD+XLTpIk64/B7EaczWr5AyuX8jffg
         whbednG2UljxEPnahZeMnlKMprhyPtfWYrHtUwPvo2W6Js+usH0bYakcg8B/7ke4A3c1
         79Yky735aHFkzUIFeuxlnqzXuYS/cTq7jbW+I5J5wV01YG6uKZsF6plEj/vzd5sf03Bn
         rqQ7vwPxHTBA1CXFCU1zYt3XvbYVaQAoJPZJ2yp0T7pJlDxq9AL9q/roFtJu9L1zW1Vp
         uznJKA7SXzyGt+DB8fXtiXo1hqpRvDKykPuyBnxwwcZq/nxDenN+NyRdvVgBgESPE6XC
         JfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xb27NCncv/GAk0Yv/0MlOewwu09tsDyowI6eFugj4IE=;
        b=XM3WVouUUyi3OsiKHMLoZGhDlD8UOSRWDvOIwgegRFxvqv4iNhDO5GMaWLwKGulqt5
         EbpkAAi7b4ODJ7YBgP3Ckjh81cANqks//y2K4MlhHAMXcytnz7yiN/oemw0CmomacgUC
         moLomKCihl6Sre0MrP7rwaYY2wZvzTlkqGdw/XyT0VynuEz8KiZVAC6W7m0k3dCpGFu/
         WOr5nSAY9dEtKqHlG+waA8xedox02STq872+ppww5XWD0qaWxQTmrnmNuAvgA261KEi/
         PZce3EeiDWQPC4Mw0ANL1gMbEu6LRoKd3b4pkObgL0xNlvNo5e1EBV9WgNK9T1sbUVNC
         O6zA==
X-Gm-Message-State: AOAM531LNkTI25IZPpTEVKSWfCb9y/AGRAhPEd6Q38NsEXlazoXoPbJL
        ZrZsSnA2tJa7ZCXJmKVvDXUcYqafltKcAg==
X-Google-Smtp-Source: ABdhPJzTE7pntVJyyBJMuK8Zad1QU+npA167vL9Gn3k5JVzuS3RQ8McBLkusRJOf3m+Q/CxwJoi0pA==
X-Received: by 2002:a05:6000:cd:: with SMTP id q13mr3253430wrx.346.1617788539586;
        Wed, 07 Apr 2021 02:42:19 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:f010:41b1:90b3:8d83])
        by smtp.gmail.com with ESMTPSA id n6sm6760066wrt.22.2021.04.07.02.42.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Apr 2021 02:42:18 -0700 (PDT)
Date:   Wed, 7 Apr 2021 11:42:17 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <20210407094217.GA2926@vingu-book>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 07 avril 2021 à 09:17:18 (+0200), Peter Zijlstra a écrit :
> On Tue, Apr 06, 2021 at 11:26:37AM -0400, Rik van Riel wrote:
> > I would be happy to pull the static branch out of select_idle_smt()
> > and place it into this if condition, though. You are right that
> > would save some overhead on non-smt systems.
> > 
> > Peter, would you prefer a follow-up patch for that or a version 4
> > of the patch?
> 
> Sorry, I was side-tracked with that core scheduling crap.. Something
> like the below then?
> 
> (Also fixed that stray line-wrap)
> 
> ---
> Subject: sched/fair: Bring back select_idle_smt(), but differently
> From: Rik van Riel <riel@surriel.com>
> Date: Fri, 26 Mar 2021 15:19:32 -0400
> 
> From: Rik van Riel <riel@surriel.com>
> 
> Mel Gorman did some nice work in 9fe1f127b913 ("sched/fair: Merge
> select_idle_core/cpu()"), resulting in the kernel being more efficient
> at finding an idle CPU, and in tasks spending less time waiting to be
> run, both according to the schedstats run_delay numbers, and according
> to measured application latencies. Yay.
> 
> The flip side of this is that we see more task migrations (about 30%
> more), higher cache misses, higher memory bandwidth utilization, and
> higher CPU use, for the same number of requests/second.
> 
> This is most pronounced on a memcache type workload, which saw a
> consistent 1-3% increase in total CPU use on the system, due to those
> increased task migrations leading to higher L2 cache miss numbers, and
> higher memory utilization. The exclusive L3 cache on Skylake does us
> no favors there.
> 
> On our web serving workload, that effect is usually negligible.
> 
> It appears that the increased number of CPU migrations is generally a
> good thing, since it leads to lower cpu_delay numbers, reflecting the
> fact that tasks get to run faster. However, the reduced locality and
> the corresponding increase in L2 cache misses hurts a little.
> 
> The patch below appears to fix the regression, while keeping the
> benefit of the lower cpu_delay numbers, by reintroducing
> select_idle_smt with a twist: when a socket has no idle cores, check
> to see if the sibling of "prev" is idle, before searching all the
> other CPUs.
> 
> This fixes both the occasional 9% regression on the web serving
> workload, and the continuous 2% CPU use regression on the memcache
> type workload.
> 
> With Mel's patches and this patch together, task migrations are still
> high, but L2 cache misses, memory bandwidth, and CPU time used are
> back down to what they were before. The p95 and p99 response times for
> the memcache type application improve by about 10% over what they were
> before Mel's patches got merged.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20210326151932.2c187840@imladris.surriel.com
> ---
>  kernel/sched/fair.c |   39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6112,6 +6112,27 @@ static int select_idle_core(struct task_
>  	return -1;
>  }
>  
> +/*
> + * Scan the local SMT mask for idle CPUs.
> + */
> +static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	int cpu;
> +
> +	if (!static_branch_likely(&sched_smt_present))
> +		return -1;
> +
> +	for_each_cpu(cpu, cpu_smt_mask(target)) {
> +		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
> +		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
> +			continue;
> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +			return cpu;
> +	}
> +
> +	return -1;
> +}
> +
>  #else /* CONFIG_SCHED_SMT */
>  
>  static inline void set_idle_cores(int cpu, int val)
> @@ -6128,6 +6149,11 @@ static inline int select_idle_core(struc
>  	return __select_idle_cpu(core);
>  }
>  
> +static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> +{
> +	return -1;
> +}
> +
>  #endif /* CONFIG_SCHED_SMT */
>  
>  /*
> @@ -6135,7 +6161,7 @@ static inline int select_idle_core(struc
>   * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>   * average idle time for this rq (as found in rq->avg_idle).
>   */
> -static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
> +static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int prev, int target)
>  {
>  	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>  	int i, cpu, idle_cpu = -1, nr = INT_MAX;
> @@ -6148,6 +6174,15 @@ static int select_idle_cpu(struct task_s
>  	if (!this_sd)
>  		return -1;
>  
> +	/* If we have SMT but there are no idle cores */
> +	if (static_branch_likely(&sched_smt_presernt) && !smt) {
> +		if (cpus_share_cache(prev, target)) {
> +			i = select_idle_smt(p, sd, prev);
> +			if ((unsigned int)i < nr_cpumask_bits)
> +				return i;
> +		}
> +	}
> +
>  	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>  
>  	if (sched_feat(SIS_PROP) && !smt) {
> @@ -6321,7 +6356,7 @@ static int select_idle_sibling(struct ta
>  	if (!sd)
>  		return target;
>  
> -	i = select_idle_cpu(p, sd, target);
> +	i = select_idle_cpu(p, sd, prev, target);
>  	if ((unsigned)i < nr_cpumask_bits)
>  		return i;

I would really prefer to keep that out of select_idle_cpu which aims to merge in one
single loop the walk through sd_llc. In the case of select_idle_smt, this is done outside
the loop:

I would prefer the below which also removed a number of useless and duplicated static_branch_likely(&sched_smt_presernt) in test_idle_cores and select_idle_smt

---
 kernel/sched/fair.c | 48 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdbb2d40..01d0bacedc8d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6038,11 +6038,9 @@ static inline bool test_idle_cores(int cpu, bool def)
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
@@ -6112,6 +6110,25 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 	return -1;
 }
 
+/*
+ * Scan the local SMT mask for idle CPUs.
+ */
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int
+target)
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
@@ -6128,6 +6145,11 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
 	return __select_idle_cpu(core);
 }
 
+static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
+{
+	return -1;
+}
+
 #endif /* CONFIG_SCHED_SMT */
 
 /*
@@ -6135,11 +6157,10 @@ static inline int select_idle_core(struct task_struct *p, int core, struct cpuma
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool smt, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu = -1, nr = INT_MAX;
-	bool smt = test_idle_cores(target, false);
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
 	u64 time;
@@ -6242,6 +6263,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
+	bool smt = false;
 	struct sched_domain *sd;
 	unsigned long task_util;
 	int i, recent_used_cpu;
@@ -6317,11 +6339,21 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		}
 	}
 
+	if (static_branch_likely(&sched_smt_present)) {
+		smt = test_idle_cores(target, false);
+		if (!smt && cpus_share_cache(prev, target)) {
+			/* No idle core. Check if prev has an idle sibling. */
+			i = select_idle_smt(p, sd, prev);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
 
-	i = select_idle_cpu(p, sd, target);
+	i = select_idle_cpu(p, sd, smt, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
2.17.1

>  
