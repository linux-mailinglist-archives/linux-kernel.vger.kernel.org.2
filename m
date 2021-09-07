Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB630402F32
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346126AbhIGT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45018 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbhIGT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:22 -0400
Message-ID: <20210907195003.818783000@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TJTU5kToNJvJJu5pxC6HknMZgPHnhFaDFVPd5v0iGXo=;
        b=4F+MiYMPqZBdtynG9FFYtcKvsTG7aVQFpBm+z4i4D6OAxvAUdMoJoFFVR3zHO5AjyuxQ0L
        l8as1SPOfd/S52IliTroPnc1GvL6c/PimaZgRIxrsoE9/quOmXhT8pRryFw0sBcu29bRkW
        dpdc/Kjb6QmZJ+R1POPxzvXgUJWX1BzfB2EexOHe/hoNK0zRvIJkpZ9TKfPqH27dNvAtfY
        TkouL9AbtWB3VUlVGYclLs7lbODvgEJw7IxBjYxBoAnr9RdMFxI/DpMEx30YMbybf/OeXu
        v9IA7Y6DMtPTRNlOi0HmuR3/OPsMimBIK0h3PMuGe1DZJ/HKvmSv3PyU4d6WtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TJTU5kToNJvJJu5pxC6HknMZgPHnhFaDFVPd5v0iGXo=;
        b=mCuNmlV0DxV/TNiPDAMcFmAYj/xoiAHgA2K6SXVEbHWodmHmcWKoMDP5CTsl7V8DXipWdI
        Kkuz4gRJTMl5hIDg==
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
Subject: [patch V2 01/20] x86/extable: Tidy up redundant handler functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:13 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to have the same code all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/mm/extable.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -39,9 +39,8 @@ EXPORT_SYMBOL(ex_handler_default);
 				unsigned long error_code,
 				unsigned long fault_addr)
 {
-	regs->ip = ex_fixup_addr(fixup);
 	regs->ax = trapnr;
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL_GPL(ex_handler_fault);
 
@@ -76,8 +75,7 @@ EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 				  unsigned long fault_addr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	regs->ip = ex_fixup_addr(fixup);
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
 
@@ -87,9 +85,7 @@ EXPORT_SYMBOL(ex_handler_uaccess);
 			       unsigned long fault_addr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	regs->ip = ex_fixup_addr(fixup);
-	regs->ax = trapnr;
-	return true;
+	return ex_handler_fault(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_copy);
 
@@ -103,10 +99,9 @@ EXPORT_SYMBOL(ex_handler_copy);
 		show_stack_regs(regs);
 
 	/* Pretend that the read succeeded and returned 0. */
-	regs->ip = ex_fixup_addr(fixup);
 	regs->ax = 0;
 	regs->dx = 0;
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 
@@ -121,8 +116,7 @@ EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 		show_stack_regs(regs);
 
 	/* Pretend that the write succeeded. */
-	regs->ip = ex_fixup_addr(fixup);
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
 

