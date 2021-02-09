Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80728315CF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhBJCK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbhBJAz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:55:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4A9C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 16:53:33 -0800 (PST)
Message-Id: <20210210002512.469379641@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612918410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=koso/ijkAKHT4rK+8gTqQvbpAbj2hWodmKM11mEXCzo=;
        b=oGTqOsywU3PhBfrcRDklcDnH31fQ5jT5xmFigI4hp/w96m4taMoFlAzTzivSA5xWwWEQzZ
        nhWPcnKqZhcvRh88nZSMooUHX7E0448aZoUgAsK+EUmr/IY6YIabONgnCeXrHwQ5YCCm8r
        qAjvZFIsIIldgY4LXCrbFVaO6D8c3R1rJeULg7rcHXIcTKnhpFmSmcw+i83r5LUMXUpbGT
        DTA0KqNLMNZzPr29IYZadcNrQnu1UWDHJwcELWLvdjOD4g0LosslPd/mEZscy1MUu8jPKt
        1vzERaS+R/ThD2yPfyT9NksYIMiM/Em1Eo7LjawDPVVGJ/k4f2nRkZCPIgt7Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612918410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=koso/ijkAKHT4rK+8gTqQvbpAbj2hWodmKM11mEXCzo=;
        b=cl2eD3KK0GTMfTczVe1E+y+lLelNE7Tw0A58f1IQKHjYykfKkfMY+xh0tfWdd1Oz+jjVxE
        AChYUr4xatendWBQ==
Date:   Wed, 10 Feb 2021 00:40:45 +0100
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
Subject: [patch V2 04/13] x86/apic: Split out spurious handling code
References: <20210209234041.127454039@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

sysvec_spurious_apic_interrupt() calls into the handling body of
__spurious_interrupt() which is not obvious as that function is declared
inside the DEFINE_IDTENTRY_IRQ(spurious_interrupt) macro.

As __spurious_interrupt() is currently always inlined this ends up with two
copies of the same code for no reason.

Split the handling function out and invoke it from both entry points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>

---
 arch/x86/kernel/apic/apic.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2137,18 +2137,11 @@ void __init register_lapic_address(unsig
  * Local APIC interrupts
  */
 
-/**
- * spurious_interrupt - Catch all for interrupts raised on unused vectors
- * @regs:	Pointer to pt_regs on stack
- * @vector:	The vector number
- *
- * This is invoked from ASM entry code to catch all interrupts which
- * trigger on an entry which is routed to the common_spurious idtentry
- * point.
- *
- * Also called from sysvec_spurious_apic_interrupt().
+/*
+ * Common handling code for spurious_interrupt and spurious_vector entry
+ * points below. No point in allowing the compiler to inline it twice.
  */
-DEFINE_IDTENTRY_IRQ(spurious_interrupt)
+static noinline void handle_spurious_interrupt(u8 vector)
 {
 	u32 v;
 
@@ -2183,9 +2176,23 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
 	trace_spurious_apic_exit(vector);
 }
 
+/**
+ * spurious_interrupt - Catch all for interrupts raised on unused vectors
+ * @regs:	Pointer to pt_regs on stack
+ * @vector:	The vector number
+ *
+ * This is invoked from ASM entry code to catch all interrupts which
+ * trigger on an entry which is routed to the common_spurious idtentry
+ * point.
+ */
+DEFINE_IDTENTRY_IRQ(spurious_interrupt)
+{
+	handle_spurious_interrupt(vector);
+}
+
 DEFINE_IDTENTRY_SYSVEC(sysvec_spurious_apic_interrupt)
 {
-	__spurious_interrupt(regs, SPURIOUS_APIC_VECTOR);
+	handle_spurious_interrupt(SPURIOUS_APIC_VECTOR);
 }
 
 /*

