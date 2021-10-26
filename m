Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1976643AFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 12:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhJZKSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 06:18:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhJZKSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 06:18:30 -0400
Date:   Tue, 26 Oct 2021 10:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635243366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8EB/xFbFI63YHUEjJccJODTqBIopByeoxdEKj92YPo4=;
        b=2xICGNZ7XJiTN7GaYWzLutusy6Kuxyv0ewYcToPjWVY8NTfjDZlILtmfNMl1CGFatipgIg
        7Aq5sAqdDzOSarxstBRxdUsnsRap1bAWjx5EM9yYJevrwdLkbTthkGODZ3151CN1QwXll1
        kZdzYOvRTmYytzBu4iekbQ7ztKBSYkHu9TVtBNcsmwCwwap8iHSy+v9uOLfFjDC66jx3wK
        1Dm66qmRMZFg81UQBvGu9Ogd07VlZTv5CwYrwmTYQvs8Tn6K8p5mftM+x0RCYtnQcaksRb
        zf5lXIudTvng+D1NxyrgFxoH1uXcZ+9IpawXdGtui8uazI9CU6gmiPhZU2kA8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635243366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8EB/xFbFI63YHUEjJccJODTqBIopByeoxdEKj92YPo4=;
        b=Bnqdv6gCgY3ZefyFpowcKC+94nk9Sc3XChDc4UBcT0yZ+tAMjTY8epQ2U8Bai43UYEFWT8
        uVubc9DFTzf1ISBA==
From:   "irqchip-bot for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq: arc: avoid CONFIG_HANDLE_DOMAIN_IRQ
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineet Gupta <vgupta@kernel.org>
MIME-Version: 1.0
Message-ID: <163524336530.626.3819191665877459755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e54957fa3b3b374c63c66f60a8236dd95cf5e2be
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e54957fa3b3b374c63c66f60a8236dd95cf5e2be
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 19 Oct 2021 12:26:41 +01:00
Committer:     Mark Rutland <mark.rutland@arm.com>
CommitterDate: Mon, 25 Oct 2021 10:05:28 +01:00

irq: arc: avoid CONFIG_HANDLE_DOMAIN_IRQ

In preparation for removing HANDLE_DOMAIN_IRQ, have arch/arc perform all
the necessary IRQ entry accounting in its entry code.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig      |  1 -
 arch/arc/kernel/irq.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 3a5a80f..b4ae605 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -40,7 +40,6 @@ config ARC
 	select HAVE_KRETPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_PERF_EVENTS
-	select HANDLE_DOMAIN_IRQ
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select OF
diff --git a/arch/arc/kernel/irq.c b/arch/arc/kernel/irq.c
index ef909dd..dd09b58 100644
--- a/arch/arc/kernel/irq.c
+++ b/arch/arc/kernel/irq.c
@@ -6,6 +6,8 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <asm/mach_desc.h>
+
+#include <asm/irq_regs.h>
 #include <asm/smp.h>
 
 /*
@@ -39,5 +41,11 @@ void __init init_IRQ(void)
  */
 void arch_do_IRQ(unsigned int hwirq, struct pt_regs *regs)
 {
-	handle_domain_irq(NULL, hwirq, regs);
+	struct pt_regs *old_regs;
+
+	irq_enter();
+	old_regs = set_irq_regs(regs);
+	generic_handle_domain_irq(NULL, hwirq);
+	set_irq_regs(old_regs);
+	irq_exit();
 }
