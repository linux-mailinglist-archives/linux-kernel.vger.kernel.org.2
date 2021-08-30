Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F83FBA20
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhH3Q2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53082 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbhH3Q2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:19 -0400
Message-ID: <20210830162545.430751423@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qXAWdnSnaeDy3wgzsmxWwSzZKfbxTk2DmBehG0RKp9w=;
        b=2zu03oIkA7xL6U9w0sxNw5PWDZ8QhHpI9fFYCwbsII/0wNFny9tS0NuFxPV1LEcCpkOp0L
        sS9SEgvq+NjmxR5uQRcLtUpzed9WXyfpkB2NO6tvHfkN5BOZqgvv8Mw+vds5Kds/nD893Z
        F/FvC4i2TRUUpUu6Mn6Mt/gvYh39HXTDHa3EkNTPVLbXOqq0RTrxsCoN5viF9Osiz8oBn5
        dmfY4VXqDQ3ynauXwZeBVjFkY2h0CL8u9nKEBgDtifVB+G5WKvg27Ps6vw0mrjcDMmBKSY
        6L2Df9Z7BMHvm9O3KBs+r2pvWRTB99txV5ZqILO5L0Qm9jFPkXc1lLtKrkFBEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=qXAWdnSnaeDy3wgzsmxWwSzZKfbxTk2DmBehG0RKp9w=;
        b=Som0cn2uS/XzZQOPJrZ1UQ2YGkcuXJoOLiv9LrcBLI/QkLza1VPAIf9HUVj8N3HGnrgxp5
        MHijEK+CZEQFUrBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 02/10] x86/fpu/signal: Move header zeroing out of
 xsave_to_user_sigframe()
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:24 +0200 (CEST)
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
@@ -323,9 +323,12 @@ static inline void os_xrstor(struct xreg
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
@@ -339,14 +342,6 @@ static inline int xsave_to_user_sigframe
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

