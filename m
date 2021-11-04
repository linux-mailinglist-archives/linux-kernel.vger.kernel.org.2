Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5674457B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhKDQ7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhKDQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:59:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5053AC061205
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=I8R3FR9xqx17XufxMVOMSdsLJK57PamKjiHE7gXbPN4=; b=d5IGcr20qZ/7l/fye01YlhUCTL
        SrCw/PN0AbTHUeY0bKLH0igmilx03HsfOMGfgmi4aHERMZNvVyuQmCEkkjyAGA6XV0eOoSGDwtLPg
        Aa5P/71g4eOlqwsOgdRMwd5JSc7PJ88IAu5z0YAXsw+Nd9GGJym8eMqR70cp8lpa6rFu7bpHpzN/k
        yFDh9p20lItWiNAC5CxuqLU/GcRs8TFLsIrtKAc7T9oh0py1x2olRDpEvAJZET2QGbJhC0mx2SVES
        MZQZ8Gi95PywPTVQB8g0XySPbnO1pBGO1WtM5UFZBFxv++7dgJdUI6B0gYNryeno5fojt2Sbla1c3
        Bx1Dw4/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2Z-00EC8O-64; Thu, 04 Nov 2021 16:56:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 73619302A12;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 62ECB2DD49FB2; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.708941275@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 20/22] x86,usercopy: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
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
@@ -42,4 +42,9 @@
 #define	EX_TYPE_FAULT_SGX		18
 #define	EX_TYPE_KVM_FASTOP		19
 
+#define	EX_TYPE_UACCESS_LEN		20 /* cx := reg + imm*cx */
+#define	EX_TYPE_UACCESS_LEN1		(EX_TYPE_UACCESS_LEN | EX_TYPE_IMM(1))
+#define	EX_TYPE_UACCESS_LEN4		(EX_TYPE_UACCESS_LEN | EX_TYPE_IMM(4))
+#define	EX_TYPE_UACCESS_LEN8		(EX_TYPE_UACCESS_LEN | EX_TYPE_IMM(8))
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
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UACCESS_LEN4, %2)	\
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
+		       _ASM_EXTABLE_TYPE_REG(99b, 100b, EX_TYPE_UACCESS_LEN4, %eax)
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
+	       _ASM_EXTABLE_TYPE_REG(6b, 8b, EX_TYPE_UACCESS_LEN4, %eax)
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
+		_ASM_EXTABLE_TYPE_REG(4b, 2b, EX_TYPE_UACCESS_LEN1, %3)	\
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UACCESS_LEN4, %3)	\
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
+		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UACCESS_LEN8, %[size1])
 		_ASM_EXTABLE_UA(1b, 2b)
+
 		: [size8] "=&c"(size), [dst] "=&D" (__d0)
 		: [size1] "r"(size & 7), "[size8]" (size / 8), "[dst]"(addr));
 	clac();
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -163,6 +163,13 @@ static bool ex_handler_kvm_fastop(const
 	return true;
 }
 
+static bool ex_handler_uaccess_len(const struct exception_table_entry *fixup,
+				   struct pt_regs *regs, int trapnr, int reg, int imm)
+{
+	regs->cx = imm * regs->cx + *pt_regs_nr(regs, reg);
+	return ex_handler_uaccess(fixup, regs, trapnr);
+}
+
 #define EX_TYPE_MASK	0x000000FF
 #define EX_REG_MASK	0x00000F00
 #define EX_FLAG_MASK	0x0000F000
@@ -242,6 +249,8 @@ int fixup_exception(struct pt_regs *regs
 		return ex_handler_sgx(e, regs, trapnr);
 	case EX_TYPE_KVM_FASTOP:
 		return ex_handler_kvm_fastop(e, regs);
+	case EX_TYPE_UACCESS_LEN:
+		return ex_handler_uaccess_len(e, regs, trapnr, reg, imm);
 	}
 	BUG();
 }


