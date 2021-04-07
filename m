Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D23356516
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbhDGHSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbhDGHSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:18:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07218C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 00:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Evg2XwAOvha2xlDj30kwfXHj5dszfymtOlIHI8fiTc0=; b=cLyB0t6dbUv9FZHwC4q6QQpCAo
        hY8llbXfxejiC7zook3BBZpxv/pHAn5n+4hKTUQ0sruSwERDq7+iIusoBs/w8LRBuiquYQNdTqY2z
        q12rvyyxo6R4LYA4RZt48pvwR/dv5M2C+fycKiSJdq3HN7kg+RSrGRkovr90a3SmE77CR1VJtYLlg
        btYkHNI3sS9X5m77aa7A/6K8sGJpm6WvewNYH0xcKOasJEcar2H2KSFd8cLlsG0GMh8MBMivzpxyL
        1f5SztSdEUaU4hME5MA4Z4olyOWems4lSwSaodYXHwDP1MaQesN00jtCq/f1/lhIn+1xWWIH1nWzG
        wkMuJVPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU2RE-00E4ak-QQ; Wed, 07 Apr 2021 07:17:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 354623008B7;
        Wed,  7 Apr 2021 09:17:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0EAF24BF1B01; Wed,  7 Apr 2021 09:17:18 +0200 (CEST)
Date:   Wed, 7 Apr 2021 09:17:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:26:37AM -0400, Rik van Riel wrote:
> I would be happy to pull the static branch out of select_idle_smt()
> and place it into this if condition, though. You are right that
> would save some overhead on non-smt systems.
>=20
> Peter, would you prefer a follow-up patch for that or a version 4
> of the patch?

Sorry, I was side-tracked with that core scheduling crap.. Something
like the below then?

(Also fixed that stray line-wrap)

---
Subject: sched/fair: Bring back select_idle_smt(), but differently
=46rom: Rik van Riel <riel@surriel.com>
Date: Fri, 26 Mar 2021 15:19:32 -0400

=46rom: Rik van Riel <riel@surriel.com>

Mel Gorman did some nice work in 9fe1f127b913 ("sched/fair: Merge
select_idle_core/cpu()"), resulting in the kernel being more efficient
at finding an idle CPU, and in tasks spending less time waiting to be
run, both according to the schedstats run_delay numbers, and according
to measured application latencies. Yay.

The flip side of this is that we see more task migrations (about 30%
more), higher cache misses, higher memory bandwidth utilization, and
higher CPU use, for the same number of requests/second.

This is most pronounced on a memcache type workload, which saw a
consistent 1-3% increase in total CPU use on the system, due to those
increased task migrations leading to higher L2 cache miss numbers, and
higher memory utilization. The exclusive L3 cache on Skylake does us
no favors there.

On our web serving workload, that effect is usually negligible.

It appears that the increased number of CPU migrations is generally a
good thing, since it leads to lower cpu_delay numbers, reflecting the
fact that tasks get to run faster. However, the reduced locality and
the corresponding increase in L2 cache misses hurts a little.

The patch below appears to fix the regression, while keeping the
benefit of the lower cpu_delay numbers, by reintroducing
select_idle_smt with a twist: when a socket has no idle cores, check
to see if the sibling of "prev" is idle, before searching all the
other CPUs.

This fixes both the occasional 9% regression on the web serving
workload, and the continuous 2% CPU use regression on the memcache
type workload.

With Mel's patches and this patch together, task migrations are still
high, but L2 cache misses, memory bandwidth, and CPU time used are
back down to what they were before. The p95 and p99 response times for
the memcache type application improve by about 10% over what they were
before Mel's patches got merged.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210326151932.2c187840@imladris.surriel.com
---
 kernel/sched/fair.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6112,6 +6112,27 @@ static int select_idle_core(struct task_
 	return -1;
 }
=20
+/*
+ * Scan the local SMT mask for idle CPUs.
+ */
+static int select_idle_smt(struct task_struct *p, struct sched_domain *sd,=
 int target)
+{
+	int cpu;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -1;
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
=20
 static inline void set_idle_cores(int cpu, int val)
@@ -6128,6 +6149,11 @@ static inline int select_idle_core(struc
 	return __select_idle_cpu(core);
 }
=20
+static inline int select_idle_smt(struct task_struct *p, struct sched_doma=
in *sd, int target)
+{
+	return -1;
+}
+
 #endif /* CONFIG_SCHED_SMT */
=20
 /*
@@ -6135,7 +6161,7 @@ static inline int select_idle_core(struc
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against =
the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,=
 int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,=
 int prev, int target)
 {
 	struct cpumask *cpus =3D this_cpu_cpumask_var_ptr(select_idle_mask);
 	int i, cpu, idle_cpu =3D -1, nr =3D INT_MAX;
@@ -6148,6 +6174,15 @@ static int select_idle_cpu(struct task_s
 	if (!this_sd)
 		return -1;
=20
+	/* If we have SMT but there are no idle cores */
+	if (static_branch_likely(&sched_smt_presernt) && !smt) {
+		if (cpus_share_cache(prev, target)) {
+			i =3D select_idle_smt(p, sd, prev);
+			if ((unsigned int)i < nr_cpumask_bits)
+				return i;
+		}
+	}
+
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
=20
 	if (sched_feat(SIS_PROP) && !smt) {
@@ -6321,7 +6356,7 @@ static int select_idle_sibling(struct ta
 	if (!sd)
 		return target;
=20
-	i =3D select_idle_cpu(p, sd, target);
+	i =3D select_idle_cpu(p, sd, prev, target);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
=20
