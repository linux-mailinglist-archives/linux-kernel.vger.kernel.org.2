Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE135495F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbhDEXmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241961AbhDEXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617666155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=NNHMSBQaRieLc4dNuOzG7rtghujWeXt8EkzxE1Qx9x8=;
        b=fxsVzKYOvz1xLAemMf4IAV+BrrkJ6MnGNE9ay+jRBKN+fDH0RBlTJPEOP2qydVzuM8B9ng
        elrgw/JZaGrpbkOjMNGnKoflDwzOGpfoIz3tYRznnqMMIQecnTBn3YGWL2rlbLuQEItEnT
        1UkOi/XHtO5tkTm6Tw81SGS5VRi7JCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-_gDRS--5PuuiTxGJtj2GlA-1; Mon, 05 Apr 2021 19:42:31 -0400
X-MC-Unique: _gDRS--5PuuiTxGJtj2GlA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C75A180FCA4;
        Mon,  5 Apr 2021 23:42:29 +0000 (UTC)
Received: from llong.com (ovpn-112-77.rdu2.redhat.com [10.10.112.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD54114108;
        Mon,  5 Apr 2021 23:42:14 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v4] sched/debug: Use sched_debug_lock to serialize use of cgroup_path[] only
Date:   Mon,  5 Apr 2021 19:42:03 -0400
Message-Id: <20210405234203.23526-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The handling of sysrq key can be activated by echoing the key to
/proc/sysrq-trigger or via the magic key sequence typed into a terminal
that is connected to the system in some way (serial, USB or other mean).
In the former case, the handling is done in a user context. In the
latter case, it is likely to be in an interrupt context.

There should be no more than one instance of sysrq key processing via
a terminal, but multiple instances of /proc/sysrq-trigger is possible.

Currently in print_cpu() of kernel/sched/debug.c, sched_debug_lock is
taken with interrupt disabled for the whole duration of the calls to
print_*_stats() and print_rq() which could last for the quite some time
if the information dump happens on the serial console.

If the system has many cpus and the sched_debug_lock is somehow busy
(e.g. parallel sysrq-t), the system may hit a hard lockup panic
depending on the actually serial console implementation of the
system. For instance,

[ 7809.796262] Kernel panic - not syncing: Hard LOCKUP
[ 7809.796264] CPU: 13 PID: 79867 Comm: reproducer.sh Kdump: loaded Tainted: G          I      --------- -  - 4.18.0-301.el8.x86_64 #1
[ 7809.796264] Hardware name: Dell Inc. PowerEdge R640/0W23H8, BIOS 1.4.9 06/29/2018
[ 7809.796265] Call Trace:
[ 7809.796265]  <NMI>
[ 7809.796266]  dump_stack+0x5c/0x80
[ 7809.796266]  panic+0xe7/0x2a9
[ 7809.796267]  nmi_panic.cold.9+0xc/0xc
[ 7809.796267]  watchdog_overflow_callback.cold.7+0x5c/0x70
[ 7809.796268]  __perf_event_overflow+0x52/0xf0
[ 7809.796268]  handle_pmi_common+0x204/0x2a0
[ 7809.796269]  ? __set_pte_vaddr+0x32/0x50
[ 7809.796269]  ? __native_set_fixmap+0x24/0x30
[ 7809.796270]  ? ghes_copy_tofrom_phys+0xd3/0x1c0
[ 7809.796271]  intel_pmu_handle_irq+0xbf/0x160
[ 7809.796271]  perf_event_nmi_handler+0x2d/0x50
[ 7809.796272]  nmi_handle+0x63/0x110
[ 7809.796272]  default_do_nmi+0x49/0x100
[ 7809.796273]  do_nmi+0x17e/0x1e0
[ 7809.796273]  end_repeat_nmi+0x16/0x6f
[ 7809.796274] RIP: 0010:native_queued_spin_lock_slowpath+0x5b/0x1d0
[ 7809.796275] Code: 6d f0 0f ba 2f 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 07 30 e4 09 d0 a9 00 01 ff ff 75 47 85 c0 74 0e 8b 07 84 c0 74 08 f3 90 <8b> 07 84 c0 75 f8 b8 01 00 00 00 66 89 07 c3 8b 37 81 fe 00 01 00
[ 7809.796276] RSP: 0018:ffffaa54cd887df8 EFLAGS: 00000002
[ 7809.796277] RAX: 0000000000000101 RBX: 0000000000000246 RCX: 0000000000000000
[ 7809.796278] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff936b66d0
[ 7809.796278] RBP: ffffffff9301fb40 R08: 0000000000000004 R09: 000000000000004f
[ 7809.796279] R10: 0000000000000000 R11: ffffaa54cd887cc0 R12: ffff907fd0a29ec0
[ 7809.796280] R13: 0000000000000000 R14: ffffffff926ab7c0 R15: 0000000000000000
[ 7809.796280]  ? native_queued_spin_lock_slowpath+0x5b/0x1d0
[ 7809.796281]  ? native_queued_spin_lock_slowpath+0x5b/0x1d0
[ 7809.796281]  </NMI>
[ 7809.796282]  _raw_spin_lock_irqsave+0x32/0x40
[ 7809.796283]  print_cpu+0x261/0x7c0
[ 7809.796283]  sysrq_sched_debug_show+0x34/0x50
[ 7809.796284]  sysrq_handle_showstate+0xc/0x20
[ 7809.796284]  __handle_sysrq.cold.11+0x48/0xfb
[ 7809.796285]  write_sysrq_trigger+0x2b/0x30
[ 7809.796285]  proc_reg_write+0x39/0x60
[ 7809.796286]  vfs_write+0xa5/0x1a0
[ 7809.796286]  ksys_write+0x4f/0xb0
[ 7809.796287]  do_syscall_64+0x5b/0x1a0
[ 7809.796287]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 7809.796288] RIP: 0033:0x7fabe4ceb648

The purpose of sched_debug_lock is to serialize the use of the global
cgroup_path[] buffer in print_cpu(). The rests of the printk calls don't
need serialization from sched_debug_lock.

Calling printk() with interrupt disabled can still be problematic if
multiple instances are running. Allocating a stack buffer of PATH_MAX
bytes is not feasible because of the limited size of the kernel stack.

The print_cpu() function has two callers - sched_debug_show() and
sysrq_sched_debug_show(). The solution implemented in this patch is to
allow all sched_debug_show() callers to contend for sched_debug_lock and
use the full size group_path[] as their SEQ_printf() calls will be much
faster. However only one sysrq_sched_debug_show() caller that output to
the slow console will be allowed to use group_path[]. Another parallel
console writer will have to use a shorter stack buffer instead. Since
the console output will be garbled anyway, truncation of some cgroup
paths shouldn't be a big issue.

Fixes: efe25c2c7b3a ("sched: Reinstate group names in /proc/sched_debug")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/debug.c | 54 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 486f403a778b..5d021b247998 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,8 +8,6 @@
  */
 #include "sched.h"
 
-static DEFINE_SPINLOCK(sched_debug_lock);
-
 /*
  * This allows printing both to /proc/sched_debug and
  * to the console
@@ -470,16 +468,49 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 #endif
 
 #ifdef CONFIG_CGROUP_SCHED
+static DEFINE_SPINLOCK(sched_debug_lock);
 static char group_path[PATH_MAX];
+static enum {
+	TOKEN_NONE,
+	TOKEN_ACQUIRED,
+	TOKEN_NA	/* Not applicable */
+} console_token = TOKEN_ACQUIRED;
 
-static char *task_group_path(struct task_group *tg)
+static void task_group_path(struct task_group *tg, char *path, int plen)
 {
-	if (autogroup_path(tg, group_path, PATH_MAX))
-		return group_path;
+	if (autogroup_path(tg, path, plen))
+		return;
 
-	cgroup_path(tg->css.cgroup, group_path, PATH_MAX);
+	cgroup_path(tg->css.cgroup, path, plen);
+}
 
-	return group_path;
+/*
+ * All the print_cpu() callers from sched_debug_show() will be allowed
+ * to contend for sched_debug_lock and use group_path[] as their SEQ_printf()
+ * calls will be much faster. However only one print_cpu() caller from
+ * sysrq_sched_debug_show() which outputs to the console will be allowed
+ * to use group_path[]. Another parallel console writer will have to use
+ * a shorter stack buffer instead. Since the console output will be garbled
+ * anyway, truncation of some cgroup paths shouldn't be a big issue.
+ */
+#define SEQ_printf_task_group_path(m, tg, fmt...)			\
+{									\
+	unsigned long flags;						\
+	int token = m ? TOKEN_NA					\
+		      : xchg_acquire(&console_token, TOKEN_NONE);	\
+									\
+	if (token == TOKEN_NONE) {					\
+		char buf[128];						\
+		task_group_path(tg, buf, sizeof(buf));			\
+		SEQ_printf(m, fmt, buf);				\
+	} else {							\
+		spin_lock_irqsave(&sched_debug_lock, flags);		\
+		task_group_path(tg, group_path, sizeof(group_path));	\
+		SEQ_printf(m, fmt, group_path);				\
+		spin_unlock_irqrestore(&sched_debug_lock, flags);	\
+		if (token == TOKEN_ACQUIRED)				\
+			smp_store_release(&console_token, token);	\
+	}								\
 }
 #endif
 
@@ -506,7 +537,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	SEQ_printf(m, " %s", task_group_path(task_group(p)));
+	SEQ_printf_task_group_path(m, task_group(p), " %s")
 #endif
 
 	SEQ_printf(m, "\n");
@@ -543,7 +574,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "cfs_rq[%d]:%s\n", cpu, task_group_path(cfs_rq->tg));
+	SEQ_printf_task_group_path(m, cfs_rq->tg, "cfs_rq[%d]:%s\n", cpu);
 #else
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
@@ -614,7 +645,7 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 {
 #ifdef CONFIG_RT_GROUP_SCHED
 	SEQ_printf(m, "\n");
-	SEQ_printf(m, "rt_rq[%d]:%s\n", cpu, task_group_path(rt_rq->tg));
+	SEQ_printf_task_group_path(m, rt_rq->tg, "rt_rq[%d]:%s\n", cpu);
 #else
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "rt_rq[%d]:\n", cpu);
@@ -666,7 +697,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long flags;
 
 #ifdef CONFIG_X86
 	{
@@ -717,13 +747,11 @@ do {									\
 	}
 #undef P
 
-	spin_lock_irqsave(&sched_debug_lock, flags);
 	print_cfs_stats(m, cpu);
 	print_rt_stats(m, cpu);
 	print_dl_stats(m, cpu);
 
 	print_rq(m, rq, cpu);
-	spin_unlock_irqrestore(&sched_debug_lock, flags);
 	SEQ_printf(m, "\n");
 }
 
-- 
2.18.1

