Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7832E4457B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhKDQ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhKDQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:59:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD4C061205
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SKEs1t9v5OutH8dydjOsFW3jP6ePsH6AfhcDSss3zg0=; b=rdmufhUrZscYLsW4NUmsfssgIc
        3W4CTScPYLtrv45CdBMJc1wZfFAly4pPqtm2PCXjEJ7Orgi3T6cEX0E1scUbiXyZKHBn/8okOfHz4
        J8QskDJr1y0UIzJo3L+qyS0wFUifts4pYNJlFfzXsUqE3EB+lNBrE3QiwKHA8RrfgMJreOEQQ6o3Z
        YNs9ud1hADtkd8hDmcL2+9QjkcWgarZep821mgAPbd8kfIk9EmHFVI0n4CWU0tP1odXu+WAalaOKz
        OWIVJ553EWIFZNWPkhknuG8zmSW8tIuz5mpIJUnZ9NqjWEA/7AH6zEIFvnBhPJh5nyGcD4Y02/Oso
        ohkShokw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2W-00EC7b-1w; Thu, 04 Nov 2021 16:56:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 30961300130;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 140A12DD49FB4; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165524.625383149@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 02/22] x86,mmx_32: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code puts an exception table entry on the "PREFIX" instruction to
overwrite it with a jmp.d8 when it triggers an exception. Except of
course, our code is no longer writable, also SMP.

Replace it with ALTERNATIVE, the novel

XXX: arguably we should just delete this code

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/mmx_32.c |   83 ++++++++++++++++----------------------------------
 1 file changed, 27 insertions(+), 56 deletions(-)

--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -50,23 +50,17 @@ void *_mmx_memcpy(void *to, const void *
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
+			    "prefetch 256(%0)\n", X86_FEATURE_3DNOW
+		: : "r" (from));
 
 	for ( ; i > 5; i--) {
 		__asm__ __volatile__ (
-		"1:  prefetch 320(%0)\n"
-		"2:  movq (%0), %%mm0\n"
+		"  movq (%0), %%mm0\n"
 		"  movq 8(%0), %%mm1\n"
 		"  movq 16(%0), %%mm2\n"
 		"  movq 24(%0), %%mm3\n"
@@ -82,11 +76,6 @@ void *_mmx_memcpy(void *to, const void *
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
@@ -177,22 +166,17 @@ static void fast_copy_page(void *to, voi
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
+			    "prefetch 256(%0)\n", X86_FEATURE_3DNOW
+		: : "r" (from));
 
 	for (i = 0; i < (4096-320)/64; i++) {
 		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
+		"   movq (%0), %%mm0\n"
 		"   movntq %%mm0, (%1)\n"
 		"   movq 8(%0), %%mm1\n"
 		"   movntq %%mm1, 8(%1)\n"
@@ -208,11 +192,7 @@ static void fast_copy_page(void *to, voi
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
@@ -220,7 +200,7 @@ static void fast_copy_page(void *to, voi
 
 	for (i = (4096-320)/64; i < 4096/64; i++) {
 		__asm__ __volatile__ (
-		"2: movq (%0), %%mm0\n"
+		"   movq (%0), %%mm0\n"
 		"   movntq %%mm0, (%1)\n"
 		"   movq 8(%0), %%mm1\n"
 		"   movntq %%mm1, 8(%1)\n"
@@ -237,6 +217,7 @@ static void fast_copy_page(void *to, voi
 		"   movq 56(%0), %%mm7\n"
 		"   movntq %%mm7, 56(%1)\n"
 			: : "r" (from), "r" (to) : "memory");
+
 		from += 64;
 		to += 64;
 	}
@@ -295,22 +276,17 @@ static void fast_copy_page(void *to, voi
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
+			    "prefetch 256(%0)\n", X86_FEATURE_3DNOW
+		: : "r" (from));
 
 	for (i = 0; i < 4096/64; i++) {
 		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
+		"   movq (%0), %%mm0\n"
 		"   movq 8(%0), %%mm1\n"
 		"   movq 16(%0), %%mm2\n"
 		"   movq 24(%0), %%mm3\n"
@@ -326,11 +302,6 @@ static void fast_copy_page(void *to, voi
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


