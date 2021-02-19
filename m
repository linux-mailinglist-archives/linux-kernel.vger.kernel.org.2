Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC25C31FCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBSQCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:02:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55688 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBSQBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:01:48 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B16620022B;
        Fri, 19 Feb 2021 17:01:00 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 14FE72001B3;
        Fri, 19 Feb 2021 17:01:00 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 743912042F;
        Fri, 19 Feb 2021 17:00:59 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 04/19] devfreq: imx-bus: Decouple imx-bus from icc made
Date:   Fri, 19 Feb 2021 18:00:01 +0200
Message-Id: <1613750416-11901-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link between an imx-bus device and its icc id will be done
through the fsl,icc-id property in each dts node. The imx
interconnect driver will pick up all the dts nodes that have that
property defined and will link them to the rightfull icc id.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/devfreq/imx-bus.c | 40 +++------------------------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
index 1c0c92d0eb08..9f0df88b29c1 100644
--- a/drivers/devfreq/imx-bus.c
+++ b/drivers/devfreq/imx-bus.c
@@ -65,36 +65,6 @@ static void imx_bus_exit(struct device *dev)
 	platform_device_unregister(priv->icc_pdev);
 }
 
-/* imx_bus_init_icc() - register matching icc provider if required */
-static int imx_bus_init_icc(struct device *dev)
-{
-	struct imx_bus *priv = dev_get_drvdata(dev);
-	const char *icc_driver_name;
-
-	if (!of_get_property(dev->of_node, "#interconnect-cells", 0))
-		return 0;
-	if (!IS_ENABLED(CONFIG_INTERCONNECT_IMX)) {
-		dev_warn(dev, "imx interconnect drivers disabled\n");
-		return 0;
-	}
-
-	icc_driver_name = of_device_get_match_data(dev);
-	if (!icc_driver_name) {
-		dev_err(dev, "unknown interconnect driver\n");
-		return 0;
-	}
-
-	priv->icc_pdev = platform_device_register_data(
-			dev, icc_driver_name, -1, NULL, 0);
-	if (IS_ERR(priv->icc_pdev)) {
-		dev_err(dev, "failed to register icc provider %s: %ld\n",
-				icc_driver_name, PTR_ERR(priv->icc_pdev));
-		return PTR_ERR(priv->icc_pdev);
-	}
-
-	return 0;
-}
-
 static int imx_bus_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -144,10 +114,6 @@ static int imx_bus_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = imx_bus_init_icc(dev);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
@@ -156,9 +122,9 @@ static int imx_bus_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_bus_of_match[] = {
-	{ .compatible = "fsl,imx8mq-noc", .data = "imx8mq-interconnect", },
-	{ .compatible = "fsl,imx8mm-noc", .data = "imx8mm-interconnect", },
-	{ .compatible = "fsl,imx8mn-noc", .data = "imx8mn-interconnect", },
+	{ .compatible = "fsl,imx8mq-noc",},
+	{ .compatible = "fsl,imx8mm-noc",},
+	{ .compatible = "fsl,imx8mn-noc",},
 	{ .compatible = "fsl,imx8m-noc", },
 	{ .compatible = "fsl,imx8m-nic", },
 	{ /* sentinel */ },
-- 
2.29.2

