Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13884454831
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbhKQOLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:11:08 -0500
Received: from foss.arm.com ([217.140.110.172]:57286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238172AbhKQOLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:11:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9378D13A1;
        Wed, 17 Nov 2021 06:08:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F5333F70D;
        Wed, 17 Nov 2021 06:08:03 -0800 (PST)
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
Subject: [PATCH 5/9] arm64: Make __get_wchan() use arch_stack_walk()
Date:   Wed, 17 Nov 2021 14:07:33 +0000
Message-Id: <20211117140737.44420-6-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117140737.44420-1-mark.rutland@arm.com>
References: <20211117140737.44420-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

To enable RELIABLE_STACKTRACE and LIVEPATCH on arm64, we need to
substantially rework arm64's unwinding code. As part of this, we want to
minimize the set of unwind interfaces we expose, and avoid open-coding
of unwind logic outside of stacktrace.c.

Currently, __get_wchan() walks the stack of a blocked task by calling
start_backtrace() with the task's saved PC and FP values, and iterating
unwind steps using unwind_frame(). The initialization is functionally
equivalent to calling arch_stack_walk() with the blocked task, which
will start with the task's saved PC and FP values.

Currently __get_wchan() always performs an initial unwind step, which
will stkip __switch_to(), but as this is now marked as a __sched
function, this no longer needs special handling and will be skipped in
the same way as other sched functions.

Make __get_wchan() use arch_stack_walk(). This simplifies __get_wchan(),
and in future will alow us to make unwind_frame() private to
stacktrace.c. At the same time, we can simplify the try_get_task_stack()
check and avoid the unnecessary `stack_page` variable.

The change to the skipping logic means we may terminate one frame
earlier than previously where there are an excessive number of sched
functions in the trace, but this isn't seen in practice, and wchan is
best-effort anyway, so this should not be a problem.

Other than the above, there should be no functional change as a result
of this patch.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
[Mark: rebase atop wchan changes, simplify, elaborate commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/process.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 980cad7292af..2410ef046232 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -529,30 +529,37 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	return last;
 }
 
+struct wchan_info {
+	unsigned long	pc;
+	int		count;
+};
+
+static bool get_wchan_cb(void *arg, unsigned long pc)
+{
+	struct wchan_info *wchan_info = arg;
+
+	if (!in_sched_functions(pc)) {
+		wchan_info->pc = pc;
+		return false;
+	}
+	return wchan_info->count++ < 16;
+}
+
 unsigned long __get_wchan(struct task_struct *p)
 {
-	struct stackframe frame;
-	unsigned long stack_page, ret = 0;
-	int count = 0;
+	struct wchan_info wchan_info = {
+		.pc = 0,
+		.count = 0,
+	};
 
-	stack_page = (unsigned long)try_get_task_stack(p);
-	if (!stack_page)
+	if (!try_get_task_stack(p))
 		return 0;
 
-	start_backtrace(&frame, thread_saved_fp(p), thread_saved_pc(p));
-
-	do {
-		if (unwind_frame(p, &frame))
-			goto out;
-		if (!in_sched_functions(frame.pc)) {
-			ret = frame.pc;
-			goto out;
-		}
-	} while (count++ < 16);
+	arch_stack_walk(get_wchan_cb, &wchan_info, p, NULL);
 
-out:
 	put_task_stack(p);
-	return ret;
+
+	return wchan_info.pc;
 }
 
 unsigned long arch_align_stack(unsigned long sp)
-- 
2.11.0

