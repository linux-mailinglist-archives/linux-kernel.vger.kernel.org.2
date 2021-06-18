Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A46F3ACE86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhFRPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbhFRPVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:21:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:23 -0700 (PDT)
Message-Id: <20210618143444.743973084@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/Go5Rav6mDl5Obbjh2eSObmzJ9Mc1Xwvm3VlB0I2jSE=;
        b=DzcwzNCi2k/mbAvRKTibTMI+fApsF/8oKXJBEaOWmptRgQWlHOGidI/PA69pClPlJmnFak
        cXa2JHMNRHAwnkAu8qCAEIXeRvoloIfSpstggZ9nWoTZcpge0ud/s0e02kxqrhm4/wBiSe
        kKqaLkuGvDZMIwyFWWqm3/DDybZ6s56vuWttO02B559rWwmLi/ZFNKypUCN+AzBs6y6JZ0
        uSj2wUf2MjevXjr0ZPu5sneGJJfQYjhnfuy2AoDkc2y7y9azNLgAYFkOEBZokxNTd7byXb
        2vc9MHv8rza0S2uC6M7QdotFgWkvSSTHCkJFx3WTfiEIuo8FOtH0DY4Sc1DBcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=/Go5Rav6mDl5Obbjh2eSObmzJ9Mc1Xwvm3VlB0I2jSE=;
        b=OPLJv/GzcSGUuixtyiV6IpC5EF3C8fhSho6bBy0vWasjRwJPbLth1ODnvMp/AFjJXZghdj
        DNdt983t1Zak3JAQ==
Date:   Fri, 18 Jun 2021 16:18:26 +0200
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
Subject: [patch V3 03/66] x86/fpu: Fix copy_xstate_to_kernel() gap handling
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gap handling in copy_xstate_to_kernel() is wrong when XSAVES is in use.

Using init_fpstate for copying the init state of features which are
not set in the xstate header is only correct for the legacy area, but
not for the extended features area because when XSAVES is in use then
init_fpstate is in compacted form which means the xstate offsets which
are used to copy from init_fpstate are not valid.

Fortunately this is not a real problem today because all extended
features in use have an all zeros init state, but it is wrong
nevertheless and with a potentially dynamically sized init_fpstate
this would result in access outside of the init_fpstate.

Fix this by keeping track of the last copied state in the target buffer and
explicitly zero it when there is a feature or alignment gap.

Use the compacted offset when accessing the extended feature space in
init_fpstate.

As this is not a functional issue on older kernels this is intentionally
not tagged for stable.

Fixes: b8be15d58806 ("x86/fpu/xstate: Re-enable XSAVES")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Remove the AVX/SEE thinko
    Fix comments (Boris)
V2: New patch
---
 arch/x86/kernel/fpu/xstate.c |  105 ++++++++++++++++++++++++-------------------
 1 file changed, 61 insertions(+), 44 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1084,20 +1084,10 @@ static inline bool xfeatures_mxcsr_quirk
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
@@ -1109,10 +1099,10 @@ static void copy_part(struct membuf *to,
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
@@ -1122,41 +1112,68 @@ void copy_xstate_to_kernel(struct membuf
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
+	/* Copy the SSE state - shared with YMM, but independently managed */
+	copy_feature(header.xfeatures & XFEATURE_MASK_SSE,
+		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
+		     sizeof(xsave->i387.xmm_space));
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
+		 * The ptrace buffer is in non-compacted XSAVE format.
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

