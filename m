Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF740D7BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbhIPKsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:48:17 -0400
Received: from mx22.baidu.com ([220.181.50.185]:54856 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237160AbhIPKsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:48:12 -0400
Received: from BJHW-Mail-Ex08.internal.baidu.com (unknown [10.127.64.18])
        by Forcepoint Email with ESMTPS id ADE919D3DADEA1904C24;
        Thu, 16 Sep 2021 18:46:48 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:46:48 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:46:47 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/panel: td043mtea1: Make use of the helper function dev_err_probe()
Date:   Thu, 16 Sep 2021 18:46:42 +0800
Message-ID: <20210916104642.11728-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex31.internal.baidu.com (172.31.51.25) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex08_2021-09-16 18:46:48:733
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
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index bacaf1b7fb70..1866cdb8f9c1 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -431,16 +431,14 @@ static int td043mtea1_probe(struct spi_device *spi)
 	memcpy(lcd->gamma, td043mtea1_def_gamma, sizeof(lcd->gamma));
 
 	lcd->vcc_reg = devm_regulator_get(&spi->dev, "vcc");
-	if (IS_ERR(lcd->vcc_reg)) {
-		dev_err(&spi->dev, "failed to get VCC regulator\n");
-		return PTR_ERR(lcd->vcc_reg);
-	}
+	if (IS_ERR(lcd->vcc_reg))
+		return dev_err_probe(&spi->dev, PTR_ERR(lcd->vcc_reg),
+				     "failed to get VCC regulator\n");
 
 	lcd->reset_gpio = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(lcd->reset_gpio)) {
-		dev_err(&spi->dev, "failed to get reset GPIO\n");
-		return PTR_ERR(lcd->reset_gpio);
-	}
+	if (IS_ERR(lcd->reset_gpio))
+		return dev_err_probe(&spi->dev, PTR_ERR(lcd->reset_gpio),
+				     "failed to get reset GPIO\n");
 
 	spi->bits_per_word = 16;
 	spi->mode = SPI_MODE_0;
-- 
2.25.1

