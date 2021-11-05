Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497804467D1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhKER1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhKER06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544F6C06120E
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8Rz0mZkQehQxcX5yjRFpxiNaHxGLU5lXuprb55c9f0E=; b=Lui5BnuAmKM9/1iaeAej3QQPCB
        sJEaWR2bLtFVeoj96X35z53l1CMhMvpZ2WUVGChaowkw1rgXs6nBJs6wFtSHu1z0FU/OAlFZUMkAw
        jAO+NvTXtMZqHJlEvJzNauZCtDhSvNidH9eLga3IUthspk3zSnf8U3L5i+TEGBOJqmyK857wrUxPf
        ph3KbqqRc3Q1TxKLUNXYf6ME0SnXpHgEuEx6BosZfFS41/5lRft/1vgkjC7DQU8V3aZOCiQOcDzNt
        +Ftr7z7e92KoIX9rhjoFI82vpawzpcHS67YMm3SFmAWvaPCiUGnmZ/NAUSP5iIwVGA/ApwVp673As
        hekAEU3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sX-006hZq-3H; Fri, 05 Nov 2021 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AFE53005F4;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 40C63201ED0CA; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171820.629235268@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 03/22] x86,copy_user_64: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the anonymous .fixup code at the tail of the regular functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/copy_user_64.S |   32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -32,14 +32,10 @@
 	decl %ecx
 	jnz 100b
 102:
-	.section .fixup,"ax"
-103:	addl %ecx,%edx			/* ecx is zerorest also */
-	jmp .Lcopy_user_handle_tail
-	.previous
 
-	_ASM_EXTABLE_CPY(100b, 103b)
-	_ASM_EXTABLE_CPY(101b, 103b)
-	.endm
+	_ASM_EXTABLE_CPY(100b, .Lcopy_user_handle_align)
+	_ASM_EXTABLE_CPY(101b, .Lcopy_user_handle_align)
+.endm
 
 /*
  * copy_user_generic_unrolled - memory copy with exception handling.
@@ -107,7 +103,6 @@ SYM_FUNC_START(copy_user_generic_unrolle
 	ASM_CLAC
 	ret
 
-	.section .fixup,"ax"
 30:	shll $6,%ecx
 	addl %ecx,%edx
 	jmp 60f
@@ -115,7 +110,6 @@ SYM_FUNC_START(copy_user_generic_unrolle
 	jmp 60f
 50:	movl %ecx,%edx
 60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, 30b)
 	_ASM_EXTABLE_CPY(2b, 30b)
@@ -166,20 +160,16 @@ SYM_FUNC_START(copy_user_generic_string)
 	movl %edx,%ecx
 	shrl $3,%ecx
 	andl $7,%edx
-1:	rep
-	movsq
+1:	rep movsq
 2:	movl %edx,%ecx
-3:	rep
-	movsb
+3:	rep movsb
 	xorl %eax,%eax
 	ASM_CLAC
 	ret
 
-	.section .fixup,"ax"
 11:	leal (%rdx,%rcx,8),%ecx
 12:	movl %ecx,%edx		/* ecx is zerorest also */
 	jmp .Lcopy_user_handle_tail
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, 11b)
 	_ASM_EXTABLE_CPY(3b, 12b)
@@ -203,16 +193,13 @@ SYM_FUNC_START(copy_user_enhanced_fast_s
 	cmpl $64,%edx
 	jb .L_copy_short_string	/* less then 64 bytes, avoid the costly 'rep' */
 	movl %edx,%ecx
-1:	rep
-	movsb
+1:	rep movsb
 	xorl %eax,%eax
 	ASM_CLAC
 	ret
 
-	.section .fixup,"ax"
 12:	movl %ecx,%edx		/* ecx is zerorest also */
 	jmp .Lcopy_user_handle_tail
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, 12b)
 SYM_FUNC_END(copy_user_enhanced_fast_string)
@@ -240,6 +227,11 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_
 	ret
 
 	_ASM_EXTABLE_CPY(1b, 2b)
+
+.Lcopy_user_handle_align:
+	addl %ecx,%edx			/* ecx is zerorest also */
+	jmp .Lcopy_user_handle_tail
+
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
 /*
@@ -350,7 +342,6 @@ SYM_FUNC_START(__copy_user_nocache)
 	sfence
 	ret
 
-	.section .fixup,"ax"
 .L_fixup_4x8b_copy:
 	shll $6,%ecx
 	addl %ecx,%edx
@@ -366,7 +357,6 @@ SYM_FUNC_START(__copy_user_nocache)
 .L_fixup_handle_tail:
 	sfence
 	jmp .Lcopy_user_handle_tail
-	.previous
 
 	_ASM_EXTABLE_CPY(1b, .L_fixup_4x8b_copy)
 	_ASM_EXTABLE_CPY(2b, .L_fixup_4x8b_copy)


