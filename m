Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFC40D73A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhIPKPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:15:41 -0400
Received: from mx24.baidu.com ([111.206.215.185]:53052 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236351AbhIPKPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:15:40 -0400
Received: from BC-Mail-Ex07.internal.baidu.com (unknown [172.31.51.47])
        by Forcepoint Email with ESMTPS id 5857ED8BA808A614A4EB;
        Thu, 16 Sep 2021 18:14:18 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX07.internal.baidu.com (172.31.51.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 16 Sep 2021 18:14:18 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:14:17 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/mcde: Make use of the helper function dev_err_probe()
Date:   Thu, 16 Sep 2021 18:14:06 +0800
Message-ID: <20210916101407.9601-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When possible use dev_err_probe help to properly deal with the
PROBE_DEFER error, the benefit is that DEFER issue will be logged
in the devices_deferred debugfs file.
And using dev_err_probe() can reduce code size, and the error value
gets printed.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/gpu/drm/mcde/mcde_drv.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index e60566a5739c..e9e4653a0732 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -291,11 +291,9 @@ static int mcde_probe(struct platform_device *pdev)
 
 	/* First obtain and turn on the main power */
 	mcde->epod = devm_regulator_get(dev, "epod");
-	if (IS_ERR(mcde->epod)) {
-		ret = PTR_ERR(mcde->epod);
-		dev_err(dev, "can't get EPOD regulator\n");
-		return ret;
-	}
+	if (IS_ERR(mcde->epod))
+		return dev_err_probe(dev, PTR_ERR(mcde->epod),
+				     "can't get EPOD regulator\n");
 	ret = regulator_enable(mcde->epod);
 	if (ret) {
 		dev_err(dev, "can't enable EPOD regulator\n");
@@ -303,8 +301,8 @@ static int mcde_probe(struct platform_device *pdev)
 	}
 	mcde->vana = devm_regulator_get(dev, "vana");
 	if (IS_ERR(mcde->vana)) {
-		ret = PTR_ERR(mcde->vana);
-		dev_err(dev, "can't get VANA regulator\n");
+		ret = dev_err_probe(dev, PTR_ERR(mcde->vana),
+				    "can't get VANA regulator\n");
 		goto regulator_epod_off;
 	}
 	ret = regulator_enable(mcde->vana);
@@ -320,8 +318,8 @@ static int mcde_probe(struct platform_device *pdev)
 	/* Clock the silicon so we can access the registers */
 	mcde->mcde_clk = devm_clk_get(dev, "mcde");
 	if (IS_ERR(mcde->mcde_clk)) {
-		dev_err(dev, "unable to get MCDE main clock\n");
-		ret = PTR_ERR(mcde->mcde_clk);
+		ret = dev_err_probe(dev, PTR_ERR(mcde->mcde_clk),
+				    "unable to get MCDE main clock\n");
 		goto regulator_off;
 	}
 	ret = clk_prepare_enable(mcde->mcde_clk);
@@ -333,14 +331,14 @@ static int mcde_probe(struct platform_device *pdev)
 
 	mcde->lcd_clk = devm_clk_get(dev, "lcd");
 	if (IS_ERR(mcde->lcd_clk)) {
-		dev_err(dev, "unable to get LCD clock\n");
-		ret = PTR_ERR(mcde->lcd_clk);
+		ret = dev_err_probe(dev, PTR_ERR(mcde->lcd_clk),
+				    "unable to get LCD clock\n");
 		goto clk_disable;
 	}
 	mcde->hdmi_clk = devm_clk_get(dev, "hdmi");
 	if (IS_ERR(mcde->hdmi_clk)) {
-		dev_err(dev, "unable to get HDMI clock\n");
-		ret = PTR_ERR(mcde->hdmi_clk);
+		ret = dev_err_probe(dev, PTR_ERR(mcde->hdmi_clk),
+				    "unable to get HDMI clock\n");
 		goto clk_disable;
 	}
 
-- 
2.25.1

