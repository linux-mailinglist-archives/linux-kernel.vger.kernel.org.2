Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD14C3B19F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhFWM1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36710 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhFWM0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:25 -0400
Message-Id: <20210623121453.924266705@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T+qa8kh/nBQsDzFb6YdKH7p/RYcumm1rrpwQTFGrrrk=;
        b=oiC8CYJHJV5vvioolE8jjAaPkxRZ/hFc3Rrs9zyB/5+g0MXxksCedUOEooTylIfFTR5jpp
        O+8tvw7GsZTdbhNXJHFKlFotA2zLm6Us7kJcHZy3YDF5YFugQrer+D3tNYaJpTSuH6Jd9p
        1OK9aWoYa2dn5LW7hm2YhE0QZpbgmIz24CNvRWP60VSuoOoHLaDJkm8+YNzwJVo8p5Nc23
        huAFhrBhKsgOSfpgMJn8XCOQ13huNnyR96zSgllQ/mhraQB1Ao5YuxqRmpzB8yVXm5Q9n0
        bqxbcnW+227ldlc3SdfRdak9jr/pYDUK8Qkcz2nRp39YEjIqHmDvCl6CKqVCNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=T+qa8kh/nBQsDzFb6YdKH7p/RYcumm1rrpwQTFGrrrk=;
        b=zZDxEW11Cvb5PKnleXCvlq6UP61ktXF3vDjpWS6DvXHqMO8rKSOjjdLAPpEWAtJ2hCuO6H
        QWWEHPLWo2wSWyAA==
Date:   Wed, 23 Jun 2021 14:01:53 +0200
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
Subject: [patch V4 26/65] x86/fpu: Rename copy_user_to_xregs() and
 copy_xregs_to_user()
References: <20210623120127.327154589@linutronix.de>
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
Reviewed-by: Borislav Petkov <bp@suse.de>
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

