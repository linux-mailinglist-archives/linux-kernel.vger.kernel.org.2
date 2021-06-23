Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D03B1A08
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhFWM2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:28:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhFWM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:54 -0400
Message-Id: <20210623121456.303919033@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=McSQS4QmZuQrR/negRnP0Q2gNhWHsURWcEb80O8PScQ=;
        b=NqeSEw6Vb7B4m6ty753UyPmVGYhaKxvR6gEa9eNcRESenLZJV3hCY/ksfu34tgPfzpT/1g
        yx3PDlx5a+v1cZv9p/zzGdAVOeivSKGpAqRvgW2aZQWd6LaBdKXFDzIZjixCO/A3WaJO98
        A7nLPX4MhmCVhzxdoWBl2+NjDf7et3vD3hO4s87iqUH9C7GSx0eJPYZDpI5Jv8cMXctMqu
        Vkmy0Zy/7X7+mllLqz2Sqby5H/QFoCfIc7sFNSVcq2tZSO5+osXZsQq8LDTI4E8JleM6P0
        1yKHHw34c+JoyL/Us9ct8Y6TAAsuCuaPyU3n5lV8/y89R8aBRqlvZD2WtVAQ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=McSQS4QmZuQrR/negRnP0Q2gNhWHsURWcEb80O8PScQ=;
        b=HV9qJZik16nvdKn2QMpyZLd9IwZ7VO5p8iB8zGktVnpsk+H452OEAKxGI7PZ8VrY/L8er6
        9ikMY1nrhjkWtSDg==
Date:   Wed, 23 Jun 2021 14:02:17 +0200
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
Subject: [patch V4 50/65] x86/fpu: Dont restore PKRU in fpregs_restore_userspace()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

switch_to(), flush_thread() write the task's PKRU value eagerly so the PKRU
value of current is always valid in the hardware.

That means there is no point in restoring PKRU on exit to user or when
reactivating the task's FPU registers in the signal frame setup path.

This allows to remove all the xstate buffer updates with PKRU values once
the PKRU state is stored in thread struct while a task is scheduled out.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
V3: Restore supervisor state too. (Yu-Cheng)
---
 arch/x86/include/asm/fpu/internal.h |   16 +++++++++++++++-
 arch/x86/include/asm/fpu/xstate.h   |   19 +++++++++++++++++++
 arch/x86/kernel/fpu/core.c          |    2 +-
 3 files changed, 35 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -457,7 +457,21 @@ static inline void fpregs_restore_userre
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		restore_fpregs_from_fpstate(&fpu->state);
+		u64 mask;
+
+		/*
+		 * This restores _all_ xstate which has not been
+		 * established yet.
+		 *
+		 * If PKRU is enabled, then the PKRU value is already
+		 * correct because it was either set in switch_to() or in
+		 * flush_thread(). So it is excluded because it might be
+		 * not up to date in current->thread.fpu.xsave state.
+		 */
+		mask = xfeatures_mask_restore_user() |
+			xfeatures_mask_supervisor();
+		__restore_fpregs_from_fpstate(&fpu->state, mask);
+
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
 	}
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -35,6 +35,14 @@
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR)
 
+/*
+ * Features which are restored when returning to user space.
+ * PKRU is not restored on return to user space because PKRU
+ * is switched eagerly in switch_to() and flush_thread()
+ */
+#define XFEATURE_MASK_USER_RESTORE	\
+	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
@@ -92,6 +100,17 @@ static inline u64 xfeatures_mask_uabi(vo
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
+/*
+ * The xfeatures which are restored by the kernel when returning to user
+ * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
+ * kernel does not manage all XCR0 enabled features via xsave/xrstor as
+ * some of them have to be switched eagerly on context switch and exec().
+ */
+static inline u64 xfeatures_mask_restore_user(void)
+{
+	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
+}
+
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -404,7 +404,7 @@ void fpu__clear_user_states(struct fpu *
 	}
 
 	/* Reset user states in registers. */
-	restore_fpregs_from_init_fpstate(xfeatures_mask_uabi());
+	restore_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU

