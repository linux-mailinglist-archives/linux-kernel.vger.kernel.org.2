Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C888440D7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbhIPKrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:47:55 -0400
Received: from mx22.baidu.com ([220.181.50.185]:54452 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236705AbhIPKrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:47:49 -0400
Received: from BJHW-Mail-Ex03.internal.baidu.com (unknown [10.127.64.13])
        by Forcepoint Email with ESMTPS id DF88F788B45F7BD24C3C;
        Thu, 16 Sep 2021 18:46:25 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex03.internal.baidu.com (10.127.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:46:25 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:46:25 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/panel: nt39016: Make use of the helper function dev_err_probe()
Date:   Thu, 16 Sep 2021 18:46:19 +0800
Message-ID: <20210916104620.11569-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
And using dev_err_probe() can reduce code size, the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index f8151fe3ac9a..d036853db865 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -258,16 +258,13 @@ static int nt39016_probe(struct spi_device *spi)
 		return -EINVAL;
 
 	panel->supply = devm_regulator_get(dev, "power");
-	if (IS_ERR(panel->supply)) {
-		dev_err(dev, "Failed to get power supply\n");
-		return PTR_ERR(panel->supply);
-	}
+	if (IS_ERR(panel->supply))
+		return dev_err_probe(dev, PTR_ERR(panel->supply),
+				     "Failed to get power supply\n");
 
 	panel->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(panel->reset_gpio)) {
-		dev_err(dev, "Failed to get reset GPIO\n");
-		return PTR_ERR(panel->reset_gpio);
-	}
+	if (IS_ERR(panel->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(panel->reset_gpio), "Failed to get reset GPIO\n");
 
 	spi->bits_per_word = 8;
 	spi->mode = SPI_MODE_3 | SPI_3WIRE;
@@ -287,11 +284,8 @@ static int nt39016_probe(struct spi_device *spi)
 		       DRM_MODE_CONNECTOR_DPI);
 
 	err = drm_panel_of_backlight(&panel->drm_panel);
-	if (err) {
-		if (err != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get backlight handle\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "Failed to get backlight handle\n");
 
 	drm_panel_add(&panel->drm_panel);
 
-- 
2.25.1

