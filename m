Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBE4593C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 18:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhKVRRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 12:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbhKVRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 12:17:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EACAC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=zZXo4jDWke/Q7rCYVKykQpvuoFZ23L9AGXvFsL0L/xk=; b=Lcdp5srEZLwZBRTS6OjZhRKiPo
        w2oEMnq9y0dqCAG2LrRImveOpLb1dtN+0rYFX27354cXiK4G+eKq+tMGewuHvwHmOr5a24bDkd8yp
        upFGBfsWvA8Ti/5qgAWOg3lRGMu6zv+GCq5A+F948fb1u4MhDTeiIFk4jI5tYtvwjY+E/33L2gxKw
        QSX8EQGWzvlTkwotnca0QRq9ZDG9GAO9ii4Kp2OPg1LLJcQiq7ZT4/02pKmLw//awZUSeC7pQ4kfa
        7sHcB2VDifr3CtwsmdRcHh9pb312CcfBMIUDc8S4RINpIPnV7t/WDc10gMM1OU4UqmNzx+Nb3wZHm
        f3cEWbNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpCtF-00D1sF-7N; Mon, 22 Nov 2021 17:14:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C34530043C;
        Mon, 22 Nov 2021 18:13:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E97282BB6443F; Mon, 22 Nov 2021 18:13:58 +0100 (CET)
Message-ID: <20211122170805.025419814@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 22 Nov 2021 18:03:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: [RFC][PATCH 1/6] x86: Annotate _THIS_IP_
References: <20211122170301.764232470@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to find _THIS_IP_ code references in objtool, annotate them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/linkage.h      |   11 +++++++++++
 include/linux/instruction_pointer.h |    5 +++++
 2 files changed, 16 insertions(+)

--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -3,10 +3,21 @@
 #define _ASM_X86_LINKAGE_H
 
 #include <linux/stringify.h>
+#include <asm/asm.h>
 
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
 
+#define _THIS_IP_						\
+	({	__label__ __here;				\
+		__here:						\
+		asm_volatile_goto (				\
+		    ".pushsection .discard.this_ip\n\t"		\
+		    _ASM_PTR " %l[__here]\n\t"			\
+		    ".popsection\n\t"				\
+		    : : : : __here);				\
+		(unsigned long)&&__here; })
+
 #ifdef CONFIG_X86_32
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
 #endif /* CONFIG_X86_32 */
--- a/include/linux/instruction_pointer.h
+++ b/include/linux/instruction_pointer.h
@@ -2,7 +2,12 @@
 #ifndef _LINUX_INSTRUCTION_POINTER_H
 #define _LINUX_INSTRUCTION_POINTER_H
 
+#include <asm/linkage.h>
+
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
+
+#ifndef _THIS_IP_
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+#endif
 
 #endif /* _LINUX_INSTRUCTION_POINTER_H */


