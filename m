Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3372402F31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346142AbhIGT5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346094AbhIGT5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:57:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA0C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:17 -0700 (PDT)
Message-ID: <20210907195003.877912206@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631044575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E3qyVicLO48eluwrQSkA3OguqIzUn4L8Bcq7jWABxpA=;
        b=JCMVr8cQfVFHhe3QuVn3lSmhasAUQ+Op5jlexXWqoji2rK8Xcs0s/gcSLm5eKMxo7vYkPJ
        8RHJcu5+QwUC6r/g2GTHct09jZF7jOfSDiIPxi5tucYRBgctn/jmjLcoFRwWiZtqg2rhhX
        W3cxNX0Tq90AjY2ErTLRg3kW/GEM16ZmBO1tc7mX35IrJy/9B/vLmjezDJUBPhLZWPNAgD
        dGGK/jo7ih3xQsaJ98Xgjjg0wCGn1oHz7aR5+VJ6OAtMYX7m1rq1WWQ5BH+wMSeaguUm6J
        L1078jy9lT7U+jXU29D6ZyMusFMMwBBdwV1eLlFv47YQ5XVrqhu1yvQbBp26Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631044575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E3qyVicLO48eluwrQSkA3OguqIzUn4L8Bcq7jWABxpA=;
        b=JlWCEZoFg1nMu/eDOTc0cUE3mItPls51AEfnoHaqj3fU1Qo1+C8JTA8m1uVXVz1i8V3jLE
        JjYAmZfRYEhzEzBQ==
3Message-ID: <20210907193229.370353258@linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2 02/20] x86/extable: Get rid of redundant macros
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Tue,  7 Sep 2021 21:56:15 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in defining the identical macros twice depending on C or assembly
mode. They are still identical.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/include/asm/asm.h |   37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -132,18 +132,6 @@
 	.long (handler) - . ;					\
 	.popsection
 
-# define _ASM_EXTABLE(from, to)					\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
-
-# define _ASM_EXTABLE_UA(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
-
-# define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
-
-# define _ASM_EXTABLE_FAULT(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
-
 # ifdef CONFIG_KPROBES
 #  define _ASM_NOKPROBE(entry)					\
 	.pushsection "_kprobe_blacklist","aw" ;			\
@@ -164,18 +152,6 @@
 	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
 	" .popsection\n"
 
-# define _ASM_EXTABLE(from, to)					\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
-
-# define _ASM_EXTABLE_UA(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
-
-# define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
-
-# define _ASM_EXTABLE_FAULT(from, to)				\
-	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
-
 /* For C file, we already have NOKPROBE_SYMBOL macro */
 
 /*
@@ -188,6 +164,19 @@ register unsigned long current_stack_poi
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif /* __ASSEMBLY__ */
 
+#define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+
+#define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
+#define _ASM_EXTABLE_CPY(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_copy)
+
+#define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_ASM_H */

