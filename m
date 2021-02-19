Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F33231FCC0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhBSQFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:05:18 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57028 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229734AbhBSQCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:02:35 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DC337200049;
        Fri, 19 Feb 2021 17:01:02 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB9C92001B3;
        Fri, 19 Feb 2021 17:01:02 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F8C62042F;
        Fri, 19 Feb 2021 17:01:02 +0100 (CET)
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
Subject: [RFC 08/19] interconnect: imx: Switch from imx_icc_node_adj_desc to fsl,icc-id node assignment
Date:   Fri, 19 Feb 2021 18:00:05 +0200
Message-Id: <1613750416-11901-9-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to have more than one NoCs in the interconnect net
we need to decouple the NoC from the dram. So instead of using the
imx_icc_node_adj_desc, we use the fsl,icc-id property that is in
each NoC (or pl301) to the icc node (based on the id) to it.
Along with all the NoC and pl301 nodes in the dts we will have a
interconnect dedicated node. This node will be the actual device of the
icc provider.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/interconnect/imx/imx.c | 72 +++++++++++++++-------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index c770951a909c..db048df80011 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -34,9 +34,9 @@ static int imx_icc_node_set(struct icc_node *node)
 	if (!node_data->qos_dev)
 		return 0;
 
-	freq = (node->avg_bw + node->peak_bw) * node_data->desc->adj->bw_mul;
-	do_div(freq, node_data->desc->adj->bw_div);
-	dev_dbg(dev, "node %s device %s avg_bw %ukBps peak_bw %ukBps min_freq %llukHz\n",
+	freq = max(node->avg_bw, node->peak_bw);
+
+	dev_dbg(dev, "	DBG node %s device %s avg_bw %ukBps peak_bw %ukBps min_freq %llukHz\n",
 		node->name, dev_name(node_data->qos_dev),
 		node->avg_bw, node->peak_bw, freq);
 
@@ -79,41 +79,35 @@ static int imx_icc_node_init_qos(struct icc_provider *provider,
 				 struct icc_node *node)
 {
 	struct imx_icc_node *node_data = node->data;
-	const struct imx_icc_node_adj_desc *adj = node_data->desc->adj;
 	struct device *dev = provider->dev;
-	struct device_node *dn = NULL;
 	struct platform_device *pdev;
+	struct device_node *np = NULL, *dn = NULL;
+	int idx;
 
-	if (adj->main_noc) {
-		node_data->qos_dev = dev;
-		dev_dbg(dev, "icc node %s[%d] is main noc itself\n",
-			node->name, node->id);
-	} else {
-		dn = of_parse_phandle(dev->of_node, adj->phandle_name, 0);
-		if (!dn) {
-			dev_warn(dev, "Failed to parse %s\n",
-				 adj->phandle_name);
-			return -ENODEV;
-		}
-		/* Allow scaling to be disabled on a per-node basis */
-		if (!of_device_is_available(dn)) {
-			dev_warn(dev, "Missing property %s, skip scaling %s\n",
-				 adj->phandle_name, node->name);
-			of_node_put(dn);
-			return 0;
-		}
+	for_each_node_with_property(np, "fsl,icc-id") {
+		of_property_read_u32(np, "fsl,icc-id", &idx);
+		if (idx == node_data->desc->id)
+			dn = np;
+	}
 
-		pdev = of_find_device_by_node(dn);
-		of_node_put(dn);
-		if (!pdev) {
-			dev_warn(dev, "node %s[%d] missing device for %pOF\n",
-				 node->name, node->id, dn);
-			return -EPROBE_DEFER;
-		}
-		node_data->qos_dev = &pdev->dev;
-		dev_dbg(dev, "node %s[%d] has device node %pOF\n",
-			node->name, node->id, dn);
+	if (!dn)
+		return 0;
+
+	if (!of_device_is_available(dn)) {
+		dev_warn(dev, "%pOF is disabled\n", dn);
+		return 0;
+	}
+
+	pdev = of_find_device_by_node(dn);
+	of_node_put(dn);
+	if (!pdev) {
+		dev_warn(dev, "node %s[%d] missing device for %pOF\n",
+			 node->name, node->id, dn);
+		return -EPROBE_DEFER;
 	}
+	node_data->qos_dev = &pdev->dev;
+	dev_dbg(dev, "node %s[%d] has device node %pOF\n", node->name,
+							node->id, dn);
 
 	return dev_pm_qos_add_request(node_data->qos_dev,
 				      &node_data->qos_req,
@@ -151,12 +145,10 @@ static struct icc_node *imx_icc_node_add(struct icc_provider *provider,
 	node_data->desc = node_desc;
 	icc_node_add(node, provider);
 
-	if (node_desc->adj) {
-		ret = imx_icc_node_init_qos(provider, node);
-		if (ret < 0) {
-			imx_icc_node_destroy(node);
-			return ERR_PTR(ret);
-		}
+	ret = imx_icc_node_init_qos(provider, node);
+	if (ret < 0) {
+		imx_icc_node_destroy(node);
+		return ERR_PTR(ret);
 	}
 
 	return node;
@@ -244,7 +236,7 @@ int imx_icc_register(struct platform_device *pdev,
 	provider->aggregate = icc_std_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
-	provider->dev = dev->parent;
+	provider->dev = dev;
 	platform_set_drvdata(pdev, provider);
 
 	ret = icc_provider_add(provider);
-- 
2.29.2

