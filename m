Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D90426F06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbhJHQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:34:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239288AbhJHQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633710723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kK1fYXuNv+ywQ5icgeMPInL7gyKox4tRv0GlzEiEwao=;
        b=ej+gn0uCG8LZxPmoogK2hCoJVjNhNi4/sRYgSv/e8RB7Ux5wtHhxu2tB7ylHQ2jnY0bAVu
        iam5ynKiPOtjEDMQGFuUcfcgEZUuboYAfOfd1C4iM+HjTmQbei6pcjzKLW1wGbJoYPXwEu
        /zVW2nyOmmcExLVLKhUyxj/w3YXa91c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-9HsIyXDcNLGU_xTbRMusIw-1; Fri, 08 Oct 2021 10:49:24 -0400
X-MC-Unique: 9HsIyXDcNLGU_xTbRMusIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB356100B704;
        Fri,  8 Oct 2021 14:49:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E97D52AF99;
        Fri,  8 Oct 2021 14:49:04 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EAD77425E3F0; Fri,  8 Oct 2021 11:48:13 -0300 (-03)
Message-ID: <20211007193526.308047182@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 16:23:51 -0300
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
Subject: [patch v4 5/8] task isolation: sync vmstats conditional on changes
References: <20211007192346.731667417@fedora.localdomain>
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
@@ -37,6 +48,12 @@ static struct isol_info *tsk_isol_alloc_
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
@@ -338,6 +355,7 @@ void __mod_zone_page_state(struct zone *
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -376,6 +394,7 @@ void __mod_node_page_state(struct pglist
 		x = 0;
 	}
 	__this_cpu_write(*p, x);
+	mark_vmstat_dirty();
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_enable();
@@ -574,6 +593,7 @@ static inline void mod_zone_state(struct
 
 	if (z)
 		zone_page_state_add(z, zone, item);
+	mark_vmstat_dirty();
 }
 
 void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
@@ -642,6 +662,7 @@ static inline void mod_node_state(struct
 
 	if (z)
 		node_page_state_add(z, pgdat, item);
+	mark_vmstat_dirty();
 }
 
 void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
@@ -1082,6 +1103,7 @@ static void fill_contig_page_info(struct
 			info->free_blocks_suitable += blocks <<
 						(order - suitable_order);
 	}
+	mark_vmstat_dirty();
 }
 
 /*
@@ -1434,6 +1456,7 @@ static void walk_zones_in_node(struct se
 		if (!nolock)
 			spin_unlock_irqrestore(&zone->lock, flags);
 	}
+	mark_vmstat_dirty();
 }
 #endif
 
@@ -1499,6 +1522,7 @@ static void pagetypeinfo_showfree_print(
 		}
 		seq_putc(m, '\n');
 	}
+	mark_vmstat_dirty();
 }
 
 /* Print out the free pages at each order for each migatetype */
@@ -1917,6 +1941,7 @@ static void vmstat_update(struct work_st
 				this_cpu_ptr(&vmstat_work),
 				round_jiffies_relative(sysctl_stat_interval));
 	}
+	mark_vmstat_dirty();
 }
 
 /*
@@ -2003,13 +2028,18 @@ static void vmstat_shepherd(struct work_
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
@@ -27,6 +27,13 @@ static inline void tsk_isol_free(struct
 		__tsk_isol_free(tsk);
 }
 
+void __tsk_isol_exit(struct task_struct *tsk);
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+	if (tsk->isol_info)
+		__tsk_isol_exit(tsk);
+}
+
 int prctl_task_isolation_feat_get(unsigned long arg2, unsigned long arg3,
 				  unsigned long arg4, unsigned long arg5);
 int prctl_task_isolation_cfg_get(unsigned long arg2, unsigned long arg3,
@@ -58,6 +65,10 @@ static inline void tsk_isol_free(struct
 {
 }
 
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
 static inline int prctl_task_isolation_feat_get(unsigned long arg2,
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
 
 	io_uring_files_cancel();
+	tsk_isol_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	/* sync mm's RSS info before statistics gathering */
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -2446,6 +2446,7 @@ bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
 bad_fork_cleanup_task_isolation:
+	tsk_isol_exit(p);
 	tsk_isol_free(p);
 bad_fork_cleanup_thread:
 	exit_thread(p);


