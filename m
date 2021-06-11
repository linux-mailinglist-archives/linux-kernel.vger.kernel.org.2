Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993BC3A46D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFKQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhFKQqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:16 -0400
Message-Id: <20210611163112.757056621@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nPjd7VBYAgFlpCm4CSHlqmzrV73KKgNFKV4LNjfgc98=;
        b=c16HlJnoeIuTVLgokU4g8NAFVDtzosWl0RZyG4xV46f0yiAJRWbtnAxTL2RCxAk+MhfTXm
        UCmn/b2IdtqT0hXgxnZQA+2ItMnuZZkAcpFZapejZdqVlP6i8ZNTzyICMgTVpA75QTTVxX
        3avIyENeg0fc3EVSLhz6NC1d47ypmK+XNUsVYEvAErjSzQ/YDDU0/lS2g/5zgmDLDw0AR6
        4gKJ5rz4xO3kKC0KxhuROpqzcITcp/io/hI5eEI30XfTGL83avJS0K9nlkulU4ttJa1mzg
        1sEwpZQf/wwKQhkV5v1IJY/A4eT4NEbiawdl6nqdDAwyUIF7HDPkrh5S4B5W8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nPjd7VBYAgFlpCm4CSHlqmzrV73KKgNFKV4LNjfgc98=;
        b=8D4dxwXkM+JtxRQjxLWv8+2Bx6B+YR8A55htZNawW9sTmg4c8G4pKNkaTlFzyhEGO93f7A
        vpQzUcYNmLzY6mAQ==
Date:   Fri, 11 Jun 2021 18:15:40 +0200
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
Subject: [patch 17/41] x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()
References: <20210611161523.508908024@linutronix.de>
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
V4: Adjusted to the rename.
---
 arch/x86/kernel/fpu/xstate.c |   84 +++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 54 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1020,20 +1020,30 @@ void copy_uabi_xstate_to_membuf(struct m
 	fill_gap(&to, &last, size);
 }
 
-/*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
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
@@ -1047,7 +1057,8 @@ int copy_uabi_from_kernel_to_xstate(stru
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			memcpy(dst, kbuf + offset, size);
+			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
+				return -EFAULT;
 		}
 	}
 
@@ -1075,6 +1086,16 @@ int copy_uabi_from_kernel_to_xstate(stru
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
@@ -1082,52 +1103,7 @@ int copy_uabi_from_kernel_to_xstate(stru
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

