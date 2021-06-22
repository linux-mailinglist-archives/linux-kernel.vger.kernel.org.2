Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903BB3B1010
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 00:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhFVW2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 18:28:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:40664 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhFVW2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 18:28:04 -0400
IronPort-SDR: Q99Xz6Rduj96HXeWB1xDHhMx1p/tcP5aACHd93N4cpk7kkGM9NDAvk7AIhgasi/6Ml5PjHRz6j
 wN/nquqa2gUA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="207093942"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="207093942"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 15:25:46 -0700
IronPort-SDR: VWFfuWB7fCT2KYI9MuTVuNJvq9iDi7YLvnztjh0qOiCIIi99195CMHpot2knP1mUi7q96By/zK
 JJDrPs17HFfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="641791400"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2021 15:25:45 -0700
Subject: [RFC][PATCH 3/8] x86/fpu: separate the setup of xfeatures not in fpstate
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 22 Jun 2021 15:25:00 -0700
References: <20210622222455.E901B5AC@viggo.jf.intel.com>
In-Reply-To: <20210622222455.E901B5AC@viggo.jf.intel.com>
Message-Id: <20210622222500.2A850129@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The goal of this series is to create a new class of xfeature: one which
is enabled in XCR0 so that XSAVE/XRSTOR continue to work on it, but
where the kernel does not use XSAVE*/XRSTOR* to manage the state or to
maintain it in the thread FPU buffer (fpstate).

Create a new helper in the XSAVE setup code: xstate_fpstate_enabled().
This helper returns whether or not an xfeature is being maintained
inside of the thread's fpstate.

For now, make xstate_fpstate_enabled() function identically to
xfeature_enabled().  This ensures that this series is bisectable
between this point and where PKRU is actually removed from
xfeature_fpstate_enabled().

This series originally introduced xfeatures_mask_fpstate() to mean:
"the set of features found in the kernel fpstate and managed by
XSAVE".  However, upstream ripped me off and made an identically-
named function which refers to the features managed by XSAVE,
which *excludes* PKRU at this juncture.

That means that xfeature_fpstate_enabled() and
xfeatures_mask_fpstate() will diverge until the end of the series.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
---

 b/arch/x86/kernel/fpu/xstate.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff -puN arch/x86/kernel/fpu/xstate.c~xfeature-setup-fpstate arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~xfeature-setup-fpstate	2021-06-22 14:49:08.956051757 -0700
+++ b/arch/x86/kernel/fpu/xstate.c	2021-06-22 14:49:08.965051757 -0700
@@ -156,16 +156,32 @@ void fpu__init_cpu_xstate(void)
 	}
 }
 
+/* Can the XSAVE architecture be used to manage this feature? */
 static bool xfeature_enabled(enum xfeature xfeature)
 {
 	return xfeatures_mask_all & BIT_ULL(xfeature);
 }
 
 /*
+ * Is space for the feature present in the task->thread.fpu
+ * fpstate buffer and is the using XSAVE to context-switch it?
+ */
+static bool xfeature_fpstate_enabled(enum xfeature xfeature)
+{
+	// For bisectability, mirror xfeature_enabled() for now.
+	//return xfeatures_mask_fpstate() & BIT_ULL(xfeature);
+	return xfeature_enabled(xfeature);
+}
+
+/*
  * Record the offsets and sizes of various xstates contained
- * in the XSAVE state memory layout.
+ * in the non-compacted XSAVE state memory layout.
+ *
+ * These are always used in the XSAVE ABIs and are used for
+ * the kernel xstate buffer in cases where XSAVES (and thus
+ * the compacted format) is not supported.
  */
-static void __init setup_xstate_features(void)
+static void __init setup_xfeature_offsets(void)
 {
 	u32 eax, ebx, ecx, edx, i;
 	/* start at the beginning of the "extended state" */
@@ -185,6 +201,10 @@ static void __init setup_xstate_features
 						       xmm_space);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
+		/*
+		 * Set up any features enabled that are in the kernel
+		 * xstate buffer *or* the user XSAVE ABIs.
+		 */
 		if (!xfeature_enabled(i))
 			continue;
 
@@ -257,7 +277,7 @@ static int xfeature_is_aligned(int xfeat
 
 	CHECK_XFEATURE(xfeature_nr);
 
-	if (!xfeature_enabled(xfeature_nr)) {
+	if (!xfeature_fpstate_enabled(xfeature_nr)) {
 		WARN_ONCE(1, "Checking alignment of disabled xfeature %d\n",
 			  xfeature_nr);
 		return 0;
@@ -293,7 +313,7 @@ static void __init setup_xstate_comp_off
 
 	if (!boot_cpu_has(X86_FEATURE_XSAVES)) {
 		for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-			if (xfeature_enabled(i))
+			if (xfeature_fpstate_enabled(i))
 				xstate_comp_offsets[i] = xstate_offsets[i];
 		}
 		return;
@@ -302,7 +322,7 @@ static void __init setup_xstate_comp_off
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
+		if (!xfeature_fpstate_enabled(i))
 			continue;
 
 		if (xfeature_is_aligned(i))
@@ -329,7 +349,7 @@ static void __init setup_supervisor_only
 	next_offset = FXSAVE_SIZE + XSAVE_HDR_SIZE;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i) || !xfeature_is_supervisor(i))
+		if (!xfeature_fpstate_enabled(i) || !xfeature_is_supervisor(i))
 			continue;
 
 		if (xfeature_is_aligned(i))
@@ -348,7 +368,7 @@ static void __init print_xstate_offset_s
 	int i;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
+		if (!xfeature_fpstate_enabled(i))
 			continue;
 		pr_info("x86/fpu: xstate_offset[%d]: %4d, xstate_sizes[%d]: %4d\n",
 			 i, xstate_comp_offsets[i], i, xstate_sizes[i]);
@@ -391,7 +411,7 @@ static void __init setup_init_fpu_buf(vo
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return;
 
-	setup_xstate_features();
+	setup_xfeature_offsets();
 	print_xstate_features();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
@@ -562,7 +582,7 @@ static void do_extra_xstate_size_checks(
 	int i;
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
-		if (!xfeature_enabled(i))
+		if (!xfeature_fpstate_enabled(i))
 			continue;
 
 		check_xstate_against_struct(i);
@@ -849,7 +869,7 @@ void fpu__resume_cpu(void)
  */
 static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 {
-	if (!xfeature_enabled(xfeature_nr)) {
+	if (!xfeature_fpstate_enabled(xfeature_nr)) {
 		WARN_ON_FPU(1);
 		return NULL;
 	}
_
