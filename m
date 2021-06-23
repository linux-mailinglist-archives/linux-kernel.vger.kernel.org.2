Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EEB3B19F9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhFWM1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhFWM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:31 -0400
Message-Id: <20210623121454.414215896@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zWDa8W0rBshx7pY/lVk5v1xc2fzISGaYfl8MoWaH6Jo=;
        b=CdkBbEQZYjC+VVoU1ii+6ZvjdhJzr4foBJHWoNfEGdx6g40R6oBxwLUM85SYQBL8+mOoPJ
        gKJdJTrxghKyLIodWvJ5AudKXUpIn41wOpuBVxWeoOUThiwvZpFcqZr+sQSProhFUUwXbd
        ihzV5Gsb4f+yj2NV14dUWm2F9G5lGqXnKQUQ/IeCga93hig/n3k8ytkox5kNd83RKWtYw9
        95TwfGnK94ESK+/DBagl26EDUkJmbnqRvbzfXDmxz29al6Pk2V3Qjx0G79/0bL6vFWy6Bj
        opsinW5E3FiQ3TmxuWadyu7+X/j135NbHZRQv5Wzrwc3h7URn/ygVzX2ygDeAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=zWDa8W0rBshx7pY/lVk5v1xc2fzISGaYfl8MoWaH6Jo=;
        b=Q4ILkxlfBihmtk5aWeSGJ0Aurao/GTR/ArFiNLHaJp9QaPGQGhVFJID+xrreSS2zEQYb9q
        5Pz7Odk4cs1gDtCg==
Date:   Wed, 23 Jun 2021 14:01:58 +0200
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
Subject: [patch V4 31/65] x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
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

