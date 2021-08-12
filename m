Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49713EA316
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbhHLKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:47:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57672 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbhHLKr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:26 -0400
Date:   Thu, 12 Aug 2021 10:46:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XTmmLrkthaosmLsyabarrDlmL0hAC0OyzTU3rZze8Oo=;
        b=ovYKGRS3fvQOG9ZM6RjPPSxec6YjAS05z7+cyClUcsg+qEDaU4cI93b+sTRM/JGKZLCuaw
        WR5NsOGk9OdnROSct+qB7haHtpeCGJAHdKQpC9l767UnUJEXTJ7ggjNWywa3MWcLkJHJFR
        chssW74Ksj8+VWZPi6HOSskoNX81BtCWvnWOvg3xwFjTnIAwqLpMl2kdGsc3NdwxQ7Uo2u
        qNhiFKmzsW7+fh8gFVsSNXtZObPEcTt1RHgMWoPP4H8ZZpi+iFaGvmsMxzNlb/IwDYJEDL
        x/OWhAfZHTwSpNkifSAC09Nu269EPXrEStXepjTIPFXMdtut78DWMGpjzEBt1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XTmmLrkthaosmLsyabarrDlmL0hAC0OyzTU3rZze8Oo=;
        b=ewE+0nlgNjx8MkgLi1mxAaFP0U69Aj86zYJMOMiM0DpJScpuqX9xiSFZsqZgCBI5INlblF
        O4+LAf0XS5FlDyDg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] SH: Bulk conversion to
 generic_handle_domain_irq()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162876521952.395.13922685043652970091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2e0e0ff41147ee925972dfdf9128635c64c7ee54
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2e0e0ff41147ee925972dfdf9128635c64c7ee54
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 04 May 2021 17:42:18 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 11:39:40 +01:00

SH: Bulk conversion to generic_handle_domain_irq()

Wherever possible, replace constructs that match either
generic_handle_irq(irq_find_mapping()) or
generic_handle_irq(irq_linear_revmap()) to a single call to
generic_handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/sh/boards/mach-se/7343/irq.c  | 2 +-
 arch/sh/boards/mach-se/7722/irq.c  | 2 +-
 arch/sh/boards/mach-x3proto/gpio.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 1aedbfe..f9f3b14 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -38,7 +38,7 @@ static void se7343_irq_demux(struct irq_desc *desc)
 	mask = ioread16(se7343_irq_regs + PA_CPLD_ST_REG);
 
 	for_each_set_bit(bit, &mask, SE7343_FPGA_IRQ_NR)
-		generic_handle_irq(irq_linear_revmap(se7343_irq_domain, bit));
+		generic_handle_domain_irq(se7343_irq_domain, bit);
 
 	chip->irq_unmask(data);
 }
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index 6d34592..efa96ed 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -37,7 +37,7 @@ static void se7722_irq_demux(struct irq_desc *desc)
 	mask = ioread16(se7722_irq_regs + IRQ01_STS_REG);
 
 	for_each_set_bit(bit, &mask, SE7722_FPGA_IRQ_NR)
-		generic_handle_irq(irq_linear_revmap(se7722_irq_domain, bit));
+		generic_handle_domain_irq(se7722_irq_domain, bit);
 
 	chip->irq_unmask(data);
 }
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index efc992f..f82d3a6 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -68,7 +68,7 @@ static void x3proto_gpio_irq_handler(struct irq_desc *desc)
 
 	mask = __raw_readw(KEYDETR);
 	for_each_set_bit(pin, &mask, NR_BASEBOARD_GPIOS)
-		generic_handle_irq(irq_linear_revmap(x3proto_irq_domain, pin));
+		generic_handle_domain_irq(x3proto_irq_domain, pin);
 
 	chip->irq_unmask(data);
 }
