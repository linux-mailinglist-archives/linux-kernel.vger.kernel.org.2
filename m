Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA54315CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhBJCIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:08:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55222 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbhBJAyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:54:17 -0500
Message-Id: <20210210002512.578371068@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WQDPlicIaWM+pkANu1hZXAw0rPfVqv7KclaSDn27Q7c=;
        b=3z52E6r1WKlEC7Y4Thv7qa56/0QM2ay0ovxPtPQaJpsnf+Zcr8Lqo/tn0clAcHvgzZH4AO
        0sWL9S66eEdvdAr+VITJQZdXj/u/xNIr2f/dKeJJIOkWUJIXoftYBWLXxKWKpfQIHSkTZg
        5WbJy6hWgJhwDDm1KbH/SLcVTToYjMi7IsD0caDW82+m0UdNiTI7NQOHkiL32/SWZYl/Cr
        u16z3Z6rCvvvQOO5D0d1gBeKgkbgvZ6cyrV9UAKCDQXVoQckuHlbBbJ5Id9uhSbec4BUiH
        9FFPmxpwwmW/fds3Q+F+UomxORpvixQPPnul4ANEyS4FXUoK9NdpEuVp5fLapA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WQDPlicIaWM+pkANu1hZXAw0rPfVqv7KclaSDn27Q7c=;
        b=unOYW3k4QelBOTKhx0sIAGhlAwW30bxWbxjGqE0VF2NMGUWwrx/eFZrZOOOIRPgL88BkZj
        wnV12POFgrEJAgCQ==
Date:   Wed, 10 Feb 2021 00:40:46 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: [patch V2 05/13] x86/irq: Provide macro for inlining irq stack switching
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The effort to make the ASM entry code slim and unified moved the irq stack
switching out of the low level ASM code so that the whole return from
interrupt work and state handling can be done in C and the ASM code just
handles the low level details of entry and exit.

This ended up being a suboptimal implementation for various reasons
(including tooling). The main pain points are:

 - The indirect call which is expensive thanks to retpoline

 - The inability to stay on the irq stack for softirq processing on return
   from interrupt

 - The fact that the stack switching code ends up being an easy to target
   exploit gadget.

Prepare for inlining the stack switching logic into the C entry points by
providing a ASM macro which contains the guts of the switching mechanism:

  1) Store RSP at the top of the irq stack
  2) Switch RSP to the irq stack
  3) Invoke code
  4) Pop the original RSP back

Document the unholy asm() logic while at it to reduce the amount of head
scratching required a half year from now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
V2: Cosmetic changes - Borislav
    Have ASM_CALL_CONSTRAINT unconditional - Josh
---
 arch/x86/include/asm/irq_stack.h |   98 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -7,6 +7,104 @@
 #include <asm/processor.h>
 
 #ifdef CONFIG_X86_64
+
+/*
+ * Macro to inline switching to an interrupt stack and invoking function
+ * calls from there. The following rules apply:
+ *
+ * - Ordering:
+ *
+ *   1. Write the stack pointer into the top most place of the irq
+ *	stack. This ensures that the various unwinders can link back to the
+ *	original stack.
+ *
+ *   2. Switch the stack pointer to the top of the irq stack.
+ *
+ *   3. Invoke whatever needs to be done (@asm_call argument)
+ *
+ *   4. Pop the original stack pointer from the top of the irq stack
+ *	which brings it back to the original stack where it left off.
+ *
+ * - Function invocation:
+ *
+ *   To allow flexible usage of the macro, the actual function code including
+ *   the store of the arguments in the call ABI registers is handed in via
+ *   the @asm_call argument.
+ *
+ * - Local variables:
+ *
+ *   @tos:
+ *	The @tos variable holds a pointer to the top of the irq stack and
+ *	_must_ be allocated in a non-callee saved register as this is a
+ *	restriction coming from objtool.
+ *
+ *	Note, that (tos) is both in input and output constraints to ensure
+ *	that the compiler does not assume that R11 is left untouched in
+ *	case this macro is used in some place where the per cpu interrupt
+ *	stack pointer is used again afterwards
+ *
+ * - Function arguments:
+ *	The function argument(s), if any, have to be defined in register
+ *	variables at the place where this is invoked. Storing the
+ *	argument(s) in the proper register(s) is part of the @asm_call
+ *
+ * - Constraints:
+ *
+ *   The constraints have to be done very carefully because the compiler
+ *   does not know about the assembly call.
+ *
+ *   output:
+ *     As documented already above the @tos variable is required to be in
+ *     the output constraints to make the compiler aware that R11 cannot be
+ *     reused after the asm() statement.
+ *
+ *     For builds with CONFIG_UNWIND_FRAME_POINTER ASM_CALL_CONSTRAINT is
+ *     required as well as this prevents certain creative GCC variants from
+ *     misplacing the ASM code.
+ *
+ *  input:
+ *    - func:
+ *	  Immediate, which tells the compiler that the function is referenced.
+ *
+ *    - tos:
+ *	  Register. The actual register is defined by the variable declaration.
+ *
+ *    - function arguments:
+ *	  The constraints are handed in via the 'argconstr' argument list. They
+ *	  describe the register arguments which are used in @asm_call.
+ *
+ *  clobbers:
+ *     Function calls can clobber anything except the callee-saved
+ *     registers. Tell the compiler.
+ */
+#define call_on_irqstack(func, asm_call, argconstr...)			\
+{									\
+	register void *tos asm("r11");					\
+									\
+	tos = ((void *)__this_cpu_read(hardirq_stack_ptr));		\
+									\
+	asm_inline volatile(						\
+	"movq	%%rsp, (%[tos])				\n"		\
+	"movq	%[tos], %%rsp				\n"		\
+									\
+	asm_call							\
+									\
+	"popq	%%rsp					\n"		\
+									\
+	: "+r" (tos), ASM_CALL_CONSTRAINT				\
+	: [__func] "i" (func), [tos] "r" (tos) argconstr		\
+	: "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10",	\
+	  "memory"							\
+	);								\
+}
+
+/* Macros to assert type correctness for run_*_on_irqstack macros */
+#define assert_function_type(func, proto)				\
+	static_assert(__builtin_types_compatible_p(typeof(&func), proto))
+
+#define assert_arg_type(arg, proto)					\
+	static_assert(__builtin_types_compatible_p(typeof(arg), proto))
+
 static __always_inline bool irqstack_active(void)
 {
 	return __this_cpu_read(hardirq_stack_inuse);

