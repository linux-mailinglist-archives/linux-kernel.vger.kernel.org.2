Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00754359D93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhDILku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:40:50 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:41554 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233137AbhDILkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:40:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 427E4FB02;
        Fri,  9 Apr 2021 13:40:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HZbjt4djQ3cO; Fri,  9 Apr 2021 13:40:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id A8AB840627; Fri,  9 Apr 2021 13:40:21 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v5 2/2] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Date:   Fri,  9 Apr 2021 13:40:21 +0200
Message-Id: <c68efbfc19de3bf1a6586edc71a9b9bdd05c84eb.1617968250.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1617968250.git.agx@sigxcpu.org>
References: <cover.1617968250.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to shut down the mipi power domain on the imx8. The
alternative would be to drop the dphy from the mipi power domain in the
SOCs device tree and only have the DSI host controller visible there but
since the PD is mostly about the PHY that would defeat it's purpose.

This allows to shut off the power domain when blanking the LCD panel:

pm_genpd_summary before:

domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
mipi                            on
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

after:

mipi                            off-0
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index a95572b397ca..f89a0c458499 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -14,6 +14,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 /* DPHY registers */
@@ -469,20 +470,32 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
+	pm_runtime_enable(dev);
+
 	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
 	if (IS_ERR(phy)) {
+		pm_runtime_disable(&pdev->dev);
 		dev_err(dev, "Failed to create phy %ld\n", PTR_ERR(phy));
 		return PTR_ERR(phy);
 	}
 	phy_set_drvdata(phy, priv);
 
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		pm_runtime_disable(&pdev->dev);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
+static int mixel_dphy_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
 static struct platform_driver mixel_dphy_driver = {
 	.probe	= mixel_dphy_probe,
+	.remove = mixel_dphy_remove,
 	.driver = {
 		.name = "mixel-mipi-dphy",
 		.of_match_table	= mixel_dphy_of_match,
-- 
2.30.1

