Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8766A4467CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhKER1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhKER06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EAAC06120B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=j5BQzhdfpHBi8SHBnIfzr/y2xjeKrF5sVSCfNpdsNxk=; b=RTgJ1DaauS0ax69B7LKh4Rasl8
        tNZ3rHrttER184Bez7gJmBY8Qdhlzzerc8YQxeBWk0owmCX6/c+XeCxidZgftAoPV5u8A20pvEE7F
        6Gr5FLJRL8WOfs9HXBfIVdIydhdQ0bz/hpgI0YB86hZGlLwpMa4XnSQH6hBG+qdgB5RrX/2vCToql
        jXt68wd9EzOuhvywLLtJc8JP/XNSmNG9YV/KBfT+KOOmlIufCZz7+Z6jVW2XMAsiiFMZjRaCBVPgO
        WmirptjN9TqLWKk2DYYygjZh2w3PPbQSu2mrMyIkSFOKZ1zirnKdyVnNvIHW4PFKZp6uMUwsUgivU
        lxMeipOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sY-006hZs-HD; Fri, 05 Nov 2021 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF9D530198B;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5A53D201C7B56; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171820.928094505@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 08/22] x86,msr: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the MSR accessors to remove .fixup usage. Add two new extable
types (to the 4 already existing msr ones) using the new register
infrastructure to record which register should get the error value.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |   23 ++++++-------
 arch/x86/include/asm/msr.h                 |   26 ++++----------
 arch/x86/mm/extable.c                      |   51 +++++++++++++++--------------
 3 files changed, 47 insertions(+), 53 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -27,17 +27,16 @@
 #define	EX_TYPE_COPY			 4
 #define	EX_TYPE_CLEAR_FS		 5
 #define	EX_TYPE_FPU_RESTORE		 6
-#define	EX_TYPE_WRMSR			 7
-#define	EX_TYPE_RDMSR			 8
-#define	EX_TYPE_BPF			 9
-
-#define	EX_TYPE_WRMSR_IN_MCE		10
-#define	EX_TYPE_RDMSR_IN_MCE		11
-
-#define	EX_TYPE_DEFAULT_MCE_SAFE	12
-#define	EX_TYPE_FAULT_MCE_SAFE		13
-
-#define	EX_TYPE_POP_ZERO		14
-#define	EX_TYPE_IMM_REG			15 /* reg := (long)imm */
+#define	EX_TYPE_BPF			 7
+#define	EX_TYPE_WRMSR			 8
+#define	EX_TYPE_RDMSR			 9
+#define	EX_TYPE_WRMSR_SAFE		10 /* reg := -EIO */
+#define	EX_TYPE_RDMSR_SAFE		11 /* reg := -EIO */
+#define	EX_TYPE_WRMSR_IN_MCE		12
+#define	EX_TYPE_RDMSR_IN_MCE		13
+#define	EX_TYPE_DEFAULT_MCE_SAFE	14
+#define	EX_TYPE_FAULT_MCE_SAFE		15
+#define	EX_TYPE_POP_ZERO		16
+#define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 
 #endif
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -137,17 +137,11 @@ static inline unsigned long long native_
 {
 	DECLARE_ARGS(val, low, high);
 
-	asm volatile("2: rdmsr ; xor %[err],%[err]\n"
-		     "1:\n\t"
-		     ".section .fixup,\"ax\"\n\t"
-		     "3: mov %[fault],%[err]\n\t"
-		     "xorl %%eax, %%eax\n\t"
-		     "xorl %%edx, %%edx\n\t"
-		     "jmp 1b\n\t"
-		     ".previous\n\t"
-		     _ASM_EXTABLE(2b, 3b)
+	asm volatile("1: rdmsr ; xor %[err],%[err]\n"
+		     "2:\n\t"
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_RDMSR_SAFE, %[err])
 		     : [err] "=r" (*err), EAX_EDX_RET(val, low, high)
-		     : "c" (msr), [fault] "i" (-EIO));
+		     : "c" (msr));
 	if (tracepoint_enabled(read_msr))
 		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), *err);
 	return EAX_EDX_VAL(val, low, high);
@@ -169,15 +163,11 @@ native_write_msr_safe(unsigned int msr,
 {
 	int err;
 
-	asm volatile("2: wrmsr ; xor %[err],%[err]\n"
-		     "1:\n\t"
-		     ".section .fixup,\"ax\"\n\t"
-		     "3:  mov %[fault],%[err] ; jmp 1b\n\t"
-		     ".previous\n\t"
-		     _ASM_EXTABLE(2b, 3b)
+	asm volatile("1: wrmsr ; xor %[err],%[err]\n"
+		     "2:\n\t"
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_WRMSR_SAFE, %[err])
 		     : [err] "=a" (err)
-		     : "c" (msr), "0" (low), "d" (high),
-		       [fault] "i" (-EIO)
+		     : "c" (msr), "0" (low), "d" (high)
 		     : "memory");
 	if (tracepoint_enabled(write_msr))
 		do_trace_write_msr(msr, ((u64)high << 32 | low), err);
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -83,28 +83,29 @@ static bool ex_handler_copy(const struct
 	return ex_handler_fault(fixup, regs, trapnr);
 }
 
-static bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs)
+static bool ex_handler_msr(const struct exception_table_entry *fixup,
+			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
 {
-	if (pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
+	if (!safe && wrmsr &&
+	    pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
+			 (unsigned int)regs->cx, (unsigned int)regs->dx,
+			 (unsigned int)regs->ax,  regs->ip, (void *)regs->ip))
+		show_stack_regs(regs);
+
+	if (!safe && !wrmsr &&
+	    pr_warn_once("unchecked MSR access error: RDMSR from 0x%x at rIP: 0x%lx (%pS)\n",
 			 (unsigned int)regs->cx, regs->ip, (void *)regs->ip))
 		show_stack_regs(regs);
 
-	/* Pretend that the read succeeded and returned 0. */
-	regs->ax = 0;
-	regs->dx = 0;
-	return ex_handler_default(fixup, regs);
-}
+	if (!wrmsr) {
+		/* Pretend that the read succeeded and returned 0. */
+		regs->ax = 0;
+		regs->dx = 0;
+	}
 
-static bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup,
-				    struct pt_regs *regs)
-{
-	if (pr_warn_once("unchecked MSR access error: WRMSR to 0x%x (tried to write 0x%08x%08x) at rIP: 0x%lx (%pS)\n",
-			 (unsigned int)regs->cx, (unsigned int)regs->dx,
-			 (unsigned int)regs->ax,  regs->ip, (void *)regs->ip))
-		show_stack_regs(regs);
+	if (safe)
+		*pt_regs_nr(regs, reg) = -EIO;
 
-	/* Pretend that the write succeeded. */
 	return ex_handler_default(fixup, regs);
 }
 
@@ -186,18 +187,22 @@ int fixup_exception(struct pt_regs *regs
 		return ex_handler_clear_fs(e, regs);
 	case EX_TYPE_FPU_RESTORE:
 		return ex_handler_fprestore(e, regs);
-	case EX_TYPE_RDMSR:
-		return ex_handler_rdmsr_unsafe(e, regs);
-	case EX_TYPE_WRMSR:
-		return ex_handler_wrmsr_unsafe(e, regs);
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(e, regs);
-	case EX_TYPE_RDMSR_IN_MCE:
-		ex_handler_msr_mce(regs, false);
-		break;
+	case EX_TYPE_WRMSR:
+		return ex_handler_msr(e, regs, true, false, reg);
+	case EX_TYPE_RDMSR:
+		return ex_handler_msr(e, regs, false, false, reg);
+	case EX_TYPE_WRMSR_SAFE:
+		return ex_handler_msr(e, regs, true, true, reg);
+	case EX_TYPE_RDMSR_SAFE:
+		return ex_handler_msr(e, regs, false, true, reg);
 	case EX_TYPE_WRMSR_IN_MCE:
 		ex_handler_msr_mce(regs, true);
 		break;
+	case EX_TYPE_RDMSR_IN_MCE:
+		ex_handler_msr_mce(regs, false);
+		break;
 	case EX_TYPE_POP_ZERO:
 		return ex_handler_pop_zero(e, regs);
 	case EX_TYPE_IMM_REG:


