Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86953B2BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhFXJ7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhFXJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB56C061760
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yMslbz0udaKpV6oAogQySTQXXC96O71vea0Ft0ChJrE=; b=DjegSqqn6390EloDVw5PjsSzlx
        X31Utu5tZRsoJtdq0dQY7IoxWxnKNQs7nrn29xMR0s0HniI6aC0TqlZIIi/DLC4/JNBzVRJ3uykkD
        SoqH8egp/C83YIqWyZyx8IQea4O05gaCWkFS0cxUfGuMlgN7GefFh6/6jV8fs2LkHKuLcz4cRGSbr
        mR4k1YZfVjofJxiEdL/BAERQj5Tb/WM/IpMWAH68MSgowE3jLjdmFXj7KjYuyg7fvtdy+vUJb/k+V
        K7pTkujpWFq/D6NeV7Su280a4L3MsG5GX2N7CyKv99XcVIwRqT9fH36vvHJ1EUDcFo3lfGflWx7OD
        0FRaEqCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4J-00GQP6-8l; Thu, 24 Jun 2021 09:54:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A52C13005E3;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2146B2BC05F3F; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.749712274@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 18/24] x86/xen: Make save_fl() noinstr
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: pv_ops[30]: native_save_fl
vmlinux.o: warning: objtool: pv_ops[30]: __raw_callee_save_xen_save_fl
vmlinux.o: warning: objtool: pv_ops[30]: xen_save_fl_direct
vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x73: call to pv_ops[30]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h |    7 +++++--
 arch/x86/kernel/irqflags.S      |    2 ++
 arch/x86/xen/irq.c              |    4 ++--
 arch/x86/xen/xen-asm.S          |   32 ++++++++++++++++----------------
 4 files changed, 25 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -653,10 +653,10 @@ bool __raw_callee_save___native_vcpu_is_
  * functions.
  */
 #define PV_THUNK_NAME(func) "__raw_callee_save_" #func
-#define PV_CALLEE_SAVE_REGS_THUNK(func)					\
+#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
 	extern typeof(func) __raw_callee_save_##func;			\
 									\
-	asm(".pushsection .text;"					\
+	asm(".pushsection " section ", \"ax\";"				\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
 	    PV_THUNK_NAME(func) ":"					\
@@ -669,6 +669,9 @@ bool __raw_callee_save___native_vcpu_is_
 	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
+#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
+	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
+
 /* Get a reference to a callee-save function */
 #define PV_CALLEE_SAVE(func)						\
 	((struct paravirt_callee_save) { __raw_callee_save_##func })
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -7,9 +7,11 @@
 /*
  * unsigned long native_save_fl(void)
  */
+.pushsection .noinstr.text, "ax"
 SYM_FUNC_START(native_save_fl)
 	pushf
 	pop %_ASM_AX
 	ret
 SYM_FUNC_END(native_save_fl)
+.popsection
 EXPORT_SYMBOL(native_save_fl)
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -24,7 +24,7 @@ void xen_force_evtchn_callback(void)
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
 
-asmlinkage __visible unsigned long xen_save_fl(void)
+asmlinkage __visible noinstr unsigned long xen_save_fl(void)
 {
 	struct vcpu_info *vcpu;
 	unsigned long flags;
@@ -40,7 +40,7 @@ asmlinkage __visible unsigned long xen_s
 	*/
 	return (-flags) & X86_EFLAGS_IF;
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl, ".noinstr.text");
 
 asmlinkage __visible void xen_irq_disable(void)
 {
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -58,22 +58,6 @@ SYM_FUNC_START(xen_irq_disable_direct)
 SYM_FUNC_END(xen_irq_disable_direct)
 
 /*
- * (xen_)save_fl is used to get the current interrupt enable status.
- * Callers expect the status to be in X86_EFLAGS_IF, and other bits
- * may be set in the return value.  We take advantage of this by
- * making sure that X86_EFLAGS_IF has the right value (and other bits
- * in that byte are 0), but other bits in the return value are
- * undefined.  We need to toggle the state of the bit, because Xen and
- * x86 use opposite senses (mask vs enable).
- */
-SYM_FUNC_START(xen_save_fl_direct)
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-	setz %ah
-	addb %ah, %ah
-	ret
-SYM_FUNC_END(xen_save_fl_direct)
-
-/*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
  */
@@ -103,6 +87,22 @@ SYM_FUNC_START(check_events)
 SYM_FUNC_END(check_events)
 
 .pushsection .noinstr.text, "ax"
+/*
+ * (xen_)save_fl is used to get the current interrupt enable status.
+ * Callers expect the status to be in X86_EFLAGS_IF, and other bits
+ * may be set in the return value.  We take advantage of this by
+ * making sure that X86_EFLAGS_IF has the right value (and other bits
+ * in that byte are 0), but other bits in the return value are
+ * undefined.  We need to toggle the state of the bit, because Xen and
+ * x86 use opposite senses (mask vs enable).
+ */
+SYM_FUNC_START(xen_save_fl_direct)
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	setz %ah
+	addb %ah, %ah
+	ret
+SYM_FUNC_END(xen_save_fl_direct)
+
 SYM_FUNC_START(xen_read_cr2)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX


