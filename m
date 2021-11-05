Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799A54467B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhKERW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhKERWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AEC06120B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=aom7kC5mk4zDSEkoZCD37KPCKdonpjmoI2wHmTSZP5k=; b=WbTD5vPJ52vlDgzCV7OHOfyetw
        L5HrYaeSj3j3VORe1sYHa0caTt6Vjt3HT/tZBH89OHPBKhm6tsrTkE9q1kf+PGoiOchEHrKTrT64z
        kEnj7/qnDfZFrFHuVLwoXA6dzxQx7kAQ+0gLmF3/M4BZkFU077gKfVvzv8f55CDDdYbEZ4iAihxT8
        dgjLX71fLwDqWEunTPzNbpxcmBxtWfLap0+R2kssd4AuGhM46x5nfkLerEoAKww8oMsate0qqbI+V
        gCzFsHSEOpG5C1KLkvUgPXOT4ov36qjQy5FKoJsBWIhzGs43+ewi+JOSjIjXITfFS2V+X89z2B2cX
        lLg8XMmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sX-00ENAO-PL; Fri, 05 Nov 2021 17:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D10C30072B;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 46C55201C7B53; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171820.688114170@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 04/22] x86,copy_mc_64: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place the anonymous .fixup code at the tail of the regular functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/copy_mc_64.S |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -78,9 +78,7 @@ SYM_FUNC_START(copy_mc_fragile)
 	xorl %eax, %eax
 .L_done:
 	ret
-SYM_FUNC_END(copy_mc_fragile)
 
-	.section .fixup, "ax"
 	/*
 	 * Return number of bytes not copied for any failure. Note that
 	 * there is no "tail" handling since the source buffer is 8-byte
@@ -105,14 +103,14 @@ SYM_FUNC_END(copy_mc_fragile)
 	movl	%ecx, %edx
 	jmp copy_mc_fragile_handle_tail
 
-	.previous
-
 	_ASM_EXTABLE_TYPE(.L_read_leading_bytes, .E_leading_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE_TYPE(.L_read_words, .E_read_words, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE_TYPE(.L_read_trailing_bytes, .E_trailing_bytes, EX_TYPE_DEFAULT_MCE_SAFE)
 	_ASM_EXTABLE(.L_write_leading_bytes, .E_leading_bytes)
 	_ASM_EXTABLE(.L_write_words, .E_write_words)
 	_ASM_EXTABLE(.L_write_trailing_bytes, .E_trailing_bytes)
+
+SYM_FUNC_END(copy_mc_fragile)
 #endif /* CONFIG_X86_MCE */
 
 /*
@@ -133,9 +131,7 @@ SYM_FUNC_START(copy_mc_enhanced_fast_str
 	/* Copy successful. Return zero */
 	xorl %eax, %eax
 	ret
-SYM_FUNC_END(copy_mc_enhanced_fast_string)
 
-	.section .fixup, "ax"
 .E_copy:
 	/*
 	 * On fault %rcx is updated such that the copy instruction could
@@ -147,7 +143,7 @@ SYM_FUNC_END(copy_mc_enhanced_fast_strin
 	movq %rcx, %rax
 	ret
 
-	.previous
-
 	_ASM_EXTABLE_TYPE(.L_copy, .E_copy, EX_TYPE_DEFAULT_MCE_SAFE)
+
+SYM_FUNC_END(copy_mc_enhanced_fast_string)
 #endif /* !CONFIG_UML */


