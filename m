Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06CF42C04A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhJMMot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhJMMom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D82C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RvEiESAon9INzA+1Tv/e/j465wRogDxFivAWRLQ5cCI=; b=XgZbwC/NNndAwUwSn7vNnM/I3G
        SmdKmUO8tiukwmjtLAAPRnvQPGf3FzxXFelkt4kVxrr9ekoW4mc6UZTuhiwFBeBWZDJIn/RaaSNyI
        cPCb59Qdekx9DMuqv5lOTcu7WM/C4BUrPPIgnmkfkKHJJ/x4yL6xFR6q4bAq4rFo9WrzVFhALgdXr
        p1FlWzfGdSBa+FOae5q7QMHP0jVaBNnlZ1mOZ73AV7jCozdDLl3OJOah31IXaod6G388kA/0ghrmP
        nEObfoc296mqfORRfiBCejopvUa8hRw++MYEEEB9rEL62l6kU6jABR+mDNPI8u/n9noFvFFk2TCFV
        XQNM019Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madYM-007QZQ-7K; Wed, 13 Oct 2021 12:40:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D354730031A;
        Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A8D912083A882; Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Message-ID: <20211013123644.794292635@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 14:22:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH 2/9] x86/retpoline: Remove unused replacement symbols
References: <20211013122217.304265366@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that objtool no longer creates alternatives, these replacement
symbols are no longer needed, remove them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/retpoline.S |   42 ------------------------------------------
 1 file changed, 42 deletions(-)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -41,36 +41,6 @@ SYM_FUNC_END(__x86_indirect_thunk_\reg)
 .endm
 
 /*
- * This generates .altinstr_replacement symbols for use by objtool. They,
- * however, must not actually live in .altinstr_replacement since that will be
- * discarded after init, but module alternatives will also reference these
- * symbols.
- *
- * Their names matches the "__x86_indirect_" prefix to mark them as retpolines.
- */
-.macro ALT_THUNK reg
-
-	.align 1
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	call	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_call_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_call_\reg)
-
-SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
-	ANNOTATE_RETPOLINE_SAFE
-1:	jmp	*%\reg
-2:	.skip	5-(2b-1b), 0x90
-SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)
-
-STACK_FRAME_NON_STANDARD(__x86_indirect_alt_jmp_\reg)
-
-.endm
-
-/*
  * Despite being an assembler file we can't just use .irp here
  * because __KSYM_DEPS__ only uses the C preprocessor and would
  * only see one instance of "__x86_indirect_thunk_\reg" rather
@@ -92,15 +62,3 @@ STACK_FRAME_NON_STANDARD(__x86_indirect_
 #undef GEN
 #define GEN(reg) EXPORT_THUNK(reg)
 #include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) ALT_THUNK reg
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_call_ ## reg)
-#include <asm/GEN-for-each-reg.h>
-
-#undef GEN
-#define GEN(reg) __EXPORT_THUNK(__x86_indirect_alt_jmp_ ## reg)
-#include <asm/GEN-for-each-reg.h>


