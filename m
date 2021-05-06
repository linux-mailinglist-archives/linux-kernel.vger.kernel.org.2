Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA1375BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhEFTnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhEFTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:43:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7C7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=b0nnO7A4PZ/ugtZRyGAfLnX1a7hO4hxIVjnHyJDt6sU=; b=IVcHd5OWS4ge6jemhNo4QSbKZP
        r+7Dj0UWsispFsEaOcG9jNtXm2+RIvZvyChNbVmYpshSz9NyVKouBzdsFNYhi+1CfriFRvyZs7vIT
        TKBe965rO4r+wXn/n4Z+ImfFJtbUf2xCXsEMZGIVFPeYgNDeB2c8YGgwvtu5ihQc1RA5VtbY6w794
        YBMyah1DQnuAx2ImcOCyGZJm6saj1zgqhfPX8kzwuzyyd8h3lynBKD3OrM9c+xqT+3U2P/rrQ/nZx
        KY+fiWJAVIWO74lLqYD/HC+J2XuTYKeaVyXmRS6xCRUPZOSVxOroA46kJxpm3CQG1yM5G6BGRQx8b
        HsveM8lQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtS-005BLu-DW; Thu, 06 May 2021 19:42:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18A8130035C;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B61A520B96F8C; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.846870383@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 07/13] jump_label, x86: Add variable length patching support
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the patching to to emit 2 byte JMP/NOP instruction in
addition to the 5 byte JMP/NOP we already did. This allows for more
compact code.

This code is not yet used, as we don't emit shorter code at compile
time yet.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/jump_label.c |   53 ++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 18 deletions(-)

--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -23,44 +23,63 @@ int arch_jump_entry_size(struct jump_ent
 	return JMP32_INSN_SIZE;
 }
 
-static const void *
-__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
+struct jump_label_patch {
+	const void *code;
+	int size;
+};
+
+static struct jump_label_patch
+__jump_label_patch(struct jump_entry *entry, enum jump_label_type type)
 {
-	const void *expect, *code;
+	const void *expect, *code, *nop;
 	const void *addr, *dest;
+	int size;
 
 	addr = (void *)jump_entry_code(entry);
 	dest = (void *)jump_entry_target(entry);
 
-	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+	size = arch_jump_entry_size(entry);
+	switch (size) {
+	case JMP8_INSN_SIZE:
+		code = text_gen_insn(JMP8_INSN_OPCODE, addr, dest);
+		nop = x86_nops[size];
+		break;
+
+	case JMP32_INSN_SIZE:
+		code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
+		nop = x86_nops[size];
+		break;
+
+	default: BUG();
+	}
 
 	if (type == JUMP_LABEL_JMP)
-		expect = x86_nops[5];
+		expect = nop;
 	else
 		expect = code;
 
-	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE)) {
+	if (memcmp(addr, expect, size)) {
 		/*
 		 * The location is not an op that we were expecting.
 		 * Something went wrong. Crash the box, as something could be
 		 * corrupting the kernel.
 		 */
-		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) type:%d\n",
-				addr, addr, addr, expect, type);
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) size:%d type:%d\n",
+				addr, addr, addr, expect, size, type);
 		BUG();
 	}
 
 	if (type == JUMP_LABEL_NOP)
-		code = x86_nops[5];
+		code = nop;
 
-	return code;
+	return (struct jump_label_patch){.code = code, .size = size};
 }
 
 static inline void __jump_label_transform(struct jump_entry *entry,
 					  enum jump_label_type type,
 					  int init)
 {
-	const void *opcode = __jump_label_set_jump_code(entry, type);
+	const struct jump_label_patch jlp = __jump_label_patch(entry, type);
 
 	/*
 	 * As long as only a single processor is running and the code is still
@@ -74,12 +93,11 @@ static inline void __jump_label_transfor
 	 * always nop being the 'currently valid' instruction
 	 */
 	if (init || system_state == SYSTEM_BOOTING) {
-		text_poke_early((void *)jump_entry_code(entry), opcode,
-				JUMP_LABEL_NOP_SIZE);
+		text_poke_early((void *)jump_entry_code(entry), jlp.code, jlp.size);
 		return;
 	}
 
-	text_poke_bp((void *)jump_entry_code(entry), opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	text_poke_bp((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 }
 
 static void __ref jump_label_transform(struct jump_entry *entry,
@@ -100,7 +118,7 @@ void arch_jump_label_transform(struct ju
 bool arch_jump_label_transform_queue(struct jump_entry *entry,
 				     enum jump_label_type type)
 {
-	const void *opcode;
+	struct jump_label_patch jlp;
 
 	if (system_state == SYSTEM_BOOTING) {
 		/*
@@ -111,9 +129,8 @@ bool arch_jump_label_transform_queue(str
 	}
 
 	mutex_lock(&text_mutex);
-	opcode = __jump_label_set_jump_code(entry, type);
-	text_poke_queue((void *)jump_entry_code(entry),
-			opcode, JUMP_LABEL_NOP_SIZE, NULL);
+	jlp = __jump_label_patch(entry, type);
+	text_poke_queue((void *)jump_entry_code(entry), jlp.code, jlp.size, NULL);
 	mutex_unlock(&text_mutex);
 	return true;
 }


