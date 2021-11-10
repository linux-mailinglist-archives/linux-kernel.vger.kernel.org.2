Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8286644BE65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhKJKTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhKJKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0A0C06120D
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3kPWa4c/543EE3aiJWoHcEI2aWPVn1ShTnEUzj80FBM=; b=KucgomIR26z1HoRd+dv79ZN6ka
        LfMgO1JJm3b79vOVqYIzZdnXNmTg4mGWb2btdDdGLLYdH4SDTWyOIJ9IuyWuYl6i+b+EkdtzUYCL8
        FxVA8iAQFIN0Y6UWyWp7voIuC4L93tL5uvq06xEjttaj+rE7k/bQvKwvUqVLL9Cn65BMWRKka8BIy
        oaF2rP1P3dqfZJ/xSwRSqjORTH39AqXyUG53fe+5HMikbnMPNRxPBmQooqxw6uG5G3v5EmKArH0NE
        g3yCi4pTlFxmo1Bom52d14BG6HemMUy3V9n8mNNGU03/GNbhTjzlpNjwtvJ9XTsC1O8rWhz0Jzdz9
        4Kx5yPxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-00FFps-Bn; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5226301BCC;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8BCBA203ED504; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.604494664@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 12/23] x86,fpu: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Employ EX_TYPE_EFAULT_REG to store '-EFAULT' into the %[err] register
on exception. All the callers only ever test for 0, so the change
from -1 to -EFAULT is immaterial.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/fpu/legacy.h |    6 +-----
 arch/x86/kernel/fpu/xstate.h |    6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/fpu/legacy.h
+++ b/arch/x86/kernel/fpu/legacy.h
@@ -35,11 +35,7 @@ static inline void ldmxcsr(u32 mxcsr)
 	int err;							\
 	asm volatile("1:" #insn "\n\t"					\
 		     "2:\n"						\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:  movl $-1,%[err]\n"				\
-		     "    jmp  2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -108,11 +108,7 @@ static inline u64 xfeatures_mask_indepen
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     ".pushsection .fixup,\"ax\"\n"			\
-		     "4: movl $-2, %[err]\n"				\
-		     "jmp 3b\n"						\
-		     ".popsection\n"					\
-		     _ASM_EXTABLE(661b, 4b)				\
+		     _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_EFAULT_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")


