Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1949B3B1A05
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhFWM1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36980 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhFWM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:48 -0400
Message-Id: <20210623121455.827979263@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9oFQFnsPO5ZzY0coDrED+iuppgH1lTtiVGlTyrcZBMI=;
        b=0rpdynlIqgTZcK85FRruxxEIzxt2qzoOcWiZl4+QTjp3KYW+PKK3VJKDIXf0UwnSwqg7et
        N38dI5GdPD3ZOFLd+NilpEdifliVuWSBiIeo5+4gV1k5rQqtwy2PlL2EomlVbwoR6Bd1Uy
        e/U6i6vHYrfYost3GQK7P5HuwGv9N7I+v7YiLnsinQSjFSUAnDWuRCIlCMSw1RvIUMOjW/
        m3PZfFKKJhEwDHzHLGdzPH2VOJ8bRCh7rbS7SwE3PHukVJErPpW8GuNnZ/6+Uk5N3mravP
        5JbbtcFpdJ1TSrZtTF97g3fQvg8Y3wAql88pHGlthMi+BrBS1djk1Ghj7rpVaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9oFQFnsPO5ZzY0coDrED+iuppgH1lTtiVGlTyrcZBMI=;
        b=5jv/ThJfaCNP0Qynu3Ysz/hcwUreCOqGjjnOohi2wKQVxsGaWApETrw8BTgO8dXR/19Ltz
        Gluv0fF47tcjaZCQ==
Date:   Wed, 23 Jun 2021 14:02:12 +0200
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
Subject: [patch V4 45/65] x86/fpu: Rename fpu__clear_all() to fpu_flush_thread()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear what the function is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h |    3 ++-
 arch/x86/kernel/fpu/core.c          |    4 ++--
 arch/x86/kernel/process.c           |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -29,12 +29,13 @@
 extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern void fpu__clear_user_states(struct fpu *fpu);
-extern void fpu__clear_all(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
 extern void fpu_sync_fpstate(struct fpu *fpu);
 
+/* Clone and exit operations */
 extern int  fpu_clone(struct task_struct *dst);
+extern void fpu_flush_thread(void);
 
 /*
  * Boot time FPU initialization functions:
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -350,9 +350,9 @@ void fpu__clear_user_states(struct fpu *
 	fpu__clear(fpu, true);
 }
 
-void fpu__clear_all(struct fpu *fpu)
+void fpu_flush_thread(void)
 {
-	fpu__clear(fpu, false);
+	fpu__clear(&current->thread.fpu, false);
 }
 
 /*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -205,7 +205,7 @@ void flush_thread(void)
 	flush_ptrace_hw_breakpoint(tsk);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
-	fpu__clear_all(&tsk->thread.fpu);
+	fpu_flush_thread();
 }
 
 void disable_TSC(void)

