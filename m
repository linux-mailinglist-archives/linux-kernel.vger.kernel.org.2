Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473283DBF90
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhG3UVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 16:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231472AbhG3UVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 16:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627676460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LlxH5w48KQXMUQPbOWE+xYOrO3z4mapG1QQFJHnEnqk=;
        b=SRG9oTVnat8o+erTrpyzBGpsZG6SF375JeDyqhXzZYOqk295A05r1pqzfoxpTIu6Mhn29W
        gRJ2QqhEwtzYegtGa0bVqDt/l+pRi1j3DAO8TuIhvkgW0NoOP+C8azbnXLO/EX2nxYzkUU
        xDVND8ifhYNgfOZG65OT9q4+qpRr7gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-q500mh5QOxOD_Q5qfOFi5g-1; Fri, 30 Jul 2021 16:20:58 -0400
X-MC-Unique: q500mh5QOxOD_Q5qfOFi5g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89FBA87180C;
        Fri, 30 Jul 2021 20:20:56 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B36C1000186;
        Fri, 30 Jul 2021 20:20:48 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 7DF3C41752B3; Fri, 30 Jul 2021 17:20:28 -0300 (-03)
Message-ID: <20210730202010.240095394@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 30 Jul 2021 17:18:28 -0300
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
Subject: [patch 1/4] add basic task isolation prctl interface
References: <20210730201827.269106165@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic prctl task isolation interface, which allows
informing the kernel that application is executing 
latency sensitive code (where interruptions are undesired).

Interface is described by task_isolation.rst (added by this patch).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/Documentation/userspace-api/task_isolation.rst
===================================================================
--- /dev/null
+++ linux-2.6/Documentation/userspace-api/task_isolation.rst
@@ -0,0 +1,187 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+Task isolation prctl interface
+===============================
+
+Certain types of applications benefit from running uninterrupted by
+background OS activities. Realtime systems and high-bandwidth networking
+applications with user-space drivers can fall into the category.
+
+
+To create a OS noise free environment for the application, this
+interface allows userspace to inform the kernel the start and
+end of the latency sensitive application section (with configurable
+system behaviour for that section).
+
+The prctl options are:
+
+
+        - PR_ISOL_FEAT: Retrieve supported features.
+        - PR_ISOL_GET: Retrieve task isolation parameters.
+        - PR_ISOL_SET: Set task isolation parameters.
+        - PR_ISOL_CTRL_GET: Retrieve task isolation state.
+        - PR_ISOL_CTRL_SET: Set task isolation state (enable/disable task isolation).
+
+The isolation parameters and state are not inherited by
+children created by fork(2) and clone(2). The setting is
+preserved across execve(2).
+
+The sequence of steps to enable task isolation are:
+
+1. Retrieve supported task isolation features (PR_ISOL_FEAT).
+
+2. Configure task isolation features (PR_ISOL_SET/PR_ISOL_GET).
+
+3. Activate or deactivate task isolation features
+   (PR_ISOL_CTRL_GET/PR_ISOL_CTRL_SET).
+
+This interface is based on ideas and code from the
+task isolation patchset from Alex Belits:
+https://lwn.net/Articles/816298/
+
+--------------------
+Feature description
+--------------------
+
+        - ``ISOL_F_QUIESCE``
+
+        This feature allows quiescing select kernel activities on
+        return from system calls.
+
+---------------------
+Interface description
+---------------------
+
+**PR_ISOL_FEAT**:
+
+        Returns the supported features and feature
+        capabilities, as a bitmask. Features and its capabilities
+        are defined at include/uapi/linux/task_isolation.h::
+
+                prctl(PR_ISOL_FEAT, feat, arg3, arg4, arg5);
+
+        The 'feat' argument specifies whether to return
+        supported features (if zero), or feature capabilities
+        (if not zero). Possible non-zero values for 'feat' are:
+
+        - ``ISOL_F_QUIESCE``:
+
+                If arg3 is zero, returns a bitmask containing
+                which kernel activities are supported for quiescing.
+
+                If arg3 is ISOL_F_QUIESCE_DEFMASK, returns
+                default_quiesce_mask, a system-wide configurable.
+                See description of default_quiesce_mask below.
+
+**PR_ISOL_GET**:
+
+        Retrieve task isolation feature configuration.
+        The general format is::
+
+                prctl(PR_ISOL_GET, feat, arg3, arg4, arg5);
+
+        Possible values for feat are:
+
+        - ``ISOL_F_QUIESCE``:
+
+                Returns a bitmask containing which kernel
+                activities are enabled for quiescing.
+
+
+**PR_ISOL_SET**:
+
+        Configures task isolation features. The general format is::
+
+                prctl(PR_ISOL_SET, feat, arg3, arg4, arg5);
+
+        The 'feat' argument specifies which feature to configure.
+        Possible values for feat are:
+
+        - ``ISOL_F_QUIESCE``:
+
+                The 'arg3' argument is a bitmask specifying which
+                kernel activities to quiesce. Possible bit sets are:
+
+                - ``ISOL_F_QUIESCE_VMSTATS``
+
+                  VM statistics are maintained in per-CPU counters to
+                  improve performance. When a CPU modifies a VM statistic,
+                  this modification is kept in the per-CPU counter.
+                  Certain activities require a global count, which
+                  involves requesting each CPU to flush its local counters
+                  to the global VM counters.
+
+                  This flush is implemented via a workqueue item, which
+                  might schedule a workqueue on isolated CPUs.
+
+                  To avoid this interruption, task isolation can be
+                  configured to, upon return from system calls, synchronize
+                  the per-CPU counters to global counters, thus avoiding
+                  the interruption.
+
+                  To ensure the application returns to userspace
+                  with no modified per-CPU counters, its necessary to
+                  use mlockall() in addition to this isolcpus flag.
+
+**PR_ISOL_CTRL_GET**:
+
+        Retrieve task isolation control.
+
+                prctl(PR_ISOL_CTRL_GET, 0, 0, 0, 0);
+
+        Returns which isolation features are active.
+
+**PR_ISOL_CTRL_SET**:
+
+        Activates/deactivates task isolation control.
+
+                prctl(PR_ISOL_CTRL_SET, mask, 0, 0, 0);
+
+        The 'mask' argument specifies which features
+        to activate (bit set) or deactivate (bit clear).
+
+        For ISOL_F_QUIESCE, quiescing of background activities
+        happens on return to userspace from the
+        prctl(PR_ISOL_CTRL_SET) call, and on return from
+        subsequent system calls.
+
+        Quiescing can be adjusted (while active) by
+        prctl(PR_ISOL_SET, ISOL_F_QUIESCE, ...).
+
+--------------------
+Default quiesce mask
+--------------------
+
+Applications can either explicitly specify individual
+background activities that should be quiesced, or
+obtain a system configurable value, which is to be
+configured by the system admin/mgmt system.
+
+/sys/kernel/task_isolation/available_quiesce lists, as
+one string per line, the activities which the kernel
+supports quiescing.
+
+To configure the default quiesce mask, write a comma separated
+list of strings (from available_quiesce) to
+/sys/kernel/task_isolation/default_quiesce.
+
+echo > /sys/kernel/task_isolation/default_quiesce disables
+all quiescing via ISOL_F_QUIESCE_DEFMASK.
+
+Using ISOL_F_QUIESCE_DEFMASK allows for the application to
+take advantage of future quiescing capabilities without
+modification (provided default_quiesce is configured
+accordingly).
+
+See PR_ISOL_FEAT subsection of "Interface description" section
+for more details. samples/task_isolation/task_isolation.c
+contains an example.
+
+Examples
+========
+
+The ``samples/task_isolation/`` directory contains sample
+applications.
+
+
Index: linux-2.6/include/uapi/linux/prctl.h
===================================================================
--- linux-2.6.orig/include/uapi/linux/prctl.h
+++ linux-2.6/include/uapi/linux/prctl.h
@@ -267,4 +267,17 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
 
+/* Task isolation control */
+#define PR_ISOL_FEAT			62
+#define PR_ISOL_GET			63
+#define PR_ISOL_SET			64
+#define PR_ISOL_CTRL_GET		65
+#define PR_ISOL_CTRL_SET		66
+
+# define ISOL_F_QUIESCE			(1UL << 0)
+#  define ISOL_F_QUIESCE_VMSTATS	(1UL << 0)
+
+# define ISOL_F_QUIESCE_DEFMASK		(1UL << 0)
+
+
 #endif /* _LINUX_PRCTL_H */
Index: linux-2.6/kernel/Makefile
===================================================================
--- linux-2.6.orig/kernel/Makefile
+++ linux-2.6/kernel/Makefile
@@ -132,6 +132,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_CPU_ISOLATION) += task_isolation.o
+
 CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
Index: linux-2.6/kernel/sys.c
===================================================================
--- linux-2.6.orig/kernel/sys.c
+++ linux-2.6/kernel/sys.c
@@ -58,6 +58,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 #include <linux/sched/cputime.h>
+#include <linux/task_isolation.h>
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
@@ -2567,6 +2568,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_ISOL_FEAT:
+		error = prctl_task_isolation_feat(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_GET:
+		error = prctl_task_isolation_get(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_SET:
+		error = prctl_task_isolation_set(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_CTRL_GET:
+		error = prctl_task_isolation_ctrl_get(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_CTRL_SET:
+		error = prctl_task_isolation_ctrl_set(arg2, arg3, arg4, arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
Index: linux-2.6/samples/task_isolation/task_isolation.c
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/task_isolation.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mman.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/prctl.h>
+
+int main(void)
+{
+	int ret, defmask;
+	void *buf = malloc(4096);
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = prctl(PR_ISOL_FEAT, 0, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT");
+		return EXIT_FAILURE;
+	}
+	printf("supported features bitmask: 0x%x\n", ret);
+
+	if (!(ret & ISOL_F_QUIESCE)) {
+		printf("quiesce feature unsupported, quitting\n");
+		return EXIT_FAILURE;
+	}
+
+	ret = prctl(PR_ISOL_FEAT, ISOL_F_QUIESCE, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT (ISOL_F_QUIESCE)");
+		return EXIT_FAILURE;
+	}
+	printf("supported ISOL_F_QUIESCE bits: 0x%x\n", ret);
+
+	ret = prctl(PR_ISOL_FEAT, ISOL_F_QUIESCE, ISOL_F_QUIESCE_DEFMASK,
+		    0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_FEAT (ISOL_F_QUIESCE, DEFMASK)");
+		return EXIT_FAILURE;
+	}
+
+	defmask = ret;
+	printf("default ISOL_F_QUIESCE bits: 0x%x\n", defmask);
+
+	/*
+	 * Application can either set the value from ISOL_F_QUIESCE_DEFMASK,
+	 * which is configurable through
+	 * /sys/kernel/task_isolation/default_quiesce, or specific values.
+	 *
+	 * Using ISOL_F_QUIESCE_DEFMASK allows for the application to
+	 * take advantage of future quiescing capabilities without
+	 * modification (provided default_quiesce is configured
+	 * accordingly).
+	 */
+	defmask = defmask | ISOL_F_QUIESCE_VMSTATS;
+
+	ret = prctl(PR_ISOL_SET, ISOL_F_QUIESCE, defmask,
+		    0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_SET");
+		return EXIT_FAILURE;
+	}
+
+	ret = prctl(PR_ISOL_CTRL_SET, ISOL_F_QUIESCE, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_CTRL_SET (ISOL_F_QUIESCE)");
+		return EXIT_FAILURE;
+	}
+
+#define NR_LOOPS 999999999
+#define NR_PRINT 100000000
+	/* busy loop */
+	while (ret < NR_LOOPS)  {
+		memset(buf, 0, 4096);
+		ret = ret+1;
+		if (!(ret % NR_PRINT))
+			printf("loops=%d of %d\n", ret, NR_LOOPS);
+	}
+
+	ret = prctl(PR_ISOL_CTRL_SET, 0, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_CTRL_SET (0)");
+		exit(0);
+	}
+
+	return EXIT_SUCCESS;
+}
+
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -66,6 +66,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct isol_info;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1400,6 +1401,10 @@ struct task_struct {
 	struct llist_head               kretprobe_instances;
 #endif
 
+#ifdef CONFIG_CPU_ISOLATION
+	struct isol_info		*isol_info;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
Index: linux-2.6/init/init_task.c
===================================================================
--- linux-2.6.orig/init/init_task.c
+++ linux-2.6/init/init_task.c
@@ -213,6 +213,9 @@ struct task_struct init_task
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_CPU_ISOLATION
+	.isol_info	= NULL,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/task_isolation.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -734,6 +735,7 @@ void __put_task_struct(struct task_struc
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	tsk_isol_exit(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
@@ -2084,7 +2086,9 @@ static __latent_entropy struct task_stru
 #ifdef CONFIG_BPF_SYSCALL
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 #endif
-
+#ifdef CONFIG_CPU_ISOLATION
+	p->isol_info = NULL;
+#endif
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- /dev/null
+++ linux-2.6/include/linux/task_isolation.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_TASK_ISOL_H
+#define __LINUX_TASK_ISOL_H
+
+#ifdef CONFIG_CPU_ISOLATION
+
+struct isol_info {
+	/* Which features are active */
+	unsigned long active_mask;
+	/* Quiesce mask */
+	unsigned long quiesce_mask;
+};
+
+extern void __tsk_isol_exit(struct task_struct *tsk);
+
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+	if (tsk->isol_info)
+		__tsk_isol_exit(tsk);
+}
+
+
+int prctl_task_isolation_feat(unsigned long arg2, unsigned long arg3,
+			      unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_get(unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_set(unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_ctrl_get(unsigned long arg2, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_ctrl_set(unsigned long arg2, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5);
+
+#else
+
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
+static inline int prctl_task_isolation_feat(unsigned long arg2,
+					    unsigned long arg3,
+					    unsigned long arg4,
+					    unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_get(unsigned long arg2,
+					   unsigned long arg3,
+					   unsigned long arg4,
+					   unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_set(unsigned long arg2,
+					   unsigned long arg3,
+					   unsigned long arg4,
+					   unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_ctrl_get(unsigned long arg2,
+						unsigned long arg3,
+						unsigned long arg4,
+						unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_ctrl_set(unsigned long arg2,
+						unsigned long arg3,
+						unsigned long arg4,
+						unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_CPU_ISOLATION */
+
+#endif /* __LINUX_TASK_ISOL_H */
Index: linux-2.6/kernel/task_isolation.c
===================================================================
--- /dev/null
+++ linux-2.6/kernel/task_isolation.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Implementation of task isolation.
+ *
+ * Authors:
+ *   Chris Metcalf <cmetcalf@mellanox.com>
+ *   Alex Belits <abelits@belits.com>
+ *   Yuri Norov <ynorov@marvell.com>
+ *   Marcelo Tosatti <mtosatti@redhat.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/task_isolation.h>
+#include <linux/prctl.h>
+#include <linux/slab.h>
+#include <linux/kobject.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/init.h>
+
+static unsigned long default_quiesce_mask;
+
+static int tsk_isol_alloc_context(struct task_struct *task)
+{
+	struct isol_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (unlikely(!info))
+		return -ENOMEM;
+
+	task->isol_info = info;
+	return 0;
+}
+
+void __tsk_isol_exit(struct task_struct *tsk)
+{
+	kfree(tsk->isol_info);
+	tsk->isol_info = NULL;
+}
+
+static int prctl_task_isolation_feat_quiesce(unsigned long type)
+{
+	switch (type) {
+	case 0:
+		return ISOL_F_QUIESCE_VMSTATS;
+	case ISOL_F_QUIESCE_DEFMASK:
+		return default_quiesce_mask;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int task_isolation_get_quiesce(void)
+{
+	if (current->isol_info != NULL)
+		return current->isol_info->quiesce_mask;
+
+	return 0;
+}
+
+static int task_isolation_set_quiesce(unsigned long quiesce_mask)
+{
+	if (quiesce_mask != ISOL_F_QUIESCE_VMSTATS && quiesce_mask != 0)
+		return -EINVAL;
+
+	current->isol_info->quiesce_mask = quiesce_mask;
+	return 0;
+}
+
+int prctl_task_isolation_feat(unsigned long feat, unsigned long arg3,
+			      unsigned long arg4, unsigned long arg5)
+{
+	switch (feat) {
+	case 0:
+		return ISOL_F_QUIESCE;
+	case ISOL_F_QUIESCE:
+		return prctl_task_isolation_feat_quiesce(arg3);
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+int prctl_task_isolation_get(unsigned long feat, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	switch (feat) {
+	case ISOL_F_QUIESCE:
+		return task_isolation_get_quiesce();
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+int prctl_task_isolation_set(unsigned long feat, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	int ret;
+	bool err_free_ctx = false;
+
+	if (current->isol_info == NULL)
+		err_free_ctx = true;
+
+	ret = tsk_isol_alloc_context(current);
+	if (ret)
+		return ret;
+
+	switch (feat) {
+	case ISOL_F_QUIESCE:
+		ret = task_isolation_set_quiesce(arg3);
+		if (ret)
+			break;
+		return 0;
+	default:
+		break;
+	}
+
+	if (err_free_ctx)
+		__tsk_isol_exit(current);
+	return -EINVAL;
+}
+
+int prctl_task_isolation_ctrl_set(unsigned long feat, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5)
+{
+	if (current->isol_info == NULL)
+		return -EINVAL;
+
+	if (feat != ISOL_F_QUIESCE && feat != 0)
+		return -EINVAL;
+
+	current->isol_info->active_mask = feat;
+	return 0;
+}
+
+int prctl_task_isolation_ctrl_get(unsigned long arg2, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5)
+{
+	if (current->isol_info == NULL)
+		return 0;
+
+	return current->isol_info->active_mask;
+}
+
+struct qoptions {
+	unsigned long mask;
+	char *name;
+};
+
+static struct qoptions qopts[] = {
+	{ISOL_F_QUIESCE_VMSTATS, "vmstat"},
+};
+
+#define QLEN (sizeof(qopts) / sizeof(struct qoptions))
+
+static ssize_t default_quiesce_store(struct kobject *kobj,
+				     struct kobj_attribute *attr,
+				     const char *buf, size_t count)
+{
+	char *p, *s;
+	unsigned long defmask = 0;
+
+	s = (char *)buf;
+	if (count == 1 && strlen(strim(s)) == 0) {
+		default_quiesce_mask = 0;
+		return count;
+	}
+
+	while ((p = strsep(&s, ",")) != NULL) {
+		int i;
+		bool found = false;
+
+		if (!*p)
+			continue;
+
+		for (i = 0; i < QLEN; i++) {
+			struct qoptions *opt = &qopts[i];
+
+			if (strncmp(strim(p), opt->name, strlen(opt->name)) == 0) {
+				defmask |= opt->mask;
+				found = true;
+				break;
+			}
+		}
+		if (found == true)
+			continue;
+		return -EINVAL;
+	}
+	default_quiesce_mask = defmask;
+
+	return count;
+}
+
+#define MAXARRLEN 100
+
+static ssize_t default_quiesce_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	int i;
+	char tbuf[MAXARRLEN] = "";
+
+	for (i = 0; i < QLEN; i++) {
+		struct qoptions *opt = &qopts[i];
+
+		if (default_quiesce_mask & opt->mask) {
+			strlcat(tbuf, opt->name, MAXARRLEN);
+			strlcat(tbuf, "\n", MAXARRLEN);
+		}
+	}
+
+	return sprintf(buf, "%s", tbuf);
+}
+
+static struct kobj_attribute default_quiesce_attr =
+				__ATTR_RW(default_quiesce);
+
+static ssize_t available_quiesce_show(struct kobject *kobj,
+				      struct kobj_attribute *attr, char *buf)
+{
+	int i;
+	char tbuf[MAXARRLEN] = "";
+
+	for (i = 0; i < QLEN; i++) {
+		struct qoptions *opt = &qopts[i];
+
+		strlcat(tbuf, opt->name, MAXARRLEN);
+		strlcat(tbuf, "\n", MAXARRLEN);
+	}
+
+	return sprintf(buf, "%s", tbuf);
+}
+
+static struct kobj_attribute available_quiesce_attr =
+				__ATTR_RO(available_quiesce);
+
+static struct attribute *task_isol_attrs[] = {
+	&available_quiesce_attr.attr,
+	&default_quiesce_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group task_isol_attr_group = {
+	.attrs = task_isol_attrs,
+	.bin_attrs = NULL,
+};
+
+static int __init task_isol_ksysfs_init(void)
+{
+	int ret;
+	struct kobject *task_isol_kobj;
+
+	task_isol_kobj = kobject_create_and_add("task_isolation",
+						kernel_kobj);
+	if (!task_isol_kobj) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = sysfs_create_group(task_isol_kobj, &task_isol_attr_group);
+	if (ret)
+		goto out_task_isol_kobj;
+
+	return 0;
+
+out_task_isol_kobj:
+	kobject_put(task_isol_kobj);
+out:
+	return ret;
+}
+
+arch_initcall(task_isol_ksysfs_init);
Index: linux-2.6/samples/Kconfig
===================================================================
--- linux-2.6.orig/samples/Kconfig
+++ linux-2.6/samples/Kconfig
@@ -223,4 +223,11 @@ config SAMPLE_WATCH_QUEUE
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
 
+config SAMPLE_TASK_ISOLATION
+	bool "task isolation sample"
+	depends on CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  Build example userspace program to use prctl task isolation
+	  interface.
+
 endif # SAMPLES
Index: linux-2.6/samples/Makefile
===================================================================
--- linux-2.6.orig/samples/Makefile
+++ linux-2.6/samples/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
+subdir-$(CONFIG_SAMPLE_TASK_ISOLATION)	+= task_isolation
Index: linux-2.6/samples/task_isolation/Makefile
===================================================================
--- /dev/null
+++ linux-2.6/samples/task_isolation/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+userprogs-always-y += task_isolation
+
+userccflags += -I usr/include


