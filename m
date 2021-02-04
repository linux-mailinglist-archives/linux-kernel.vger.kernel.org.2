Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB723101FE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhBEBAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhBEA6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6860C061797
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:58:00 -0800 (PST)
Message-Id: <20210204211154.914335902@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dT/y924f7WI1Ir3LaYEXpRg5aIdOERAtoWsMEx68dmk=;
        b=0a61vNihPs+JqPRoCdBynhpeILHmE+MTp5TG6We0BKBcdNvP+hvVg791VgA1/IFDBT8FeQ
        SnnRTR2nSmIcYSUx6JF6QphISwR1mnQHr4I6bZqqQ68EbiJnqO0PX/q8iuXfyaIneHR3zG
        fZfj4NTRTD149gtPDxRLkZVu38JnShy+8NVNc2ySQlsb8QIA0/qplsonazXHp8TIiZ/8Uv
        sMSoFCqgzz1+7qqRTYCrrq8F+vgEko3WRntsY/yQDAt+vM+qZv3iCJ3TPIga5tt689pTYT
        lgbtOYTZizeAl+bFcSSq4zkSvloMdpTjgQr/6rXdlplerIMK2HCyqwsGyaNkjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=dT/y924f7WI1Ir3LaYEXpRg5aIdOERAtoWsMEx68dmk=;
        b=23PwdcnoJOy7CczbT9VJ8pnBUjgnHEllT0Fxu0CU43EJ6N6OgpES5A2tM3k9Ak1p0Q6PkC
        CrWfEmHjcVlrAjBQ==
Date:   Thu, 04 Feb 2021 21:49:11 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 08/12] x86/entry: Use run_sysvec_on_irqstack_cond() for XEN upcall
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid yet another macro implementation reuse the existing
run_sysvec_on_irqstack_cond() and move the set_irq_regs() handling into the
called function. Makes the code even simpler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -249,30 +249,23 @@ static __always_inline bool get_and_clea
 static __always_inline void restore_inhcall(bool inhcall) { }
 #endif
 
-static void __xen_pv_evtchn_do_upcall(void)
+static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
-	irq_enter_rcu();
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
 	inc_irq_stat(irq_hv_callback_count);
 
 	xen_hvm_evtchn_do_upcall();
 
-	irq_exit_rcu();
+	set_irq_regs(old_regs);
 }
 
 __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 {
-	struct pt_regs *old_regs;
+	irqentry_state_t state = irqentry_enter(regs);
 	bool inhcall;
-	irqentry_state_t state;
-
-	state = irqentry_enter(regs);
-	old_regs = set_irq_regs(regs);
 
-	instrumentation_begin();
-	run_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
-	instrumentation_end();
-
-	set_irq_regs(old_regs);
+	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {

