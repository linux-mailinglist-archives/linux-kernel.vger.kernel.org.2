Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA44431FCBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBSQEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 11:04:02 -0500
Received: from inva020.nxp.com ([92.121.34.13]:35946 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhBSQBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 11:01:53 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 35AF41A02DA;
        Fri, 19 Feb 2021 17:01:04 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 288691A0401;
        Fri, 19 Feb 2021 17:01:04 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 88C4D20430;
        Fri, 19 Feb 2021 17:01:03 +0100 (CET)
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
Subject: [RFC 10/19] interconnect: imx8mq: Add the pl301_per_m and pl301_wakeup nodes and subnodes
Date:   Fri, 19 Feb 2021 18:00:07 +0200
Message-Id: <1613750416-11901-11-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
References: <1613750416-11901-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the bus diagram, there are two more pl301s that need to
be added here. The pl301_per_m which is an intermediary node between
pl301_main and its masters: usdhc1, usdhc2 and sdma. The pl301_wakeup
is an intermediary node between pl301_main and its masters, in this case
all the SAIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/interconnect/imx/imx8mq.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index b8c36d668946..010ad3d76286 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -57,14 +57,25 @@ static struct imx_icc_node_desc nodes[] = {
 	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, IMX8MQ_ICN_MAIN),
 
 	/* OTHER */
-	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("NAND", IMX8MQ_ICM_NAND, IMX8MQ_ICN_MAIN),
-	DEFINE_BUS_MASTER("USDHC1", IMX8MQ_ICM_USDHC1, IMX8MQ_ICN_MAIN),
-	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("PCIE1", IMX8MQ_ICM_PCIE1, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("PCIE2", IMX8MQ_ICM_PCIE2, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN,
 			IMX8MQ_ICN_NOC, IMX8MQ_ICS_OCRAM),
+	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_PER_M),
+	DEFINE_BUS_MASTER("USDHC1", IMX8MQ_ICM_USDHC1, IMX8MQ_ICN_PER_M),
+	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_PER_M),
+	DEFINE_BUS_INTERCONNECT("PL301_PER_M", IMX8MQ_ICN_PER_M,
+			IMX8MQ_ICN_MAIN),
+
+	DEFINE_BUS_MASTER("SAI1", IMX8MQ_ICM_SAI1, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI2", IMX8MQ_ICM_SAI2, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI3", IMX8MQ_ICM_SAI3, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI4", IMX8MQ_ICM_SAI4, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI5", IMX8MQ_ICM_SAI5, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_MASTER("SAI6", IMX8MQ_ICM_SAI6, IMX8MQ_ICN_WAKEUP),
+	DEFINE_BUS_INTERCONNECT("PL301_WAKEUP", IMX8MQ_ICN_WAKEUP,
+			IMX8MQ_ICN_MAIN),
 };
 
 static int imx8mq_icc_probe(struct platform_device *pdev)
-- 
2.29.2

