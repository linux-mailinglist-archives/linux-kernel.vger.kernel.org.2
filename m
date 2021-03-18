Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9F7340BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbhCRRYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCRRYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:24:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B20C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=SlK5QKkRgCR8VsAPifj04b/JpEJ24BwnofM4yK4Zndk=; b=hWOoCzqxtzPjYX4z3kA7YJBbyR
        TBpcFqg3HNC9EZJVf0YqlkNS06IhvgrqCkxdIeZJ1oSACG2YTLhKUJSbMS1Ocf5NURBW2wqZM1cj4
        rseETqaWyE5gwKfLoV3Q2EZ8aXk7wf0V1fqDSYD6T52KJc4MP4QNmgoQmS2p80rtYu0UacK2kXL7B
        a0Nnp9YH9tUmpZotsW5wIS/jaLvCG9LZoeiQS3YvXfynW/fei1VFwcru9wPRxnpXW+cuAQjkx+aYK
        yy3tzcY9+XAqnn5QO0dx6wf3AAwR3w6Rzcz5gtqKkLfv9MNs4QAIh1ABZYvcsIBxyG+V3Gs1fWI5e
        Z8CAei1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMwMq-003HIU-Fi; Thu, 18 Mar 2021 17:23:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3913C3070F9;
        Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 236CD238A4648; Thu, 18 Mar 2021 18:23:27 +0100 (CET)
Message-ID: <20210318171919.703716384@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Mar 2021 18:11:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH v2 05/14] objtool: Per arch retpoline naming
References: <20210318171103.577093939@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __x86_indirect_ naming is obviously not generic. Shorten to allow
matching some additional magic names later.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/arch/x86/decode.c      |    5 +++++
 tools/objtool/check.c                |    7 ++++++-
 tools/objtool/include/objtool/arch.h |    2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -692,3 +692,8 @@ int arch_decode_hint_reg(struct instruct
 
 	return 0;
 }
+
+bool arch_is_retpoline(struct symbol *sym)
+{
+	return !strncmp(sym->name, "__x86_indirect_", 15);
+}
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -850,6 +850,11 @@ static int add_ignore_alternatives(struc
 	return 0;
 }
 
+__weak bool arch_is_retpoline(struct symbol *sym)
+{
+	return false;
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -872,7 +877,7 @@ static int add_jump_destinations(struct
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -85,4 +85,6 @@ const char *arch_nop_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 
+bool arch_is_retpoline(struct symbol *sym);
+
 #endif /* _ARCH_H */


