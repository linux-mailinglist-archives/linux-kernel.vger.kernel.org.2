Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B93F2D34
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbhHTNfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 09:35:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53582 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhHTNfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:35:23 -0400
Date:   Fri, 20 Aug 2021 13:34:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629466485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0s3bahhvH4Mry2JfJKxiDVBMWk8q8usPOxiMSkcYTE=;
        b=j5tsGFYJhE4dv0BahW0Pz8aE0xcaoayXyqZLWKZkG3PZYIi3fQyVekQ4frf2nP7aa9Mqul
        sR+sGhZwv42i3v4oC4X4UgBCsZBeI0E2LfJZpkqlCB9XBlOMrBw4Zq3wo6/JeOauFoahVE
        CLM5S6aqocFoIAmG5n1e2dpJrxmpFxG2f53Q1q4E9ucOY/vzW55AviIeKMu/36MqZQ+Tdr
        YP89+hLzUn+PUdcYUASrbR/jXEgsu3T3ckZlAwNY7HD+F3pms1H99NDKyFGAQmYJQped8Q
        JrWRubKI9xCu0zJyArLpvRypjkvNAnE0xFTqxWA5b/qG/SZEvxujDxifVXKYpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629466485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0s3bahhvH4Mry2JfJKxiDVBMWk8q8usPOxiMSkcYTE=;
        b=febQrq0Ugna9g4XHFvvdUbeaxarnN9uFgOMSDyx1FvpxaH7PaEo1qLvKot6uEixhfGoxaQ
        RHiQbQ5Ithn87DDQ==
From:   "irqchip-bot for Sven Peter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Fix irq_disable from
 within irq handlers
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210812100942.17206-1-sven@svenpeter.dev>
References: <20210812100942.17206-1-sven@svenpeter.dev>
MIME-Version: 1.0
Message-ID: <162946648413.25758.10370643723543390409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     60a1cd10b222e004f860d14651e80089c77e8e6b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/60a1cd10b222e004f860d14651e80089c77e8e6b
Author:        Sven Peter <sven@svenpeter.dev>
AuthorDate:    Thu, 12 Aug 2021 12:09:42 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 20 Aug 2021 14:32:33 +01:00

irqchip/apple-aic: Fix irq_disable from within irq handlers

When disable_irq_nosync for an interrupt is called from within its
interrupt handler, this interrupt is only marked as disabled with the
intention to mask it when it triggers again.
The AIC hardware however automatically masks the interrupt when it is read.
aic_irq_eoi then unmasks it again if it's not disabled *and* not masked.
This results in a state mismatch between the hardware state and the
state kept in irq_data: The hardware interrupt is masked but
IRQD_IRQ_MASKED is not set. Any further calls to unmask_irq will directly
return and the interrupt can never be enabled again.

Fix this by keeping the hardware and irq_data state in sync by unmasking in
aic_irq_eoi if and only if the irq_data state also assumes the interrupt to
be unmasked.

Fixes: 76cde2639411 ("irqchip/apple-aic: Add support for the Apple Interrupt Controller")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210812100942.17206-1-sven@svenpeter.dev
---
 drivers/irqchip/irq-apple-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index b8c06bd..6fc145a 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -226,7 +226,7 @@ static void aic_irq_eoi(struct irq_data *d)
 	 * Reading the interrupt reason automatically acknowledges and masks
 	 * the IRQ, so we just unmask it here if needed.
 	 */
-	if (!irqd_irq_disabled(d) && !irqd_irq_masked(d))
+	if (!irqd_irq_masked(d))
 		aic_irq_unmask(d);
 }
 
