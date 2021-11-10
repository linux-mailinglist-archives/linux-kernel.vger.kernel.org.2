Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6244C180
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhKJMs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:48:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B3C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ur1n8RFUDeZ5YjA4gZ7O2S+VvWVSzTiddAwPQ4GJv84=; b=cheHGaAntlvz7WyiTTOCt9O3JO
        KWby1DCKMn/0viZjEieVEkX9w/mMDtiuoVID3V9zRgsJA6mc7SXCprIfNSYEVhKxDNBbab9XRo9p6
        WUKOzXmNFgDGlXn8jSa1Awky28f6UrpqRoPLv/Y1FHsPBQwmy6uk4RvVFUtiZ+920ir3M1qxfTMd8
        0EEqL9zQgGO/s0M38nw7YcoCZXES0iUJmStjVMQxaxIr9via+THWHRyJz0/Um9upaddXArxCDCp5B
        Lt7q2eL2LJEfjW0yiWCGpSQldChzDAhoZ/Cn/IpAb+Ao6PREUvSrE3MnwD2C1QfzigLexdovKXqsJ
        ZKPcwYdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkmzE-00FH6B-8r; Wed, 10 Nov 2021 12:45:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32F813000A3;
        Wed, 10 Nov 2021 13:45:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAC43212EB3B2; Wed, 10 Nov 2021 13:45:54 +0100 (CET)
Date:   Wed, 10 Nov 2021 13:45:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2.1 11/23] x86,xen: Remove .fixup usage
Message-ID: <YYu/AteC/Wamqn46@hirez.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.545019822@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110101325.545019822@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


x86_64-allyesconfig now actually builds...

---
Subject: x86,xen: Remove .fixup usage
From: Peter Zijlstra <peterz@infradead.org>

Employ the fancy new EX_TYPE_IMM_REG to store -EFAULT in the return
register and use this to remove some Xen .fixup usage.

All callers of these functions only test for 0 return, so the actual
return value change from -1 to -EFAULT is immaterial.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/xen/page.h |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -96,11 +96,7 @@ static inline int xen_safe_write_ulong(u
 
 	asm volatile("1: mov %[val], %[ptr]\n"
 		     "2:\n"
-		     ".section .fixup, \"ax\"\n"
-		     "3: sub $1, %[ret]\n"
-		     "   jmp 2b\n"
-		     ".previous\n"
-		     _ASM_EXTABLE(1b, 3b)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %[ret])
 		     : [ret] "+r" (ret), [ptr] "=m" (*addr)
 		     : [val] "r" (val));
 
@@ -110,16 +106,12 @@ static inline int xen_safe_write_ulong(u
 static inline int xen_safe_read_ulong(const unsigned long *addr,
 				      unsigned long *val)
 {
-	int ret = 0;
 	unsigned long rval = ~0ul;
+	int ret = 0;
 
 	asm volatile("1: mov %[ptr], %[rval]\n"
 		     "2:\n"
-		     ".section .fixup, \"ax\"\n"
-		     "3: sub $1, %[ret]\n"
-		     "   jmp 2b\n"
-		     ".previous\n"
-		     _ASM_EXTABLE(1b, 3b)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG, %[ret])
 		     : [ret] "+r" (ret), [rval] "+r" (rval)
 		     : [ptr] "m" (*addr));
 	*val = rval;
