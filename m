Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A961C31FCCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhBSQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:07:09 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36942 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhBSQCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:02:37 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B91411A01B9;
        Fri, 19 Feb 2021 17:01:09 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AB3CF1A00BD;
        Fri, 19 Feb 2021 17:01:09 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 17C002042F;
        Fri, 19 Feb 2021 17:01:09 +0100 (CET)
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
Subject: [RFC 18/19] net: ethernet: fec_main: Add interconnect support
Date:   Fri, 19 Feb 2021 18:00:15 +0200
Message-Id: <1613750416-11901-19-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On probe, if the dts node contains a valid icc path, then look for the
fsl,icc-rate property and get the rate. Also set the icc bandwidth
for that path to the nominal rate needed for fec to function right.
Then enable and disable the path every time the fec is used or not.
This will result in reducing the clock speeds along the icc path
for each pl301 and NoC, but still meet the requirements for all the
other icc consumers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 0602d5d5d2ee..7611492cb800 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -529,6 +529,9 @@ struct fec_enet_private {
 	unsigned int num_tx_queues;
 	unsigned int num_rx_queues;
 
+	struct icc_path *bus_path;
+	unsigned int bus_rate;
+
 	/* The saved address of a sent-in-place packet/buffer, for skfree(). */
 	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
 	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 3db882322b2b..0ed78b390098 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -47,6 +47,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/interconnect.h>
 #include <linux/clk.h>
 #include <linux/crc32.h>
 #include <linux/platform_device.h>
@@ -3572,6 +3573,18 @@ fec_probe(struct platform_device *pdev)
 	fep->pdev = pdev;
 	fep->dev_id = dev_id++;
 
+	fep->bus_path = devm_of_icc_get(&pdev->dev, "path");
+	if (IS_ERR(fep->bus_path)) {
+		return PTR_ERR(fep->bus_path);
+	} else if (fep->bus_path) {
+		if (of_property_read_u32(np, "fsl,icc-rate", &fep->bus_rate)) {
+			dev_err(&pdev->dev, "icc-rate missing\n");
+			return -EINVAL;
+		}
+
+		icc_set_bw(fep->bus_path, 0, fep->bus_rate);
+	}
+
 	platform_set_drvdata(pdev, ndev);
 
 	if ((of_machine_is_compatible("fsl,imx6q") ||
@@ -3826,6 +3839,8 @@ static int __maybe_unused fec_suspend(struct device *dev)
 	if (fep->clk_enet_out || fep->reg_phy)
 		fep->link = 0;
 
+	icc_disable(fep->bus_path);
+
 	return 0;
 }
 
@@ -3836,6 +3851,8 @@ static int __maybe_unused fec_resume(struct device *dev)
 	int ret;
 	int val;
 
+	icc_enable(fep->bus_path);
+
 	if (fep->reg_phy && !(fep->wol_flag & FEC_WOL_FLAG_ENABLE)) {
 		ret = regulator_enable(fep->reg_phy);
 		if (ret)
@@ -3884,6 +3901,7 @@ static int __maybe_unused fec_runtime_suspend(struct device *dev)
 	clk_disable_unprepare(fep->clk_ahb);
 	clk_disable_unprepare(fep->clk_ipg);
 
+	icc_disable(fep->bus_path);
 	return 0;
 }
 
@@ -3893,6 +3911,7 @@ static int __maybe_unused fec_runtime_resume(struct device *dev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int ret;
 
+	icc_enable(fep->bus_path);
 	ret = clk_prepare_enable(fep->clk_ahb);
 	if (ret)
 		return ret;
-- 
2.29.2

