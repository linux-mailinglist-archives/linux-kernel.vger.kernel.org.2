Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE640F861
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbhIQMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:54:55 -0400
Received: from mx24.baidu.com ([111.206.215.185]:45370 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244648AbhIQMyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:54:54 -0400
Received: from BJHW-Mail-Ex15.internal.baidu.com (unknown [10.127.64.38])
        by Forcepoint Email with ESMTPS id B0902B2139210E719B97;
        Fri, 17 Sep 2021 20:53:30 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 17 Sep 2021 20:53:30 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 17 Sep 2021 20:53:29 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] video: backlight: Make use of the helper function dev_err_probe()
Date:   Fri, 17 Sep 2021 20:53:23 +0800
Message-ID: <20210917125324.18031-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2021-09-17 20:53:30:693
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
Using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: backlight patches are handled in one

 drivers/video/backlight/bd6107.c      | 16 +++++--------
 drivers/video/backlight/l4f00242t03.c | 34 ++++++++++-----------------
 2 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 515184fbe33a..e21b793302a2 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -120,7 +120,6 @@ static int bd6107_probe(struct i2c_client *client,
 	struct backlight_device *backlight;
 	struct backlight_properties props;
 	struct bd6107 *bd;
-	int ret;
 
 	if (pdata == NULL) {
 		dev_err(&client->dev, "No platform data\n");
@@ -148,11 +147,9 @@ static int bd6107_probe(struct i2c_client *client,
 	 * the reset.
 	 */
 	bd->reset = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(bd->reset)) {
-		dev_err(&client->dev, "unable to request reset GPIO\n");
-		ret = PTR_ERR(bd->reset);
-		return ret;
-	}
+	if (IS_ERR(bd->reset))
+		return dev_err_probe(&client->dev, PTR_ERR(bd->reset),
+				     "unable to request reset GPIO\n");
 
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_RAW;
@@ -164,10 +161,9 @@ static int bd6107_probe(struct i2c_client *client,
 					      dev_name(&client->dev),
 					      &bd->client->dev, bd,
 					      &bd6107_backlight_ops, &props);
-	if (IS_ERR(backlight)) {
-		dev_err(&client->dev, "failed to register backlight\n");
-		return PTR_ERR(backlight);
-	}
+	if (IS_ERR(backlight))
+		return dev_err_probe(&client->dev, PTR_ERR(backlight),
+				     "failed to register backlight\n");
 
 	backlight_update_status(backlight);
 	i2c_set_clientdata(client, backlight);
diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
index 46f97d1c3d21..8d81d4dec3c6 100644
--- a/drivers/video/backlight/l4f00242t03.c
+++ b/drivers/video/backlight/l4f00242t03.c
@@ -179,37 +179,29 @@ static int l4f00242t03_probe(struct spi_device *spi)
 	priv->spi = spi;
 
 	priv->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(priv->reset)) {
-		dev_err(&spi->dev,
-			"Unable to get the lcd l4f00242t03 reset gpio.\n");
-		return PTR_ERR(priv->reset);
-	}
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->reset),
+				     "Unable to get the lcd l4f00242t03 reset gpio.\n");
 	gpiod_set_consumer_name(priv->reset, "lcd l4f00242t03 reset");
 
 	priv->enable = devm_gpiod_get(&spi->dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->enable)) {
-		dev_err(&spi->dev,
-			"Unable to get the lcd l4f00242t03 data en gpio.\n");
-		return PTR_ERR(priv->enable);
-	}
+	if (IS_ERR(priv->enable))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->enable),
+				     "Unable to get the lcd l4f00242t03 data en gpio.\n");
 	gpiod_set_consumer_name(priv->enable, "lcd l4f00242t03 data enable");
 
 	priv->io_reg = devm_regulator_get(&spi->dev, "vdd");
-	if (IS_ERR(priv->io_reg)) {
-		dev_err(&spi->dev, "%s: Unable to get the IO regulator\n",
-		       __func__);
-		return PTR_ERR(priv->io_reg);
-	}
+	if (IS_ERR(priv->io_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->io_reg),
+				     "%s: Unable to get the IO regulator\n", __func__);
 
 	priv->core_reg = devm_regulator_get(&spi->dev, "vcore");
-	if (IS_ERR(priv->core_reg)) {
-		dev_err(&spi->dev, "%s: Unable to get the core regulator\n",
-		       __func__);
-		return PTR_ERR(priv->core_reg);
-	}
+	if (IS_ERR(priv->core_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(priv->core_reg),
+				     "%s: Unable to get the core regulator\n", __func__);
 
 	priv->ld = devm_lcd_device_register(&spi->dev, "l4f00242t03", &spi->dev,
-					priv, &l4f_ops);
+					    priv, &l4f_ops);
 	if (IS_ERR(priv->ld))
 		return PTR_ERR(priv->ld);
 
-- 
2.25.1

