Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37F1388BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbhESKnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:43:39 -0400
Received: from foss.arm.com ([217.140.110.172]:58834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232768AbhESKnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AD601424;
        Wed, 19 May 2021 03:42:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E0323F719;
        Wed, 19 May 2021 03:42:10 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v6 02/17] mfd: axp20x: Allow AXP 806 chips without interrupt lines
Date:   Wed, 19 May 2021 11:41:37 +0100
Message-Id: <20210519104152.21119-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210519104152.21119-1-andre.przywara@arm.com>
References: <20210519104152.21119-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the AXP chip requires to have its IRQ line connected to some
interrupt controller, and will fail probing when this is not the case.

On a new Allwinner SoC (H616) there is no NMI pin anymore, and at
least one board does not connect the AXP's IRQ pin to anything else,
so the interrupt functionality of the AXP chip is simply not available.

Check whether the interrupt line number returned by the platform code is
valid, before trying to register the irqchip. If not, we skip this
registration, to avoid the driver to bail out completely.
Also we need to skip the power key functionality, as this relies on
a valid IRQ as well.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/mfd/axp20x.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 3eae04e24ac8..4145a38b3890 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -884,8 +884,13 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_irq_chip = &axp803_regmap_irq_chip;
 		break;
 	case AXP806_ID:
+		/*
+		 * Don't register the power key part if in slave mode or
+		 * if there is no interrupt line.
+		 */
 		if (of_property_read_bool(axp20x->dev->of_node,
-					  "x-powers,self-working-mode")) {
+					  "x-powers,self-working-mode") &&
+		    axp20x->irq > 0) {
 			axp20x->nr_cells = ARRAY_SIZE(axp806_self_working_cells);
 			axp20x->cells = axp806_self_working_cells;
 		} else {
@@ -959,12 +964,17 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 				     AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE);
 	}
 
-	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
-			  IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
-			   -1, axp20x->regmap_irq_chip, &axp20x->regmap_irqc);
-	if (ret) {
-		dev_err(axp20x->dev, "failed to add irq chip: %d\n", ret);
-		return ret;
+	/* Only if there is an interrupt line connected towards the CPU. */
+	if (axp20x->irq > 0) {
+		ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
+				IRQF_ONESHOT | IRQF_SHARED | axp20x->irq_flags,
+				-1, axp20x->regmap_irq_chip,
+				&axp20x->regmap_irqc);
+		if (ret) {
+			dev_err(axp20x->dev, "failed to add irq chip: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
-- 
2.17.5

