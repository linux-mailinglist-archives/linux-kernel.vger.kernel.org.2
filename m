Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB631FCB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhBSQDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:03:30 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35798 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhBSQBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:01:50 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8083F1A02B6;
        Fri, 19 Feb 2021 17:01:01 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 718E71A01C8;
        Fri, 19 Feb 2021 17:01:01 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id D069F2042F;
        Fri, 19 Feb 2021 17:01:00 +0100 (CET)
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
Subject: [RFC 06/19] devfreq: imx8m-ddrc: Use the opps acquired from EL3
Date:   Fri, 19 Feb 2021 18:00:03 +0200
Message-Id: <1613750416-11901-7-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8M platforms get their dram OPPs from the EL3.
We don't need to duplicate that in the kernel dram dts node.
We should just trust the OPPs provided by the EL3.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 49 ++----------------------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index 3a6c04ba4f2e..33de83acfd8b 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -333,38 +333,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
 		if (freq->dram_core_parent_index == 2 &&
 				freq->dram_alt_parent_index == 0)
 			return -ENODEV;
-	}
-
-	return 0;
-}
-
-static int imx8m_ddrc_check_opps(struct device *dev)
-{
-	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
-	struct imx8m_ddrc_freq *freq_info;
-	struct dev_pm_opp *opp;
-	unsigned long freq;
-	int i, opp_count;
-
-	/* Enumerate DT OPPs and disable those not supported by firmware */
-	opp_count = dev_pm_opp_get_opp_count(dev);
-	if (opp_count < 0)
-		return opp_count;
-	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
-		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
-		if (IS_ERR(opp)) {
-			dev_err(dev, "Failed enumerating OPPs: %ld\n",
-				PTR_ERR(opp));
-			return PTR_ERR(opp);
-		}
-		dev_pm_opp_put(opp);
 
-		freq_info = imx8m_ddrc_find_freq(priv, freq);
-		if (!freq_info) {
-			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
-					freq, DIV_ROUND_CLOSEST(freq, 250000));
-			dev_pm_opp_disable(dev, freq);
-		}
+		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
+			return -ENODEV;
 	}
 
 	return 0;
@@ -372,7 +343,6 @@ static int imx8m_ddrc_check_opps(struct device *dev)
 
 static void imx8m_ddrc_exit(struct device *dev)
 {
-	dev_pm_opp_of_remove_table(dev);
 }
 
 static int imx8m_ddrc_probe(struct platform_device *pdev)
@@ -419,16 +389,6 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = dev_pm_opp_of_add_table(dev);
-	if (ret < 0) {
-		dev_err(dev, "failed to get OPP table\n");
-		return ret;
-	}
-
-	ret = imx8m_ddrc_check_opps(dev);
-	if (ret < 0)
-		goto err;
-
 	priv->profile.polling_ms = 1000;
 	priv->profile.target = imx8m_ddrc_target;
 	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
@@ -441,13 +401,8 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->devfreq)) {
 		ret = PTR_ERR(priv->devfreq);
 		dev_err(dev, "failed to add devfreq device: %d\n", ret);
-		goto err;
 	}
 
-	return 0;
-
-err:
-	dev_pm_opp_of_remove_table(dev);
 	return ret;
 }
 
-- 
2.29.2

