Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8614839CBE6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFFAeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:34:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFFAeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:34:17 -0400
Message-Id: <20210606001323.639943263@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622939547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=U3EXUQXIWt8Z7bf3sCDWIfygCwU+xyRyr6nZHBGoxuc=;
        b=gKKgOhaOXrEnw1jOvwF+gmuFxVNLaUEoC3PSw7I//eoZQVAsaiAK8Q4p3W87iDhqr8zuxq
        HRtgy57W1hviLGeTdfEozfUAbAI0cTbEeG6lb216dMbrYnP1pX8GSLjolqT6WGzewQ+mZV
        Ie9uVgFJgpppYMwDEOjnlg0pkzEeYYPJxsZAfCtliCUQmFVjr/JH977wIS6UkEvY0HANQb
        M8kLHEcWL2ZqyT/8DBEJOb4fGUf6rnd3XxnvwNkY0hUbcqiKgyGHFPSurLFXgJLuTs5EQR
        x50+7m1peyDshHM+e+vSyJQDi6yeRdzbkASKqviS+a7+Ty/1JdW7tjTVGHB05g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622939547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=U3EXUQXIWt8Z7bf3sCDWIfygCwU+xyRyr6nZHBGoxuc=;
        b=onB7mjvM9fJwjAiNV22DbWASB6PD9pu68CGTtgWSblR+lwbyAjA4/5T6iEZ6qV3DI+m+L0
        2/o5EefauQhKaBCQ==
Date:   Sun, 06 Jun 2021 01:47:49 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 07/14] x86/fpu: Add address range checks to copy_user_to_xstate()
References: <20210605234742.712464974@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

copy_user_to_xstate() uses __copy_from_user(), which provides a negligible
speedup.  Fortunately, both call sites are at least almost correct.
__fpu__restore_sig() checks access_ok() with a length of
xstate_sigframe_size() and ptrace regset access uses fpu_user_xstate_size.
These should be valid upper bounds on the length, so, at worst, this would
cause spurious failures and not accesses to kernel memory.

Nonetheless, this is far more fragile than necessary and none of these
callers are in a hotpath. 

Use copy_from_user() instead.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/fpu/xstate.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1192,7 +1192,7 @@ int copy_user_to_xstate(struct xregs_sta
 	offset = offsetof(struct xregs_state, header);
 	size = sizeof(hdr);
 
-	if (__copy_from_user(&hdr, ubuf + offset, size))
+	if (copy_from_user(&hdr, ubuf + offset, size))
 		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
@@ -1207,7 +1207,7 @@ int copy_user_to_xstate(struct xregs_sta
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			if (__copy_from_user(dst, ubuf + offset, size))
+			if (copy_from_user(dst, ubuf + offset, size))
 				return -EFAULT;
 		}
 	}
@@ -1215,7 +1215,7 @@ int copy_user_to_xstate(struct xregs_sta
 	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
 		offset = offsetof(struct fxregs_state, mxcsr);
 		size = MXCSR_AND_FLAGS_SIZE;
-		if (__copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
+		if (copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
 			return -EFAULT;
 	}
 

