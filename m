Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3290D39865A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhFBKVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbhFBKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:20:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14730C06138A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:18:03 -0700 (PDT)
Message-Id: <20210602101619.182960608@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622629081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+8DU0peep4ebfgYPhhRF+e0bN04oe+xitFx5PjSmpQg=;
        b=0E4GhbLAI7e1+pxnPsqmCBisGnJ6pRO82wASW2opqSnYJf1pFCrGmhPEy/YUEm3Dy/aSUT
        +2d0D4i0VtqYQ4RVoHDjLJFfHJFPcqJxnOBal+27GWjvY4t1BdruIMstx/sNMxs03dSl5R
        FdOjc2y9LdoxmfQEhjaV2kxa0fjXrSd1xi/UoMTVQDPqvElposzsG0Ced8DdIFLRkRpMK/
        XkDt59fBRCJzEAcGJWYHpg94OwR0Yms1/dHCaKDLzDQgv0cbRisdqr2y4FYA0+69lJ6JP7
        phjM0/Pz7BG5+EnRidVsFRXcDAnMRb3UYkPg/5ZmqhjdKh57PHbzgeAxTVG/bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622629081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=+8DU0peep4ebfgYPhhRF+e0bN04oe+xitFx5PjSmpQg=;
        b=tptb5+/UHAOFkuwhKvjl5iUy+LDJ3Do5KyjZsHE1Lf6KGMOV7WpvFr3iUWz2HDU80cHQMV
        3gV/wRG1F+roiKDA==
Date:   Wed, 02 Jun 2021 11:55:51 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [patch 8/8] x86/fpu: Deduplicate copy_xxx_to_xstate()
References: <20210602095543.149814064@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_user_to_xstate() and copy_kernel_to_xstate() are almost identical
except for the copy function.

Unify them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |   83 +++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1124,20 +1124,30 @@ void copy_xstate_to_kernel(struct membuf
 	fill_gap(&to, &last, size);
 }
 
-/*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
- * and copy to the target thread. This is called from xstateregs_set().
- */
-int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
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
+static int copy_to_xstate(struct xregs_state *xsave, const void *kbuf,
+			  const void __user *ubuf)
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
@@ -1151,7 +1161,8 @@ int copy_kernel_to_xstate(struct xregs_s
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			memcpy(dst, kbuf + offset, size);
+			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
+				return -EFAULT;
 		}
 	}
 
@@ -1179,58 +1190,22 @@ int copy_kernel_to_xstate(struct xregs_s
 }
 
 /*
+ * Convert from a ptrace standard-format kernel buffer to kernel XSAVES format
+ * and copy to the target thread. This is called from xstateregs_set().
+ */
+int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+{
+	return copy_to_xstate(xsave, kbuf, NULL);
+}
+
+/*
  * Convert from a sigreturn standard-format user-space buffer to kernel
  * XSAVES format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
  */
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
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
+	return copy_to_xstate(xsave, NULL, ubuf);
 }
 
 /*

