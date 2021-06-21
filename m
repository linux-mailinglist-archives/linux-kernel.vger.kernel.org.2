Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20403AE8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFUMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhFUMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:06:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73227C0613A3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=H00IMLUlaIrSE9UKMOc5mWD67u54cGByQXTmPNVV5Q0=; b=vNQu3vlXoyxQ6Bvtnwc+lzvHJS
        c2mHUVqZT9Z3gkCqwDqC3mTX+McLfLZLflv1Dcv58DuUCuntIPaKbIYn/OpRVvBeEQdZIV0RW1MS6
        kJod4rsRDJnC8erYDAjmDA0cAJ7npS7S3k0QrZ/4i9A2lDwbz52QzRqj7PubC7fOVEp6by5Tmb4aI
        F4EI/Sgs227PKZqI3GxXGUj9WZ9+kXKDo1jPP4tkTZgb8nouOh5XohHuWrcjOPSoSLUObLhkTtTgq
        0aNeebvH7gwc8d77p3yaBMXNUDOPJE8Fq+EgKl3PKWPsF4shB8syK2EhswMkVBwC+rW4ts6cKki6L
        Vw/dErvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvIdm-00D3ie-3a; Mon, 21 Jun 2021 12:03:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB2C03005CB;
        Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 492D0235EE38D; Mon, 21 Jun 2021 14:02:39 +0200 (CEST)
Message-ID: <20210621120121.573797819@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Jun 2021 13:12:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        joro@8bytes.org, boris.ostrovsky@oracle.com, jgross@suse.com,
        x86@kernel.org, mbenes@suse.com
Subject: [RFC][PATCH 15/18] x86/xen: Make irq_disable() noinstr
References: <20210621111233.344964031@infradead.org>
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


