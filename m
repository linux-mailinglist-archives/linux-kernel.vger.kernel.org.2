Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4AB3681F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbhDVNyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236432AbhDVNxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:53:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7294DC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:53:19 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:53:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619099598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NW0YBRBnX9JFtYtsr1PxdO/vBUavl8Zvy/HwpNPn5Gg=;
        b=4Rk6DoEDQcIAOa0oMe1bFtyszXbvNc9rJgY6B6aHS0Z4GYcium7OzkjE0WIjNbxSdII5CV
        xV5veLjtmYt23v/Yu++krbMITUg/FLFcuiCoUOWvtKWDZaok3zzqQcq2JvOpJNrEcl9bcQ
        FtlyCHpGw5tgUNspKZiywmDj7Y1ia3eSA++RHOa0DOXkf+iuhPTqwVBJZlFGtlPObL3M6i
        c7jcZxaj+1qlSb5vw+KFelLbANZcqdnI0crG8zB4s/im8YqvxEYyHcYrZdYtgVolf66eu1
        xnhooHmx6J23eHuekUc1DTUfW1+fu2Ni+mipIhahioA6L+Mvs9tteVXFdt59ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619099598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NW0YBRBnX9JFtYtsr1PxdO/vBUavl8Zvy/HwpNPn5Gg=;
        b=IgdHz9hKGQSyB30z0+W0YnBRo/4Go1Caav698+R3Ruy8QyDp95580vwF3hwaSxBFRZMqhM
        ZN1nSk+0g5vMUsCg==
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
Message-ID: <161909959747.29796.448922731474945904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     f53dda735f4a36b8153b9b57cd141cd6de4982db
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f53dda735f4a36b8153b9b57cd141cd6de4982db
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Apr 2021 10:35:50 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 22 Apr 2021 14:45:48 +01:00

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
 
