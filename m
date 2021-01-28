Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732F9308059
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhA1VRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhA1VR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:17:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18A4C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 13:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vFXdrprJYXLFSPP8UE1ua7upEFkQkB4P+OBl0fVN1/w=; b=ZWuUotXO8UZSCJ6GuCbVCNcbho
        zI3CCKZPFNJBK0yVdakT5lVAnp0ywyNSTXtWQPXfcdxfNHiU+NABEMVn7hKt+E+yZEPcYjcet5tts
        O3GDoSP47nuYMZ2i/B9d6Fg+6n+12RUrEnnevNpzW4/EfgUZIj3+2c5ol6djuFFCXlAopmmEYmhGc
        FkamGzDhVwHdVpOpmnt/e+niMVlqu1MIktl/Q/AuS5I3Xo9yMNPg2jjDk+Rg86XcOg+E++2XTrBYf
        GQWlJqoKGEscsbQOGhEkcxWfbiY5Khf5IuKOivRgBUPy91VLUpycbP9xCMg715YUskW/zVqvlFFuO
        ETNL8USQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l5EeU-008zZK-GN; Thu, 28 Jan 2021 21:16:31 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B650986584; Thu, 28 Jan 2021 22:16:27 +0100 (CET)
Date:   Thu, 28 Jan 2021 22:16:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, tdevries@suse.de
Cc:     linux-kernel@vger.kernel.org, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH v2] x86/debug: Fix DR6 handling
Message-ID: <20210128211627.GB4348@worktop.programming.kicks-ass.net>
References: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBMAbQGACujjfz+i@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom reported that one of the GDB test-cases failed, and Boris bisected
it to commit:

  d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")

The debugging session led us to commit:

  6c0aca288e72 ("x86: Ignore trap bits on single step exceptions")

It turns out that TF and data breakpoints are both traps and will be
merged, while instruction breakpoints are faults and will not be
merged. This means 6c0aca288e72 is wrong, we only need to exclude TF
and instruction breakpoints while we can merge TF and data
breakpoints.

Fixes: d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
Fixes: 6c0aca288e72 ("x86: Ignore trap bits on single step exceptions")
Reported-by: Tom de Vries <tdevries@suse.de>
Bisected-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/hw_breakpoint.c |   39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -491,15 +491,12 @@ static int hw_breakpoint_handler(struct
 	struct perf_event *bp;
 	unsigned long *dr6_p;
 	unsigned long dr6;
+	bool bpx;
 
 	/* The DR6 value is pointed by args->err */
 	dr6_p = (unsigned long *)ERR_PTR(args->err);
 	dr6 = *dr6_p;
 
-	/* If it's a single step, TRAP bits are random */
-	if (dr6 & DR_STEP)
-		return NOTIFY_DONE;
-
 	/* Do an early return if no trap bits are set in DR6 */
 	if ((dr6 & DR_TRAP_BITS) == 0)
 		return NOTIFY_DONE;
@@ -509,28 +506,29 @@ static int hw_breakpoint_handler(struct
 		if (likely(!(dr6 & (DR_TRAP0 << i))))
 			continue;
 
+		bp = this_cpu_read(bp_per_reg[i]);
+		if (!bp)
+			continue;
+
+		bpx = bp->hw.info.type == X86_BREAKPOINT_EXECUTE;
+
 		/*
-		 * The counter may be concurrently released but that can only
-		 * occur from a call_rcu() path. We can then safely fetch
-		 * the breakpoint, use its callback, touch its counter
-		 * while we are in an rcu_read_lock() path.
+		 * TF and data breakpoints are traps and can be merged, however
+		 * instruction breakpoints are faults and will be raised
+		 * separately.
+		 *
+		 * However DR6 can indicate both TF and instruction
+		 * breakpoints. In that case take TF as that has precedence and
+		 * delay the instruction breakpoint for the next exception.
 		 */
-		rcu_read_lock();
+		if (bpx && (dr6 & DR_STEP))
+			continue;
 
-		bp = this_cpu_read(bp_per_reg[i]);
 		/*
 		 * Reset the 'i'th TRAP bit in dr6 to denote completion of
 		 * exception handling
 		 */
 		(*dr6_p) &= ~(DR_TRAP0 << i);
-		/*
-		 * bp can be NULL due to lazy debug register switching
-		 * or due to concurrent perf counter removing.
-		 */
-		if (!bp) {
-			rcu_read_unlock();
-			break;
-		}
 
 		perf_bp_event(bp, args->regs);
 
@@ -538,11 +536,10 @@ static int hw_breakpoint_handler(struct
 		 * Set up resume flag to avoid breakpoint recursion when
 		 * returning back to origin.
 		 */
-		if (bp->hw.info.type == X86_BREAKPOINT_EXECUTE)
+		if (bpx)
 			args->regs->flags |= X86_EFLAGS_RF;
-
-		rcu_read_unlock();
 	}
+
 	/*
 	 * Further processing in do_debug() is needed for a) user-space
 	 * breakpoints (to generate signals) and b) when the system has
