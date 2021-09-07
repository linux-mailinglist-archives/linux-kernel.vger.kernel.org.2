Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9A4402F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbhIGT5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346257AbhIGT5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700E4C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:28 -0700 (PDT)
Message-ID: <20210907195004.269330688@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U5xM49pdLb5dSGIBKozT2XtRlv1dw1hHJxy+JQJj3ek=;
        b=yEQboyNRvmwDj+QvA+u6U7u1yy2ZuS3DF5Ze9Y6V+CJk48wBiO+0NsGs4n9+47OPcHuw5p
        ycTb/YbKux7O/vgqh/M868LCDiXa9PzxM7ahz+CIh3buEncU7sbEBvUhdLM1et5XJhhVRo
        cRWPzDbaJaV85U/0T1uzGTHjFrsBxEc09p2qn6SnXWEoj7Y9WjP/t3CNucKOqbVOqb6TBa
        idstM6904dGo6jpFddWG6ne1QHkmBV9EhGof6SFd4KSaKicM6BTSWtVASsNmoMrUbw4HTJ
        D0OqIeEgVbHxp/mDYUQ7cnSTyzL4NYeyvvWAEKNWTd994ddzbwazjhclR2oU8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U5xM49pdLb5dSGIBKozT2XtRlv1dw1hHJxy+JQJj3ek=;
        b=yzExehW17xv5HcFz1P3mO5WtNHMYOYyAnyA/i3LEQqeHZQJwNtJsUz/S7Paa3VDonsduRI
        gXXQQfCtlqk3R0Aw==
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
Subject: [patch V2 09/20] x86/extable: Remove EX_TYPE_FAULT from MCE safe fixups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:26 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the MC safe copy and FPU have been converted to use the MCE safe
fixup types remove EX_TYPE_FAULT from the list of types which MCE considers
to be safe to be recovered in kernel.

This removes the SGX exception handling of ENCLS from the #MC safe
handling, but according to the SGX wizards the current SGX implementations
cannot survive #MC on ENCLS:

  https://lore.kernel.org/r/YS+upEmTfpZub3s9@google.com

The code relies on the trap number being stored if ENCLS raised an
exception. That's still working, but it does not longer trick the MCE code
to assume that #MC is handled correctly for ENCLS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/mce/severity.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -277,7 +277,6 @@ static int error_context(struct mce *m,
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
-	case EX_TYPE_FAULT:
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;

