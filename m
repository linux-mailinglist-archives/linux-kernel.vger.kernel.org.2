Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09662375BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhEFTpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18778C06138C
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=spwKOAaPMkax7g3y36qhZyQjssDY1X8RFz+x7JOk2pE=; b=UPyrpgciynioEQ7uBQjNteUIkC
        c8JqYyELfznWoBZV53XSf5B9s0L0whrrmvBE0qIKSjQTznS0KPQAYLPeY6ZfJMwvsKNb49bW5tSQU
        M2xPAsOZ3p0/HcOganqnTjbr+UZ7rQDgO/p2EKOrfudi/6AC40rOmCbGR+whqaGP7qyD8JVp5VrRC
        oQ4LsyvPrOtbLKHXLaF5F1zwhZW1UMg8YqKMOFBUECGy3LFRh6WNoGOQrMjv8awCT3HSQcxlI/knP
        5boUnuPydqr3Bff9ppy3xf088SdEXYkjSmLkk2yTd2Hc3rylYijIgYmb3xdn64pbj/FRLeov06gDd
        qidWguUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtQ-002ADC-C2; Thu, 06 May 2021 19:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBAA7300350;
        Thu,  6 May 2021 21:42:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A5E9120B96F85; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.599716762@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 03/13] jump_label, x86: Strip ASM jump_label support
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In prepration for variable size jump_label support; remove all ASM
bits, which are currently unused.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |   36 ------------------------------------
 1 file changed, 36 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -47,42 +47,6 @@ static __always_inline bool arch_static_
 	return true;
 }
 
-#else	/* __ASSEMBLY__ */
-
-.macro STATIC_JUMP_IF_TRUE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.else
-	.byte		BYTES_NOP5
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key - .
-	.popsection
-.endm
-
-.macro STATIC_JUMP_IF_FALSE target, key, def
-.Lstatic_jump_\@:
-	.if \def
-	.byte		BYTES_NOP5
-	.else
-	/* Equivalent to "jmp.d32 \target" */
-	.byte		0xe9
-	.long		\target - .Lstatic_jump_after_\@
-.Lstatic_jump_after_\@:
-	.endif
-	.pushsection __jump_table, "aw"
-	_ASM_ALIGN
-	.long		.Lstatic_jump_\@ - ., \target - .
-	_ASM_PTR	\key + 1 - .
-	.popsection
-.endm
-
 #endif	/* __ASSEMBLY__ */
 
 #endif


