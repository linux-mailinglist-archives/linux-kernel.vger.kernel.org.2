Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCDD32DA15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238182AbhCDTHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:07:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237831AbhCDTHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:07:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B99364F79;
        Thu,  4 Mar 2021 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884776;
        bh=Ktk0H1RA0BdtnmHXEm/of5tm/WQlyCcZUk9EHpI/Anw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4LXxD4vDeM5z/0JShtcly4N36bWdPD4bkQlsj2iYNvFE2QIm3VSyUv2LHxpTaaD3
         QqjvfCicII5jLKch4ofBJPukF30Jl6mDQE7CTfqE3DN4r2Rjcz1WUVa51SieNEVj1L
         eY/Di2Fq6NmyfHpx1uqqi5EmhosefBM/J7cE9zMXxKO9ldggMwGGg4dOgnUKHRovfp
         AriV1H6fZAiLQXhhHSFtlhRO1xSbFfYLdCjq6r9vIm7zB6AZ5iOfEbq1zFOICD0MGX
         dIW4S6/qkzI5q/CxcBL1jk/W8yUOLOisgZOLz011lHe9e02Jqm7IyEC0N7aHD062Km
         Qd/izk2YmyeDA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 10/11] kentry: Check that syscall entries and syscall exits match
Date:   Thu,  4 Mar 2021 11:06:03 -0800
Message-Id: <c88f24ac2ad4e0ee1ae1f43a2fa115d17a0aa6b2.1614884673.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614884673.git.luto@kernel.org>
References: <cover.1614884673.git.luto@kernel.org>
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
 include/linux/sched.h |  4 ++++
 init/init_task.c      |  8 ++++++++
 kernel/entry/common.c | 24 +++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6e3a5eeec509..95d6d8686d98 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1368,6 +1368,10 @@ struct task_struct {
 	struct llist_head               kretprobe_instances;
 #endif
 
+#ifdef CONFIG_DEBUG_ENTRY
+	bool kentry_in_syscall;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/init/init_task.c b/init/init_task.c
index 8a992d73e6fb..de4fdaac4e8b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -212,6 +212,14 @@ struct task_struct init_task
 #ifdef CONFIG_SECCOMP
 	.seccomp	= { .filter_count = ATOMIC_INIT(0) },
 #endif
+#ifdef CONFIG_DEBUG_ENTRY
+	/*
+	 * The init task, and kernel threads in general, are considered
+	 * to be "in a syscall".  This way they can execve() and then exit
+	 * the supposed syscall that they were in to go to user mode.
+	 */
+	.kentry_in_syscall = true,
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f62934d761e3..9dea411de3b0 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -148,11 +148,21 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 
 long kentry_syscall_begin(struct pt_regs *regs, long syscall)
 {
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+	unsigned long work;
+
+	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
+		DEBUG_ENTRY_WARN_ONCE(
+			current->kentry_in_syscall,
+			"entering syscall %ld while already in a syscall",
+			syscall);
+		current->kentry_in_syscall = true;
+	}
 
 	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
 	lockdep_assert_irqs_enabled();
 
+	work = READ_ONCE(current_thread_info()->syscall_work);
+
 	if (work & SYSCALL_WORK_ENTER)
 		syscall = syscall_trace_enter(regs, syscall, work);
 
@@ -163,11 +173,16 @@ long kentry_syscall_begin(struct pt_regs *regs, long syscall)
 static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
+
 #ifdef CONFIG_DEBUG_ENTRY
 	DEBUG_ENTRY_WARN_ONCE(this_cpu_read(kentry_cpu_depth) != 1,
 			      "__exit_to_user_mode called at wrong kentry cpu depth (%u)",
 			      this_cpu_read(kentry_cpu_depth));
+
+	DEBUG_ENTRY_WARN_ONCE(current->kentry_in_syscall,
+			      "exiting to user mode while in syscall context");
 #endif
+
 	trace_hardirqs_on_prepare();
 	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	instrumentation_end();
@@ -331,6 +346,13 @@ void kentry_syscall_end(struct pt_regs *regs)
 	 */
 	if (unlikely(work & SYSCALL_WORK_EXIT))
 		syscall_exit_work(regs, work);
+
+#ifdef CONFIG_DEBUG_ENTRY
+	DEBUG_ENTRY_WARN_ONCE(!current->kentry_in_syscall,
+			      "exiting syscall %lu without entering first", nr);
+
+	current->kentry_in_syscall = 0;
+#endif
 }
 
 noinstr void kentry_enter_from_user_mode(struct pt_regs *regs)
-- 
2.29.2

