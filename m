Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493A845482F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 15:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhKQOLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 09:11:00 -0500
Received: from foss.arm.com ([217.140.110.172]:57214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238179AbhKQOK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 09:10:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF2F11B3;
        Wed, 17 Nov 2021 06:07:59 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 538DB3F70D;
        Wed, 17 Nov 2021 06:07:57 -0800 (PST)
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
Subject: [PATCH 3/9] arm64: Mark __switch_to() as __sched
Date:   Wed, 17 Nov 2021 14:07:31 +0000
Message-Id: <20211117140737.44420-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211117140737.44420-1-mark.rutland@arm.com>
References: <20211117140737.44420-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike most architectures (and only in keeping with powerpc), arm64 has
a non __sched() function on the path to our cpu_switch_to() assembly
function.

It is expected that for a blocked task, in_sched_functions() can be used
to skip all functions between the raw context switch assembly and the
scheduler functions that call into __switch_to(). This is the behaviour
expected by stack_trace_consume_entry_nosched(), and the behaviour we'd
like to have such that we an simplify arm64's __get_wchan()
implementation to use arch_stack_walk().

This patch mark's arm64's __switch_to as __sched. This *will not* change
the behaviour of arm64's current __get_wchan() implementation, which
always performs an initial unwind step which skips __switch_to(). This
*will* change the behaviour of stack_trace_consume_entry_nosched() and
stack_trace_save_tsk() to match their expected behaviour on blocked
tasks, skipping all scheduler-internal functions including
__switch_to().

Other than the above, there should be no functional change as a result
of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index aacf2f5559a8..980cad7292af 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -490,7 +490,8 @@ void update_sctlr_el1(u64 sctlr)
 /*
  * Thread switching.
  */
-__notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
+__notrace_funcgraph __sched
+struct task_struct *__switch_to(struct task_struct *prev,
 				struct task_struct *next)
 {
 	struct task_struct *last;
-- 
2.11.0

