Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1D2403AA0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351762AbhIHNau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349432AbhIHNaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 09:30:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883F6C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 06:29:15 -0700 (PDT)
Message-ID: <20210908132525.023659534@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631107754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E3qyVicLO48eluwrQSkA3OguqIzUn4L8Bcq7jWABxpA=;
        b=1cehLeyfig+dl9UYxqftOE2CjUPUCWWM7mLvDL5gjJPDJCQAUU2pTK/Th69QAW8WRi9Ri1
        fyPWHUGNW/3auXIkB1jWWTuuvrcJ/kfBC5MS9psKHStaSbA4WPsgGYJdqp1x9j0G3jMqee
        aU+s/oBpQ9jeVm1G/B3haaCW25cUPrUYP4WPBDdcQmD3lcCp1undt5Jn74LdJoG889I+JR
        KtNSu/7oTda0ahScjxvPyHnVQH34xJ6jEuSsbTjfLlDvDldymOEm2SwtiUpjLIIXm/6raf
        UNkONvaXnHteWMxRiIwvpA97Kyp+JXlxgeTIIsCMkyv5JNeo38x9IRK33g6FGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631107754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E3qyVicLO48eluwrQSkA3OguqIzUn4L8Bcq7jWABxpA=;
        b=F8x0kvVQQRe502WC6V2IOoMWp7hTG91MQUrCeq4Z55/dJ86azv/9DzgLO+1KsTm3fP8mIg
        bYE7kQAAG8QBRQCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [patch V3 02/20] x86/extable: Get rid of redundant macros
References: <20210908130922.118265849@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed,  8 Sep 2021 15:29:13 +0200 (CEST)
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

