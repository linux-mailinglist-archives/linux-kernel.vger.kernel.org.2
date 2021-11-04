Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA84457B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhKDQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhKDQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:59:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28865C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/n7zRU5v8kmCfSc1CSJd+SNy9tex+Ug1K2HP6Ye0Pyc=; b=C7+w1YoKVY5KXCSuSFtIqnA8cr
        6GtG29JDwqSTgckv4Gh0DEUTTaQAcsYOg2fV2TdAnjU9iRoZY9VX7+U9HZtI8Gs4mvFM/JF7IOk6D
        JxUgokBNeQUKTcGgfKoFKNA0X71OxzFH8Lna7qrZ5YpTxuWVXGtFp6RRUJD2U77JTX7Q1CgaBIcfn
        MsjfZe34ayNVhdhvKnhiEwGiBMgcofnB7rMqM5iHv2KRcXW7X8fSuUxC+KZPloLBz1ofP2cfsV526
        3iGTNxdvLTCmQ7se8A2TRh7emHtjIFAUmA1UZkDUyUtCWWGe2wJjl/LFK4iAfBMLUWAWdv1ZjJqwR
        hwTc8OSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2Y-00EC83-I8; Thu, 04 Nov 2021 16:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6A95B30281E;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 585672DD49FB8; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.588957687@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 18/22] x86,kvm: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM instruction emulation has a gnarly hack where the .fixup does a
return, luckily exceptions can easily emulate a return so create a new
extable type to fully do the FASTOP magic.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    1 +
 arch/x86/kvm/emulate.c                     |   14 +++-----------
 arch/x86/mm/extable.c                      |   11 +++++++++++
 3 files changed, 15 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -40,5 +40,6 @@
 #define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(1))
 
 #define	EX_TYPE_FAULT_SGX		18
+#define	EX_TYPE_KVM_FASTOP		19
 
 #endif
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -344,7 +344,7 @@ static int fastop(struct x86_emulate_ctx
 	__FOP_RET(#op "_" #dst)
 
 #define FOP1EEX(op,  dst) \
-	FOP1E(op, dst) _ASM_EXTABLE(10b, kvm_fastop_exception)
+	FOP1E(op, dst) _ASM_EXTABLE_TYPE(10b, 10b, EX_TYPE_KVM_FASTOP)
 
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
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -10,6 +10,7 @@
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 #include <asm/sgx.h>
+#include <asm/text-patching.h>
 
 static inline unsigned long *pt_regs_nr(struct pt_regs *regs, int nr)
 {
@@ -154,6 +155,14 @@ static bool ex_handler_sgx(const struct
 	return ex_handler_default(fixup, regs);
 }
 
+static bool ex_handler_kvm_fastop(const struct exception_table_entry *fixup,
+				  struct pt_regs *regs)
+{
+	regs->si = 0;
+	int3_emulate_ret(regs);
+	return true;
+}
+
 #define EX_TYPE_MASK	0x000000FF
 #define EX_REG_MASK	0x00000F00
 #define EX_FLAG_MASK	0x0000F000
@@ -231,6 +240,8 @@ int fixup_exception(struct pt_regs *regs
 		return ex_handler_imm_reg(e, regs, reg, imm);
 	case EX_TYPE_FAULT_SGX:
 		return ex_handler_sgx(e, regs, trapnr);
+	case EX_TYPE_KVM_FASTOP:
+		return ex_handler_kvm_fastop(e, regs);
 	}
 	BUG();
 }


