Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F104438BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhKBWuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 18:50:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:46348 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhKBWuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 18:50:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10156"; a="231637428"
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="231637428"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 15:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,203,1631602800"; 
   d="scan'208";a="541420673"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2021 15:47:26 -0700
Subject: [PATCH] x86/fpu: Optimize out sigframe xfeatures when in init state
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 02 Nov 2021 15:47:50 -0700
Message-Id: <20211102224750.FA412E26@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is an optimization on top of the AMX code which was recently
queued in Linus's tree:

2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")

I've marked it "Fixes:" that commit.

--

From: Dave Hansen <dave.hansen@linux.intel.com>

tl;dr: AMX state is ~8k.  Signal frames can have space for this
~8k and each signal entry writes out all 8k even if it is zeros.
Skip writing zeros for AMX to speed up signal delivery by about
4% overall when AMX is in its init state.

This is a user-visible change to the sigframe ABI.

== Hardware XSAVE Background ==

XSAVE state components may be tracked by the processor as being
in their initial configuration.  Software can detect which
features are in this configuration by looking at the XSTATE_BV
field in an XSAVE buffer or with the XGETBV(1) instruction.

Both the XSAVE and XSAVEOPT instructions enumerate features s
being in the initial configuration via the XSTATE_BV field in the
XSAVE header,  However, XSAVEOPT declines to actually write
features in their initial configuration to the buffer.  XSAVE
writes the feature unconditionally, regardless of whether it is
in the initial configuration or not.

Basically, XSAVE users never need to inspect XSTATE_BV to
determine if the feature has been written to the buffer.
XSAVEOPT users *do* need to inspect XSTATE_BV.  They might also
need to clear out the buffer if they want to make an isolated
change to the state, like modifying one register.

== Software Signal / XSAVE Background ==

Signal frames have historically been written with XSAVE itself.
Each state is written in its entirety, regardless of being in its
initial configuration.

In other words, the signal frame ABI uses the XSAVE behavior, not
the XSAVEOPT behavior.

== Problem ==

This means that any application which has acquired permission to
use AMX via ARCH_REQ_XCOMP_PERM will write 8k of state to the
signal frame.  This 8k write will occur even when AMX was in its
initial configuration and software *knows* this because of
XSTATE_BV.

This problem also exists to a lesser degree with AVX-512 and its
2k of state.  However, AVX-512 use does not require
ARCH_REQ_XCOMP_PERM and is more likely to have existing users
which would be impacted by any change in behavior.

== Solution ==

Stop writing out AMX xfeatures which are in their initial state
to the signal frame.  This effectively makes the signal frame
XSAVE buffer look as if it were written with a combination of
XSAVEOPT and XSAVE behavior.  Userspace which handles XSAVEOPT-
style buffers should be able to handle this naturally.

For now, include only the AMX xfeatures: XTILE and XTILEDATA in
this new behavior.  These require new ABI to use anyway, which
makes their users very unlikely to be broken.  This XSAVEOPT-like
behavior should be expected for all future dynamic xfeatures.  It
may also be extended to legacy features like AVX-512 in the
future.

Only attempt this optimization on systems with dynamic features.
Disable dynamic feature support (XFD) if XGETBV1 is unavailable
by adding a CPUID dependency.

This has been measured to reduce the *overall* cycle cost of
signal delivery by about 4%.

Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---

 b/Documentation/x86/xstate.rst      |    9 ++++++++
 b/arch/x86/include/asm/fpu/xcr.h    |   12 +++++++++++
 b/arch/x86/include/asm/fpu/xstate.h |    7 ++++++
 b/arch/x86/kernel/cpu/cpuid-deps.c  |    1 
 b/arch/x86/kernel/fpu/xstate.h      |   37 ++++++++++++++++++++++++++++++++++--
 5 files changed, 64 insertions(+), 2 deletions(-)

diff -puN arch/x86/kernel/fpu/xstate.h~avoid-writing-amx-zeros arch/x86/kernel/fpu/xstate.h
--- a/arch/x86/kernel/fpu/xstate.h~avoid-writing-amx-zeros	2021-11-02 12:43:42.965655750 -0700
+++ b/arch/x86/kernel/fpu/xstate.h	2021-11-02 12:43:42.973655749 -0700
@@ -4,6 +4,7 @@
 
 #include <asm/cpufeature.h>
 #include <asm/fpu/xstate.h>
+#include <asm/fpu/xcr.h>
 
 #ifdef CONFIG_X86_64
 DECLARE_PER_CPU(u64, xfd_state);
@@ -199,6 +200,32 @@ static inline void os_xrstor_supervisor(
 }
 
 /*
+ * XSAVE itself always writes all requested xfeatures.  Removing features
+ * from the request bitmap reduces the features which are written.
+ * Generate a mask of features which must be written to a sigframe.  The
+ * unset features can be optimized away and not written.
+ *
+ * This optimization is user-visible.  Only use for states where
+ * uninitialized sigframe contents are tolerable, like dynamic features.
+ *
+ * Users of buffers produced with this optimization smust check XSTATE_BV
+ * to determine which features have been optimized out.
+ */
+static inline u64 xfeatures_need_sigframe_write(void)
+{
+	u64 xfeaures_to_write;
+
+	/* In-use features must be written: */
+	xfeaures_to_write = xfeatures_in_use();
+
+	/* Also write all non-optimizable sigframe features: */
+	xfeaures_to_write |= XFEATURE_MASK_USER_SUPPORTED &
+			     ~XFEATURE_MASK_SIGFRAME_INITOPT;
+
+	return xfeaures_to_write;
+}
+
+/*
  * Save xstate to user space xsave area.
  *
  * We don't use modified optimization because xrstor/xrstors might track
@@ -220,10 +247,16 @@ static inline int xsave_to_user_sigframe
 	 */
 	struct fpstate *fpstate = current->thread.fpu.fpstate;
 	u64 mask = fpstate->user_xfeatures;
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
+	u32 lmask;
+	u32 hmask;
 	int err;
 
+	/* Optimize away writing unnecessary xfeatures: */
+	if (fpu_state_size_dynamic())
+		mask &= xfeatures_need_sigframe_write();
+
+	lmask = mask;
+	hmask = mask >> 32;
 	xfd_validate_state(fpstate, mask, false);
 
 	stac();
diff -puN arch/x86/include/asm/fpu/xstate.h~avoid-writing-amx-zeros arch/x86/include/asm/fpu/xstate.h
--- a/arch/x86/include/asm/fpu/xstate.h~avoid-writing-amx-zeros	2021-11-02 12:43:42.965655750 -0700
+++ b/arch/x86/include/asm/fpu/xstate.h	2021-11-02 12:43:42.973655749 -0700
@@ -92,6 +92,13 @@
 #define XFEATURE_MASK_FPSTATE	(XFEATURE_MASK_USER_RESTORE | \
 				 XFEATURE_MASK_SUPERVISOR_SUPPORTED)
 
+/*
+ * Features in this mask have space allocated in the signal frame, but may not
+ * have that space initialized when the feature is in its init state.
+ */
+#define XFEATURE_MASK_SIGFRAME_INITOPT	(XFEATURE_MASK_XTILE | \
+					 XFEATURE_MASK_USER_DYNAMIC)
+
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff -puN arch/x86/include/asm/fpu/xcr.h~avoid-writing-amx-zeros arch/x86/include/asm/fpu/xcr.h
--- a/arch/x86/include/asm/fpu/xcr.h~avoid-writing-amx-zeros	2021-11-02 12:43:42.965655750 -0700
+++ b/arch/x86/include/asm/fpu/xcr.h	2021-11-02 12:43:42.973655749 -0700
@@ -3,6 +3,7 @@
 #define _ASM_X86_FPU_XCR_H
 
 #define XCR_XFEATURE_ENABLED_MASK	0x00000000
+#define XCR_XFEATURE_IN_USE_MASK	0x00000001
 
 static inline u64 xgetbv(u32 index)
 {
@@ -20,4 +21,15 @@ static inline void xsetbv(u32 index, u64
 	asm volatile("xsetbv" :: "a" (eax), "d" (edx), "c" (index));
 }
 
+/*
+ * Return a mask of xfeatures which are currently being tracked
+ * by the processor as being in the initial configuration.
+ *
+ * Callers should check X86_FEATURE_XGETBV1.
+ */
+static inline u64 xfeatures_in_use(void)
+{
+	return xgetbv(XCR_XFEATURE_IN_USE_MASK);
+}
+
 #endif /* _ASM_X86_FPU_XCR_H */
diff -puN Documentation/x86/xstate.rst~avoid-writing-amx-zeros Documentation/x86/xstate.rst
--- a/Documentation/x86/xstate.rst~avoid-writing-amx-zeros	2021-11-02 12:43:42.965655750 -0700
+++ b/Documentation/x86/xstate.rst	2021-11-02 12:43:42.973655749 -0700
@@ -63,3 +63,12 @@ kernel sends SIGILL to the application.
 the handler allocates a larger xstate buffer for the task so the large
 state can be context switched. In the unlikely cases that the allocation
 fails, the kernel sends SIGSEGV.
+
+Dynamic features in signal frames
+---------------------------------
+
+Dynamcally enabled features are not written to the signal frame upon signal
+entry if the feature is in its initial configuration.  This differs from
+non-dynamic features which are always written regardless of their
+configuration.  Signal handlers can examine the XSAVE buffer's XSTATE_BV
+field to determine if a features was written.
diff -puN arch/x86/kernel/cpu/cpuid-deps.c~avoid-writing-amx-zeros arch/x86/kernel/cpu/cpuid-deps.c
--- a/arch/x86/kernel/cpu/cpuid-deps.c~avoid-writing-amx-zeros	2021-11-02 12:43:42.973655749 -0700
+++ b/arch/x86/kernel/cpu/cpuid-deps.c	2021-11-02 12:43:42.973655749 -0700
@@ -76,6 +76,7 @@ static const struct cpuid_dep cpuid_deps
 	{ X86_FEATURE_SGX1,			X86_FEATURE_SGX       },
 	{ X86_FEATURE_SGX2,			X86_FEATURE_SGX1      },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
+	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{}
 };
_
