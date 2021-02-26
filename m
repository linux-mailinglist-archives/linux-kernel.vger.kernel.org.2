Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C89326413
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhBZO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:29:54 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:55741 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229949AbhBZO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:29:45 -0500
Received: from [77.244.183.192] (port=64786 helo=melee.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lFe73-001EWE-GE; Fri, 26 Feb 2021 15:29:01 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mfd: lp87565: handle optional reset pin
Date:   Fri, 26 Feb 2021 15:28:52 +0100
Message-Id: <20210226142852.19632-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210226142852.19632-1-luca@lucaceresoli.net>
References: <20210226142852.19632-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optionally handle the NRST pin (active low reset) in order to start from a
known state during boot and to shut down the chip when rebooting.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
---
 drivers/mfd/lp87565.c       | 27 +++++++++++++++++++++++++++
 include/linux/mfd/lp87565.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 9c21483d9653..a52ab76febb3 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -5,6 +5,7 @@
  * Author: Keerthy <j-keerthy@ti.com>
  */
 
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
@@ -64,6 +65,24 @@ static int lp87565_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	lp87565->reset_gpio = devm_gpiod_get_optional(lp87565->dev, "reset",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(lp87565->reset_gpio)) {
+		ret = PTR_ERR(lp87565->reset_gpio);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+	}
+
+	if (lp87565->reset_gpio) {
+		gpiod_set_value_cansleep(lp87565->reset_gpio, 1);
+		/* The minimum assertion time is undocumented, just guess */
+		usleep_range(2000, 4000);
+
+		gpiod_set_value_cansleep(lp87565->reset_gpio, 0);
+		/* Min 1.2 ms before first I2C transaction */
+		usleep_range(1500, 3000);
+	}
+
 	ret = regmap_read(lp87565->regmap, LP87565_REG_OTP_REV, &otpid);
 	if (ret) {
 		dev_err(lp87565->dev, "Failed to read OTP ID\n");
@@ -83,6 +102,13 @@ static int lp87565_probe(struct i2c_client *client,
 				    NULL, 0, NULL);
 }
 
+static void lp87565_shutdown(struct i2c_client *client)
+{
+	struct lp87565 *lp87565 = i2c_get_clientdata(client);
+
+	gpiod_set_value_cansleep(lp87565->reset_gpio, 1);
+}
+
 static const struct i2c_device_id lp87565_id_table[] = {
 	{ "lp87565-q1", 0 },
 	{ },
@@ -95,6 +121,7 @@ static struct i2c_driver lp87565_driver = {
 		.of_match_table = of_lp87565_match_table,
 	},
 	.probe = lp87565_probe,
+	.shutdown = lp87565_shutdown,
 	.id_table = lp87565_id_table,
 };
 module_i2c_driver(lp87565_driver);
diff --git a/include/linux/mfd/lp87565.h b/include/linux/mfd/lp87565.h
index 94cb581af34b..4c895072d91b 100644
--- a/include/linux/mfd/lp87565.h
+++ b/include/linux/mfd/lp87565.h
@@ -252,5 +252,6 @@ struct lp87565 {
 	u8 rev;
 	u8 dev_type;
 	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
 };
 #endif /* __LINUX_MFD_LP87565_H */
-- 
2.30.0

