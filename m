Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F284457AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhKDQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhKDQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:59:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17CC061205
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FwAF+bJxnQgNc7Zbr4m4rMqVhiyCbHvCDahCzDGnf8Y=; b=ZNR4Iv4BVWxw0hfRQpCH435WiQ
        D8PxnDa9JDjGlVcQ/xbucr0bUdBVbJwb4/rmjJhen/kq5geYhp0TbHQYgrZV5oGAPo+F1WMyX+SON
        WCITcOFTiY5YeGeaK8ckwDt8+5LVStxi6nA85AeN9Z+xJcA9eJt5mMprC6nzJpL8zJUfaNZ/IFMOP
        +j3pz2iVHRIvP6/uJ//VPGEWRtyTvBuMzPwjEPM4N7DFVx26zCMWVoUM8mry+DLzg4bcyzVBy+1lF
        muZB0dQzPL0WO9ovQUySwPHcRygni9y5ZuEnXqUujnVp4XmoKjHih0cfjKeNwLKkBGVIpqmYkyr0S
        pk6qf8LQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2X-00EC7j-9m; Thu, 04 Nov 2021 16:56:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 55118301995;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 36AD62DD49FBD; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.107322937@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 10/22] x86,uaccess: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
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
 arch/x86/include/asm/uaccess.h |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

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
+					   EX_FLAG_CLR_AX_DX,		\
+					   %[errout])			\
+		     _ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_EFAULT_REG |	\
+					   EX_FLAG_CLR_AX_DX,		\
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
+	 __get_user_asm(x, ptr, retval, "q", "=a")
 #endif
 
 #define __get_user_size(x, ptr, size, retval)				\
@@ -379,14 +377,14 @@ do {									\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__get_user_asm(x_u8__, ptr, retval, "b", "=q");		\
+		__get_user_asm(x_u8__, ptr, retval, "b", "=a");		\
 		(x) = x_u8__;						\
 		break;							\
 	case 2:								\
-		__get_user_asm(x, ptr, retval, "w", "=r");		\
+		__get_user_asm(x, ptr, retval, "w", "=a");		\
 		break;							\
 	case 4:								\
-		__get_user_asm(x, ptr, retval, "l", "=r");		\
+		__get_user_asm(x, ptr, retval, "l", "=a");		\
 		break;							\
 	case 8:								\
 		__get_user_asm_u64(x, ptr, retval);			\
@@ -400,16 +398,13 @@ do {									\
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
+					   EX_FLAG_CLR_AX,		\
+					   %[errout])			\
 		     : [errout] "=r" (err),				\
 		       [output] ltype(x)				\
 		     : [umem] "m" (__m(addr)),				\
-		       [efault] "i" (-EFAULT), "0" (err))
+		       "0" (err))
 
 #endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 


