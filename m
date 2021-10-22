Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E41F437723
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 14:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhJVMfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 08:35:42 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:1338
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230000AbhJVMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:35:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOnZq3wP/ihxQpMOqF6tspEbGRioYnFZ1V2awXzGU5g7yBtNMtq1BB/l5Hl8sqLeH8crHhxNy/EuqOvflXRyz6TQBrEGljtYUiBr3K2jEacIcMDsWRdERp8/AR9qKjN5r/HEDwO3DabqXZTZQoAuoD69v/9vKMFdY+YEUY2O5WZcM2vunyFZdeWlkVWIkudBMZI3ChVLPZuuCSZJTyKjFsZ7+UAudtDddRiB2o2GG30X3f+PGPYrDiud56+xuGFt/ZYASPbm6QQdJchxT4jY3AqTypzg8GzCu7l4PCFW/BUbDNMCDFKFcJfZGVxeIxDrs0OymBXMcN4erlgfEFKo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rP86zpfjA8plyp6jYR6UD8izXfcxyja5fNqExZCux5c=;
 b=JaFX8i7BJbEYITajsct2+dVN5vVpdgf1EyKfUEHZsnsYavdkWFEERRgt4f+kSlASc4amsbp7fNlU9+uapSRYh+hX7KDk5ELFyzQ2gfHTqzxi9pt5rwiFnVOHI8j7Uyi78Q2fL0va6ZLCh4CQvJjGbdTkrl9FrQZtji6iJlgs3OtjOpm913lzyBye8MtnESbfL3L0MMCHFsoIsfjF05U3AfpvJq1dcqhETYD3G2X55l0crTdzMDW6ofuNryxU+WzfO13XpYBGrDjGgTinpvtooLxsRvobEZ9M+wbC97ly4inVhganAzTgS5njogxhk9e18gAxF2fxIcTfGMOO2HPjaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP86zpfjA8plyp6jYR6UD8izXfcxyja5fNqExZCux5c=;
 b=fuGt1KuZ/75lT2vCcYjwTHre/e6a3F39/y3ISjO9hromMryKxQk0LrXWG3sQWz8WK6j6Nt6iBpqQc2eJbUrC0icwf+tvihmqzvNuSYCNnfDnlW12U0QWRpyBmoWO9JsTtwG04yPfw4BsDYnVlWnMW/PWGWybzS4pQLDHaZgWUkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 12:33:20 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 12:33:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com, abel.vesa@nxp.com,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: gate off peripheral clock slice
Date:   Fri, 22 Oct 2021 21:09:46 +0800
Message-Id: <20211022130946.16683-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DU2PR04MB9020.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SI2PR02CA0046.apcprd02.prod.outlook.com (2603:1096:4:196::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 12:33:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd2694ea-c8b3-445d-d620-08d9955821aa
X-MS-TrafficTypeDiagnostic: DU2PR04MB8661:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB8661BBF3AAAAC0E1897A8B48C9809@DU2PR04MB8661.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvXUEACyLh3KKXN33ht+oB6ktTEruiXvPA92oPzmY1eBdIUZeW6whRHxXc7GDSsRJAnXsehFR96J5gn9nQie8RXy4teOpz0V/BLJcfrYBg7k9fU3ZcRJsvuFFU7bs1rKi0qg3DxT1rTlR25WdrLOSFrO+y/FLKOOkRStjuA1Y+T6JArgFG4KJZSuDQngFdfsCVCyLjAY1OH/F5cxCwraFZFTlGZvldbF7i+eErq8iHABYS7x/6h7tTAsn07aIju3lIt/v3Ml25osAll8sjWi3mIjbbVcfHv3+1plOi2jj3JyIOQzRCvgh6o1qLTHZk+tQi2uwOu73UQHmLMOoXAmPOf5YsKzT6bz0+s7rXhbS+00IsaNunGE/cEHDKUrZvWoCTbd4m69e/HZM6FGb8GJ4a5zjk3IHWmBdxtL8GtfQmQqkF3e/chuwkCnFddwAG4oIfogN10MZP+LfvJwDZKnb997iPJwmQgLZ+kUg1cRj2D/2RZF66sYll6atJeKhY05jYt9plyfuLisuaT8Z9f3LQt4+LzZbnAQKMNHf73aQ0EuioXljkkKm99UIsw+tYMrSIrWoKuML8azx8NitAVDQaw0rYcUgcLnJAEZNgOlgd5AMBMbV7ojIFMhRrhQ12TdUWBlQ7HxdImzMsaJn6Mdgk/QR0VlTxcq2wuLmMuRdiEo37CxdpAJ3DeNRjWFPSJSfOB8z0DqEuXPwR2eN8el9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2616005)(1076003)(2906002)(66476007)(66946007)(5660300002)(508600001)(8936002)(186003)(6506007)(956004)(316002)(6666004)(52116002)(66556008)(4326008)(26005)(6512007)(83380400001)(38350700002)(38100700002)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pWdSZ7eWbbKD//uuF/o5JgLRTrwyAf0rlBS5PHejBhAvf5L0qqfHFgxWkr7+?=
 =?us-ascii?Q?vunB9ac4BC2fgQur+7dfe2Q3qaLGHgoeU/ZknY4TUNqWPiKMMnZXYhobzP/J?=
 =?us-ascii?Q?RBOcb16AMtLI+XoJdOmufHKYtzx9hwq1zSda76scJk5kjTcvp0BxxMLlqJDw?=
 =?us-ascii?Q?2dlCJRHGs3wQPbwNe2/TcwF2b8dUPsZqhoH5p2CiDFeMTLEEzmAPZaBbts6o?=
 =?us-ascii?Q?/dikPvOFbs41/5O4FtD1XHpfEZ+dDVbpKBQqn5we5KN43tFze5zTzx/oYGHu?=
 =?us-ascii?Q?hzqN3SZdbdv/IK+Qsd7lEh6hyvRnKdd/6c4Q7hQI7mL0Vv56DNqRrIAr2itC?=
 =?us-ascii?Q?EtM+smSxnorPzg8ktn9L5qpHz+fvn3oD1ruQe8fgwXFUJhsLRxmRZUmjYLnz?=
 =?us-ascii?Q?bAO0b4yPS0q2XPybBTVARjhqYg4zdWXvQuRuW7H2aN7pEakt6m/MOUaQKHKg?=
 =?us-ascii?Q?0K9vw/MV0dWxfDTZtawhxsilnUe6sdjAWFfO3kz92sPw0KF8LTZID5MqOrOf?=
 =?us-ascii?Q?T4OPrwO5VAd+kKq9XWYblyz0jiYKjYh+16BMWN8c7PqJLJcj+qfBd9UQROmW?=
 =?us-ascii?Q?2fBkeeEu0Ln0rFpTCe79FVusdCU/yhyI2Ggv40Rtt8nnV3g4b3jmukIEdyVk?=
 =?us-ascii?Q?oy25r6D/3AiNj25rdtcyoaU419UouwFfw2w3d9gPlJkMhzqLF14eePnmVnNk?=
 =?us-ascii?Q?sRMMkMniR2JShAhpn6x4BOGXee1i8SREb8lyzZ4GFWvo1uXxbx1UtByXexsi?=
 =?us-ascii?Q?eycF9dqlh+YTW9r8yYGtK99+UMQT6z+ErQ0sxmOLkXscsTk5GA0G5AD2DY7M?=
 =?us-ascii?Q?oYqEoQbIvAHjdr0fCVTdkTqYfmU5A0PgZB9yha0X/nCZpGzw6J6+E70pTLju?=
 =?us-ascii?Q?P0zjk42mvo/RoMJ37ejogaFbNriGl8mxtMMQn/p12s50F8e40/7V6wUqHSAC?=
 =?us-ascii?Q?GgRPp6XPFR6iT81eM6BtZzrha5rs+4vvApRw7aA2JqmLmbeXsCyPUd570Tsw?=
 =?us-ascii?Q?E8Dz4pEJzwi68eg3E4wEcwCyCHWWIJgiizlhGTbKafOyNVrhpohkhXT5Yry1?=
 =?us-ascii?Q?HGV0qAaVskogaN6S18WF6icCASm0OgRVVAnNoSTKoaLrg0foK8Y9ZrBzJ4LW?=
 =?us-ascii?Q?9nIs/EibTTyZMxxf42TsGjH+iK5WdgME0Im0U+IQGD+SbDhrwMsDj4Un9RuE?=
 =?us-ascii?Q?cFHPkcvRdm8rRdMsEXGqC7HYPpqjZ2pKXI+xq/FTZpFSVBo2+9oX1M1zwGSo?=
 =?us-ascii?Q?Umesbq1w65F91mHGqD6me3zj5S8OWYbqGNP0bEaxTLQthQd9qDF5RovuyK1Y?=
 =?us-ascii?Q?yYpzO/5XsubwbteSlDtxY5WI/BRVfCph00H/PePT6Di6fsLDLheZJZLo/4qN?=
 =?us-ascii?Q?ky9imdHVBoVo3SMJFBRWMovctwZLXNmPGMX3nU6aTzgDKlwNWJ/XIV2VAtFX?=
 =?us-ascii?Q?VIG/Gmz4WOM=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2694ea-c8b3-445d-d620-08d9955821aa
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 12:33:20.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peng.fan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The Peripheral clocks are default enabled when SoC power on, and
bootloader not gate off the clocks when booting Linux Kernel.

So Linux Kernel is not aware the peripheral clocks are enabled and
still take them as disabled because of enable count is zero.

Then Peripheral clock's source without clock gated off could be
changed when have assigned-parents in device tree

However, per i.MX8M* reference mannual, "Peripheral clock slices must
be stopped to change the clock source", so need to gate off the
the peripheral clock when registering the clocks to avoid glitch.

Tested boot on i.MX8MM/P-EVK board

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 2dfd6149e528..ee41fbf90589 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -184,6 +184,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 	struct clk_mux *mux = NULL;
 	const struct clk_ops *divider_ops;
 	const struct clk_ops *mux_ops;
+	u32 val;
 
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -216,8 +217,14 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
 		div->width = PCG_PREDIV_WIDTH;
 		divider_ops = &imx8m_clk_composite_divider_ops;
 		mux_ops = &clk_mux_ops;
-		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
+		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED)) {
 			flags |= CLK_SET_PARENT_GATE;
+			if (!(flags & CLK_IS_CRITICAL)) {
+				val = readl(reg);
+				val &= ~BIT(PCG_CGC_SHIFT);
+				writel(val, reg);
+			}
+		}
 	}
 
 	div->lock = &imx_ccm_lock;
-- 
2.30.0

