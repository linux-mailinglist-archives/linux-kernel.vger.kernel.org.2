Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343B936297F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 22:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbhDPUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 16:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343820AbhDPUjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:24 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22724C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:59 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y10-20020a05622a004ab029019d4ad3437cso6794127qtw.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 13:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RwILZOlA2kaRn2Fjp5mm1qeS3lOQZP94Avp0hPYvV8s=;
        b=L30jDWM8kRSEV+5kKD0WdaYDR8Z0597crW3FQH5s1G/LjSolw/yXhEtVZp9T0ypPAS
         tPyUlpJ14Exkch3RC3xlJXFbHfBR552Mfb6+Xy1xFrk/Nv8td7UbSHlzm4cS7Z2l4Etr
         W6TzWRt8hGBfVkEqBk6Cal1nRFcXbLl8XEVSgSx7IFiGDC7hK2mOHD6RwzRrMIP+ZfKy
         a/2KCFx6TkK5XM8DJ7xjaJ62QjMXjhEAZ+PqBhxBwnLKNLfYa5cRgWkLbVlwrvDWk4ml
         /A06ohyKAcBHAxPplf2kgWrH1yZFUPQZIW2825lv84izTHOWps0Or/xZ0aHz78GU63Ia
         LcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RwILZOlA2kaRn2Fjp5mm1qeS3lOQZP94Avp0hPYvV8s=;
        b=hyD4ym8OePSpEK1fwkQVcNyf2pU438R6cpTScdBraF85KQ8n8lIfeb06jgpkel3T7i
         WrIR/hW/Oat7AkKDM2TjpV9AG1pKwMlN/R0FByg7sKi5Kxj9WTl5tKq1RhN6+AFs9XQ4
         kE1NTDpY+Jl2dSb2gh2HnGxlb+v5TA63WipFIPfc3QrI2FRtD54bQf3/uom1WwCcpR7P
         qutQ28MhY8VEFdEd8FWWKcfSxnkBdvlLVLTImkzdg+wrsi7cGO8r7Xm5OLPByaWDWXib
         SkdnHW37zOXDGh25IKSiDqLOn8Kuhbv7HQKQylO64arSV0UHtqjJ7F/WLL3YtkxTPOF6
         DzmQ==
X-Gm-Message-State: AOAM530PlwAigvctM3vLzX0wadEqcaeZM4ZP7q7iO+hWL+BB1IT+8+el
        F9XXugMc3YKGAYqnnZQ7/2VDz93AB3dHHJZKiVY=
X-Google-Smtp-Source: ABdhPJxL1uq/nzF08q0wDmPJcSvwOaHN3iXBV0w8/Et5CjuhjlL4nG24VjhMKCEDgNiXefsBmQ0R3oaQiJvhf65VA1o=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a0c:de03:: with SMTP id
 t3mr10322213qvk.58.1618605538302; Fri, 16 Apr 2021 13:38:58 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:35 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 06/15] x86: Avoid CFI jump tables in IDT and entry points
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function addresses in C
code with jump table addresses. To avoid referring to jump tables in
entry code with PTI, disable CFI for IDT and paravirt code, and use
function_nocfi() to prevent jump table addresses from being added to
the IDT or system call entry points.

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/include/asm/desc.h  | 8 +++++++-
 arch/x86/kernel/Makefile     | 3 +++
 arch/x86/kernel/cpu/common.c | 8 ++++----
 arch/x86/kernel/idt.c        | 2 +-
 arch/x86/kernel/traps.c      | 2 +-
 arch/x86/xen/Makefile        | 2 ++
 6 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 476082a83d1c..96666256eec2 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -381,7 +381,13 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 	desc->limit1 = (limit >> 16) & 0xf;
 }
 
-void alloc_intr_gate(unsigned int n, const void *addr);
+/*
+ * Use function_nocfi() to prevent the compiler from replacing function
+ * addresses with jump table addresses when CONFIG_CFI_CLANG is enabled.
+ */
+#define alloc_intr_gate(n, addr) __alloc_intr_gate(n, function_nocfi(addr))
+
+void __alloc_intr_gate(unsigned int n, const void *addr);
 
 static inline void init_idt_data(struct idt_data *data, unsigned int n,
 				 const void *addr)
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0704c2a94272..12a739eb208e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -46,6 +46,9 @@ endif
 # non-deterministic coverage.
 KCOV_INSTRUMENT		:= n
 
+CFLAGS_REMOVE_idt.o		:= $(CC_FLAGS_CFI)
+CFLAGS_REMOVE_paravirt.o	:= $(CC_FLAGS_CFI)
+
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6bdb69a9a7dc..e6cff98b182a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1752,10 +1752,10 @@ DEFINE_PER_CPU(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
 void syscall_init(void)
 {
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
-	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
+	wrmsrl(MSR_LSTAR, (unsigned long)function_nocfi(entry_SYSCALL_64));
 
 #ifdef CONFIG_IA32_EMULATION
-	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
+	wrmsrl(MSR_CSTAR, (unsigned long)function_nocfi(entry_SYSCALL_compat));
 	/*
 	 * This only works on Intel CPUs.
 	 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
@@ -1765,9 +1765,9 @@ void syscall_init(void)
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
 	wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
 		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
-	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
+	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)function_nocfi(entry_SYSENTER_compat));
 #else
-	wrmsrl(MSR_CSTAR, (unsigned long)ignore_sysret);
+	wrmsrl(MSR_CSTAR, (unsigned long)function_nocfi(ignore_sysret));
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
 	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d552f177eca0..6574a742e373 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -340,7 +340,7 @@ void idt_invalidate(void *addr)
 	load_idt(&idt);
 }
 
-void __init alloc_intr_gate(unsigned int n, const void *addr)
+void __init __alloc_intr_gate(unsigned int n, const void *addr)
 {
 	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
 		return;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a80806..54616dc49116 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -403,7 +403,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 		 * which is what the stub expects, given that the faulting
 		 * RIP will be the IRET instruction.
 		 */
-		regs->ip = (unsigned long)asm_exc_general_protection;
+		regs->ip = (unsigned long)function_nocfi(asm_exc_general_protection);
 		regs->sp = (unsigned long)&gpregs->orig_ax;
 
 		return;
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 40b5779fce21..61e2d9b2fa43 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -11,6 +11,8 @@ endif
 CFLAGS_enlighten_pv.o		:= -fno-stack-protector
 CFLAGS_mmu_pv.o			:= -fno-stack-protector
 
+CFLAGS_REMOVE_enlighten_pv.o	:= $(CC_FLAGS_CFI)
+
 obj-y				+= enlighten.o
 obj-y				+= mmu.o
 obj-y				+= time.o
-- 
2.31.1.368.gbe11c130af-goog

