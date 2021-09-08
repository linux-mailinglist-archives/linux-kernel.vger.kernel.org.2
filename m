Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64467403A9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351693AbhIHNal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:30:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347108AbhIHNaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:21 -0400
Message-ID: <20210908132524.963232825@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TJTU5kToNJvJJu5pxC6HknMZgPHnhFaDFVPd5v0iGXo=;
        b=AjlVqm4SNctPI0S+q+dZXo4g6rrfb3nu+ubY9bvqZ1BloD/U2SPwlXt/6LNpJW7NEXG63L
        0QQ1jRN0/ZR/oxZHBlrItL/MTnr0HRh5bVD/EdxAxIIVH7ZXncwdnovNCElqARMwykzYBQ
        iTkCsRv/K71wbVwgZ8QJbC1onfG2Kl7eDn5d6eSkEy5ySvpRVtwYr0LOYZhIjPdypoHt9a
        I3pZoMVpbzKwYvDw0cFx9h6f/ck84jsznCQBGc51YBNwEdVPMlkRUdVdf78t/QRHPIyqs4
        PP/92C/Jayu2f22fXOYm4dTTBBDcI2L/GvDHyOcOIfa/HAHvIvkrZxcf+Ibv6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=TJTU5kToNJvJJu5pxC6HknMZgPHnhFaDFVPd5v0iGXo=;
        b=2EnTtCR+V4GK4IF0abgHyV3J6zDUkUlABZ0CP2sCgXxcYYbFv5LtpILbLVvQGbADTNhyA/
        tA2/65pWzZFJ69AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 01/20] x86/extable: Tidy up redundant handler functions
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:12 +0200 (CEST)
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
 

