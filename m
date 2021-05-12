Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA837EBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbhELTgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:36:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57425 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352132AbhELSCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:02:34 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14CI0xYr2812112
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 12 May 2021 11:00:59 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14CI0xYr2812112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620842460;
        bh=gqlXLuQq8BrofRaSFN0kaUrAxPVuDGKa+VrSx+E5YpU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ilWJrOlZ1rBle28L7o3R4UTaMSuLgQi84LEvLyn8PwGInlzmYHEeOSlhm6PDQGkE4
         /5q6SUdIpA5qslmKcCpEcXenc9+c3DYuGmtZ5DfSl6ehBNTY8ZjR8eHX+p+m2QJLqD
         szVq9Sw2Z1ExkNIIpTt5db3ppXZwYiwsFqkzvuJi1oR5Fs4nLnafXsGgSQWLzE0S1G
         kmTzGLrBMak6Hg1emfHVYnofdpc5J+s4jJdp6BsR39eAf0Dv29tC9aBDzx+/rr/LPz
         WTq+FcEk8vvA+ZWMJ2gRqWupr3p4E6M9QGQTH4TiWA80hRFnM/C5xLWb1U9e9RFd4w
         Ge/VlVEpJGrIg==
Subject: Re: [PATCH 4/6] x86/irq: merge common code in
 DEFINE_IDTENTRY_SYSVEC[_SIMPLE]
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210511005531.1065536-1-hpa@zytor.com>
 <20210511005531.1065536-5-hpa@zytor.com>
 <87lf8lfizj.ffs@nanos.tec.linutronix.de>
 <d6789f7c-9c44-cb57-2a52-03ac9474d2e2@zytor.com> <YJuUG5qhGW3A1fUD@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <35c78aaa-4621-6a32-5c53-c2680a4b66c5@zytor.com>
Date:   Wed, 12 May 2021 11:00:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJuUG5qhGW3A1fUD@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------446FD4EE50BABBA6757AD1B2"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------446FD4EE50BABBA6757AD1B2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/12/21 1:38 AM, Ingo Molnar wrote:
> 
> * H. Peter Anvin <hpa@zytor.com> wrote:
> 
>> On 5/11/21 7:22 AM, Thomas Gleixner wrote:
>>>
>>> That's not really making the code more readable. Something like the
>>> below perhaps?
>>>
>>> #define IDTENTRY_INVOKE_SYSVEC(func, regs, raw)				\
>>> do {									\
>>> 	irqentry_state_t state = irqentry_enter(regs);			\
>>> 									\
>>> 	instrumentation_begin();					\
>>> 	kvm_set_cpu_l1tf_flush_l1d();					\
>>>           if (raw) {							\
>>> 		__irq_enter_raw();					\
>>> 		func(regs);						\
>>> 		__irq_exit_raw();			                \
>>> 	} else {	                                                \
>>> 		run_sysvec_on_irqstack_cond(func, regs);	        \
>>>           }                                                               \
>>> 	instrumentation_end();						\
>>>           irqentry_exit(regs, state);					\
>>> } while (0)								\
>>>
>>
>> Digging more into it, it looks like a *lot* of the macros in
>> <asm/irq_stack.h> and <asm/idtentry.h> can be replaced with inlines without
>> any change in functionality or generated code.
> 
> That would be a much preferred outcome ...

Well, here is an RFC. This is obviously a much bigger change and I don't 
feel it is mature yet, but it would be good to know if you (plural) feel 
it is in the right direction.

I will clean up the rest of the patchset and resubmit.

	-hpa


--------------446FD4EE50BABBA6757AD1B2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-irq-merge-and-functionalize-common-code-in-DECLA.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-x86-irq-merge-and-functionalize-common-code-in-DECLA.pa";
 filename*1="tch"

From e52200ed187e30f45d32639612e09281a544c062 Mon Sep 17 00:00:00 2001
From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Date: Wed, 5 May 2021 17:43:46 -0700
Subject: [PATCH] x86/irq: merge and functionalize common code in
 DECLARE/DEFINE_IDTENTRY_*

Move as much of the common code in the _IDTENTRY_ and
run_*_on_irq_stack() into inline functions instead of macros. A lot of
them differ only in types and/or the presence or absence of an
additional argument; the differential amount of code is neglible and
after bending the types a little bit, they unify nicely.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/entry/common.c          |   5 +-
 arch/x86/include/asm/idtentry.h  | 170 +++++++++++++++----------------
 arch/x86/include/asm/irq_stack.h |  73 +++++--------
 arch/x86/kernel/apic/apic.c      |   2 +-
 arch/x86/kernel/irq.c            |   1 +
 arch/x86/kernel/sev-es.c         |   6 +-
 arch/x86/kernel/traps.c          |   2 +-
 7 files changed, 117 insertions(+), 142 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 7b2542b13ebd..1e46a1a35b20 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -253,7 +253,8 @@ static __always_inline bool get_and_clear_inhcall(void) { return false; }
 static __always_inline void restore_inhcall(bool inhcall) { }
 #endif
 
-static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
+static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs,
+				      u32 __dummy __always_unused)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -269,7 +270,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	irqentry_state_t state = irqentry_enter(regs);
 	bool inhcall;
 
-	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
+	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs, 0);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index c03a18cac78e..85f79a429a39 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,6 +11,65 @@
 
 #include <asm/irq_stack.h>
 
+/**
+ * idtentry_call - Common code for non-trivial IDT entry points
+ * @func:	What should ultimately be called
+ * @regs:	Pointer to entry struct pt_regs
+ * @arg:	Extra argument to func (vector, error_code)
+ * @flush:	If kvm_set_cpu_l1tf_flush_l1d() should be called
+ * @wrapper:	Wrapper to call func; NULL for just call
+ */
+static __always_inline void
+idtentry_call(irq_func_t func, struct pt_regs *regs, bool flush,
+	      void (*wrapper)(irq_func_t, struct pt_regs *, u32),
+	      u32 arg)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+
+	instrumentation_begin();
+	if (flush)
+		kvm_set_cpu_l1tf_flush_l1d();
+	if (wrapper)
+		wrapper(func, regs, arg);
+	else
+		func(regs, arg);
+	instrumentation_end();
+	irqentry_exit(regs, state);
+}
+
+/**
+ * _DEFINE_IDTENTRY - Common macro for defining idtentries with no argument
+ * @func:	Function name of the entry point
+ * @flush:	If wrapper should call kvm_set_cpu_l1tf_flush_l1d()
+ * @inline_opt: __always_inline or noinline as appropriate for __func
+ * @wrapper:	Wrapper function for calling __func
+ *
+ */
+#define _DEFINE_IDTENTRY(func, flush, inline_opt, wrapper)		\
+static inline_opt void __##func(struct pt_regs *regs, u32);		\
+__visible noinstr void func(struct pt_regs *regs)			\
+{									\
+	idtentry_call(__##func, regs, flush, wrapper, 0);		\
+}									\
+static inline_opt void							\
+__##func(struct pt_regs *regs, u32 __dummy __always_unused)
+
+/**
+ * _DEFINE_IDTENTRY_ERRORCODE - Common macro for defining idtentries with argument
+ * @func:	Function name of the entry point
+ * @flush:	If wrapper should call kvm_set_cpu_l1tf_flush_l1d()
+ * @inline_opt: __always_inline or noinline as appropriate for __func
+ * @wrapper:	Wrapper function for calling __func
+ *
+ */
+#define _DEFINE_IDTENTRY_ERRORCODE(func, flush, inline_opt, wrapper)	\
+static inline_opt void __##func(struct pt_regs *regs, u32 error_code);	\
+__visible noinstr void func(struct pt_regs *regs, u32 error_code)	\
+{									\
+	idtentry_call(__##func, regs, flush, wrapper, error_code);	\
+}									\
+static inline_opt void __##func(struct pt_regs *regs, u32 error_code)
+
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
@@ -45,19 +104,7 @@
  * which has to run before returning to the low level assembly code.
  */
 #define DEFINE_IDTENTRY(func)						\
-static __always_inline void __##func(struct pt_regs *regs);		\
-									\
-__visible noinstr void func(struct pt_regs *regs)			\
-{									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	__##func (regs);						\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
-}									\
-									\
-static __always_inline void __##func(struct pt_regs *regs)
+	_DEFINE_IDTENTRY(func, false, __always_inline, NULL)
 
 /* Special case for 32bit IRET 'trap' */
 #define DECLARE_IDTENTRY_SW	DECLARE_IDTENTRY
@@ -80,7 +127,7 @@ static __always_inline void __##func(struct pt_regs *regs)
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
 	asmlinkage void asm_##func(void);				\
 	asmlinkage void xen_asm_##func(void);				\
-	__visible void func(struct pt_regs *regs, unsigned long error_code)
+	__visible void func(struct pt_regs *regs, u32 error_code)
 
 /**
  * DEFINE_IDTENTRY_ERRORCODE - Emit code for simple IDT entry points
@@ -90,22 +137,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * Same as DEFINE_IDTENTRY, but has an extra error_code argument
  */
 #define DEFINE_IDTENTRY_ERRORCODE(func)					\
-static __always_inline void __##func(struct pt_regs *regs,		\
-				     unsigned long error_code);		\
-									\
-__visible noinstr void func(struct pt_regs *regs,			\
-			    unsigned long error_code)			\
-{									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	__##func (regs, error_code);					\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
-}									\
-									\
-static __always_inline void __##func(struct pt_regs *regs,		\
-				     unsigned long error_code)
+	_DEFINE_IDTENTRY_ERRORCODE(func, false, __always_inline, NULL)
 
 /**
  * DECLARE_IDTENTRY_RAW - Declare functions for raw IDT entry points
@@ -161,7 +193,7 @@ __visible noinstr void func(struct pt_regs *regs)
  * is required before the enter/exit() helpers are invoked.
  */
 #define DEFINE_IDTENTRY_RAW_ERRORCODE(func)				\
-__visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
+__visible noinstr void func(struct pt_regs *regs, u32 error_code)
 
 /**
  * DECLARE_IDTENTRY_IRQ - Declare functions for device interrupt IDT entry
@@ -187,25 +219,11 @@ __visible noinstr void func(struct pt_regs *regs, unsigned long error_code)
  * has to be done in the function body if necessary.
  */
 #define DEFINE_IDTENTRY_IRQ(func)					\
-static void __##func(struct pt_regs *regs, u32 vector);			\
-									\
-__visible noinstr void func(struct pt_regs *regs,			\
-			    unsigned long error_code)			\
-{									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-	u32 vector = (u32)(u8)error_code;				\
-									\
-	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_irq_on_irqstack_cond(__##func, regs, vector);		\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
-}									\
-									\
-static noinline void __##func(struct pt_regs *regs, u32 vector)
+	_DEFINE_IDTENTRY_ERRORCODE(func, true, noinline, run_on_irqstack_cond)
 
 /**
- * DECLARE_IDTENTRY_SYSVEC - Declare functions for system vector entry points
+ * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
+ *		      No error code pushed by hardware
  * @vector:	Vector number (ignored for C)
  * @func:	Function name of the entry point
  *
@@ -214,9 +232,11 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
  * - The XEN PV trap entry point: xen_##func (maybe unused)
  * - The C handler called from the ASM entry point
  *
- * Maps to DECLARE_IDTENTRY().
+ * Note: This is the C variant of DECLARE_IDTENTRY(). As the name says it
+ * declares the entry points for usage in C code. There is an ASM variant
+ * as well which is used to emit the entry stubs in entry_32/64.S.
  */
-#define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
+#define DECLARE_IDTENTRY_SYSVEC(vector, func)	\
 	DECLARE_IDTENTRY(vector, func)
 
 /**
@@ -229,20 +249,7 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
  * Runs the function on the interrupt stack if the entry hit kernel mode
  */
 #define DEFINE_IDTENTRY_SYSVEC(func)					\
-static void __##func(struct pt_regs *regs);				\
-									\
-__visible noinstr void func(struct pt_regs *regs)			\
-{									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_sysvec_on_irqstack_cond(__##func, regs);			\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
-}									\
-									\
-static noinline void __##func(struct pt_regs *regs)
+	_DEFINE_IDTENTRY(func, true, noinline, run_on_irqstack_cond)
 
 /**
  * DEFINE_IDTENTRY_SYSVEC_SIMPLE - Emit code for simple system vector IDT
@@ -255,23 +262,16 @@ static noinline void __##func(struct pt_regs *regs)
  * Only use for 'empty' vectors like reschedule IPI and KVM posted
  * interrupt vectors.
  */
+static __always_inline void
+call_sysvec_simple(irq_func_t func, struct pt_regs *regs, u32 arg)
+{
+	__irq_enter_raw();
+	func(regs, arg);
+	__irq_exit_raw();
+}
+
 #define DEFINE_IDTENTRY_SYSVEC_SIMPLE(func)				\
-static __always_inline void __##func(struct pt_regs *regs);		\
-									\
-__visible noinstr void func(struct pt_regs *regs)			\
-{									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	__irq_enter_raw();						\
-	kvm_set_cpu_l1tf_flush_l1d();					\
-	__##func (regs);						\
-	__irq_exit_raw();						\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
-}									\
-									\
-static __always_inline void __##func(struct pt_regs *regs)
+	_DEFINE_IDTENTRY(func, true, __always_inline, call_sysvec_simple)
 
 /**
  * DECLARE_IDTENTRY_XENCB - Declare functions for XEN HV callback entry point
@@ -312,8 +312,8 @@ static __always_inline void __##func(struct pt_regs *regs)
  */
 #define DECLARE_IDTENTRY_VC(vector, func)				\
 	DECLARE_IDTENTRY_RAW_ERRORCODE(vector, func);			\
-	__visible noinstr void ist_##func(struct pt_regs *regs, unsigned long error_code);	\
-	__visible noinstr void safe_stack_##func(struct pt_regs *regs, unsigned long error_code)
+	__visible noinstr void ist_##func(struct pt_regs *regs, u32 error_code);	\
+	__visible noinstr void safe_stack_##func(struct pt_regs *regs, u32 error_code)
 
 /**
  * DEFINE_IDTENTRY_IST - Emit code for IST entry points
@@ -396,8 +396,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  */
 #define DECLARE_IDTENTRY_DF(vector, func)				\
 	asmlinkage void asm_##func(void);				\
-	__visible void func(struct pt_regs *regs,			\
-			    unsigned long error_code,			\
+	__visible void func(struct pt_regs *regs, u32 error_code,	\
 			    unsigned long address)
 
 /**
@@ -408,8 +407,7 @@ static __always_inline void __##func(struct pt_regs *regs)
  * cr2 in the address argument.
  */
 #define DEFINE_IDTENTRY_DF(func)					\
-__visible noinstr void func(struct pt_regs *regs,			\
-			    unsigned long error_code,			\
+__visible noinstr void func(struct pt_regs *regs, u32 error_code,	\
 			    unsigned long address)
 
 #endif	/* !CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562854c60808..305ca95b2743 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -6,6 +6,8 @@
 
 #include <asm/processor.h>
 
+typedef void (*irq_func_t)(struct pt_regs *regs, u32 arg);
+
 #ifdef CONFIG_X86_64
 
 /*
@@ -132,7 +134,7 @@
 }
 
 /*
- * Function call sequence for __call_on_irqstack() for system vectors.
+ * Function call sequence for __call_on_irqstack() for irqs and system vectors.
  *
  * Note that irq_enter_rcu() and irq_exit_rcu() do not use the input
  * mechanism because these functions are global and cannot be optimized out
@@ -145,27 +147,6 @@
  * call to idtentry_exit() anyway, it's likely that it does not cause extra
  * effort for this asm magic.
  */
-#define ASM_CALL_SYSVEC							\
-	"call irq_enter_rcu				\n"		\
-	"movq	%[arg1], %%rdi				\n"		\
-	"call %P[__func]				\n"		\
-	"call irq_exit_rcu				\n"
-
-#define SYSVEC_CONSTRAINTS	, [arg1] "r" (regs)
-
-#define run_sysvec_on_irqstack_cond(func, regs)				\
-{									\
-	assert_function_type(func, void (*)(struct pt_regs *));		\
-	assert_arg_type(regs, struct pt_regs *);			\
-									\
-	call_on_irqstack_cond(func, regs, ASM_CALL_SYSVEC,		\
-			      SYSVEC_CONSTRAINTS, regs);		\
-}
-
-/*
- * As in ASM_CALL_SYSVEC above the clobbers force the compiler to store
- * @regs and @vector in callee saved registers.
- */
 #define ASM_CALL_IRQ							\
 	"call irq_enter_rcu				\n"		\
 	"movq	%[arg1], %%rdi				\n"		\
@@ -173,16 +154,13 @@
 	"call %P[__func]				\n"		\
 	"call irq_exit_rcu				\n"
 
-#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" (vector)
+#define IRQ_CONSTRAINTS	, [arg1] "r" (regs), [arg2] "r" (arg)
 
-#define run_irq_on_irqstack_cond(func, regs, vector)			\
-{									\
-	assert_function_type(func, void (*)(struct pt_regs *, u32));	\
-	assert_arg_type(regs, struct pt_regs *);			\
-	assert_arg_type(vector, u32);					\
-									\
-	call_on_irqstack_cond(func, regs, ASM_CALL_IRQ,			\
-			      IRQ_CONSTRAINTS, regs, vector);		\
+static __always_inline void
+run_on_irqstack_cond(irq_func_t func, struct pt_regs *regs, u32 arg)
+{
+	call_on_irqstack_cond(func, regs, ASM_CALL_IRQ,
+			      IRQ_CONSTRAINTS, regs, arg);
 }
 
 #define ASM_CALL_SOFTIRQ						\
@@ -194,28 +172,25 @@
  * interrupts are pending to be processed. The interrupt stack cannot be in
  * use here.
  */
-#define do_softirq_own_stack()						\
-{									\
-	__this_cpu_write(hardirq_stack_inuse, true);			\
-	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
-	__this_cpu_write(hardirq_stack_inuse, false);			\
+static __always_inline void do_softirq_own_stack(void)
+{
+	__this_cpu_write(hardirq_stack_inuse, true);
+	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);
+	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
 #else /* CONFIG_X86_64 */
-/* System vector handlers always run on the stack they interrupted. */
-#define run_sysvec_on_irqstack_cond(func, regs)				\
-{									\
-	irq_enter_rcu();						\
-	func(regs);							\
-	irq_exit_rcu();							\
-}
 
-/* Switches to the irq stack within func() */
-#define run_irq_on_irqstack_cond(func, regs, vector)			\
-{									\
-	irq_enter_rcu();						\
-	func(regs, vector);						\
-	irq_exit_rcu();							\
+/*
+ * System vector handlers always run on the stack they interrupted;
+ * irqs switch to the irq stack withing func().
+ */
+static __always_inline void
+run_on_irqstack_cond(irq_func_t func, struct pt_regs *regs, u32 arg)
+{
+	irq_enter_rcu();
+	func(regs, arg);
+	irq_exit_rcu();
 }
 
 #endif /* !CONFIG_X86_64 */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4a39fb429f15..64832869e1a1 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2188,7 +2188,7 @@ static noinline void handle_spurious_interrupt(u8 vector)
  */
 DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 {
-	handle_spurious_interrupt(vector);
+	handle_spurious_interrupt((u8)error_code);
 }
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_spurious_apic_interrupt)
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index e28f6a5d14f1..27994818d9b1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -239,6 +239,7 @@ static __always_inline void handle_irq(struct irq_desc *desc,
  */
 DEFINE_IDTENTRY_IRQ(common_interrupt)
 {
+	const u8 vector = error_code;
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	struct irq_desc *desc;
 
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 73873b007838..bdd75b71d0f3 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -1335,15 +1335,15 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 		vc_finish_insn(&ctxt);
 		break;
 	case ES_UNSUPPORTED:
-		pr_err_ratelimited("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+		pr_err_ratelimited("Unsupported exit-code 0x%02x in early #VC exception (IP: 0x%lx)\n",
 				   error_code, regs->ip);
 		goto fail;
 	case ES_VMM_ERROR:
-		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02x IP: 0x%lx)\n",
 				   error_code, regs->ip);
 		goto fail;
 	case ES_DECODE_FAILED:
-		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02x IP: 0x%lx)\n",
 				   error_code, regs->ip);
 		goto fail;
 	case ES_EXCEPTION:
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 853ea7a80806..f5aecbb44bc7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -461,7 +461,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	pr_emerg("PANIC: double fault, error_code: 0x%lx\n", error_code);
+	pr_emerg("PANIC: double fault, error_code: 0x%x\n", error_code);
 	die("double fault", regs, error_code);
 	panic("Machine halted.");
 	instrumentation_end();
-- 
2.31.1


--------------446FD4EE50BABBA6757AD1B2--
