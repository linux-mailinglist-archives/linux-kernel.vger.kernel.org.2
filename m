Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447E64467CC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhKER1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhKER06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4168DC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QjJd5c+GNuxdZwQv6LDG5NZVY8zjn8QojxIKsLL+GWw=; b=fdtxBnwrooQW1jjnBoUZHCm5yy
        czXOZiiz92v0MnCPEtSPWK95sF+EvZzO8PKjgTWBBTMbYWsBWgY5/OP526C+zmqIewFE7DTzMQCNV
        dFtB4wfXFuBRt07a4Ly2014Q3+AxZHh81KAi9NLrBATCA9vCH/h6wY9n2w+8mOEcfgtqZl4Q55Ctn
        wiYZdZcUGcMVtntN7GaFX3RRoCc16YnowDp1FPNBMaLzhHpv0VF9OrjtVdkJidzgT+BrkKDpRsrXO
        8HOP+Hk968w35FMWTJZirWYdio+WtvLKTvMoHO3OxCzepJMpjM56oif8dzHumv+IdF2NFbqkmZuAv
        xkaf7PIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sY-006hZu-IJ; Fri, 05 Nov 2021 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C492E301994;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6233B201C7B58; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.048378088@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 10/22] x86,uaccess: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the !CC_AS_ASM_GOTO_OUTPUT (aka. the legacy codepath), remove the
.fixup usage by employing both EX_TYPE_EFAULT_REG and EX_FLAG_CLR.
Like was already done for X86_32's version of __get_user_asm_u64()
use the "a" register for output, specifically so we can use CLR_AX.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/uaccess.h |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -351,24 +351,22 @@ do {									\
 		     "1:	movl %[lowbits],%%eax\n"		\
 		     "2:	movl %[highbits],%%edx\n"		\
 		     "3:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "4:	mov %[efault],%[errout]\n"		\
-		     "	xorl %%eax,%%eax\n"				\
-		     "	xorl %%edx,%%edx\n"				\
-		     "	jmp 3b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_UA(1b, 4b)				\
-		     _ASM_EXTABLE_UA(2b, 4b)				\
+		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG |	\
+					   EX_FLAG_CLEAR_AX_DX,		\
+					   %[errout])			\
+		     _ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_EFAULT_REG |	\
+					   EX_FLAG_CLEAR_AX_DX,		\
+					   %[errout])			\
 		     : [errout] "=r" (retval),				\
 		       [output] "=&A"(x)				\
 		     : [lowbits] "m" (__m(__ptr)),			\
 		       [highbits] "m" __m(((u32 __user *)(__ptr)) + 1),	\
-		       [efault] "i" (-EFAULT), "0" (retval));		\
+		       "0" (retval));					\
 })
 
 #else
 #define __get_user_asm_u64(x, ptr, retval) \
-	 __get_user_asm(x, ptr, retval, "q", "=r")
+	 __get_user_asm(x, ptr, retval, "q")
 #endif
 
 #define __get_user_size(x, ptr, size, retval)				\
@@ -379,14 +377,14 @@ do {									\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__get_user_asm(x_u8__, ptr, retval, "b", "=q");		\
+		__get_user_asm(x_u8__, ptr, retval, "b");		\
 		(x) = x_u8__;						\
 		break;							\
 	case 2:								\
-		__get_user_asm(x, ptr, retval, "w", "=r");		\
+		__get_user_asm(x, ptr, retval, "w");			\
 		break;							\
 	case 4:								\
-		__get_user_asm(x, ptr, retval, "l", "=r");		\
+		__get_user_asm(x, ptr, retval, "l");			\
 		break;							\
 	case 8:								\
 		__get_user_asm_u64(x, ptr, retval);			\
@@ -396,20 +394,17 @@ do {									\
 	}								\
 } while (0)
 
-#define __get_user_asm(x, addr, err, itype, ltype)			\
+#define __get_user_asm(x, addr, err, itype)				\
 	asm volatile("\n"						\
 		     "1:	mov"itype" %[umem],%[output]\n"		\
 		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:	mov %[efault],%[errout]\n"		\
-		     "	xorl %k[output],%k[output]\n"			\
-		     "	jmp 2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG | \
+					   EX_FLAG_CLEAR_AX,		\
+					   %[errout])			\
 		     : [errout] "=r" (err),				\
-		       [output] ltype(x)				\
+		       [output] "=a" (x)				\
 		     : [umem] "m" (__m(addr)),				\
-		       [efault] "i" (-EFAULT), "0" (err))
+		       "0" (err))
 
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 


