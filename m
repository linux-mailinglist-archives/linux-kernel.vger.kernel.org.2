Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237734457D6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhKDREM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04AEC06120F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jl7nFaC0/37KaZuML0m3DPWRy0uNV3GGQpcPIywC454=; b=hH2G+036nxP732yIxe8FLseHuE
        5s5kIOSiWIXr+jz7dJlWr/rZcxzHsSno3v2WTNrbBKP9q2xbknbIt9FJUhDJfkZMUhnZOgraX9O0C
        SeLChKPiVJHAjnssLmGW20RhhnkFmv6ki7y4DlthrNIOatEUa/7xUa6RSuj5CLiq4N7poiETe/Uxn
        3XWD0W8CTNeHs0fpbIBNXHC9u/AtxyzvDd5sSDCtBFbeDTCooE4L8Aks5S48DXaRDQFH8aN3ngQhA
        F2NSn1d39lhEk89zl820JylCURd6YuUL+Pto49zlUi+h7edAhOOWjGaexWwY3BfhRH42AKSUY/2jf
        R8IEAqBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2X-0060Fs-WF; Thu, 04 Nov 2021 16:57:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60B28301BDE;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4D8EE2DD49FB3; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.467849195@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 16/22] x86,checksum_32: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply add EX_FLAG_CLR_AX to do as the .fixup used to do.

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
+	_ASM_EXTABLE_TYPE(9999b, 7f, EX_TYPE_UACCESS | EX_FLAG_CLR_AX)
 
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


