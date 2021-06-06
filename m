Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A712639CF10
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhFFMpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFFMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5581C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 05:43:48 -0700 (PDT)
Date:   Sun, 06 Jun 2021 12:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vrkx0yOEe3xuCukVi7PoyqMjLU734/aFqOpUvdguwvc=;
        b=Znd4ymroJUvTWFJjH7vpSX8TSUabVY9GQYOn6IHRsQkGAUehqQo9lBSQBcsjvGc+sCdewl
        PhgnBtNrBGb7h5vFWAud8ybC51IHKsJzon3+gB7NWUX5ie9b8YoQZQzvll1uxtGXuBrVp9
        QWuvCCYuMNPhylzLHDA8XdB1+Hr5MgiDJrXIu0qb8a2gYVwMmxZ0fu7jV/+vM6YlL4U8nh
        +YjzhoBIArnDwHNcY48O6TK7MVJQbhkkmc+3jp8U8Dq43mG/e1tLM5T4AVDEmEpmxAKjYB
        nCwQSrF2t+OOTABiX6rEPJcGjPdwpB3cTXyRGzJWZ7cM/hVaeLlv9ELmUO8QBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vrkx0yOEe3xuCukVi7PoyqMjLU734/aFqOpUvdguwvc=;
        b=WSUCCB4a5tnT7O1W9LX31yjZvWJrvPjfSD8qynB6bsUxmEvayTmKmVxyv8uHEGRvz4GG0L
        b3aSrq6fdNOnhVAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/nvic: Convert from handle_IRQ()
 to handle_domain_irq()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298342602.29796.4230154738072328248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ebae7259a5ee70c2ac31ed021875818f79723859
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ebae7259a5ee70c2ac31ed021875818f79723859
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 12 May 2021 13:46:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 17:35:36 +01:00

irqchip/nvic: Convert from handle_IRQ() to handle_domain_irq()

Given that the nvic driver is fully irqdomain aware, there is no
reason for it to use the arch-specific handle_IRQ(), and it can
be moved over to handle_domain_irq().

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-nvic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index f747e22..b31c4cf 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -40,9 +40,7 @@ static struct irq_domain *nvic_irq_domain;
 asmlinkage void __exception_irq_entry
 nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 {
-	unsigned int irq = irq_linear_revmap(nvic_irq_domain, hwirq);
-
-	handle_IRQ(irq, regs);
+	handle_domain_irq(nvic_irq_domain, hwirq, regs);
 }
 
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
