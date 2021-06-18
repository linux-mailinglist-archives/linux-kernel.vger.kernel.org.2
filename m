Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EB83ACEB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbhFRPYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:24:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhFRPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:27 -0400
Message-Id: <20210618143449.881756905@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0CdvGYxNajIKnrRn2/DXRFr7pPjRiZyv1K+b+MmKyK4=;
        b=lUE5rnxk2oPuB0zTb5DTQnVlwTmxlSaWqqeR6rJxfTK1yq3Vfp0dlwunPj0MZsQ9pg9aHm
        P2hGzk/1FlHDHgoqgoeqod/pwL1R7P5CNzMq0hLKZKbRLS4zsQt9fQqdPO6s2eco0IWGIc
        wIwVkzVK+etvUHFs0KE7CeymzAN7rSuLcV6+cwC7+t8UhX/NmP/YwwUY3S9aFZMUGfQipU
        lFy2RNTf1kR8nhOt2iiqJ+WaaCrf2Cx+qZYnUK+5TL8tvYNLavornuz3I1zyLceZqmKqxT
        kgJHVAGfd3F2U54Fd67UjADgCBlfwro/JqBux6bxFSjtI5B87x30ZZjvSekeTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0CdvGYxNajIKnrRn2/DXRFr7pPjRiZyv1K+b+MmKyK4=;
        b=X2mnQavK3rLC7wGO/ZftDyzDabJ1HImsOIa3BhXd9J6PohgkVzMV4EHKzpMpo0+H4PrdX+
        96SqBDxtDVE7xTDg==
Date:   Fri, 18 Jun 2021 16:19:11 +0200
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
Subject: [patch V3 48/66] x86/fpu: Rename __fpregs_load_activate() to
 fpregs_restore_userregs()
References: <20210618141823.161158090@linutronix.de>
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
@@ -468,10 +468,8 @@ static inline void fpregs_activate(struc
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
@@ -402,7 +402,7 @@ void switch_fpu_return(void)
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

