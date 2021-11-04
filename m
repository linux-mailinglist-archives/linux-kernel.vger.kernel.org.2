Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7914457B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhKDQ7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhKDQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:59:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7793C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8Rz0mZkQehQxcX5yjRFpxiNaHxGLU5lXuprb55c9f0E=; b=Er4CIx38Dn7qKtj27SdXtxMcfM
        VUQDJSexgkZ9Y+ZpYNJT+aAz1RVD6LxD9+WbirKsId6nTHQO19fKpDsY1ZxlsTyk3axpP3sEu6w7X
        MBE9l8bYOz869nWqVlB2eMTP4VHu7ecFF3ygoZEQAR3gm48FnT5FKFZiB8ZQKo8zDjNY5nerijtIG
        qwGIObWQ+yEs/4VGymiDGwlFoLtXTwtizf5g2ZVrJjdXKyNAwsdlwl687EC9EUEAH/2RkihMtHMEm
        QkRoji0HNgXfHR3qMlaOMKPz5Mvo3t31x3AmETKR1F/+2oFhaFUiUxUy7CsxcDzOaKs3mQCM+S0Z1
        f3fqhTWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2W-00EC7a-1w; Thu, 04 Nov 2021 16:56:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3656E3006BA;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 170AF2DD49FB5; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165524.685209465@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 03/22] x86,copy_user_64: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
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


