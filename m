Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39C840D7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhIPKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:47:42 -0400
Received: from mx22.baidu.com ([220.181.50.185]:54334 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235570AbhIPKrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:47:39 -0400
Received: from BC-Mail-Ex17.internal.baidu.com (unknown [172.31.51.11])
        by Forcepoint Email with ESMTPS id 507C2D9F7E29BEF0739F;
        Thu, 16 Sep 2021 18:46:18 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex17.internal.baidu.com (172.31.51.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Thu, 16 Sep 2021 18:46:18 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Thu, 16 Sep 2021 18:46:17 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/panel: ls037v7dw01: Make use of the helper function dev_err_probe()
Date:   Thu, 16 Sep 2021 18:46:11 +0800
Message-ID: <20210916104612.11516-1-caihuoqing@baidu.com>
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
 .../gpu/drm/panel/panel-sharp-ls037v7dw01.c   | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
index 94992f45113a..a07d0f6c3e69 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
@@ -146,22 +146,19 @@ static int ls037v7dw01_probe(struct platform_device *pdev)
 	lcd->pdev = pdev;
 
 	lcd->vdd = devm_regulator_get(&pdev->dev, "envdd");
-	if (IS_ERR(lcd->vdd)) {
-		dev_err(&pdev->dev, "failed to get regulator\n");
-		return PTR_ERR(lcd->vdd);
-	}
+	if (IS_ERR(lcd->vdd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lcd->vdd),
+				     "failed to get regulator\n");
 
 	lcd->ini_gpio = devm_gpiod_get(&pdev->dev, "enable", GPIOD_OUT_LOW);
-	if (IS_ERR(lcd->ini_gpio)) {
-		dev_err(&pdev->dev, "failed to get enable gpio\n");
-		return PTR_ERR(lcd->ini_gpio);
-	}
+	if (IS_ERR(lcd->ini_gpio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lcd->ini_gpio),
+				     "failed to get enable gpio\n");
 
 	lcd->resb_gpio = devm_gpiod_get(&pdev->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(lcd->resb_gpio)) {
-		dev_err(&pdev->dev, "failed to get reset gpio\n");
-		return PTR_ERR(lcd->resb_gpio);
-	}
+	if (IS_ERR(lcd->resb_gpio))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lcd->resb_gpio),
+				     "failed to get reset gpio\n");
 
 	lcd->mo_gpio = devm_gpiod_get_index(&pdev->dev, "mode", 0,
 					    GPIOD_OUT_LOW);
-- 
2.25.1

