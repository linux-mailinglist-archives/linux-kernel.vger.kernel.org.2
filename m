Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24974467B8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhKERXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhKERWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00EAC061210
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GP01YFM16qeWeivEJh41tvuNdAjyBsO9/aV4rwEvVJo=; b=BEZCmJad5GpA4SOkF+UPNfUSBb
        +VGJuI4K6r9oPWTFRWUXrOQAUVh3L9SFHDyjIAOR/2/XuUV4zqlJThkPGjfWBg1vOBIGppIV780Gh
        v7yMC7URtFfJaoI/Qwe3ORRm30tmPGhPW6JIXO5bHj3LOojqdy4Ea6JpziWOrR0W4Hic0SZbsYLdC
        DMRES4Jz07HH+gGIcJMo2PvVfAwBkwrkx3CJwKVnY9QohAz5kFr4+BhzDD7Mxm2pLEwVb2QqMrU9B
        1/N1HRTK7yQ13bXlGj9qbcOO4x6HoCTtguXJXFGyaDpFSHzDfIRiylD0ToNlvTMfZovOewzJoYFkr
        JaZx2SgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sZ-00ENAZ-8e; Fri, 05 Nov 2021 17:19:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CAC6C301BCC;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E898201C7B5A; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.173483150@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 12/22] x86,fpu: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Employ EX_TYPE_NEG_REG to store '-1' into the %[err] register on
exception.

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
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_NEG_REG, %[err]) \
 		     : [err] "=r" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -107,11 +107,7 @@ static inline u64 xfeatures_mask_indepen
 		     "\n"						\
 		     "xor %[err], %[err]\n"				\
 		     "3:\n"						\
-		     ".pushsection .fixup,\"ax\"\n"			\
-		     "4: movl $-2, %[err]\n"				\
-		     "jmp 3b\n"						\
-		     ".popsection\n"					\
-		     _ASM_EXTABLE(661b, 4b)				\
+		     _ASM_EXTABLE_TYPE_REG(661b, 3b, EX_TYPE_NEG_REG, %[err]) \
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")


