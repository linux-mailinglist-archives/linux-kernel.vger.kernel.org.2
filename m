Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2043D5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhJ0Vo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:44:26 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53356 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhJ0VoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:44:21 -0400
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 19RKhn5f001184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Oct 2021 13:43:56 -0700
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 13:43:33 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 13:43:33 -0700
Received: from yow-pgortmak-d1.wrs.com (128.224.56.57) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 13:43:32 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Frederic Weisbecker" <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 2/2] cpuset: add binding to CPU isolation
Date:   Wed, 27 Oct 2021 16:43:19 -0400
Message-ID: <20211027204319.22697-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211027204319.22697-1-paul.gortmaker@windriver.com>
References: <20211027204319.22697-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to put one or a group of cores into a set and then use
that set to control the core's isolation setting.

Currently the isolation only toggles RCU nocb, and note that a
limitation exists where you can only RCU toggle if you use a boot
arg to enable nocb offload at boot initially.  So the 1st offload
request of the subset in the cpuset are no-ops.

An example probably describes things the best:

root@hackbox:/sys/fs/cgroup/cpuset# cat /proc/cmdline
BOOT_IMAGE=/boot/bzImage rcu_nocbs=1-11 root=/dev/sda3 console=ttyS0,115200 ro
root@hackbox:/sys/fs/cgroup/cpuset# dmesg|grep Offload
[    0.154015] rcu:     Offload RCU callbacks from CPUs: 1-11.
root@hackbox:/sys/fs/cgroup/cpuset# mkdir cores4-6
root@hackbox:/sys/fs/cgroup/cpuset# cd cores4-6/
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# dmesg -c > /dev/null
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# echo 4-6 > cpuset.cpus
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# dmesg
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# echo 1 > cpuset.cpu_isolation
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# dmesg
[ 1021.217641] Isolating core 4
[ 1021.217650] Isolating core 5
[ 1021.217651] Isolating core 6
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# dmesg -c > /dev/null
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# echo 0 > cpuset.cpu_isolation
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# dmesg
[ 1050.589700] Deisolating core 4
[ 1050.589778] rcu: De-offloading 4
[ 1050.590001] Deisolating core 5
[ 1050.590065] rcu: De-offloading 5
[ 1050.590284] Deisolating core 6
[ 1050.590366] rcu: De-offloading 6
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# dmesg -c > /dev/null
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# echo 1 > cpuset.cpu_isolation
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6# dmesg
[ 1071.584802] Isolating core 4
[ 1071.584886] rcu: Offloading 4
[ 1071.585130] Isolating core 5
[ 1071.585203] rcu: Offloading 5
[ 1071.585448] Isolating core 6
[ 1071.585459] rcu: Offloading 6
root@hackbox:/sys/fs/cgroup/cpuset/cores4-6#

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
[PG: RFC code - not for merge]
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/cgroup/cpuset.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190c4429..4420bffcc232 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -209,6 +209,7 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 typedef enum {
 	CS_ONLINE,
 	CS_CPU_EXCLUSIVE,
+	CS_CPU_ISOLATED,
 	CS_MEM_EXCLUSIVE,
 	CS_MEM_HARDWALL,
 	CS_MEMORY_MIGRATE,
@@ -228,6 +229,11 @@ static inline int is_cpu_exclusive(const struct cpuset *cs)
 	return test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
 }
 
+static inline int is_cpu_isolated(const struct cpuset *cs)
+{
+	return test_bit(CS_CPU_ISOLATED, &cs->flags);
+}
+
 static inline int is_mem_exclusive(const struct cpuset *cs)
 {
 	return test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
@@ -1866,6 +1872,23 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
 	return 0;
 }
 
+/**
+ * update_isol_state - update isolated state for allowed cores
+ * @cs: the cpuset in which each core might need to be changed
+ *
+ */
+static void update_isol_state(struct cpuset *cs)
+{
+	struct cpumask *mask = cs->cpus_allowed;
+	int cpu, isolate = is_cpu_isolated(cs);
+
+	for_each_cpu(cpu, mask)
+		if (isolate)
+			isolate_cpu(cpu);
+		else
+			deisolate_cpu(cpu);
+}
+
 /**
  * update_tasks_flags - update the spread flags of tasks in the cpuset.
  * @cs: the cpuset in which each task's spread flags needs to be changed
@@ -1900,6 +1923,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	struct cpuset *trialcs;
 	int balance_flag_changed;
 	int spread_flag_changed;
+	int isol_flag_changed;
 	int err;
 
 	trialcs = alloc_trial_cpuset(cs);
@@ -1921,6 +1945,8 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
+	isol_flag_changed = (is_cpu_isolated(cs) != is_cpu_isolated(trialcs));
+
 	spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
 	spin_unlock_irq(&callback_lock);
@@ -1930,6 +1956,9 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 
 	if (spread_flag_changed)
 		update_tasks_flags(cs);
+
+	if (isol_flag_changed)
+		update_isol_state(cs);
 out:
 	free_cpuset(trialcs);
 	return err;
@@ -2264,6 +2293,7 @@ typedef enum {
 	FILE_EFFECTIVE_MEMLIST,
 	FILE_SUBPARTS_CPULIST,
 	FILE_CPU_EXCLUSIVE,
+	FILE_CPU_ISOLATED,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
 	FILE_SCHED_LOAD_BALANCE,
@@ -2293,6 +2323,9 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	case FILE_CPU_EXCLUSIVE:
 		retval = update_flag(CS_CPU_EXCLUSIVE, cs, val);
 		break;
+	case FILE_CPU_ISOLATED:
+		retval = update_flag(CS_CPU_ISOLATED, cs, val);
+		break;
 	case FILE_MEM_EXCLUSIVE:
 		retval = update_flag(CS_MEM_EXCLUSIVE, cs, val);
 		break;
@@ -2465,6 +2498,8 @@ static u64 cpuset_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 	switch (type) {
 	case FILE_CPU_EXCLUSIVE:
 		return is_cpu_exclusive(cs);
+	case FILE_CPU_ISOLATED:
+		return is_cpu_isolated(cs);
 	case FILE_MEM_EXCLUSIVE:
 		return is_mem_exclusive(cs);
 	case FILE_MEM_HARDWALL:
@@ -2595,6 +2630,13 @@ static struct cftype legacy_files[] = {
 		.private = FILE_CPU_EXCLUSIVE,
 	},
 
+	{
+		.name = "cpu_isolation",
+		.read_u64 = cpuset_read_u64,
+		.write_u64 = cpuset_write_u64,
+		.private = FILE_CPU_ISOLATED,
+	},
+
 	{
 		.name = "mem_exclusive",
 		.read_u64 = cpuset_read_u64,
-- 
2.15.0

