Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B41A31FCC4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhBSQFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:05:39 -0500
Received: from inva021.nxp.com ([92.121.34.21]:57036 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbhBSQCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:02:35 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BDF420024B;
        Fri, 19 Feb 2021 17:01:05 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8885E200235;
        Fri, 19 Feb 2021 17:01:05 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E8B9C2042F;
        Fri, 19 Feb 2021 17:01:04 +0100 (CET)
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
Subject: [RFC 12/19] interconnect: imx: Add imx_icc_get_bw and imx_icc_aggregate functions
Date:   Fri, 19 Feb 2021 18:00:09 +0200
Message-Id: <1613750416-11901-13-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aggregate function will return whatever is the highest
rate for that specific node. The imx_icc_get_bw sets the
initial avg and peak to 0 in order to avoid setting them to
INT_MAX by the interconnect core.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/interconnect/imx/imx.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index db048df80011..5cc1ce55406c 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -25,6 +25,23 @@ struct imx_icc_node {
 	struct dev_pm_qos_request qos_req;
 };
 
+static int imx_icc_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
+
+	return 0;
+}
+
+static int imx_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
+		      u32 peak_bw, u32 *agg_avg, u32 *agg_peak)
+{
+	*agg_avg = max(*agg_avg, avg_bw);
+	*agg_peak = max(*agg_peak, peak_bw);
+
+	return 0;
+}
+
 static int imx_icc_node_set(struct icc_node *node)
 {
 	struct device *dev = node->provider->dev;
@@ -233,7 +250,8 @@ int imx_icc_register(struct platform_device *pdev,
 	if (!provider)
 		return -ENOMEM;
 	provider->set = imx_icc_set;
-	provider->aggregate = icc_std_aggregate;
+	provider->get_bw = imx_icc_get_bw;
+	provider->aggregate = imx_icc_aggregate;
 	provider->xlate = of_icc_xlate_onecell;
 	provider->data = data;
 	provider->dev = dev;
-- 
2.29.2

