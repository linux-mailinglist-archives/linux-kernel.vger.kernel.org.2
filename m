Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC99F33948A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhCLRSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhCLRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:18:00 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A7AC061762
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=09yN6bostEIHrNjzFuxK/7wiG96S+1A3Tjp3k+B4zpU=; b=JlqmFLjYl8eTEgd22WIZqrhKNu
        uNrbeVefCTw/HZDr91SDZ3oY4r/WrEsYszdVZyfqURGnfHDuGmf8XZr3CFIScBCBJ7j8VV9Ts8gLN
        3+SduPOmWDRnifTOfkUkJnOA7nnUAUdMsvONh6z22YD+WLLNQyfqIKI5qoYNTNOqN0Kez2K0dKCFR
        KmFtB8ST+3lACAjFC2xjFPCIFVGtlRoQ8Pfe2nNSugHT8DdX+7YWWobQJ5AhvpLYJr5HGjRvzQBld
        JbGckbo2a9Dhs7JvSAdJlRfE5xNo0Kh+o7baVYtU43oSLjgOOQd0aBwpBICTbuUfDX5k5RRcj6hvK
        pPuZmEWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKlQ9-00C534-VN; Fri, 12 Mar 2021 17:17:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19AEE3059C0;
        Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0881123CC2293; Fri, 12 Mar 2021 18:17:53 +0100 (CET)
Message-ID: <20210312171653.527760836@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Mar 2021 18:16:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suze.cz
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [PATCH 3/9] objtool: Per arch retpoline naming
References: <20210312171613.533405394@infradead.org>
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
 tools/objtool/check.c                |    9 +++++++--
 tools/objtool/include/objtool/arch.h |    2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -690,3 +690,8 @@ int arch_decode_hint_reg(struct instruct
 
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
@@ -1026,7 +1031,7 @@ static int add_call_destinations(struct
 				return -1;
 			}
 
-		} else if (!strncmp(reloc->sym->name, "__x86_indirect_thunk_", 21)) {
+		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accodingly.
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -85,4 +85,6 @@ const char *arch_nop_insn(int len);
 
 int arch_decode_hint_reg(struct instruction *insn, u8 sp_reg);
 
+bool arch_is_retpoline(struct symbol *sym);
+
 #endif /* _ARCH_H */


