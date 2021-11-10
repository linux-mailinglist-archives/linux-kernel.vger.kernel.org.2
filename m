Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC17444BE66
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhKJKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhKJKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98367C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BsaFN7ppKcfq3kObU08u/k1zuuiOEDzX7U9L+5fuPJg=; b=KZt2dd/a0Uy2HmW+93YUY/KJpB
        2IthVKBOn89i5NKr3xlFa8aX8XIkIU3uLpwa9Scza8JGX1pgGJz7u2U3CJGAThM5JPta2y6QnSYuX
        69FbnAekNvKW7WP92mfl9w8hgtu/zAg0xi/Pd21n27pYy6yCPj2seXMmCc2CBp2SjVpFBoit8+K2w
        nQwANADkFstlPJaZ4rzxTUatFSEER9QkvuHWTE8LpfwHG0iIE/2Zs2FOotWHj1/VWxrN7Z6IkEDIY
        HvTU+B4KLk++lM91XHnzXlaQWOs7+rzL2o7QzLMdwLtqIQxIIpJW6GGV2rfxUbpJOY2BCTvXIxKM/
        GkJQtpdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-00FFpm-7R; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC8203010C2;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7D3992015DC2F; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.426016322@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 09/23] x86,futex: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
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


