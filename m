Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2424F394011
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhE1JfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:35:19 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:20868
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235526AbhE1JfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:35:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3iV07cGPPyOWe+pwNp3dyWTujMzaCTa9TIVbBVJiemRCCjULvQD23M8Cg3MVndzof1q83xHs+uUNV3aU4QLi1qpHFxOrz7+ybSF0xVRdGZTjaUwGmXWM/LF98RLr/Zx9BDvLe2SoaaGmcaKX2nV6rz6a0o0yc1diVXTVblVO6PP1aFwA3RBYlh8PsOLBp8MR8Ak506zblt0fW5q9OMb2MaVGpW9hFBuJSHYh6QZYhf0VF35ZMKc0QEc2osk00324nbnKDbcjaKEuKka+BavAmjsdbR23fpsay+nBLaKnzqsWVoQcy5lodEQbuiY40tANGHm6Qwk8B8cGhiBLf3Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHaVeFH74yfJKRUNDbWglQ9FZ92itEWWIl/o49cWxGk=;
 b=NTL/OkOkfdDeRaMZP2xajjwoKKA3ZoVMmeEdV++9aXYP5mBJhojfItn4l+cJVis75bhZQ9a1nMwUol/b0prExonjj62/bB+uS12PKNYyWNlTLUJPZ1EUtHTQR8Bs8E9MdqZyQTnLu0fYUylsBlhf+DnFVy23KZzcZJxxbV/iFU6cXuAJYoYa6sAPJWRfmY1DsHl2YheL4GK13neVn+FgZ4ui0WTA5lpHDsDtk9GyS3oT1i1XIY8avlyxqWgiAc6ARRcpHaQE0nRSDer6dhhEyXPFVNXaiFii9e+nJLUyWFsSrTPocaZA69iFxZNh0SRhcFMNtAjZiU2CG2mJvxoC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHaVeFH74yfJKRUNDbWglQ9FZ92itEWWIl/o49cWxGk=;
 b=mX3pkAg5Kcj2FqOSgaGmEMNAeaNypT1jUvIghSI/Qzhx8SNbodEqlEwcDe0T9ChwsCUeGRHcBx4O8lE+wS56Lap5Mgj4ERmKB4n/hOnd0On1qC9gK/O02kIdeby1H8DjC+xazTCbPhvjn+7UmU3Wv6egBvFjhxYOaxdH8LaUZgE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7302.eurprd04.prod.outlook.com (2603:10a6:10:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 09:33:33 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 09:33:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/4] mailbox: imx-mailbox: support i.MX8ULP MU
Date:   Fri, 28 May 2021 18:06:03 +0800
Message-Id: <20210528100603.21759-5-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 09:33:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be788608-4f77-402f-ad8b-08d921bba8e6
X-MS-TrafficTypeDiagnostic: DBAPR04MB7302:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB7302693E4A998B38A080C214C9229@DBAPR04MB7302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgUnBnXOvAb39nt04GnrGjx5TqlaL0tDMYA2KAlzNrmCf9WjEi9jWqgVNQ5T+2xCMKc4nlyQmVEYhnqdJaInQfzDtm6mENbuG6HCMqfStcu4YjXvsoF0LCvlgTiEQqLFg4fHJCKhwvPJ8BjOE+my8S3f7pGIGdI2bVkOxaFV+lfIQxJfhxhapt28n+pUiLJYClRbdg2XZ6JWM+skUrwYChekiXRSF2YtszUcAr6i4PxI5ONN49OjKm7tnRGzQOTYgOZ+IE9jFCkr3+JbTaZub1ETZv40JOnOOWqRVgsmJvE1FYc7wQ5+0QdIsc1Z7YE2QC8mNs0ebKElYCstOGkA7LKoFY0Hp3cTWmT51ySV18Wy+8w9J2h/5yO2AM3mqzORinZM8uos2BePdZE66eCBtRS5/UmSfGrk6+mHMARoZ3ilvN4Rz+IfZQ2gSdKnLcAW4To0XQq/Hvl6BCIAxP9gzJMBDBj3Drig1mRKpdsxV3KdTwnQ5nodu6U4m+yV2SyQBFbU02UZR22wPKEnvcWwq0gWdflJQfeD6wc3ADio1qDqcCm6AX3CvQ73txPCmDjhUN20DS99jInXQvijIptN0QBmkOWJ61TIQq8mNRR01xfgUTjm7Y8S2vSh9+NB7myntf2JTIJKefyi4X7C9TlzSTjgj6KS/WSkmACW27tX7xU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(2616005)(26005)(38350700002)(186003)(86362001)(8936002)(6666004)(8676002)(316002)(4326008)(2906002)(83380400001)(66476007)(66556008)(15650500001)(6486002)(6506007)(52116002)(38100700002)(7416002)(956004)(5660300002)(66946007)(16526019)(478600001)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tfDmqrtmAilL8dsi/TVEnN+WnBDv6l7HYa92K8VWowGxuLefpzRLnANLrBM6?=
 =?us-ascii?Q?NH7vTah/OCqAwvCC/3+fSOQhjrZVR/W6/GdWUYHX7KHgXY9s+ZLOR83VUFHp?=
 =?us-ascii?Q?+z+2CX9coTAQH0BJGMOGMp/Eiv46hwfKgVwzqwcyK6phtmQY5jWIr7GiXf06?=
 =?us-ascii?Q?H1xwhUHsMNI2dUX3XDP55QKLAdVyjZACrkfguOgA7qpPBXTqDgBvs/2x+oYt?=
 =?us-ascii?Q?Km6w0dg9OpuuicPbPtDl0X8JU8atRre0KuEscWwukfsARkFiiZ+q20tzwU6M?=
 =?us-ascii?Q?kwlDZ7AKDzDfYxy1G55m1uN58FJbpWKHxKN4Clm6b8zkaKI0pNIY4WGIH6qg?=
 =?us-ascii?Q?qOHq1wiWndSwtMSmyWyVUDsOfT2nK5IOPT3SFFeUgN5HDtOqeaUlnaZc3iQU?=
 =?us-ascii?Q?Giz0nxqHJwcmfSXofOyoxj04E2JH7OawEtBbOLBsD/fPYccCsJ6I+xzUrQDb?=
 =?us-ascii?Q?43NWXVomvCbt0GAzaFaYx470UolxLTYDgF+9R6vMLZ/EoZJH27zGVbonPNXw?=
 =?us-ascii?Q?2zr+EMHR0DlxFcawmy1F4H2U+yMoXp1h9a4Jj3vkXqcFKRdqcsXCXgw64QhC?=
 =?us-ascii?Q?dRLyWzk0kHiU24glL96/dTlmLkPx6GqzJW5tdFS3/2dXM6sScBh1hDzUMhKd?=
 =?us-ascii?Q?OxFguFYbLeBvBYXrTb9uzZbIZzUrJvaWxGDv370HqOJqlQqCn9seATAi9sLs?=
 =?us-ascii?Q?Ts5uI+hk6/U6ueOri+C7nCiOz70WdYnz595Q7Y2G5waQiyuLlC+XMW4o7OEh?=
 =?us-ascii?Q?KxuYoKZGYr4f3ifi8UkFuZNC6z+5a3U5ui0iryjGu3Y3of3oxT049n0y+ORV?=
 =?us-ascii?Q?KKxve15EZSFiChoqmzsyicMrDyKtNdNh8G+auzEVlYVw5q4F6WP0DrEKbxwx?=
 =?us-ascii?Q?f8IxavM5ui2dp0OUyXMIB2lQlQIMal5jmWjDIHDLSX//ZM5XLR1YFeVvN1ko?=
 =?us-ascii?Q?Jdn75dUA+4l+fV7yvT6lm4cRfdwOS8DY36tF/nN1z/y/gVivbt5Goc4czsvt?=
 =?us-ascii?Q?49G/zrnCEHgdDYPQUrHWWocMTbhM4IwYICPMciMdl2KcEoE6yTUIlXTYxC1e?=
 =?us-ascii?Q?5LKcJEMSxVbMY9FIoiNkF2RzP77HoR0m8ZP5sumByO3oQos+7dl36J/cCZuL?=
 =?us-ascii?Q?wU02MkAyElCWL0lCs1UfdDehgM4RE6eCCStKi3KeMJgIMwsdK0Bl0VgEMwdk?=
 =?us-ascii?Q?njRRWOOwaSGjISneDR2Use/JM+xXIaxhmE+uVsOst5Q4mcRRYoG6S5Q9y/Wg?=
 =?us-ascii?Q?cYljC4igKchZj0aB+OYR1cLglrisU5YkKyqJlMyIlQO9pDTUhCDHaxDg1tEX?=
 =?us-ascii?Q?ZFFIfpHTxFucIsujkA5HX+NZ5adw3zdTJn/wSqYqNpxhOQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be788608-4f77-402f-ad8b-08d921bba8e6
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 09:33:32.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ad1VtqQ2cZLPQD5mhpQI2fT4RgLVHrccfWXKSRsOCsOIUo1UpCSNAd9dYxsvp/XIjTrNJtmH2UgQtkbY+qtuQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302
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
 drivers/mailbox/imx-mailbox.c | 104 ++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index f5dadcc827aa..bc51bd3c1999 100644
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
@@ -42,7 +28,7 @@ enum imx_mu_chan_type {
 };
 
 enum imx_mu_xcr {
-	IMX_MU_CR,
+	IMX_MU_GIER,
 	IMX_MU_GCR,
 	IMX_MU_TCR,
 	IMX_MU_RCR,
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
-		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_GCR]);
+		ctrl = imx_mu_read(priv, priv->dcfg->xCR[IMX_MU_GIER]);
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
+		imx_mu_xcr_rmw(priv, IMX_MU_GIER, IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx), 0);
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
+		imx_mu_xcr_rmw(priv, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(priv->dcfg->type, cp->idx));
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
+	.xCR	= {0x110, 0x114, 0x120, 0x128},
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

