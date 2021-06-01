Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D905F396D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhFAGyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 02:54:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63636 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233040AbhFAGx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:53:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1516WfiD062862;
        Tue, 1 Jun 2021 02:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NCXEv/aJngQFqigRMlTYy/jGouLUt4CcN6irCoZTFks=;
 b=Aoz0U80ox2mdfo9DTxGA/ZkEROXNX3udO2HLwzgKkmijcRmiDztqEBy6aR+l8AbzgCNB
 h1M/uxbkoU7/k5Vg4PTsUvv1ROpxvhxjgf8ID/peJbK6c5Kx6e3n/vyO9FlT+T5bUTnS
 qrx/3MY8DelAjHULzp0DmfaEi0DqWGrsQXQnD6FsY5q2a2+WGTI7N6as5Vnxpqebxxng
 T7wjtRCPOQ7bCaj03UzQZUu6DDH7ufZ4oDVBzn8Y3A2SFOGnewWydShCWuA7rkxQF+yK
 2Y4SIBACvct8XrloyPhLOQTiUZDsHlE2xWH0GF56fA7u04HXz+cu0SDjs4YtWb6aBwJi 3w== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38wfebrvc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 02:52:10 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1516lKVd002991;
        Tue, 1 Jun 2021 06:52:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 38ud880syf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 06:52:08 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1516q5k429622596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 06:52:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62A5311C058;
        Tue,  1 Jun 2021 06:52:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F020F11C04C;
        Tue,  1 Jun 2021 06:52:02 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.77.195.136])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Jun 2021 06:52:02 +0000 (GMT)
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, aneesh.kumar@linux.ibm.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        amakhalov@vmware.com, guro@fb.com, vbabka@suse.cz,
        srikar@linux.vnet.ibm.com, psampat@linux.ibm.com,
        ego@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.ibm.com>
Subject: [RFC PATCH v0 3/3] percpu: Avoid using percpu ptrs of non-existing cpus
Date:   Tue,  1 Jun 2021 12:21:47 +0530
Message-Id: <20210601065147.53735-4-bharata@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601065147.53735-1-bharata@linux.ibm.com>
References: <20210601065147.53735-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9qBE326RlfhVU4tKbSkqGRoEShEeAk3v
X-Proofpoint-GUID: 9qBE326RlfhVU4tKbSkqGRoEShEeAk3v
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_03:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent the callers of alloc_percpu() from using the percpu
pointer of non-existing CPUs. Also switch those callers who
require initialization of percpu data for onlined CPU to use
the new variant alloc_percpu_cb()

Note: Not all callers have been modified here

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 fs/namespace.c           |  4 ++--
 kernel/cgroup/rstat.c    | 20 ++++++++++++++++----
 kernel/sched/cpuacct.c   | 10 +++++-----
 kernel/sched/psi.c       | 14 +++++++++++---
 lib/percpu-refcount.c    |  4 ++--
 lib/percpu_counter.c     |  2 +-
 net/ipv4/fib_semantics.c |  2 +-
 net/ipv6/route.c         |  6 +++---
 8 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c3f1a78ba369..b6ea584b99e5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -182,7 +182,7 @@ int mnt_get_count(struct mount *mnt)
 	int count = 0;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		count += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_count;
 	}
 
@@ -294,7 +294,7 @@ static unsigned int mnt_get_writers(struct mount *mnt)
 	unsigned int count = 0;
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		count += per_cpu_ptr(mnt->mnt_pcp, cpu)->mnt_writers;
 	}
 
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index cee265cb535c..b25c59138c0b 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -152,7 +152,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_sleep)
 
 	lockdep_assert_held(&cgroup_rstat_lock);
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock,
 						       cpu);
 		struct cgroup *pos = NULL;
@@ -245,19 +245,31 @@ void cgroup_rstat_flush_release(void)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+static int cgroup_rstat_cpuhp_handler(void __percpu *ptr, unsigned int cpu, void *data)
+{
+	struct cgroup *cgrp = (struct cgroup *)data;
+	struct cgroup_rstat_cpu *rstatc = per_cpu_ptr(ptr, cpu);
+
+	rstatc->updated_children = cgrp;
+	u64_stats_init(&rstatc->bsync);
+	return 0;
+}
+
 int cgroup_rstat_init(struct cgroup *cgrp)
 {
 	int cpu;
 
 	/* the root cgrp has rstat_cpu preallocated */
 	if (!cgrp->rstat_cpu) {
-		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		cgrp->rstat_cpu = alloc_percpu_cb(struct cgroup_rstat_cpu,
+						  cgroup_rstat_cpuhp_handler,
+						  cgrp);
 		if (!cgrp->rstat_cpu)
 			return -ENOMEM;
 	}
 
 	/* ->updated_children list is self terminated */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 
 		rstatc->updated_children = cgrp;
@@ -274,7 +286,7 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 	cgroup_rstat_flush(cgrp);
 
 	/* sanity check */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 
 		if (WARN_ON_ONCE(rstatc->updated_children != cgrp) ||
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 104a1bade14f..81dd53387ba5 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -160,7 +160,7 @@ static u64 __cpuusage_read(struct cgroup_subsys_state *css,
 	u64 totalcpuusage = 0;
 	int i;
 
-	for_each_possible_cpu(i)
+	for_each_online_cpu(i)
 		totalcpuusage += cpuacct_cpuusage_read(ca, i, index);
 
 	return totalcpuusage;
@@ -195,7 +195,7 @@ static int cpuusage_write(struct cgroup_subsys_state *css, struct cftype *cft,
 	if (val)
 		return -EINVAL;
 
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		cpuacct_cpuusage_write(ca, cpu, 0);
 
 	return 0;
@@ -208,7 +208,7 @@ static int __cpuacct_percpu_seq_show(struct seq_file *m,
 	u64 percpu;
 	int i;
 
-	for_each_possible_cpu(i) {
+	for_each_online_cpu(i) {
 		percpu = cpuacct_cpuusage_read(ca, i, index);
 		seq_printf(m, "%llu ", (unsigned long long) percpu);
 	}
@@ -242,7 +242,7 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 		seq_printf(m, " %s", cpuacct_stat_desc[index]);
 	seq_puts(m, "\n");
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct cpuacct_usage *cpuusage = per_cpu_ptr(ca->cpuusage, cpu);
 
 		seq_printf(m, "%d", cpu);
@@ -275,7 +275,7 @@ static int cpuacct_stats_show(struct seq_file *sf, void *v)
 	int stat;
 
 	memset(val, 0, sizeof(val));
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		u64 *cpustat = per_cpu_ptr(ca->cpustat, cpu)->cpustat;
 
 		val[CPUACCT_STAT_USER]   += cpustat[CPUTIME_USER];
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3cff41f..228977aa4780 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -186,7 +186,7 @@ static void group_init(struct psi_group *group)
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
 	group->avg_next_update = group->avg_last_update + psi_period;
@@ -321,7 +321,7 @@ static void collect_percpu_times(struct psi_group *group,
 	 * the sampling period. This eliminates artifacts from uneven
 	 * loading, or even entirely idle CPUs.
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		u32 times[NR_PSI_STATES];
 		u32 nonidle;
 		u32 cpu_changed_states;
@@ -935,12 +935,20 @@ void psi_memstall_leave(unsigned long *flags)
 }
 
 #ifdef CONFIG_CGROUPS
+static int psi_cpuhp_handler(void __percpu *ptr, unsigned int cpu, void *unused)
+{
+	struct psi_group_cpu *groupc = per_cpu_ptr(ptr, cpu);
+
+	seqcount_init(&groupc->seq);
+	return 0;
+}
+
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
+	cgroup->psi.pcpu = alloc_percpu_cb(struct psi_group_cpu, psi_cpuhp_handler, NULL);
 	if (!cgroup->psi.pcpu)
 		return -ENOMEM;
 	group_init(&cgroup->psi);
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index a1071cdefb5a..aeba43c33600 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -173,7 +173,7 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	unsigned long count = 0;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		count += *per_cpu_ptr(percpu_count, cpu);
 
 	pr_debug("global %lu percpu %lu\n",
@@ -253,7 +253,7 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 	 * zeroing is visible to all percpu accesses which can see the
 	 * following __PERCPU_REF_ATOMIC clearing.
 	 */
-	for_each_possible_cpu(cpu)
+	for_each_online_cpu(cpu)
 		*per_cpu_ptr(percpu_count, cpu) = 0;
 
 	smp_store_release(&ref->percpu_count_ptr,
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index ed610b75dc32..db40abc6f0f5 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -63,7 +63,7 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&fbc->lock, flags);
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		*pcount = 0;
 	}
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index a632b66bc13a..dbfd14b0077f 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -194,7 +194,7 @@ static void rt_fibinfo_free_cpus(struct rtable __rcu * __percpu *rtp)
 	if (!rtp)
 		return;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct rtable *rt;
 
 		rt = rcu_dereference_protected(*per_cpu_ptr(rtp, cpu), 1);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index a22822bdbf39..e7db3a5fe5c5 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -165,7 +165,7 @@ static void rt6_uncached_list_flush_dev(struct net *net, struct net_device *dev)
 	if (dev == loopback_dev)
 		return;
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
 		struct rt6_info *rt;
 
@@ -3542,7 +3542,7 @@ void fib6_nh_release(struct fib6_nh *fib6_nh)
 	if (fib6_nh->rt6i_pcpu) {
 		int cpu;
 
-		for_each_possible_cpu(cpu) {
+		for_each_online_cpu(cpu) {
 			struct rt6_info **ppcpu_rt;
 			struct rt6_info *pcpu_rt;
 
@@ -6569,7 +6569,7 @@ int __init ip6_route_init(void)
 #endif
 #endif
 
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		struct uncached_list *ul = per_cpu_ptr(&rt6_uncached_list, cpu);
 
 		INIT_LIST_HEAD(&ul->head);
-- 
2.31.1

