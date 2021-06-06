Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BC639D100
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFFT21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:28:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:28:25 -0400
Date:   Sun, 06 Jun 2021 19:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623007594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4E3ueUiWYkqfDHgMawcLyMAQE84TBVIhzeOZP9gRehc=;
        b=o11dnlzrQ2H2cBf/LtSwX4TKbb/yZzYsYG8qdHTqvwtfm62l2XpfdKokiRd7b9DPo88vXY
        qhwC2DObT9V9vQRrOj2TWysfYBH1tfYP+CDuUMb2BCq/b4Z3prEdRyW4ATmgvmabbfs+3h
        iDOvttx6f71/IS2YZxylTlo8GzOnzH9dqgHdmJQ4iB64jJ2ujFTA3hEWdgIgNehOCD8ARe
        e8PJM1DRX0WRAh5WT/M+GJgGfsR2AQBZKAGxJwTyTjsNjTzl/6Y+xIjC5DIWBEwQjwAa+b
        sQ00UmufAa8AQRKH0jiPuuFntd9Z2gO6Z/hC9OhrXWAQ6HUF8XrQFNoQzrj0Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623007594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4E3ueUiWYkqfDHgMawcLyMAQE84TBVIhzeOZP9gRehc=;
        b=1bw0MlSj3oPbxWdGbDz9NMfVrbekuiMMLM8PNN8yl3nScupx3SeTh72P86g+BK6XgeucCD
        7fKMnqv1wz5NDrAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] fixup! irqchip: Bulk conversion to
 generic_handle_domain_irq()
Cc:     maz@kernel.org, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162300759381.29796.15824095054552048651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     70d49fc8ebd2fabcb223288ec8a9f2c58ceb3407
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/70d49fc8ebd2fabcb223288ec8a9f2c58ceb3407
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 06 Jun 2021 19:28:32 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Jun 2021 19:28:32 +01:00

fixup! irqchip: Bulk conversion to generic_handle_domain_irq()
---
 drivers/irqchip/irq-xilinx-intc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 875ff52..356a597 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -150,7 +150,6 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct xintc_irq_chip *irqc;
-	u32 pending;
 
 	irqc = irq_data_get_irq_handler_data(&desc->irq_data);
 	chained_irq_enter(chip, desc);
