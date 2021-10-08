Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A260F4263FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 07:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhJHFJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 01:09:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:41767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhJHFJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 01:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633669614;
        bh=6iaTpy2uq0pbufqko+SQ1GFIf29FtfHkK7hNKIno9tA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=RMV+N/vAFDHDZLsyr8PxAACcTYrmmQ7s+TEH0n22i1k6ONlxDF7nyNAzso2t+rEiz
         Bw/gBOrVhulvVnlj/I2tIAZdkzyFA+pLoiHNeWmcyyyFDtwS9PFFAXHpD2utJfdKjg
         g/mxlLP7SvAAbxFzpuqgW3OVFbcAusiYuYRufU2E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.132]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsZ3-1mZ14D08wJ-00HNK4; Fri, 08
 Oct 2021 07:06:54 +0200
Message-ID: <63057cf75e91bd0d348b5475ffab8e5a9f5d20f4.camel@gmx.de>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Barry Song <21cnbao@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Oct 2021 07:06:51 +0200
In-Reply-To: <20211005093137.GQ3959@techsingularity.net>
References: <20210920142614.4891-3-mgorman@techsingularity.net>
         <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
         <20210921103621.GM3959@techsingularity.net>
         <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
         <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
         <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
         <f1b421f956fa044b4efa7f5fef015725b27223cf.camel@gmx.de>
         <4f571c5c759b9d356d1bb4114fb169181194a780.camel@gmx.de>
         <20211005074719.GP3959@techsingularity.net>
         <ba1195a9843add64b38fce9ceb186c0c21ef5783.camel@gmx.de>
         <20211005093137.GQ3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YgWfgOHbC9EbgTcoDCcbTC64fNrL74BQrtrUo+bOXrHIbv/AlZk
 /qWeEUO0OWlhwU2uQoZuyuCmsRD2gyU9T0iT3iIlKHuNElaUE80FEsOEdetmSK/JGJeQNcR
 /HujCdpYwDIhMEF+oojwBEAolUXE67gMfB5p87YkKOF0WWnfNMioAD1wVIDCETEpdJG29PO
 EB8PZVRc8ZzpByzihww6g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FGGle0+gnss=:STLwywxg5xbYiCLyjNZ/co
 fpeSZL8fohFW/qDwALu0GevdsgKOOWxMQ8CzwdJ9O5QNeIt3j2LXYmYU/y9bfFAE4h3Nu4RxM
 WfTYgIgq2cAyw66SRb2JJnAdUziQrHxnOV7JDjHrIBjifRltWg3/Cf8SjOj7A1QVKMUH2QIRD
 w22eE6mSEjsT1hlTbsVL6wnw4fDYkeaxIAnuZHL7GO1oJxPUqcTnEwa9lkyukLp79kJYTLwB6
 7Qjdmqb+0sLriy/aHTzbAPm+KivBAp9hsApeLRZBqvEYfH4OnKlxxrfpzorE+P54pLODeJ2b6
 6J8JWkA23kt/cBPa/Eits0P/349d931K07hwpb/usGCNZg1GHwy4V19RRlhA6Ye4udtkZu35q
 hVJgOUBlsgOrHlOa8uoPzILxlwGgdKfuDHyeQOXp1rgqaK72c6W7ZOB85CYmOTE0E6ypSnz4n
 FSegUaEB46ta1ss1DIdCifeVmL+w56n1D9s+169z3dXqG1gpkynlZkLddfDbDDa2P53rqmG1b
 SHaUd3TahtznC8Wf8A2yV/uhCKI9BCeO3xpdNhHBEo34jGhe5clPnJ+fudGzADYxAliJauTeI
 ArQXLO/wj3JQ2Mkc2DC5JAkwYATNiotk1BuQCsz6731UlXa86RHZwwS/Tqs+R5IuVSjh/WK7g
 4CT5fbchnJtIMXgZCg+QS3z7jVoBs6JO2xgUSQzcvwVIfGjHjjvjDjmNuEE5tnHyhdMVK/G7g
 SddYwlYqKRMr5gyWzlVln7h8olzIzCG1A4WsSh7+aV7n0DneeMC37jl3xaOEPFwjrhPHHdZb5
 tBCztee7Bd/1MdvSJH+dwO9jfygdlbskR7R/bFDIFka/hqHr7P12lgk5ahq4rpRC9KM930Ifd
 BtzT5DFHtbj9XXwH8BDDNvA2cYVrA6xL2i220pm8CKvwU0/xlmz2wpN9i9BsmvCexEiR+j4ri
 kseEWeePs6+IcANXjnpwGZD/NrliKPpLGy0oOEZ+/kUfrIj/fapNkLJQszjkZ+tbmLvrSXWYO
 gpxpDffgzhKGJjhjq6sYCbTVJqM/sYcTrPEO692G0cnHeME24tHI46cyPEeQH4a+QCbTg5rpN
 LCwbJ/95g3HyDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-05 at 10:31 +0100, Mel Gorman wrote:
> Ideally, I would do some tracing to confirm that maximum runqueue depth
> is really reduced by the path.

I would expect your worst case to remain unchanged, mine does.  The
patch mitigates, it does not eradicate.

I dug up a late 2016 mitigation patch, wedged it into 2021 and added a
BFH that does eradicate my stacking depth woes.  I'll probably keep it,
at least for a while. Not because I feel anything in my desktop, rather
because meeting this again (and it being deeper than I recall) reminded
me of measuring impact on NFS etc, making it a tad difficult to ignore.
Oh well, I'll forget about it eventually.. BTDT.

(standard beloved Granny disclaimer)

sched: Add SIS stacking mitigation feature

Select the least loaded LLC CPU for cache cold tasks and kthreads.

Addendum: renamed feature, and give it a big brother.

Not-Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/fair.c     |   54 ++++++++++++++++++++++++++++++++++++++++++=
++----
 kernel/sched/features.h |    5 ++++
 2 files changed, 55 insertions(+), 4 deletions(-)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6261,6 +6261,26 @@ static inline int select_idle_smt(struct

 #endif /* CONFIG_SCHED_SMT */

+static bool task_is_kthread_or_cold(struct task_struct *p)
+{
+	s64 cold =3D sysctl_sched_migration_cost;
+
+	if (p->flags & PF_KTHREAD)
+		return true;
+	if (cold <=3D 0)
+		return false;
+	return task_rq(p)->clock_task - p->se.exec_start > cold;
+}
+
+static bool cpu_load_inconsistent(int cpu)
+{
+	struct rq *rq =3D cpu_rq(cpu);
+
+	if (rq->cfs.h_nr_running < 4)
+		return false;
+	return cpu_load(rq) << 2 < scale_load_down(rq->cfs.load.weight);
+}
+
 /*
  * Scan the LLC domain for idle CPUs; this is dynamically regulated by
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against=
 the
@@ -6269,7 +6289,7 @@ static inline int select_idle_smt(struct
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd=
, bool has_idle_core, int target)
 {
 	struct cpumask *cpus =3D this_cpu_cpumask_var_ptr(select_idle_mask);
-	int i, cpu, idle_cpu =3D -1, nr =3D INT_MAX;
+	int i, cpu, idle_cpu =3D -1, nr =3D INT_MAX, ld =3D -1;
 	struct rq *this_rq =3D this_rq();
 	int this =3D smp_processor_id();
 	struct sched_domain *this_sd;
@@ -6309,6 +6329,21 @@ static int select_idle_cpu(struct task_s
 		time =3D cpu_clock(this);
 	}

+	/*
+	 * Select the least loaded CPU for kthreads and cache cold tasks
+	 * if no idle CPU is found.
+	 */
+	if ((sched_feat(SIS_SPOT) && task_is_kthread_or_cold(p)) ||
+	    (sched_feat(SIS_REXY) && cpu_load_inconsistent(target))) {
+		idle_cpu =3D task_cpu(p);
+		if (idle_cpu !=3D target && !cpus_share_cache(idle_cpu, target))
+			idle_cpu =3D target;
+		if (unlikely(!sched_cpu_cookie_match(cpu_rq(idle_cpu), p)))
+			idle_cpu =3D -1;
+		else
+			ld =3D scale_load_down(cpu_rq(idle_cpu)->cfs.load.weight);
+	}
+
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i =3D select_idle_core(p, cpu, cpus, &idle_cpu);
@@ -6317,10 +6352,21 @@ static int select_idle_cpu(struct task_s

 		} else {
 			if (!--nr)
-				return -1;
-			idle_cpu =3D __select_idle_cpu(cpu, p);
-			if ((unsigned int)idle_cpu < nr_cpumask_bits)
+				return idle_cpu;
+			i =3D __select_idle_cpu(cpu, p);
+			if ((unsigned int)i < nr_cpumask_bits) {
+				idle_cpu =3D i;
 				break;
+			}
+		}
+		if (ld > 0 && sched_cpu_cookie_match(cpu_rq(cpu), p)) {
+			i =3D scale_load_down(cpu_rq(cpu)->cfs.load.weight);
+			if (i < ld) {
+				idle_cpu =3D cpu;
+				if (i =3D=3D 0)
+					break;
+				ld =3D i;
+			}
 		}
 	}

=2D-- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -95,3 +95,8 @@ SCHED_FEAT(LATENCY_WARN, false)

 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+/* Mitigate PELT induced stacking.  */
+SCHED_FEAT(SIS_SPOT, true)
+/* Spot's 12 ton big brother. */
+SCHED_FEAT(SIS_REXY, true)

