Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E638B4374F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhJVJpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:45:02 -0400
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:34114
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232531AbhJVJpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:45:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8AIWFRtHG6JA9ZVPRq4ngkeJKRdE0mZxSvbkYZngwusyqSdcfKURFTJpp8qxzqT4dIBu9OcgUX4n+haC+hTSu899Vged21KZJjoUWHjtrbQkFwJCGPVI6JQGO+fW86TrdSkDjTE3p5h8+DxsaIgcsKSW6BTXtADv/p5g7HZ8nyo86TJx+iyok9jVK+rWksoq0V5d4rS3NMqTgU7KS0/SWqenF6M4gLiEJbqPWy1Dx45ezpKNL9kHiGLashxLuAVijipnYJXfViAj1u56WKC35zRDKZqiw4WPHSjOhiYCEux2RykkRIT4L62kRSzFs6GJXjHhFzdEttutAlNti0XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NWMSvQdzuUCnJyzq2uAVuzDT16mIRQWpN+sZ+lqfMo=;
 b=Nxkl1wDNe9pfW8nukW/dyeiDEJdCR66V5n6L4EpjYs7xbYxiIbVL4jLj+mm79ui47muBPP6t1hBdNRc+N4K2NGHJA5MnZ0QLj5xN8Mr4k9SGfJQT8jvJOSRyf2idSuR3HOBATQuAjvpJ2Xoz328I2KycKSQeKchHvMYjEos5T/K75zHBCG7WUVH5651Kgtn1cvKYmkU4pK3Ggn4qXlZYZIvFczCJt4niLNGHzN/thSqWtZongw89TstRD4hIp9V+ImkCGXbvKv5IiIBalO7f+WmtvX89N20Cikgd7YcuN7o0VulMkExkOhzDf2hyMTcZ2FbY1uExOSUJmfgFNE6RaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NWMSvQdzuUCnJyzq2uAVuzDT16mIRQWpN+sZ+lqfMo=;
 b=Hhl3LL3wSUeLOc+wBBRHmvYvA9DrrxpiLPp3bLIsQvTeNqJAs+OR3bSaEPLB2EgilSzI0cCYNZdOAlJXxmmcRGoKYj/q22Z8Vs2oa5EDwOw09Hyu4u05PoQr1PrOjq5QJPh9E80yQ5R+Q/o/bfHJu5AJ9dJVfLfmphgQNjoSrjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB9051.eurprd04.prod.outlook.com (2603:10a6:10:2e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 09:42:40 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 09:42:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     jassisinghbrar@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] mailbox: imx: support i.MX8ULP S4 MU
Date:   Fri, 22 Oct 2021 18:18:56 +0800
Message-Id: <20211022101856.8612-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211022101856.8612-1-peng.fan@oss.nxp.com>
References: <20211022101856.8612-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To DU2PR04MB9020.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 09:42:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f9d6201-bd12-40d6-2648-08d9954049df
X-MS-TrafficTypeDiagnostic: DU2PR04MB9051:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB9051D208E449BB700C16D768C9809@DU2PR04MB9051.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MinrzaEBppAzsJndxf6P2K96kwBQSBfdrljg1f3hKA+cRVAnIVIikyPjzUoeKbfiNI/hWVHgiX+k0YbTWKQomdBYYOVDSIkMHiflC8nNv6TAb2yAknSS5mDqYvRhn2PeatZPyIYTllq1X+GrdcPxRS37IQwEKEK+HUz0/Z3Ncw+E/OHz6NTcE3JPDZ1JKA/BRscweVopgww5IdCAdQJgknSfWDqzvyXg1Pkg12xCHrn0jVkmbPNegJ1Gvo4ZTuM1j/JHeqBPP5U5KnV4PFLHE22fMGV9b6i/1K26ctYU3GfoxC/Q/6qI0xffdc45I1QCP/nxaiplIWfPlNOVDleArHRhADRZJDdEhRsOQGcIWEarYblQB9r1uL1mCOQxGJVGEh9vvi3Yeh3PK9pm2K18imCXTdAaCXw1I/pbDqgzH+BQTJEuVKUPbpbLGODMDC1PJ+0Tv0p+3fakNGBk3pkcCEm+Xf4xVP+Y6Rx2eurtZ7CTbe80lw06kV1jISOfhctCRmR3e9nIWjEx4b3LM/+KzlaGZqmiaiAhxj/79ObTR2lEy4qGeG4Ew2alEvu28Oigd9kljwRA+TpQ2BFvAiUOEbLqJhgbhz+RAhNoo/8w18MMFw37uLwNMWxton6VRwDhvdkwnETQBzPO/lPatVBkgVR4f1k7O6cTgBU8pzIV78vjOVjaICrmp5H59K+rxF8j/Qm9/2zbm9e1xyV9Kl7SZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(1076003)(66476007)(66556008)(6512007)(508600001)(7416002)(83380400001)(6506007)(2616005)(956004)(186003)(26005)(66946007)(30864003)(6666004)(8936002)(316002)(2906002)(8676002)(4326008)(6486002)(86362001)(52116002)(5660300002)(15650500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NjytuwesNZzflff10ZJDPQBDcTfJeZFU05XXmG0hK82sG+cPgqE+4zB0YCQS?=
 =?us-ascii?Q?6pXzMIRYZV0KD+K9ISMKwivknr89O5mxMdgXNeGUybWNJCgXgncfhkZGU8ku?=
 =?us-ascii?Q?jXFBhRghRq7MnwIMlMjB4D62IOdrk74zBL7/PM96Bk4c6cSmPtwlXk6MCkPB?=
 =?us-ascii?Q?B+iQlnv4e9KAY70QKnOU+ROlS6GMLSV0DZJ3/k2DqAfLF1qQfPVcbYvCRoNq?=
 =?us-ascii?Q?qeOfVXlH4UaeKMs0CECmWhtcYYS5s6SRy14aDefZy/bYqKKpU5X9gjzhs1h4?=
 =?us-ascii?Q?6sAi675sP3ksDHwCtE+58NjYEAnx6LKU5ZaRBduTOXdOvrGvKB5IqFQkJ+kU?=
 =?us-ascii?Q?HJ65TX86AhWr2SIKMYLvubOvIdjmOmhck2NFgxRkdPY5d3IdJWKm1bsw9FzD?=
 =?us-ascii?Q?gapohnfLREIH+xFRu/4Wx+m7+skiPJiUdyOs2BtmwUmraagqryD00yHyfnu0?=
 =?us-ascii?Q?+Lv7klaG3UWl5tSP2ujMj1AgmGYkQPEHER3ryDJP3fnK1dyYDICr3uop9khe?=
 =?us-ascii?Q?pCcxpxqDLt0PIIy3I7aAN7Zd1nxi+ix1MnHupX5wdSgGasaKg3McOV0cFCzy?=
 =?us-ascii?Q?mNol2as7bHoqIjBnpHtn9EY7eKMVXgvo9ZKDcfvav+f6BRzqwWa4LhOa/Sml?=
 =?us-ascii?Q?J9wpHwWOv9IK9rA+tOgEoq8+SKeJeIB1AO75//AU3KAg61rqYOOBW9Kr/a9t?=
 =?us-ascii?Q?tGndia37j2gBbEGLNpIzRgPJKZNStFesHF1tSXGTUMBPKE5oH9RzKFquoDJ2?=
 =?us-ascii?Q?NU82s8RL4f1BBz1lrZf91IQOTvQzAX+rOT7xCu/9AL0pFckK28KFaJU1flwO?=
 =?us-ascii?Q?RZXgQxeJv6gI49P8p09QJOL4/s7Tdh6vKFMbqLcpc2690YB3uCFxdA9tmQtO?=
 =?us-ascii?Q?qxJZRd/0etcVTJ7ZUeDlQLtX9d9pQZ9gOj0fUfUNDw+G/DkPMo0ue0AKk4Ud?=
 =?us-ascii?Q?JxrIqhEjDmqG/EMiAiyrcB4vDFrrJjnHczOSl/aWf+1hoY8sSFhf9/DkxGV0?=
 =?us-ascii?Q?YcoJy9mgrwgipMoJOdV32/O2UFA9Y/15s+eUuEaBBQgp/s+Uaxz+Z1qsNejA?=
 =?us-ascii?Q?LF3GTEZBKp464Wf2wvT5AcSiyTBqPdKPg7HVg9xR2GhHVKsNi0wks1VVUECh?=
 =?us-ascii?Q?/DDkpXQ2yx9BbSjBc8M/fkM0DUeqr3KHQ66pdPGvAcvOIYTGWmPdAFLwzZt5?=
 =?us-ascii?Q?uQWxlDs6flwoZrmR1U4vZon4ExJK4Fq0Xgtzjw/cpMdKRHDnnp5r6mbg7V2S?=
 =?us-ascii?Q?N0r72sl/vL7uH957K5ojrUeQgs+0LyzM7Mge/dwMuo8dmhpILz2V8BNP1mR+?=
 =?us-ascii?Q?8kNhgwq7RJ5IzE6ymqyB0T+I3d8yy5ZE/BAL4GtBCnR4Dqb+ZzYqvixFf2bb?=
 =?us-ascii?Q?V4JhbVxgEMt/LBNjeA7pQFwagDFjRJ9CC646S1DUDPKPaSyD0vrk4jiJ4oRm?=
 =?us-ascii?Q?ylD6oFm9pbg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9d6201-bd12-40d6-2648-08d9954049df
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:42:40.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Like i.MX8 SCU, i.MX8ULP S4 also has vendor specific protocol.
 - bind SCU/S4 MU part to share one tx/rx/init API to make code simple.
 - S4 msg max size is very large, so alloc the space at driver probe,
   not use local on stack variable.
 - S4 MU has 8 TR and 4 RR which is different with i.MX8 MU, so adapt
   code to reflect this.

   Tested on i.MX8MP, i.MX8ULP

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mailbox/imx-mailbox.c   | 124 ++++++++++++++++++++++----------
 include/linux/firmware/imx/s4.h |  20 ++++++
 2 files changed, 107 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/firmware/imx/s4.h

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 0ce75c6b36b6..ffe36a6bef9e 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/firmware/imx/ipc.h>
+#include <linux/firmware/imx/s4.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -18,6 +19,8 @@
 #define IMX_MU_CHANS		16
 /* TX0/RX0/RXDB[0-3] */
 #define IMX_MU_SCU_CHANS	6
+/* TX0/RX0 */
+#define IMX_MU_S4_CHANS		2
 #define IMX_MU_CHAN_NAME_SIZE	20
 
 enum imx_mu_chan_type {
@@ -47,6 +50,11 @@ struct imx_sc_rpc_msg_max {
 	u32 data[7];
 };
 
+struct imx_s4_rpc_msg_max {
+	struct imx_s4_rpc_msg hdr;
+	u32 data[254];
+};
+
 struct imx_mu_con_priv {
 	unsigned int		idx;
 	char			irq_desc[IMX_MU_CHAN_NAME_SIZE];
@@ -58,6 +66,7 @@ struct imx_mu_con_priv {
 struct imx_mu_priv {
 	struct device		*dev;
 	void __iomem		*base;
+	void			*msg;
 	spinlock_t		xcr_lock; /* control register lock */
 
 	struct mbox_controller	mbox;
@@ -75,7 +84,8 @@ struct imx_mu_priv {
 
 enum imx_mu_type {
 	IMX_MU_V1,
-	IMX_MU_V2,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
 };
 
 struct imx_mu_dcfg {
@@ -89,18 +99,18 @@ struct imx_mu_dcfg {
 	u32	xCR[4];		/* Control Registers */
 };
 
-#define IMX_MU_xSR_GIPn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
-#define IMX_MU_xSR_RFn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
-#define IMX_MU_xSR_TEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
 
 /* General Purpose Interrupt Enable */
-#define IMX_MU_xCR_GIEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
 /* Receive Interrupt Enable */
-#define IMX_MU_xCR_RIEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
 /* Transmit Interrupt Enable */
-#define IMX_MU_xCR_TIEn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
 /* General Purpose Interrupt Request */
-#define IMX_MU_xCR_GIRn(type, x) (type == IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
 
 
 static struct imx_mu_priv *to_imx_mu_priv(struct mbox_controller *mbox)
@@ -167,14 +177,22 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
 	return 0;
 }
 
-static int imx_mu_scu_tx(struct imx_mu_priv *priv,
-			 struct imx_mu_con_priv *cp,
-			 void *data)
+static int imx_mu_specific_tx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data)
 {
-	struct imx_sc_rpc_msg_max *msg = data;
 	u32 *arg = data;
 	int i, ret;
 	u32 xsr;
+	u32 size, max_size, num_tr;
+
+	if (priv->dcfg->type & IMX_MU_V2_S4) {
+		size = ((struct imx_s4_rpc_msg_max *)data)->hdr.size;
+		max_size = sizeof(struct imx_s4_rpc_msg_max);
+		num_tr = 8;
+	} else {
+		size = ((struct imx_sc_rpc_msg_max *)data)->hdr.size;
+		max_size = sizeof(struct imx_sc_rpc_msg_max);
+		num_tr = 4;
+	}
 
 	switch (cp->type) {
 	case IMX_MU_TYPE_TX:
@@ -183,27 +201,27 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 		 * sizeof yields bytes.
 		 */
 
-		if (msg->hdr.size > sizeof(*msg) / 4) {
+		if (size > max_size / 4) {
 			/*
 			 * The real message size can be different to
-			 * struct imx_sc_rpc_msg_max size
+			 * struct imx_sc_rpc_msg_max/imx_s4_rpc_msg_max size
 			 */
-			dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on TX; got: %i bytes\n", sizeof(*msg), msg->hdr.size << 2);
+			dev_err(priv->dev, "Maximal message size (%u bytes) exceeded on TX; got: %i bytes\n", max_size, size << 2);
 			return -EINVAL;
 		}
 
-		for (i = 0; i < 4 && i < msg->hdr.size; i++)
-			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
-		for (; i < msg->hdr.size; i++) {
+		for (i = 0; i < num_tr && i < size; i++)
+			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % num_tr) * 4);
+		for (; i < size; i++) {
 			ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_TSR],
 						 xsr,
-						 xsr & IMX_MU_xSR_TEn(priv->dcfg->type, i % 4),
+						 xsr & IMX_MU_xSR_TEn(priv->dcfg->type, i % num_tr),
 						 0, 100);
 			if (ret) {
 				dev_err(priv->dev, "Send data index: %d timeout\n", i);
 				return ret;
 			}
-			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
+			imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % num_tr) * 4);
 		}
 
 		imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(priv->dcfg->type, cp->idx), 0);
@@ -216,23 +234,32 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
 	return 0;
 }
 
-static int imx_mu_scu_rx(struct imx_mu_priv *priv,
-			 struct imx_mu_con_priv *cp)
+static int imx_mu_specific_rx(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp)
 {
-	struct imx_sc_rpc_msg_max msg;
-	u32 *data = (u32 *)&msg;
+	u32 *data;
 	int i, ret;
 	u32 xsr;
+	u32 size, max_size;
+
+	data = (u32 *)priv->msg;
 
 	imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(priv->dcfg->type, 0));
 	*data++ = imx_mu_read(priv, priv->dcfg->xRR);
 
-	if (msg.hdr.size > sizeof(msg) / 4) {
-		dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on RX; got: %i bytes\n", sizeof(msg), msg.hdr.size << 2);
+	if (priv->dcfg->type & IMX_MU_V2_S4) {
+		size = ((struct imx_s4_rpc_msg_max *)priv->msg)->hdr.size;
+		max_size = sizeof(struct imx_s4_rpc_msg_max);
+	} else {
+		size = ((struct imx_sc_rpc_msg_max *)priv->msg)->hdr.size;
+		max_size = sizeof(struct imx_sc_rpc_msg_max);
+	}
+
+	if (size > max_size / 4) {
+		dev_err(priv->dev, "Maximal message size (%u bytes) exceeded on RX; got: %i bytes\n", max_size, size << 2);
 		return -EINVAL;
 	}
 
-	for (i = 1; i < msg.hdr.size; i++) {
+	for (i = 1; i < size; i++) {
 		ret = readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_RSR], xsr,
 					 xsr & IMX_MU_xSR_RFn(priv->dcfg->type, i % 4), 0, 100);
 		if (ret) {
@@ -243,7 +270,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
 	}
 
 	imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, 0), 0);
-	mbox_chan_received_data(cp->chan, (void *)&msg);
+	mbox_chan_received_data(cp->chan, (void *)priv->msg);
 
 	return 0;
 }
@@ -394,8 +421,8 @@ static const struct mbox_chan_ops imx_mu_ops = {
 	.shutdown = imx_mu_shutdown,
 };
 
-static struct mbox_chan *imx_mu_scu_xlate(struct mbox_controller *mbox,
-					  const struct of_phandle_args *sp)
+static struct mbox_chan *imx_mu_specific_xlate(struct mbox_controller *mbox,
+					       const struct of_phandle_args *sp)
 {
 	u32 type, idx, chan;
 
@@ -478,11 +505,12 @@ static void imx_mu_init_generic(struct imx_mu_priv *priv)
 		imx_mu_write(priv, 0, priv->dcfg->xCR[i]);
 }
 
-static void imx_mu_init_scu(struct imx_mu_priv *priv)
+static void imx_mu_init_specific(struct imx_mu_priv *priv)
 {
 	unsigned int i;
+	int num_chans = priv->dcfg->type & IMX_MU_V2_S4 ? IMX_MU_S4_CHANS : IMX_MU_SCU_CHANS;
 
-	for (i = 0; i < IMX_MU_SCU_CHANS; i++) {
+	for (i = 0; i < num_chans; i++) {
 		struct imx_mu_con_priv *cp = &priv->con_priv[i];
 
 		cp->idx = i < 2 ? 0 : i - 2;
@@ -493,8 +521,8 @@ static void imx_mu_init_scu(struct imx_mu_priv *priv)
 			 "imx_mu_chan[%i-%i]", cp->type, cp->idx);
 	}
 
-	priv->mbox.num_chans = IMX_MU_SCU_CHANS;
-	priv->mbox.of_xlate = imx_mu_scu_xlate;
+	priv->mbox.num_chans = num_chans;
+	priv->mbox.of_xlate = imx_mu_specific_xlate;
 
 	/* Set default MU configuration */
 	for (i = 0; i < IMX_MU_xCR_MAX; i++)
@@ -508,6 +536,7 @@ static int imx_mu_probe(struct platform_device *pdev)
 	struct imx_mu_priv *priv;
 	const struct imx_mu_dcfg *dcfg;
 	int ret;
+	u32 size;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -528,6 +557,15 @@ static int imx_mu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	priv->dcfg = dcfg;
 
+	if (priv->dcfg->type & IMX_MU_V2_S4)
+		size = sizeof(struct imx_s4_rpc_msg_max);
+	else
+		size = sizeof(struct imx_sc_rpc_msg_max);
+
+	priv->msg = devm_kzalloc(dev, size, GFP_KERNEL);
+	if (IS_ERR(priv->msg))
+		return PTR_ERR(priv->msg);
+
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		if (PTR_ERR(priv->clk) != -ENOENT)
@@ -623,10 +661,21 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.xCR	= {0x110, 0x114, 0x120, 0x128},
 };
 
+static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp_s4 = {
+	.tx	= imx_mu_specific_tx,
+	.rx	= imx_mu_specific_rx,
+	.init	= imx_mu_init_specific,
+	.type	= IMX_MU_V2 | IMX_MU_V2_S4,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x110, 0x114, 0x120, 0x128},
+};
+
 static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
-	.tx	= imx_mu_scu_tx,
-	.rx	= imx_mu_scu_rx,
-	.init	= imx_mu_init_scu,
+	.tx	= imx_mu_specific_tx,
+	.rx	= imx_mu_specific_rx,
+	.init	= imx_mu_init_specific,
 	.xTR	= 0x0,
 	.xRR	= 0x10,
 	.xSR	= {0x20, 0x20, 0x20, 0x20},
@@ -637,6 +686,7 @@ static const struct of_device_id imx_mu_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-mu", .data = &imx_mu_cfg_imx7ulp },
 	{ .compatible = "fsl,imx6sx-mu", .data = &imx_mu_cfg_imx6sx },
 	{ .compatible = "fsl,imx8ulp-mu", .data = &imx_mu_cfg_imx8ulp },
+	{ .compatible = "fsl,imx8ulp-mu-s4", .data = &imx_mu_cfg_imx8ulp_s4 },
 	{ .compatible = "fsl,imx8-mu-scu", .data = &imx_mu_cfg_imx8_scu },
 	{ },
 };
diff --git a/include/linux/firmware/imx/s4.h b/include/linux/firmware/imx/s4.h
new file mode 100644
index 000000000000..9e34923ae1d6
--- /dev/null
+++ b/include/linux/firmware/imx/s4.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2021 NXP
+ *
+ * Header file for the IPC implementation.
+ */
+
+#ifndef _S4_IPC_H
+#define _S4_IPC_H
+
+struct imx_s4_ipc;
+
+struct imx_s4_rpc_msg {
+	uint8_t ver;
+	uint8_t size;
+	uint8_t cmd;
+	uint8_t tag;
+} __packed;
+
+#endif /* _S4_IPC_H */
-- 
2.30.0

