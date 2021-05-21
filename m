Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD038CB64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbhEUQ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:57:18 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:59249 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbhEUQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:57:17 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d49 with ME
        id 7Uvr2500B21Fzsu03UvrPg; Fri, 21 May 2021 18:55:52 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 21 May 2021 18:55:52 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] usb: dwc3: meson-g12a: Disable the regulator in the error handling path of the probe
Date:   Fri, 21 May 2021 18:55:50 +0200
Message-Id: <79df054046224bbb0716a8c5c2082650290eec86.1621616013.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after a successful 'regulator_enable()' call,
'regulator_disable()' must be called.

Fix the error handling path of the probe accordingly.

The remove function doesn't need to be fixed, because the
'regulator_disable()' call is already hidden in 'dwc3_meson_g12a_suspend()'
which is called via 'pm_runtime_set_suspended()' in the remove function.

Fixes: c99993376f72 ("usb: dwc3: Add Amlogic G12A DWC3 glue")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Please review carefully.

I'm not that sure about:
   The remove function doesn't need to be fixed, because the
   'regulator_disable()' call is already hidden in 'dwc3_meson_g12a_suspend()'
   which is called via 'pm_runtime_set_suspended()' in the remove function.

This is more a guess than anything else!
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index bdf1f98dfad8..804957525130 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -772,13 +772,13 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 
 	ret = priv->drvdata->usb_init(priv);
 	if (ret)
-		goto err_disable_clks;
+		goto err_disable_regulator;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
 		ret = phy_init(priv->phys[i]);
 		if (ret)
-			goto err_disable_clks;
+			goto err_disable_regulator;
 	}
 
 	/* Set PHY Power */
@@ -816,6 +816,10 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	for (i = 0 ; i < PHY_COUNT ; ++i)
 		phy_exit(priv->phys[i]);
 
+err_disable_regulator:
+	if (priv->vbus)
+		regulator_disable(priv->vbus);
+
 err_disable_clks:
 	clk_bulk_disable_unprepare(priv->drvdata->num_clks,
 				   priv->drvdata->clks);
-- 
2.30.2

