Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18E402FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346680AbhIGU0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346530AbhIGU0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E90C06129F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:25:01 -0700 (PDT)
Message-ID: <20210907200848.933910410@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GZJQvUubgFKOIOpZMEEroBchdVNjppmWoOSCkIHhhFU=;
        b=BVXQJt/inURnRP2pzvB3biApgRwWGutwyDF3noTPZnfZI3w2ZkJzAaMCj1G5m5wbKPyqRf
        g1Gy61oP4g/UIMgDxSipBFPRm43lnfiU8zVFHTFcP/8xHtCBqqRv7oKjYcufsnk0CU817J
        oiQdPhVDkcupbkmxjhgbaz0ADtlFA3RHmzQUMWKXJtF9bXj+HdPwCpWU5BM8At2aVtaJMR
        byy1sDfR5G9zNfy1kgC7MUI7zJdBsAMZRdOQE3lMFQoUJXEEPclCLIt5sJX3L/pRJp+yOh
        UCXQ2ilTCzkdhltuHoJWHsnk9SlJLaNtu36ZZiZFaxhZXR48V+gbWIqLkKbDWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GZJQvUubgFKOIOpZMEEroBchdVNjppmWoOSCkIHhhFU=;
        b=Gn7R/fH8uMdV8uVAiFY7cr52L5uSvnLc/Fq3QrncYCGizrT8MpHUg//bQtKcSAzldtsFZU
        fPaox2rOMODZFvBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 12/20] x86/fpu/signal: Move header zeroing out of
 xsave_to_user_sigframe()
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:59 +0200 (CEST)
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

