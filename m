Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E324457D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhKDREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9ABC06120B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=5EidmflN1FISKMVzA9sUXSQxCA5c9nKoVVrPLxsEVqM=; b=OFNoPIaXSAHbqFqvRgXeX749vt
        uk62WmK8WjOS8C3xCMjW/0ScKv+lyGwwuhi2+5ZjwPlVG/hfvrGxjMJq4ddJ0t5UxFQ5fKXLv+/qW
        7TDHExCUAhaqOukQpEA5PriM8OSJtwPHgWQmD9ihmq5GfvD0UXF6VqUesT4HG9TVrSuGk/aqh+pip
        6GrYu5FPg0NOlSdVHHbOHW5EBn7lMzAVVE+/Nd/br+Sg6dcCErxM39YnvF9nnievjtuyYqT7KxW+G
        jgLTlcuLlhsHAOH+qiiuxndX602mKkhLaFV0mDpxUz9Y7Baj9fs/7LlkZpo2DG9fz5sDk28kOFO3w
        WMUI7mug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2Y-0060Fu-Hw; Thu, 04 Nov 2021 16:57:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65B9430221D;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 514EC2DD49FB6; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.527997216@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 17/22] x86,sgx: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create EX_TYPE_FAULT_SGX which does as EX_TYPE_FAULT does, except adds
this extra bit that SGX really fanies having.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    2 +
 arch/x86/include/asm/sgx.h                 |   18 ++++++++++++++
 arch/x86/kernel/cpu/sgx/encls.h            |   36 ++++-------------------------
 arch/x86/mm/extable.c                      |   10 ++++++++
 4 files changed, 35 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -39,4 +39,6 @@
 #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(0))
 #define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(1))
 
+#define	EX_TYPE_FAULT_SGX		18
+
 #endif
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -46,6 +46,24 @@ enum sgx_encls_function {
 };
 
 /**
+ * SGX_ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
+ *
+ * ENCLS has its own (positive value) error codes and also generates
+ * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
+ * with system error codes as everything percolates back up the stack.
+ * Unfortunately (for us), we need to precisely identify each unique
+ * error code, e.g. the action taken if EWB fails varies based on the
+ * type of fault and on the exact SGX error code, i.e. we can't simply
+ * convert all faults to -EFAULT.
+ *
+ * To make all three error types coexist, we set bit 30 to identify an
+ * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
+ * between positive (faults and SGX error codes) and negative (system
+ * error codes) values.
+ */
+#define SGX_ENCLS_FAULT_FLAG 0x40000000
+
+/**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -11,26 +11,8 @@
 #include <asm/traps.h>
 #include "sgx.h"
 
-/**
- * ENCLS_FAULT_FLAG - flag signifying an ENCLS return code is a trapnr
- *
- * ENCLS has its own (positive value) error codes and also generates
- * ENCLS specific #GP and #PF faults.  And the ENCLS values get munged
- * with system error codes as everything percolates back up the stack.
- * Unfortunately (for us), we need to precisely identify each unique
- * error code, e.g. the action taken if EWB fails varies based on the
- * type of fault and on the exact SGX error code, i.e. we can't simply
- * convert all faults to -EFAULT.
- *
- * To make all three error types coexist, we set bit 30 to identify an
- * ENCLS fault.  Bit 31 (technically bits N:31) is used to differentiate
- * between positive (faults and SGX error codes) and negative (system
- * error codes) values.
- */
-#define ENCLS_FAULT_FLAG 0x40000000
-
 /* Retrieve the encoded trapnr from the specified return code. */
-#define ENCLS_TRAPNR(r) ((r) & ~ENCLS_FAULT_FLAG)
+#define ENCLS_TRAPNR(r) ((r) & ~SGX_ENCLS_FAULT_FLAG)
 
 /* Issue a WARN() about an ENCLS function. */
 #define ENCLS_WARN(r, name) {						  \
@@ -50,7 +32,7 @@
  */
 static inline bool encls_faulted(int ret)
 {
-	return ret & ENCLS_FAULT_FLAG;
+	return ret & SGX_ENCLS_FAULT_FLAG;
 }
 
 /**
@@ -88,11 +70,7 @@ static inline bool encls_failed(int ret)
 	asm volatile(						\
 	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
 	"2:\n"							\
-	".section .fixup,\"ax\"\n"				\
-	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
-	"   jmp 2b\n"						\
-	".previous\n"						\
-	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_SGX)		\
 	: "=a"(ret)						\
 	: "a"(rax), inputs					\
 	: "memory", "cc");					\
@@ -127,7 +105,7 @@ static inline bool encls_failed(int ret)
  *
  * Return:
  *   0 on success,
- *   trapnr with ENCLS_FAULT_FLAG set on fault
+ *   trapnr with SGX_ENCLS_FAULT_FLAG set on fault
  */
 #define __encls_N(rax, rbx_out, inputs...)			\
 	({							\
@@ -136,11 +114,7 @@ static inline bool encls_failed(int ret)
 	"1: .byte 0x0f, 0x01, 0xcf;\n\t"			\
 	"   xor %%eax,%%eax;\n"					\
 	"2:\n"							\
-	".section .fixup,\"ax\"\n"				\
-	"3: orl $"__stringify(ENCLS_FAULT_FLAG)",%%eax\n"	\
-	"   jmp 2b\n"						\
-	".previous\n"						\
-	_ASM_EXTABLE_FAULT(1b, 3b)				\
+	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_SGX)		\
 	: "=a"(ret), "=b"(rbx_out)				\
 	: "a"(rax), inputs					\
 	: "memory");						\
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -9,6 +9,7 @@
 #include <asm/sev.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
+#include <asm/sgx.h>
 
 static inline unsigned long *pt_regs_nr(struct pt_regs *regs, int nr)
 {
@@ -146,6 +147,13 @@ static bool ex_handler_imm_reg(const str
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_sgx(const struct exception_table_entry *fixup,
+			   struct pt_regs *regs, int trapnr)
+{
+	regs->ax = trapnr | SGX_ENCLS_FAULT_FLAG;
+	return ex_handler_default(fixup, regs);
+}
+
 #define EX_TYPE_MASK	0x000000FF
 #define EX_REG_MASK	0x00000F00
 #define EX_FLAG_MASK	0x0000F000
@@ -221,6 +229,8 @@ int fixup_exception(struct pt_regs *regs
 		return ex_handler_pop_seg(e, regs);
 	case EX_TYPE_IMM_REG:
 		return ex_handler_imm_reg(e, regs, reg, imm);
+	case EX_TYPE_FAULT_SGX:
+		return ex_handler_sgx(e, regs, trapnr);
 	}
 	BUG();
 }


