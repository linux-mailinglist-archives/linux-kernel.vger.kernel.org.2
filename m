Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3833F7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhCQSNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232950AbhCQSM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E743464F40;
        Wed, 17 Mar 2021 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616004776;
        bh=Cy67C7Z7d7LL0ijZ6YWpzWsRX7BTC1I4ZcP/ARReO4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpYG/x9Y3I3hTpyo0T8d5Oj/Dokm1ogvxc2WUjXn0w1Cs44CTbW6l8FthDMRhyWi0
         P7lQaUlGq02oH2vqe70ZR44eZmpD05FakV3ix3rlNYifNtL82wzPPtKFr32yhhrkco
         YYX3tjCAYp6EhFPnPYr3t3IBjfnLwyKLBRZTqQtgfSxa7hlxZmuQ4g4X/vF8GzhDmj
         DqQNbKMTw9b0SAVhYUruBFfl1a2TdRn6vr/y9avQtI+rKtsqMb4tnFIMx8Lyz0baBO
         OOcJaTWa/juuuMytsqTHS4EeJLmegIh/qFN+/OP/U79aFRoZhx1bd53xaj5c2xFV9j
         gXTiGAzbd+VFw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 7/9] kentry: Add debugging checks for proper kentry API usage
Date:   Wed, 17 Mar 2021 11:12:46 -0700
Message-Id: <df38bc3aa82dc122c88bf902f6922ab7c22bf783.1616004689.git.luto@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616004689.git.luto@kernel.org>
References: <cover.1616004689.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's quite easy to mess up kentry calls.  Add debgging checks that kentry
transitions to and from user mode match up and that kentry_nmi_enter() and
kentry_nmi_exit() match up.

Checking full matching of kentry_enter() with kentry_exit() needs
per-task state.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 kernel/entry/common.c | 81 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 6fbe1c109877..8ba774184e00 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,9 +11,65 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+/*
+ * kentry_cpu_depth is 0 in user mode, 1 in normal kernel mode, and
+ * 1 + n * KENTRY_DEPTH_NMI in kentry_nmi_enter() mode.  We can't
+ * use a percpu variable to match up kentry_enter() from kernel mode
+ * with the corresponding kentry_exit() because tasks may schedule inside
+ * nested kentry_enter() regions.
+ */
+#define KENTRY_CPU_DEPTH_NMI	1024UL
+
+#ifdef CONFIG_DEBUG_ENTRY
+
+/*
+ * Extra safe WARN_ONCE.  Per-arch optimized WARN_ONCE() implementations
+ * might go through the low-level entry and kentry code even before noticing
+ * that the warning already fired, which could result in recursive warnings.
+ * This carefully avoids any funny business once a given warning has fired.
+ */
+#define DEBUG_ENTRY_WARN_ONCE(condition, format...) ({		\
+	static bool __section(".data.once") __warned;		\
+	int __ret_warn_once = !!(condition);			\
+								\
+	if (unlikely(__ret_warn_once && !READ_ONCE(__warned))) {\
+		WRITE_ONCE(__warned, true);			\
+		WARN(1, format);				\
+	}							\
+	unlikely(__ret_warn_once);				\
+})
+
+
+static DEFINE_PER_CPU(unsigned int, kentry_cpu_depth) = 1UL;
+
+static __always_inline void kentry_cpu_depth_add(unsigned int n)
+{
+	this_cpu_add(kentry_cpu_depth, n);
+}
+
+static void kentry_cpu_depth_check(unsigned int n)
+{
+	DEBUG_ENTRY_WARN_ONCE(this_cpu_read(kentry_cpu_depth) < n, "kentry depth underflow");
+}
+
+static __always_inline void kentry_cpu_depth_sub(unsigned int n)
+{
+	this_cpu_sub(kentry_cpu_depth, n);
+}
+#else
+
+#define DEBUG_ENTRY_WARN_ONCE(condition, format...) do {} while (0)
+
+static __always_inline void kentry_cpu_depth_add(unsigned int n) {}
+static void kentry_cpu_depth_check(unsigned int n) {}
+static __always_inline void kentry_cpu_depth_sub(unsigned int n) {}
+
+#endif
+
 /* See comment for enter_from_user_mode() in entry-common.h */
 static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
+	kentry_cpu_depth_add(1);
 	arch_check_user_regs(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
 
@@ -22,6 +78,14 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 
 	instrumentation_begin();
 	trace_hardirqs_off_finish();
+
+#ifdef CONFIG_DEBUG_ENTRY
+	DEBUG_ENTRY_WARN_ONCE(
+		this_cpu_read(kentry_cpu_depth) != 1,
+		"kentry: __enter_from_user_mode() called while kentry thought the CPU was in the kernel (%u)",
+		this_cpu_read(kentry_cpu_depth));
+#endif
+
 	instrumentation_end();
 }
 
@@ -92,6 +156,11 @@ long kentry_syscall_begin(struct pt_regs *regs, long syscall)
 static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
+#ifdef CONFIG_DEBUG_ENTRY
+	DEBUG_ENTRY_WARN_ONCE(this_cpu_read(kentry_cpu_depth) != 1,
+			      "__exit_to_user_mode called at wrong kentry cpu depth (%u)",
+			      this_cpu_read(kentry_cpu_depth));
+#endif
 	trace_hardirqs_on_prepare();
 	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	instrumentation_end();
@@ -99,6 +168,7 @@ static __always_inline void __exit_to_user_mode(void)
 	user_enter_irqoff();
 	arch_exit_to_user_mode();
 	lockdep_hardirqs_on(CALLER_ADDR0);
+	kentry_cpu_depth_sub(1);
 }
 
 /* Workaround to allow gradual conversion of architecture code */
@@ -346,7 +416,12 @@ noinstr void kentry_exit(struct pt_regs *regs, kentry_state_t state)
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		kentry_exit_to_user_mode(regs);
-	} else if (!regs_irqs_disabled(regs)) {
+		return;
+	}
+
+	kentry_cpu_depth_check(1);
+
+	if (!regs_irqs_disabled(regs)) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
 		 * carefully and needs the same ordering of lockdep/tracing
@@ -385,6 +460,8 @@ kentry_state_t noinstr kentry_nmi_enter(struct pt_regs *regs)
 
 	irq_state.lockdep = lockdep_hardirqs_enabled();
 
+	kentry_cpu_depth_add(KENTRY_CPU_DEPTH_NMI);
+
 	__nmi_enter();
 	lockdep_hardirqs_off(CALLER_ADDR0);
 	lockdep_hardirq_enter();
@@ -401,6 +478,7 @@ kentry_state_t noinstr kentry_nmi_enter(struct pt_regs *regs)
 void noinstr kentry_nmi_exit(struct pt_regs *regs, kentry_state_t irq_state)
 {
 	instrumentation_begin();
+	kentry_cpu_depth_check(KENTRY_CPU_DEPTH_NMI);
 	ftrace_nmi_exit();
 	if (irq_state.lockdep) {
 		trace_hardirqs_on_prepare();
@@ -413,4 +491,5 @@ void noinstr kentry_nmi_exit(struct pt_regs *regs, kentry_state_t irq_state)
 	if (irq_state.lockdep)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 	__nmi_exit();
+	kentry_cpu_depth_sub(KENTRY_CPU_DEPTH_NMI);
 }
-- 
2.30.2

