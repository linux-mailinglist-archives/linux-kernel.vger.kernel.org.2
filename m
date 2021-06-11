Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157E23A46CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhFKQqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:46:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhFKQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:46:11 -0400
Message-Id: <20210611163112.347846297@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623429853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=myLIKFFpGMaW4S59hURYKecww2rFsdS40cWlqBgxH+8=;
        b=BFC7KI4/z4XScN0KiHfqmbqsOi+zj5/RwPiwGh+Q7gnEEU/yBGS9uj5TdZyCkUA45/Wouf
        rkxhTSdyPd7kCoTs80FtoPtAFkWPWJ95zwPRPUyptqla9Sh30j2zSRrowFnTooNn88/0zg
        4OrhYS2tC0obCcjK7vhMBBQAjOlNzNq3n4XIqL9+u9sOXFQ4/CTdeIOxPOHdpNtHwipyPD
        6EDW/tCfR9YLOX69W0j8cIQpfUYLFsXOoZzldk3Fd37tjU/XnffBefkEATeJ1PLAa0JcHd
        ojAYhxk1xlPojV78QkEkq95ngAYIT8H6YEyabYCVkk9ElpBYBg1jCFfl6RBWdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623429853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=myLIKFFpGMaW4S59hURYKecww2rFsdS40cWlqBgxH+8=;
        b=kNQOkUtme3Pw1gLbgh0yqSd3LplJt/DCwmdUYMefsL0HqhJdO8M7d3xELMngyk3faQcWct
        rFmZNFHelyD9yLAA==
Date:   Fri, 11 Jun 2021 18:15:36 +0200
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
Subject: [patch 13/41] x86/fpu: Rename copy_user_to_xregs() and copy_xregs_to_user()
References: <20210611161523.508908024@linutronix.de>
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
@@ -338,7 +338,7 @@ static inline void xrstor_from_kernel(st
  * backward compatibility for old applications which don't understand
  * compacted format of xsave area.
  */
-static inline int copy_xregs_to_user(struct xregs_state __user *buf)
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
 	u64 mask = xfeatures_mask_user();
 	u32 lmask = mask;
@@ -363,7 +363,7 @@ static inline int copy_xregs_to_user(str
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
@@ -276,7 +276,7 @@ static int copy_user_to_fpregs_zeroing(v
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
-			r = copy_user_to_xregs(buf, xbv);
+			r = xrstor_from_user_sigframe(buf, xbv);
 			if (!r && unlikely(init_bv))
 				xrstor_from_kernel(&init_fpstate.xsave, init_bv);
 			return r;

