Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907AB39400E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbhE1JfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:35:08 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:31974
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235160AbhE1JfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:35:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBGYScbT0m1u4f/nSzi2QZgxPi+n2N3f7cXk2Vk114odZku0qQrEeYQG4Ns4khkVeZ6kNqoealnSKIlauBjpYg1KsUmOnYqKbwV1IPk2JyC95i9Po44f/YYJa6vRoKXrTTVHFkw0Sb+6kJlGMzau3ldAa6QrIgoGMfxzSTv2JReSQPuin9YCSsE3G8Fk/bj/smTsLHFpF2A60dY6nG0Z376qOQOSIV7oHLOElc/j95duMnvoSAZWsvICkjbgkw9FoMJhsKIILtKDQJFwHfd1O+CQFfCGW7SS2fIkN3w/nRlB1g4pAYbLfGEJPsE9Y0Y0oqnd4au9aTbXv2wAKOq6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kthR1LaEBXeLffCxe1zpZe6u5BMGV8EDqpFYNFkbXVc=;
 b=TMnbmTaj81dgLsG2qatgLH0I2oBrKRaiKnAL9uq8BwF+gjwBeY/zXHkGlo63+78Kq3/ejivxXfaMM/yrAqOxPzPp1q/GV82hzUYh9ULgDM06OHfU7H624cTNDJ3BafbtWUMJ3wTW/0lSIbGhF9niq+S/jMQlrOUIyW8Jb2pAG/c5baaRDEurNlLQoUsnZHJeJfpjcYbP9Np2gg0qzclzC1q0ANOTqggszxA9F5pCKTU+pVxTqH+85gShTIHlXiS5BhCzkTH/Sp4jFv85AIsBzqYbZ0zB/+j6OTPe+sHrlp8NFc3r/08kvr3afBt7hFX9Eshx18xNKfcJhVglf2KKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kthR1LaEBXeLffCxe1zpZe6u5BMGV8EDqpFYNFkbXVc=;
 b=dzYUnxcmRT05TXWdzOXSDqjXwJkVxxas+WH8MXdsPPPGXWi/nLo4C+7LmKVkob68QGfkVlwa9eKPQScAnWyc+q8JNxkYZRCCLE068d5wvCupyi04aZ//ik42CWgoH3IK/hbc2/1fIGMGOx7jL8GQX8/wLf7YkoN5dlUmVw7iqTw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7302.eurprd04.prod.outlook.com (2603:10a6:10:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 09:33:24 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 09:33:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] mailbox: imx: replace the xTR/xRR array with single register
Date:   Fri, 28 May 2021 18:06:01 +0800
Message-Id: <20210528100603.21759-3-peng.fan@oss.nxp.com>
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
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 09:33:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 622606d0-aa70-4b43-e7c6-08d921bba3a7
X-MS-TrafficTypeDiagnostic: DBAPR04MB7302:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB730248994A45672C901DDC46C9229@DBAPR04MB7302.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+cUexT01TNj1gubYCI3zoy+ssE/E1paA1hFhGzIG2zIPhtWbF/4KmmgqA+2VcBrsKD2K0oC23yDpWcBvQtxUP2HFSxNNjUrYVo3mKTXF160Kxuh7qY6R2QTIfTPeRafJJv0KbVh7RCF6MYCsVWKks5xgAL9mMlY9conqU8XE84BNzlrLb0SS4rnxv2XoTfSC59FR+EHcTfK5A+9y2ekfiKpbUpg4LrfsoVMvrPDZRA+ChH/THJw64xLGlOzA54Z0QumfN3yymmshDybXZ4D+BKEXeQA6AB8hag2d/AkJcercAopULOdbrOu0vbXROM02z2vCG+bZzd38XupKKuwqc5qMZjX9yP/3dAbDV7QbRiIiqbc94+lLUz7W1DSh0Bg0f6oe4tmvrpUHS/AhAhIqNMKro2JoleMllGSzYtlGnXYaju4t6QneRJf+fLRagVXLcA2VNaqwslXZgNlzJ6Yi7xKMsYqjHUabmjnhn4V8TZI1hR0C6rtV3LxTKDvl/ohTP3NZCP4qAy2KPS+H68lpeirWIKyNlhFp614BPe6CSXMN2L4gRPgirG0yR6ffWC9Kknbc3DotAJDAjmfndt23JRHMeGPjejrK85AgjTR6NsknxJWfHNicRYi7gSeOECxI7PO30vIVpN9KqniBAdiNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(2616005)(26005)(38350700002)(186003)(86362001)(8936002)(6666004)(8676002)(316002)(4326008)(2906002)(83380400001)(66476007)(66556008)(15650500001)(6486002)(6506007)(52116002)(38100700002)(7416002)(956004)(5660300002)(66946007)(16526019)(478600001)(6512007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0UnMkG1iLqg9ye7awZFtWVTi2cu3zNf6GGTDD5aazgCYls/MBzJl7tjvWgxD?=
 =?us-ascii?Q?MtE7FyDMyc58DtlqwEmREoLgHpKu92Hg2YZRDD/AjZjTaH/BqCaLQO8zIpB+?=
 =?us-ascii?Q?nx7B3KhNChzHRXRjfIVAY8u6JxKHIEKcrLf7UHJTQyijMHwmuIkxbRk8lHdt?=
 =?us-ascii?Q?Z90rkFHt8/pv+4qBQ8kKT5GDTaJH+K+NsqC2Qpd96VlupzXq1BMsaT0gqNYe?=
 =?us-ascii?Q?SQHXMBfFeIgMVysl9YSkZl/BJYgMZtprYF5K/kuHPBst3pfdCTRimeq36Eq9?=
 =?us-ascii?Q?KdA6DeyPn3z/sRDmMTXq7WcFXUmfx8aM4nXBVyiNw9pC9a/4UzHJGL8+Tfhv?=
 =?us-ascii?Q?9GeNtNGyDcyXNh8lv12w7ih/siuUqZmea5hViFKBSNstLw22+9Yp2ZfZVPhu?=
 =?us-ascii?Q?DcmlZd/KBIGaorQivdUNljeVXjbjfyD0r2OspoB2yDlod9zv1hw4GZTt6ksE?=
 =?us-ascii?Q?T7Lf0d/dGvkkhQSBs8X3/WviK2l3LdsmKvZ3lh9sqPSmvC1DcHAdLrZSNSfE?=
 =?us-ascii?Q?PT9jqGl9eSKYCXmvsQet/8Df/yBeFNagPf9nSqTEfnGsu7qYOVo2LT5ZBpF9?=
 =?us-ascii?Q?EGw0sQ6aMtFpvQTmcWL7n5WmA1iUyYpjvM+udP+nlqYnArWgqophTL+ZRBgl?=
 =?us-ascii?Q?E6WDgPGW1O9v4bvojPsQHru3fUEdpebjbvNTF/8449fa1Dha5TTrKEWjvIRq?=
 =?us-ascii?Q?dYI3ZFcTZ5liUxbp0/k2sQA0NfoJJTpnvuoPrHEzAcNX/IuQOWDF3R+lq6bs?=
 =?us-ascii?Q?7KnxIeAxR6zxClvqduJ3vtYsxe2QYbvrxxZQ0UMfaGJjB9nOjY0wf0AyN8Rv?=
 =?us-ascii?Q?zjA7MY7E12hvfOxp8Dq1rAoonUAxUCh6v32+UBfRzPIxC94u0EoyFJx3FvPO?=
 =?us-ascii?Q?cyWRiOMtG9nnWGch2924Os1EPfdxkSvkBOD+6Hxt+kdNfboQwAnqGuzc8Ai9?=
 =?us-ascii?Q?g8HkioOGBzyoH9pswXKY1vXi/iJ57EYJNldQZOBncgxSHX9O61Ux2EJACzdx?=
 =?us-ascii?Q?wFY/ywU/GjaltftCe91rUK7l4Y8Sj3qXzdORJVo3IbBq6tb/7d2vBv3+R05Q?=
 =?us-ascii?Q?w40kw4TRABtV9EU/QabInTTlQESH9f65uZQ6gHuOIGQu+K0U18fUd/XrQaqI?=
 =?us-ascii?Q?EHHeeMqixWuK40ziuPvnt/bfaaT6vUA22OJZsf9CQO+c1QBSawp2d9JM+DOA?=
 =?us-ascii?Q?c9WKCsmP/8LNbaFeW3+WgimnHbygc9AzZGX6G/r9gEbF0m/mahN0yLmuLkZR?=
 =?us-ascii?Q?49lZOttGexJ7k1pPLqCpAEzfp+SZJkPOuuwsZQPdQybUHLzQzfQtUB+uBBaF?=
 =?us-ascii?Q?EwMRZS6iq8oaoWW0BkBlyHKDaPgJC8QH6SMaSi+7AEwI7A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622606d0-aa70-4b43-e7c6-08d921bba3a7
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 09:33:23.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR2zWuGzN7h+GsCnLOeAZX+Y6ixAVI4EugUdDd8Tq+V5Q51Rw8nyVjetJo1C0Zgrx5dPRsC/vh8aqavwkRUJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7302
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

