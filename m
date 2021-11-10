Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3F944BE5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhKJKTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhKJKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:19:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D7FC06127A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Qwo+OHKMxMv44Qo/IdYwchyLtVeX4Scd8onHXP992OI=; b=LnPIrkglHMvXAB5YVDlatXYwA1
        WF+d3EFtvClVR0vowpZyg/BHaC3/2DEj6oA1bWqxrAOfbBoi9G9RpGcOqZQ+S8b1HDxi9cMevOkd8
        mx4Kr1RC7s+nUrSEY6pNwaeXj+OHdxspEnpOGHJ3/uWMqPQvXyM5iY2qfJSUb8/e4SvK++q2AwDOE
        /eUWpSS10Z3tHx0Cygf8S60Zcen3eZERO7PJjA0IrImNeqVWkx8DWlzt0qReyZPQn9CLYz9q+uUU5
        WETHAfH5EBwzmZR4JJ71JSFZAu9UKT0GnQqNP99sS5S5J4AVcoLEM9maORLhKeyTJnq1+uVzgjuru
        YXku+jsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkkeG-001lkX-MJ; Wed, 10 Nov 2021 10:16:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD630302148;
        Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 915D7203ED505; Wed, 10 Nov 2021 11:16:06 +0100 (CET)
Message-ID: <20211110101325.663529463@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 10 Nov 2021 11:01:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        jpoimboe@redhat.com, mark.rutland@arm.com, dvyukov@google.com,
        seanjc@google.com, pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2 13/23] x86,segment: Remove .fixup usage
References: <20211110100102.250793167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and use EX_TYPE_ZERO_REG to clear the register and retry the
segment load on exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/extable_fixup_types.h |    1 +
 arch/x86/include/asm/segment.h             |    9 +--------
 2 files changed, 2 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -45,5 +45,6 @@
 
 #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
 #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
+#define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(0))
 
 #endif
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -307,14 +307,7 @@ do {									\
 									\
 	asm volatile("						\n"	\
 		     "1:	movl %k0,%%" #seg "		\n"	\
-									\
-		     ".section .fixup,\"ax\"			\n"	\
-		     "2:	xorl %k0,%k0			\n"	\
-		     "		jmp 1b				\n"	\
-		     ".previous					\n"	\
-									\
-		     _ASM_EXTABLE(1b, 2b)				\
-									\
+		     _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k0)\
 		     : "+r" (__val) : : "memory");			\
 } while (0)
 


