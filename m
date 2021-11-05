Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA14467AF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhKERWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhKERWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB524C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dno7ounniGoyNA4PJzOD17O9L+AKpdVlNUEQ3yWCCoQ=; b=NpWFteBi/IBWYprRIDaRsIs8Mk
        a320jwv54yYF/S7lP+rolLJmiHfLclzx/SohAN9ly7U67caLxErFX3SCn3uK/gJW8IWfA4XvrhoKG
        D9DrRRt44pZsaSyFnn08MWYhcuqOiUmeAJHWIG/ThA6aE2tzcbccJOzZyRyVjGBWn9WdW9uXO5cZE
        UmwCToz+gmcarNwH2dQjihaoyt4LsUNtCdFpOD4DKWWFHkhEE9yidHkEMTv36w9JtJ8YPIsRvPb9D
        AjlB/h2Yashe+gvjamyOA5Aeh9KCVEchP/nle2+chBxA8k8tlPfIwUkCayFMfSrpL2LD07GMz6N2j
        K4nZoXOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sa-00ENAq-42; Fri, 05 Nov 2021 17:19:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D121530220B;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 775C7201C7B5C; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.291793575@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 14/22] x86,vmx: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the vmread exceptin path, use the, thus far, unused output register
to push the @fault argument onto the stack. This, in turn, enables the
exception handler to not do pushes and only modify that register when
an exception does occur.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/extable_fixup_types.h |    1 +
 arch/x86/kvm/vmx/vmx_ops.h                 |   14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -42,5 +42,6 @@
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
 #define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_DATA_IMM(-1))
 #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(0))
+#define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_DATA_IMM(1))
 
 #endif
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -80,9 +80,11 @@ static __always_inline unsigned long __v
 		      * @field, and bounce through the trampoline to preserve
 		      * volatile registers.
 		      */
-		     "push $0\n\t"
+		     "xorl %k1, %k1\n\t"
+		     "2:\n\t"
+		     "push %1\n\t"
 		     "push %2\n\t"
-		     "2:call vmread_error_trampoline\n\t"
+		     "call vmread_error_trampoline\n\t"
 
 		     /*
 		      * Unwind the stack.  Note, the trampoline zeros out the
@@ -93,12 +95,8 @@ static __always_inline unsigned long __v
 		     "3:\n\t"
 
 		     /* VMREAD faulted.  As above, except push '1' for @fault. */
-		     ".pushsection .fixup, \"ax\"\n\t"
-		     "4: push $1\n\t"
-		     "push %2\n\t"
-		     "jmp 2b\n\t"
-		     ".popsection\n\t"
-		     _ASM_EXTABLE(1b, 4b)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %1)
+
 		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
 	return value;
 }


