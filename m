Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9A44457CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhKDRD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FF0C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gcJhx4ceBQs4Ni5nlcHSvRBpkMpCkYcNxBB2bBdgyDs=; b=BOSNmsOS/zu16g+mx8nYkKtlpc
        /tIm0GGkJ7adICzeoJ0Hh+5L9loCHoaYGJYnU07SuXR00iVf3fWj6mP4unbJ69no2LIswpiGVYxRG
        +SlsL+pwdLBCt67aB8S27HDGderNqckHcrprMuTe1NUozJ5jwLKQj2NrUO0Rl8opDPh29UUOI+p/+
        p2ON4lvxIptKcrk7hq9xOxyWLzs1OokWzMwbCOp77cl1+wOfxXwszxYSmmBXyL7jVOeH1tKIncYhw
        06ohjlKQOKKartCnorey4PjnibAdyUB6xwEU0+TGucgiuzKhM5LdDNP/Fdr5IReZ+b6tC/IhfVNhu
        /XCbhjrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2Z-0060Fv-Pl; Thu, 04 Nov 2021 16:57:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 775E6302A1A;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 656B52DD49FB4; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.767986267@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 21/22] x86,word-at-a-time: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Push the load_unaligned_zeropad() exception into exception context by
adding a new extable type. This however requires we have both the
address and the output register. Since we can only have a single
register argument, use the same for both.

This also means the source can no longer use "m" constraint.

XXX: I'm not really happy with this patch

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    2 ++
 arch/x86/include/asm/word-at-a-time.h      |   27 +++++++--------------------
 arch/x86/mm/extable.c                      |   17 +++++++++++++++++
 3 files changed, 26 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -47,4 +47,6 @@
 #define	EX_TYPE_UACCESS_LEN4		(EX_TYPE_UACCESS_LEN | EX_TYPE_IMM(4))
 #define	EX_TYPE_UACCESS_LEN8		(EX_TYPE_UACCESS_LEN | EX_TYPE_IMM(8))
 
+#define	EX_TYPE_LOAD_UNALIGNED		21 /* reg := (reg) */
+
 #endif
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -79,27 +79,14 @@ static inline unsigned long find_zero(un
  */
 static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
-	unsigned long ret, dummy;
+	unsigned long ret;
+
+	asm("1:\tmov (%0),%0\n"
+	    "2:\n"
+	    _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_LOAD_UNALIGNED, %0)
+	    : "=&r" (ret)
+	    : "0" ((unsigned long)addr));
 
-	asm(
-		"1:\tmov %2,%0\n"
-		"2:\n"
-		".section .fixup,\"ax\"\n"
-		"3:\t"
-		"lea %2,%1\n\t"
-		"and %3,%1\n\t"
-		"mov (%1),%0\n\t"
-		"leal %2,%%ecx\n\t"
-		"andl %4,%%ecx\n\t"
-		"shll $3,%%ecx\n\t"
-		"shr %%cl,%0\n\t"
-		"jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE(1b, 3b)
-		:"=&r" (ret),"=&c" (dummy)
-		:"m" (*(unsigned long *)addr),
-		 "i" (-sizeof(unsigned long)),
-		 "i" (sizeof(unsigned long)-1));
 	return ret;
 }
 
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -170,6 +170,21 @@ static bool ex_handler_uaccess_len(const
 	return ex_handler_uaccess(fixup, regs, trapnr);
 }
 
+static bool ex_handler_load_unaligned_zeropad(const struct exception_table_entry *fixup,
+					      struct pt_regs *regs, int reg)
+{
+	unsigned long addr, offset, data;
+
+	addr = *pt_regs_nr(regs, reg);
+	offset = addr & (sizeof(unsigned long) - 1);
+	addr &= ~(sizeof(unsigned long) - 1);
+	data = *(unsigned long *)addr;
+	data >>= offset*8;
+	*pt_regs_nr(regs, reg) = data;
+
+	return ex_handler_default(fixup, regs);
+}
+
 #define EX_TYPE_MASK	0x000000FF
 #define EX_REG_MASK	0x00000F00
 #define EX_FLAG_MASK	0x0000F000
@@ -251,6 +266,8 @@ int fixup_exception(struct pt_regs *regs
 		return ex_handler_kvm_fastop(e, regs);
 	case EX_TYPE_UACCESS_LEN:
 		return ex_handler_uaccess_len(e, regs, trapnr, reg, imm);
+	case EX_TYPE_LOAD_UNALIGNED:
+		return ex_handler_load_unaligned_zeropad(e, regs, reg);
 	}
 	BUG();
 }


