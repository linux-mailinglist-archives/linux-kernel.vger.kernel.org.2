Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104063B2BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhFXJ66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbhFXJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:58:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D23C061756
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=H00IMLUlaIrSE9UKMOc5mWD67u54cGByQXTmPNVV5Q0=; b=fRQS3cbilNodTL0o1lYXNhuNdm
        x2RX3V2mr/h4N7/B24J6RHXnHUqoPTGVcOzplu1xTIqq7VRtbQmVIo8Bjvm9pv5F9qpzXqpmjeB7e
        E1CoxFkEdIvwe62HQhHGv1zvM6p+XbVQp7ALBxzfdwpaCE6SifdI0N6lgK+waAfW8LwzAp+3VfGNP
        tKmRMKBkYQP3VQv1MIrOjZMewXzkPepEEDguSwTQGF7re/YjJIlYZIXaMB2WNKt/9j4c18QF4mOdG
        zl3wnVzIN+t14A08861XdfbRe4SR6tZAD6M7nAeSa2A7VB2JmrzMVk0tKpfHnX6Punb2PuFsHxY1y
        dr/pWmJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwM4J-00GQP7-9P; Thu, 24 Jun 2021 09:54:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AB2E53005EC;
        Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 379BD2BC1D0C3; Thu, 24 Jun 2021 11:54:24 +0200 (CEST)
Message-ID: <20210624095148.933869441@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:41:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com, rostedt@goodmis.org,
        dvyukov@google.com, elver@google.com
Subject: [PATCH v2 21/24] x86/xen: Make irq_disable() noinstr
References: <20210624094059.886075998@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vmlinux.o: warning: objtool: pv_ops[31]: native_irq_disable
vmlinux.o: warning: objtool: pv_ops[31]: __raw_callee_save_xen_irq_disable
vmlinux.o: warning: objtool: pv_ops[31]: xen_irq_disable_direct
vmlinux.o: warning: objtool: lock_is_held_type()+0x5b: call to pv_ops[31]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/paravirt.c |    7 ++++++-
 arch/x86/xen/irq.c         |    4 ++--
 arch/x86/xen/xen-asm.S     |    3 +--
 3 files changed, 9 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -263,6 +263,11 @@ static noinstr void pv_native_irq_enable
 	native_irq_enable();
 }
 
+static noinstr void pv_native_irq_disable(void)
+{
+	native_irq_disable();
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
@@ -306,7 +311,7 @@ struct paravirt_patch_template pv_ops =
 
 	/* Irq ops. */
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
-	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
+	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -42,7 +42,7 @@ asmlinkage __visible noinstr unsigned lo
 }
 __PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl, ".noinstr.text");
 
-asmlinkage __visible void xen_irq_disable(void)
+asmlinkage __visible noinstr void xen_irq_disable(void)
 {
 	/* There's a one instruction preempt window here.  We need to
 	   make sure we're don't switch CPUs between getting the vcpu
@@ -51,7 +51,7 @@ asmlinkage __visible void xen_irq_disabl
 	this_cpu_read(xen_vcpu)->evtchn_upcall_mask = 1;
 	preempt_enable_no_resched();
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable, ".noinstr.text");
 
 asmlinkage __visible noinstr void xen_irq_enable(void)
 {
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 
+.pushsection .noinstr.text, "ax"
 /*
  * Disabling events is simply a matter of making the event mask
  * non-zero.
@@ -30,8 +31,6 @@ SYM_FUNC_START(xen_irq_disable_direct)
 	ret
 SYM_FUNC_END(xen_irq_disable_direct)
 
-.pushsection .noinstr.text, "ax"
-
 /*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.


