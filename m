Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96173B1A19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhFWM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhFWM2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:28:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AFC061760
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 05:24:34 -0700 (PDT)
Message-Id: <20210623121456.018867925@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P4OqoRqjeRo0o5o/XQIssoZR/fDg/ouzQsBqAA0CX54=;
        b=MNG3jfmut9JAAcQgjlPhmCDfryaz3smGc13KTq3rZ/HXS1EGv8TSOq0jyZ8v6+q0iJgCqI
        PhSuXD18x36alY7aqEc4jeGIZhO4tkPQN/m5XmLdoWGavjfHui+HLYbkb/O3ecp+U5v1/W
        KP6HN+yQ1PEy9sCoxAb9emRWjhMKiLDA6k3B+oHCAMbxkML6Ffi5RoIlIo7DNMblQCsFQW
        /21QyTAemLF9PD1R0ItuLjEuDDG2sTQAZViZweVUCD5lGwiJ2lL0WCkXMQTPDeNHoFFyU0
        2N4tZktJmj8zgXuLc4/uu4Fc9NuYM7jm2u4N9DJ6jO12dhOPtNhg6hZPU0LULg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=P4OqoRqjeRo0o5o/XQIssoZR/fDg/ouzQsBqAA0CX54=;
        b=ohzGNRd1v3864wzLrnN8cD8jI3nQn+EbJtWLI5FqZ5Sgxa33w8vNSuYVmrG+tejJsJNJtT
        wrNzIShceFVc0+Bg==
Date:   Wed, 23 Jun 2021 14:02:14 +0200
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
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 47/65] x86/fpu: Rename __fpregs_load_activate() to
 fpregs_restore_userregs()
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
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

