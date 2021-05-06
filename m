Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2716375BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhEFToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbhEFTnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:43:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C5C06138B
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=kTND8cMaqzAiYz7N4YuTWnLrD0yRhC/y3Dt46Y3ZObk=; b=FNrv1FUD9/a4VxUjsj7wVOqxtf
        ZAWcCcEKlE2UewFHHUBRPkICpBaUQWqsN/RewkJ4gaXGuWElrD6GeYXy23zuS3NcIV9AURFUhO+m+
        XXOGnad6un/9FYtfvm5sa4cin756HeiSwppZr0+nW2aYlhRNCvQ1CWSMu5rbhvi6JGMt2RCuOduhP
        jH4mBLWUexrQB+haOglsIKGOrOkXRnX7wf+aiWVSoSc+OmtXtsyqKH3jfB5nOKCAcl9bE+au8z7GM
        nqA+/Qc0p5GcCMT0jgqps5dSSfCEZa6c0OQybqJB7NWjL4CEt2yE/RE+r4+qoXCR/JWYIdnG7QFoG
        ZXUZBhPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtS-005BLs-D9; Thu, 06 May 2021 19:42:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 195D830035D;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ADC3F20B96F89; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.726939027@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 05/13] jump_label, x86: Improve error when we fail expected text
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single usage site left, remove the function and extend
the print to include more information, like the expected text and the
patch type.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/jump_label.c |   33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,38 +16,33 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-static void bug_at(const void *ip, int line)
-{
-	/*
-	 * The location is not an op that we were expecting.
-	 * Something went wrong. Crash the box, as something could be
-	 * corrupting the kernel.
-	 */
-	pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph) %d\n", ip, ip, ip, line);
-	BUG();
-}
-
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
 {
 	const void *expect, *code;
 	const void *addr, *dest;
-	int line;
 
 	addr = (void *)jump_entry_code(entry);
 	dest = (void *)jump_entry_target(entry);
 
 	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
 
-	if (type == JUMP_LABEL_JMP) {
-		expect = x86_nops[5]; line = __LINE__;
-	} else {
-		expect = code; line = __LINE__;
+	if (type == JUMP_LABEL_JMP)
+		expect = x86_nops[5];
+	else
+		expect = code;
+
+	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE)) {
+		/*
+		 * The location is not an op that we were expecting.
+		 * Something went wrong. Crash the box, as something could be
+		 * corrupting the kernel.
+		 */
+		pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph != %5ph)) type:%d\n",
+				addr, addr, addr, expect, type);
+		BUG();
 	}
 
-	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
-		bug_at(addr, line);
-
 	if (type == JUMP_LABEL_NOP)
 		code = x86_nops[5];
 


