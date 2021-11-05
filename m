Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C20564467B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhKERW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhKERWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BD5C06120D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FDlj2/hrMdHccfeNJ9LQTDqkfYdqrI/6JO6ehX/p+uo=; b=WdeMswYOCLUY5wJQYAlQADEBe8
        0lgKAt7/2sx4MyiU15YoIwNLSdVpxjEW5Z/s9EItPq8WqPo4wboooUvXrGSbQbeVRCGPem0juvcTA
        A95qaDMhdkYjR10oxFmhQZS0N+eYiYT6ayI0oMqwF0hef/vFKPEQZnhi+5SUJEdfOmh+sFmLtQBOU
        3o4m8k74A2sj/20jSm5Dy/d6qj0QG8sOY1SVyP2ZIHXshueUEWtPqNfynF9yjrnHUYfdlMIJgMNFp
        lhf1Kqu/iiaJrBAM3NiYxZJq8vaS8idl+4isVU/3lB3t0tgWK71uX21HnNSKFx50dJ7Ls+0mgRt1a
        fpHsk72Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sa-00ENBF-V3; Fri, 05 Nov 2021 17:19:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7128302A12;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8C528203C0069; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.593025759@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 19/22] x86,usercopy: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically usercopy does whole word copies followed by a number of byte
copies to finish the tail. This means that on exception it needs to
compute the remaining length as: words*sizeof(long) + bytes.

Create a new extable handler to do just this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    5 +++++
 arch/x86/lib/usercopy_32.c                 |   28 +++++-----------------------
 arch/x86/lib/usercopy_64.c                 |    8 +++-----
 arch/x86/mm/extable.c                      |    9 +++++++++
 4 files changed, 22 insertions(+), 28 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -46,4 +46,9 @@
 
 #define	EX_TYPE_FAULT_SGX		18
 
+#define	EX_TYPE_UCOPY_LEN		19 /* cx := reg + imm*cx */
+#define	EX_TYPE_UCOPY_LEN1		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(1))
+#define	EX_TYPE_UCOPY_LEN4		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(4))
+#define	EX_TYPE_UCOPY_LEN8		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(8))
+
 #endif
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -43,11 +43,7 @@ do {									\
 		"	movl %2,%0\n"					\
 		"1:	rep; stosb\n"					\
 		"2: " ASM_CLAC "\n"					\
-		".section .fixup,\"ax\"\n"				\
-		"3:	lea 0(%2,%0,4),%0\n"				\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		_ASM_EXTABLE_UA(0b, 3b)					\
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %2)	\
 		_ASM_EXTABLE_UA(1b, 2b)					\
 		: "=&c"(size), "=&D" (__d0)				\
 		: "r"(size & 3), "0"(size / 4), "1"(addr), "a"(0));	\
@@ -149,10 +145,6 @@ __copy_user_intel(void __user *to, const
 		       "36:    movl %%eax, %0\n"
 		       "37:    rep; movsb\n"
 		       "100:\n"
-		       ".section .fixup,\"ax\"\n"
-		       "101:   lea 0(%%eax,%0,4),%0\n"
-		       "       jmp 100b\n"
-		       ".previous\n"
 		       _ASM_EXTABLE_UA(1b, 100b)
 		       _ASM_EXTABLE_UA(2b, 100b)
 		       _ASM_EXTABLE_UA(3b, 100b)
@@ -190,7 +182,7 @@ __copy_user_intel(void __user *to, const
 		       _ASM_EXTABLE_UA(35b, 100b)
 		       _ASM_EXTABLE_UA(36b, 100b)
 		       _ASM_EXTABLE_UA(37b, 100b)
-		       _ASM_EXTABLE_UA(99b, 101b)
+		       _ASM_EXTABLE_TYPE_REG(99b, 100b, EX_TYPE_UCOPY_LEN4, %%eax)
 		       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 		       :  "1"(to), "2"(from), "0"(size)
 		       : "eax", "edx", "memory");
@@ -255,10 +247,6 @@ static unsigned long __copy_user_intel_n
 	       "        movl %%eax,%0\n"
 	       "7:      rep; movsb\n"
 	       "8:\n"
-	       ".section .fixup,\"ax\"\n"
-	       "9:      lea 0(%%eax,%0,4),%0\n"
-	       "        jmp 8b\n"
-	       ".previous\n"
 	       _ASM_EXTABLE_UA(0b, 8b)
 	       _ASM_EXTABLE_UA(1b, 8b)
 	       _ASM_EXTABLE_UA(2b, 8b)
@@ -277,7 +265,7 @@ static unsigned long __copy_user_intel_n
 	       _ASM_EXTABLE_UA(81b, 8b)
 	       _ASM_EXTABLE_UA(14b, 8b)
 	       _ASM_EXTABLE_UA(91b, 8b)
-	       _ASM_EXTABLE_UA(6b, 9b)
+	       _ASM_EXTABLE_TYPE_REG(6b, 8b, EX_TYPE_UCOPY_LEN4, %%eax)
 	       _ASM_EXTABLE_UA(7b, 8b)
 	       : "=&c"(size), "=&D" (d0), "=&S" (d1)
 	       :  "1"(to), "2"(from), "0"(size)
@@ -315,14 +303,8 @@ do {									\
 		"	movl %3,%0\n"					\
 		"1:	rep; movsb\n"					\
 		"2:\n"							\
-		".section .fixup,\"ax\"\n"				\
-		"5:	addl %3,%0\n"					\
-		"	jmp 2b\n"					\
-		"3:	lea 0(%3,%0,4),%0\n"				\
-		"	jmp 2b\n"					\
-		".previous\n"						\
-		_ASM_EXTABLE_UA(4b, 5b)					\
-		_ASM_EXTABLE_UA(0b, 3b)					\
+		_ASM_EXTABLE_TYPE_REG(4b, 2b, EX_TYPE_UCOPY_LEN1, %3)	\
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %3)	\
 		_ASM_EXTABLE_UA(1b, 2b)					\
 		: "=&c"(size), "=&D" (__d0), "=&S" (__d1), "=r"(__d2)	\
 		: "3"(size), "0"(size), "1"(to), "2"(from)		\
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -35,12 +35,10 @@ unsigned long __clear_user(void __user *
 		"	incq   %[dst]\n"
 		"	decl %%ecx ; jnz  1b\n"
 		"2:\n"
-		".section .fixup,\"ax\"\n"
-		"3:	lea 0(%[size1],%[size8],8),%[size8]\n"
-		"	jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE_UA(0b, 3b)
+
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN8, %[size1])
 		_ASM_EXTABLE_UA(1b, 2b)
+
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
 		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
 	clac();
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -145,6 +145,13 @@ static bool ex_handler_imm_reg(const str
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_ucopy_leng(const struct exception_table_entry *fixup,
+				   struct pt_regs *regs, int trapnr, int reg, int imm)
+{
+	regs->cx = imm * regs->cx + *pt_regs_nr(regs, reg);
+	return ex_handler_uaccess(fixup, regs, trapnr);
+}
+
 int ex_get_fixup_type(unsigned long ip)
 {
 	const struct exception_table_entry *e = search_exception_tables(ip);
@@ -217,6 +224,8 @@ int fixup_exception(struct pt_regs *regs
 		return ex_handler_imm_reg(e, regs, reg, imm);
 	case EX_TYPE_FAULT_SGX:
 		return ex_handler_sgx(e, regs, trapnr);
+	case EX_TYPE_UCOPY_LEN:
+		return ex_handler_ucopy_leng(e, regs, trapnr, reg, imm);
 	}
 	BUG();
 }


