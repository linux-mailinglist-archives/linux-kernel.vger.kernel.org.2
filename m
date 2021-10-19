Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686D9433B33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbhJSPxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233552AbhJSPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634658652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tHnOevJ/6q1DnnyRs3OtFQTeo9S8lRCNyynYP/60PBU=;
        b=hpLQe1qbktYHCdpl2MdcXrCy8f0eyHxgp0QRNO40+CuDryOj8v5PumDASaZ7z+prCyvMhv
        MlOi97dcZbc+94d920NfewSH37GYWPKy32KYD23o9FRTNt/cL82UkgNx7R0DMbl81JvKJh
        6jlWxCgDSWylA7Q2G2mapoIG03+ykuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-yO4SvrEwM8aRydrX_eCJcw-1; Tue, 19 Oct 2021 11:50:48 -0400
X-MC-Unique: yO4SvrEwM8aRydrX_eCJcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8559610B394D;
        Tue, 19 Oct 2021 15:50:47 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8FC55D6D5;
        Tue, 19 Oct 2021 15:50:46 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id CDE324172EE3; Tue, 19 Oct 2021 12:49:35 -0300 (-03)
Message-ID: <20211019154210.670213643@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 19 Oct 2021 12:24:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v5 1/8] add basic task isolation prctl interface
References: <20211019152431.885037499@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
v4:
 - Switch to structures for parameters when possible
   (which are more extensible).
 - Switch to CFG_{S,G}ET naming and use drop
   "internal configuration" prctls            (Frederic Weisbecker).

v3:

 - Split in smaller patches              (Nitesh Lal).
 - Misc cleanups                         (Nitesh Lal).
 - Clarify nohz_full is not a dependency (Nicolas Saenz).
 - Incorrect values for prctl definitions (kernel robot).
 - Save configured state, so applications
   can activate externally configured
   task isolation parameters.
-  Remove "system default" notion (chisol should
   make it obsolete).

v2:

- Finer-grained control of quiescing (Frederic Weisbecker / Nicolas Saenz).
- Avoid potential regressions by allowing applications
  to use ISOL_F_QUIESCE_DEFMASK (whose default value
  is configurable in /sys/).         (Nitesh Lal / Nicolas Saenz).

 include/linux/sched.h          |    5 
 include/linux/task_isolation.h |   91 ++++++++++
 include/uapi/linux/prctl.h     |   48 +++++
 init/init_task.c               |    3 
 kernel/Makefile                |    2 
 kernel/fork.c                  |   22 ++
 kernel/sys.c                   |   17 +
 kernel/task_isolation.c        |  357 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 543 insertions(+), 2 deletions(-)

Index: linux-2.6/include/uapi/linux/prctl.h
===================================================================
--- linux-2.6.orig/include/uapi/linux/prctl.h
+++ linux-2.6/include/uapi/linux/prctl.h
@@ -269,4 +269,52 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
 
+#define PR_ISOL_FEAT_GET		63
+#define PR_ISOL_CFG_GET			64
+#define PR_ISOL_CFG_SET			65
+
+/* arg2 to CFG_GET/CFG_SET */
+# define I_CFG_FEAT			1
+# define I_CFG_INHERIT			2
+# define I_CFG_ONESHOT			3
+
+#define PR_ISOL_ACTIVATE_GET		66
+#define PR_ISOL_ACTIVATE_SET		67
+
+# define ISOL_F_QUIESCE			(1UL << 0)
+#  define ISOL_F_QUIESCE_VMSTATS	(1UL << 0)
+
+struct task_isol_quiesce_extensions {
+	__u64 flags;
+	__u64 supported_quiesce_bits;
+	__u64 pad[6];
+};
+
+/*
+ * This structure provides control over
+ * inheritance of task isolation across
+ * clone and fork.
+ */
+struct task_isol_inherit_control {
+	__u8	inherit_mask;
+	__u8	flags;
+	__u8	pad[6];
+};
+
+# define ISOL_INHERIT_CONF		(1UL << 0)
+# define ISOL_INHERIT_ACTIVE		(1UL << 1)
+
+struct task_isol_activate_control {
+	__u64 flags;
+	__u64 quiesce_oneshot_mask;
+	__u64 pad[6];
+};
+
+struct task_isol_quiesce_control {
+	__u64 flags;
+	__u64 quiesce_mask;
+	__u64 pad[6];
+};
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
@@ -2530,6 +2531,22 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
 		break;
 #endif
+	case PR_ISOL_FEAT_GET:
+		error = prctl_task_isolation_feat_get(arg2, arg3, arg4, arg5);
+		break;
+
+	case PR_ISOL_CFG_GET:
+		error = prctl_task_isolation_cfg_get(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_CFG_SET:
+		error = prctl_task_isolation_cfg_set(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_ACTIVATE_GET:
+		error = prctl_task_isolation_activate_get(arg2, arg3, arg4, arg5);
+		break;
+	case PR_ISOL_ACTIVATE_SET:
+		error = prctl_task_isolation_activate_set(arg2, arg3, arg4, arg5);
+		break;
 	default:
 		error = -EINVAL;
 		break;
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -67,6 +67,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct isol_info;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1488,6 +1489,10 @@ struct task_struct {
 	struct callback_head		l1d_flush_kill;
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
@@ -214,6 +214,9 @@ struct task_struct init_task
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
@@ -746,6 +747,7 @@ void __put_task_struct(struct task_struc
 	WARN_ON(refcount_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	tsk_isol_free(tsk);
 	io_uring_free(tsk);
 	cgroup_free(tsk);
 	task_numa_free(tsk, true);
@@ -1585,6 +1587,15 @@ static int copy_io(unsigned long clone_f
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
@@ -2159,7 +2170,9 @@ static __latent_entropy struct task_stru
 	RCU_INIT_POINTER(p->bpf_storage, NULL);
 	p->bpf_ctx = NULL;
 #endif
-
+#ifdef CONFIG_CPU_ISOLATION
+	p->isol_info = NULL;
+#endif
 	/* Perform scheduler related setup. Assign this task to a CPU. */
 	retval = sched_fork(clone_flags, p);
 	if (retval)
@@ -2203,6 +2216,9 @@ static __latent_entropy struct task_stru
 	retval = copy_thread(clone_flags, args->stack, args->stack_size, p, args->tls);
 	if (retval)
 		goto bad_fork_cleanup_io;
+	retval = copy_task_isolation(p);
+	if (retval)
+		goto bad_fork_cleanup_thread;
 
 	stackleak_task_init(p);
 
@@ -2211,7 +2227,7 @@ static __latent_entropy struct task_stru
 				args->set_tid_size);
 		if (IS_ERR(pid)) {
 			retval = PTR_ERR(pid);
-			goto bad_fork_cleanup_thread;
+			goto bad_fork_cleanup_task_isolation;
 		}
 	}
 
@@ -2429,6 +2445,8 @@ bad_fork_put_pidfd:
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
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_TASK_ISOL_H
+#define __LINUX_TASK_ISOL_H
+
+#ifdef CONFIG_CPU_ISOLATION
+
+struct isol_info {
+	/* Which features have been configured */
+	u64 conf_mask;
+	/* Which features are active */
+	u64 active_mask;
+	/* Quiesce mask */
+	u64 quiesce_mask;
+
+	/* Oneshot mask */
+	u64 oneshot_mask;
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
+int prctl_task_isolation_feat_get(unsigned long arg2, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_cfg_get(unsigned long arg2, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_cfg_set(unsigned long arg2, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_activate_get(unsigned long arg2, unsigned long arg3,
+				      unsigned long arg4, unsigned long arg5);
+int prctl_task_isolation_activate_set(unsigned long arg2, unsigned long arg3,
+				      unsigned long arg4, unsigned long arg5);
+
+int __copy_task_isolation(struct task_struct *tsk);
+
+#else
+
+static inline void tsk_isol_free(struct task_struct *tsk)
+{
+}
+
+static inline int prctl_task_isolation_feat_get(unsigned long arg2,
+						unsigned long arg3,
+						unsigned long arg4,
+						unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_cfg_get(unsigned long arg2,
+					       unsigned long arg3,
+					       unsigned long arg4,
+					       unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_cfg_set(unsigned long arg2,
+					       unsigned long arg3,
+					       unsigned long arg4,
+					       unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_activate_get(unsigned long arg2,
+						    unsigned long arg3,
+						    unsigned long arg4,
+						    unsigned long arg5)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int prctl_task_isolation_activate_set(unsigned long arg2,
+						    unsigned long arg3,
+						    unsigned long arg4,
+						    unsigned long arg5)
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
@@ -0,0 +1,357 @@
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
+int prctl_task_isolation_feat_get(unsigned long arg2, unsigned long arg3,
+				  unsigned long arg4, unsigned long arg5)
+{
+	int ret;
+	void __user *addr = (void __user *) arg3;
+
+	switch (arg2) {
+	case 0: {
+		u64 supported_fmask = ISOL_F_QUIESCE;
+
+		ret = 0;
+		if (copy_to_user(addr, &supported_fmask, sizeof(u64)))
+			ret = -EFAULT;
+
+		return ret;
+	}
+	case ISOL_F_QUIESCE: {
+		struct task_isol_quiesce_extensions *q_ext;
+
+		q_ext = kzalloc(sizeof(struct task_isol_quiesce_extensions),
+			 GFP_KERNEL);
+		if (!q_ext)
+			return -ENOMEM;
+
+		q_ext->supported_quiesce_bits = ISOL_F_QUIESCE_VMSTATS;
+
+		ret = 0;
+		if (copy_to_user(addr, q_ext, sizeof(*q_ext)))
+			ret = -EFAULT;
+		kfree(q_ext);
+		return ret;
+	}
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static int cfg_inherit_get(unsigned long arg3, unsigned long arg4,
+			   unsigned long arg5)
+{
+	struct task_isol_inherit_control *i_ctrl;
+	int ret;
+	void __user *addr = (void __user *) arg3;
+
+	if (!current->isol_info)
+		return -EINVAL;
+
+	i_ctrl = kzalloc(sizeof(struct task_isol_inherit_control),
+			 GFP_KERNEL);
+	if (!i_ctrl)
+		return -ENOMEM;
+
+	i_ctrl->inherit_mask = current->isol_info->inherit_mask;
+
+	ret = 0;
+	if (copy_to_user(addr, i_ctrl, sizeof(*i_ctrl)))
+		ret = -EFAULT;
+	kfree(i_ctrl);
+
+	return ret;
+}
+
+static int cfg_feat_get(unsigned long arg3, unsigned long arg4,
+			unsigned long arg5)
+{
+	int ret = 0;
+	void __user *addr = (void __user *)arg4;
+
+	switch (arg3) {
+	case 0: {
+		u64 cfg_mask = 0;
+
+		if (current->isol_info)
+			cfg_mask = current->isol_info->conf_mask;
+
+		if (copy_to_user(addr, &cfg_mask, sizeof(u64)))
+			ret = -EFAULT;
+
+		return ret;
+	}
+	case ISOL_F_QUIESCE: {
+		struct task_isol_quiesce_control *i_qctrl;
+
+		i_qctrl = kzalloc(sizeof(struct task_isol_quiesce_control),
+				  GFP_KERNEL);
+		if (!i_qctrl)
+			return -ENOMEM;
+
+		if (current->isol_info)
+			i_qctrl->quiesce_mask = current->isol_info->quiesce_mask;
+
+		if (copy_to_user(addr, i_qctrl, sizeof(*i_qctrl)))
+			ret = -EFAULT;
+
+		kfree(i_qctrl);
+		return ret;
+	}
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+int prctl_task_isolation_cfg_get(unsigned long arg2, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5)
+{
+	switch (arg2) {
+	case I_CFG_FEAT:
+		return cfg_feat_get(arg3, arg4, arg5);
+	case I_CFG_INHERIT:
+		return cfg_inherit_get(arg3, arg4, arg5);
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static int cfg_inherit_set(unsigned long arg3, unsigned long arg4,
+			   unsigned long arg5)
+{
+	int ret = 0;
+	struct task_isol_inherit_control *i_ctrl;
+	const void __user *addr = (const void __user *)arg3;
+
+	i_ctrl = kzalloc(sizeof(struct task_isol_inherit_control),
+			 GFP_KERNEL);
+	if (!i_ctrl)
+		return -ENOMEM;
+
+	ret = -EFAULT;
+	if (copy_from_user(i_ctrl, addr, sizeof(*i_ctrl)))
+		goto out_free;
+
+	ret = -EINVAL;
+	if (i_ctrl->inherit_mask & ~(ISOL_INHERIT_CONF|ISOL_INHERIT_ACTIVE))
+		goto out_free;
+
+	if (i_ctrl->inherit_mask & ISOL_INHERIT_ACTIVE)
+		if (!(i_ctrl->inherit_mask & ISOL_INHERIT_CONF))
+			goto out_free;
+
+	if (!current->isol_info) {
+		struct isol_info *isol_info;
+
+		isol_info = tsk_isol_alloc_context();
+		if (IS_ERR(isol_info)) {
+			ret = PTR_ERR(isol_info);
+			goto out_free;
+		}
+		current->isol_info = isol_info;
+	}
+
+	ret = 0;
+	current->isol_info->inherit_mask = i_ctrl->inherit_mask;
+
+out_free:
+	kfree(i_ctrl);
+
+	return ret;
+}
+
+static int cfg_feat_quiesce_set(unsigned long arg4, unsigned long arg5)
+{
+	int ret = 0;
+	struct isol_info *isol_info;
+	struct task_isol_quiesce_control *i_qctrl;
+	const void __user *addr = (const void __user *)arg4;
+
+	i_qctrl = kzalloc(sizeof(struct task_isol_quiesce_control),
+			 GFP_KERNEL);
+	if (!i_qctrl)
+		return -ENOMEM;
+
+	ret = -EFAULT;
+	if (copy_from_user(i_qctrl, addr, sizeof(*i_qctrl)))
+		goto out_free;
+
+	ret = -EINVAL;
+	if (i_qctrl->flags != 0)
+		goto out_free;
+
+	if (i_qctrl->quiesce_mask != ISOL_F_QUIESCE_VMSTATS &&
+	    i_qctrl->quiesce_mask != 0)
+		goto out_free;
+
+	/* current->isol_info is only allocated/freed from task
+	 * context.
+	 */
+	if (!current->isol_info) {
+		isol_info = tsk_isol_alloc_context();
+		if (IS_ERR(isol_info)) {
+			ret = PTR_ERR(isol_info);
+			goto out_free;
+		}
+		current->isol_info = isol_info;
+	}
+
+	isol_info = current->isol_info;
+
+	isol_info->quiesce_mask = i_qctrl->quiesce_mask;
+	isol_info->conf_mask |= ISOL_F_QUIESCE;
+	ret = 0;
+
+out_free:
+	kfree(i_qctrl);
+
+	return ret;
+}
+
+int prctl_task_isolation_cfg_set(unsigned long arg2, unsigned long arg3,
+				 unsigned long arg4, unsigned long arg5)
+{
+	switch (arg2) {
+	case I_CFG_FEAT:
+		switch (arg3) {
+		case ISOL_F_QUIESCE:
+			return cfg_feat_quiesce_set(arg4, arg5);
+		default:
+			break;
+		}
+		break;
+	case I_CFG_INHERIT:
+		return cfg_inherit_set(arg3, arg4, arg5);
+	default:
+		break;
+	}
+	return -EINVAL;
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
+int prctl_task_isolation_activate_set(unsigned long arg2, unsigned long arg3,
+				      unsigned long arg4, unsigned long arg5)
+{
+	int ret;
+	struct isol_info *isol_info;
+	u64 oneshot_mask, active_mask;
+	const void __user *addr_mask = (const void __user *)arg2;
+	const void __user *addr_ctrl = (const void __user *)arg3;
+
+	oneshot_mask = active_mask = 0;
+
+	ret = -EFAULT;
+	if (copy_from_user(&active_mask, addr_mask, sizeof(u64)))
+		goto out;
+
+	ret = -EINVAL;
+	if (active_mask != ISOL_F_QUIESCE && active_mask != 0)
+		return ret;
+
+	isol_info = current->isol_info;
+	if (!isol_info)
+		return ret;
+
+	if (addr_ctrl != NULL) {
+		struct task_isol_activate_control act_ctrl;
+
+		ret = -EFAULT;
+		if (copy_from_user(&act_ctrl, addr_ctrl, sizeof(act_ctrl)))
+			goto out;
+
+		ret = -EINVAL;
+		if (act_ctrl.flags)
+			goto out;
+
+		if (act_ctrl.quiesce_oneshot_mask != ISOL_F_QUIESCE_VMSTATS &&
+		    act_ctrl.quiesce_oneshot_mask != 0)
+			goto out;
+
+		oneshot_mask = act_ctrl.quiesce_oneshot_mask;
+	}
+
+	isol_info->active_mask = active_mask;
+	isol_info->oneshot_mask = oneshot_mask;
+	ret = 0;
+
+out:
+	return ret;
+}
+
+int prctl_task_isolation_activate_get(unsigned long arg2, unsigned long arg3,
+				      unsigned long arg4, unsigned long arg5)
+{
+	int ret = 0;
+
+	if (current->isol_info)
+		ret = current->isol_info->active_mask;
+
+	return ret;
+}
+


