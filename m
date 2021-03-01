Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CF2327BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhCAKPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:15:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:42738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232077AbhCAKOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:14:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614593627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4hslT8KX8ZQaE9K4OhU6b2VZEmYPacWP8l76dYIkuk=;
        b=eENDup3F9Fns4o6qYgFYnm3XBhoj9BrCUJ/zgjGG+sYNWK4Xq2jkYiuOy0AXbWrMDTL7GI
        JKDipHcpfmS8Qa/VJlQtpzpRUDm3qGGPxBb5MeXhuqJuoPSP0jOeBYbUomqHCv3nK+F0Kd
        Pv5sqLFP6Hfn54hG3T7IfKCo+EkvQLY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6172B01E;
        Mon,  1 Mar 2021 10:13:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@kernel.org, mhocko@suse.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 3/3] kernel/smp: add more data to CSD lock debugging
Date:   Mon,  1 Mar 2021 11:13:36 +0100
Message-Id: <20210301101336.7797-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210301101336.7797-1-jgross@suse.com>
References: <20210301101336.7797-1-jgross@suse.com>
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

The data of the last event (consisting of sequence counter, source
cpu, target cpu, and event type) is stored in a global variable. When
a new event is to be traced, the data of the last event is stored in
the event related percpu location and the global data is updated with
the new event's data. This allows to track two events in one data
location: one by the value of the event data (the event before the
current one), and one by the location itself (the current event).

A typical printout with a detected hang will look like this:

csd: Detected non-responsive CSD lock (#1) on CPU#1, waiting 5000000003 ns for CPU#06 scf_handler_1+0x0/0x50(0xffffa2a881bb1410).
	csd: CSD lock (#1) handling prior scf_handler_1+0x0/0x50(0xffffa2a8813823c0) request.
        csd: cnt(00008cc): ffff->0000 dequeue (src cpu 0 == empty)
        csd: cnt(00008cd): ffff->0006 idle
        csd: cnt(0003668): 0001->0006 queue
        csd: cnt(0003669): 0001->0006 ipi
        csd: cnt(0003e0f): 0007->000a queue
        csd: cnt(0003e10): 0001->ffff ping
        csd: cnt(0003e71): 0003->0000 ping
        csd: cnt(0003e72): ffff->0006 gotipi
        csd: cnt(0003e73): ffff->0006 handle
        csd: cnt(0003e74): ffff->0006 dequeue (src cpu 0 == empty)
        csd: cnt(0003e7f): 0004->0006 ping
        csd: cnt(0003e80): 0001->ffff pinged
        csd: cnt(0003eb2): 0005->0001 noipi
        csd: cnt(0003eb3): 0001->0006 queue
        csd: cnt(0003eb4): 0001->0006 noipi
        csd: cnt now: 0003f00

The idea is to print only relevant entries. Those are all events which
are associated with the hang (so sender side events for the source cpu
of the hanging request, and receiver side events for the target cpu),
and the related events just before those (for adding data needed to
identify a possible race). Printing all available data would be
possible, but this would add large amounts of data printed on larger
configurations.

Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
V2:
- add automatic data deciphering and sorting of entries
- add new trace point for leaving flush_smp_call_function_queue()
- add information when finding an empty call_single_queue
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 kernel/smp.c                                  | 234 +++++++++++++++++-
 2 files changed, 234 insertions(+), 4 deletions(-)

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
index 6d7e6dbe33dc..94993cf19ba3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -31,8 +31,59 @@
 
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
+#define CFD_SEQ_HDLEND	9
+		u64	cnt:28;
+	}		u;
+};
+
+static char *seq_type[] = {
+	[CFD_SEQ_QUEUE]		= "queue",
+	[CFD_SEQ_IPI]		= "ipi",
+	[CFD_SEQ_NOIPI]		= "noipi",
+	[CFD_SEQ_PING]		= "ping",
+	[CFD_SEQ_PINGED]	= "pinged",
+	[CFD_SEQ_HANDLE]	= "handle",
+	[CFD_SEQ_DEQUEUE]	= "dequeue (src cpu 0 == empty)",
+	[CFD_SEQ_IDLE]		= "idle",
+	[CFD_SEQ_GOTIPI]	= "gotipi",
+	[CFD_SEQ_HDLEND]	= "hdlend (src cpu 0 == early)",
+};
+
+struct cfd_seq_local {
+	u64	ping;
+	u64	pinged;
+	u64	handle;
+	u64	dequeue;
+	u64	idle;
+	u64	gotipi;
+	u64	hdlend;
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
@@ -108,12 +159,18 @@ void __init call_function_init(void)
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
 
@@ -124,9 +181,34 @@ early_param("csdlock_debug", csdlock_debug);
 static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
 static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
+static DEFINE_PER_CPU(struct cfd_seq_local, cfd_seq_local);
 
 #define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
+static u64 cfd_seq;
+
+#define CFD_SEQ(s, d, t, c)	\
+	(union cfd_seq_cnt){ .u.src = s, .u.dst = d, .u.type = t, .u.cnt = c }
+
+static u64 cfd_seq_inc(unsigned int src, unsigned int dst, unsigned int type)
+{
+	union cfd_seq_cnt new, old;
+
+	new = CFD_SEQ(src, dst, type, 0);
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
@@ -160,6 +242,88 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
 	return -1;
 }
 
+static void cfd_seq_data_add(u64 val, unsigned int src, unsigned int dst,
+			     unsigned int type, union cfd_seq_cnt *data,
+			     unsigned int *n_data, unsigned int now)
+{
+	union cfd_seq_cnt new[2];
+	unsigned int i, j, k;
+
+	new[0].val = val;
+	new[1] = CFD_SEQ(src, dst, type, new[0].u.cnt + 1);
+
+	for (i = 0; i < 2; i++) {
+		if (new[i].u.cnt <= now)
+			new[i].u.cnt |= 0x80000000U;
+		for (j = 0; j < *n_data; j++) {
+			if (new[i].u.cnt == data[j].u.cnt) {
+				/* Direct read value trumps generated one. */
+				if (i == 0)
+					data[j].val = new[i].val;
+				break;
+			}
+			if (new[i].u.cnt < data[j].u.cnt) {
+				for (k = *n_data; k > j; k--)
+					data[k].val = data[k - 1].val;
+				data[j].val = new[i].val;
+				(*n_data)++;
+				break;
+			}
+		}
+		if (j == *n_data) {
+			data[j].val = new[i].val;
+			(*n_data)++;
+		}
+	}
+}
+
+static const char *csd_lock_get_type(unsigned int type)
+{
+	return (type >= ARRAY_SIZE(seq_type)) ? "?" : seq_type[type];
+}
+
+static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
+{
+	struct cfd_seq_local *seq = &per_cpu(cfd_seq_local, cpu);
+	unsigned int srccpu = csd->node.src;
+	struct call_function_data *cfd = per_cpu_ptr(&cfd_data, srccpu);
+	struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
+	unsigned int now;
+	union cfd_seq_cnt data[2 * ARRAY_SIZE(seq_type)];
+	unsigned int n_data = 0, i;
+
+	data[0].val = READ_ONCE(cfd_seq);
+	now = data[0].u.cnt;
+
+	cfd_seq_data_add(pcpu->seq_queue, srccpu, cpu,
+			 CFD_SEQ_QUEUE, data, &n_data, now);
+	cfd_seq_data_add(pcpu->seq_ipi, srccpu, cpu,
+			 CFD_SEQ_IPI, data, &n_data, now);
+	cfd_seq_data_add(pcpu->seq_noipi, srccpu, cpu,
+			 CFD_SEQ_NOIPI, data, &n_data, now);
+	cfd_seq_data_add(per_cpu(cfd_seq_local.ping, srccpu), srccpu,
+			 CFD_SEQ_NOCPU, CFD_SEQ_PING, data, &n_data, now);
+	cfd_seq_data_add(per_cpu(cfd_seq_local.pinged, srccpu), srccpu,
+			 CFD_SEQ_NOCPU, CFD_SEQ_PINGED, data, &n_data, now);
+	cfd_seq_data_add(seq->idle, CFD_SEQ_NOCPU, cpu,
+			 CFD_SEQ_IDLE, data, &n_data, now);
+	cfd_seq_data_add(seq->gotipi, CFD_SEQ_NOCPU, cpu,
+			 CFD_SEQ_GOTIPI, data, &n_data, now);
+	cfd_seq_data_add(seq->handle, CFD_SEQ_NOCPU, cpu,
+			 CFD_SEQ_HANDLE, data, &n_data, now);
+	cfd_seq_data_add(seq->dequeue, CFD_SEQ_NOCPU, cpu,
+			 CFD_SEQ_DEQUEUE, data, &n_data, now);
+	cfd_seq_data_add(seq->hdlend, CFD_SEQ_NOCPU, cpu,
+			 CFD_SEQ_HDLEND, data, &n_data, now);
+
+	for (i = 0; i < n_data; i++) {
+		pr_alert("\tcsd: cnt(%07x): %04x->%04x %s\n",
+			 data[i].u.cnt & ~0x80000000U, data[i].u.src,
+			 data[i].u.dst, csd_lock_get_type(data[i].u.type));
+	}
+	pr_alert("\tcsd: cnt now: %07x\n", now);
+}
+
 /*
  * Complain if too much time spent waiting.  Note that only
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
@@ -209,6 +373,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
 			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
 	}
 	if (cpu >= 0) {
+		if (static_branch_unlikely(&csdlock_debug_extended))
+			csd_lock_print_extended(csd, cpu);
 		if (!trigger_single_cpu_backtrace(cpu))
 			dump_cpu_task(cpu);
 		if (!cpu_cur_csd) {
@@ -252,7 +418,27 @@ static __always_inline void csd_lock_wait(call_single_data_t *csd)
 
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
@@ -290,6 +476,19 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
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
@@ -348,6 +547,8 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
  */
 void generic_smp_call_function_single_interrupt(void)
 {
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->gotipi, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_GOTIPI);
 	flush_smp_call_function_queue(true);
 }
 
@@ -375,7 +576,13 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	lockdep_assert_irqs_disabled();
 
 	head = this_cpu_ptr(&call_single_queue);
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->handle, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_HANDLE);
 	entry = llist_del_all(head);
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->dequeue,
+		      /* Special meaning of source cpu: 0 == queue empty */
+		      entry ? CFD_SEQ_NOCPU : 0,
+		      smp_processor_id(), CFD_SEQ_DEQUEUE);
 	entry = llist_reverse_order(entry);
 
 	/* There shouldn't be any pending callbacks on an offline CPU. */
@@ -434,8 +641,12 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 		}
 	}
 
-	if (!entry)
+	if (!entry) {
+		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->hdlend,
+			      0, smp_processor_id(),
+			      CFD_SEQ_HDLEND);
 		return;
+	}
 
 	/*
 	 * Second; run all !SYNC callbacks.
@@ -473,6 +684,9 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	 */
 	if (entry)
 		sched_ttwu_pending(entry);
+
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->hdlend, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_HDLEND);
 }
 
 void flush_smp_call_function_from_idle(void)
@@ -482,6 +696,8 @@ void flush_smp_call_function_from_idle(void)
 	if (llist_empty(this_cpu_ptr(&call_single_queue)))
 		return;
 
+	cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->idle, CFD_SEQ_NOCPU,
+		      smp_processor_id(), CFD_SEQ_IDLE);
 	local_irq_save(flags);
 	flush_smp_call_function_queue(true);
 	if (local_softirq_pending())
@@ -698,7 +914,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	cpumask_clear(cfd->cpumask_ipi);
 	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = &per_cpu_ptr(cfd->pcpu, cpu)->csd;
+		struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
+		call_single_data_t *csd = &pcpu->csd;
 
 		if (cond_func && !cond_func(cpu, info))
 			continue;
@@ -712,12 +929,21 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
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

