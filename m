Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3C3682FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhDVPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:08:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39138 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbhDVPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:08:12 -0400
Date:   Thu, 22 Apr 2021 15:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619104057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vse8CPZ4D4/3toiwG7dugP4TGCliPX6mGrmWayk4m4Y=;
        b=RDiaVHXAnr/NfFs6bu/S6cnzM5UbzfQI66z8bvuy+cFhyQI9KZqpbTwWvEswukSHsgApp5
        lt1YVTt/UYulOV/SrCP0F/4ccjqIiJAMtqjrmYn6A4a/2rdQjUl06o7WPImh9cqXBSPuOI
        tlInCqrMXRs3HGpCK5lLpFfqoewdl7QG4JCjW52DOM/4XHJiq7QlM/0M2UCgh0KJgxWjpv
        pMbjpkhrXGnkKhbxY1Xm3Y2tUDZC79cCUUkkmF81iS1U6G+B563HkIzd1bJo3pReg5LUQD
        3wl1Np3mS73YT44ePDNIQCG3n8/+c/tEhMAzoXqGzLjdEt9vd1ZxqvpcTU9nKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619104057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vse8CPZ4D4/3toiwG7dugP4TGCliPX6mGrmWayk4m4Y=;
        b=Xo9NrJRriQFUqSs6DLgcP2OiFK4mYFa/uE1gXSyNxFyNmiwKrS5UjK0IdRrDQBhe0wiJlF
        G0x/UH72WntPO5AQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ARM: PXA: Kill use of
 irq_create_strict_mappings()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210406093557.1073423-3-maz@kernel.org>
References: <20210406093557.1073423-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <161910405667.29796.6261741505534686018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     b68761da01114a64b9c521975c3bca6d10eeb950
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b68761da01114a64b9c521975c3bca6d10eeb950
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Apr 2021 10:35:50 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 15:55:21 +01:00

ARM: PXA: Kill use of irq_create_strict_mappings()

irq_create_strict_mappings() is a poor way to allow the use of
a linear IRQ domain as a legacy one. Let's be upfront about
it and use a legacy domain when appropriate.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210406093557.1073423-3-maz@kernel.org
---
 arch/arm/mach-pxa/pxa_cplds_irqs.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index 45c19ca..ec0d9b0 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -147,22 +147,20 @@ static int cplds_probe(struct platform_device *pdev)
 	}
 
 	irq_set_irq_wake(fpga->irq, 1);
-	fpga->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
-					       CPLDS_NB_IRQ,
-					       &cplds_irq_domain_ops, fpga);
+	if (base_irq)
+		fpga->irqdomain = irq_domain_add_legacy(pdev->dev.of_node,
+							CPLDS_NB_IRQ,
+							base_irq, 0,
+							&cplds_irq_domain_ops,
+							fpga);
+	else
+		fpga->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
+							CPLDS_NB_IRQ,
+							&cplds_irq_domain_ops,
+							fpga);
 	if (!fpga->irqdomain)
 		return -ENODEV;
 
-	if (base_irq) {
-		ret = irq_create_strict_mappings(fpga->irqdomain, base_irq, 0,
-						 CPLDS_NB_IRQ);
-		if (ret) {
-			dev_err(&pdev->dev, "couldn't create the irq mapping %d..%d\n",
-				base_irq, base_irq + CPLDS_NB_IRQ);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
