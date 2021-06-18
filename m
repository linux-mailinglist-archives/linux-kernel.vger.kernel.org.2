Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8FC3ACE94
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbhFRPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhFRPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F010C0617AD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:36 -0700 (PDT)
Message-Id: <20210618143445.869339459@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EFWP0kL3mzs5vMeQuyAKSIlrs3/tsfT7zciJy9J5rIE=;
        b=rvqx60HhNyC2RFGEf+B6yrtCsWAQG2EvrBBTZgD67y59eqSe1YnGSmBd5fr3PaoM5ynwhr
        YbkRJH3iWAdv6aw7bO1UiGfWd3pkhCLG2pee4Yb42wuHiQ51rGh4Wly56yLtnhkELHJ5F6
        rGPCa+/fHHXoO86AI4daX8nSj2pp39KUcTONhkqNUtlg2zjcgsfSlKQ3PLaDVHjZMYrjV+
        ep8dHBNk8JF+UwEv8UfSvNFz+qJDlliaRbib6dKqGoFC1cmmLgf/570GjaeR9I6Xozovuu
        GZPHA/GXIZ1b5gIrLECSapyxdc6u/AsxaEyNJWuJR8S1MPohzT56A7zlON994Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=EFWP0kL3mzs5vMeQuyAKSIlrs3/tsfT7zciJy9J5rIE=;
        b=lqwpi82u7BVPb/Qe6RaI7F8njCyz5eBU/ynXwXyXvTpB4+JOynJtTRVrfed7ZJ/25O7j0B
        kshl3SrO/pLdVaAw==
Date:   Fri, 18 Jun 2021 16:18:36 +0200
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
Subject: [patch V3 13/66] x86/fpu: Simplify PTRACE_GETREGS code
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

ptrace() has interfaces that let a ptracer inspect a ptracee's register state.
This includes XSAVE state.  The ptrace() ABI includes a hardware-format XSAVE
buffer for both the SETREGS and GETREGS interfaces.

In the old days, the kernel buffer and the ptrace() ABI buffer were the
same boring non-compacted format.  But, since the advent of supervisor
states and the compacted format, the kernel buffer has diverged from the
format presented in the ABI.

This leads to two paths in the kernel:
1. Effectively a verbatim copy_to_user() which just copies the kernel buffer
   out to userspace.  This is used when the kernel buffer is kept in the
   non-compacted form which means that it shares a format with the ptrace
   ABI.
2. A one-state-at-a-time path: copy_xstate_to_kernel().  This is theoretically
   slower since it does a bunch of piecemeal copies.

Remove the verbatim copy case.  Speed probably does not matter in this path,
and the vast majority of new hardware will use the one-state-at-a-time path
anyway.  This ensures greater testing for the "slow" path.

This also makes enabling PKRU in this interface easier since a single path
can be patched instead of two.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/fpu/regset.c |   24 +++---------------------
 arch/x86/kernel/fpu/xstate.c |    6 +++---
 2 files changed, 6 insertions(+), 24 deletions(-)

--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -77,32 +77,14 @@ int xstateregs_get(struct task_struct *t
 		struct membuf to)
 {
 	struct fpu *fpu = &target->thread.fpu;
-	struct xregs_state *xsave;
 
-	if (!boot_cpu_has(X86_FEATURE_XSAVE))
+	if (!cpu_feature_enabled(X86_FEATURE_XSAVE))
 		return -ENODEV;
 
-	xsave = &fpu->state.xsave;
-
 	fpu__prepare_read(fpu);
 
-	if (using_compacted_format()) {
-		copy_xstate_to_kernel(to, xsave);
-		return 0;
-	} else {
-		fpstate_sanitize_xstate(fpu);
-		/*
-		 * Copy the 48 bytes defined by the software into the xsave
-		 * area in the thread struct, so that we can copy the whole
-		 * area to user using one user_regset_copyout().
-		 */
-		memcpy(&xsave->i387.sw_reserved, xstate_fx_sw_bytes, sizeof(xstate_fx_sw_bytes));
-
-		/*
-		 * Copy the xstate memory layout.
-		 */
-		return membuf_write(&to, xsave, fpu_user_xstate_size);
-	}
+	copy_xstate_to_kernel(to, &fpu->state.xsave);
+	return 0;
 }
 
 int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1069,11 +1069,11 @@ static void copy_feature(bool from_xstat
 }
 
 /*
- * Convert from kernel XSAVES compacted format to standard format and copy
- * to a kernel-space ptrace buffer.
+ * Convert from kernel XSAVE or XSAVES compacted format to UABI
+ * non-compacted format and copy to a kernel-space ptrace buffer.
  *
  * It supports partial copy but pos always starts from zero. This is called
- * from xstateregs_get() and there we check the CPU has XSAVES.
+ * from xstateregs_get() and there we check the CPU has XSAVE.
  */
 void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 {

