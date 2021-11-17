Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BA454830
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238210AbhKQOLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:11:04 -0500
Received: from foss.arm.com ([217.140.110.172]:57252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238207AbhKQOLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:11:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C0C61396;
        Wed, 17 Nov 2021 06:08:03 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AD6FD3F70D;
        Wed, 17 Nov 2021 06:08:00 -0800 (PST)
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
Subject: [PATCH 4/9] arm64: Make perf_callchain_kernel() use arch_stack_walk()
Date:   Wed, 17 Nov 2021 14:07:32 +0000
Message-Id: <20211117140737.44420-5-mark.rutland@arm.com>
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

Currently perf_callchain_kernel() walks the stack of an interrupted
context by calling start_backtrace() with the context's PC and FP, and
iterating unwind steps using walk_stackframe(). This is functionally
equivalent to calling arch_stack_walk() with the interrupted context's
pt_regs, which will start with the PC and FP from the regs.

Make perf_callchain_kernel() use arch_stack_walk(). This simplifies
perf_callchain_kernel(), and in future will alow us to make
walk_stackframe() private to stacktrace.c.

At the same time, we update the callchain_trace() callback to check the
return value of perf_callchain_store(), which indicates whether there is
space for any further entries. When a non-zero value is returned,
further calls will be ignored, and are redundant, so we can stop the
unwind at this point.

We also remove the stale and confusing comment for callchain_trace.

There should be no functional change as a result of this patch.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
[Mark: elaborate commit message, remove comment]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/perf_callchain.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 4a72c2727309..2160a53272b7 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -132,30 +132,21 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 	}
 }
 
-/*
- * Gets called by walk_stackframe() for every stackframe. This will be called
- * whist unwinding the stackframe and is like a subroutine return so we use
- * the PC.
- */
 static bool callchain_trace(void *data, unsigned long pc)
 {
 	struct perf_callchain_entry_ctx *entry = data;
-	perf_callchain_store(entry, pc);
-	return true;
+	return perf_callchain_store(entry, pc) == 0;
 }
 
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
-	struct stackframe frame;
-
 	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
 		/* We don't support guest os callchain now */
 		return;
 	}
 
-	start_backtrace(&frame, regs->regs[29], regs->pc);
-	walk_stackframe(current, &frame, callchain_trace, entry);
+	arch_stack_walk(callchain_trace, entry, current, regs);
 }
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
-- 
2.11.0

