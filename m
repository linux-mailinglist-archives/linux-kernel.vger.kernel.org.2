Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D479394010
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbhE1JfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:35:14 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:31974
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235393AbhE1JfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:35:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5+Xc0KXtf/PtsLEjXyFG83r3e9pnWjxuKPP2iJTX6Be+MbyZ0pLCUibuafEkFo+kDgr2xiST2E2G3Sau0XK+w0t+M0FEXYr+3aCDxr656FRyZLZU+Rxa/VbLzSOXNXWSc5e8ud/gqDx0o44MF4Dd8nN/bDChrvQryytsrqf1Vz4zlx9SwxFFNYxoazo6l0Uyoqd1g/M3X31p+Cs9MY8/Y6j3lRPEiCQ4r+soRUi1daRq/2NzSaVT8+owtKIVmCkYTY0E6zFCbnseNbk+qbN7OWMw14mzj/9JAq0xsRVMQ/W5XS6Kwnry4WaYM95f3N9ucAmcusailcgIM3lFI4DVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2IsQF9x1U+XldRTire0kFdqpmTCrVlVdeAlsaqg0M=;
 b=LCnBjowL2x/8RRa728pZi3/lszo5bKui4Znu36AqkAGmyvutnKSYo96izhroE6HLe1nvAAhKykCz7a5zl3aGrXohK//vsKoI/vallVhpm2dDmi1AWite+5X6rQCudY8DMaKvIJPyNv9eh5xIJWqNSyLH7U5nsTI6utnpZzLgMTS+6Ciw9XWDrsfN0Dz6NQt7d4oLVNsuM+TjjXHGy8y40FfN2z9aksFn5Jp5dOjHVOELLLm0AGutCHdf5bNm+rnpQTZqaYwHY9VKGg7KBlUKxGL3RTU6a6RBNTDYYDV3Tj9ChXDrrqwYO6SZV9eBUI/BYR6llebH6lWmVK4qUyOCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2IsQF9x1U+XldRTire0kFdqpmTCrVlVdeAlsaqg0M=;
 b=Avtu8iIXmAH89FvpB8GNTovFOldZu9cAjytUImOxaNiswqDk3fJMM09f7qO2c/OJViIEFZbzxoXLj1v39lt/ZU3zdjFQiGYl6jbQW1fAvoGXK4fVSPu7+FV6V2v3iJczIL/EZQo01/+EtFXXxxUQQPSw+ShZR5vAgKYbkk2PnWU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7302.eurprd04.prod.outlook.com (2603:10a6:10:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 09:33:28 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 09:33:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] mailbox: imx: add xSR/xCR register array
Date:   Fri, 28 May 2021 18:06:02 +0800
Message-Id: <20210528100603.21759-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210528100603.21759-1-peng.fan@oss.nxp.com>
References: <20210528100603.21759-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 09:33:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 592194e9-b28d-41aa-c495-08d921bba63c
X-MS-TrafficTypeDiagnostic: DBAPR04MB7302:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7302C4B80562001D7A29C524C9229@DBAPR04MB7302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tkc6OY/MP/zDz+XPXyt63hDR86oJk3f1+3DiO8zmsCEXppN1HLshCCAyEMskUcdwEkuzlgwD2IzeLV+rjBguCYpB5Qn7fDXpDCsRJMmzCQt5Zw4Uoao8nEBlAmXhliWDlrZMTIWc9Q1qH8h+NRFOwZKCUg5PW1mKMrQ9kCVtKHkV3HDaJTPsyKNOfg2uyXnc5PaldkC5hPE9gqruzyydRVZPQdpmhfR4uOE4rN8JXPRXiXu4BHZUGAwIBQNz5kqemSJaEKMbJmtBic4B9vdmZZI4ziLwDTMb/tTRW/KiIo608DvPqZRQjICKv+lrd9g3NHJHn3PYoUZLTYlzn/A3ry61jCKz8w6GfxtfjqoOtsejQ9/33mBT+ZMxmzJy98ka5/C96414N0hkyTUcTrvzclXXoygw90MwULfCTg4JDTtsp72ufO2FHPlzcs+sM3ZTqm5UC3KJX4BIA7U2mPrM4wI7ryeXYB5Y7sPIJUqjHnzI6ftcZ9XK3+lVnScDIXSe84ApCiHcoN09f0qnvReLfT+l4yErl8bWTkW1xV8wPY2yic0FzwhwAsfqOf2XtPMrjc9BmgCeaftk6YmGl42GsdkXKrbzjcDLiDhEHOFPS6VzEa3xG769N1xRb2t+ggakyffEesNClYd1YyEEi1xIU9hgB1B4Xow2hVkPEPDJnio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(2616005)(26005)(38350700002)(186003)(86362001)(8936002)(6666004)(8676002)(316002)(4326008)(2906002)(83380400001)(66476007)(66556008)(15650500001)(6486002)(6506007)(52116002)(38100700002)(7416002)(956004)(5660300002)(66946007)(16526019)(478600001)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Z2deogKOe/dWGPQzkCNb9+h236JRmezU3Ytap/xeqMNR7bu+r3w19LlJiCPj?=
 =?us-ascii?Q?M/gzsY5dhD9deHm77X0o0bD/rwW8Iw5+qZiZ2EzshmNXxA80niiPnEpre64k?=
 =?us-ascii?Q?KC9+j9k4NmpTLUlKwiXGv+gB89CyLvgtx9HU6WHspeireFC6i6ZLjijdh62z?=
 =?us-ascii?Q?G+RloXj93iwD4kA/9+RPtEXCIO2apMUSlXDLqPHah9hCCnO9k5t0wel4CtoW?=
 =?us-ascii?Q?VhzDCNlm6XsbPWlVjGypbcHIhRaDCCb6m25DAcZvu2Gc5dhmif0UFhC6bgQC?=
 =?us-ascii?Q?rHc/nJG/I5IFDYdddhrdK5Xg2XpzkDf7gU8UKWtKWkbLkMFCXZuB8XxV4D+d?=
 =?us-ascii?Q?WrGc9F/Wnd7osN1fovZZHiIx+YepawapxW7vhDmDxNHBmZotmJiJymx6g2S3?=
 =?us-ascii?Q?OSb6P+PbMAqpkccSI3562LafQE/RmistU2CyUdCjkdRPc1p99mC7a0KCMSvh?=
 =?us-ascii?Q?zNTu1d8zTmd3qhR9adJGP1797kTHhGPIVF2uDGhIWULVLT0qb3NF3zzwL+FK?=
 =?us-ascii?Q?YRU8na6KPkewX6Jcj/GIZQYz6NZSzH9D89rboZBMfXYRMI32APCtNObqXt6q?=
 =?us-ascii?Q?3KNZNWomhwcfhgWWIoxfi6DnJzU099LheTBcnCIUR4G93FvanA3+dSz/cnWj?=
 =?us-ascii?Q?EOhAB37ab7qF7k342k2B6B3ykzvdulX3svGHN02zW+tJy3QY7Pg5I1LHAVV7?=
 =?us-ascii?Q?NqH6+HS2BOnY3w9Ozwpbbod/JDn4JYDZs13Whbppc8wcLpEGsqcSC7J2k16T?=
 =?us-ascii?Q?Ig9eGr3cdrtcUsjy50vHDDEejUIjhAlCVIjHpkfvGTztCv73zI8lC/0pzHmr?=
 =?us-ascii?Q?ju1lU/HmDSZJ/AFR3wrmRaSj57YM1r/dGX15fflPd4xEN8npOfBvN2yDGjQ7?=
 =?us-ascii?Q?WkvPwYBznjdr5+ShIHr1AJcAjXoJNr/9yPUcmTj75xX0es2phbx2b8womoYy?=
 =?us-ascii?Q?iJGvO7RqWXKll8OE4wRpWhMLwYr5hoqTsbCyskYSKsuT5bp///dMQwOuCAw+?=
 =?us-ascii?Q?UxX9T1KL2jC/imrZITsmjCESEwJtC+tdZXyx9mpQWmxywloMyTPgzRWvJq13?=
 =?us-ascii?Q?JC2UhHn4rj0yu8cz4e4y/jOdIG/RqvIXvvzrwDdPX4W2D49KZohIJ5dAgbiR?=
 =?us-ascii?Q?QOjFV828AxeNJaaNVvmI9DKNZXvO9ODFnVjkWwKLp0e5853O21FrcCW2Y4lu?=
 =?us-ascii?Q?HKdla1XzLxJK6E2t8PkE1jU0Lf7XxGl65FOBmSbaQvlwBTkB3xLbg4JIV2MI?=
 =?us-ascii?Q?IaQFIQmyuVKfBAHCV9Its0LCgkOGEDFF9KmyomIglzOKWdIHN4p81Mvk7xNV?=
 =?us-ascii?Q?+pkDOdLQCQXc2ohGavusiS9nI+rcYpp2UV+Zcn+Dqe1+ew=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592194e9-b28d-41aa-c495-08d921bba63c
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 09:33:28.4215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKCxarGnAjbF3vC7Cd4SovPgWhR6ROx4wkqpihWW2zoJmmJeQJuiU4zcCGeyVoRsXF4mVYLq0exIQYpxe5Y1Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

We are going to add a new platform which has 4 status registers(SR, TSR,
RSR, GSR) and 4 control registers(CR, TCR, RCR, GCR), so extend xSR
and xCR to register array and adapt code to use it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 96 ++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index bd7758c32a80..f5dadcc827aa 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -41,6 +41,21 @@ enum imx_mu_chan_type {
 	IMX_MU_TYPE_RXDB,	/* Rx doorbell */
 };
 
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+};
+
 struct imx_sc_rpc_msg_max {
 	struct imx_sc_rpc_msg hdr;
 	u32 data[7];
@@ -67,7 +82,7 @@ struct imx_mu_priv {
 	struct clk		*clk;
 	int			irq;
 
-	u32 xcr;
+	u32 xcr[4];
 
 	bool			side_b;
 };
@@ -78,8 +93,8 @@ struct imx_mu_dcfg {
 	void (*init)(struct imx_mu_priv *priv);
 	u32	xTR;		/* Transmit Register0 */
 	u32	xRR;		/* Receive Register0 */
-	u32	xSR;		/* Status Register */
-	u32	xCR;		/* Control Register */
+	u32	xSR[4];		/* Status Registers */
+	u32	xCR[4];		/* Control Registers */
 };
 
 static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
@@ -97,16 +112,16 @@ static u32 imx_mu_read(struct imx_mu_priv *priv, u32 offs)
 	return ioread32(priv->base + offs);
 }
 
-static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, u32 set, u32 clr)
+static u32 imx_mu_xcr_rmw(struct imx_mu_priv *priv, enum imx_mu_xcr type, u32 set, u32 clr)
 {
 	unsigned long flags;
 	u32 val;
 
 	spin_lock_irqsave(&priv->xcr_lock, flags);
-	val = imx_mu_read(priv, priv->dcfg->xCR);
+	val = imx_mu_read(priv, priv->dcfg->xCR[type]);
 	val &= ~clr;
 	val |= set;
-	imx_mu_write(priv, val, priv->dcfg->xCR);
+	imx_mu_write(priv, val, priv->dcfg->xCR[type]);
 	spin_unlock_irqrestore(&priv->xcr_lock, flags);
 
 	return val;
@@ -121,10 +136,10 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
 		imx_mu_write(priv, *arg, priv->dcfg->xTR + cp->idx * 4);
-		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_TXDB:
-		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIRn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(cp->idx), 0);
 		tasklet_schedule(&cp->txdb_tasklet);
 		break;
 	default:
@@ -174,7 +189,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 		for (i = 0; i < 4 && i < msg->hdr.size; i++)
 			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
 		for (; i < msg->hdr.size; i++) {
-			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR,
+			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_TSR],
 						 xsr,
 						 xsr & IMX_MU_xSR_TEn(i % 4),
 						 0, 100);
@@ -185,7 +200,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
 		}
 
-		imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(cp->idx), 0);
 		break;
 	default:
 		dev_warn_ratelimited(priv->dev, "Send data on wrong channel type: %d\n", cp->type);
@@ -203,7 +218,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 	int i, ret;
 	u32 xsr;
 
-	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
+	imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(0));
 	*data++ = imx_mu_read(priv, priv->dcfg->xRR);
 
 	if (msg.hdr.size > sizeof(msg) / 4) {
@@ -212,7 +227,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 	}
 
 	for (i = 1; i < msg.hdr.size; i++) {
-		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR, xsr,
+		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
 					 xsr & IMX_MU_xSR_RFn(i % 4), 0, 100);
 		if (ret) {
 			dev_err(priv->dev, "timeout read idx %d\n", i);
@@ -221,7 +236,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 		*data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
 	}
 
-	imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
+	imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(0), 0);
 	mbox_chan_received_data(cp->chan, (void *)&msg);
 
 	return 0;
@@ -241,19 +256,22 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 	struct imx_mu_con_priv *cp = chan->con_priv;
 	u32 val, ctrl;
 
-	ctrl = imx_mu_read(priv, priv->dcfg->xCR);
-	val = imx_mu_read(priv, priv->dcfg->xSR);
-
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
+		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_TCR]);
+		val = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_TSR]);
 		val &= IMX_MU_xSR_TEn(cp->idx) &
 			(ctrl & IMX_MU_xCR_TIEn(cp->idx));
 		break;
 	case IMX_MU_TYPE_RX:
+		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_RCR]);
+		val = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_RSR]);
 		val &= IMX_MU_xSR_RFn(cp->idx) &
 			(ctrl & IMX_MU_xCR_RIEn(cp->idx));
 		break;
 	case IMX_MU_TYPE_RXDB:
+		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_GCR]);
+		val = imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_GSR]);
 		val &= IMX_MU_xSR_GIPn(cp->idx) &
 			(ctrl & IMX_MU_xCR_GIEn(cp->idx));
 		break;
@@ -265,12 +283,12 @@ static irqreturn_t imx_mu_isr(int irq, void *p)
 		return IRQ_NONE;
 
 	if (val == IMX_MU_xSR_TEn(cp->idx)) {
-		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(cp->idx));
 		mbox_chan_txdone(chan, 0);
 	} else if (val == IMX_MU_xSR_RFn(cp->idx)) {
 		priv->dcfg->rx(priv, cp);
 	} else if (val == IMX_MU_xSR_GIPn(cp->idx)) {
-		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR);
+		imx_mu_write(priv, IMX_MU_xSR_GIPn(cp->idx), priv->dcfg->xSR[IMX_MU_GSR]);
 		mbox_chan_received_data(chan, NULL);
 	} else {
 		dev_warn_ratelimited(priv->dev, "Not handled interrupt\n");
@@ -317,10 +335,10 @@ static int imx_mu_startup(struct mbox_chan *chan)
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_RX:
-		imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(cp->idx), 0);
 		break;
 	case IMX_MU_TYPE_RXDB:
-		imx_mu_xcr_rmw(priv, IMX_MU_xCR_GIEn(cp->idx), 0);
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIEn(cp->idx), 0);
 		break;
 	default:
 		break;
@@ -342,13 +360,13 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
-		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
+		imx_mu_xcr_rmw(priv, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(cp->idx));
 		break;
 	case IMX_MU_TYPE_RX:
-		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(cp->idx));
+		imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(cp->idx));
 		break;
 	case IMX_MU_TYPE_RXDB:
-		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_GIEn(cp->idx));
+		imx_mu_xcr_rmw(priv, IMX_MU_GCR, 0, IMX_MU_xCR_GIEn(cp->idx));
 		break;
 	default:
 		break;
@@ -444,7 +462,8 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 		return;
 
 	/* Set default MU configuration */
-	imx_mu_write(priv, 0, priv->dcfg->xCR);
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
 }
 
 static void imx_mu_init_scu(struct imx_mu_priv *priv)
@@ -466,7 +485,8 @@ static void imx_mu_init_scu(struct imx_mu_priv *priv)
 	priv->mbox.of_xlate = imx_mu_scu_xlate;
 
 	/* Set default MU configuration */
-	imx_mu_write(priv, 0, priv->dcfg->xCR);
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
 }
 
 static int imx_mu_probe(struct platform_device *pdev)
@@ -566,8 +586,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
 	.init	= imx_mu_init_generic,
 	.xTR	= 0x0,
 	.xRR	= 0x10,
-	.xSR	= 0x20,
-	.xCR	= 0x24,
+	.xSR	= {0x20, 0x20, 0x20, 0x20},
+	.xCR	= {0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
@@ -576,8 +596,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
 	.init	= imx_mu_init_generic,
 	.xTR	= 0x20,
 	.xRR	= 0x40,
-	.xSR	= 0x60,
-	.xCR	= 0x64,
+	.xSR	= {0x60, 0x60, 0x60, 0x60},
+	.xCR	= {0x64, 0x64, 0x64, 0x64},
 };
 
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
@@ -586,8 +606,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
 	.init	= imx_mu_init_scu,
 	.xTR	= 0x0
 	.xRR	= 0x10
-	.xSR	= 0x20,
-	.xCR	= 0x24,
+	.xSR	= {0x20, 0x20, 0x20, 0x20},
+	.xCR	= {0x24, 0x24, 0x24, 0x24},
 };
 
 static const struct of_device_id imx_mu_dt_ids[] = {
@@ -601,9 +621,12 @@ MODULE_DEVICE_TABLE(of, imx_mu_dt_ids);
 static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
+	int i;
 
-	if (!priv->clk)
-		priv->xcr = imx_mu_read(priv, priv->dcfg->xCR);
+	if (!priv->clk) {
+		for (i = 0; i < IMX_MU_xCR_MAX; i++)
+			priv->xcr[i] = imx_mu_read(priv, priv->dcfg->xCR[i]);
+	}
 
 	return 0;
 }
@@ -611,6 +634,7 @@ static int __maybe_unused imx_mu_suspend_noirq(struct device *dev)
 static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 {
 	struct imx_mu_priv *priv = dev_get_drvdata(dev);
+	int i;
 
 	/*
 	 * ONLY restore MU when context lost, the TIE could
@@ -620,8 +644,10 @@ static int __maybe_unused imx_mu_resume_noirq(struct device *dev)
 	 * send failed, may lead to system freeze. This issue
 	 * is observed by testing freeze mode suspend.
 	 */
-	if (!imx_mu_read(priv, priv->dcfg->xCR) && !priv->clk)
-		imx_mu_write(priv, priv->xcr, priv->dcfg->xCR);
+	if (!imx_mu_read(priv, priv->dcfg->xCR[0]) && !priv->clk) {
+		for (i = 0; i < IMX_MU_xCR_MAX; i++)
+			imx_mu_write(priv, priv->xcr[i], priv->dcfg->xCR[i]);
+	}
 
 	return 0;
 }
-- 
2.30.0

