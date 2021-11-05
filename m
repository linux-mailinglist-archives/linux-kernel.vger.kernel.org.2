Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22714467D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhKER11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhKER06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D540C061210
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BsaFN7ppKcfq3kObU08u/k1zuuiOEDzX7U9L+5fuPJg=; b=AQ+JsGjCotxaEbtxOFZs+AlHWa
        e3jhLdlRHZvGH6Y0L9ZayvB8uEeTvkH0XJ/sepCqtzGfqVGbXb27RMlIAY/4NzE8WocZyMiO22/vv
        tCw7Ni492ydE3D3jRHdu+OKcXohzaWyEWEIBRZZjHXlfIQ90KjMYNEEiarCCa6Hn2J4VF+P8xRfLP
        02a/FP0Iq+QlQFhC5bnlWGvVI0rpkNJpMyzHUjih6j7zDdEC/+h0/i8ZJmAxKYyBSTgvLpUgdSgRV
        Gir+RKNb2DHc1M3z7kMxt3rC+3QUcwIgQrpJqR9X4A3HRI2I6UjcosMxaypFkQ+Jca+HkRO5ZBk27
        9p/ZOcBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sY-006hZr-HE; Fri, 05 Nov 2021 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BF811300C88;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5E811201C7B57; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171820.987853861@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 09/22] x86,futex: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new EX_TYPE_IMM_REG to store -EFAULT into the designated 'ret'
register, this removes the need for anonymous .fixup code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    2 ++
 arch/x86/include/asm/futex.h               |   28 ++++++++--------------------
 2 files changed, 10 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -32,6 +32,8 @@
 #define	EX_TYPE_DEFAULT_MCE_SAFE	14
 #define	EX_TYPE_FAULT_MCE_SAFE		15
 #define	EX_TYPE_POP_ZERO		16
+
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
+#define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
 
 #endif
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -17,13 +17,9 @@ do {								\
 	int oldval = 0, ret;					\
 	asm volatile("1:\t" insn "\n"				\
 		     "2:\n"					\
-		     "\t.section .fixup,\"ax\"\n"		\
-		     "3:\tmov\t%3, %1\n"			\
-		     "\tjmp\t2b\n"				\
-		     "\t.previous\n"				\
-		     _ASM_EXTABLE_UA(1b, 3b)			\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %1) \
 		     : "=r" (oldval), "=r" (ret), "+m" (*uaddr)	\
-		     : "i" (-EFAULT), "0" (oparg), "1" (0));	\
+		     : "0" (oparg), "1" (0));	\
 	if (ret)						\
 		goto label;					\
 	*oval = oldval;						\
@@ -39,15 +35,11 @@ do {								\
 		     "3:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"	\
 		     "\tjnz\t2b\n"				\
 		     "4:\n"					\
-		     "\t.section .fixup,\"ax\"\n"		\
-		     "5:\tmov\t%5, %1\n"			\
-		     "\tjmp\t4b\n"				\
-		     "\t.previous\n"				\
-		     _ASM_EXTABLE_UA(1b, 5b)			\
-		     _ASM_EXTABLE_UA(3b, 5b)			\
+		     _ASM_EXTABLE_TYPE_REG(1b, 4b, EX_TYPE_EFAULT_REG, %1) \
+		     _ASM_EXTABLE_TYPE_REG(3b, 4b, EX_TYPE_EFAULT_REG, %1) \
 		     : "=&a" (oldval), "=&r" (ret),		\
 		       "+m" (*uaddr), "=&r" (tem)		\
-		     : "r" (oparg), "i" (-EFAULT), "1" (0));	\
+		     : "r" (oparg), "1" (0));			\
 	if (ret)						\
 		goto label;					\
 	*oval = oldval;						\
@@ -95,15 +87,11 @@ static inline int futex_atomic_cmpxchg_i
 	if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 	asm volatile("\n"
-		"1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
+		"1:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"
 		"2:\n"
-		"\t.section .fixup, \"ax\"\n"
-		"3:\tmov     %3, %0\n"
-		"\tjmp     2b\n"
-		"\t.previous\n"
-		_ASM_EXTABLE_UA(1b, 3b)
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %0) \
 		: "+r" (ret), "=a" (oldval), "+m" (*uaddr)
-		: "i" (-EFAULT), "r" (newval), "1" (oldval)
+		: "r" (newval), "1" (oldval)
 		: "memory"
 	);
 	user_access_end();


