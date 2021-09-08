Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061CE403AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351784AbhIHNa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:30:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51014 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349436AbhIHNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:24 -0400
Message-ID: <20210908132525.096452100@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SmSiQ7xCWe8n3tLVAh8SY5hwaLF7QDHxdm1wHtCdRSI=;
        b=i1F5evhsMnCt4irzaoNcFUaWynE+pDHy7St8rpGZzUeiPQ25hIuudljBO8k/HUS/0wg3Uz
        3lGztjOKxk2snh1p1oKSocT0SMyCaUpRPwWgG+gxQjWWCZESbIzFmc9jWwLFKSVViBDJ5v
        yFJk2mzLFdzG7WF7E5kvHdUG7CczOakwkaO80u/DSV756WvysNnioTIwzt7NmSrqIoV6+i
        j4r1MuNlTk1gLBZySztFFn2Vc9Rb+CdRpSmFwcoIYIKgiHfnKZNjZ4dLlfm3nmpAiCzv+n
        3dgvVAKKebKK94UWXoZ2l+v014DaZ1wJoY6BSsffaF6RFZckBSihbqJZLczO4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SmSiQ7xCWe8n3tLVAh8SY5hwaLF7QDHxdm1wHtCdRSI=;
        b=2cS+gj6yRXZ2Op9eC7U2ayabHRY45+3E+4xnQnccYve6paL1BOdSI+evz24S0SvFjanXQr
        ZLdsN8vLzqwqcnBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 03/20] x86/mce: Deduplicate exception handling
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:15 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparatory patch for further simplification. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/mce/core.c |   34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -373,13 +373,16 @@ static int msr_to_offset(u32 msr)
 	return -1;
 }
 
-__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
-				      struct pt_regs *regs, int trapnr,
-				      unsigned long error_code,
-				      unsigned long fault_addr)
+static void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 {
-	pr_emerg("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
-		 (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+	if (wrmsr) {
+		pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
+			 regs->ip, (void *)regs->ip);
+	} else {
+		pr_emerg("MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip);
+	}
 
 	show_stack_regs(regs);
 
@@ -387,7 +390,14 @@ static int msr_to_offset(u32 msr)
 
 	while (true)
 		cpu_relax();
+}
 
+__visible bool ex_handler_rdmsr_fault(const struct exception_table_entry *fixup,
+				      struct pt_regs *regs, int trapnr,
+				      unsigned long error_code,
+				      unsigned long fault_addr)
+{
+	ex_handler_msr_mce(regs, false);
 	return true;
 }
 
@@ -432,17 +442,7 @@ static noinstr u64 mce_rdmsrl(u32 msr)
 				      unsigned long error_code,
 				      unsigned long fault_addr)
 {
-	pr_emerg("MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
-		 (unsigned int)regs->cx, (unsigned int)regs->dx, (unsigned int)regs->ax,
-		  regs->ip, (void *)regs->ip);
-
-	show_stack_regs(regs);
-
-	panic("MCA architectural violation!\n");
-
-	while (true)
-		cpu_relax();
-
+	ex_handler_msr_mce(regs, true);
 	return true;
 }
 

