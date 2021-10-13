Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3B42C03B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbhJMMmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbhJMMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:42:27 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F0FC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QQPJl+3ZmiohTD9n1MpzdTPeSiWu7JER+ilCsxVGnzI=; b=BvKUXQ27SjdgshrGMF6lz96/8t
        vvxsER9sKkaw1NUPGQsghC2xTpNjgke4J2Y667HQI0qeo6x26rxJHRRIAuwUSerIhyvNMXx/AB1S1
        WOJkmhKf6/OJuSlRvIdbGRp+cKPxR9fv6t/aXsJpGiicE+NQJlG5+Kob68xfbKJy4XJ3Jah+Ls7zl
        H/1AF9gud7VMoozNwZrUYvafMmD9+087LNSsUkRNDsrCSAH4aoIDBMxMe5d9C8mzJD890HPWM0KTM
        q7ne8SYff//BS9COoSojBk3roiuMdPByOviwUno6xUUtdEeCardTRQdSfIPIZejCc9xLi3+Ah1unx
        qZJcnICg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madYN-009bnu-3w; Wed, 13 Oct 2021 12:40:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 217F1300BD9;
        Wed, 13 Oct 2021 14:40:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C010D2098532B; Wed, 13 Oct 2021 14:40:13 +0200 (CEST)
Message-ID: <20211013123645.245747489@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 13 Oct 2021 14:22:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH 6/9] x86/alternative: Try inline spectre_v2=retpoline,amd
References: <20211013122217.304265366@infradead.org>
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
 arch/x86/kernel/alternative.c |   24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -389,15 +389,13 @@ static int emit_indirect(int op, int reg
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
-
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
-		return -1;
 
 	target = addr + insn->length + insn->immediate.value;
 	reg = (target - &__x86_indirect_thunk_rax) /
@@ -406,7 +404,22 @@ static int patch_retpoline(void *addr, s
 	if (WARN_ON_ONCE(reg & ~0xf))
 		return -1;
 
-	op = insn->opcode.bytes[0];
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
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
+		return -1;
 
 	/*
 	 * Convert:
@@ -430,6 +443,7 @@ static int patch_retpoline(void *addr, s
 		op = JMP32_INSN_OPCODE;
 	}
 
+indirect:
 	ret = emit_indirect(op, reg, bytes + i);
 	if (ret < 0)
 		return ret;


