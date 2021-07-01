Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D23B97F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhGAVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234083AbhGAVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625173584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9yPwSKFMLSFalHu5G+DILMrBw2Fx6d/i+cmpDBn0LfY=;
        b=am5hKAOnL7hDWO2uxvSjpskMnSAZ/qEpDgzxbko69aql0uVRQk39oi2wZPpnTdhLM8DiWs
        R5EbrAFIcQ6hcAaL4EQFbK41+wwxfo1UL//goXo05BoI65UOlrtUinFAJCZKBfCWFwCHsS
        PBnYKdqao6rmXaLp7GMHtpU9TpYRlqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-KZEvQ8vHNQeZjQTWOMh1-A-1; Thu, 01 Jul 2021 17:06:21 -0400
X-MC-Unique: KZEvQ8vHNQeZjQTWOMh1-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87527CC625;
        Thu,  1 Jul 2021 21:06:20 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08F8960C13;
        Thu,  1 Jul 2021 21:06:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 2A5554179DC3; Thu,  1 Jul 2021 18:06:06 -0300 (-03)
Message-ID: <20210701210458.350881923@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 01 Jul 2021 18:03:39 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 3/5] mm: vmstat: optionally flush per-CPU vmstat counters on return to userspace
References: <20210701210336.358118649@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to disable vmstat worker thread, when entering
nohz full, does not cover all scenarios. For example, it is possible
for the following to happen:

1) enter nohz_full, which calls refresh_cpu_vm_stats, syncing the stats.
2) app runs mlock, which increases counters for mlock'ed pages.
3) start -RT loop

Since refresh_cpu_vm_stats from nohz_full logic can happen _before_
the mlock, vmstat shepherd can restart vmstat worker thread on 
the CPU in question.

To fix this, optionally sync the vmstat counters when returning
from userspace, controllable by a new "vmstat_sync" isolcpus 
flags (default off).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-vmstat-update/kernel/sched/isolation.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/sched/isolation.c
+++ linux-2.6-vmstat-update/kernel/sched/isolation.c
@@ -8,6 +8,7 @@
  *
  */
 #include "sched.h"
+#include <linux/vmstat.h>
 
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
@@ -129,6 +130,9 @@ static int __init housekeeping_setup(cha
 		}
 	}
 
+	if (flags & HK_FLAG_VMSTAT_SYNC)
+		static_branch_enable(&vmstat_sync_enabled);
+
 	housekeeping_flags |= flags;
 
 	free_bootmem_cpumask_var(non_housekeeping_mask);
Index: linux-2.6-vmstat-update/include/linux/vmstat.h
===================================================================
--- linux-2.6-vmstat-update.orig/include/linux/vmstat.h
+++ linux-2.6-vmstat-update/include/linux/vmstat.h
@@ -21,6 +21,15 @@ int sysctl_vm_numa_stat_handler(struct c
 		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
+DECLARE_STATIC_KEY_FALSE(vmstat_sync_enabled);
+
+extern void __sync_vmstat(void);
+static inline void sync_vmstat(void)
+{
+	if (static_branch_unlikely(&vmstat_sync_enabled))
+		__sync_vmstat();
+}
+
 struct reclaim_stat {
 	unsigned nr_dirty;
 	unsigned nr_unqueued_dirty;
Index: linux-2.6-vmstat-update/mm/vmstat.c
===================================================================
--- linux-2.6-vmstat-update.orig/mm/vmstat.c
+++ linux-2.6-vmstat-update/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -308,6 +309,24 @@ void set_pgdat_percpu_threshold(pg_data_
 	}
 }
 
+DEFINE_STATIC_KEY_FALSE(vmstat_sync_enabled);
+static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+static inline void mark_vmstat_dirty(void)
+{
+	int cpu;
+
+	if (!static_branch_unlikely(&vmstat_sync_enabled))
+		return;
+
+	cpu = smp_processor_id();
+
+	if (housekeeping_cpu(cpu, HK_FLAG_VMSTAT_SYNC))
+		return;
+
+	per_cpu(vmstat_dirty, smp_processor_id()) = true;
+}
+
 /*
  * For use when we know that interrupts are disabled,
  * or when we know that preemption is disabled and that
@@ -330,6 +349,7 @@ void __mod_zone_page_state(struct zone *
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -361,6 +381,7 @@ void __mod_node_page_state(struct pglist
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -401,6 +422,7 @@ void __inc_zone_state(struct zone *zone,
 		zone_page_state_add(v + overstep, zone, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -419,6 +441,7 @@ void __inc_node_state(struct pglist_data
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -447,6 +470,7 @@ void __dec_zone_state(struct zone *zone,
 		zone_page_state_add(v - overstep, zone, item);
 		__this_cpu_write(*p, overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -465,6 +489,7 @@ void __dec_node_state(struct pglist_data
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -528,6 +553,7 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	mark_vmstat_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -596,6 +622,7 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	mark_vmstat_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -2006,6 +2033,32 @@ static void vmstat_shepherd(struct work_
 		round_jiffies_relative(sysctl_stat_interval));
 }
 
+void __sync_vmstat(void)
+{
+	int cpu;
+
+	cpu = get_cpu();
+	if (per_cpu(vmstat_dirty, cpu) == false) {
+		put_cpu();
+		return;
+	}
+
+	refresh_cpu_vm_stats(false);
+	per_cpu(vmstat_dirty, cpu) = false;
+	put_cpu();
+
+	/*
+	 * If task is migrated to another CPU between put_cpu
+	 * and cancel_delayed_work_sync, the code below might
+	 * cancel vmstat_update work for a different cpu
+	 * (than the one from which the vmstats were flushed).
+	 *
+	 * However, vmstat shepherd will re-enable it later,
+	 * so its harmless.
+	 */
+	cancel_delayed_work_sync(&per_cpu(vmstat_work, cpu));
+}
+
 static void __init start_shepherd_timer(void)
 {
 	int cpu;
Index: linux-2.6-vmstat-update/kernel/entry/common.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/entry/common.c
+++ linux-2.6-vmstat-update/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/vmstat.h>
 
 #include "common.h"
 
@@ -290,6 +291,7 @@ static void syscall_exit_to_user_mode_pr
  */
 static void isolation_exit_to_user_mode_prepare(void)
 {
+	sync_vmstat();
 }
 
 static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)


