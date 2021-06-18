Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C63ACEBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 17:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhFRPZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 11:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhFRPWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 11:22:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B093C0611C2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 08:19:54 -0700 (PDT)
Message-Id: <20210618143447.575056756@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624029593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5nxS4acYkwzPGdJZu39mrBIae17GFhHQ/cIcJW9fMb4=;
        b=32qBct06DpvMlPbK8JnDlKXZxoDo8tsguvsHTRaYXC6iWnKTvHSWRBnxtOrXIqTuPNtfco
        pJUlnoEvy/y17aT+MYcm6pHQ2h7qcy9c6R1ouLWXHzeLVezYKtCZ4i3ES4nZhSomRSSPI1
        kFZx8cvrFB9LTsY/DCiwwJAD98co7RmnAL9pH4ioNBBYCKe5Ew9tqT/Z+TARYMY9MIkRzl
        nrs57AN5pkuEoVlWND+UEMvtQLopFCWKkF0MH5qJ/DumGj0fl20g4jv40zh0RgMfdzSCVO
        MFcgBDmEevoAfq+BE4mEDAw9IPzBglyu2ZKhnxUBNZxLZyrv64Dw+EtihWNnaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624029593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5nxS4acYkwzPGdJZu39mrBIae17GFhHQ/cIcJW9fMb4=;
        b=AnG29HloSB9rBsimcWXw4ynBn/yx9f6tuDy5h5oajAPYrB1eEu7NaFUyQ6QYCia8yYXjBJ
        xnnZSqmjIgl9VqCg==
Date:   Fri, 18 Jun 2021 16:18:51 +0200
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
Subject: [patch V3 28/66] x86/fpu: Rename copy_user_to_xregs() and
 copy_xregs_to_user()
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function names for xsave[s]/xrstor[s] operations are horribly named and
a permanent source of confusion.

Rename:
	copy_xregs_to_user() to xsave_to_user_sigframe()
	copy_user_to_xregs() to xrstor_from_user_sigframe()

so it's entirely clear what this is about. This is also a clear indicator
of the potentially different storage format because this is user ABI and
cannot use compacted format.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h |    4 ++--
 arch/x86/kernel/fpu/signal.c        |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -328,7 +328,7 @@ static inline void os_xrstor(struct xreg
  * backward compatibility for old applications which don't understand
  * compacted format of xsave area.
  */
-static inline int copy_xregs_to_user(struct xregs_state __user *buf)
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
 	u64 mask = xfeatures_mask_user();
 	u32 lmask = mask;
@@ -353,7 +353,7 @@ static inline int copy_xregs_to_user(str
 /*
  * Restore xstate from user space xsave area.
  */
-static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
+static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 mask)
 {
 	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
 	u32 lmask = mask;
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -129,7 +129,7 @@ static inline int copy_fpregs_to_sigfram
 	int err;
 
 	if (use_xsave())
-		err = copy_xregs_to_user(buf);
+		err = xsave_to_user_sigframe(buf);
 	else if (use_fxsr())
 		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
 	else
@@ -266,7 +266,7 @@ static int copy_user_to_fpregs_zeroing(v
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
-			r = copy_user_to_xregs(buf, xbv);
+			r = xrstor_from_user_sigframe(buf, xbv);
 			if (!r && unlikely(init_bv))
 				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;

