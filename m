Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F71321F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhBVSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:39:31 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:55036 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhBVSi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:38:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 791CFFB02;
        Mon, 22 Feb 2021 19:38:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RDN2vddEVoRq; Mon, 22 Feb 2021 19:38:12 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BB22940258; Mon, 22 Feb 2021 19:38:11 +0100 (CET)
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
Subject: [PATCH v4 1/1] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Date:   Mon, 22 Feb 2021 19:38:11 +0100
Message-Id: <fa1ce8cdb448ed81e0dc6e49e3c7f8fd6b19ecae.1614019053.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614019053.git.agx@sigxcpu.org>
References: <cover.1614019053.git.agx@sigxcpu.org>
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

This allows to shut off the power domain hen blanking the LCD panel:

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
 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index a95572b397ca..5de175695834 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -14,6 +14,7 @@
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 /* DPHY registers */
@@ -469,6 +470,8 @@ static int mixel_dphy_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
+	pm_runtime_enable(dev);
+
 	phy = devm_phy_create(dev, np, &mixel_dphy_phy_ops);
 	if (IS_ERR(phy)) {
 		dev_err(dev, "Failed to create phy %ld\n", PTR_ERR(phy));
@@ -481,8 +484,15 @@ static int mixel_dphy_probe(struct platform_device *pdev)
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
2.30.0

