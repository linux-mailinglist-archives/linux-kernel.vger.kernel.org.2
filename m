Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCFD31FCB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhBSQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:03:51 -0500
Received: from inva021.nxp.com ([92.121.34.21]:55742 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhBSQBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:01:51 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 30002200113;
        Fri, 19 Feb 2021 17:01:02 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FBA52001B3;
        Fri, 19 Feb 2021 17:01:02 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 807ED2042F;
        Fri, 19 Feb 2021 17:01:01 +0100 (CET)
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
Subject: [RFC 07/19] devfreq: imx8m-ddrc: Add late system sleep PM ops
Date:   Fri, 19 Feb 2021 18:00:04 +0200
Message-Id: <1613750416-11901-8-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that, in order to be able to resume from suspend, the dram rate
needs to be the highest one available. Therefore, add the late system
suspend/resume PM ops which set the highest rate on suspend and the
latest one used before suspending on resume.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/devfreq/imx8m-ddrc.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index 33de83acfd8b..04347dee781b 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -72,6 +72,8 @@ struct imx8m_ddrc {
 	struct clk *dram_alt;
 	struct clk *dram_apb;
 
+	unsigned long suspend_rate;
+	unsigned long resume_rate;
 	int freq_count;
 	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
 };
@@ -271,6 +273,22 @@ static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
 	return ret;
 }
 
+static int imx8m_ddrc_suspend(struct device *dev)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+
+	priv->resume_rate = clk_get_rate(priv->dram_core);
+
+	return imx8m_ddrc_target(dev, &priv->suspend_rate, 0);
+}
+
+static int imx8m_ddrc_resume(struct device *dev)
+{
+	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
+
+	return imx8m_ddrc_target(dev, &priv->resume_rate, 0);
+}
+
 static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
 {
 	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
@@ -336,6 +354,9 @@ static int imx8m_ddrc_init_freq_info(struct device *dev)
 
 		if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
 			return -ENODEV;
+
+		if (index ==  0)
+			priv->suspend_rate = freq->rate * 250000;
 	}
 
 	return 0;
@@ -412,10 +433,15 @@ static const struct of_device_id imx8m_ddrc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
 
+static const struct dev_pm_ops imx8m_ddrc_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx8m_ddrc_suspend, imx8m_ddrc_resume)
+};
+
 static struct platform_driver imx8m_ddrc_platdrv = {
 	.probe		= imx8m_ddrc_probe,
 	.driver = {
 		.name	= "imx8m-ddrc-devfreq",
+		.pm = &imx8m_ddrc_pm_ops,
 		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
 	},
 };
-- 
2.29.2

