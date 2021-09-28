Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E486841B3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhI1QcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:32:21 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:13488 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241800AbhI1QcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:32:18 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SFpceK024408;
        Tue, 28 Sep 2021 11:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=lDsgfNRJKnCcRztCgiTQv34/875GpVZYZarRaSv+m9g=;
 b=Bo78CuA8FPaKv+v++tT13xG3buhkANqIVlc6gkBvHzf2TS7tXsjU8jAb5rOslC3o6GZm
 Yez1pfRQPlH/sJe0b3969bhAMZvSRbB+s4skBArtkidmcdSMDOM8XmmlCjO7Lexe6XnC
 ctriCIYNUCt+FqGXn8ipVYwjASbJLYma3/5IfTNuSV7WmbRy63YIJG0IOMw2tKlMOXu9
 VzwSflTeKbttElo0atyiq7Cw4IjyMjn6c1dH296F8e1MM2vGCYRyTesU421Sx23ITDPx
 YrGEBPcpC1dTEhEyu23+/pKhLCq2/sutoVAY1RBfWk6AIQLS5aTkF5zfSPd2wV7Fy7yJ zQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bc62dg1y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Sep 2021 11:30:36 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 28 Sep
 2021 17:30:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 28 Sep 2021 17:30:35 +0100
Received: from algalon.ad.cirrus.com (unknown [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1BEA0B0E;
        Tue, 28 Sep 2021 16:30:35 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2] mfd: arizona: Split of_match table into I2C and SPI versions
Date:   Tue, 28 Sep 2021 17:30:35 +0100
Message-ID: <20210928163035.23960-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: _EYJtK_3Y-EHqdoDcUYL_DQOfjCo58yS
X-Proofpoint-ORIG-GUID: _EYJtK_3Y-EHqdoDcUYL_DQOfjCo58yS
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Arizona driver has both some devices which only have an I2C
interface and some which only have a SPI interface. Currently both of
these share an of_match table, but this means inapproriate compatibles
are available for each interface. Tidy this up by creating a table for
each interface listing only the appropriate compatibles.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Changes since v1:
 - Drop inappropriate fixes tag

Thanks,
Charles

 drivers/mfd/arizona-core.c | 13 -------------
 drivers/mfd/arizona-i2c.c  | 14 +++++++++++++-
 drivers/mfd/arizona-spi.c  | 13 ++++++++++++-
 drivers/mfd/arizona.h      |  2 --
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 9323b1e3a69ef..cbf1dd90b70d5 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -845,19 +845,6 @@ static int arizona_of_get_core_pdata(struct arizona *arizona)
 
 	return 0;
 }
-
-const struct of_device_id arizona_of_match[] = {
-	{ .compatible = "wlf,wm5102", .data = (void *)WM5102 },
-	{ .compatible = "wlf,wm5110", .data = (void *)WM5110 },
-	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
-	{ .compatible = "wlf,wm8997", .data = (void *)WM8997 },
-	{ .compatible = "wlf,wm8998", .data = (void *)WM8998 },
-	{ .compatible = "wlf,wm1814", .data = (void *)WM1814 },
-	{ .compatible = "wlf,wm1831", .data = (void *)WM1831 },
-	{ .compatible = "cirrus,cs47l24", .data = (void *)CS47L24 },
-	{},
-};
-EXPORT_SYMBOL_GPL(arizona_of_match);
 #else
 static inline int arizona_of_get_core_pdata(struct arizona *arizona)
 {
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 5e83b730c4ced..3ed810e81f631 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -104,11 +104,23 @@ static const struct i2c_device_id arizona_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, arizona_i2c_id);
 
+#ifdef CONFIG_OF
+const struct of_device_id arizona_i2c_of_match[] = {
+	{ .compatible = "wlf,wm5102", .data = (void *)WM5102 },
+	{ .compatible = "wlf,wm5110", .data = (void *)WM5110 },
+	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
+	{ .compatible = "wlf,wm8997", .data = (void *)WM8997 },
+	{ .compatible = "wlf,wm8998", .data = (void *)WM8998 },
+	{ .compatible = "wlf,wm1814", .data = (void *)WM1814 },
+	{},
+};
+#endif
+
 static struct i2c_driver arizona_i2c_driver = {
 	.driver = {
 		.name	= "arizona",
 		.pm	= &arizona_pm_ops,
-		.of_match_table	= of_match_ptr(arizona_of_match),
+		.of_match_table	= of_match_ptr(arizona_i2c_of_match),
 	},
 	.probe		= arizona_i2c_probe,
 	.remove		= arizona_i2c_remove,
diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index aa1d6f94ae532..9fe06dda37829 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -225,11 +225,22 @@ static const struct spi_device_id arizona_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, arizona_spi_ids);
 
+#ifdef CONFIG_OF
+const struct of_device_id arizona_spi_of_match[] = {
+	{ .compatible = "wlf,wm5102", .data = (void *)WM5102 },
+	{ .compatible = "wlf,wm5110", .data = (void *)WM5110 },
+	{ .compatible = "wlf,wm8280", .data = (void *)WM8280 },
+	{ .compatible = "wlf,wm1831", .data = (void *)WM1831 },
+	{ .compatible = "cirrus,cs47l24", .data = (void *)CS47L24 },
+	{},
+};
+#endif
+
 static struct spi_driver arizona_spi_driver = {
 	.driver = {
 		.name	= "arizona",
 		.pm	= &arizona_pm_ops,
-		.of_match_table	= of_match_ptr(arizona_of_match),
+		.of_match_table	= of_match_ptr(arizona_spi_of_match),
 		.acpi_match_table = ACPI_PTR(arizona_acpi_match),
 	},
 	.probe		= arizona_spi_probe,
diff --git a/drivers/mfd/arizona.h b/drivers/mfd/arizona.h
index 801cbbcd71cb5..66d6092d08515 100644
--- a/drivers/mfd/arizona.h
+++ b/drivers/mfd/arizona.h
@@ -28,8 +28,6 @@ extern const struct regmap_config wm8998_i2c_regmap;
 
 extern const struct dev_pm_ops arizona_pm_ops;
 
-extern const struct of_device_id arizona_of_match[];
-
 extern const struct regmap_irq_chip wm5102_aod;
 extern const struct regmap_irq_chip wm5102_irq;
 
-- 
2.11.0

