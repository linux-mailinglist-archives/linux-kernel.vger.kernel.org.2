Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB273A46DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhFKQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:47:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhFKQqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:36 -0400
Message-Id: <20210611163114.427041562@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XI/d2qBDpQxwEOlxYsvnj5NnGnx1u0+zHwg/KuK6XZQ=;
        b=HeHU2OxmuAgZghjbZ7n2NwHkLUfDu15vac4FVHBuuIOb2sRQ+meMT7YqVLVcX9110G/up1
        yAHbvtI21yEGAwOvUrsPrVaxo9XF7CZHG3ynE5L25L58fjC/n6GSALuStsiqHDLnGKo/Cj
        jZyLqSGY5UmX0XDj4NACskEevYDvzasbcL4cbD4K4+JHfdpL1hA+xoV4tO3zkGNEWk0Omp
        gyuZOsHl09oOk07IYW34U+U89B3uo5MZGOS2kygPAp+oCRaWSrqQOUAce1mmA83UrBcDBS
        Se4pP2JVrgnBow3BPY+MnGmDv4lNxgjK6wgAt4kSapBrejy5PBvrzliKg3rSkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XI/d2qBDpQxwEOlxYsvnj5NnGnx1u0+zHwg/KuK6XZQ=;
        b=0zTVC+4/ChgrN9sq3ywtprh6XaJigiyv/BJOCz9ilXFSdIUJ2nqn7tvDLw0yGvb1kRQUeh
        wnVauQ5Z0DFIazAw==
Date:   Fri, 11 Jun 2021 18:15:55 +0200
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
Subject: [patch 32/41] x86/fpu: Rename __fpregs_load_activate() to
 fpregs_restore_userregs()
References: <20210611161523.508908024@linutronix.de>
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
V4: New patch
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

