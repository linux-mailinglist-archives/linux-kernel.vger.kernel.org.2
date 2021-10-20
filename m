Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3E4349AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhJTLG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJTLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A1C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lYGyymg5C8ylJ6CrqYR1qZZocrAi78wdz+kgthYdXKo=; b=iGVsdiS3qJ8Ud8+BGDDb/1NlKA
        3CrsxWfyvQWAVM0ypBxWCaxA/+eN6sb26CPx/Yv/OuYKM7agoq8tosvHPBOIRqG2zOU7jhhhoehOR
        tsf8WWgdwFEs/7Md/DGHIjoOgBaiwfuUouTuPU/IdBC1UBknFivU9HDy6R91zX6M3o7BRwMaTWZAz
        T10b2GuQ7CZbc+mvANEOOc3HBKhNt7zjSAsHEruA+DiZulMdeyJLOCljukb4ow2rVjEliLz/6MWd9
        /MNtbeUa9BLpDeZXswK+joQT5ATFyX1AJ436xmRtxQdbrQZuGBslmcN3nKLgFUcexsA8COG/gCWAv
        IGnvPOsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00CR13-9N; Wed, 20 Oct 2021 11:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 305AC30099C;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1BB24201BB3C5; Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Message-ID: <20211020105843.162995272@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 11/14] x86/alternative: Try inline spectre_v2=retpoline,amd
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try and replace retpoline thunk calls with:

  lfence
  call    *%\reg

for spectre_v2=retpoline,amd.

Specifically, the sequence above is 5 bytes for the low 8 registers,
but 6 bytes for the high 8 registers. This means that unless the
compilers prefix stuff the call with higher registers this replacement
will fail.

Luckily GCC strongly favours RAX for the indirect calls and most (95%+
for defconfig-x86_64) will be converted. OTOH clang strongly favours
R11 and almost nothing gets converted.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -389,12 +389,13 @@ static int emit_indirect(int op, int reg
  *
  *   CALL *%\reg
  *
+ * It also tries to inline spectre_v2=retpoline,amd when size permits.
  */
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
+	u8 cc, op = insn->opcode.bytes[0];
 	void (*target)(void);
 	int reg, ret, i = 0;
-	u8 op, cc;
 
 	target = addr + insn->length + insn->immediate.value;
 	reg = (target - &__x86_indirect_thunk_rax) /
@@ -406,11 +407,23 @@ static int patch_retpoline(void *addr, s
 	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
 	BUG_ON(reg == 4);
 
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
+		/*
+		 * Can't do nothing about the Jcc case here.
+		 */
+		if (op != JMP32_INSN_OPCODE && op != CALL_INSN_OPCODE)
+			return -1;
+
+		bytes[i++] = 0x0f;
+		bytes[i++] = 0xae;
+		bytes[i++] = 0xe8; /* lfence */
+
+		goto indirect;
+	}
+
 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
 		return -1;
 
-	op = insn->opcode.bytes[0];
-
 	/*
 	 * Convert:
 	 *
@@ -433,6 +446,7 @@ static int patch_retpoline(void *addr, s
 		op = JMP32_INSN_OPCODE;
 	}
 
+indirect:
 	ret = emit_indirect(op, reg, bytes + i);
 	if (ret < 0)
 		return ret;


