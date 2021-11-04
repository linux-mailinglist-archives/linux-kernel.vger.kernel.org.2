Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C594457B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhKDQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhKDQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:59:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD5C061203
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GqXkbBjICzqhoA0Hhk8XFabzY8w+2fdfv8ARTnpPqhc=; b=Tt1dfP2zJH4vfD/NsjTv1G6iZM
        dajW9zL9u2psrpJIg4bBIJC5aMn07BWD7+bAvaYEQYWbkc4M634yUSB4EXsQoT5hoih31dNv//2yt
        RnRKEdMnD4Zkh6eKo5X1P1QLmfdI7wp0o+8txy/rJhkg7vlMR2PPQl8ODWgSFx4RXT3xUpkysOXYL
        kjx8QXc5CEgQ4a21sPbubN4GEDvRz8KQHJhSzsa57zov4Un4qwAUJfcPT4lbIA+JR+i7ra3P/5Hu5
        dKruJnvfAIpNhkx53lpkKHcZuV577S5r+jAfYdy/ZT+f/tAxuzpTf2mIkq6f8/mJ0pDWYWbndIy1i
        N0kWiy4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mig2X-00EC7n-VU; Thu, 04 Nov 2021 16:56:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5EE27301BCC;
        Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 44DDE2DD49FB4; Thu,  4 Nov 2021 17:56:35 +0100 (CET)
Message-ID: <20211104165525.348183644@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 04 Nov 2021 17:47:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [RFC][PATCH 14/22] x86,ftrace: Remove .fixup usage
References: <20211104164729.226550532@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and use EX_TYPE_ONE_REG to load 1 into the %[faulted] register
on exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    1 +
 arch/x86/kernel/ftrace.c                   |    9 ++-------
 2 files changed, 3 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -37,5 +37,6 @@
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(-EFAULT))
 #define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(-1))
 #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(0))
+#define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(1))
 
 #endif
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -661,13 +661,8 @@ void prepare_ftrace_return(unsigned long
 		"   movl $0, %[faulted]\n"
 		"3:\n"
 
-		".section .fixup, \"ax\"\n"
-		"4: movl $1, %[faulted]\n"
-		"   jmp 3b\n"
-		".previous\n"
-
-		_ASM_EXTABLE(1b, 4b)
-		_ASM_EXTABLE(2b, 4b)
+		_ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_ONE_REG, %[faulted])
+		_ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_ONE_REG, %[faulted])
 
 		: [old] "=&r" (old), [faulted] "=r" (faulted)
 		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)


