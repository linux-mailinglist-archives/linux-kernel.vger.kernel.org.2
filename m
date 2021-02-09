Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA451315CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhBJCLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbhBJA4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:56:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3E2C06178B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:53:37 -0800 (PST)
Message-Id: <20210210002512.869753106@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZUuD7el08S9hIgNKakBrr1aoSRMs579UlOVxCfrS//U=;
        b=dp5EiHQMGiAOO+yX/GnORd9hKQ2ECwHstRqfSHhzwEwIrYxPZm/HYcJR4NtMhn/BqHeR+R
        rdalgEOCkLQDK2W2BnFT7VOLVvxhlFk5rCf972IuM5ImVD4Jzt2xLz38Mh9cVmesqTfgLv
        LMkxyByYyloVZmd6ZWvazj6Nn1yv1A2lu8K6GmF9AHxomcw75CaupA9i5KSYVEmMVKMm2R
        +x3kYKeHW1XabYKNjY56VTRfKkmj933f/TSGohrHuJnfqiAkn4QS6PpGh8OBG00StHEHby
        JK3IkBInEcCtpgEfAWvFonpwb7Gj515n8UDnwfQsAUGOpHO12SJFJHlhWeM0+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZUuD7el08S9hIgNKakBrr1aoSRMs579UlOVxCfrS//U=;
        b=pk0IXAGN+FWct9fRQDqP+cXQ9XJma5LDxtzA0z/1OBI9MxyM/3vHuhWTxGhu8V96LnW4+M
        MIuDzvfNxumRFjCg==
Date:   Wed, 10 Feb 2021 00:40:49 +0100
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
Subject: [patch V2 08/13] x86/entry: Use run_sysvec_on_irqstack_cond() for XEN upcall
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

To avoid yet another macro implementation reuse the existing
run_sysvec_on_irqstack_cond() and move the set_irq_regs() handling into the
called function. Makes the code even simpler.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

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


