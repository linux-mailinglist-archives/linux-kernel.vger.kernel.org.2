Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D55A3261FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhBZL0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:26:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:60192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhBZL0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:26:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614338733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBpwkpRBjPYpONcCK58de+e0K3J8PANk86L4naG0G9s=;
        b=CmgA5SqQRgJjLlCBNtTU6SqjdTiGNVbTLRjQQ+HkAOfR1m2eg8NY2NKb7lbh1h/MLSpqHt
        FYRlygxv+nCOK87b3iUZS1LU8PfYrNFtEvTt0NMVlvR6GehKh6B13mX7tl6zU0UGdvaHVW
        mhCy4/tPNupQpoZiU2ILv/PmjD201P4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F983B004;
        Fri, 26 Feb 2021 11:25:33 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@kernel.org, mhocko@suse.com,
        Juergen Gross <jgross@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/3] kernel/smp: add more data to CSD lock debugging
Date:   Fri, 26 Feb 2021 12:25:21 +0100
Message-Id: <20210226112521.8641-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210226112521.8641-1-jgross@suse.com>
References: <20210226112521.8641-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to help identifying problems with IPI handling and remote
function execution add some more data to IPI debugging code.

There have been multiple reports of cpus looping long times (many
seconds) in smp_call_function_many() waiting for another cpu executing
a function like tlb flushing. Most of these reports have been for
cases where the kernel was running as a guest on top of KVM or Xen
(there are rumours of that happening under VMWare, too, and even on
bare metal).

Finding the root cause hasn't been successful yet, even after more than
2 years of chasing this bug by different developers.

Commit 35feb60474bf4f7 ("kernel/smp: Provide CSD lock timeout
diagnostics") tried to address this by adding some debug code and by
issuing another IPI when a hang was detected. This helped mitigating
the problem (the repeated IPI unlocks the hang), but the root cause is
still unknown.

Current available data suggests that either an IPI wasn't sent when it
should have been, or that the IPI didn't result in the target cpu
executing the queued function (due to the IPI not reaching the cpu,
the IPI handler not being called, or the handler not seeing the queued
request).

Try to add more diagnostic data by introducing a global atomic counter
which is being incremented when doing critical operations (before and
after queueing a new request, when sending an IPI, and when dequeueing
a request). The counter value is stored in percpu variables which can
be printed out when a hang is detected.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 kernel/smp.c                                  | 143 +++++++++++++++++-
 2 files changed, 144 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index af9749b866c2..89da345ec8f1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -789,6 +789,10 @@
 			printed to the console in case a hanging cpu is
 			detected and that cpu is pinged again in order to try
 			to resolve the hang situation.
+			0: disable csdlock debugging (default)
+			1: enable basic csdlock debugging (minor impact)
+			ext: enable extended csdlock debugging (more impact,
+			     but more data)
 
 	dasd=		[HW,NET]
 			See header of drivers/s390/block/dasd_devmap.c.
diff --git a/kernel/smp.c b/kernel/smp.c
index 6d7e6dbe33dc..0d6a6a802fd1 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -31,8 +31,44 @@
 
 #define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+union cfd_seq_cnt {
+	u64		val;
+	struct {
+		u64	src:16;
+		u64	dst:16;
+#define CFD_SEQ_NOCPU	0xffff
+		u64	type:4;
+#define CFD_SEQ_QUEUE	0
+#define CFD_SEQ_IPI	1
+#define CFD_SEQ_NOIPI	2
+#define CFD_SEQ_PING	3
+#define CFD_SEQ_PINGED	4
+#define CFD_SEQ_HANDLE	5
+#define CFD_SEQ_DEQUEUE	6
+#define CFD_SEQ_IDLE	7
+#define CFD_SEQ_GOTIPI	8
+		u64	cnt:28;
+	}		u;
+};
+
+struct cfd_seq_local {
+	u64	ping;
+	u64	pinged;
+	u64	handle;
+	u64	dequeue;
+	u64	idle;
+	u64	gotipi;
+};
+#endif
+
 struct cfd_percpu {
 	call_single_data_t	csd;
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+	u64	seq_queue;
+	u64	seq_ipi;
+	u64	seq_noipi;
+#endif
 };
 
 struct call_function_data {
@@ -108,12 +144,18 @@ void __init call_function_init(void)
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
+static DEFINE_STATIC_KEY_FALSE(csdlock_debug_extended);
 
 static int __init csdlock_debug(char *str)
 {
 	unsigned int val = 0;
 
-	get_option(&str, &val);
+	if (str && !strcmp(str, "ext")) {
+		val = 1;
+		static_branch_enable(&csdlock_debug_extended);
+	} else
+		get_option(&str, &val);
+
 	if (val)
 		static_branch_enable(&csdlock_debug_enabled);
 
@@ -124,9 +166,33 @@ early_param("csdlock_debug", csdlock_debug);
 static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
 static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
+static DEFINE_PER_CPU(struct cfd_seq_local, cfd_seq_local);
 
 #define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
+static u64 cfd_seq;
+
+static u64 cfd_seq_inc(unsigned int src, unsigned int dst, unsigned int type)
+{
+	union cfd_seq_cnt new, old;
+
+	new.u.src = src;
+	new.u.dst = dst;
+	new.u.type = type;
+
+	do {
+		old.val = READ_ONCE(cfd_seq);
+		new.u.cnt = old.u.cnt + 1;
+	} while (cmpxchg(&cfd_seq, old.val, new.val) != old.val);
+
+	return old.val;
+}
+
+#define cfd_seq_store(var, src, dst, type)				\
+	do {								\
+		if (static_branch_unlikely(&csdlock_debug_extended))	\
+			var = cfd_seq_inc(src, dst, type);		\
+	} while (0)
 
 /* Record current CSD work for current CPU, NULL to erase. */
 static void __csd_lock_record(call_single_data_t *csd)
@@ -160,6 +226,24 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
 	return -1;
 }
 
+static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
+{
+	struct cfd_seq_local *seq = &per_cpu(cfd_seq_local, cpu);
+	unsigned int srccpu = csd->node.src;
+	struct call_function_data *cfd = per_cpu_ptr(&cfd_data, srccpu);
+	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
+
+	pr_alert("\tcsd: CPU#%d->CPU#%d%s: queue=%016llx, ipi=%016llx, noipi=%016llx\n",
+		 srccpu, cpu,
+		 (srccpu != raw_smp_processor_id()) ? " (might be stale)" : "",
+		 pcpu->seq_queue, pcpu->seq_ipi, pcpu->seq_noipi);
+	pr_alert("\tcsd: CSD source CPU#%d: ping=%016llx, pinged=%016llx\n", srccpu,
+		 per_cpu(cfd_seq_local.ping, srccpu),
+		 per_cpu(cfd_seq_local.pinged, srccpu));
+	pr_alert("\tcsd: CSD target CPU#%d: idle=%016llx, gotipi=%016llx, handle=%016llx, dequeue=%016llx\n",
+		 cpu, seq->idle, seq->gotipi, seq->handle, seq->dequeue);
+}
+
 /*
  * Complain if too much time spent waiting.  Note that only
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
@@ -209,6 +293,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
 	}
 	if (cpu >= 0) {
+		if (static_branch_unlikely(&csdlock_debug_extended))
+			csd_lock_print_extended(csd, cpu);
 		if (!trigger_single_cpu_backtrace(cpu))
 			dump_cpu_task(cpu);
 		if (!cpu_cur_csd) {
@@ -252,7 +338,27 @@ static __always_inline void csd_lock_wait(call_single_data_t *csd)
 
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
+
+static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
+{
+	unsigned int this_cpu = smp_processor_id();
+	struct cfd_seq_local *seq = this_cpu_ptr(&cfd_seq_local);
+	struct call_function_data *cfd = this_cpu_ptr(&cfd_data);
+	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
+
+	cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
+	if (llist_add(node, &per_cpu(call_single_queue, cpu))) {
+		cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
+		cfd_seq_store(seq->ping, this_cpu, cpu, CFD_SEQ_PING);
+		send_call_function_single_ipi(cpu);
+		cfd_seq_store(seq->pinged, this_cpu, cpu, CFD_SEQ_PINGED);
+	} else {
+		cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
+	}
+}
 #else
+#define cfd_seq_store(var, src, dst, type)
+
 static void csd_lock_record(call_single_data_t *csd)
 {
 }
@@ -290,6 +396,19 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
 void __smp_call_single_queue(int cpu, struct llist_node *node)
 {
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+	if (static_branch_unlikely(&csdlock_debug_extended)) {
+		unsigned int type;
+
+		type = CSD_TYPE(container_of(node, call_single_data_t,
+					     node.llist));
+		if (type == CSD_TYPE_SYNC || type == CSD_TYPE_ASYNC) {
+			__smp_call_single_queue_debug(cpu, node);
+			return;
+		}
+	}
+#endif
+
 	/*
 	 * The list addition should be visible before sending the IPI
 	 * handler locks the list to pull the entry off it because of
@@ -348,6 +467,8 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
  */
 void generic_smp_call_function_single_interrupt(void)
 {
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->gotipi, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_GOTIPI);
 	flush_smp_call_function_queue(true);
 }
 
@@ -375,7 +496,11 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	lockdep_assert_irqs_disabled();
 
 	head = this_cpu_ptr(&call_single_queue);
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->handle, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_HANDLE);
 	entry = llist_del_all(head);
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->dequeue, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_DEQUEUE);
 	entry = llist_reverse_order(entry);
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
@@ -482,6 +607,8 @@ void flush_smp_call_function_from_idle(void)
 	if (llist_empty(this_cpu_ptr(&call_single_queue)))
 		return;
 
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_IDLE);
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
 	if (local_softirq_pending())
@@ -698,7 +825,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	cpumask_clear(cfd->cpumask_ipi);
 	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
+		struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
+		call_single_data_t *csd = &pcpu->csd;
 
 		if (cond_func && !cond_func(cpu, info))
 			continue;
@@ -712,12 +840,21 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		csd->node.src = smp_processor_id();
 		csd->node.dst = cpu;
 #endif
-		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
+		cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
+		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
+			cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
+		} else {
+			cfd_seq_store(pcpu->seq_noipi, this_cpu, cpu, CFD_SEQ_NOIPI);
+		}
 	}
 
 	/* Send a message to all CPUs in the map */
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->ping, this_cpu,
+		      CFD_SEQ_NOCPU, CFD_SEQ_PING);
 	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu,
+		      CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 
 	if (wait) {
 		for_each_cpu(cpu, cfd->cpumask) {
-- 
2.26.2

