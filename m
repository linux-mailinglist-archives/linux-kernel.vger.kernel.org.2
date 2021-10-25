Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3409E439552
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhJYLzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 07:55:03 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:29489
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231855AbhJYLyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 07:54:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REAahljd/XWf1mKM4SwYrsRAaW/XryKSkP7NnjuAXxjsPXROc02/jqAnU6mSu1ILSHlaZ/rWf8jKVfMwCdsObfYE3Z7dpj+Hj1wWvALOoKP+6b4gUADb3OP5S3Ku0ZucVQ1gfG3oMLL5ixe4kFj7/bhDTKASV0aA+YB1TcW/kBcH372etuNUHB+DwmVtLqErotuS9xXYkHOj+5bJLKJeW/eWJd0r9Z2Hi6IYXOs5yPnRIt/+vU97V79qTTf3edE1W96n4xkw49PDK7G20dIjI5cMU++urMqJZAlQLl4z+5C9JQOjqJe0GqdvXdy/2L17AxvAedR1lg4RLTwNsybSFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgT5a3RyUl6QqrOguIZYh0l4rMCS6QAkW9XIdSNtfR4=;
 b=SJnqwqeo7hm7s26WBkJMr08feL/xEjF7wpLDi1cXr0dezuT0c88YUQ22y4bLbRXNnqX8J3J2IC4gjXmvSykEUrsMmNIG2gLCjZR8nQCfiVMMK4E2C9tRiIfsBLiOhXLzFhdKwmnMXnbZeyFJq89cyRil/hgL62PLwENEtwWVGvX5FK6z83sQ30I7pJqKStwI6yVUDAW/CY+eekmFw6t9qmWST0tQHMEigipYzCbg1tB/8svYjqiIkMm4rZYPMwIQt9QH4lOGksd+cfbnxZTxQG3V7rZ3rpDHGPgKEDK7nOR54UbgMIC8R8gWB+ZWyoY/RaUmlGSJKrfLZECIFE5npw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgT5a3RyUl6QqrOguIZYh0l4rMCS6QAkW9XIdSNtfR4=;
 b=E4N8cv9qJeqrCu8/26khbK79ro2EnW3GwYsSWY/Enc0GIWRdJ9cYqjbvpna+iyqrKmUFfR/A2RvKPCcDBltYF86dDGXw3BZUW+bgedEWJmFDmF0dnzNQdgCYCzx2DlMpYf3u/95MliQhvzzJGn4ISkhAPKLYEQsta9Q9Pg9I/Lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9)
 by DB9PR04MB8445.eurprd04.prod.outlook.com (2603:10a6:10:2bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 11:52:30 +0000
Received: from DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a]) by DU2PR04MB9020.eurprd04.prod.outlook.com
 ([fe80::b928:9230:aa10:639a%9]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 11:52:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, mturquette@baylibre.com, abel.vesa@nxp.com,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] clk: imx: gate off peripheral clock slice
Date:   Mon, 25 Oct 2021 20:29:02 +0800
Message-Id: <20211025122902.1151-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0017.apcprd04.prod.outlook.com
 (2603:1096:3:1::27) To DU2PR04MB9020.eurprd04.prod.outlook.com
 (2603:10a6:10:2e3::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR0401CA0017.apcprd04.prod.outlook.com (2603:1096:3:1::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Mon, 25 Oct 2021 11:52:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a7b1132-a127-4168-c82a-08d997adec25
X-MS-TrafficTypeDiagnostic: DB9PR04MB8445:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB9PR04MB8445FDA18369F34D2ABC68AEC9839@DB9PR04MB8445.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U03KNJ55/sN+qPJmDIBsxoUAfFW1eCeJrTvUT9V01nr7Bx2rKOU9FPmV9T2afpaPp70HkGeA6+fiitLGu+40pNY9oglCrYAWbadhjs56/ftGoZuukXgIHfN0rddKTEw97b/3zhCAqjM0tsKb9KwDYGl+WFpCfMJRctyykAEtbReBUIzc3jbs7vzRJSF2czbERCKA0g5qRDo20E15ylku2mzsqYc09/EzLPyDTJILqyc4HTmlzzwYRzrGORmofdXm1B/BTyeXM7uCTb0xBE+2E0GJuDB8vUhJrgYG98jz6sJJ/8nLXyuUHl/6Z/xw4eRhdKWGb4V2xQXPBLaV+T4MOkZzxzlxJexyvQ0Q5CSCrr4rjUVCipmg3DVwLC6ubwL3caBtxRNBlw2rg38zmsW+JWqCGEwd++3tS7dsFuNOjCSqpZwXfSZ8N65r/kXt4C+/FKvzqggyn+BWRIGSfJcdGdBjuUgzD34ChIneXtOwuOoi7o2+FrWawN3KA7VxLaCuqy1WEPY5YCJzM3NS5LA5IKKUuZHeYMzTwyzJYU3MRZSTOd196EQ0kZdHSuP6LaDCC78cxTlSAGlsszrliU8g7dlEPtN1RJfHcvrVEsWvKZeSQufR7wjXspaJxbJ7nk1jUkNn6Hxwp8Vmcl/Bb5E3naqrhvLZi8XO/63ayPt/jxz25q84YB7/wtx88ALYwSIcedd1TTJHruHGYOL/q7OCag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB9020.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(4326008)(26005)(52116002)(6666004)(6506007)(8676002)(83380400001)(6486002)(186003)(956004)(38100700002)(38350700002)(2616005)(1076003)(316002)(66476007)(66556008)(86362001)(2906002)(66946007)(508600001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i4PtnC3m8J7Lbx0Q58aretjrYgJJLKHHftI06qsxre794cnsVJDr6Ov88JXa?=
 =?us-ascii?Q?AjC4Uz2FfCy799XV8r/aYcIl7g9wFMsMSaLKeA1DOeAlQVOiXOjU9CwOhOp6?=
 =?us-ascii?Q?XHxRiQGsQcF7wXLbj8ZiJwPX+QZS/lnk/08wG1sZVYEpIZ8lEQCG8FJ+OB/H?=
 =?us-ascii?Q?Cg32CPO8QjJkilhG22/1KI/2IUWsn7zNrWWOo2EPMnzKQJw6OkO7kDbnLvIZ?=
 =?us-ascii?Q?jOZsPAI5D3vNj0VA5zHBvSOYiDdyMspqF18W6GQypW/Udu//cRDK0m8yaZCD?=
 =?us-ascii?Q?WrrTHkjsaH3OkvuHip0i8QFmf42Kn0lG71Pqb9LACO/Nb5wL2F/TBsvLBVFH?=
 =?us-ascii?Q?yZS1Z8B7mQUnQIVabCYA5bpad0XMMIWF15ebb9eo6qnXikGHPY+lENL9ChRa?=
 =?us-ascii?Q?ct7SapLuHtfMlrco0/XY3HVndAD777mL6aLWf8LcoqDRVIJW2gGtGxZf2Oxi?=
 =?us-ascii?Q?98RVdcu93JfCzcb0Sycs6xVoZx0Et2Y1+IhiCOIqrtmsCwJ7Htr9avRgljrz?=
 =?us-ascii?Q?GbfVQKGIlaFN001NJ7o6jY0oVyVx1Mrwc09Qwqs/8oG7yJSnjcW1nAhxJwFc?=
 =?us-ascii?Q?/SV+kUgGNrLaDmHDD+1ZkhB7CmyGE3MfcxWEJAYyWBN7ezvb7eFBKFIVL9CI?=
 =?us-ascii?Q?HxXI41DkrDUWpBpo5XbmjBPP+3g4SGP1wS/Uo8Chc9tfeSdDdmKi002G930R?=
 =?us-ascii?Q?P29n2qTV127VIdT+QWIll3chxLXxH7vi4S5E8E4QkJRDouksqn5FCPUlHDbc?=
 =?us-ascii?Q?FdaBkhuIJlI9DR0yg+dS8p0n8/KqBiFmzfu7Y3NFZkyjge9VgNAqqk2xB5fs?=
 =?us-ascii?Q?/UearhFW3r/82K04cVi1dREonvZatFFIy9rBLuA43VYKqpwB41NyfrQWv/Vx?=
 =?us-ascii?Q?ylOPRxwnmnYfrvYWaK2Oj6QavSlTMZxXSASkBckZv0HNST/o+oiMrQX93+7d?=
 =?us-ascii?Q?f3hcmS0uhUyxMw1rcrNJ3nQbNsQi0xRuyysnrpMNaPFK7f8lTyJKfuRLtfgO?=
 =?us-ascii?Q?OyVNA0VU+SH7OeJ1dgTscKtARoGsh/j8TF7LZf7DK/MStoCLmDadpbaTXLEP?=
 =?us-ascii?Q?Vxdq7Q6y8pM8tfALHg/Xou0FPMAUaCvAYKj6iOisRUMQWz+1EUmHbXnkdzyY?=
 =?us-ascii?Q?frt62dPOgu+FkjnbB0LZ0C0c+jKYMDTwlJpPnn3jzWUGZKQl4IFchNaSLOxe?=
 =?us-ascii?Q?nDZVCa3kfDBYkUICb7Q51EPG2y+SspfydiUXC1dI6AxmcuIx2o1bpUWUg0sn?=
 =?us-ascii?Q?c7t8mz3h9HEjmyzrpVz7NbCaZtUHK1TcF1caHlKgSaJYicxjARyINRxeEVa9?=
 =?us-ascii?Q?It/2piRXqdlP68N47TLSBgd1OrSK9qt+HJZFZv3RHJLg4qinT1by/oevPeWt?=
 =?us-ascii?Q?xGTYldpsfpgHWeitZNbYTQwPQR1wNpJw5ekZy6BPtsvzodBhOTkvvJ0tQNWI?=
 =?us-ascii?Q?LtnNUmZf9zBz+AAQHCu1WqGRACw9RR1RoeOQH8hahiXQzy4oZnDPUzs4FjsF?=
 =?us-ascii?Q?rDQ9pnqeNBETKXnTGhaZo82cMwOxVg5JxlCBHzOFsOLPJvm2jOh9SIqCTVsT?=
 =?us-ascii?Q?I477LymeRVoQrM8XC1+RmfDeSqV418BJOoKLpyq6WzJQkASy7avfWjJBZlGw?=
 =?us-ascii?Q?ZfHEISxCz4KNcvrg08GTdEk=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7b1132-a127-4168-c82a-08d997adec25
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB9020.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 11:52:29.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obArg+8i52AX+NMzVi1a+xIpTySXauCDjqqyWHg9ZmlvRISNdesCwRL3G1LITlOeg7+t8eEL4TclMdUT3j9sOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8445
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

Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Add Fixes tag

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

