Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998BC3A6BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 18:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbhFNQj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 12:39:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhFNQjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 12:39:52 -0400
Message-Id: <20210614155353.825709513@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623688668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b0UE/Wtjy44wT2PV0JtkA5Gooc1f+d4nXKHTY1eGR+U=;
        b=w1zegg7b1eOG6S4k8sglb7A/QuR3mRpIUnDnIDvck1d8pWBQv1rIrGn/TnywuFBpJgdcJe
        HJ7uhQRb51vwkKRMO6bqQgmGSGvjKWwlwRpFwwxLKNoE+RhmxYSNxSSBLMs8oy8JabReFA
        ZXhqHUun+7ERjDWDY1WAve4IZaVA94K6yrKZupLBfyqbU8yKAEDrK1cdGc4mb1zPNzB3tE
        KIbYpOiprnflov+3n1jrOmR8SIAi99H39/UEGjEfPMtQEH+0NWDLA3q8dBzV0ouyP/ovzR
        vdOk77XCKVDzfi/z6HrU6HEF1qrj5UwM7E+j81W14xdFx3NFyLcnlEw6E1MGWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623688668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b0UE/Wtjy44wT2PV0JtkA5Gooc1f+d4nXKHTY1eGR+U=;
        b=fd3oRFJMyne6H2BQFJQcQwPANLdfliowx+Xh+oIYAr9oqumzfDFonYc7uAhSdTQsNIm0QR
        w8u4fkoyeI3CAWBQ==
Date:   Mon, 14 Jun 2021 17:44:10 +0200
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
Subject: [patch V2 02/52] x86/fpu: Fix copy_xstate_to_kernel() gap handling
References: <20210614154408.673478623@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gap handling in copy_xstate_to_kernel() is wrong in two aspects when
XSAVES is in use.

  1) Copying of xstate.i387.xmm_space is only copied when the SSE feature
     bit is set. This is not correct because YMM (AVX) shares the XMM space
     and that state must also be copied if only the YMM feature bit set
     like already done for MXCSR.

  2) Using init_fpstate for copying the init state of features which are
     not set in the xstate header is only correct for the legacy area, but
     not for the extended features area because when XSAVES is in use then
     init_fpstate is in compacted form which means the xstate offsets which
     are used to copy from init_fpstate are not valid.

     Fortunately this is not a real problem today because all extended
     features in use have an all zeros init state, but it is wrong
     nevertheless and with a potentially dynamically sized init_fpstate
     this would result in access outside of the init_fpstate.

Fix this by:

  1) Copying XMM space when the SSE or the YMM feature bits are set

  2) Keeping track of the last copied state in the target buffer and
     explicitely zero it when there is a feature or alignment gap.

     Use the compacted offset when accessing the extended feature space
     in init_fpstate.

Fixes: b8be15d58806 ("x86/fpu/xstate: Re-enable XSAVES")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
V2: New patch
---
 arch/x86/kernel/fpu/xstate.c |  105 ++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 44 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1082,20 +1082,10 @@ static inline bool xfeatures_mxcsr_quirk
 	return true;
 }
 
-static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
+static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
+			 void *init_xstate, unsigned int size)
 {
-	if (*last >= offset)
-		return;
-	membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
-	*last = offset;
-}
-
-static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
-		      unsigned size, void *from)
-{
-	fill_gap(to, last, offset);
-	membuf_write(to, from, size);
-	*last = offset + size;
+	membuf_write(to, from_xstate ? xstate : init_xstate, size);
 }
 
 /*
@@ -1107,10 +1097,10 @@ static void copy_part(struct membuf *to,
  */
 void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 {
+	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
-	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
-	unsigned size = to.left;
-	unsigned last = 0;
+	unsigned int zerofrom;
 	int i;
 
 	/*
@@ -1120,41 +1110,68 @@ void copy_xstate_to_kernel(struct membuf
 	header.xfeatures = xsave->header.xfeatures;
 	header.xfeatures &= xfeatures_mask_user();
 
-	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(&to, &last, 0, off_mxcsr, &xsave->i387);
-	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
-		copy_part(&to, &last, off_mxcsr,
-			  MXCSR_AND_FLAGS_SIZE, &xsave->i387.mxcsr);
-	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(&to, &last, offsetof(struct fxregs_state, st_space),
-			  128, &xsave->i387.st_space);
-	if (header.xfeatures & XFEATURE_MASK_SSE)
-		copy_part(&to, &last, xstate_offsets[XFEATURE_SSE],
-			  256, &xsave->i387.xmm_space);
-	/*
-	 * Fill xsave->i387.sw_reserved value for ptrace frame:
-	 */
-	copy_part(&to, &last, offsetof(struct fxregs_state, sw_reserved),
-		  48, xstate_fx_sw_bytes);
-	/*
-	 * Copy xregs_state->header:
-	 */
-	copy_part(&to, &last, offsetof(struct xregs_state, header),
-		  sizeof(header), &header);
+	/* Copy FP state up to MXCSR */
+	copy_feature(header.xfeatures & XFEATURE_MASK_FP, &to, &xsave->i387,
+		     &xinit->i387, off_mxcsr);
+
+	/* Copy MXCSR when SSE or YMM are set in the feature mask */
+	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
+		     &to, &xsave->i387.mxcsr, &xinit->i387.mxcsr,
+		     MXCSR_AND_FLAGS_SIZE);
+
+	/* Copy the remaining FP state */
+	copy_feature(header.xfeatures & XFEATURE_MASK_FP,
+		     &to, &xsave->i387.st_space, &xinit->i387.st_space,
+		     sizeof(xsave->i387.st_space));
+
+	/* Copy the SSE state - shared with YMM */
+	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
+		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
+		     16 * 16);
+
+	/* Zero the padding area */
+	membuf_zero(&to, sizeof(xsave->i387.padding));
+
+	/* Copy xsave->i387.sw_reserved */
+	membuf_write(&to, xstate_fx_sw_bytes, sizeof(xsave->i387.sw_reserved));
+
+	/* Copy the user space relevant state of @xsave->header */
+	membuf_write(&to, &header, sizeof(header));
+
+	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		/*
-		 * Copy only in-use xstates:
+		 * The ptrace buffer is XSAVE format which is non-compacted.
+		 * In non-compacted format disabled features still occupy
+		 * state space, but there is no state to copy from in the
+		 * compacted init_fpstate. The gap tracking will zero this
+		 * later.
+		 */
+		if (!(xfeatures_mask_user() & BIT_ULL(i)))
+			continue;
+
+		/*
+		 * If there was a feature or alignment gap, zero the space
+		 * in the destination buffer.
 		 */
-		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, i);
+		if (zerofrom < xstate_offsets[i])
+			membuf_zero(&to, xstate_offsets[i] - zerofrom);
 
-			copy_part(&to, &last, xstate_offsets[i],
-				  xstate_sizes[i], src);
-		}
+		copy_feature(header.xfeatures & BIT_ULL(i), &to,
+			     __raw_xsave_addr(xsave, i),
+			     __raw_xsave_addr(xinit, i),
+			     xstate_sizes[i]);
 
+		/*
+		 * Keep track of the last copied state in the non-compacted
+		 * target buffer for gap zeroing.
+		 */
+		zerofrom = xstate_offsets[i] + xstate_sizes[i];
 	}
-	fill_gap(&to, &last, size);
+
+	if (to.left)
+		membuf_zero(&to, to.left);
 }
 
 /*

