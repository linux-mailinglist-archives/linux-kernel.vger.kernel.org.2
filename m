Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23FF376310
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhEGJsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 05:48:36 -0400
Received: from mail-db8eur05on2067.outbound.protection.outlook.com ([40.107.20.67]:2912
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236835AbhEGJsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 05:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZ+l3U/K7GZmXsMf4p6HXLICzbmDq7JDt8EXbDIG2NBBKXI5JRH/E/nzLk31vkrGgme/uh48VX8kVx7F/2L+MZ8KzLyF0W7K86y9S5pYIE8u92zDpx/JfiOnLHIJYjsn4IT3bCEeQEuas7HXXSR9kKg0cckxxT3TbcBAZLhwi8KcBH0pe8H6G6zgFhQr/1uNxnSM7OrNLkeTk8pDO3JuF0cMjxzJC3bw1xH/bjnz1rlfvBjQqx9X8XYOz2TSr1jkbr4RBSt//jrplQXLa83ZMX4SHL1EWx6EP7XRJeLPEXRNCBZOH2zOCG5BA0vbzIQGC5I6cOBtmLZcJvPRDEI1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2IsQF9x1U+XldRTire0kFdqpmTCrVlVdeAlsaqg0M=;
 b=IbmZnd5f5lENlz5DJ9abOjwKYY8gwQl3gCsPAgQlwsfLPv1P0GpnNCOV9cpjdRk43LMQM96px5mPke0a2Xp01v9s8G5MZncRgzLv6wpAQaTOonTSwXiYlqRo2X6e/xcgzUioP/oThNtf72MNJs0ouoLw0bn3RWE/xdEEnDTOtJCXZW4Lsl1jcS87L9JA9ZZl/eI7uc1glc2ujf+BViCMTssOA6giFrfo5MWw6tE9fBk0N9kgQJ174Ux/S8vOhmDbhjUA8qrk321ma0jF7wD9Vk7wXQDALlsGmd7IMc+WE6jrWbvynVNf6xNBfThzzNn7x/qW5WclESnla2Xvvkdbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s2IsQF9x1U+XldRTire0kFdqpmTCrVlVdeAlsaqg0M=;
 b=aE13CBNmkT5r0L8OtIdFTr856JDGBgs3maQgkvp1+sE/+Rm+NI1NR2PqduQulXdgCr7/AYRJLIqeJ9QQJ4oOJCsLt+koCXZE2/2pSHnaQvvcxcWxDhnd1B0Pjus9a+jpTtAeFxax9JD1i0O3+d9dzMy0DRG1dFjLmq3VPV0APWQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB6857.eurprd04.prod.outlook.com (2603:10a6:10:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Fri, 7 May
 2021 09:47:30 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4065.039; Fri, 7 May 2021
 09:47:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] mailbox: imx: add xSR/xCR register array
Date:   Fri,  7 May 2021 18:19:25 +0800
Message-Id: <20210507101926.25631-4-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0085.apcprd02.prod.outlook.com (2603:1096:4:90::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 09:47:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf221c8f-e619-4649-6af0-08d9113d2127
X-MS-TrafficTypeDiagnostic: DB8PR04MB6857:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB68574CC7A514528F75F3E58DC9579@DB8PR04MB6857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDjtA8SMjeQo/cKRAPQFAY5TbgfSl4b+1ZNWBv54hgnfBdUniTsd/YIwospCUnDCFmpt3QVoz5ZDD8QqxIFvz5pLO/crBwQGq3JxxaLjKaeCe90MLyPjCSJFcmMuQVwXoBljtsMzQRefOH3pL5rm0/PaobMs3ZYItY/mGrNcsDYkwrw5zYxi6v3tspognzHp8hF3FIhcndx/9wzzRzFmBtg3sIcqWXloWUZZJK5Pbg+IfMIldjqfcwdHdk5ad0qAF0GECeMSvFMfqtoEWTLYIrSfW8qsxxO3fhI/721BGwgWwOjvEs5vRk0M7OQ9ApMs71J7ARodOd7APxC0ulhgS6vTsBRS386+0WD8QawQzYuH2n/dR03GPpwADlGbkncz3pPr+vJf6LVdCgeFqK7oFZTvJ4sQXGlts4HoULTsc36x7klqRQL3cby+0Om6zue2nMpOjDQKRmCjxMchuVCmbjAJV6lF6ISUaMZwDB99Q+1q8/ELP11M82G/tc68GjfhDi6fDJMeM9r07iCuCj6SEop8YkIXGYJnOf51flbPrGwdNYFVCzPPqQ3zcvhwHm+V2qPAdi5igrW21PkLu6fza52gDdJTZzsalfJ7UbGCyC5BSof07NsZ08kCkF6rmtJIZ2uhBTOo0yxWtnNCvvJYgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(86362001)(4326008)(478600001)(26005)(7416002)(6486002)(83380400001)(8936002)(316002)(38100700002)(5660300002)(66946007)(2616005)(956004)(1076003)(8676002)(2906002)(15650500001)(6512007)(16526019)(66556008)(66476007)(52116002)(6506007)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kpdBTUf8KEzZH0ud2+eqqp0GKNIZM3sNHoA4ku0yJ7QrDyU1IBmQ1TTBiNoo?=
 =?us-ascii?Q?wDrfYINeHqgkTkf7CFcQyXegQ/BMB7CZsc8mLp2atKB+ib0pPkiKSi5LFgym?=
 =?us-ascii?Q?c7MmnhRPV4NzOhLk1K79X4nWq03N6O3xq3R/YEaYbrYCw2yAe75Awr+gCpB0?=
 =?us-ascii?Q?2lGEmnMEP/ytn78hxFUmwtKA4sjsneSlQzZpl7hzs0lqRTV0M4mxRNYtm75t?=
 =?us-ascii?Q?9pUyeokP0rSXLnPLlkPS5EH5nMnQtZ6pePwJFD28GB7AavjXTDrFmsfWqKYs?=
 =?us-ascii?Q?csNDsB0WAjzVZdL2ab6iEVwi7ithA58qiPTBUI0Y5um3kvVP2uK9aA7E4oJm?=
 =?us-ascii?Q?BQKuxQVcvHUuWxfVXGrDkgkL0E7l8jCsV6TVpyIa4INYYsgWYlGEZGBnXVGe?=
 =?us-ascii?Q?KBOJw5RjhhPFP6/kU+yOp5PHiPzSAhdNG4dxd9M2INc3zOjyafprQz2/Md6a?=
 =?us-ascii?Q?r4PO2pm3daRVYTBGgJYRyTOerElb8d3vBwgtdC0/+30tQjWBOVwBL5nXZ2x7?=
 =?us-ascii?Q?zF1eHsYJSGhERhJgM4eDnniIREkRlKZnfR/N1y6SHNoYyoQ32JwgsmtFLaTu?=
 =?us-ascii?Q?3B8NDR5e8q2sl8a5aZy6m1jMvErxHTeop20xQGYpdHBI4Pd/d4xuKPrmjTuq?=
 =?us-ascii?Q?FSXwwv3P5Tl4aGS2GV/IJOWfTaZkDsxFEKUK1XMJdT5iPaeo3j3envGrsDXP?=
 =?us-ascii?Q?aFrEAldGIEAacw8ySSp4O2lQFJydx8eE0HPG5cjoSh9VVPgEbRfzkNM2aVLn?=
 =?us-ascii?Q?rNadedrGfvqH+0YjmbtTuTpY5sE7ZA5kP0icDJnCNKK6vmFNqKJ/CZkNofMW?=
 =?us-ascii?Q?NtDNmeN2KJjKU8Jrva66wXY0nEG7H2jSXpnG2jAIJRQ0Wbzs7tIJqQdOloeg?=
 =?us-ascii?Q?kJm9wYkVo1M6cbdNukLRysMqzdAVMYTJ7EOfw6vs/6PVIyz5YycHTpNLq4jZ?=
 =?us-ascii?Q?KE5DnAe3ms5+l1kL5C10ns3vHLke544pAOgv/Tbo4jFiz+5lJgBqnpxWF3wJ?=
 =?us-ascii?Q?slPAUWIq/P3Ed475JRem7nAeQ4+Neb1uai3fSgKSDlaZuZ/WjXYaLf1jYeH9?=
 =?us-ascii?Q?XqQ8p98MjmZGAnP/JJvhWYVFkfh+YvzCZ5yh30e59Lycu2Ol57dqra6R5Qri?=
 =?us-ascii?Q?e17LS5pffcZEEnLJUiBeW6sn2Gf0AoJ0khntZdFAHNpUB7/58DDVmWMB2ER/?=
 =?us-ascii?Q?RdgqjEuZMfK0RO68betyBFAOyWJlrh2Fyo+6JZSvPTiaYbMEXCjOgHiho3kL?=
 =?us-ascii?Q?p//pobrhDu7+IYK2/5tF+4gIh6KHWl1ewLi3ZBSxBOLSaa+lmyxm+U50chd/?=
 =?us-ascii?Q?8HskiiE2AFXZaEXc6DDaRJDa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf221c8f-e619-4649-6af0-08d9113d2127
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 09:47:29.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLgTX9q590fpiy61O630/G88XK6e81KSb3A41ZIFQrsbRD+3nu7vXNU7vPcVjWh5AGXpHibCtXzzLW7prLQKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6857
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

