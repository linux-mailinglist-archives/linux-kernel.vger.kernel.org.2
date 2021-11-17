Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DE454836
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbhKQOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:11:25 -0500
Received: from foss.arm.com ([217.140.110.172]:57424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238233AbhKQOLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:11:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A86661474;
        Wed, 17 Nov 2021 06:08:19 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 24B403F70D;
        Wed, 17 Nov 2021 06:08:17 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aou@eecs.berkeley.edu, borntraeger@de.ibm.com, bp@alien8.de,
        broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com,
        mpe@ellerman.id.au, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: [PATCH 9/9] arm64: Make some stacktrace functions private
Date:   Wed, 17 Nov 2021 14:07:37 +0000
Message-Id: <20211117140737.44420-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117140737.44420-1-mark.rutland@arm.com>
References: <20211117140737.44420-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that open-coded stack unwinds have been converted to
arch_stack_walk(), we no longer need to expose any of unwind_frame(),
walk_stackframe(), or start_backtrace() outside of stacktrace.c.

Make those functions private to stacktrace.c, removing their prototypes
from <asm/stacktrace.h> and marking them static.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Cc: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/stacktrace.h |  6 ------
 arch/arm64/kernel/stacktrace.c      | 12 +++++++-----
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index 686731b9df05..3a15d376ab36 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -63,9 +63,6 @@ struct stackframe {
 #endif
 };
 
-extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
-extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
-			    bool (*fn)(void *, unsigned long), void *data);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			   const char *loglvl);
 
@@ -150,7 +147,4 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
 	return false;
 }
 
-void start_backtrace(struct stackframe *frame, unsigned long fp,
-		     unsigned long pc);
-
 #endif	/* __ASM_STACKTRACE_H */
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 9fc771a05306..0fb58fed54cb 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -33,8 +33,8 @@
  */
 
 
-void start_backtrace(struct stackframe *frame, unsigned long fp,
-		     unsigned long pc)
+static void start_backtrace(struct stackframe *frame, unsigned long fp,
+			    unsigned long pc)
 {
 	frame->fp = fp;
 	frame->pc = pc;
@@ -63,7 +63,8 @@ void start_backtrace(struct stackframe *frame, unsigned long fp,
  * records (e.g. a cycle), determined based on the location and fp value of A
  * and the location (but not the fp value) of B.
  */
-int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
+static int notrace unwind_frame(struct task_struct *tsk,
+				struct stackframe *frame)
 {
 	unsigned long fp = frame->fp;
 	struct stack_info info;
@@ -141,8 +142,9 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 }
 NOKPROBE_SYMBOL(unwind_frame);
 
-void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
-			     bool (*fn)(void *, unsigned long), void *data)
+static void notrace walk_stackframe(struct task_struct *tsk,
+				    struct stackframe *frame,
+				    bool (*fn)(void *, unsigned long), void *data)
 {
 	while (1) {
 		int ret;
-- 
2.11.0

