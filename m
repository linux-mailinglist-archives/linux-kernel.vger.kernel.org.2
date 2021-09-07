Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA41402FAA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346725AbhIGU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:26:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45952 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346682AbhIGU0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:26:12 -0400
Message-ID: <20210907200849.107595581@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A1n4ILCtM1X2Y8ay+C8F+KpSsPy2PuvE7HCormzCao0=;
        b=ROUHLpx1RwTcuKPP/nPvz2iqKGt7MvFlB1HsnFluksoWMnM0h+50pWwwAFm+AwyyN4DtPt
        qf7aS9yl8AK10QpScKacwQaW1Amv7JgzW+Gro3mlyNF0aGGdoQ6gOAwlFiSK8IV8B/qoCq
        PxblhXRCdNmDI0/kWykw6I3No4WPjwalha9PNXgnWH8L2q4cBMbJ5Y/mcN0iqCsrSRm+mx
        QxDaykbmXkwP1aqEDTzqu+n69fkiYGPl+vREwyeSrvSC5uU7oGSXc9/8X/1L+aBz5Qdizy
        CmYbwBar/dwv6ZBc98FKxhnwiEhirrayktUw9ylsyqk/izaCbB1NpBsVePHOGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=A1n4ILCtM1X2Y8ay+C8F+KpSsPy2PuvE7HCormzCao0=;
        b=WUbFnoOW2vo3giTFGPG2MaUpWh/g0fESt+UUISacpyFzgbm/XRQ+TiFCcvqO3CMB7y4eRR
        +s/cTjK76UqN3XBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 15/20] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:25:04 +0200 (CEST)
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

