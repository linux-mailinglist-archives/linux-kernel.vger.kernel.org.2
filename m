Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F5F375BED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhEFTpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E1C06138D
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=hkvQMeUwV3lUUZcHckLdVsZKUO+Em/Rb7jbt+jRJULk=; b=qHh1CFEY5Egi+5dlDfqjtG8qnh
        e/E4EDMvesLbzbdOP0+edu/8Z2Mczm1iDDAhSlvEIBqnjfnv1qkv7XpXvk8ksws+nwhyIkidseBPX
        /i6g+RLjkI55PcX00sVTzih1PGaI1JtiyALRoOGanfRwWqXqsGtjg3b50Qi49hRZ3isaHI/TvCnlw
        8f9S4zgwkZTenV8+zWtG82yQ9zhdpuMgHE3abJpSraAKgCiD6i1hmO4YRftUJsByLu2FghlyI1ktd
        PDO8HSwradtzmIZhPnyBi+wuNP9Fx17GKRG39bmJvtVLjDcVT5O5LSMS9qcky8/sxrGO49Nr0eTFH
        rmlPdU1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtS-002ADE-Cm; Thu, 06 May 2021 19:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 18A29300356;
        Thu,  6 May 2021 21:42:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B1F2320B96F8B; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.786777050@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 06/13] jump_label, x86: Introduce jump_entry_size()
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows architectures to have variable sized jumps.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |    4 ++--
 arch/x86/kernel/jump_label.c      |    7 +++++++
 include/linux/jump_label.h        |    9 +++++++++
 kernel/jump_label.c               |    2 +-
 4 files changed, 19 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -4,8 +4,6 @@
 
 #define HAVE_JUMP_LABEL_BATCH
 
-#define JUMP_LABEL_NOP_SIZE 5
-
 #include <asm/asm.h>
 #include <asm/nops.h>
 
@@ -47,6 +45,8 @@ static __always_inline bool arch_static_
 	return true;
 }
 
+extern int arch_jump_entry_size(struct jump_entry *entry);
+
 #endif	/* __ASSEMBLY__ */
 
 #endif
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -16,6 +16,13 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
+#define JUMP_LABEL_NOP_SIZE	JMP32_INSN_SIZE
+
+int arch_jump_entry_size(struct jump_entry *entry)
+{
+	return JMP32_INSN_SIZE;
+}
+
 static const void *
 __jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type)
 {
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -176,6 +176,15 @@ static inline void jump_entry_set_init(s
 	entry->key |= 2;
 }
 
+static inline int jump_entry_size(struct jump_entry *entry)
+{
+#ifdef JUMP_LABEL_NOP_SIZE
+	return JUMP_LABEL_NOP_SIZE;
+#else
+	return arch_jump_entry_size(entry);
+#endif
+}
+
 #endif
 #endif
 
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -309,7 +309,7 @@ EXPORT_SYMBOL_GPL(jump_label_rate_limit)
 static int addr_conflict(struct jump_entry *entry, void *start, void *end)
 {
 	if (jump_entry_code(entry) <= (unsigned long)end &&
-	    jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE > (unsigned long)start)
+	    jump_entry_code(entry) + jump_entry_size(entry) > (unsigned long)start)
 		return 1;
 
 	return 0;


