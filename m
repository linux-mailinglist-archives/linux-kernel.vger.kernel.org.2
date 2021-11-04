Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3214457D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 18:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhKDREP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhKDRDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 13:03:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D814BC061210
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wdCGYsbyem/WgX1a1Isn0JFwEGFMgSk5yqoSwmFEJgY=; b=RXZZDnCtLuRRklyrYIVRKTAJa5
        Jd18EFhOUVZbh5rkei201lBpmlJ7i/GDSPq88lvuJ6YCTRHM140f9i4rZUnqffD8sgis8K09u1lt+
        +lCWETZOV1W4qg8ZLLx2RCkVLFsRe+m1FuKWDamXMfdS+QkSuTvkf2arGQaNdbx+Jp38Q+/2J8icD
        c2RqpjJY6NsRG9dG1QLohIHxp5w2f/XmMd92RXZJfwy9+TLBleOeVO3eAa0k6VmRh5+G7/YPJ3JrN
        DYaxpp+9/UljOBpZ0LXSdLRfRIzoDpiQIlOBCMCi7oqhvJbw4bem7r5rXQbyyOMN/WQjWQ/utwFCR
        IEZXZTxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2Y-0060Ft-1A; Thu, 04 Nov 2021 16:57:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 60BDF302148;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4B3892DD49FB5; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.408049586@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 15/22] x86,vmx: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
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
---
 arch/x86/kvm/vmx/vmx_ops.h |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

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


