Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F871375BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbhEFTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270EC06138B
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zN+cgK9L1vGhTGBZmLlXfmugO1t8jyzZ97aV4L6C/NU=; b=dhsaPUJqgadKCDfmfm66r66qwK
        PY8R4d9hWpWSgaJUfCQRZWBJqCcz46dOVgiNIl5vhJLWfLmesugoJ8iUMs1bj8/Pq+BjT3VJ5Ua27
        4gEkrcKTWNIvyUmbVJxB3rMMSiJPKd+z4TTPaU1SBhQNZHo6cdyIVMlwnY5nSmGpgT98HN0IvdtaM
        hgh+Cm8/qwQgrR672OI3/lgJfaIOwzRZJQ4DlErLQD5liCdra99VufSIULHDsfYvH9Tb3KYWJhqQG
        miC/Rbh755Z0PA1hdgznatBVs3eHlYfce9kuZuqL8o7M3IhCfqXMlwH1Xq6aFa6PObqD/gbVSFIxE
        wrdLWlJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtS-002ADF-Cw; Thu, 06 May 2021 19:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18A3E300359;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BF10820B96F8E; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.967034497@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:34:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 09/13] jump_label,x86: Emit short JMP
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can patch short JMP/NOP, allow the compiler/assembler to
emit short JMP instructions.

There is no way to have the assembler emit short NOPs based on the
potential displacement, so leave those long for now.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |    3 +--
 arch/x86/kernel/jump_label.c      |    8 +++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -35,8 +35,7 @@ static __always_inline bool arch_static_
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9 \n\t"
-		".long %l[l_yes] - (. + 4) \n\t"
+		"jmp %l[l_yes]\n\t"
 		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -15,12 +15,18 @@
 #include <asm/kprobes.h>
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
+#include <asm/insn.h>
 
 #define JUMP_LABEL_NOP_SIZE	JMP32_INSN_SIZE
 
 int arch_jump_entry_size(struct jump_entry *entry)
 {
-	return JMP32_INSN_SIZE;
+	struct insn insn = {};
+
+	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
+	BUG_ON(insn.length != 2 && insn.length != 5);
+
+	return insn.length;
 }
 
 struct jump_label_patch {


