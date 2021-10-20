Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486694349AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhJTLG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhJTLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:06:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06324C061765
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xSMVP5j96yVHQwjbR9gNeckaGov+Y1BQGvjn8ahsflw=; b=S6ODRhq9HxfjnfJbB+gmA6h7Pl
        TjmBRm0KrK9dQdr6EVXM/MSLdaUVuNpg/n8yYWCZ+I0bMVq3DVJDOlkURtCQI//FGqZxVpTzsuGaF
        6xpVmkS09g7SYcYOq8tSmv47IL2yO1IAmIe3CzcOeVnmoo94bB0bz7x8MeP//U6+1HYDxNuGNbalL
        oWoe87OI21I/9qiLwgyy6wb5CJ2MCoWg0/0gIdmFIqkCDcbRf2bBriH5MXAXy0xxxA3bZyE17Fua6
        P/v7zC7jT2Z98jsgNUPQMYKxPOmxLBf9KEHTUSDbv+R8KVz3qO4poA6RRhkMXhT/HQSwt5GirUx5Y
        JXZ9IfAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md9L1-00CR12-9N; Wed, 20 Oct 2021 11:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C2C73007C3;
        Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 17070201BB3D0; Wed, 20 Oct 2021 13:00:50 +0200 (CEST)
Message-ID: <20211020105843.102958676@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 20 Oct 2021 12:44:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        alexei.starovoitov@gmail.com, ndesaulniers@google.com
Subject: [PATCH v2 10/14] x86/alternative: Handle Jcc __x86_indirect_thunk_\reg
References: <20211020104442.021802560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the rare cases where the compiler (clang) does an indirect
conditional tail-call using:

  Jcc __x86_indirect_thunk_\reg

For the !RETPOLINE case this can be rewritten to fit the original (6
byte) instruction like:

  Jncc.d8	1f
  JMP		*%\reg
  NOP
1:

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -393,7 +393,8 @@ static int emit_indirect(int op, int reg
 static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 {
 	void (*target)(void);
-	int reg, i = 0;
+	int reg, ret, i = 0;
+	u8 op, cc;
 
 	target = addr + insn->length + insn->immediate.value;
 	reg = (target - &__x86_indirect_thunk_rax) /
@@ -408,9 +409,34 @@ static int patch_retpoline(void *addr, s
 	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
 		return -1;
 
-	i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
-	if (i < 0)
-		return i;
+	op = insn->opcode.bytes[0];
+
+	/*
+	 * Convert:
+	 *
+	 *   Jcc.d32 __x86_indirect_thunk_\reg
+	 *
+	 * into:
+	 *
+	 *   Jncc.d8 1f
+	 *   jmp *%\reg
+	 *   nop
+	 * 1:
+	 */
+	if (op == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80) {
+		cc = insn->opcode.bytes[1] & 0xf;
+		cc ^= 1; /* invert condition */
+
+		bytes[i++] = 0x70 + cc; /* Jcc.d8 */
+		bytes[i++] = insn->length - 2;
+
+		op = JMP32_INSN_OPCODE;
+	}
+
+	ret = emit_indirect(op, reg, bytes + i);
+	if (ret < 0)
+		return ret;
+	i += ret;
 
 	for (; i < insn->length;)
 		bytes[i++] = BYTES_NOP1;
@@ -444,6 +470,10 @@ void __init_or_module noinline apply_ret
 		case JMP32_INSN_OPCODE:
 			break;
 
+		case 0x0f: /* escape */
+			if (op2 >= 0x80 && op2 <= 0x8f)
+				break;
+			fallthrough;
 		default:
 			WARN_ON_ONCE(1);
 			continue;


