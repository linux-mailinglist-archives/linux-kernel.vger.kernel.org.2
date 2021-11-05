Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F344467B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhKERXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhKERWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFDC061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TNa9ojDNmb0RcBqwAeeRYHbWotLxPnVy8jg7pRy+KJY=; b=gN3wSLXLImpwysnV0wMUHmcHT5
        jHmxDGwl2mqjKBUNVxLF/HfmzmN7TIU+8Ng2+vfNXEwnhYLSl0hhTRh4UVdV61MjIWQ7mZ4lI94ye
        qEsfVMPKXHUjF/yI97sIPJ5WMUOGfkHb7WIBRIQSBRmCoSrgdFuyLFEA23vSfiDtQFX8QMFqY4i7G
        jrjUG7X2t074cqcnCDzjNqRHqG6FsXThVq1MNRXxeHg0+QCphWkOdgwDX+9wmeJ9mF/aOCiDgS5su
        G0f4o8FeYetjEP1m27yglhFWoWTCYSwUTYMzeBqJrvLP9jnV+rsdLAUI5hVV2dYZzIMbKgsKd8wY0
        svlM8Ukw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sa-00ENBE-Uq; Fri, 05 Nov 2021 17:19:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6EC2302A0E;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9212D203C007D; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.654356149@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite load_unaligned_zeropad() to not require .fixup text.

This is easiest done using asm_goto_output, where we can stick a C
label in the exception table entry. The fallback version isn't nearly
so nice but should work.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/word-at-a-time.h |   67 ++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 19 deletions(-)

--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -77,30 +77,59 @@ static inline unsigned long find_zero(un
  * and the next page not being mapped, take the exception and
  * return zeroes in the non-existing part.
  */
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+
+static inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	unsigned long offset, data;
+	unsigned long ret;
+
+	asm_volatile_goto(
+		"1:	mov %[mem], %[ret]\n"
+
+		_ASM_EXTABLE(1b, %l[do_exception])
+
+		: [ret] "=&r" (ret)
+		: [mem] "m" (*(unsigned long *)addr)
+		: : do_exception);
+
+out:
+	return ret;
+
+do_exception: __cold;
+
+	offset = (unsigned long)addr & (sizeof(long) - 1);
+	addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
+	data = *(unsigned long *)addr;
+	ret = data >> offset * 8;
+	goto out;
+}
+
+#else /* !CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 static inline unsigned long load_unaligned_zeropad(const void *addr)
 {
-	unsigned long ret, dummy;
+	unsigned long offset, data;
+	unsigned long ret, err = 0;
 
-	asm(
-		"1:\tmov %2,%0\n"
+	asm(	"1:	mov %[mem], %[ret]\n"
 		"2:\n"
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
+
+		_ASM_EXTABLE_FAULT(1b, 2b)
+
+		: [ret] "=&r" (ret), "+a" (err)
+		: [mem] "m" (*(unsigned long *)addr));
+
+	if (unlikely(err)) {
+		offset = (unsigned long)addr & (sizeof(long) - 1);
+		addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
+		data = *(unsigned long *)addr;
+		ret = data >> offset * 8;
+	}
+
 	return ret;
 }
 
+#endif /* CONFIG_CC_HAS_ASM_GOTO_OUTPUT */
+
 #endif /* _ASM_WORD_AT_A_TIME_H */


