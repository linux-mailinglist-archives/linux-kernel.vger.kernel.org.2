Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34FB38FBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhEYHfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhEYHfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:35:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396DC06138A
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YKOuGlrdCZMl6g5CLFG7XG3Qd3TuT3OdsI6hUrigAik=; b=uiLjhj1hDzEw8oHzwtEvBGVjn0
        vomHa6WLGrBQn8CKZj9J5Hxcs/VaYw8g3PQ6qYPJqoE5YxdoN4TacGHjwRdf0WhgTydmwcbWg7iJI
        4EPlWYPrrrwqaCc4/15lfnjFJ4g0AP7mRdWdfvOzXpWJJ37EzkLUmcGJZ9oZbEFbt0JzFKLIpeYGm
        QeJzQKuUn6tj0FxplX8bIWEbNdRCuRkbHUcc5xD/56jTiHifM2bK/npHjPuHoAoBqivCFxT8pcKb/
        1WTrA9CCQC1Ry3V+KJZyBEvrSHyqWeapwdjTQRNBY/7dLQvfDAk7Q4OqrluFmvP0Jb5/lrkNnAj/t
        U1ON1Ijg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llRYg-003Eit-L6; Tue, 25 May 2021 07:33:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31EB530029A;
        Tue, 25 May 2021 09:32:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D54D830A65B5F; Tue, 25 May 2021 09:32:57 +0200 (CEST)
Message-ID: <20210525073213.561116662@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 25 May 2021 09:25:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, rostedt@goodmis.org,
        naveen.n.rao@linux.vnet.ibm.com, ananth@linux.ibm.com,
        x86@kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] kprobes: Remove kprobe::fault_handler
References: <20210525072518.791889911@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason for kprobe::fault_handler(), as given by their comment:

 * We come here because instructions in the pre/post
 * handler caused the page_fault, this could happen
 * if handler tries to access user space by
 * copy_from_user(), get_user() etc. Let the
 * user-specified handler try to fix it first.

Is just plain bad. Those other handlers are ran from non-preemptible
context and had better use _nofault() functions. Also, there is no
upstream usage of this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/trace/kprobes.rst    |   24 +++++-------------------
 arch/arc/kernel/kprobes.c          |   10 ----------
 arch/arm/probes/kprobes/core.c     |    9 ---------
 arch/arm64/kernel/probes/kprobes.c |   10 ----------
 arch/csky/kernel/probes/kprobes.c  |   10 ----------
 arch/ia64/kernel/kprobes.c         |    9 ---------
 arch/mips/kernel/kprobes.c         |    3 ---
 arch/powerpc/kernel/kprobes.c      |   10 ----------
 arch/riscv/kernel/probes/kprobes.c |   10 ----------
 arch/s390/kernel/kprobes.c         |   10 ----------
 arch/sh/kernel/kprobes.c           |   10 ----------
 arch/sparc/kernel/kprobes.c        |   10 ----------
 arch/x86/kernel/kprobes/core.c     |   10 ----------
 include/linux/kprobes.h            |    8 --------
 kernel/kprobes.c                   |   19 -------------------
 samples/kprobes/kprobe_example.c   |   15 ---------------
 16 files changed, 5 insertions(+), 172 deletions(-)

--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -362,14 +362,11 @@ register_kprobe
 	#include <linux/kprobes.h>
 	int register_kprobe(struct kprobe *kp);
 
-Sets a breakpoint at the address kp->addr.  When the breakpoint is
-hit, Kprobes calls kp->pre_handler.  After the probed instruction
-is single-stepped, Kprobe calls kp->post_handler.  If a fault
-occurs during execution of kp->pre_handler or kp->post_handler,
-or during single-stepping of the probed instruction, Kprobes calls
-kp->fault_handler.  Any or all handlers can be NULL. If kp->flags
-is set KPROBE_FLAG_DISABLED, that kp will be registered but disabled,
-so, its handlers aren't hit until calling enable_kprobe(kp).
+Sets a breakpoint at the address kp->addr.  When the breakpoint is hit, Kprobes
+calls kp->pre_handler.  After the probed instruction is single-stepped, Kprobe
+calls kp->post_handler.  Any or all handlers can be NULL. If kp->flags is set
+KPROBE_FLAG_DISABLED, that kp will be registered but disabled, so, its handlers
+aren't hit until calling enable_kprobe(kp).
 
 .. note::
 
@@ -415,17 +412,6 @@ the breakpoint was hit.  Return 0 here u
 p and regs are as described for the pre_handler.  flags always seems
 to be zero.
 
-User's fault-handler (kp->fault_handler)::
-
-	#include <linux/kprobes.h>
-	#include <linux/ptrace.h>
-	int fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr);
-
-p and regs are as described for the pre_handler.  trapnr is the
-architecture-specific trap number associated with the fault (e.g.,
-on i386, 13 for a general protection fault or 14 for a page fault).
-Returns 1 if it successfully handled the exception.
-
 register_kretprobe
 ------------------
 
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -324,16 +324,6 @@ int __kprobes kprobe_fault_handler(struc
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned zero,
 		 * try to fix up.
 		 */
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -358,15 +358,6 @@ int __kprobes kprobe_fault_handler(struc
 		 */
 		kprobes_inc_nmissed_count(cur);
 
-		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
-			return 1;
 		break;
 
 	default:
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -283,16 +283,6 @@ int __kprobes kprobe_fault_handler(struc
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -302,16 +302,6 @@ int __kprobes kprobe_fault_handler(struc
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -851,15 +851,6 @@ int __kprobes kprobe_fault_handler(struc
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -403,9 +403,6 @@ int kprobe_fault_handler(struct pt_regs
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-		return 1;
-
 	if (kcb->kprobe_status & KPROBE_HIT_SS) {
 		resume_execution(cur, regs, kcb);
 		regs->cp0_status |= kcb->kprobe_old_SR;
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -509,16 +509,6 @@ int kprobe_fault_handler(struct pt_regs
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -275,16 +275,6 @@ int __kprobes kprobe_fault_handler(struc
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -453,16 +453,6 @@ static int kprobe_trap_handler(struct pt
 		kprobes_inc_nmissed_count(p);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (p->fault_handler && p->fault_handler(p, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -390,16 +390,6 @@ int __kprobes kprobe_fault_handler(struc
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -353,16 +353,6 @@ int __kprobes kprobe_fault_handler(struc
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -947,16 +947,6 @@ int kprobe_fault_handler(struct pt_regs
 		 * these specific fault cases.
 		 */
 		kprobes_inc_nmissed_count(cur);
-
-		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
 	}
 
 	return 0;
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -54,8 +54,6 @@ struct kretprobe_instance;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
-typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
-				       int trapnr);
 typedef int (*kretprobe_handler_t) (struct kretprobe_instance *,
 				    struct pt_regs *);
 
@@ -83,12 +81,6 @@ struct kprobe {
 	/* Called after addr is executed, unless... */
 	kprobe_post_handler_t post_handler;
 
-	/*
-	 * ... called if executing addr causes a fault (eg. page fault).
-	 * Return 1 if it handled fault, otherwise kernel will see it.
-	 */
-	kprobe_fault_handler_t fault_handler;
-
 	/* Saved opcode (which has been replaced with breakpoint) */
 	kprobe_opcode_t opcode;
 
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1183,23 +1183,6 @@ static void aggr_post_handler(struct kpr
 }
 NOKPROBE_SYMBOL(aggr_post_handler);
 
-static int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
-			      int trapnr)
-{
-	struct kprobe *cur = __this_cpu_read(kprobe_instance);
-
-	/*
-	 * if we faulted "during" the execution of a user specified
-	 * probe handler, invoke just that probe's fault handler
-	 */
-	if (cur && cur->fault_handler) {
-		if (cur->fault_handler(cur, regs, trapnr))
-			return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(aggr_fault_handler);
-
 /* Walks the list and increments nmissed count for multiprobe case */
 void kprobes_inc_nmissed_count(struct kprobe *p)
 {
@@ -1330,7 +1313,6 @@ static void init_aggr_kprobe(struct kpro
 	ap->addr = p->addr;
 	ap->flags = p->flags & ~KPROBE_FLAG_OPTIMIZED;
 	ap->pre_handler = aggr_pre_handler;
-	ap->fault_handler = aggr_fault_handler;
 	/* We don't care the kprobe which has gone. */
 	if (p->post_handler && !kprobe_gone(p))
 		ap->post_handler = aggr_post_handler;
@@ -2014,7 +1996,6 @@ int register_kretprobe(struct kretprobe
 
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
-	rp->kp.fault_handler = NULL;
 
 	/* Pre-allocate memory for max kretprobe instances */
 	if (rp->maxactive <= 0) {
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -86,26 +86,11 @@ static void __kprobes handler_post(struc
 #endif
 }
 
-/*
- * fault_handler: this is called if an exception is generated for any
- * instruction within the pre- or post-handler, or when Kprobes
- * single-steps the probed instruction.
- */
-static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
-{
-	pr_info("fault_handler: p->addr = 0x%p, trap #%dn", p->addr, trapnr);
-	/* Return 0 because we don't handle the fault. */
-	return 0;
-}
-/* NOKPROBE_SYMBOL() is also available */
-NOKPROBE_SYMBOL(handler_fault);
-
 static int __init kprobe_init(void)
 {
 	int ret;
 	kp.pre_handler = handler_pre;
 	kp.post_handler = handler_post;
-	kp.fault_handler = handler_fault;
 
 	ret = register_kprobe(&kp);
 	if (ret < 0) {


