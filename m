Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8237630D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbhEGJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:48:34 -0400
Received: from mail-db8eur05on2049.outbound.protection.outlook.com ([40.107.20.49]:6827
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236814AbhEGJs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:48:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+YtRWC/Dz0K3NMb7Ad65TVdmi6w1VT0eM0Uh205acHbPKl6X06ayPOZDnLmebAPVNucsKzUPQ2cFSdSrWNaaYsgY+WGCiacCzPgCL9RDoRP/+25mc8tR0jAFHNACTNwC/G9e3yms7lXojqscVLJp0Ij6itvFqTNp8VXkjDjTox2aNdg5tV6Twl4CKtzFsd3U2mcNcvGlqp0zzxDXE9SBLGGH4sCdMbmUIm8KqwiW9bXchOgd3hVY73/jZJVHNCczz8XcUFNUSn6aHSoIvYlFACVLkhZXsd+JOJaQBX2sEZpK8ET1prO/nDx4ArYU/Yd/jutODxTxiglH0B+uvYfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kthR1LaEBXeLffCxe1zpZe6u5BMGV8EDqpFYNFkbXVc=;
 b=MSHcAf7i/Xo1bdQpkF6j/vd7RpOA1ERIVQV72hitYfkhDabPo4+1lu8MEZuy/JYh7VJZgIvOoc918k7JtJMLgWgyx5w81d5/dTFavNzIrvmqp3Ap+Oq+opVlXtubiMf22NEFQtSfS6thhOzbdKH7z6vTYCDa+ugeF1OwY1n4Et7UkUTlpiEeui62ke5SCoLc2JpbuL/ZhquSWO7HyMrz8p4zqcYbogi8Fot0cqWqsUldPrnItd2l7/6MfyE6KsafQ0DBkfU9IQ9gmzANsOXSL7/TDAGq7SfIDjs0eqnENgIzVTx3TGG+jrkC1obSBx+8wuYWvMltBtrTzZrOKe4KlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kthR1LaEBXeLffCxe1zpZe6u5BMGV8EDqpFYNFkbXVc=;
 b=UGWAvykc/b7INNPxA4BVUh8nCpYdCqUklkb69sJf4WSLDX9N1YCJfi0/QHqV4TGx+kOIBLeLBXP3cjcZXhu+2h5FqIx3ecwqDKZ+IMFSD6q5UUUjalt+Y2XdLmNo590DNMDGTh/UO8+90GEr5HDA0JmItaswa6IShvvzlHgSEgw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 09:47:25 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 09:47:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] mailbox: imx: replace the xTR/xRR array with single register
Date:   Fri,  7 May 2021 18:19:24 +0800
Message-Id: <20210507101926.25631-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210507101926.25631-1-peng.fan@oss.nxp.com>
References: <20210507101926.25631-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 09:47:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f618e615-fb67-4eae-a1dc-08d9113d1e54
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB685759E49074502297ACB68EC9579@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pzOBMziSiF0cL4CMNYm/fq/RzjovzGk1Gay1TWKgkPCjulBhg0ITxGbGLdo2wQo91eHw0oshZYoU3oGrx7ltyGPp6Tqqr7UQ3cG8t4UK5hCC/MTppAnoXWs8tsVVAmjYoeJhMxg4bU3pbcO6L7iBwySDfXm0RpuWm3IHqa8jkpo8U9DZfcNmoMyC9ZxHlCD/R1oqoJKoZJqr2IG5s+oJDBlrE2VDE29q10P6gl6HLUqPWJlV/6w1oY0yCJxtGv9bb27YHwAbw011b0RaW2592CeZtBKCnXPCI5UXf1KltRBW16D43DnDNuvrMh01KppLeCpKiTe0oVucNtzr4xkolIspFAKlyzA29bMnfOOTlUXBOtUP0W2PD4dr9wQEfQfCPpJfJnxJKCzZhjhKjS6wtkD8ejWeU4S8KYOzzu7FiX4BYVO/cihISYzMzDgVVm4yJ6yBvOyAIlcN9GYsGhLbTb+ifgLFhKzV+2UjuseLp+OEki8f8629pj1p/Z12oVxmBNe/dl+7+7ejcbnFh4O9vyr15o7uYrkpjfxapeTmVyYNQOmNPByKhLf7T7GjTD5hYhtL1sUEFA8ZKkyqGNeOIxN8qvu72srfWF9uvxHaxYEN1xa7opoioePt/xUWPkcdYvqHQUuAiU9xtY1tpV6OOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(86362001)(4326008)(478600001)(26005)(7416002)(6486002)(83380400001)(8936002)(316002)(38100700002)(5660300002)(66946007)(2616005)(956004)(1076003)(8676002)(2906002)(15650500001)(6512007)(16526019)(66556008)(66476007)(52116002)(6506007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sHHCbRqmdCc2zl90epdahTQ5ejwBprOIiRPesUvLxHlqZI9xPxEf0lV5zIrk?=
 =?us-ascii?Q?OeUU67NYSFqBivXzlVbX1NViiTyN6p6E8BLxxC+zfd/4p26VjeatZ32b9B1n?=
 =?us-ascii?Q?TDl2l+HAJoaq4GZ4JAYb/9KlPjS51pjncpo109vfjJ8wrHCPDBPKgFksllHY?=
 =?us-ascii?Q?CKkfON1KQCSXU6Co67WsB53cgKMFBt69T+aV4/n4mYzFkTDcqlAVPzp4/Wi2?=
 =?us-ascii?Q?P31opKP0HxCx9oZ9X6Nb4Pe4whPPpeirMnbGuCr08sMkuIUQ5y+GuFr0Na94?=
 =?us-ascii?Q?C3rkoO/VdvJ0cuspRJe0r3qOgLLye4joXQUF6xgfYSbzEoY7UzpTBhBxmIgH?=
 =?us-ascii?Q?48tFOG78dxUkJUIEWLYpef5KiSoQqloUjYNAnWuXMxW0eEDC0qRDXVzEj8a9?=
 =?us-ascii?Q?JhCX5Yij39+JKuCg4o7sm0fIlUc4Cv7USrS/7LJZ+2Ngm8jWJOyAeRnw0tdr?=
 =?us-ascii?Q?iERGC9lu1bZxm1diXLu/dL5HubtoQC/BRTJJtioS0BJg07hwg3e1FAeconRT?=
 =?us-ascii?Q?e8sywRXbeMhWP0v06sfETHE17QACOUEqAQ6/dHVuu+lGHdqjDZlOBo1AKyib?=
 =?us-ascii?Q?NlyWwFfa34bO6Q0QgIKtHlTnIhutQUSWA8D36ZkRbaZSPnyyVWO8GjxM4rQ/?=
 =?us-ascii?Q?AOPbFEgE67TGf/F3JWIKZhJ3TIXFILw8LCeMjng9w8ukTpkwPWKycV4XvSl0?=
 =?us-ascii?Q?o3gfLkGuJgMhl47OFGPOhBSCdX8hFBtih0TA+pgMfv4ShwffpZKdFpfRkmnF?=
 =?us-ascii?Q?lVUVeIX6IiaK9sSGCPWZbWQ8w548qTPi3cC5gD6kYgmfG+fTIVIsvie7/NG4?=
 =?us-ascii?Q?JcWES5HRT2KYKDOcOzO+lwyrmVUfX71fwJT27rwFCoPHOvK8yS1RRtehE2k5?=
 =?us-ascii?Q?s35P5PpF07tGLQMnfNX80CuAk0q4VswS3E+3PXTb5p66N9hSazgDQ7oBrire?=
 =?us-ascii?Q?AVPH934dRpVoejksaYhZyQjBp0EyRj2PIdirQFndXtbbeagGx8rlVXZsaEYS?=
 =?us-ascii?Q?6p1cpauy3CgZ5qC57JWt9pP9trN4W221YVLdxMC0zf8lIzuUYZLRcZPD9hT4?=
 =?us-ascii?Q?rri61q+0yl6YJDZYJBi1WfpAibkhxltczGDQbawqlo33KBb+YRISF+AsuxsQ?=
 =?us-ascii?Q?/k1BKO+g9WfkQkv3udF738DWYxegLovM1heBG7Oldz4PmV9e700pw9lnlcAS?=
 =?us-ascii?Q?pxKIAVx9D89sTVECzTpQLUvXrSnjDUmz9oV1/0zspVXcnHrzmvUdRB1bDD/o?=
 =?us-ascii?Q?ZbsE7T/IE4OGJJxZyeyYqmBzzh4pq3lxlqL8UKmGSUEiJYYDj1duBzqoF7u/?=
 =?us-ascii?Q?OxGFwn2nHLDVuV3JgH0rVLto?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f618e615-fb67-4eae-a1dc-08d9113d1e54
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 09:47:25.3783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dialfqrzq8QbV5J7wBLJ/Rk5eFgKbrKmF9f3ymSBofl235oEcQZZRbsvoNysPNNZ3wPaEkeyUfMxJjh4EGcgLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The xTR/xRR registers are using 4 bytes stride and continuous.
Considering we will support more TR and RR registers, use base + idx * 4
method to calculate register address, not hardcoding in driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 2543c7b6948b..bd7758c32a80 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -76,8 +76,8 @@ struct imx_mu_dcfg {
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
 	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
 	void (*init)(struct imx_mu_priv *priv);
-	u32	xTR[4];		/* Transmit Registers */
-	u32	xRR[4];		/* Receive Registers */
+	u32	xTR;		/* Transmit Register0 */
+	u32	xRR;		/* Receive Register0 */
 	u32	xSR;		/* Status Register */
 	u32	xCR;		/* Control Register */
 };
@@ -120,7 +120,7 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
-		imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
+		imx_mu_write(priv, *arg, priv->dcfg->xTR + cp->idx * 4);
 		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_TXDB:
@@ -140,7 +140,7 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
 {
 	u32 dat;
 
-	dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
+	dat = imx_mu_read(priv, priv->dcfg->xRR + (cp->idx) * 4);
 	mbox_chan_received_data(cp->chan, (void *)&dat);
 
 	return 0;
@@ -172,7 +172,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 		}
 
 		for (i = 0; i < 4 && i < msg->hdr.size; i++)
-			imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
+			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
 		for (; i < msg->hdr.size; i++) {
 			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR,
 						 xsr,
@@ -182,7 +182,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 				dev_err(priv->dev, "Send data index: %d timeout\n", i);
 				return ret;
 			}
-			imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
+			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
 		}
 
 		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
@@ -204,7 +204,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 	u32 xsr;
 
 	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
-	*data++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
+	*data++ = imx_mu_read(priv, priv->dcfg->xRR);
 
 	if (msg.hdr.size > sizeof(msg) / 4) {
 		dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on RX; got: %i bytes\n", sizeof(msg), msg.hdr.size << 2);
@@ -218,7 +218,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 			dev_err(priv->dev, "timeout read idx %d\n", i);
 			return ret;
 		}
-		*data++ = imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
+		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
 	}
 
 	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
@@ -564,8 +564,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
 	.init	= imx_mu_init_generic,
-	.xTR	= {0x0, 0x4, 0x8, 0xc},
-	.xRR	= {0x10, 0x14, 0x18, 0x1c},
+	.xTR	= 0x0,
+	.xRR	= 0x10,
 	.xSR	= 0x20,
 	.xCR	= 0x24,
 };
@@ -574,8 +574,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.tx	= imx_mu_generic_tx,
 	.rx	= imx_mu_generic_rx,
 	.init	= imx_mu_init_generic,
-	.xTR	= {0x20, 0x24, 0x28, 0x2c},
-	.xRR	= {0x40, 0x44, 0x48, 0x4c},
+	.xTR	= 0x20,
+	.xRR	= 0x40,
 	.xSR	= 0x60,
 	.xCR	= 0x64,
 };
@@ -584,8 +584,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_scu_tx,
 	.rx	= imx_mu_scu_rx,
 	.init	= imx_mu_init_scu,
-	.xTR	= {0x0, 0x4, 0x8, 0xc},
-	.xRR	= {0x10, 0x14, 0x18, 0x1c},
+	.xTR	= 0x0
+	.xRR	= 0x10
 	.xSR	= 0x20,
 	.xCR	= 0x24,
 };
-- 
2.30.0

