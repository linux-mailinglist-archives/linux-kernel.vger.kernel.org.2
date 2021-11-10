Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B803944BE63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhKJKTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKJKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4FC06120B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QICR41qgd3LTqynAKrBRWAgiDFD2C+BWkz+lGqKEbDE=; b=EiA90x6/j4w6dnglVG2S3Xo0oE
        VkaK8PweOllcOAbprr1l2VpBMl/+I/asqItfuGbuRmZx59XAIjPXZytpHFRwm91+yl/afe4Jbf/Lb
        RI1ZC62erXhPf8QNWmrMI8nCcoN4MGm+TQ6j/+wEU5vToAtyjkTwTh5P7b6laEwTCA7r9cX/r1N5G
        1XtE7f9UOKm95YVK+hk3FAXAkL8qHBHXFjX+vO9pJapnqsMtxpohDdgK+YYXl7EFX+Fcc1HEBj/aZ
        EYGLwMriG9ytrMmSe4TMMtFaydnG9UP97/Ck9XNwXV9xmYGTViKSJD5VeIWw00vQj68azouW8wk5j
        +QdAbKTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeH-00FFpr-BG; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B1B90301A54;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 86846203ED503; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.545019822@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 11/23] x86,xen: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAUL_REG, %[ret])
 		     : [ret] "+r" (ret), [rval] "+r" (rval)
 		     : [ptr] "m" (*addr));
 	*val = rval;


