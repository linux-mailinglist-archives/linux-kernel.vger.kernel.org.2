Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61823B1013
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhFVW2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:5541 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230454AbhFVW2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:28:10 -0400
IronPort-SDR: UHrIx2A9z5G3w4wgDQfi6cLn0vz+Y5REZ9QJdyPSGuw/NEmrhZflcYOTZuxr995REwazLVJA24
 e0QACTn+Z99A==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="204146819"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="204146819"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:53 -0700
IronPort-SDR: vMSYxKo/Wdt2nBfKSQVOBDnCjXLTzGrSzIuC02M7uCibTY5/PqkB0hllQPbHOPcnGv7OEwnA0V
 WRrxhhUloKuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="444756949"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2021 15:25:53 -0700
Subject: [RFC][PATCH 7/8] x86/fpu: actually stop using XSAVE on PKRU
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:25:08 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222508.2BB7D73C@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Previously, 'xfeatures_mask_all' represented all of the features that
might be found in a kernel XSAVE buffer.  It also happened to be
(XCR0|XSS): the set of XSAVE features enabled in the hardware.  In
other words, if an feature was XSAVE-enabled in the hardware, it was
guaranteed to be found in the kernel XSAVE buffer.

The goal of this series is to remove PKRU from the kernel XSAVE
buffer, but to also leave it XSAVE-enabled in the hardware.  This ensures
that applications which read the hardware enabling status of PKRU directly
with xgetbv(0) will not notice a thing.

Locate all the places where 'xfeatures_mask_all' is used to represent
the set of features in a kernel XSAVE buffer and replace it with
xfeatures_mask_fpstate().  Update the fpstate access function
(__raw_xsave_addr()) to WARN() if a caller attempts to access a
non-present feature.  Lastly, remove the get_xsaves_size() hack now
that PKRU can be removed from the fpstate size calculations.

The most visible effect if this an 8-byte drop in the "context size":

Before:
	x86/fpu: Enabled xstate features 0x2ff, context size is 2568 bytes, using 'compacted' format.
After:
	x86/fpu: XSAVE managing features 0xff, context size is 2560 bytes, using 'compacted' format.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/include/asm/fpu/internal.h |    2 +-
 b/arch/x86/kernel/fpu/xstate.c        |   29 +++++++++++++----------------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff -puN arch/x86/include/asm/fpu/internal.h~warn-on-seeing-pkey-xfeature arch/x86/include/asm/fpu/internal.h
--- a/arch/x86/include/asm/fpu/internal.h~warn-on-seeing-pkey-xfeature	2021-06-22 14:49:13.609051745 -0700
+++ b/arch/x86/include/asm/fpu/internal.h	2021-06-22 14:49:13.622051745 -0700
@@ -286,7 +286,7 @@ static inline void os_xrstor_booting(str
  */
 static inline void os_xsave(struct xregs_state *xstate)
 {
-	u64 mask = xfeatures_mask_all;
+	u64 mask = xfeatures_mask_fpstate();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
diff -puN arch/x86/kernel/fpu/xstate.c~warn-on-seeing-pkey-xfeature arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~warn-on-seeing-pkey-xfeature	2021-06-22 14:49:13.613051745 -0700
+++ b/arch/x86/kernel/fpu/xstate.c	2021-06-22 14:49:13.628051745 -0700
@@ -168,9 +168,7 @@ static bool xfeature_enabled(enum xfeatu
  */
 static bool xfeature_fpstate_enabled(enum xfeature xfeature)
 {
-	// For bisectability, mirror xfeature_enabled() for now.
-	//return xfeatures_mask_fpstate() & BIT_ULL(xfeature);
-	return xfeature_enabled(xfeature);
+	return xfeatures_mask_fpstate() & BIT_ULL(xfeature);
 }
 
 /*
@@ -416,7 +414,7 @@ static void __init setup_init_fpu_buf(vo
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
 		init_fpstate.xsave.header.xcomp_bv = XCOMP_BV_COMPACTED_FORMAT |
-						     xfeatures_mask_all;
+						     xfeatures_mask_fpstate();
 
 	/*
 	 * Init all the features state with header.xfeatures being 0x0
@@ -644,7 +642,6 @@ static unsigned int __init get_xsaves_si
 static unsigned int __init get_xsaves_size_no_independent(void)
 {
 	unsigned int size;
-	u64 xfeatures_in_xcr0;
 	u64 old_xss;
 	u64 old_xcr0;
 
@@ -655,14 +652,8 @@ static unsigned int __init get_xsaves_si
 	/* Disable independent features. */
 	wrmsrl(MSR_IA32_XSS, old_xss & ~xfeatures_mask_independent());
 
-	/*
-	 * *Temporarily* (to be removed in a later patch), ennsure there
-	 * is still space for PKRU in the fpstate buffer even though it's
-	 * essentially unused.
-	 */
-	xfeatures_in_xcr0 = xfeatures_mask_fpstate() | XFEATURE_MASK_PKRU;
 	/* Disable user features which are not kept in the fpstate: */
-	xsetbv(XCR_XFEATURE_ENABLED_MASK, old_xcr0 & xfeatures_in_xcr0);
+	xsetbv(XCR_XFEATURE_ENABLED_MASK, old_xcr0 & xfeatures_mask_fpstate());
 
 	/*
 	 * Ask the hardware what size is required of the buffer.
@@ -843,8 +834,8 @@ void __init fpu__init_system_xstate(void
 	}
 
 	print_xstate_offset_size();
-	pr_info("x86/fpu: Enabled xstate features 0x%llx, context size is %d bytes, using '%s' format.\n",
-		xfeatures_mask_all,
+	pr_info("x86/fpu: XSAVE managing features 0x%llx, context size is %d bytes, using '%s' format.\n",
+		xfeatures_mask_fpstate(),
 		fpu_kernel_xstate_size,
 		boot_cpu_has(X86_FEATURE_XSAVES) ? "compacted" : "standard");
 	return;
@@ -879,9 +870,15 @@ void fpu__resume_cpu(void)
  * Given an xstate feature nr, calculate where in the xsave
  * buffer the state is.  Callers should ensure that the buffer
  * is valid.
+ *
+ * This only works on kernel FPU buffers, like task->thread.fpu.
  */
 static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
+	if (!(xfeatures_mask_fpstate() & BIT_ULL(xfeature_nr))) {
+		WARN_ON_FPU(1);
+		return NULL;
+	}
 	if (!xfeature_fpstate_enabled(xfeature_nr)) {
 		WARN_ON_FPU(1);
 		return NULL;
@@ -1235,7 +1232,7 @@ void xsaves(struct xregs_state *xstate,
 	if (mask & xfeatures_mask_independent())
 		xchk = ~xfeatures_mask_independent();
 	else
-		xchk = ~xfeatures_mask_all;
+		xchk = ~xfeatures_mask_fpstate();
 
 	if (WARN_ON_ONCE(!mask || mask & xchk))
 		return;
@@ -1272,7 +1269,7 @@ void xrstors(struct xregs_state *xstate,
 	if (mask & xfeatures_mask_independent())
 		xchk = ~xfeatures_mask_independent();
 	else
-		xchk = ~xfeatures_mask_all;
+		xchk = ~xfeatures_mask_fpstate();
 
 	if (WARN_ON_ONCE(!mask || mask & xchk))
 		return;
_
