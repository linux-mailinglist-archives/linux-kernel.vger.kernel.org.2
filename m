Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4832258E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhBWFvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhBWFvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:51:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DA4164E4D;
        Tue, 23 Feb 2021 05:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614059433;
        bh=FU04Z3uONMTAV1M7tOSu6/T7aaKEMhBS/a1JpR1XhlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGlrpAR57bjJ2K6ovLkZvhuoynIroGygP5VvHUf0ZgsDqb18m82bRyAmUw4Jx9v6m
         zzibr062x34VFDBWY6pycBKOZfUYhnKavp3QYtSCCiIdgnTzEXQ8gspSmyXUORDnm0
         QUREP+uit26XD7wsMSW1SFS1KMrekUabWO1d6yjN7t4MBY2wriKjUSEXijxKezeF8n
         +5ZpwtEQ3SCve+4wqf3JK8+sJUQQA2tvDYZ2NYU3vDOpH4eFY047wyM/hHnxh//I91
         v+JanoLX4v5rBwKCSVtPkKdY4fC1bg9sjM9As+YfbrYUoYizK7KOKSGn2ta8/ooekC
         fL/abgfra+Qog==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] entry: Check that syscall entries and syscall exits match
Date:   Mon, 22 Feb 2021 21:50:27 -0800
Message-Id: <fb6f42d81eaaec2c4b3bcb657f0dd7d7bdc136c9.1614059335.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614059335.git.luto@kernel.org>
References: <cover.1614059335.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If arch code calls the wrong kernel entry helpers, syscall entries and
exits can get out of sync.  Add a new field to task_struct to track the
syscall state and validate that it transitions correctly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

I'm not in love with this patch.  I'm imagining moving TS_COMPAT and such
into the new kentry_syscall_state field.  What do you all think?

 include/linux/entry-common.h | 11 +++++++++++
 include/linux/sched.h        |  1 +
 init/init_task.c             |  9 +++++++++
 kernel/entry/common.c        | 25 ++++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ca86a00abe86..c2463b6b71fe 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -60,6 +60,17 @@
 	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
 
+/*
+ * task_struct::kentry_syscall_state
+ *
+ * kentry_syscall_state is reset to zero on syscall exit.  For efficiency
+ * reasons, if CONFIG_PROVE_LOCKING=n, kentry_syscall_state is permitted
+ * to remain 0 even inside a syscall.
+ */
+#ifdef CONFIG_PROVE_LOCKING
+# define KENTRY_SYSCALL_STATE_IN_SYSCALL		1
+#endif
+
 /**
  * arch_check_user_regs - Architecture specific sanity check for user mode regs
  * @regs:	Pointer to currents pt_regs
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e3a5eeec509..691057a3b48d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1002,6 +1002,7 @@ struct task_struct {
 #endif
 	struct seccomp			seccomp;
 	struct syscall_user_dispatch	syscall_dispatch;
+	u32				kentry_syscall_state;
 
 	/* Thread group tracking: */
 	u64				parent_exec_id;
diff --git a/init/init_task.c b/init/init_task.c
index 8a992d73e6fb..91050c4f0bb3 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -12,6 +12,7 @@
 #include <linux/audit.h>
 #include <linux/numa.h>
 #include <linux/scs.h>
+#include <linux/entry-common.h>
 
 #include <linux/uaccess.h>
 
@@ -212,6 +213,14 @@ struct task_struct init_task
 #ifdef CONFIG_SECCOMP
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_PROVE_LOCKING
+	/*
+	 * The init task, and kernel threads in general, are considered
+	 * to be "in a syscall".  This way they can execve() and then exit
+	 * the supposed syscall that they were in to go to user mode.
+	 */
+	.kentry_syscall_state = KENTRY_SYSCALL_STATE_IN_SYSCALL,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 378341642f94..7e971b866ad2 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -83,7 +83,16 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 static __always_inline long
 __syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
 {
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+	unsigned long work;
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		WARN_ONCE(current->kentry_syscall_state,
+			  "entering syscall %ld while already in a syscall",
+			  syscall);
+		current->kentry_syscall_state = KENTRY_SYSCALL_STATE_IN_SYSCALL;
+	}
+
+	work = READ_ONCE(current_thread_info()->syscall_work);
 
 	if (work & SYSCALL_WORK_ENTER)
 		syscall = syscall_trace_enter(regs, syscall, work);
@@ -195,6 +204,12 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
 
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		WARN_ONCE(current->kentry_syscall_state &
+			  KENTRY_SYSCALL_STATE_IN_SYSCALL,
+			  "exiting to user mode while in syscall context");
+	}
+
 	lockdep_assert_irqs_disabled();
 
 	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
@@ -282,6 +297,14 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 	 */
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		WARN_ONCE(!(current->kentry_syscall_state &
+			    KENTRY_SYSCALL_STATE_IN_SYSCALL),
+			  "exiting syscall %lu without entering first", nr);
+	}
+
+	current->kentry_syscall_state = 0;
 }
 
 static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
-- 
2.29.2

