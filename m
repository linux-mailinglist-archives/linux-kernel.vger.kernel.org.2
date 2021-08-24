Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDAB3F61E1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbhHXPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238456AbhHXPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629819775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H4U+nL22loZngf8MJY5xpoQrsD7orIsQqag7bZ7Olqo=;
        b=fqiVBfTMfANHyTZN4iK1hFTXazWg8gHJLqHojwKWTjGOlz1B+D+LKGN5Lkb4Afvk9Panbo
        aoDw5iupwcR5jNw74FN1TDxEPcgandx5b2IfMyKg85tTYKiszR8ZpU08kSJmn4IGizGnzy
        JhKBw05iyZKSft+WErsQlmcxEweTrDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-5cECGuQzMdeeIqK6mfoq_g-1; Tue, 24 Aug 2021 11:42:54 -0400
X-MC-Unique: 5cECGuQzMdeeIqK6mfoq_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBF78799EF;
        Tue, 24 Aug 2021 15:42:53 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E55B61036D38;
        Tue, 24 Aug 2021 15:42:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 08F8A416D8BC; Tue, 24 Aug 2021 12:42:15 -0300 (-03)
Message-ID: <20210824152646.667676905@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 24 Aug 2021 12:24:24 -0300
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
Subject: [patch V3 1/8] add basic task isolation prctl interface
References: <20210824152423.300346181@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic prctl task isolation interface, which allows
informing the kernel that application is executing 
latency sensitive code (where interruptions are undesired).

Interface is described by task_isolation.rst (added by
next patch).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/sched.h          |    5 +
 include/linux/task_isolation.h |   87 +++++++++++++++++
 include/uapi/linux/prctl.h     |   10 ++
 init/init_task.c               |    3 
 kernel/Makefile                |    2 
 kernel/fork.c                  |    6 +
 kernel/sys.c                   |   16 +++
 kernel/task_isolation.c        |  203 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 331 insertions(+), 1 deletion(-)

Index: linux-2.6/include/uapi/linux/prctl.h
===================================================================
--- linux-2.6.orig/include/uapi/linux/prctl.h
+++ linux-2.6/include/uapi/linux/prctl.h
@@ -267,4 +267,31 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
 
+/* Task isolation control */
+#define PR_ISOL_INT_GET			63
+#define PR_ISOL_INT_SET			64
+# define INHERIT_CFG			0x0
+
+/*
+ * This structure provides control over
+ * inheritance of task isolation across
+ * clone and fork.
+ */
+struct task_isol_inherit_control {
+	__u8	inherit_mask;
+	__u8	pad[7];
+};
+
+# define ISOL_INHERIT_CONF		(1UL << 0)
+# define ISOL_INHERIT_ACTIVE		(1UL << 1)
+
+#define PR_ISOL_FEAT			65
+#define PR_ISOL_GET			66
+#define PR_ISOL_SET			67
+#define PR_ISOL_CTRL_GET		68
+#define PR_ISOL_CTRL_SET		69
+
+# define ISOL_F_QUIESCE			(1UL << 0)
+#  define ISOL_F_QUIESCE_VMSTATS	(1UL << 0)
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
@@ -2567,6 +2568,31 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_ISOL_INT_GET:
+		error = prctl_task_isolation_int_get(arg2,
+						     (void __user *)arg3, arg4,
+						     arg5);
+		break;
+	case PR_ISOL_INT_SET:
+		error = prctl_task_isolation_int_set(arg2,
+						    (void __user *)arg3, arg4,
+						     arg5);
+		break;
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
 
+	tsk_isol_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
@@ -1511,6 +1513,15 @@ static int copy_io(unsigned long clone_f
 	return 0;
 }
 
+static int copy_task_isolation(struct task_struct *tsk)
+{
+#ifdef CONFIG_CPU_ISOLATION
+	if (current->isol_info)
+		return __copy_task_isolation(tsk);
+#endif
+	return 0;
+}
+
 static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 {
 	struct sighand_struct *sig;
@@ -2084,7 +2095,9 @@ static __latent_entropy struct task_stru
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
@@ -2128,6 +2141,9 @@ static __latent_entropy struct task_stru
 	retval = copy_thread(clone_flags, args->stack, args->stack_size, p, args->tls);
 	if (retval)
 		goto bad_fork_cleanup_io;
+	retval = copy_task_isolation(p);
+	if (retval)
+		goto bad_fork_cleanup_thread;
 
 	stackleak_task_init(p);
 
@@ -2136,7 +2152,7 @@ static __latent_entropy struct task_stru
 				args->set_tid_size);
 		if (IS_ERR(pid)) {
 			retval = PTR_ERR(pid);
-			goto bad_fork_cleanup_thread;
+			goto bad_fork_cleanup_task_isolation;
 		}
 	}
 
@@ -2354,6 +2370,8 @@ bad_fork_put_pidfd:
 bad_fork_free_pid:
 	if (pid != &init_struct_pid)
 		free_pid(pid);
+bad_fork_cleanup_task_isolation:
+	tsk_isol_free(p);
 bad_fork_cleanup_thread:
 	exit_thread(p);
 bad_fork_cleanup_io:
Index: linux-2.6/include/linux/task_isolation.h
===================================================================
--- /dev/null
+++ linux-2.6/include/linux/task_isolation.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_TASK_ISOL_H
+#define __LINUX_TASK_ISOL_H
+
+#ifdef CONFIG_CPU_ISOLATION
+
+struct isol_info {
+	/* Which features have been configured */
+	int conf_mask;
+	/* Which features are active */
+	int active_mask;
+	/* Quiesce mask */
+	int quiesce_mask;
+
+	u8 inherit_mask;
+};
+
+extern void __tsk_isol_free(struct task_struct *tsk);
+
+static inline void tsk_isol_free(struct task_struct *tsk)
+{
+	if (tsk->isol_info)
+		__tsk_isol_free(tsk);
+}
+
+int prctl_task_isolation_int_get(unsigned long cmd, void __user *addr,
+				 unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_int_set(unsigned long cmd, void __user *addr,
+				 unsigned long arg4, unsigned long arg5);
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
+int __copy_task_isolation(struct task_struct *tsk);
+
+#else
+
+static inline void tsk_isol_free(struct task_struct *tsk)
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
+static inline int prctl_task_isolation_int_get(unsigned long cmd,
+					       void __user *addr,
+					       unsigned long arg4,
+					       unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_int_set(unsigned long cmd,
+					       void __user *addr,
+					       unsigned long arg4,
+					       unsigned long arg5)
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
@@ -0,0 +1,280 @@
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
+#include <linux/sched/task.h>
+
+void __tsk_isol_free(struct task_struct *tsk)
+{
+	if (!tsk->isol_info)
+		return;
+	kfree(tsk->isol_info);
+	tsk->isol_info = NULL;
+}
+
+static int prctl_task_isolation_feat_quiesce(int type)
+{
+	switch (type) {
+	case 0:
+		return ISOL_F_QUIESCE_VMSTATS;
+	default:
+		break;
+	}
+
+	return -EINVAL;
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
+static int task_isolation_get_quiesce(void)
+{
+	int ret = 0;
+
+	if (current->isol_info)
+		ret = current->isol_info->quiesce_mask;
+
+	return ret;
+}
+
+int prctl_task_isolation_get(unsigned long feat, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	switch (feat) {
+	case 0: {
+		int ret = -ENODATA;
+
+		if (current->isol_info)
+			ret = current->isol_info->conf_mask;
+		return ret;
+	}
+	case ISOL_F_QUIESCE:
+		return task_isolation_get_quiesce();
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static struct isol_info *tsk_isol_alloc_context(void)
+{
+	struct isol_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (unlikely(!info))
+		return ERR_PTR(-ENOMEM);
+
+	return info;
+}
+
+static int prepare_set_quiesce(int quiesce_mask)
+{
+	if (quiesce_mask != ISOL_F_QUIESCE_VMSTATS && quiesce_mask != 0)
+		return -EINVAL;
+
+	return 0;
+}
+
+int prctl_task_isolation_set(unsigned long feat, unsigned long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	int ret;
+	struct isol_info *isol_info;
+
+	/* Validate input */
+	switch (feat) {
+	case ISOL_F_QUIESCE:
+		ret = prepare_set_quiesce(arg3);
+		if (ret)
+			return -EINVAL;
+		break;
+	default:
+		break;
+	}
+
+	/* current->isol_info is only allocated/freed from task
+	 * context.
+	 */
+	if (!current->isol_info) {
+		isol_info = tsk_isol_alloc_context();
+		if (IS_ERR(isol_info))
+			return PTR_ERR(isol_info);
+		current->isol_info = isol_info;
+	}
+
+	isol_info = current->isol_info;
+	switch (feat) {
+	case ISOL_F_QUIESCE:
+		isol_info->quiesce_mask = arg3;
+		isol_info->conf_mask |= ISOL_F_QUIESCE;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+int __copy_task_isolation(struct task_struct *tsk)
+{
+	struct isol_info *info, *new_info;
+
+	info = current->isol_info;
+	if (!(info->inherit_mask & (ISOL_INHERIT_CONF|ISOL_INHERIT_ACTIVE)))
+		return 0;
+
+	new_info = tsk_isol_alloc_context();
+	if (IS_ERR(new_info))
+		return PTR_ERR(new_info);
+
+	new_info->inherit_mask = info->inherit_mask;
+
+	if (info->inherit_mask & ISOL_INHERIT_CONF) {
+		new_info->quiesce_mask = info->quiesce_mask;
+		new_info->conf_mask = info->conf_mask;
+	}
+
+	if (info->inherit_mask & ISOL_INHERIT_ACTIVE)
+		new_info->active_mask = info->active_mask;
+
+	tsk->isol_info = new_info;
+
+	return 0;
+}
+
+int prctl_task_isolation_int_get(unsigned long cmd, void __user *addr,
+				 unsigned long arg4, unsigned long arg5)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case INHERIT_CFG: {
+		struct task_isol_inherit_control *i_ctrl;
+
+		if (!current->isol_info)
+			return -EINVAL;
+
+		i_ctrl = kzalloc(sizeof(struct task_isol_inherit_control),
+				 GFP_KERNEL);
+		if (!i_ctrl)
+			return -ENOMEM;
+
+		i_ctrl->inherit_mask = current->isol_info->inherit_mask;
+
+		if (copy_to_user(addr, i_ctrl, sizeof(*i_ctrl)))
+			ret = -EFAULT;
+		kfree(i_ctrl);
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+int prctl_task_isolation_int_set(unsigned long cmd, void __user *addr,
+				 unsigned long arg4, unsigned long arg5)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case INHERIT_CFG: {
+		struct task_isol_inherit_control *i_ctrl;
+
+		i_ctrl = kzalloc(sizeof(struct task_isol_inherit_control),
+				 GFP_KERNEL);
+		if (!i_ctrl)
+			return -ENOMEM;
+
+		ret = -EFAULT;
+		if (copy_from_user(i_ctrl, addr, sizeof(*i_ctrl)))
+			goto out_free;
+
+		ret = -EINVAL;
+		if (i_ctrl->inherit_mask & ~(ISOL_INHERIT_CONF|ISOL_INHERIT_ACTIVE))
+			goto out_free;
+
+		if (i_ctrl->inherit_mask & ISOL_INHERIT_ACTIVE)
+			if (!(i_ctrl->inherit_mask & ISOL_INHERIT_CONF))
+				goto out_free;
+
+		if (!current->isol_info) {
+			struct isol_info *isol_info;
+
+			isol_info = tsk_isol_alloc_context();
+			if (IS_ERR(isol_info)) {
+				ret = PTR_ERR(isol_info);
+				goto out_free;
+			}
+			current->isol_info = isol_info;
+		}
+
+		ret = 0;
+		current->isol_info->inherit_mask = i_ctrl->inherit_mask;
+out_free:
+		kfree(i_ctrl);
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+
+int prctl_task_isolation_ctrl_set(unsigned long feat, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5)
+{
+	struct isol_info *isol_info;
+
+	if (feat != ISOL_F_QUIESCE && feat != 0)
+		return -EINVAL;
+
+	isol_info = current->isol_info;
+	if (!isol_info)
+		return -EINVAL;
+	isol_info->active_mask = feat;
+
+	return 0;
+}
+
+int prctl_task_isolation_ctrl_get(unsigned long arg2, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5)
+{
+	int ret = 0;
+
+	if (current->isol_info)
+		ret = current->isol_info->active_mask;
+
+	return ret;
+}


