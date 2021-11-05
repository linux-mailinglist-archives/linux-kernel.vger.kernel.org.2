Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCDB4467C8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhKER07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhKER06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EB0C061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Q3Z85Cbzlea+LNwhOVpl8fPW0KGe9d84gZ5fRqi0Qr4=; b=jbT7GuFqz2VmUtlJkuc5r6ALfg
        Lz/elH6xE2c1Y1SWdczTQ+dQ+hsaBHA3IXihC+KGBpUTOXoww6rFnCqZOYO2ChpG4p9N3EKus4LnR
        3+JpQYcNCsfZasi3XAvPMT4fZ19boCWoHIflkFFS+73I6Wq7p0UD/A2qXfAXl9nneS/ke66Y8QeBg
        X0s1vc8h+M0SyXy6LoZByY76BuYstgIHJENcYCkqyfZyUekFVDBYC91iFNwU2B1IyK3CBRD4nSDyQ
        qt3nRT4+zEWwXTgaHYDRtdHZY9mPJgorUgTCv2+4hoTiR0ZPKnYas3Hb3I5EYXgWXJiDj+7FT+W9o
        rirM/iiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sZ-006hZw-9l; Fri, 05 Nov 2021 17:20:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1065302148;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 84CF6201C7B5F; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.470393311@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 17/22] x86,kvm: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
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
 arch/x86/kvm/emulate.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

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


