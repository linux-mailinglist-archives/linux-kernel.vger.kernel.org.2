Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBAD426CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbhJHOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhJHOuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633704536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tmD9ZEINCvk9JFN6rbQUkZKIMAUowAvYF/qUs+8JLng=;
        b=TjaXXk9CL/Z+XCWpTFkEhbxnrtlmLW22XFEf3TPMt/uTuyjc7t4fALSnRL3eZLxfO3aZFs
        zr1rJQMe0zDkCgB7sZgz3xI/lbU/DdfRCr4HG2T623RRkyARhHbHLPwfgXR2WP/7mN/KyA
        KKpNTvapp5kDxd3LEhtnnOWIg2LbUdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-L9Tuf4wrNzySFXbsm62nZQ-1; Fri, 08 Oct 2021 10:48:55 -0400
X-MC-Unique: L9Tuf4wrNzySFXbsm62nZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37CA1801A93;
        Fri,  8 Oct 2021 14:48:54 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB7955D9F0;
        Fri,  8 Oct 2021 14:48:52 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E34EE41A8010; Fri,  8 Oct 2021 11:48:13 -0300 (-03)
Message-ID: <20211007193526.032879835@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 16:23:49 -0300
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
Subject: [patch v4 3/8] task isolation: sync vmstats on return to userspace
References: <20211007192346.731667417@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

To fix this, use the task isolation prctl interface to quiesce 
deferred actions when returning to userspace.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/task_isolation.h |   12 ++++++++++++
 include/linux/vmstat.h         |    8 ++++++++
 kernel/entry/common.c          |    2 ++
 kernel/task_isolation.c        |   26 ++++++++++++++++++++++++++
 mm/vmstat.c                    |   21 +++++++++++++++++++++
 5 files changed, 69 insertions(+)

Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -40,8 +40,20 @@ int prctl_task_isolation_activate_set(un
 
 int __copy_task_isolation(struct task_struct *tsk);
 
+void __isolation_exit_to_user_mode_prepare(void);
+
+static inline void isolation_exit_to_user_mode_prepare(void)
+{
+	if (current->isol_info)
+		__isolation_exit_to_user_mode_prepare();
+}
+
 #else
 
+static void isolation_exit_to_user_mode_prepare(void)
+{
+}
+
 static inline void tsk_isol_free(struct task_struct *tsk)
 {
 }
Index: linux-2.6/include/linux/vmstat.h
===================================================================
--- linux-2.6.orig/include/linux/vmstat.h
+++ linux-2.6/include/linux/vmstat.h
@@ -21,6 +21,14 @@ int sysctl_vm_numa_stat_handler(struct c
 		void *buffer, size_t *length, loff_t *ppos);
 #endif
 
+#ifdef CONFIG_SMP
+void sync_vmstat(void);
+#else
+static inline void sync_vmstat(void)
+{
+}
+#endif
+
 struct reclaim_stat {
 	unsigned nr_dirty;
 	unsigned nr_unqueued_dirty;
Index: linux-2.6/kernel/entry/common.c
===================================================================
--- linux-2.6.orig/kernel/entry/common.c
+++ linux-2.6/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/task_isolation.h>
 
 #include "common.h"
 
@@ -285,6 +286,7 @@ static void syscall_exit_to_user_mode_pr
 static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
 {
 	syscall_exit_to_user_mode_prepare(regs);
+	isolation_exit_to_user_mode_prepare();
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
 }
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- linux-2.6.orig/kernel/task_isolation.c
+++ linux-2.6/kernel/task_isolation.c
@@ -18,6 +18,8 @@
 #include <linux/sysfs.h>
 #include <linux/init.h>
 #include <linux/sched/task.h>
+#include <linux/mm.h>
+#include <linux/vmstat.h>
 
 void __tsk_isol_free(struct task_struct *tsk)
 {
@@ -355,3 +357,23 @@ int prctl_task_isolation_activate_get(un
 	return ret;
 }
 
+void __isolation_exit_to_user_mode_prepare(void)
+{
+	struct isol_info *i;
+
+	i = current->isol_info;
+	if (!i)
+		return;
+
+	if (i->active_mask != ISOL_F_QUIESCE)
+		return;
+
+	if (i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS) {
+		sync_vmstat();
+		if (i->oneshot_mask & ISOL_F_QUIESCE_VMSTATS) {
+			i->oneshot_mask &= ~ISOL_F_QUIESCE_VMSTATS;
+			i->quiesce_mask &= ~ISOL_F_QUIESCE_VMSTATS;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(__isolation_exit_to_user_mode_prepare);
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -2003,6 +2003,27 @@ static void vmstat_shepherd(struct work_
 		round_jiffies_relative(sysctl_stat_interval));
 }
 
+void sync_vmstat(void)
+{
+	int cpu;
+
+	cpu = get_cpu();
+
+	refresh_cpu_vm_stats(false);
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


