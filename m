Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18A840B7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhINTMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhINTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:12:37 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F13C0613E1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:09 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h7-20020a37b707000000b003fa4d25d9d0so666520qkf.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eswE9x++QEr3t7S4y8rlWeL0a3Liad59aeS4pTFkcME=;
        b=NUAtV0nW2vNvCzgyjutmQLco76CZcG5FGoie0Fm7gqFIWqoncyjBbkkKuiV7Qot8eb
         6nVeRd/M1gJdOJRohK3UsH3ju6RjTcAV5BDh//FnBiBBL0mP39NWPxvQG5nEPjpXul2e
         hBKL/RgbzF+PwJ6Ij+I2XlB/2F3beQAgrg5KgJo24I6JLBWKA4bdYOOSgQsm/25VrSVv
         xDt1NlHfXYkJuynon6KnbZgis+DjFJzPYY+9l+be5Naff0F+zsIrMnBtjWUpVN6TBDfc
         EOpRe86ODoUvzarzwBlJRZUZKB4Q58BVPxnsC/Kp7InC0YkTVihxjeg78dX0+Ap/fgrJ
         n39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eswE9x++QEr3t7S4y8rlWeL0a3Liad59aeS4pTFkcME=;
        b=jnEdTz1Fy84y1SERYnRWJHInX6Chq5jtwPCZ9uldNS4w0bNzlThvRks/byvQYN7dw9
         SO+xNB3aJEkZtRU2knorm2cTqINry62QUEv7GHejBMK0KNnwyJ6VzPYTTXHf7s9Rw+kj
         fNQRl9p9QnxyMvoWlHhnliWN2qAU/0cLC73kt3Kigjr4dZ0NwqPD+3E0T20gtRoZpAmc
         F4oDximscmFlaahUezFjVDlWVBjKaJ+f2MGtYWU6fDLKAFoB5mo+AiCZ2v8gUEwJwxr+
         zMUCdc4gJ6X02hcXZ8QQgKXoVnIVPA5kpFfW09ytONmSQa45QJ/1iuq4XDLC4Oaw7aX1
         DDpQ==
X-Gm-Message-State: AOAM531GQuJTeS0CaF9KeBXRMgPHzazrxgZ/sJeQC610tYt1XLHSDmT3
        xfBXDG6W5b9ZHCv/J/OMmDfWqi4I/x9od75BvjY=
X-Google-Smtp-Source: ABdhPJyiOlccCF+s6uZ7ACPFewW9Z+xfFvQjcbnWGm/7CizOqEhDJ0nd2ysRhlMPg2HBUW4iLLoHI7GdS924CRzC4Q8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:d19c:5902:49bb:c41])
 (user=samitolvanen job=sendgmr) by 2002:ad4:55b2:: with SMTP id
 f18mr7222089qvx.22.1631646669041; Tue, 14 Sep 2021 12:11:09 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:10:38 -0700
In-Reply-To: <20210914191045.2234020-1-samitolvanen@google.com>
Message-Id: <20210914191045.2234020-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v3 09/16] x86: Use an opaque type for functions not callable
 from C
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

The kernel has several assembly functions that are not directly callable
from C. Use an opaque type for these function prototypes to make misuse
harder, and to avoid the need to annotate references to these functions
for Clang's Control-Flow Integrity (CFI).

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Suggested-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/ftrace.h         |  2 +-
 arch/x86/include/asm/idtentry.h       | 10 +++++-----
 arch/x86/include/asm/page_64.h        |  7 ++++---
 arch/x86/include/asm/paravirt_types.h |  3 ++-
 arch/x86/include/asm/processor.h      |  2 +-
 arch/x86/include/asm/proto.h          | 25 +++++++++++++------------
 arch/x86/include/asm/uaccess_64.h     |  9 +++------
 arch/x86/kernel/alternative.c         |  2 +-
 arch/x86/kernel/ftrace.c              |  2 +-
 arch/x86/kernel/paravirt.c            |  4 ++--
 arch/x86/kvm/emulate.c                |  4 ++--
 arch/x86/kvm/kvm_emulate.h            |  9 ++-------
 arch/x86/xen/enlighten_pv.c           |  6 +++---
 arch/x86/xen/xen-ops.h                | 10 +++++-----
 14 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 9f3130f40807..54d23f421c16 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -17,7 +17,7 @@
 
 #ifndef __ASSEMBLY__
 extern atomic_t modifying_ftrace_code;
-extern void __fentry__(void);
+DECLARE_ASM_FUNC_SYMBOL(__fentry__);
 
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 1345088e9902..2f6d0528bdd2 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -27,8 +27,8 @@
  * as well which is used to emit the entry stubs in entry_32/64.S.
  */
 #define DECLARE_IDTENTRY(vector, func)					\
-	asmlinkage void asm_##func(void);				\
-	asmlinkage void xen_asm_##func(void);				\
+	DECLARE_ASM_FUNC_SYMBOL(asm_##func);				\
+	DECLARE_ASM_FUNC_SYMBOL(xen_asm_##func);				\
 	__visible void func(struct pt_regs *regs)
 
 /**
@@ -78,8 +78,8 @@ static __always_inline void __##func(struct pt_regs *regs)
  * C-handler.
  */
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
-	asmlinkage void asm_##func(void);				\
-	asmlinkage void xen_asm_##func(void);				\
+	DECLARE_ASM_FUNC_SYMBOL(asm_##func);				\
+	DECLARE_ASM_FUNC_SYMBOL(xen_asm_##func);				\
 	__visible void func(struct pt_regs *regs, unsigned long error_code)
 
 /**
@@ -386,7 +386,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * - The C handler called from the C shim
  */
 #define DECLARE_IDTENTRY_DF(vector, func)				\
-	asmlinkage void asm_##func(void);				\
+	DECLARE_ASM_FUNC_SYMBOL(asm_##func);				\
 	__visible void func(struct pt_regs *regs,			\
 			    unsigned long error_code,			\
 			    unsigned long address)
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 4bde0dc66100..d6760b6773de 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -5,6 +5,7 @@
 #include <asm/page_64_types.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/linkage.h>
 #include <asm/alternative.h>
 
 /* duplicated to the one in bootmem.h */
@@ -40,9 +41,9 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 #define pfn_valid(pfn)          ((pfn) < max_pfn)
 #endif
 
-void clear_page_orig(void *page);
-void clear_page_rep(void *page);
-void clear_page_erms(void *page);
+DECLARE_ASM_FUNC_SYMBOL(clear_page_orig);
+DECLARE_ASM_FUNC_SYMBOL(clear_page_rep);
+DECLARE_ASM_FUNC_SYMBOL(clear_page_erms);
 
 static inline void clear_page(void *page)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index d9d6b0203ec4..dfaa50d20d6a 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -38,6 +38,7 @@
 #include <asm/desc_defs.h>
 #include <asm/pgtable_types.h>
 #include <asm/nospec-branch.h>
+#include <asm/proto.h>
 
 struct page;
 struct thread_struct;
@@ -271,7 +272,7 @@ struct paravirt_patch_template {
 
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
-extern void (*paravirt_iret)(void);
+extern asm_func_ptr paravirt_iret;
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9ad2acaaae9b..3f5454c9b121 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -449,7 +449,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 
 DECLARE_PER_CPU(void *, hardirq_stack_ptr);
 DECLARE_PER_CPU(bool, hardirq_stack_inuse);
-extern asmlinkage void ignore_sysret(void);
+DECLARE_ASM_FUNC_SYMBOL(ignore_sysret);
 
 /* Save actual FS/GS selectors and bases to current->thread */
 void current_save_fsgs(void);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 8c5d1910a848..a6aa64eb3657 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_PROTO_H
 #define _ASM_X86_PROTO_H
 
+#include <linux/linkage.h>
 #include <asm/ldt.h>
 
 struct task_struct;
@@ -11,26 +12,26 @@ struct task_struct;
 void syscall_init(void);
 
 #ifdef CONFIG_X86_64
-void entry_SYSCALL_64(void);
-void entry_SYSCALL_64_safe_stack(void);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_64);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_64_safe_stack);
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
 #ifdef CONFIG_X86_32
-void entry_INT80_32(void);
-void entry_SYSENTER_32(void);
-void __begin_SYSENTER_singlestep_region(void);
-void __end_SYSENTER_singlestep_region(void);
+DECLARE_ASM_FUNC_SYMBOL(entry_INT80_32);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSENTER_32);
+DECLARE_ASM_FUNC_SYMBOL(__begin_SYSENTER_singlestep_region);
+DECLARE_ASM_FUNC_SYMBOL(__end_SYSENTER_singlestep_region);
 #endif
 
 #ifdef CONFIG_IA32_EMULATION
-void entry_SYSENTER_compat(void);
-void __end_entry_SYSENTER_compat(void);
-void entry_SYSCALL_compat(void);
-void entry_SYSCALL_compat_safe_stack(void);
-void entry_INT80_compat(void);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSENTER_compat);
+DECLARE_ASM_FUNC_SYMBOL(__end_entry_SYSENTER_compat);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_compat);
+DECLARE_ASM_FUNC_SYMBOL(entry_SYSCALL_compat_safe_stack);
+DECLARE_ASM_FUNC_SYMBOL(entry_INT80_compat);
 #ifdef CONFIG_XEN_PV
-void xen_entry_INT80_compat(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_entry_INT80_compat);
 #endif
 #endif
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 45697e04d771..df2be1efa35e 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -17,12 +17,9 @@
  */
 
 /* Handles exceptions in both to and from, but doesn't do access_ok */
-__must_check unsigned long
-copy_user_enhanced_fast_string(void *to, const void *from, unsigned len);
-__must_check unsigned long
-copy_user_generic_string(void *to, const void *from, unsigned len);
-__must_check unsigned long
-copy_user_generic_unrolled(void *to, const void *from, unsigned len);
+DECLARE_ASM_FUNC_SYMBOL(copy_user_enhanced_fast_string);
+DECLARE_ASM_FUNC_SYMBOL(copy_user_generic_string);
+DECLARE_ASM_FUNC_SYMBOL(copy_user_generic_unrolled);
 
 static __always_inline __must_check unsigned long
 copy_user_generic(void *to, const void *from, unsigned len)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e9da3dc71254..0c60a7fa6fa5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -530,7 +530,7 @@ extern struct paravirt_patch_site __start_parainstructions[],
  * convention such that we can 'call' it from assembly.
  */
 
-extern void int3_magic(unsigned int *ptr); /* defined in asm */
+DECLARE_ASM_FUNC_SYMBOL(int3_magic);
 
 asm (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 1b3ce3b4a2a2..9e0c07a82b44 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -589,7 +589,7 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-extern void ftrace_graph_call(void);
+DECLARE_ASM_FUNC_SYMBOL(ftrace_graph_call);
 
 static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
 {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 04cafc057bed..4196902527d1 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -138,7 +138,7 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 }
 
 /* These are in entry.S */
-extern void native_iret(void);
+DECLARE_ASM_FUNC_SYMBOL(native_iret);
 
 static struct resource reserve_ioports = {
 	.start = 0,
@@ -376,7 +376,7 @@ NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
-void (*paravirt_iret)(void) = native_iret;
+asm_func_ptr paravirt_iret = native_iret;
 #endif
 
 EXPORT_SYMBOL(pv_ops);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2837110e66ed..1f81f939d982 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -201,7 +201,7 @@ struct opcode {
 		const struct escape *esc;
 		const struct instr_dual *idual;
 		const struct mode_dual *mdual;
-		void (*fastop)(struct fastop *fake);
+		fastop_t fastop;
 	} u;
 	int (*check_perm)(struct x86_emulate_ctxt *ctxt);
 };
@@ -322,7 +322,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	__FOP_RET(#name)
 
 #define FOP_START(op) \
-	extern void em_##op(struct fastop *fake); \
+	DECLARE_ASM_FUNC_SYMBOL(em_##op); \
 	asm(".pushsection .text, \"ax\" \n\t" \
 	    ".global em_" #op " \n\t" \
 	    ".align " __stringify(FASTOP_SIZE) " \n\t" \
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 68b420289d7e..44c1a9324e1c 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -290,13 +290,8 @@ enum x86emul_mode {
 #define X86EMUL_SMM_MASK             (1 << 6)
 #define X86EMUL_SMM_INSIDE_NMI_MASK  (1 << 7)
 
-/*
- * fastop functions are declared as taking a never-defined fastop parameter,
- * so they can't be called from C directly.
- */
-struct fastop;
-
-typedef void (*fastop_t)(struct fastop *);
+/* fastop functions cannot be called from C directly. */
+typedef asm_func_ptr fastop_t;
 
 struct x86_emulate_ctxt {
 	void *vcpu;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 753f63734c13..398ba060185a 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -612,8 +612,8 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_machine_check)
 #endif
 
 struct trap_array_entry {
-	void (*orig)(void);
-	void (*xen)(void);
+	asm_func_ptr orig;
+	asm_func_ptr xen;
 	bool ist_okay;
 };
 
@@ -672,7 +672,7 @@ static bool __ref get_trap_addr(void **addr, unsigned int ist)
 		struct trap_array_entry *entry = trap_array + nr;
 
 		if (*addr == entry->orig) {
-			*addr = entry->xen;
+			*addr = (void *)entry->xen;
 			ist_okay = entry->ist_okay;
 			found = true;
 			break;
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 8d7ec49a35fb..b5ceb3007cfe 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -8,12 +8,12 @@
 #include <xen/xen-ops.h>
 
 /* These are code, but not functions.  Defined in entry.S */
-extern const char xen_failsafe_callback[];
+DECLARE_ASM_FUNC_SYMBOL(xen_failsafe_callback);
 
-void xen_sysenter_target(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_sysenter_target);
 #ifdef CONFIG_X86_64
-void xen_syscall_target(void);
-void xen_syscall32_target(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_syscall_target);
+DECLARE_ASM_FUNC_SYMBOL(xen_syscall32_target);
 #endif
 
 extern void *xen_initial_gdt;
@@ -136,7 +136,7 @@ __visible unsigned long xen_read_cr2(void);
 __visible unsigned long xen_read_cr2_direct(void);
 
 /* These are not functions, and cannot be called normally */
-__visible void xen_iret(void);
+DECLARE_ASM_FUNC_SYMBOL(xen_iret);
 
 extern int xen_panic_handler_init(void);
 
-- 
2.33.0.309.g3052b89438-goog

