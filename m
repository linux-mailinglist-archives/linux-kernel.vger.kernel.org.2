Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E53D7379
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhG0KmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236104AbhG0KmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627382528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vEN9CXdgENWPUhqQXrpodq7dKt/DmYX3YZPatLCszDk=;
        b=Kjpp/xQIatXRQMPVAP56rjOLvSLtm8TbaNMdJhF4awGV7g1Pef0iRpE/Fzuo4/UGF+A8Ai
        RNHDkLNGvAlocEXOt7ybCRKnljmPrp8v4msoXMejiPIw86LC+TxaF2ZAnLk1F6xtJdj/sG
        NzQWH2qtSUiUC7DrK/pdaOSCVaq2YXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-r8_7WMtzNGqnB8Njg6-yuQ-1; Tue, 27 Jul 2021 06:42:07 -0400
X-MC-Unique: r8_7WMtzNGqnB8Njg6-yuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3369C8799F0;
        Tue, 27 Jul 2021 10:42:06 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9F405C1B4;
        Tue, 27 Jul 2021 10:41:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A56C94179B89; Tue, 27 Jul 2021 07:41:49 -0300 (-03)
Message-ID: <20210727104119.618069631@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 27 Jul 2021 07:38:05 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/4] task isolation: sync vmstats on return to userspace
References: <20210727103803.464432924@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Index: linux-2.6-vmstat-update/include/linux/task_isolation.h
===================================================================
--- linux-2.6-vmstat-update.orig/include/linux/task_isolation.h
+++ linux-2.6-vmstat-update/include/linux/task_isolation.h
@@ -30,9 +30,20 @@ int prctl_task_isolation_enter(unsigned
 int prctl_task_isolation_exit(unsigned long arg2, unsigned long arg3,
 			      unsigned long arg4, unsigned long arg5);
 
+void __isolation_exit_to_user_mode_prepare(void);
+
+static inline void isolation_exit_to_user_mode_prepare(void)
+{
+	if (current->isol_info != NULL)
+		__isolation_exit_to_user_mode_prepare();
+}
 
 #else
 
+static void isolation_exit_to_user_mode_prepare(void)
+{
+}
+
 static inline void tsk_isol_exit(struct task_struct *tsk)
 {
 }
Index: linux-2.6-vmstat-update/include/linux/vmstat.h
===================================================================
--- linux-2.6-vmstat-update.orig/include/linux/vmstat.h
+++ linux-2.6-vmstat-update/include/linux/vmstat.h
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
Index: linux-2.6-vmstat-update/kernel/entry/common.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/entry/common.c
+++ linux-2.6-vmstat-update/kernel/entry/common.c
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
Index: linux-2.6-vmstat-update/kernel/task_isolation.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/task_isolation.c
+++ linux-2.6-vmstat-update/kernel/task_isolation.c
@@ -13,6 +13,8 @@
 #include <linux/task_isolation.h>
 #include <linux/prctl.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/vmstat.h>
 
 static int tsk_isol_alloc_context(struct task_struct *task)
 {
@@ -93,4 +95,14 @@ int prctl_task_isolation_exit(unsigned l
 	return 0;
 }
 
+void __isolation_exit_to_user_mode_prepare(void)
+{
+	if (current->isol_info->mode != PR_ISOL_MODE_NORMAL)
+		return;
+
+	if (current->isol_info->active != 1)
+		return;
+
+	sync_vmstat();
+}
 
Index: linux-2.6-vmstat-update/mm/vmstat.c
===================================================================
--- linux-2.6-vmstat-update.orig/mm/vmstat.c
+++ linux-2.6-vmstat-update/mm/vmstat.c
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


