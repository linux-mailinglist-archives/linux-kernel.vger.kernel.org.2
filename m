Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029413A4375
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhFKN44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:56:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhFKN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:56:34 -0400
Date:   Fri, 11 Jun 2021 13:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623419675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HoL2ySp8w8o8sZrjWgTnP6GSCUTGnGHxfIhwVCErAIg=;
        b=Mfn/22BFcFYstffwuFSenbQRBkzyphOHwj4mWwrY4gVmswiOB591mgvrxM5SM7ZKBjabyN
        UqrntbXJJwnvluQFrveDIeUFzpe0BAJN9CE2yVv3tvspvEuQ0HrSOlsbMgDqJtugkhr3/u
        8lUIREb2AlVa8KPLGJkfA03n+eR2u54RTYGgCKA+SJWZBN7At4lGJiyAvcSYmj9N5Fx7u4
        CBc7sHHEl8usn6UPOXRaemdwB+kdXw8+4iV5tn8LWzr+55KJZ9Guc27K5qyxviEKhQzym1
        qcXa3AEQoosMyspk9WW+WJLMa90AW9mwUhHVIpY/mHnyuc63yhDejHIxllJNtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623419675;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HoL2ySp8w8o8sZrjWgTnP6GSCUTGnGHxfIhwVCErAIg=;
        b=PsVwHD6klcUFElvEJHaBB3jdO4LfcLqUumueww4tQuKWAf+GH+oS72SIKyJsWLYsB8QGHY
        egtrGwndzGjer5CA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/nvic: Convert from handle_IRQ()
 to handle_domain_irq()
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162341967525.19906.16186149196707834208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9e027dd979beca41cd85f4e971d184fe0ffcff3c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9e027dd979beca41cd85f4e971d184fe0ffcff3c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 12 May 2021 13:46:05 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Jun 2021 13:09:19 +01:00

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
