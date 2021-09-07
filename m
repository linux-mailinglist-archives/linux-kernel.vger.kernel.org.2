Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD962402F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346527AbhIGUZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:25:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346457AbhIGUZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:25:53 -0400
Message-ID: <20210907200848.411800641@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SmSiQ7xCWe8n3tLVAh8SY5hwaLF7QDHxdm1wHtCdRSI=;
        b=Vwl156kSvuS3Aw/k4jCrVxNn8T96Wu06fLD99+SxZxZRoofVVGj1st+lmXVFdHoORqrhy+
        Hvki2AI2FDQPfbPvMrnFTffx+IFNbpi7CHIvWS2HN5TpCdD9ejzqbEYkABPa+V5AYAo69m
        scblxhLlg07otYTCfdJkrj0C+OiNTD0/t23fha91dSAv4dFWMuA6zfMJHMzTPOSP3WEgPH
        f8AIIEJ4FSmIBYIR8gqhotpTEjX2XsHX8DwNrnXUTRm5WQ/nGGCqT1JI80xLEcZJmXhTHO
        8P6BcmmaqzpQejlJbntCDIAPnOEOWfJmfgw/hMazjTqsESG5NRGTgAy52E30BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=SmSiQ7xCWe8n3tLVAh8SY5hwaLF7QDHxdm1wHtCdRSI=;
        b=pbP0pocdn+aCQPNxZiC/J6522hF+V0Q6Rv9f7FMe9SBprPwORlwDPOSOSIYXDrZTbcTxA4
        s1u5/Oceef9HcVBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 03/20] x86/mce: Deduplicate exception handling
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:44 +0200 (CEST)
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
 

