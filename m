Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E5644BE62
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhKJKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhKJKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08709C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=7EdtArm/rTKJoZlT0o6kCiJxc6A7WaOmxidCofTePr0=; b=Z0neqn2VoHbQwuOMIcmqyvRC8D
        2h5mxU/jQEScnJ0ItIYBJTMT6eqZD4cVBMGfd6N6VqKkt399Z2hhqJVmnNMcrccjvuB6fyf7EDVWT
        87kMsZjBM+MqJW5kqJWQPNrJiIg7KX3K8u405SduO/77UfprteT39g5/OlLG6vVLP5cNb2y/X30bW
        +CSCf5I6KzryBhPc2FlTjmY12JCGq6Qzz8L+iTd1RI+Th0D6Her5oGs4zWr3XUFiMLja9Ap2P+fHW
        QKlKSTXDhq5PtBU8FDWN1Si4AGAq+sbwtZrPBF//4s5Va5l+61+co/OXYEuWbyi31YoPOq+v9YYYE
        4ZiA5NKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-00FFpv-NQ; Wed, 10 Nov 2021 10:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC9A6301BDC;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 97A47203ED507; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.722157053@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 14/23] x86,kvm: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM instruction emulation has a gnarly hack where the .fixup does a
return, however there's already a ret right after the 10b label, so
mark that as 11 and have the exception clear %esi to remove the
.fixup.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    1 +
 arch/x86/kvm/emulate.c                     |   16 ++++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -46,5 +46,6 @@
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
 #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(0))
+#define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_DATA_IMM(1))
 
 #endif
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -315,7 +315,7 @@ static int fastop(struct x86_emulate_ctx
 	__FOP_FUNC(#name)
 
 #define __FOP_RET(name) \
-	"ret \n\t" \
+	"11: ret \n\t" \
 	".size " name ", .-" name "\n\t"
 
 #define FOP_RET(name) \
@@ -344,7 +344,7 @@ static int fastop(struct x86_emulate_ctx
 	__FOP_RET(#op "_" #dst)
 
 #define FOP1EEX(op,  dst) \
-	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
+	FOP1E(op, dst) _ASM_EXTABLE_TYPE_REG(10b, 11b, EX_TYPE_ZERO_REG, %esi)
 
 #define FASTOP1(op) \
 	FOP_START(op) \
@@ -434,10 +434,6 @@ static int fastop(struct x86_emulate_ctx
 	#op " %al \n\t" \
 	__FOP_RET(#op)
 
-asm(".pushsection .fixup, \"ax\"\n"
-    "kvm_fastop_exception: xor %esi, %esi; ret\n"
-    ".popsection");
-
 FOP_START(setcc)
 FOP_SETCC(seto)
 FOP_SETCC(setno)
@@ -473,12 +469,8 @@ FOP_END;
  \
 	asm volatile("1:" insn "\n" \
 	             "2:\n" \
-	             ".pushsection .fixup, \"ax\"\n" \
-	             "3: movl $1, %[_fault]\n" \
-	             "   jmp  2b\n" \
-	             ".popsection\n" \
-	             _ASM_EXTABLE(1b, 3b) \
-	             : [_fault] "+qm"(_fault) inoutclob ); \
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %[_fault]) \
+	             : [_fault] "+r"(_fault) inoutclob ); \
  \
 	_fault ? X86EMUL_UNHANDLEABLE : X86EMUL_CONTINUE; \
 })


