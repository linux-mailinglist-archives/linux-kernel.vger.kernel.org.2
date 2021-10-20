Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076AE4349A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJTLGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJTLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2344C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RvEiESAon9INzA+1Tv/e/j465wRogDxFivAWRLQ5cCI=; b=SHZpP4wLKBLUDW9RI/dlYUFQRF
        DcG0M3rgl1pYqhpQx2AsgZ3LQY3hCBsJBUJVHtMFwMGLWqhtHUan2AhCdOw+TEtqHCBTv+GZCM1ZJ
        XKtNHcKvny7XSElnxRcj4weWyd7xJVQO/t6uXHG6j9xgVHJgR6MEpbFe/GqC4sDnsWew4cJSIb3WE
        GyrGzixndv5ttzS3Naas+nt6rWyQFl7bHsIMu8MopIK7OP2v4W68LP0UjvVgEGgQmCe1s502Mjzpx
        WuYms1lqwaPwhu7br4jNdw6wdmCe9vlj81BfBHEi4ADNKRMfxFNR2azu+OwSUbBjKPL/Z1bcbjUyz
        tdwjoavw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00CR11-8V; Wed, 20 Oct 2021 11:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28267300728;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EBD5C201BB3C9; Wed, 20 Oct 2021 13:00:49 +0200 (CEST)
Message-ID: <20211020105842.798997433@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 05/14] x86/retpoline: Remove unused replacement symbols
References: <20211020104442.021802560@infradead.org>
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


