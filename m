Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3004344BE64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhKJKTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhKJKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A02FC06120C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=aom7kC5mk4zDSEkoZCD37KPCKdonpjmoI2wHmTSZP5k=; b=VG9vhYle9kr+PfttKw325/k1Fe
        bz8c9fViKWi+B6yLRMrqCQrUbW+qnZovWZ3ldMhTmhhysqPI7y/M89e7gzl+BIvGGohP9bT7jWHyw
        daRdob8amHrDI0/BRGL56zWhtu0mIUjFsmlWwIAUvG6PZEMABylxteXIjy0fu30oKTvPL2HlSwSYM
        m4Q8F3qWKoCd8Ezc70DUqQvZlStCaF2BxW/j48BhqrTlBu3LAxzvA8F2+jBH2tElYxL8blqoVPv2w
        kVE4LhWQSPZ1VKlcqhpwtUdNu+WXjRSQGUQ+xHA24cc6TWaYp27MmzHvTcIAKQdd8IiUCBzJiRE+b
        xNsDIFWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeG-00FFpZ-8i; Wed, 10 Nov 2021 10:16:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82210300688;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 69B0C203C8AA9; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.127055887@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 04/23] x86,copy_mc_64: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
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


