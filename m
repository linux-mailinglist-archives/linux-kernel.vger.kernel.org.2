Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB633FBA23
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 18:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbhH3Q2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237844AbhH3Q2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 12:28:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBFC061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 09:27:30 -0700 (PDT)
Message-ID: <20210830162545.597134323@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630340849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A1n4ILCtM1X2Y8ay+C8F+KpSsPy2PuvE7HCormzCao0=;
        b=gFXQLHhS85r2fJzIZDex+9DTRAeqeNvwuMJbyvyz9DZZDp/DfuXKUJc71ULL7ZH3fkb079
        /XEwpczIVmO4S/nyWgAqTs6Vk91DMEcqUvlJIFyC/pAVvwqS/raKmTN1p0/HSqjFU8NDK8
        SYMI8TTbNh7hS5c2QmfWyR5t8lJkflwGYM+He5q16udzk/EaquI6cIJcG73oRnMVdp1brd
        yxc9muARZiCNaG8TRPhee79QstnCZWepgKmD+99168yuJ7XIHbyNcynO7DqKIFXimU1NOx
        HP8+al1KeSdMcBIc1TqAhOAxm7sDNdDknK9znhW02KA8b+GvdIX83GGRY3RGwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630340849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=A1n4ILCtM1X2Y8ay+C8F+KpSsPy2PuvE7HCormzCao0=;
        b=dRcdn9z5pcrPyHEdiC+Fz0QFPbqiEoZxlhi2emLX3Xur+nReB4f9wdor1+k6yMZWuCQb3y
        m3Sbl4CQRhmS9XCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 05/10] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
References: <20210830154702.247681585@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Mon, 30 Aug 2021 18:27:28 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that copy_fpregs_to_sigframe() returns boolean the individual return
codes in the related helper functions do not make sense anymore. Change
them to return boolean success/fail.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/signal.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -65,7 +65,7 @@ static inline int check_xstate_in_sigfra
 /*
  * Signal frame handlers.
  */
-static inline int save_fsave_header(struct task_struct *tsk, void __user *buf)
+static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 {
 	if (use_fxsr()) {
 		struct xregs_state *xsave = &tsk->thread.fpu.state.xsave;
@@ -82,18 +82,19 @@ static inline int save_fsave_header(stru
 		if (__copy_to_user(buf, &env, sizeof(env)) ||
 		    __put_user(xsave->i387.swd, &fp->status) ||
 		    __put_user(X86_FXSR_MAGIC, &fp->magic))
-			return -1;
+			return false;
 	} else {
 		struct fregs_state __user *fp = buf;
 		u32 swd;
+
 		if (__get_user(swd, &fp->swd) || __put_user(swd, &fp->status))
-			return -1;
+			return false;
 	}
 
-	return 0;
+	return true;
 }
 
-static inline int save_xstate_epilog(void __user *buf, int ia32_frame)
+static inline bool save_xstate_epilog(void __user *buf, int ia32_frame)
 {
 	struct xregs_state __user *x = buf;
 	struct _fpx_sw_bytes *sw_bytes;
@@ -131,7 +132,7 @@ static inline int save_xstate_epilog(voi
 
 	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
 
-	return err;
+	return !err;
 }
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
@@ -219,10 +220,10 @@ bool copy_fpstate_to_sigframe(void __use
 	}
 
 	/* Save the fsave header for the 32-bit frames. */
-	if ((ia32_fxstate || !use_fxsr()) && save_fsave_header(tsk, buf))
+	if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
 		return false;
 
-	if (use_fxsr() && save_xstate_epilog(buf_fx, ia32_fxstate))
+	if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate))
 		return false;
 
 	return true;

