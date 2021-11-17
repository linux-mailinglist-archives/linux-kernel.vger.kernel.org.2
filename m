Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01855454833
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhKQOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:11:14 -0500
Received: from foss.arm.com ([217.140.110.172]:57356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238187AbhKQOLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:11:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31DE31435;
        Wed, 17 Nov 2021 06:08:13 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A39EE3F70D;
        Wed, 17 Nov 2021 06:08:10 -0800 (PST)
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
Subject: [PATCH 7/9] arm64: Make profile_pc() use arch_stack_walk()
Date:   Wed, 17 Nov 2021 14:07:35 +0000
Message-Id: <20211117140737.44420-8-mark.rutland@arm.com>
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

Currently profile_pc() walks the stack of an interrupted context by
calling start_backtrace() with the context's PC and FP, and iterating
unwind steps using walk_stackframe(). This is functionally equivalent to
calling arch_stack_walk() with the interrupted context's pt_regs, which
will start with the PC and FP from the regs.

Make profile_pc() use arch_stack_walk(). This simplifies profile_pc(),
and in future will alow us to make walk_stackframe() private to
stacktrace.c.

At the same time, we remove the early return for when regs->pc is not in
lock functions, as this will be handled by the first call to the
profile_pc_cb() callback.

There should be no functional change as a result of this patch.

Signed-off-by: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
[Mark: remove unnecessary early return, elaborate commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/time.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index eebbc8d7123e..070d4427327f 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -32,22 +32,23 @@
 #include <asm/stacktrace.h>
 #include <asm/paravirt.h>
 
-unsigned long profile_pc(struct pt_regs *regs)
+static bool profile_pc_cb(void *arg, unsigned long pc)
 {
-	struct stackframe frame;
+	unsigned long *prof_pc = arg;
 
-	if (!in_lock_functions(regs->pc))
-		return regs->pc;
+	if (in_lock_functions(pc))
+		return true;
+	*prof_pc = pc;
+	return false;
+}
 
-	start_backtrace(&frame, regs->regs[29], regs->pc);
+unsigned long profile_pc(struct pt_regs *regs)
+{
+	unsigned long prof_pc = 0;
 
-	do {
-		int ret = unwind_frame(NULL, &frame);
-		if (ret < 0)
-			return 0;
-	} while (in_lock_functions(frame.pc));
+	arch_stack_walk(profile_pc_cb, &prof_pc, current, regs);
 
-	return frame.pc;
+	return prof_pc;
 }
 EXPORT_SYMBOL(profile_pc);
 
-- 
2.11.0

