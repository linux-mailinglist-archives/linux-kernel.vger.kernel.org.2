Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D82B45B7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhKXJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 04:46:09 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:60439 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbhKXJqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:46:06 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1AO9Igj2077922;
        Wed, 24 Nov 2021 17:18:42 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Nov
 2021 17:42:50 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <eajames@linux.ibm.com>, <tglx@linutronix.de>, <maz@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH] irqchip: Replace update_bits with write_bits.
Date:   Wed, 24 Nov 2021 17:43:48 +0800
Message-ID: <20211124094348.11621-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1AO9Igj2077922
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt status bits are cleared by writing 1, we should force a
write to clear the interrupt without checking if the value has changed.

Fixes: 04f605906ff0 ("irqchip: Add Aspeed SCU interrupt controller")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index f3c6855a4cef..18b77c3e6db4 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -76,8 +76,8 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 		generic_handle_domain_irq(scu_ic->irq_domain,
 					  bit - scu_ic->irq_shift);
 
-		regmap_update_bits(scu_ic->scu, scu_ic->reg, mask,
-				   BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
+				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.25.1

