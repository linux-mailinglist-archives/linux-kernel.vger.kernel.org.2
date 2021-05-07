Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721D3376312
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbhEGJsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:48:41 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:2912
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236826AbhEGJsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:48:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/CR6m7fRaAYB+isUSlBuxkcfBVysZ/lyFrbItvQ+ANI37R9V5514PxwLGbZ3cD8EKScgwtluYwAXNSnLrJ8vRwJPNpW5wCKKQEZ10rBshq7as8mrtUR8m+a/zmlU/pkmVwKgQijb1vGXUVVIJPgrY5Ht0z7oCYcEyWpOOUKcoI1hUST0lXrLipe8FYxDVhLx62mO5exO78fVkB5/jxkgeg/8WqdL/w5ezz6xg29rQEQawBSy18R2Vp35V/4S87ebggHgdPEyjyRaB+Xe7WM2e8pPe4mEy/lWb4wQuRWXKcQGSjw5kkujqpSqLi4fH63l/rR61t7vb/nsGl/oshabw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNYroyI2UN6Umsg6IIK+wfhqiMhS1hdXL7p0qTR/PHA=;
 b=ZRITZZPCnPqHp7K/yirkguIaTmVJh4Crn23WT4hiVR302MKPjBoqiqawVT956RLQG+vSO/7EAPWjyLDS8Nd27O5pn3nBTKlAHBXhGFAk/9d6Dn/qYxIcpqXj+wiBw/LYNQzEl0mAsfTky2by/AqMME9CLjapRdBxKQ2Rb694Tvjs2KCF0LVG1AjWhgSRoi6CxeT3FZU9JyvxmPoNvDT8ppJtFtBw5BbdxxXaFH8iYhYc93Il5CajkPSsxz1OpvV069wTI4XZm0VVaRRe7Pb9LPsShfGxMiJJaMKs7miWQbEHmJTxfMLczN9XO/Ck5oJPvA8NTxB1uTfMxCdVjR/h0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNYroyI2UN6Umsg6IIK+wfhqiMhS1hdXL7p0qTR/PHA=;
 b=GHqohYqtTkEJvG0aHLUFWuotAv0kyBGe1bC0VGqyrRtOJa8A/y5ylF+iPMHi+0PF2BVxnMHt45KM2SYtdZrAceSYF0FzhTJ54C98xAlbFKuALzFxw5c6USbci0dhX2hKtQ6tARxlL1SMpXLdf9Lu3gaA71wSfGLbxGgXGKbOQ2Q=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 09:47:34 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 09:47:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] mailbox: imx-mailbox: support i.MX8ULP MU
Date:   Fri,  7 May 2021 18:19:26 +0800
Message-Id: <20210507101926.25631-5-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 09:47:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cd7f834-3c0b-4739-1742-08d9113d23d2
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68575CA01FB6E84E49F9201DC9579@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdKfskGWUXFjwA4bhJTgrqVsvo8uYcVZ1mFUOM/IPYqxcSP3/6/E21KDJLVcSz8DMIn8UVUnJCxc/ZZ9Ssz2o0co+xO/vTfPr+ihHO4e/WmLggDdpdsOASbrga5+pRQbZ+XmsxpmE0w4gdYvXcvqwSHhZCAQTvXMwKXWp08diRDRBbhU02YRiFSY1ylQDlXmZZc7x8y+tUiV7IdVTF/c41xEjWRmPmmmCoS+c+BpX434bFyt+sDPzlplhDAr1PuZDFoK4AYEWS+dTfNAmN7ZN/e17S5kwM6T47zo5xLH0x06LS78uJJu2E7ga9PX1LYtbrjPCV5ycwKAPiE5WWD1moDaHKt894ePvxNF1qG0jn0eiMsmMW3Z4DwWluI/b3yZhzKMocFv2ILkHZGaCkIodLhl0oR2rTfd1shzJTrPzB5nR55nvDJpTvy+QCghAiBl088o6zI8QCtmmNki+cSWtKWQr2Ia30S14NezHPsMKOdfHeEK4QUNWNQ2wCL1vF2otvomT5+y5mdvQ4ZFcYAxicaal7W9bRphRSJVMUOS9ObCpD7u70s20ID9cDDBunWKI7/Tyxb3fYLV45kUIJrHUt3fa9nkEvTtwtk+hH3fQqq3y1GJZhMkW72eh2z7OV4rA6JbNVMB0I7f1v1HsaMW2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(86362001)(4326008)(478600001)(26005)(7416002)(6486002)(83380400001)(6666004)(8936002)(316002)(38100700002)(5660300002)(66946007)(2616005)(956004)(1076003)(8676002)(2906002)(15650500001)(6512007)(16526019)(66556008)(66476007)(52116002)(6506007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aPkR4I/UUNl/GQXsJtWU7pJeIrtkxBWW51EQ3yhBwwp+f5CMzXjhicCEdfIy?=
 =?us-ascii?Q?KPMzbjhRgRuEyIlqVefMAF3kJVwILaFXNdGe5LemjLRTvekYv9XWtPt6ghYx?=
 =?us-ascii?Q?A3VqAJEsKEpIOi1Qe0xx4hnrSe/87Wytuq2lII6hkeIgNZptRJQzZd4zwZKH?=
 =?us-ascii?Q?q85aUOBQJxAYcy2DajCk6vVqSyAQN7wKD/wuZLO9RGoH90vjAwkM9nJoHevm?=
 =?us-ascii?Q?T+syht1oBlG6qjOQa1vigDrDeZ+vWeupWCaq+nIECjTFZLAJpRvShjVtf2ql?=
 =?us-ascii?Q?I/1g8gCGb8b7Rk6WavRDPZPFa7LJMB48Wt9ZbljepkbO2KRfaUqxDAwoosN5?=
 =?us-ascii?Q?lDP/MA3er1znU68wEknGpLwTXPkAmC2D3oEmXoYEpqvzESLD4CUFvhXzHu9Q?=
 =?us-ascii?Q?dWc82gzbO+Ew9SFfhzFBR0N9D02prhTlP0lSRxiITAt+737SMFwbCGNZ4urj?=
 =?us-ascii?Q?pkyAbhOIUG1xNiLda3lZyum0Hr9Yrfj9SBER60JaySjUnH5tKvU+mrDSZVMl?=
 =?us-ascii?Q?gXPUBPGUOlNmZS8P7Mzz+GJjY0rXlJWUlBcBPYbmPJTkunqEUdS+oX/Kf6jr?=
 =?us-ascii?Q?0XyqS4i96czJ/6aq4vpI4wSkoJz0q3ALSe6IJon22ePB4cPL61h8qsMbhEdx?=
 =?us-ascii?Q?MErNtjevMCTSvNTMVKWoHRcYpSHPRJXI9EPFqGL2ruu9yksztMiRC3eocMJ9?=
 =?us-ascii?Q?9emv+OjhLDNRTawpmO0Y8x43NKjRwdpzJ9r1Md0G8FBQN26bL6aLZWVfNS2g?=
 =?us-ascii?Q?LQezohnORMoBxMvan6dC/jCImOB7wsGsNc+gO/Gt1gHFyVEkbbRXJ2S40VID?=
 =?us-ascii?Q?qeL3osqbLU1n8fX11op/ycpKpfncc9h0j72e72FkWEFE/n1Ki8tTdvCttR33?=
 =?us-ascii?Q?DmguKiPHePcp+TOjwS+86qh8iWMgcwk4+D2fNafMFkKGp2QAA221WKjufr0E?=
 =?us-ascii?Q?XeJn9bjoiGza7tdhsWoDPMBO5Nu9ByfS0dQfThk1cXBcxGK/QBlo6fDh5ktA?=
 =?us-ascii?Q?105+L0bpPSGsfl/vjV/2TGrpiqLwckLqkIpa1k/6A6l9pEPnZCQZZXSDvsP4?=
 =?us-ascii?Q?Ud6yBzUY5E5d1MZQDqvQRVaJla8jRAuCiIrSkYF4y+D8nxDoMobWzANrJc1Z?=
 =?us-ascii?Q?TO6Ip9Y1hHPZI5fHCraBF2punw3uLVzN9g65oHJ/lVCOfy5hNUsfsVVxDh50?=
 =?us-ascii?Q?XbiG/pki+K+rTgKET3xG7DKuiYmyFCC03lPafyrO01t0LCri2AagsadQvLDW?=
 =?us-ascii?Q?IGVIzWz/ec/OoFNm82RDVAEVm/eUkXTG999mwkd0LLkAFGw+jkwYbTJc1+0r?=
 =?us-ascii?Q?8V2KHCOtBbDtshnfmNcSd+uW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd7f834-3c0b-4739-1742-08d9113d23d2
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 09:47:34.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7gOAIIAebsAY/39yyx12JeoDG7hdbF/eVTNFTljOSSf4bLaIM02qxC4VMU2LCaaKG3E+4liD+YAPHhW2aN0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8ULP MU has different register layout and bit layout compared
with i.MX6SX/7ULP/8.

So add enum imx_mu_type to show it is IMX_MU_V2 or IMX_MU_V1.

For IMX_MU_V2 mu hardware, check it when calculating bit offset to get
the correct offset.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 100 +++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index f5dadcc827aa..7fc5b4c2d3af 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -15,20 +15,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
-#define IMX_MU_xSR_GIPn(x)	BIT(28 + (3 - (x)))
-#define IMX_MU_xSR_RFn(x)	BIT(24 + (3 - (x)))
-#define IMX_MU_xSR_TEn(x)	BIT(20 + (3 - (x)))
-#define IMX_MU_xSR_BRDIP	BIT(9)
-
-/* General Purpose Interrupt Enable */
-#define IMX_MU_xCR_GIEn(x)	BIT(28 + (3 - (x)))
-/* Receive Interrupt Enable */
-#define IMX_MU_xCR_RIEn(x)	BIT(24 + (3 - (x)))
-/* Transmit Interrupt Enable */
-#define IMX_MU_xCR_TIEn(x)	BIT(20 + (3 - (x)))
-/* General Purpose Interrupt Request */
-#define IMX_MU_xCR_GIRn(x)	BIT(16 + (3 - (x)))
-
 #define IMX_MU_CHANS		16
 /* TX0/RX0/RXDB[0-3] */
 #define IMX_MU_SCU_CHANS	6
@@ -87,16 +73,36 @@ struct imx_mu_priv {
 	bool			side_b;
 };
 
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2,
+};
+
 struct imx_mu_dcfg {
 	int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
 	int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
 	void (*init)(struct imx_mu_priv *priv);
+	enum imx_mu_type type;
 	u32	xTR;		/* Transmit Register0 */
 	u32	xRR;		/* Receive Register0 */
 	u32	xSR[4];		/* Status Registers */
 	u32	xCR[4];		/* Control Registers */
 };
 
+#define IMX_MU_xSR_GIPn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+
+
 static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
 {
 	return container_of(mbox, struct imx_mu_priv, mbox);
@@ -136,10 +142,10 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
 		imx_mu_write(priv, *arg, priv->dcfg->xTR + cp->idx * 4);
-		imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(priv->dcfg->type, cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_TXDB:
-		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dcfg->type, cp->idx), 0);
 		tasklet_schedule(&cp->txdb_tasklet);
 		break;
 	default:
@@ -191,7 +197,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 		for (; i < msg->hdr.size; i++) {
 			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_TSR],
 						 xsr,
-						 xsr & IMX_MU_xSR_TEn(i % 4),
+						 xsr & IMX_MU_xSR_TEn(priv->dcfg->type, i % 4),
 						 0, 100);
 			if (ret) {
 				dev_err(priv->dev, "Send data index: %d timeout\n", i);
@@ -200,7 +206,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
 		}
 
-		imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(priv->dcfg->type, cp->idx), 0);
 		break;
 	default:
 		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
@@ -218,7 +224,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 	int i, ret;
 	u32 xsr;
 
-	imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(0));
+	imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(priv->dcfg->type, 0));
 	*data++ = imx_mu_read(priv, priv->dcfg->xRR);
 
 	if (msg.hdr.size > sizeof(msg) / 4) {
@@ -228,7 +234,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 
 	for (i = 1; i < msg.hdr.size; i++) {
 		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
-					 xsr & IMX_MU_xSR_RFn(i % 4), 0, 100);
+					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0, 100);
 		if (ret) {
 			dev_err(priv->dev, "timeout read idx %d\n", i);
 			return ret;
@@ -236,7 +242,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
 	}
 
-	imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(0), 0);
+	imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, 0), 0);
 	mbox_chan_received_data(cp->chan, (void *)&msg);
 
 	return 0;
@@ -260,20 +266,20 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 	case IMX_MU_TYPE_TX:
 		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_TCR]);
 		val = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_TSR]);
-		val &= IMX_MU_xSR_TEn(cp->idx) &
-			(ctrl & IMX_MU_xCR_TIEn(cp->idx));
+		val &= IMX_MU_xSR_TEn(priv->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_TIEn(priv->dcfg->type, cp->idx));
 		break;
 	case IMX_MU_TYPE_RX:
 		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_RCR]);
 		val = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_RSR]);
-		val &= IMX_MU_xSR_RFn(cp->idx) &
-			(ctrl & IMX_MU_xCR_RIEn(cp->idx));
+		val &= IMX_MU_xSR_RFn(priv->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_RIEn(priv->dcfg->type, cp->idx));
 		break;
 	case IMX_MU_TYPE_RXDB:
 		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_GCR]);
 		val = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_GSR]);
-		val &= IMX_MU_xSR_GIPn(cp->idx) &
-			(ctrl & IMX_MU_xCR_GIEn(cp->idx));
+		val &= IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx));
 		break;
 	default:
 		break;
@@ -282,13 +288,17 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 	if (!val)
 		return IRQ_NONE;
 
-	if (val == IMX_MU_xSR_TEn(cp->idx)) {
-		imx_mu_xcr_rmw(priv, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(cp->idx));
+	if ((val == IMX_MU_xSR_TEn(priv->dcfg->type, cp->idx)) &&
+	    (cp->type == IMX_MU_TYPE_TX)) {
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(priv->dcfg->type, cp->idx));
 		mbox_chan_txdone(chan, 0);
-	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
+	} else if ((val == IMX_MU_xSR_RFn(priv->dcfg->type, cp->idx)) &&
+		   (cp->type == IMX_MU_TYPE_RX)) {
 		priv->dcfg->rx(priv, cp);
-	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
-		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR[IMX_MU_GSR]);
+	} else if ((val == IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx)) &&
+		   (cp->type == IMX_MU_TYPE_RXDB)) {
+		imx_mu_write(priv, IMX_MU_xSR_GIPn(priv->dcfg->type, cp->idx),
+			     priv->dcfg->xSR[IMX_MU_GSR]);
 		mbox_chan_received_data(chan, NULL);
 	} else {
 		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
@@ -335,10 +345,10 @@ static int imx_mu_startup(struct mbox_chan *chan)
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_RX:
-		imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_RXDB:
-		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx), 0);
 		break;
 	default:
 		break;
@@ -360,13 +370,13 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
-		imx_mu_xcr_rmw(priv, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(cp->idx));
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(priv->dcfg->type, cp->idx));
 		break;
 	case IMX_MU_TYPE_RX:
-		imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(cp->idx));
+		imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(priv->dcfg->type, cp->idx));
 		break;
 	case IMX_MU_TYPE_RXDB:
-		imx_mu_xcr_rmw(priv, IMX_MU_GCR, 0, IMX_MU_xCR_GIEn(cp->idx));
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR, 0, IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx));
 		break;
 	default:
 		break;
@@ -600,12 +610,23 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.xCR	= {0x64, 0x64, 0x64, 0x64},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
+	.tx	= imx_mu_generic_tx,
+	.rx	= imx_mu_generic_rx,
+	.init	= imx_mu_init_generic,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x114, 0x120, 0x128},
+};
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.tx	= imx_mu_scu_tx,
 	.rx	= imx_mu_scu_rx,
 	.init	= imx_mu_init_scu,
-	.xTR	= 0x0
-	.xRR	= 0x10
+	.xTR	= 0x0,
+	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
 	.xCR	= {0x24, 0x24, 0x24, 0x24},
 };
@@ -613,6 +634,7 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
+	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ },
 };
-- 
2.30.0

