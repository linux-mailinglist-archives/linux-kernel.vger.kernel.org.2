Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B33FEC76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbhIBKwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbhIBKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:52:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0828CC06129E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:50:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k24so1480103pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaFO9ZNuL8LbfmBnRSJrjXQxn7MIPhQ31K06L4a+1wU=;
        b=gW1BhsnK0CJOWQx8sgCIw89fR+5rGWWNyewG94lwmGHS6djYHsjvHHW/ckH25+U3ub
         K/R/pcxXjZ4aguyLPlg8dNmZv5G08kRDhOWXs255xfeJpLk4aUX+e6wPMrvr/fs0A0kW
         ea5B0LmTBnFtq0UMCW8yluVSjet1ChvV7QT3meiQVgnYGSTPdn77l6YFGhMhLkEFkNWJ
         pMQSmM70RjlumjWdvRoKcXu1ywdZOpwN8Id73Fvkpj+UjzDs+YZSMdTg9MDGw+n7/K5o
         kNE3UCgyK5Rq023cG6SIHe6D5s33KYDOVxb2G/BFFCKyvkH9Js+DWF/vqVtJbxOmusAE
         92Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaFO9ZNuL8LbfmBnRSJrjXQxn7MIPhQ31K06L4a+1wU=;
        b=gBM3uESuYyhoNjlsLCjvA2+DZwttwlFHkMVLY7OsYkApXViX+1KH5s1h7OQE4si4cH
         9gzWkwjFcVophV8gvTHkNfY0+1b5tCQxdIwQLrCK05UidDquThpwc1So7XU3qNvproFU
         kgsY3OBJSe+RfCXnpuGhchBZ0KQyBctVZZHwalQO60pziVzSwauJlm18cNZJFM94Tcf9
         ovtHkjmBe16j8Ra3vLvpjYbABgPyB9YR0x8htVpwpJZz8wcUKuyO8nkVEKQEm6mCSEKF
         JcuuDO4gdyNgdLCFxrdOBe1QAcJ58PxAPPxURVKPqMQ2RMuJyOT3oJVaJFoR0VZK8UzS
         tB9Q==
X-Gm-Message-State: AOAM5332ulOSY6YBFRSifuo4oujGil5zivgDvmGxDRzAIFaPNKkHJBxm
        tmRmOinK5rgbuN7luUZFygaUPhXLC6E=
X-Google-Smtp-Source: ABdhPJzWNcPJMCreKfHDYwk3PXvg4n/8fZ5ufLvsuoHtRC2M6CCgPrdvAJi8RyT1j3jPDKnuiWbqQw==
X-Received: by 2002:a65:5845:: with SMTP id s5mr2560714pgr.227.1630579846339;
        Thu, 02 Sep 2021 03:50:46 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id w3sm1895608pjv.0.2021.09.02.03.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 03:50:46 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 25/24] x86/traps: Rewrite native_load_gs_index in C code
Date:   Thu,  2 Sep 2021 18:50:51 +0800
Message-Id: <20210902105052.2842-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

There is no constrain/limition to force native_load_gs_index() to be in
ASM code.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S            | 36 ----------------------------
 arch/x86/entry/traps.c               | 25 +++++++++++++++++++
 arch/x86/include/asm/special_insns.h | 11 +--------
 arch/x86/mm/extable.c                | 15 ++++++++++++
 4 files changed, 41 insertions(+), 46 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2d17fca1f503..16ee481e9b5f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -659,42 +659,6 @@ native_irq_return_ldt:
 SYM_CODE_END(common_interrupt_return)
 _ASM_NOKPROBE(common_interrupt_return)
 
-/*
- * Reload gs selector with exception handling
- * edi:  new selector
- *
- * Is in entry.text as it shouldn't be instrumented.
- */
-SYM_FUNC_START(asm_load_gs_index)
-	FRAME_BEGIN
-	swapgs
-SYM_INNER_LABEL(asm_load_gs_index_gs_change, SYM_L_GLOBAL)
-.Lgs_change:
-	movl	%edi, %gs
-2:	ALTERNATIVE "", "mfence", X86_BUG_SWAPGS_FENCE
-	swapgs
-	FRAME_END
-	ret
-SYM_FUNC_END(asm_load_gs_index)
-EXPORT_SYMBOL(asm_load_gs_index)
-
-	_ASM_EXTABLE(.Lgs_change, .Lbad_gs)
-	.section .fixup, "ax"
-	/* running with kernelgs */
-SYM_CODE_START_LOCAL_NOALIGN(.Lbad_gs)
-	swapgs					/* switch back to user gs */
-.macro ZAP_GS
-	/* This can't be a string because the preprocessor needs to see it. */
-	movl $__USER_DS, %eax
-	movl %eax, %gs
-.endm
-	ALTERNATIVE "", "ZAP_GS", X86_BUG_NULL_SEG
-	xorl	%eax, %eax
-	movl	%eax, %gs
-	jmp	2b
-SYM_CODE_END(.Lbad_gs)
-	.previous
-
 #ifdef CONFIG_XEN_PV
 /*
  * A note on the "critical region" in our callback handler.
diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index 52511db6baa6..2a17d74569fd 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -679,6 +679,31 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 }
 
 #ifdef CONFIG_X86_64
+
+/*
+ * Reload gs selector with exception handling
+ * selector:  new selector
+ *
+ * Is noinstr as it shouldn't be instrumented.
+ */
+noinstr void native_load_gs_index(unsigned int selector)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	native_swapgs();
+	asm volatile(
+		".global asm_load_gs_index_gs_change \n"
+		"asm_load_gs_index_gs_change: \n"
+		"1: movl %0, %%gs \n"
+		"   swapgs \n"
+		"2: \n"
+		_ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_clear_gs)
+		:: "r" (selector) : "memory");
+	alternative("", "mfence", X86_BUG_SWAPGS_FENCE);
+	local_irq_restore(flags);
+}
+
 /*
  * Help handler running on a per-cpu (IST or entry trampoline) stack
  * to switch to the normal thread stack if the interrupted code was in
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 058995bb153c..c5d74ebce527 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -120,16 +120,7 @@ static inline void native_wbinvd(void)
 	asm volatile("wbinvd": : :"memory");
 }
 
-extern asmlinkage void asm_load_gs_index(unsigned int selector);
-
-static inline void native_load_gs_index(unsigned int selector)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	asm_load_gs_index(selector);
-	local_irq_restore(flags);
-}
+extern asmlinkage void native_load_gs_index(unsigned int selector);
 
 static inline unsigned long __read_cr4(void)
 {
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index e1664e9f969c..695a580a652a 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -138,6 +138,21 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_clear_fs);
 
+__visible bool ex_handler_clear_gs(const struct exception_table_entry *fixup,
+				   struct pt_regs *regs, int trapnr,
+				   unsigned long error_code,
+				   unsigned long fault_addr)
+{
+	/*
+	 * The following native_load_gs_index() should not fault, otherwise
+	 * it would be infinite recursion.
+	 */
+	if (static_cpu_has(X86_BUG_NULL_SEG))
+		native_load_gs_index(__USER_DS);
+	native_load_gs_index(0);
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
+}
+
 enum handler_type ex_get_fault_handler_type(unsigned long ip)
 {
 	const struct exception_table_entry *e;
-- 
2.19.1.6.gb485710b

