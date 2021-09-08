Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975BE403AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351836AbhIHNbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:31:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51154 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351595AbhIHNai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:38 -0400
Message-ID: <20210908132525.621674721@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GZJQvUubgFKOIOpZMEEroBchdVNjppmWoOSCkIHhhFU=;
        b=NtATYJiblABHX1reZJ71WUBghs6oZgiFAcS0bUTeSPBXtwTcdk9WlYRB69ojqlfnuYJPIh
        S5NklTIMDcreBbqAvz9uNobYnwpWXaUIF8mba+/N7fwaD5mPwuop3O8P3BJ9EgBNSw0PMf
        K3efzmpmDU7jIjHwmSl3I3aIM8O8QT9v41ZYz82wrjIcFaBZxEzM+mlQiXrpoUfrGChyig
        tPGrYkOD9q1mhhTsnjsA0ZUC0nWDBgdxHX6WM5h4VULtm4yn/OgnNZhObYPX0UmUDkvoh7
        EwVJed1Pq3oIDr1449w18b5aMcVPVBX9oBQykZWjK3aJszVGEKkDBHY+NPEDcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GZJQvUubgFKOIOpZMEEroBchdVNjppmWoOSCkIHhhFU=;
        b=4ANg+y9KKVDIT2jHwNyjechC8o6vaDlPioDNIaiTpUOtIEJklGJEqXXYs0RqwVOQIIDvHP
        uNp6GXhbBP0XARDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 12/20] x86/fpu/signal: Move header zeroing out of
 xsave_to_user_sigframe()
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:29 +0200 (CEST)
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

