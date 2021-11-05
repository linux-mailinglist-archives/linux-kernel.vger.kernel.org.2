Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845FF4467B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 18:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhKERWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhKERWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 13:22:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C28C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=wb1nu+ZOC3u3i9GW/68HwJWCJe1QrJmnRgB4zxoi7jY=; b=fYgwtpUfrOK1FslkVRqNTZd9F0
        fIPS/sEiixzfNIa3bCA7SRUSDW47SNMHdzfkn3cRmw5en+vWiaJkvLK6uIbn8yJvs7IQ96upg8thZ
        1rW9knywYxzdfc3O3nW+Y4URt0/HGmw4o1okOP/ySkinX+nkXGKJTX+VpH+dVV3HLt6UFMIInQBr/
        BLR0KcehP0bGfOWrgiLAySezVU//eR9kNXUjF6OxNcQZeCFa5hfJVyQtxuCgMyYsjEyVfK3hvzDZ/
        Pov3aekz++aAz+UdLJK1DJLcfCJoMYRUC/f7nXCfCyOy+iXOel3z6nL3VYvAbxfBdwqcW4ioUIEs9
        vPsXgIlg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj2sZ-00ENAY-7j; Fri, 05 Nov 2021 17:19:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7620301995;
        Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 66431201C7B59; Fri,  5 Nov 2021 18:19:48 +0100 (CET)
Message-ID: <20211105171821.114706623@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Nov 2021 18:10:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH 11/22] x86,xen: Remove .fixup usage
References: <20211105171023.989862879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Employ the fancy new EX_TYPE_IMM_REG to create EX_TYPE_NEG_REG to
store '-1' into the designated register and use this to remove some
Xen .fixup usage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    1 +
 arch/x86/include/asm/xen/page.h            |   12 ++----------
 2 files changed, 3 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -35,5 +35,6 @@
 
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
+#define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_DATA_IMM(-1))
 
 #endif
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
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_NEG_REG, %[ret])
 		     : [ret] "+r" (ret), [ptr] "=m" (*addr)
 		     : [val] "r" (val));
 
@@ -115,11 +111,7 @@ static inline int xen_safe_read_ulong(co
 
 	asm volatile("1: mov %[ptr], %[rval]\n"
 		     "2:\n"
-		     ".section .fixup, \"ax\"\n"
-		     "3: sub $1, %[ret]\n"
-		     "   jmp 2b\n"
-		     ".previous\n"
-		     _ASM_EXTABLE(1b, 3b)
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_NEG_REG, %[ret])
 		     : [ret] "+r" (ret), [rval] "+r" (rval)
 		     : [ptr] "m" (*addr));
 	*val = rval;


