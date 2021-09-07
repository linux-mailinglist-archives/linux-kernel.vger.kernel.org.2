Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5091F402F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346454AbhIGUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbhIGUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:25:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6CC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:24:45 -0700 (PDT)
Message-ID: <20210907200848.355816654@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631046283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E3qyVicLO48eluwrQSkA3OguqIzUn4L8Bcq7jWABxpA=;
        b=LI7BTv1VAzBHIsWF1c5Jszn9ypJaYg2VpcZbjM995IUzgDyziHBtaVE+NlvxbRHbCmMf68
        b92njcDxt0RhI+Kh+/tcDPHFaSNk7UTLwpzl3RHwxZm6HwFe7qdjljCbqYKBtPfCUUZaJ5
        CcbxOQnRqCXut1UPMGNj8Oyv6jbQQjLnI3TyuPq4pTR3g19jjh7alFRZpkZIrlFrnQMANf
        fiPXHjV/FittN8+0XoUtfxuY0+NWXIn1QRFTfy+m0dA7x/f67PFbGk+XMZN9DE07w4UAZc
        OtLrXnvzaQoSF5eyb7kdy5lmpji8gPUdFCAGeWNLU6pMmBPj9mYcCbtnY69kIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631046283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=E3qyVicLO48eluwrQSkA3OguqIzUn4L8Bcq7jWABxpA=;
        b=lmLzS1gBsKl/r71kmNZQWY04uJc/4ETYjtVTc2E9o9tu3WFxQaEBX6ft579ovXUwXD8pw4
        TwbSJJ+EDake2YAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Ziljstra <peterz@infradead.org>
Subject: [patch V2.1 02/20] x86/extable: Get rid of redundant macros
References: <20210907200722.067068005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  7 Sep 2021 22:24:43 +0200 (CEST)
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

