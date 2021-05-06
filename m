Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D10375BE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 21:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhEFToz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbhEFTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 15:44:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BE4C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=14ae5ButIL56sXgU5cp10qJMzTtbzliJ9DS4yK56dlY=; b=dwcjY8MlI0jOUWIqnlbw8je8BD
        MlHs7LDLLAGzNg2rfQSD0OqZFN2zcTeptnjKYIHFlCK9k8JzKpWGtQyKsEsyyqsoUE68VY/8V9gnb
        wVzOoGLQE1kksg68aX6UodT3CGKKwqSbq7ioCicvDsx6ZUfcl7KdHQGBjctTMh6JIaZI/TdSWxT39
        6AQ9q2l6oYLL/RiiTKoqhAbvtHqKjLySBBj+va7NpKHuy6VglbCzlxrajbk/VHHvNS3Y/Y3revsD8
        Of0yAsAsimiKtm2+3smOVQX8H74FaSKyYH7md2T0VtaS8fHEkBHdgGqCyiXPdIz0ySQvqTOjj8eHQ
        sNQkD1Tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lejtQ-002ADB-C8; Thu, 06 May 2021 19:42:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFE95300351;
        Thu,  6 May 2021 21:42:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A9D6F20B96F88; Thu,  6 May 2021 21:42:38 +0200 (CEST)
Message-ID: <20210506194157.663132781@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 06 May 2021 21:33:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 04/13] jump_label, x86: Factor out the __jump_table generation
References: <20210506193352.719596001@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both arch_static_branch() and arch_static_branch_jump() have the same
blurb to generate the __jump_table entry, share it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/jump_label.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -14,15 +14,19 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 
+#define JUMP_TABLE_ENTRY				\
+	".pushsection __jump_table,  \"aw\" \n\t"	\
+	_ASM_ALIGN "\n\t"				\
+	".long 1b - . \n\t"				\
+	".long %l[l_yes] - . \n\t"			\
+	_ASM_PTR "%c0 + %c1 - .\n\t"			\
+	".popsection \n\t"
+
 static __always_inline bool arch_static_branch(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(BYTES_NOP5) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
@@ -33,13 +37,9 @@ static __always_inline bool arch_static_
 static __always_inline bool arch_static_branch_jump(struct static_key * const key, const bool branch)
 {
 	asm_volatile_goto("1:"
-		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
-		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
-		_ASM_ALIGN "\n\t"
-		".long 1b - ., %l[l_yes] - . \n\t"
-		_ASM_PTR "%c0 + %c1 - .\n\t"
-		".popsection \n\t"
+		".byte 0xe9 \n\t"
+		".long %l[l_yes] - (. + 4) \n\t"
+		JUMP_TABLE_ENTRY
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;


