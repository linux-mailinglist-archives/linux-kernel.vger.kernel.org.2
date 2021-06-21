Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041973AE89F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFUMFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFUMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:05:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE426C061767
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=yMslbz0udaKpV6oAogQySTQXXC96O71vea0Ft0ChJrE=; b=ekJ0gH2eUq7yOcT01QTsHr5rFH
        3FC5aUEI+0/3iAt7lPk/y/DZOOOfaf5Wytrayowmh8JAhgkcTTH2cLF9mULVxVVvEhBd8jcDA6VwY
        NJtKvKI9a+DEqruv1Mz4cs5qqKNcYdEIBZ2aQ31+MCBO3wZODuoq16FrPzrq/+xBsm4eUdYkUzTMK
        gKoAw1kxNyl6gE9pikRfAmPEq9EFTO22QUcEzhXZu2MoiuuY6tY06EmTUnWN1H1T41WgbwXJ09u7N
        YglPh2nd3JQ5AvaKMj2rjdILOBWk7ma4CUaSUaUyE9+N8ZYMxm4v9b5HnOFCF7hYfYsbXaodX4yy3
        Sj5XZZhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdR-00AEJw-5z; Mon, 21 Jun 2021 12:02:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B60F93005BA;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 353FB235EE38A; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120121.352066430@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 12/18] x86/xen: Make save_fl() noinstr
References: <20210621111233.344964031@infradead.org>
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


