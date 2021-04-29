Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E231736EAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbhD2M5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:57:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54566 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhD2M5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:57:32 -0400
Date:   Thu, 29 Apr 2021 12:56:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619701004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkdPTwzS6GeJhZZPpvn3cefE4IFChyUoGE6kAhB2BtU=;
        b=OyE848gqAIpcXVJkwB58V1+tLTwgfCtuYLOEJUtoXyhJuN5nYRmb1ycn6g7Uy2OtG6vLfM
        7K7Z1+/P8wNiKzjmU/hAFDvUnXJa0T9kMTEdDtIwBY/bYK2TZa2FUZvFyeiDAYOZFQU5RJ
        hli+QZAMu4rT8KdP3uo2k5u61YsqhtHCXD+B5BIVen16bgPowgJhiXjdWyoX4h1z09Czum
        aPWJgBKBalMsl/K/uJtiW1qiD4qlUzbciNImuiiDZYhZ2VgYSLunOQwPQhiaV9/IxLYu/+
        cp2dEtaqcWf6isNgOZgasN2NThevcTXCLwCnpmbcc66Xhp3nxCuWDQu9ZM/2Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619701004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rkdPTwzS6GeJhZZPpvn3cefE4IFChyUoGE6kAhB2BtU=;
        b=z1X+X37CJBmz7/1L7tzXneBv653+1w4qiuIdk9cXdWGipn1hKhvqCICw7b6BfDyhYMcart
        JSKzav68toA8pXCw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ARM: PXA: Fix cplds irqdesc allocation
 when using legacy mode
Cc:     Guenter Roeck <linux@roeck-us.net>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20210426223942.GA213931@roeck-us.net>
References: <20210426223942.GA213931@roeck-us.net>
MIME-Version: 1.0
Message-ID: <161970100394.29796.15958780952771731304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     33aa3698bac9748ff40575ec342322c04c19b750
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/33aa3698bac9748ff40575ec342322c04c19b750
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 27 Apr 2021 09:00:28 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 29 Apr 2021 13:52:30 +01:00

ARM: PXA: Fix cplds irqdesc allocation when using legacy mode

The Mainstone PXA platform uses CONFIG_SPARSE_IRQ, and thus we
cannot rely on the irq descriptors to be readilly allocated
before creating the irqdomain in legacy mode. The kernel then
complains loudly about not being able to associate the interrupt
in the domain -- can't blame it.

Fix it by allocating the irqdescs upfront in the legacy case.

Fixes: b68761da0111 ("ARM: PXA: Kill use of irq_create_strict_mappings()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210426223942.GA213931@roeck-us.net
---
 arch/arm/mach-pxa/pxa_cplds_irqs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index ec0d9b0..bddfc7c 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -121,8 +121,13 @@ static int cplds_probe(struct platform_device *pdev)
 		return fpga->irq;
 
 	base_irq = platform_get_irq(pdev, 1);
-	if (base_irq < 0)
+	if (base_irq < 0) {
 		base_irq = 0;
+	} else {
+		ret = devm_irq_alloc_descs(&pdev->dev, base_irq, base_irq, CPLDS_NB_IRQ, 0);
+		if (ret < 0)
+			return ret;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	fpga->base = devm_ioremap_resource(&pdev->dev, res);
