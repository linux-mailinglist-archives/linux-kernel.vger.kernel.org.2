Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ECD44BE58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhKJKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BEAC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TTF1UV5LZXr3lh3C33okjA/5I2Cp9czNNmnRX54Js1I=; b=ZjuhPoA9M+p6pLHL0VUXZLPid2
        Xm3WPngLnnLJquraSIoIuMPdjG6Ythv0UfayYU6VYw9fam+9YlWZZMvRW3u9pkAMkTIcA3oWUs8m/
        OgG1fxZX/skATBsZuRwTcXMx+H3vqUEczbxYbIZmTMH4Hd825Mi5HASulOYRISHZ7jvGwRbmJn2em
        mKtPJIG7SbQJsHJcPo2GTwwrhbZLoJu6AUmaFNsrZI+TN2r//4jHrUrtBezO7QVo7omEl2LXO/19L
        L1R22DFHQv3eZI94cHUw70THJ2Dv3lHxfzIiEkdjaBdULqMaGLMCT6fKL/8/blDJz/VEZRvxfz5YU
        occd850w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeE-001lkR-RH; Wed, 10 Nov 2021 10:16:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7ABCC3005CA;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6021D203BF63A; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.009464367@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 02/23] x86,mmx_32: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code puts an exception table entry on the PREFETCH instruction
to overwrite it with a JMP.d8 when it triggers an exception. Except of
course, our code is no longer writable, also SMP.

Replace it with ALTERNATIVE, the 'new' way of doing these things.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/mmx_32.c |   86 +++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 56 deletions(-)

--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -50,23 +50,18 @@ void *_mmx_memcpy(void *to, const void *
 	kernel_fpu_begin_mask(KFPU_387);
 
 	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"		/* This set is 28 bytes */
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
-			: : "r" (from));
+		ALTERNATIVE "",
+			    "prefetch (%0)\n"
+			    "prefetch 64(%0)\n"
+			    "prefetch 128(%0)\n"
+			    "prefetch 192(%0)\n"
+			    "prefetch 256(%0)\n", X86_FEATURE_3DNOWPREFETCH
+		: : "r" (from));
 
 	for ( ; i > 5; i--) {
 		__asm__ __volatile__ (
-		"1:  prefetch 320(%0)\n"
-		"2:  movq (%0), %%mm0\n"
+		ALTERNATIVE "", "prefetch 320(%0)\n", X86_FEATURE_3DNOWPREFETCH
+		"  movq (%0), %%mm0\n"
 		"  movq 8(%0), %%mm1\n"
 		"  movq 16(%0), %%mm2\n"
 		"  movq 24(%0), %%mm3\n"
@@ -82,11 +77,6 @@ void *_mmx_memcpy(void *to, const void *
 		"  movq %%mm1, 40(%1)\n"
 		"  movq %%mm2, 48(%1)\n"
 		"  movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
 			: : "r" (from), "r" (to) : "memory");
 
 		from += 64;
@@ -177,22 +167,18 @@ static void fast_copy_page(void *to, voi
 	 * but that is for later. -AV
 	 */
 	__asm__ __volatile__(
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b) : : "r" (from));
+		ALTERNATIVE "",
+			    "prefetch (%0)\n"
+			    "prefetch 64(%0)\n"
+			    "prefetch 128(%0)\n"
+			    "prefetch 192(%0)\n"
+			    "prefetch 256(%0)\n", X86_FEATURE_3DNOWPREFETCH
+		: : "r" (from));
 
 	for (i = 0; i < (4096-320)/64; i++) {
 		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
+		ALTERNATIVE "", "prefetch 320(%0)\n", X86_FEATURE_3DNOWPREFETCH
+		"   movq (%0), %%mm0\n"
 		"   movntq %%mm0, (%1)\n"
 		"   movq 8(%0), %%mm1\n"
 		"   movntq %%mm1, 8(%1)\n"
@@ -208,11 +194,7 @@ static void fast_copy_page(void *to, voi
 		"   movntq %%mm6, 48(%1)\n"
 		"   movq 56(%0), %%mm7\n"
 		"   movntq %%mm7, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE(1b, 3b) : : "r" (from), "r" (to) : "memory");
+			: : "r" (from), "r" (to) : "memory");
 
 		from += 64;
 		to += 64;
@@ -220,7 +202,7 @@ static void fast_copy_page(void *to, voi
 
 	for (i = (4096-320)/64; i < 4096/64; i++) {
 		__asm__ __volatile__ (
-		"2: movq (%0), %%mm0\n"
+		"   movq (%0), %%mm0\n"
 		"   movntq %%mm0, (%1)\n"
 		"   movq 8(%0), %%mm1\n"
 		"   movntq %%mm1, 8(%1)\n"
@@ -237,6 +219,7 @@ static void fast_copy_page(void *to, voi
 		"   movq 56(%0), %%mm7\n"
 		"   movntq %%mm7, 56(%1)\n"
 			: : "r" (from), "r" (to) : "memory");
+
 		from += 64;
 		to += 64;
 	}
@@ -295,22 +278,18 @@ static void fast_copy_page(void *to, voi
 	kernel_fpu_begin_mask(KFPU_387);
 
 	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b) : : "r" (from));
+		ALTERNATIVE "",
+			    "prefetch (%0)\n"
+			    "prefetch 64(%0)\n"
+			    "prefetch 128(%0)\n"
+			    "prefetch 192(%0)\n"
+			    "prefetch 256(%0)\n", X86_FEATURE_3DNOWPREFETCH
+		: : "r" (from));
 
 	for (i = 0; i < 4096/64; i++) {
 		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
+		ALTERNATIVE "", "prefetch 320(%0)\n", X86_FEATURE_3DNOWPREFETCH
+		"   movq (%0), %%mm0\n"
 		"   movq 8(%0), %%mm1\n"
 		"   movq 16(%0), %%mm2\n"
 		"   movq 24(%0), %%mm3\n"
@@ -326,11 +305,6 @@ static void fast_copy_page(void *to, voi
 		"   movq %%mm1, 40(%1)\n"
 		"   movq %%mm2, 48(%1)\n"
 		"   movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
 			: : "r" (from), "r" (to) : "memory");
 
 		from += 64;


