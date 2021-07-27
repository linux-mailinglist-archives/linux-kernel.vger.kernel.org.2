Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C817A3D737B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhG0KmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236277AbhG0KmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627382528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=VaKRVjBMpsLodLME7oyHsTC3glIyyNjhikKvvkbPvH0=;
        b=FzgBniUZJx916HyXwrWqSJDpLV2Voq0NA3UDdLCfIxvVZpr476s6Miy7NRSBuz6B0aBFB+
        wiI0Z76rOaVAu5zStzmFFo9MzIKCx5kXZiQuDXimwEjwRbiXhGuu4LMU2iYaE3/ix/j6bq
        m8p3Z0CDTZCQ4q1D3VdnE+MIpntWV+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-5cQh3i2EO3qxVvXw3VXI6g-1; Tue, 27 Jul 2021 06:42:07 -0400
X-MC-Unique: 5cQh3i2EO3qxVvXw3VXI6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0901C100F768;
        Tue, 27 Jul 2021 10:42:06 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC90F60854;
        Tue, 27 Jul 2021 10:41:57 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A07084179B87; Tue, 27 Jul 2021 07:41:49 -0300 (-03)
Message-ID: <20210727104119.551607458@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 27 Jul 2021 07:38:04 -0300
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
Subject: [patch 1/4] add basic task isolation prctl interface
References: <20210727103803.464432924@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic prctl task isolation interface, which allows
informing the kernel that application is executing 
latency sensitive code (where interruptions are undesired).

Interface is described by task_isolation.rst (added by this patch).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-vmstat-update/Documentation/userspace-api/task_isolation.rst
===================================================================
--- /dev/null
+++ linux-2.6-vmstat-update/Documentation/userspace-api/task_isolation.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Task isolation prctl interface
+=============================
+
+Set thread isolation mode and parameters, which allows
+informing the kernel that application is
+executing latency sensitive code (where interruptions
+are undesired).
+
+Its composed of 4 prctl commands (passed as arg1 to
+prctl):
+
+PR_ISOL_SET:   set isolation parameters for the task
+
+PR_ISOL_GET:   get isolation parameters for the task
+
+PR_ISOL_ENTER: indicate that task should be considered
+               isolated from this point on
+
+PR_ISOL_EXIT: indicate that task should not be considered
+              isolated from this point on
+
+The isolation parameters and mode are not inherited by
+children created by fork(2) and clone(2). The setting is
+preserved across execve(2).
+
+The meaning of isolated is specified as follows, when setting arg2 to
+PR_ISOL_SET or PR_ISOL_GET, with the following arguments passed as arg3.
+
+Isolation mode (PR_ISOL_MODE):
+------------------------------
+
+- PR_ISOL_MODE_NONE (arg4): no per-task isolation (default mode).
+  PR_ISOL_EXIT sets mode to PR_ISOL_MODE_NONE.
+
+- PR_ISOL_MODE_NORMAL (arg4): applications can perform system calls normally,
+  and in case of interruption events, the notifications can be collected
+  by BPF programs.
+  In this mode, if system calls are performed, deferred actions initiated
+  by the system call will be executed before return to userspace.
+
+Other modes, which for example send signals upon interruptions events,
+can be implemented.
+
+Example
+=======
+
+The ``samples/task_isolation/`` directory contains a sample
+application.
+
Index: linux-2.6-vmstat-update/include/uapi/linux/prctl.h
===================================================================
--- linux-2.6-vmstat-update.orig/include/uapi/linux/prctl.h
+++ linux-2.6-vmstat-update/include/uapi/linux/prctl.h
@@ -267,4 +267,13 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
 
+/* Task isolation control */
+#define PR_ISOL_SET			62
+#define PR_ISOL_GET			63
+#define PR_ISOL_ENTER			64
+#define PR_ISOL_EXIT			65
+# define PR_ISOL_MODE			1
+
+# define PR_ISOL_MODE_NONE		0
+# define PR_ISOL_MODE_NORMAL		1
 #endif /* _LINUX_PRCTL_H */
Index: linux-2.6-vmstat-update/kernel/Makefile
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/Makefile
+++ linux-2.6-vmstat-update/kernel/Makefile
@@ -132,6 +132,8 @@ obj-$(CONFIG_WATCH_QUEUE) += watch_queue
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_CPU_ISOLATION) += task_isolation.o
+
 CFLAGS_stackleak.o += $(DISABLE_STACKLEAK_PLUGIN)
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
Index: linux-2.6-vmstat-update/kernel/sys.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/sys.c
+++ linux-2.6-vmstat-update/kernel/sys.c
@@ -58,6 +58,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 #include <linux/sched/cputime.h>
+#include <linux/task_isolation.h>
 #include <linux/rcupdate.h>
 #include <linux/uidgid.h>
 #include <linux/cred.h>
@@ -2567,6 +2568,18 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_ISOL_SET:
+		error = prctl_task_isolation_set(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_GET:
+		error = prctl_task_isolation_get(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_ENTER:
+		error = prctl_task_isolation_enter(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_EXIT:
+		error = prctl_task_isolation_exit(arg2, arg3, arg4, arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
Index: linux-2.6-vmstat-update/samples/task_isolation/task_isolation.c
===================================================================
--- /dev/null
+++ linux-2.6-vmstat-update/samples/task_isolation/task_isolation.c
@@ -0,0 +1,51 @@
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
+	int ret;
+	void *buf = malloc(4096);
+
+	memset(buf, 1, 4096);
+	ret = mlock(buf, 4096);
+	if (ret) {
+		perror("mlock");
+		return EXIT_FAILURE;
+	}
+
+	ret = prctl(PR_ISOL_SET, PR_ISOL_MODE, PR_ISOL_MODE_NORMAL, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_SET");
+		return EXIT_FAILURE;
+	}
+
+	ret = prctl(PR_ISOL_ENTER, 0, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_ENTER");
+		exit(0);
+	}
+
+	/* busy loop */
+	while (ret < 99999999) {
+		memset(buf, 0, 10);
+		ret = ret+1;
+	}
+
+	ret = prctl(PR_ISOL_EXIT, 0, 0, 0, 0);
+	if (ret == -1) {
+		perror("prctl PR_ISOL_EXIT");
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
+}
+
Index: linux-2.6-vmstat-update/include/linux/sched.h
===================================================================
--- linux-2.6-vmstat-update.orig/include/linux/sched.h
+++ linux-2.6-vmstat-update/include/linux/sched.h
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
Index: linux-2.6-vmstat-update/init/init_task.c
===================================================================
--- linux-2.6-vmstat-update.orig/init/init_task.c
+++ linux-2.6-vmstat-update/init/init_task.c
@@ -213,6 +213,9 @@ struct task_struct init_task
 #ifdef CONFIG_SECCOMP_FILTER
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_CPU_ISOLATION
+	.isol_info	= NULL,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
Index: linux-2.6-vmstat-update/kernel/fork.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/fork.c
+++ linux-2.6-vmstat-update/kernel/fork.c
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
Index: linux-2.6-vmstat-update/include/linux/task_isolation.h
===================================================================
--- /dev/null
+++ linux-2.6-vmstat-update/include/linux/task_isolation.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_TASK_ISOL_H
+#define __LINUX_TASK_ISOL_H
+
+#ifdef CONFIG_CPU_ISOLATION
+
+struct isol_info {
+	u8 mode;
+	u8 active;
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
+int prctl_task_isolation_get(unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5);
+
+int prctl_task_isolation_set(unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5);
+
+int prctl_task_isolation_enter(unsigned long arg2, unsigned long arg3,
+			       unsigned long arg4, unsigned long arg5);
+
+int prctl_task_isolation_exit(unsigned long arg2, unsigned long arg3,
+			      unsigned long arg4, unsigned long arg5);
+
+
+#else
+
+static inline void tsk_isol_exit(struct task_struct *tsk)
+{
+}
+
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
+static inline int prctl_task_isolation_enter(unsigned long arg2,
+					     unsigned long arg3,
+					     unsigned long arg4,
+					     unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_exit(unsigned long arg2,
+					    unsigned long arg3,
+					    unsigned long arg4,
+					    unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_CPU_ISOLATION */
+
+#endif /* __LINUX_TASK_ISOL_H */
Index: linux-2.6-vmstat-update/kernel/task_isolation.c
===================================================================
--- /dev/null
+++ linux-2.6-vmstat-update/kernel/task_isolation.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Implementation of task isolation.
+ *
+ * Authors:
+ *   Chris Metcalf <cmetcalf@mellanox.com>
+ *   Alex Belits <abelits@marvell.com>
+ *   Yuri Norov <ynorov@marvell.com>
+ *   Marcelo Tosatti <mtosatti@redhat.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/task_isolation.h>
+#include <linux/prctl.h>
+#include <linux/slab.h>
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
+int prctl_task_isolation_get(unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	if (arg2 != PR_ISOL_MODE)
+		return -EOPNOTSUPP;
+
+	if (current->isol_info != NULL)
+		return current->isol_info->mode;
+
+	return PR_ISOL_MODE_NONE;
+}
+
+
+int prctl_task_isolation_set(unsigned long arg2, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	int ret;
+
+	if (arg2 != PR_ISOL_MODE)
+		return -EOPNOTSUPP;
+
+	if (arg3 != PR_ISOL_MODE_NORMAL)
+		return -EINVAL;
+
+	ret = tsk_isol_alloc_context(current);
+	if (ret)
+		return ret;
+
+	current->isol_info->mode = arg3;
+	return 0;
+}
+
+int prctl_task_isolation_enter(unsigned long arg2, unsigned long arg3,
+			       unsigned long arg4, unsigned long arg5)
+{
+
+	if (current->isol_info == NULL)
+		return -EINVAL;
+
+	if (current->isol_info->mode != PR_ISOL_MODE_NORMAL)
+		return -EINVAL;
+
+	current->isol_info->active = 1;
+
+	return 0;
+}
+
+int prctl_task_isolation_exit(unsigned long arg2, unsigned long arg3,
+			      unsigned long arg4, unsigned long arg5)
+{
+	if (current->isol_info == NULL)
+		return -EINVAL;
+
+	if (current->isol_info->mode != PR_ISOL_MODE_NORMAL)
+		return -EINVAL;
+
+	current->isol_info->active = 0;
+
+	return 0;
+}
+
+
Index: linux-2.6-vmstat-update/samples/Kconfig
===================================================================
--- linux-2.6-vmstat-update.orig/samples/Kconfig
+++ linux-2.6-vmstat-update/samples/Kconfig
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
Index: linux-2.6-vmstat-update/samples/Makefile
===================================================================
--- linux-2.6-vmstat-update.orig/samples/Makefile
+++ linux-2.6-vmstat-update/samples/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
+subdir-$(CONFIG_SAMPLE_TASK_ISOLATION)	+= task_isolation
Index: linux-2.6-vmstat-update/samples/task_isolation/Makefile
===================================================================
--- /dev/null
+++ linux-2.6-vmstat-update/samples/task_isolation/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+userprogs-always-y += task_isolation
+
+userccflags += -I usr/include


