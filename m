Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A322308DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhA2Tz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233116AbhA2Tx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:53:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 626F164E16;
        Fri, 29 Jan 2021 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611949925;
        bh=7JLtK1ZG6Fg/i5KmUg42DfpdW1WhNDzqH82CShEOGJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBDHKe/ZX896ep26XLUYFGFSV3wwfO1AV0TH7Yxo99eIp6tq6pCH00F5RNPskqD3/
         KOq4UUrtU2C9cpPlworWicMar/qjpxqCUXCq3VaC+GMu8x0x1m4aEIXwPjVnNW1UVc
         TTEr1QmOgF4rI93b+iU4pu6tsZB1o6+Ibxa7TcyAYjUNWW9whfxDzJVdcArup3PJNd
         PHJZSxl/GryiCWPKBYbAJGAyj+t6lVrNSVBvomv4hfpcj0oaKzbz4FRXrD1tnXxYMx
         VJgJl8sVPjYXzf5bhH9Jee1LVZwUgsxciPKprP+FHoZoilSQC0khJ8X2g1VuZQTJeN
         szAHihamZ1rgg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l5ZoJ-007Wjr-5c; Fri, 29 Jan 2021 20:52:03 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 08/14] staging: hikey9xx: hi6421-spmi-pmic: document registers
Date:   Fri, 29 Jan 2021 20:51:54 +0100
Message-Id: <10f52ec0a8346fb883245344886c44714c859cd1.1611949675.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611949675.git.mchehab+huawei@kernel.org>
References: <cover.1611949675.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clearer about how the IRQ registers are filled by adding
a table with them, with two macros used to calculate the mask
register.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 39 +++++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index f2af1760add9..9c10f7c4e7c9 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -38,10 +38,6 @@ enum hi6421_spmi_pmic_irq_list {
 
 #define HISI_IRQ_ARRAY			2
 #define HISI_IRQ_NUM			(HISI_IRQ_ARRAY * 8)
-#define HISI_IRQ_MASK			GENMASK(1, 0)
-
-#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
-#define SOC_PMIC_IRQ0_ADDR		0x0212
 
 #define HISI_IRQ_KEY_NUM		0
 
@@ -49,6 +45,36 @@ enum hi6421_spmi_pmic_irq_list {
 #define HISI_IRQ_KEY_VALUE		(BIT(POWERKEY_DOWN) | BIT(POWERKEY_UP))
 #define HISI_MASK			GENMASK(HISI_BITS - 1, 0)
 
+/*
+ * The IRQs are mapped as:
+ *
+ * 	======================  =============   ============	=====
+ *	IRQ			MASK REGISTER 	IRQ REGISTER	BIT
+ * 	======================  =============   ============	=====
+ *	OTMP			0x0202		0x212		bit 0
+ *	VBUS_CONNECT		0x0202		0x212		bit 1
+ *	VBUS_DISCONNECT		0x0202		0x212		bit 2
+ *	ALARMON_R		0x0202		0x212		bit 3
+ *	HOLD_6S			0x0202		0x212		bit 4
+ *	HOLD_1S			0x0202		0x212		bit 5
+ *	POWERKEY_UP		0x0202		0x212		bit 6
+ *	POWERKEY_DOWN		0x0202		0x212		bit 7
+ *
+ *	OCP_SCP_R		0x0203		0x213		bit 0
+ *	COUL_R			0x0203		0x213		bit 1
+ *	SIM0_HPD_R		0x0203		0x213		bit 2
+ *	SIM0_HPD_F		0x0203		0x213		bit 3
+ *	SIM1_HPD_R		0x0203		0x213		bit 4
+ *	SIM1_HPD_F		0x0203		0x213		bit 5
+ * 	======================  =============   ============	=====
+ */
+#define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
+#define SOC_PMIC_IRQ0_ADDR		0x0212
+
+#define IRQ_MASK_REGISTER(irq_data)	(SOC_PMIC_IRQ_MASK_0_ADDR + \
+					 (irqd_to_hwirq(irq_data) >> 3))
+#define IRQ_MASK_BIT(irq_data)		BIT(irqd_to_hwirq(irq_data) & 0x07)
+
 static const struct mfd_cell hi6421v600_devs[] = {
 	{ .name = "hi6421v600-regulator", },
 };
@@ -89,13 +115,12 @@ static void hi6421_spmi_irq_mask(struct irq_data *d)
 	unsigned int data;
 	u32 offset;
 
-	offset = (irqd_to_hwirq(d) >> HISI_IRQ_MASK);
-	offset += SOC_PMIC_IRQ_MASK_0_ADDR;
+	offset = IRQ_MASK_REGISTER(d);
 
 	spin_lock_irqsave(&ddata->lock, flags);
 
 	regmap_read(ddata->regmap, offset, &data);
-	data |= (1 << (irqd_to_hwirq(d) & 0x07));
+	data |= IRQ_MASK_BIT(d);
 	regmap_write(ddata->regmap, offset, data);
 
 	spin_unlock_irqrestore(&ddata->lock, flags);
-- 
2.29.2

