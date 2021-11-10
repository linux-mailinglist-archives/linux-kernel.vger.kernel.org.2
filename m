Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1244BE59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhKJKTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhKJKTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD664C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TUQMMKOEXzAHngwEsJY5M5IhipZssw+igpGwu/8LZC8=; b=VLkTX45eUncF8bRgqsAQOa6twZ
        6D7X5j86N5Z87RLob9aYui/vUIvowuniIm51w4DJgwGDZu1xn84wgyFlfJplbTI1m7XCOPpivEjtm
        eOoQCfz1T4lmRHP0nN521zH1/YHobEYGgyGH9RD5mLICONSmLBN1/PVX5yi1uGYLGwEbXj3rrxEEO
        Ni5zg++6ZQoSXMElppvjlxbAbzDfEnMmFdc546b3W7CxIQ/C9jXwxTGGk05wf5KM5Ai8GgnQ7MoNY
        KUX27FQpKjNmYrxsNNHa5WwrbFgyR5CcJsl1kGFB3YvtAb3euZ3lTMN/0se0ELDnzdmC8JvAu7Geq
        JmbDGMVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-001lka-0w; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD46F301D5C;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A615203ED506; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.781308550@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 15/23] x86,vmx: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the vmread exceptin path, use the, thus far, unused output register
to push the @fault argument onto the stack. This, in turn, enables the
exception handler to not do pushes and only modify that register when
an exception does occur.

As noted by Sean the input constraint needs to be changed to "=&r" to
avoid the value and field occupying the same register.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx_ops.h |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

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
@@ -93,13 +95,9 @@ static __always_inline unsigned long __v
 		     "3:\n\t"
 
 		     /* VMREAD faulted.  As above, except push '1' for @fault. */
-		     ".pushsection .fixup, \"ax\"\n\t"
-		     "4: push $1\n\t"
-		     "push %2\n\t"
-		     "jmp 2b\n\t"
-		     ".popsection\n\t"
-		     _ASM_EXTABLE(1b, 4b)
-		     : ASM_CALL_CONSTRAINT, "=r"(value) : "r"(field) : "cc");
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %1)
+
+		     : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
 	return value;
 }
 


