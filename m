Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8B33B2BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhFXJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFXJ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:57:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3655CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qHTXS78ok5kfLGklYF3b5PlRhcrT3rsqkzy3QAz8Fb0=; b=iL83eqacToedD2EN3/fjzcR2Pb
        dfBjsd3lhjvpbPcF2qR46GdtFRya5OmsgGpV9DAkBCJAB41Upma66W85m4xXgBCW4/+MnrZ6M/aPu
        JakTMUxFgxDWY5Ru1jhOl+Qf+pbUdRUur/uld/bBcKG2vlCmSFVqqdQ56xtNFccABbi2LocBreW1d
        vVDGtNKl9P3eZxyweWjKpeghyyYKQPk7o/tPxQhwQFOuohCQbmM9Bvj5vOQgeMKlV+sD7yfGh8RZw
        BY6lH7Wl53JwkvdI3d61zYIqVr9FjyfnTK2/OEUSjsQOgVV+WLX/QgIDezgIPe97thWvPSJ0diexZ
        lOvZm4eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4C-00BCEM-GM; Thu, 24 Jun 2021 09:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA2853005EB;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2F6922BC1D0C2; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.872254932@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 20/24] x86/xen: Make irq_enable() noinstr
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: pv_ops[32]: native_irq_enable
vmlinux.o: warning: objtool: pv_ops[32]: __raw_callee_save_xen_irq_enable
vmlinux.o: warning: objtool: pv_ops[32]: xen_irq_enable_direct
vmlinux.o: warning: objtool: lock_is_held_type()+0xfe: call to pv_ops[32]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/paravirt.c |    7 ++++-
 arch/x86/xen/irq.c         |    4 +--
 arch/x86/xen/xen-asm.S     |   56 ++++++++++++++++++++++-----------------------
 3 files changed, 36 insertions(+), 31 deletions(-)

--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -258,6 +258,11 @@ static noinstr void pv_native_set_debugr
 	native_set_debugreg(regno, val);
 }
 
+static noinstr void pv_native_irq_enable(void)
+{
+	native_irq_enable();
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
@@ -302,7 +307,7 @@ struct paravirt_patch_template pv_ops =
 	/* Irq ops. */
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
-	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
+	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
 #endif /* CONFIG_PARAVIRT_XXL */
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -53,7 +53,7 @@ asmlinkage __visible void xen_irq_disabl
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
 
-asmlinkage __visible void xen_irq_enable(void)
+asmlinkage __visible noinstr void xen_irq_enable(void)
 {
 	struct vcpu_info *vcpu;
 
@@ -76,7 +76,7 @@ asmlinkage __visible void xen_irq_enable
 
 	preempt_enable();
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable, ".noinstr.text");
 
 static void xen_safe_halt(void)
 {
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -22,33 +22,6 @@
 #include <linux/linkage.h>
 
 /*
- * Enable events.  This clears the event mask and tests the pending
- * event status with one and operation.  If there are pending events,
- * then enter the hypervisor to get them handled.
- */
-SYM_FUNC_START(xen_irq_enable_direct)
-	FRAME_BEGIN
-	/* Unmask events */
-	movb $0, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-
-	/*
-	 * Preempt here doesn't matter because that will deal with any
-	 * pending interrupts.  The pending check may end up being run
-	 * on the wrong CPU, but that doesn't hurt.
-	 */
-
-	/* Test for pending */
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
-	jz 1f
-
-	call check_events
-1:
-	FRAME_END
-	ret
-SYM_FUNC_END(xen_irq_enable_direct)
-
-
-/*
  * Disabling events is simply a matter of making the event mask
  * non-zero.
  */
@@ -57,6 +30,8 @@ SYM_FUNC_START(xen_irq_disable_direct)
 	ret
 SYM_FUNC_END(xen_irq_disable_direct)
 
+.pushsection .noinstr.text, "ax"
+
 /*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
@@ -86,7 +61,32 @@ SYM_FUNC_START(check_events)
 	ret
 SYM_FUNC_END(check_events)
 
-.pushsection .noinstr.text, "ax"
+/*
+ * Enable events.  This clears the event mask and tests the pending
+ * event status with one and operation.  If there are pending events,
+ * then enter the hypervisor to get them handled.
+ */
+SYM_FUNC_START(xen_irq_enable_direct)
+	FRAME_BEGIN
+	/* Unmask events */
+	movb $0, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+
+	/*
+	 * Preempt here doesn't matter because that will deal with any
+	 * pending interrupts.  The pending check may end up being run
+	 * on the wrong CPU, but that doesn't hurt.
+	 */
+
+	/* Test for pending */
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
+	jz 1f
+
+	call check_events
+1:
+	FRAME_END
+	ret
+SYM_FUNC_END(xen_irq_enable_direct)
+
 /*
  * (xen_)save_fl is used to get the current interrupt enable status.
  * Callers expect the status to be in X86_EFLAGS_IF, and other bits


