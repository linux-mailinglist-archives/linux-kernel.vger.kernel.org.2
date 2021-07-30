Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD843DBF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhG3UVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231702AbhG3UVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627676458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XO2HFhZDrRX79fzjYOS5YH3FCFpPu+mgYLlCLH/GDt4=;
        b=SHvBZPPRmp6YAzE8Y706dix9ERv17KgZsC8cMFzCZyku0s9P+NOlhFm7JCTsGciyR/OCgN
        /9haNXvgC8whgAtUG/HXIBfCgrBtTeyUh336bKkvONitji98jA8Z3T2YLlEfO2/7+qcO1F
        4QCdAfD+YKb3rNmde96gBRItLiouXAA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-Ec1eXWvwMkiybvYsWAHnbQ-1; Fri, 30 Jul 2021 16:20:57 -0400
X-MC-Unique: Ec1eXWvwMkiybvYsWAHnbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D7B871805;
        Fri, 30 Jul 2021 20:20:55 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E4A5D740;
        Fri, 30 Jul 2021 20:20:48 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 7FF5C41752B4; Fri, 30 Jul 2021 17:20:28 -0300 (-03)
Message-ID: <20210730202010.270885685@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 30 Jul 2021 17:18:29 -0300
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
Subject: [patch 2/4] task isolation: sync vmstats on return to userspace
References: <20210730201827.269106165@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- linux-2.6.orig/include/linux/task_isolation.h
+++ linux-2.6/include/linux/task_isolation.h
@@ -32,8 +32,20 @@ int prctl_task_isolation_ctrl_get(unsign
 int prctl_task_isolation_ctrl_set(unsigned long arg2, unsigned long arg3,
 				  unsigned long arg4, unsigned long arg5);
 
+void __isolation_exit_to_user_mode_prepare(void);
+
+static inline void isolation_exit_to_user_mode_prepare(void)
+{
+	if (current->isol_info != NULL)
+		__isolation_exit_to_user_mode_prepare();
+}
+
 #else
 
+static void isolation_exit_to_user_mode_prepare(void)
+{
+}
+
 static inline void tsk_isol_exit(struct task_struct *tsk)
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
 
@@ -287,6 +288,7 @@ static void syscall_exit_to_user_mode_pr
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
@@ -17,6 +17,8 @@
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/vmstat.h>
 
 static unsigned long default_quiesce_mask;
 
@@ -145,6 +147,17 @@ int prctl_task_isolation_ctrl_get(unsign
 	return current->isol_info->active_mask;
 }
 
+void __isolation_exit_to_user_mode_prepare(void)
+{
+	struct isol_info *i = current->isol_info;
+
+	if (i->active_mask != ISOL_F_QUIESCE)
+		return;
+
+	if (i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS)
+		sync_vmstat();
+}
+
 struct qoptions {
 	unsigned long mask;
 	char *name;
Index: linux-2.6/mm/vmstat.c
===================================================================
--- linux-2.6.orig/mm/vmstat.c
+++ linux-2.6/mm/vmstat.c
@@ -1964,6 +1964,27 @@ static void vmstat_shepherd(struct work_
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


