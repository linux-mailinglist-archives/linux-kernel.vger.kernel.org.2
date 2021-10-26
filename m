Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC443AFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhJZKSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60714 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbhJZKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:25 -0400
Date:   Tue, 26 Oct 2021 10:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9BCr3M45nzBab9Unh1IfzXkeT7tYIdOqMNbyPX1KmNQ=;
        b=1ha1nahm7Kcuywt9rtYWlR0CjANegjip6lMoMq+r6aPYSxNWBTl+SiIEXcL2qX2x6KvGv/
        Wtiqu42RDDocca5JbN1ctWm0T1qOWXuK88Uc6snMfxEZrJ6lHy/OHIoFF5O6Sbu8+P9se7
        LzOHi4i5z4alFGgme9Ma1TC9yepFY+Ask/lYIYRRx4tnN5B8OKBf/6h+QwEhvWqgM/j8L/
        Wvi1c0ecC8jLInRYOOafQXcJXj6/dWgHpdQzbuyaqalWbEo7YFfLu/vxHEcDNpkcQgLX+X
        5vlnhNKIV1jcLqunIg3K3JsaxnAr2A0NO82B37ERCOgCw2nse91nsjjR3xacyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9BCr3M45nzBab9Unh1IfzXkeT7tYIdOqMNbyPX1KmNQ=;
        b=SYBthGUjNxx3LEuV39QPCNTjJqSBXTlAwuTbF99a7asioqPYuaHXUJuaxW5Vcavnlykud7
        ARwMH1zxMI8z6dDA==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: csky: perform irqentry in entry code
Cc:     Mark Rutland <mark.rutland@arm.com>, Guo Ren <guoren@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Message-ID: <163524335971.626.2296372899853325797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     287232987f0ebb29f68cfab13625017bbfb38adc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/287232987f0ebb29f68cfab13625017bbfb38adc
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 20 Oct 2021 11:00:46 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Tue, 26 Oct 2021 10:13:27 +01:00

irq: csky: perform irqentry in entry code

In preparation for removing HANDLE_DOMAIN_IRQ_IRQENTRY, have arch/csky
perform all the irqentry accounting in its entry code. As arch/csky uses
GENERIC_IRQ_MULTI_HANDLER, we can use generic_handle_arch_irq() to do
so.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/csky/Kconfig        | 1 -
 arch/csky/kernel/entry.S | 2 +-
 arch/csky/kernel/irq.c   | 5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 45f03f6..9d4d898 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -18,7 +18,6 @@ config CSKY
 	select DMA_DIRECT_REMAP
 	select IRQ_DOMAIN
 	select HANDLE_DOMAIN_IRQ
-	select HANDLE_DOMAIN_IRQ_IRQENTRY
 	select DW_APB_TIMER_OF
 	select GENERIC_IOREMAP
 	select GENERIC_LIB_ASHLDI3
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 00e3c8e..a4ababf 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -249,7 +249,7 @@ ENTRY(csky_irq)
 
 
 	mov	a0, sp
-	jbsr	csky_do_IRQ
+	jbsr	generic_handle_arch_irq
 
 	jmpi	ret_from_exception
 
diff --git a/arch/csky/kernel/irq.c b/arch/csky/kernel/irq.c
index 03a1930..fcdaf31 100644
--- a/arch/csky/kernel/irq.c
+++ b/arch/csky/kernel/irq.c
@@ -15,8 +15,3 @@ void __init init_IRQ(void)
 	setup_smp_ipi();
 #endif
 }
-
-asmlinkage void __irq_entry csky_do_IRQ(struct pt_regs *regs)
-{
-	handle_arch_irq(regs);
-}
