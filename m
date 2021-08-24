Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B13F61DD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbhHXPnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238419AbhHXPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629819760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=0K8WtbiSrQ46/iMpVFsjzQaqD0haAsGAizj8OKg2e0M=;
        b=ijPn0P3bHge7QsQH+YSIt/z+EugDP7dB9Wu6qQeX/62UL7x1AoRLA9vOGzqpnaGwOZ2HFJ
        qlKaSclGRT0soe5BNnuhazCXrRQq00goR/B3kTa2RdiXKag0DzPsPb5e1Cc8t+WJLTMkpO
        d7iO8QR+cVOStd4srnQi3UGIG2jT0O0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-wwvgUyAONri8LFUsppTEiA-1; Tue, 24 Aug 2021 11:42:39 -0400
X-MC-Unique: wwvgUyAONri8LFUsppTEiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDD22871810;
        Tue, 24 Aug 2021 15:42:37 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37B1F60BD9;
        Tue, 24 Aug 2021 15:42:30 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 193E24175282; Tue, 24 Aug 2021 12:42:15 -0300 (-03)
Message-ID: <20210824152646.822271769@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 24 Aug 2021 12:24:28 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch V3 5/8] task isolation: sync vmstats conditional on changes
References: <20210824152423.300346181@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than syncing VM-stats on every return to userspace
(or VM-entry), keep track of changes through a per-CPU bool.

This improves performance when enabling task isolated
for vcpu VMs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -22,7 +22,16 @@ int sysctl_vm_numa_stat_handler(struct c
 #endif
 
 #ifdef CONFIG_SMP
-void sync_vmstat(void);
+extern struct static_key vmstat_sync_enabled;
+
+void __sync_vmstat(void);
+static inline void sync_vmstat(void)
+{
+	if (static_key_false(&vmstat_sync_enabled))
+		__sync_vmstat();
+}
+
+void init_sync_vmstat(void);
 #else
 static inline void sync_vmstat(void)
 {
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -21,6 +21,17 @@
 #include <linux/mm.h>
 #include <linux/vmstat.h>
 
+void __tsk_isol_exit(struct task_struct *tsk)
+{
+	struct isol_info *i;
+
+	i = tsk->isol_info;
+	if (!i)
+		return;
+
+	static_key_slow_dec(&vmstat_sync_enabled);
+}
+
 void __tsk_isol_free(struct task_struct *tsk)
 {
 	if (!tsk->isol_info)
@@ -92,6 +103,12 @@ static struct isol_info *tsk_isol_alloc_
 	if (unlikely(!info))
 		return ERR_PTR(-ENOMEM);
 
+	preempt_disable();
+	init_sync_vmstat();
+	preempt_enable();
+
+	static_key_slow_inc(&vmstat_sync_enabled);
+
 	return info;
 }
 
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -28,6 +28,7 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
+#include <linux/sched/isolation.h>
 
 #include "internal.h"
 
@@ -306,6 +307,22 @@ void set_pgdat_percpu_threshold(pg_data_
 	}
 }
 
+struct static_key vmstat_sync_enabled;
+static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
+
+static inline void mark_vmstat_dirty(void)
+{
+	if (!static_key_false(&vmstat_sync_enabled))
+		return;
+
+	raw_cpu_write(vmstat_dirty, true);
+}
+
+void init_sync_vmstat(void)
+{
+	raw_cpu_write(vmstat_dirty, true);
+}
+
 /*
  * For use when we know that interrupts are disabled,
  * or when we know that preemption is disabled and that
@@ -328,6 +345,7 @@ void __mod_zone_page_state(struct zone *
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 }
 EXPORT_SYMBOL(__mod_zone_page_state);
 
@@ -359,6 +377,7 @@ void __mod_node_page_state(struct pglist
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 }
 EXPORT_SYMBOL(__mod_node_page_state);
 
@@ -399,6 +418,7 @@ void __inc_zone_state(struct zone *zone,
 		zone_page_state_add(v + overstep, zone, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -417,6 +437,7 @@ void __inc_node_state(struct pglist_data
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __inc_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -445,6 +466,7 @@ void __dec_zone_state(struct zone *zone,
 		zone_page_state_add(v - overstep, zone, item);
 		__this_cpu_write(*p, overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
@@ -463,6 +485,7 @@ void __dec_node_state(struct pglist_data
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
 	}
+	mark_vmstat_dirty();
 }
 
 void __dec_zone_page_state(struct page *page, enum zone_stat_item item)
@@ -526,6 +549,7 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	mark_vmstat_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -594,6 +618,7 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	mark_vmstat_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -1964,13 +1989,18 @@ static void vmstat_shepherd(struct work_
 		round_jiffies_relative(sysctl_stat_interval));
 }
 
-void sync_vmstat(void)
+void __sync_vmstat(void)
 {
 	int cpu;
 
 	cpu = get_cpu();
+	if (per_cpu(vmstat_dirty, cpu) == false) {
+		put_cpu();
+		return;
+	}
 
 	refresh_cpu_vm_stats(false);
+	raw_cpu_write(vmstat_dirty, false);
 	put_cpu();
 
 	/*
Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -24,6 +24,13 @@ static inline void tsk_isol_free(struct
 		__tsk_isol_free(tsk);
 }
 
+void __tsk_isol_exit(struct task_struct *tsk);
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+       if (tsk->isol_info)
+               __tsk_isol_exit(tsk);
+}
+
 int prctl_task_isolation_int_get(unsigned long cmd, void __user *addr,
 				 unsigned long arg4, unsigned long arg5);
 int prctl_task_isolation_int_set(unsigned long cmd, void __user *addr,
@@ -59,6 +66,10 @@ static inline void tsk_isol_free(struct
 {
 }
 
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
 static inline int prctl_task_isolation_feat(unsigned long arg2,
 					    unsigned long arg3,
 					    unsigned long arg4,
Index: linux-2.6/kernel/exit.c
===================================================================
--- linux-2.6.orig/kernel/exit.c
+++ linux-2.6/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/task_isolation.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -778,6 +779,7 @@ void __noreturn do_exit(long code)
 	}
 
 	io_uring_files_cancel(tsk->files);
+	tsk_isol_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	/* sync mm's RSS info before statistics gathering */
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -2371,6 +2371,7 @@ bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
 bad_fork_cleanup_task_isolation:
+	tsk_isol_exit(p);
 	tsk_isol_free(p);
 bad_fork_cleanup_thread:
 	exit_thread(p);


