Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F16B4457D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhKDREB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50FFC061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=niWDCOkWSkUK11Qjc32FhvLd2DC8XOP/FNVzM6530EA=; b=NWJf22h4UQt777D5234gij7RZb
        1qlHmKSvCDvV8cpP8BuPx+GsJ5K+XqHwFGT6liHhx8XocfnLwi2F+f7f6QNu+CJ6EpzAuRXaETP13
        ZcSF8E//4vcboTB4fD/2nprOVyKt4JxI8C2u835dZS8ob4KtdRBuxq2ZMid+xZIc0OguebR7l4piP
        S0qtSUcuLXGvSH0dbadTIP36GnpHCaL84EqeHKEgJ+ppytYvjazV180k7qjhfu94FWxl3mDNMG2Tm
        Fuk1xSH4TCmUezPwgplFmPK/GLt//2YPsK/6R8EqeWpEW8I4Si0T7nhEPmNj8UEwTWbm6ngKmu5Qv
        h5OuUG7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2X-0060Fr-Vh; Thu, 04 Nov 2021 16:57:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F11D301BDC;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 429262DD49FB2; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.288404702@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 13/22] x86,segment: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and use EX_TYPE_ZERO_REG to clear the register and retry the
segment load on exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    1 +
 arch/x86/include/asm/segment.h             |    9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -36,5 +36,6 @@
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(-EFAULT))
 #define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(-1))
+#define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(0))
 
 #endif
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -307,14 +307,7 @@ do {									\
 									\
 	asm volatile("						\n"	\
 		     "1:	movl %k0,%%" #seg "		\n"	\
-									\
-		     ".section .fixup,\"ax\"			\n"	\
-		     "2:	xorl %k0,%k0			\n"	\
-		     "		jmp 1b				\n"	\
-		     ".previous					\n"	\
-									\
-		     _ASM_EXTABLE(1b, 2b)				\
-									\
+		     _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k0)\
 		     : "+r" (__val) : : "memory");			\
 } while (0)
 


