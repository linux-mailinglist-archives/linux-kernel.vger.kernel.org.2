Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820C031020C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbhBEA7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:59:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44108 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbhBEA6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:58:35 -0500
Message-Id: <20210204211154.513658079@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612486674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WTKxw3cYU9sqIcWjJRqdyEqf3tBdofU/yBSNh3t9yJc=;
        b=Fr4oxfzu8CPcY0QTU74YJvp0rdMBQib6yeXIhROxnbRVrj6H/5odlAYYW2OWQaiKd3e7bb
        zcBcwQ9uAjJ0D1pQ+vSB1MtwicbJQBrAQd+ftZ+vcu7Ol3pCfu0dWUE4XxHMQKdQpKxOYy
        X26qo/ckC0YqKWXCPKPYqF3STuif+BYHki2Uc6MeEkjTQWsbAPig8HmbRSyDn0fkZuGEgU
        aTluFJ4NfLBnRJrOkJ2y+8ttlTVJ1PQM6lz231Jpoii9lgA999L38bkLjp+mcRK2h+IRq9
        knkYBzmA9dDxu8384RDTTOzYJAepzwF1cMCPayP9CMyo2Hj0rwxnj5JufroP/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612486674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=WTKxw3cYU9sqIcWjJRqdyEqf3tBdofU/yBSNh3t9yJc=;
        b=7W4xfBIlt1CvqgeR6h3WSqJSacQLtAwI/t6Si4jQHbblumYAxNiq5u0ZAbQjSzZdRtYSP4
        nqiM6ICD1UE4DjBA==
Date:   Thu, 04 Feb 2021 21:49:07 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 04/12] x86/apic: Split out spurious handling code
References: <20210204204903.350275743@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysvec_spurious_apic_interrupt() calls into the handling body of
__spurious_interrupt() which is not obvious as that function is declared
inside the DEFINE_IDTENTRY_IRQ(spurious_interrupt) macro.

As __spurious_interrupt() is currently always inlined this ends up with two
copies of the same code for no reason.

Split the handling function out and invoke it from both entry points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c |   31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2133,18 +2133,11 @@ void __init register_lapic_address(unsig
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
 
@@ -2179,9 +2172,23 @@ DEFINE_IDTENTRY_IRQ(spurious_interrupt)
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

