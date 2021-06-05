Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB039CBED
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFFAei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33048 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFFAeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:25 -0400
Message-Id: <20210606001324.340301148@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vDthe6uuRpBWklEAw3Cp7dyNM0bY9SLui24uNh/dpuA=;
        b=SFlgTzwLbMOPbLCR+4KfCB4qTQmwbUlTMrabZBa/xP8q1VLIHYGQpV8k2e94Eypcu8HGbp
        mnT/Bh6D0q0f5UN3W9NT56FveBQUCHIiQSdlyoqaCp/PfMUr09UGAvp2Esa/YT2Rq6Pfld
        WJddq/OIzpB45gNdnIDLT3vIF2WxKfThZc1mQF3shs4xhop3DaZNzZQdJbmGW8JheqT3yy
        1g60V0G9oG8Vc1DVge1heeDFrp7oszGOmD2t0PqY1H5mqyU2R6PmJLDw8QhsCKyRCf+Vmr
        xh1Bdjen7tEEcYe7sX/+teGR7em9WKWSGNjhOZR6zMXjrIXZpuxpPkPd8O6ALA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vDthe6uuRpBWklEAw3Cp7dyNM0bY9SLui24uNh/dpuA=;
        b=POeWSefLr9pBGyGgooNuHcS9FpXQ3N3E4eH5fImmUB3/hIfnEWFs/ea4nOcxyApoFoZhp8
        jMH1ilsc6zoEadBA==
Date:   Sun, 06 Jun 2021 01:47:56 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 14/14] x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()
References: <20210605234742.712464974@linutronix.de>
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
V2: Adjusted to the rename.
---
 arch/x86/kernel/fpu/xstate.c |   83 +++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1124,20 +1124,30 @@ void copy_uabi_xstate_to_kernel(struct m
 	fill_gap(&to, &last, size);
 }
 
-/*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
- * and copy to the target thread. This is called from xstateregs_set().
- */
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
+			    const void *kbuf, const void __user *ubuf)
+{
+	if (kbuf) {
+		memcpy(dst, kbuf + offset, size);
+	} else {
+		if (copy_from_user(dst, ubuf + offset, size))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
+			       const void __user *ubuf)
 {
 	unsigned int offset, size;
-	int i;
 	struct xstate_header hdr;
+	int i;
 
 	offset = offsetof(struct xregs_state, header);
 	size = sizeof(hdr);
 
-	memcpy(&hdr, kbuf + offset, size);
+	if (copy_from_buffer(&hdr, offset, size, kbuf, ubuf))
+		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
@@ -1151,7 +1161,8 @@ int copy_uabi_from_kernel_to_xstate(stru
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			memcpy(dst, kbuf + offset, size);
+			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
+				return -EFAULT;
 		}
 	}
 
@@ -1179,6 +1190,15 @@ int copy_uabi_from_kernel_to_xstate(stru
 }
 
 /*
+ * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
+ * and copy to the target thread. This is called from xstateregs_set().
+ */
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+{
+	return copy_uabi_to_xstate(xsave, kbuf, NULL);
+}
+
+/*
  * Convert from a sigreturn standard-format user-space buffer to kernel
  * XSAVES format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
@@ -1186,52 +1206,7 @@ int copy_uabi_from_kernel_to_xstate(stru
 int copy_uabi_from_user_to_xstate(struct xregs_state *xsave,
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
 
 /*

