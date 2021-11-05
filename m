Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB70E4467CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhKER1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbhKER06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEEC06120A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ntkLV0JwnaiZKgK80tLD5qiEZSWsA+sw7wi17Zbzp+U=; b=gApBdgLdwp6HrbATBEDYdDVP9V
        x/XCjS0d9mHr5+hOprfOAGCwExrXKQs50qLXwsPwHYx65D9JUIy5jbL0UnIziqZdYVwXLPfV7qBRu
        DzC3cpxCMR0kGdqziEbFcJksuRMoFvpWSsw92HBCrLVXX9MHyWHxw24fgxtMIlrW6Ap1nJ6dYKrY3
        Up6uOAHUlGsuS0/E2lEXYl90ZaXBPz6O98MXRXkTLKU34Z/iG34x945FfAehuspLgkoZ2rq3YKgui
        1zNE0ZV2akOmGOiobNr1jCjxb9zhtHwk9ad8iLim85xtvF7e8CHCcizJv+5KIb3I71388ibdcpNND
        GHLQOXTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sa-006hZy-3u; Fri, 05 Nov 2021 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1035301BDE;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7A9B7201C7B5D; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.351049849@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 15/22] x86,checksum_32: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply add EX_FLAG_CLEAR_AX to do as the .fixup used to do.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/lib/checksum_32.S |   19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -260,9 +260,9 @@ unsigned int csum_partial_copy_generic (
  * Copy from ds while checksumming, otherwise like csum_partial
  */
 
-#define EXC(y...)			\
-	9999: y;			\
-	_ASM_EXTABLE_UA(9999b, 6001f)
+#define EXC(y...)						\
+	9999: y;						\
+	_ASM_EXTABLE_TYPE(9999b, 7f, EX_TYPE_UACCESS | EX_FLAG_CLEAR_AX)
 
 #ifndef CONFIG_X86_USE_PPRO_CHECKSUM
 
@@ -358,15 +358,6 @@ EXC(	movb %cl, (%edi)	)
 	adcl $0, %eax
 7:
 
-# Exception handler:
-.section .fixup, "ax"							
-
-6001:
-	xorl %eax, %eax
-	jmp 7b
-
-.previous
-
 	popl %ebx
 	popl %esi
 	popl %edi
@@ -439,10 +430,6 @@ EXC(	movb %dl, (%edi)         )
 6:	addl %edx, %eax
 	adcl $0, %eax
 7:
-.section .fixup, "ax"
-6001:	xorl %eax, %eax
-	jmp  7b			
-.previous				
 
 	popl %esi
 	popl %edi


