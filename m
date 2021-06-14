Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248683A6C27
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbhFNQmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbhFNQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:40:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56583C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 09:38:38 -0700 (PDT)
Message-Id: <20210614155357.961762271@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SeD8fiZ+X3pZ3707wzNMAAtOtnk/2AHvO8ATOw6KgBs=;
        b=lfDszvtJWEhClYjp/zz3ng5kJSiyyn4rzZq47w5TW31+8jJzy4v6Eyt6xIGPmZ9YpcMX2C
        5vixxwesmcPiC5YVgyp3NZ3ZtGT4M3wif8bG54ZqbDAqhVh6CXXrT4gUYKqyvVc+QPhUT/
        XuAGX1XngZxbxhrIjIjWro8X7Y1VFkzojN17evEtBSd6vsM4T828pAqmHfYcVeUir7o+Y9
        ChJC00YXhca9HPPOs9s1Fkk0KrsWq1tQzr1Z5Ex+gpqSzr6VX26TacxVIKwQ8Sf0S2xOej
        pZf4Ebvc0MoKsqw1zZaE+b/0BpPiNj1bzsSSXapdW3TL7g/BfH4Vts1EiFpHrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=SeD8fiZ+X3pZ3707wzNMAAtOtnk/2AHvO8ATOw6KgBs=;
        b=GQDftF+eih6HHpUNe4Y9hphKJfeSVOvJZIgIdqKeeTe/JD5JL5S5P31qTk+6jiilpcfGax
        q+2Tv+AzUjKMMODw==
Date:   Mon, 14 Jun 2021 17:44:50 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [patch V2 42/52] x86/fpu: Rename __fpregs_load_activate() to
 fpregs_restore_userregs()
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename it so that it becomes entirely clear what this function is
about. It's purpose is to restore the FPU registers to the state which was
saved in the task's FPU memory state either at context switch or by an in
kernel FPU user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    6 ++----
 arch/x86/kernel/fpu/core.c          |    2 +-
 arch/x86/kernel/fpu/signal.c        |    2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -485,10 +485,8 @@ static inline void fpregs_activate(struc
 	trace_x86_fpu_regs_activated(fpu);
 }
 
-/*
- * Internal helper, do not use directly. Use switch_fpu_return() instead.
- */
-static inline void __fpregs_load_activate(void)
+/* Internal helper for switch_fpu_return() and signal frame setup */
+static inline void fpregs_restore_userregs(void)
 {
 	struct fpu *fpu = &current->thread.fpu;
 	int cpu = smp_processor_id();
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -472,7 +472,7 @@ void switch_fpu_return(void)
 	if (!static_cpu_has(X86_FEATURE_FPU))
 		return;
 
-	__fpregs_load_activate();
+	fpregs_restore_userregs();
 }
 EXPORT_SYMBOL_GPL(switch_fpu_return);
 
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -188,7 +188,7 @@ int copy_fpstate_to_sigframe(void __user
 	 */
 	fpregs_lock();
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
-		__fpregs_load_activate();
+		fpregs_restore_userregs();
 
 	pagefault_disable();
 	ret = copy_fpregs_to_sigframe(buf_fx);

