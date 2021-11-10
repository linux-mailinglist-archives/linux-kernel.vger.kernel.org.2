Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C5244BE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhKJKUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhKJKTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77916C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/P70rEaXTduluwO79BbjwtHEscsRktgYJTxd5JGSd50=; b=TTU7rEX4636mUlw8WKLuKKRsTN
        EnP5ZPv2oXRsevWZEPEoRQs9g4EYmGjF/CxcROynw21ooB0webbw6rJRBYgwrSMTPBmcrVTpNzzlZ
        MBxe9aJA5mE4mOKLmP9JpXgqSU4nyNCKs0/wR73Ojsu6aPaoK/hZFr1f8erXSno+pU/f5bxbVYWpm
        6bYez05DbwoaMDyiB5EHCfNjdHGkObj0BQsyG1xkgGXL3CY59W6I1ztzWwE/KLexiWTjr3bohVQVR
        z7stTkARyDJ/SpWfmUkPTSXF1oFEgHg5w3ssV+nz+sIj0rJ/WOl6yIQzTzEOAtBcO7tX0HpINZVrM
        MKO1O+nQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-00FFpt-Cg; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDFC030221D;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9E3C020189CA9; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.840433319@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 16/23] x86,vmx: Provide asm-goto-output vmread
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use asm-goto-output for smaller fast path code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kvm/vmx/vmx_ops.h |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -71,6 +71,31 @@ static __always_inline unsigned long __v
 {
 	unsigned long value;
 
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+
+	asm_volatile_goto("1: vmread %[field], %[output]\n\t"
+			  "jna %l[do_fail]\n\t"
+
+			  _ASM_EXTABLE(1b, %l[do_exception])
+
+			  : ASM_CALL_CONSTRAINT, [output] "=r" (value)
+			  : [field] "r" (field)
+			  : "cc"
+			  : do_fail, do_exception);
+
+	return value;
+
+do_fail:
+	WARN_ONCE(1, "kvm: vmread failed: field=%lx\n", field);
+	pr_warn_ratelimited("kvm: vmread failed: field=%lx\n", field);
+	return 0;
+
+do_exception:
+	kvm_spurious_fault();
+	return 0;
+
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 	asm volatile("1: vmread %2, %1\n\t"
 		     ".byte 0x3e\n\t" /* branch taken hint */
 		     "ja 3f\n\t"
@@ -99,6 +124,8 @@ static __always_inline unsigned long __v
 
 		     : ASM_CALL_CONSTRAINT, "=&r"(value) : "r"(field) : "cc");
 	return value;
+
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
 }
 
 static __always_inline u16 vmcs_read16(unsigned long field)


