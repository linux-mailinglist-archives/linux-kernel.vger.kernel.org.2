Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824953ACEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhFRPXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:23:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56678 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhFRPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:08 -0400
Message-Id: <20210618143448.030191461@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gE/BZ/z8MZphRKA81kM6mdQBHwEZxr3TUDbUuwiO2UM=;
        b=1sti/wEM/0nXB51us3jMEfst5quPcNJzzOEt8QpV1X5FAgYtFxpYc49+4HqilYp8z7bijg
        3snTPgWfBqAS1ifcu2Fvtc9xn/m+Q90u0GzlX4i5FvNiWTx2Q8QSoYpD+hyAExJQwYyrkC
        HA0F2SBewcSL2da7eiheqALhTZgizFz9+7+zdOKsouVuga7hJtf8M5+vbaQeggtRGH60uq
        /W69KNJyyfbT8Za5fkxcerXXYQQ0GSjN5uQwwPntKX1XJsH4i3Bz5AKFFPpUa58lH48uEv
        CVfHuY4Q20gdeij0jm/h0nuYNtmmGwjyTys0+Qrz+090paHYzdatYCzf0pQ0ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=gE/BZ/z8MZphRKA81kM6mdQBHwEZxr3TUDbUuwiO2UM=;
        b=1UjJFP2vc3AVgva8dMWpV3avZB+WFyKy1HMZSB2foFb2vg8oobtzlOWclyK/nDpV8zBP8w
        Wb4C30BXItpf/vDQ==
Date:   Fri, 18 Jun 2021 16:18:55 +0200
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
Subject: [patch V3 32/66] x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_uabi_from_user_to_xstate() and copy_uabi_from_kernel_to_xstate() are
almost identical except for the copy function.

Unify them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
V3: Fixed MXCSR thinkos and simplified the handling of MXCSR
---
 arch/x86/kernel/fpu/xstate.c |  137 ++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 90 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -953,23 +953,6 @@ int arch_set_user_pkey_access(struct tas
 }
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
-/*
- * Weird legacy quirk: SSE and YMM states store information in the
- * MXCSR and MXCSR_FLAGS fields of the FP area. That means if the FP
- * area is marked as unused in the xfeatures header, we need to copy
- * MXCSR and MXCSR_FLAGS if either SSE or YMM are in use.
- */
-static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
-{
-	if (!(xfeatures & (XFEATURE_MASK_SSE|XFEATURE_MASK_YMM)))
-		return false;
-
-	if (xfeatures & XFEATURE_MASK_FP)
-		return false;
-
-	return true;
-}
-
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
@@ -1082,39 +1065,53 @@ void copy_xstate_to_uabi_buf(struct memb
 		membuf_zero(&to, to.left);
 }
 
-static inline bool mxcsr_valid(struct xstate_header *hdr, const u32 *mxcsr)
+static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
+			    const void *kbuf, const void __user *ubuf)
 {
-	u64 mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
-
-	/* Only check if it is in use */
-	if (hdr->xfeatures & mask) {
-		/* Reserved bits in MXCSR must be zero. */
-		if (*mxcsr & ~mxcsr_feature_mask)
-			return false;
+	if (kbuf) {
+		memcpy(dst, kbuf + offset, size);
+	} else {
+		if (copy_from_user(dst, ubuf + offset, size))
+			return -EFAULT;
 	}
-	return true;
+	return 0;
 }
 
-/*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
- * and copy to the target thread. This is called from xstateregs_set().
- */
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+
+static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
+			       const void __user *ubuf)
 {
 	unsigned int offset, size;
-	int i;
 	struct xstate_header hdr;
+	u64 mask;
+	int i;
 
 	offset = offsetof(struct xregs_state, header);
-	size = sizeof(hdr);
-
-	memcpy(&hdr, kbuf + offset, size);
+	if (copy_from_buffer(&hdr, offset, sizeof(hdr), kbuf, ubuf))
+		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
-	if (!mxcsr_valid(&hdr, kbuf + offsetof(struct fxregs_state, mxcsr)))
-		return -EINVAL;
+	/* Validate MXCSR when any of the related features is in use */
+	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
+	if (hdr.xfeatures & mask) {
+		u32 mxcsr[2];
+
+		offset = offsetof(struct fxregs_state, mxcsr);
+		if (copy_from_buffer(mxcsr, offset, sizeof(mxcsr), kbuf, ubuf))
+			return -EFAULT;
+
+		/* Reserved bits in MXCSR must be zero. */
+		if (mxcsr[0] & ~mxcsr_feature_mask)
+			return -EINVAL;
+
+		/* SSE and YMM require MXCSR even when FP is not in use. */
+		if (!(hdr.xfeatures & XFEATURE_MASK_FP)) {
+			xsave->i387.mxcsr = mxcsr[0];
+			xsave->i387.mxcsr_mask = mxcsr[1];
+		}
+	}
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
@@ -1125,16 +1122,11 @@ int copy_uabi_from_kernel_to_xstate(stru
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			memcpy(dst, kbuf + offset, size);
+			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
+				return -EFAULT;
 		}
 	}
 
-	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		memcpy(&xsave->i387.mxcsr, kbuf + offset, size);
-	}
-
 	/*
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
@@ -1150,6 +1142,16 @@ int copy_uabi_from_kernel_to_xstate(stru
 }
 
 /*
+ * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S]
+ * format and copy to the target thread. This is called from
+ * xstateregs_set().
+ */
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+{
+	return copy_uabi_to_xstate(xsave, kbuf, NULL);
+}
+
+/*
  * Convert from a sigreturn standard-format user-space buffer to kernel
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
@@ -1157,52 +1159,7 @@ int copy_uabi_from_kernel_to_xstate(stru
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
 				      const void __user *ubuf)
 {
-	unsigned int offset, size;
-	int i;
-	struct xstate_header hdr;
-
-	offset = offsetof(struct xregs_state, header);
-	size = sizeof(hdr);
-
-	if (copy_from_user(&hdr, ubuf + offset, size))
-		return -EFAULT;
-
-	if (validate_user_xstate_header(&hdr))
-		return -EINVAL;
-
-	for (i = 0; i < XFEATURE_MAX; i++) {
-		u64 mask = ((u64)1 << i);
-
-		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, i);
-
-			offset = xstate_offsets[i];
-			size = xstate_sizes[i];
-
-			if (copy_from_user(dst, ubuf + offset, size))
-				return -EFAULT;
-		}
-	}
-
-	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		if (copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
-			return -EFAULT;
-	}
-
-	/*
-	 * The state that came in from userspace was user-state only.
-	 * Mask all the user states out of 'xfeatures':
-	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
-
-	/*
-	 * Add back in the features that came in from userspace:
-	 */
-	xsave->header.xfeatures |= hdr.xfeatures;
-
-	return 0;
+	return copy_uabi_to_xstate(xsave, NULL, ubuf);
 }
 
 /**

