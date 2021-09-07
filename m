Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E8402F40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbhIGT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346296AbhIGT5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:39 -0400
Message-ID: <20210907195004.433139136@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GZJQvUubgFKOIOpZMEEroBchdVNjppmWoOSCkIHhhFU=;
        b=a95Edyh6g8Hfk5/vhncC+54Py4u+qqWTFa+0JBVOvqIwMYctb+l2Bw9C1PtrLOZ10cjGhR
        5L7MYDdiYHiL5zHSOw1ncXRZp3/iOlifGI0EZFCC/n+S8IDn7p4npeP/G1cHxg/lY8tid/
        KDYMbd70oyfu6J6mGsOfrLt0MYNR3RoD3iXrxbojApVlKxdwR5gj+LOKtNnNjGkma3qbXc
        HJU39KBkBTkVbcpFWtkOI6qs0wtZCh1X2SH5adWx308ijDYpca62kHYIatZgTd7sMXK0XK
        XkdDA5OAhJiZOADnlxM43SujqJ2IPqYdWPzTB7S801i/PGIS4qEpHiifGXdppQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GZJQvUubgFKOIOpZMEEroBchdVNjppmWoOSCkIHhhFU=;
        b=pm/Ch0+1wbNsFtoSDaKR3bw48x0y0pfAoQ2U5ygvk+siak18iN4GY1tAhGsDtWvGscY1O6
        vK+Y93+iWH4KlzAQ==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 12/20] x86/fpu/signal: Move header zeroing out of
 xsave_to_user_sigframe()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:31 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to have the header zeroing in the pagefault disabled
region. Do it upfront once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |   17 ++++++-----------
 arch/x86/kernel/fpu/signal.c        |   12 ++++++++++++
 2 files changed, 18 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -349,9 +349,12 @@ static inline void os_xrstor(struct xreg
  * We don't use modified optimization because xrstor/xrstors might track
  * a different application.
  *
- * We don't use compacted format xsave area for
- * backward compatibility for old applications which don't understand
- * compacted format of xsave area.
+ * We don't use compacted format xsave area for backward compatibility for
+ * old applications which don't understand the compacted format of the
+ * xsave area.
+ *
+ * The caller has to zero buf::header before calling this because XSAVE*
+ * does not touch the reserved fields in the header.
  */
 static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
@@ -365,14 +368,6 @@ static inline int xsave_to_user_sigframe
 	u32 hmask = mask >> 32;
 	int err;
 
-	/*
-	 * Clear the xsave header first, so that reserved fields are
-	 * initialized to zero.
-	 */
-	err = __clear_user(&buf->header, sizeof(buf->header));
-	if (unlikely(err))
-		return -EFAULT;
-
 	stac();
 	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -189,6 +189,18 @@ int copy_fpstate_to_sigframe(void __user
 
 	if (!access_ok(buf, size))
 		return -EACCES;
+
+	if (use_xsave()) {
+		struct xregs_state __user *xbuf = buf_fx;
+
+		/*
+		 * Clear the xsave header first, so that reserved fields are
+		 * initialized to zero.
+		 */
+		ret = __clear_user(&xbuf->header, sizeof(xbuf->header));
+		if (unlikely(ret))
+			return ret;
+	}
 retry:
 	/*
 	 * Load the FPU registers if they are not valid for the current task.

