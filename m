Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AFD377A88
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEJDaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:30:39 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:40040
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230314AbhEJDae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:30:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfFcRehYoXIMXwfTPde+jiTwTxNVKOcH1ovWGPpMH0Z8ZuAaJmcC/wmiRQPP6MSdT8CQNLUwTbd1NVhvVzFZRhsvuR5Xduzg7sKU6Vtc+vYqekQJwfusVFHK98gkk9v/0LzWLNQ1Fcsr8/dqP8/PCKydnIF8X5oKl8d/35OLKjBPu0lKf0hdB2ZLX8qpfo1v5CZCMfy7Qj0YtFooJLtkBqTesA/IIEUzM6y53iUq3UH9Kdg3TRawwxuuwxokUOEqC5SxKVODTs34d3xBfZE+cRlX/9hHBR4Rggizw8Xt0Xv3Ov+zxAwcSOtkofNFM+W8WlaPeeqAU1z9v4FU3rymCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3a8RtViAU6NJPihpfy8sxeF6A97AR4gHBn5SIWqMkw=;
 b=kUTt92m40i39m6OvEHJujMOyFCt/XhC2khAwjwlaMyT3Wbq0LSm/2p5hcV9Ygfwy2HUqrSp6EX8XVZ4vJj0QjZZTFPXuZcqFxgZuJe+Vyd+bXrmr3D92K7+U4MEvkolT/OANrCu1GTQTZjz7UDVBxEHReQ7K+uRLrHyBQmI5qzaTcpyHBZ5f2Xbr2zyMBvMQKXqJIIT6+PJvzN3PtAK7RPE4Qkl5b7CER1UvWtz2QByay9O47nfhnlGcjLW1uSGXCU6zFtwpdD49kDI1qMsY3R0cSC97fEOSJbcS26QIBmQrJjxcAqT5rfSMmqfdmDiQ4wQpiCN19Wgpi38I8Lw5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3a8RtViAU6NJPihpfy8sxeF6A97AR4gHBn5SIWqMkw=;
 b=dpSzKbfvZ1k8HUjc+0pClGtzCY8di/JnQoPf40oslwbKn1ZIfiX8FVO6OBJOpqnsuk69lNTQtvgZBWaENMzDyks6BySatS9iw5Di4Cx95GesqCGgMXuxOUxHOOEz4myhAS/E1yWoXOE+eTgFFo2ItnO+2Pw8Uj+Jd1KBGwfKhl8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 03:29:27 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::45b9:c993:87ec:9a64%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 03:29:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com,
        frieder.schrempf@kontron.de, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 05/13] soc: imx: gpcv2: wait for ADB400 handshake
Date:   Mon, 10 May 2021 12:00:37 +0800
Message-Id: <20210510040045.13225-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210510040045.13225-1-peng.fan@oss.nxp.com>
References: <20210510040045.13225-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-1xn6.ap.freescale.net (119.31.174.71) by SG2PR04CA0184.apcprd04.prod.outlook.com (2603:1096:4:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 03:29:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e30061-ccb0-4aa1-4167-08d91363d09f
X-MS-TrafficTypeDiagnostic: DB7PR04MB4091:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB409137ACCF74969C86DC6E22C9549@DB7PR04MB4091.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqxsmMVZxgJ8rVDzbPmfRM4zhjcSekCbir0Kk3hRNlUccV7Pmvw0dYuZh+Yd2dX7vbddS46KA8cbbs+eXfJ5mn/CtCRDW5nSGQK2Bv2jz3BvkjYJHug3/p2rfXD9ixEjj0k3W1201fXfRmT6VjiMbtxPpn/HFdc6T9SK9mHF+3aP4gtH5R/PcLDuI1PmxpnSth5Ue75htmFYysVclO2X9i89ulKCzKb6AM5X+zfUNXSOSPsadoIRX2xxoDoskOY9VOMnRARMGkqZsY4GZ1XxC7rkciWf/7guaO6OYkWwlt7MZAg9Js8iXP2T5iM/30/nodf/qXMtwYkd5vAPznT4kJh3LPhAw8cOBYq9g4lHDNLGF5t7eNK6gwn7F1dzb3R/HLi2BjCXhnoa6dQaQ+595xblgRWvIAVxGAVrdNDco0cR4MW6av3sA4QHOWn3xBW6tTZtUmoyHmrrTcT+rm/9HBcP4oe+k1usVYRn05Y+cN3sq91O4luPiYr7eVhqzw93gs2A+EiobJMfo/vju5FvNLZEIOdcbuaqpAQjCmFp6ySSlTJzu/8ZmI2RWj8vAb+W1xUa7L06Zy74QcZCupEJ+GpOas4obTAfwIPWuRb+pENPkcpldzK8xCdVDS1GA/mHNw+FyXYgdjCo6uCY2veaVNBP6iuj6Q7R3wDmon69qDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(316002)(86362001)(478600001)(4326008)(1076003)(2616005)(956004)(5660300002)(16526019)(6666004)(7416002)(66476007)(38100700002)(83380400001)(6506007)(52116002)(26005)(2906002)(38350700002)(6512007)(6486002)(66556008)(8936002)(186003)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n3ltLM6tx7MO9enjdzlrE+yim8IdcgMHwQRvTCDKL7zeN5+xuYnND5y9m2O9?=
 =?us-ascii?Q?tqd7A5ge8B7IaxxyF/FH1m8oniLAzRkKzEiJJtvrTinaGpPR6wkR50OoOmz0?=
 =?us-ascii?Q?m3ihaU9+5NlmWaDg0JJuPedAqWh1XQaCDX+e3VK8vHM9xXKmU5XDT5h8KPuu?=
 =?us-ascii?Q?+Nrb3ZWYQaiyDhm1f8BpW1AFFBxv9wK0cQ1EPcBl9fvIOrCOacwZE9N0Neqv?=
 =?us-ascii?Q?O98NzogNo+JwEqG2Beg6GZ7fP4DmUL2SfbQz9UqhPvFlcOcKD1VzVMw4fgVK?=
 =?us-ascii?Q?2e8JoSviTIlwbOSusXizMLB8lqPeixV2bYDiyGE53+s0zktP0AHonMgxV2eJ?=
 =?us-ascii?Q?PeMHeJgdoiaMP5eFF1h1cC4EN9XjGv/YqEQ0Y+Mu5gJ0IqcmHFjswtBmtXdg?=
 =?us-ascii?Q?8TofhzOQr58qustvrJNrgEgtDDnsF00ji1mSrp9YfR65aQNUC2qNgpsTQWUl?=
 =?us-ascii?Q?k3RQ4oCgJyCcNkCrkgZDjjfhYDspN5+y7CnFMP/4JUz8ooW7e0jyiqe2j9d8?=
 =?us-ascii?Q?2YA0LSQ88nKfMN8o8Q2f7jz8hHiWzZBX7Lli8hMDO8myMVzELEsO55sHNC5P?=
 =?us-ascii?Q?HdtzfnQ+nCrtpanE4Bq+vRUT0q7pNIBHgYAMnelXyoqh+m6WQXI2fCo3GbB2?=
 =?us-ascii?Q?C/vz4dnyjT7rES2OoQAtU79MMrnlatAhlT/+VxipD9dTXCOakgfp6HutdW9i?=
 =?us-ascii?Q?jfnhUP3Lsvp0tzRvo4BN9t4m5/aMqsg4/OyjKEHc9DcI/WKtnBZObcMUl4tr?=
 =?us-ascii?Q?Ou82HWT92CDpRl7Pe8C9SbNBbEo7ib2NMKWXaK1bq1MmwNPN1Co7P3iHdeEI?=
 =?us-ascii?Q?N/OkZx+F+AJeZ1mRthc4m5jge9mcpmlFVlcKPJbYJpmMS7XBZWRcxYgRd7LP?=
 =?us-ascii?Q?6ZM/hb/KAOLB+I3M/zUs4cUK3DSlSiWVD+5XzGzcY0o2IXdE7xBkjSPpAiUr?=
 =?us-ascii?Q?CRuJJk2Y3+fe+YR50GjprIwHjcJ7q5YHBpiMl25QLLO5ENoZ2y8JBRZPv8Tv?=
 =?us-ascii?Q?Epp3J5MdahhZufoqeU+aATxbjgVk0c45oQcCwNixMLwOCKZ4aQdl6wNbDtJ0?=
 =?us-ascii?Q?pao1LpAu7kIYxSpZ+f7Vho5ly02U3SEOqo4O+BT67iPgmo1dWnbT9fnRNd62?=
 =?us-ascii?Q?i/CZRo1OqHThJT2XE2ichiHpLAh1l97Yfg0rGTIuuAJI7dUuxnkA0dr3AKCy?=
 =?us-ascii?Q?MfwJkjcin95ej1TQwahsgIjKs1SepldcrUvHl+Giervvi6nFQ7tc+aJHWhtK?=
 =?us-ascii?Q?gINdlPm3DmWQJdH5HfZrOPxHgnbO50xqLlz934CP7ZHf1TCrM9d6TFy9kMPc?=
 =?us-ascii?Q?L/EvhklxHMFi1ESe1FNBheaX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e30061-ccb0-4aa1-4167-08d91363d09f
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 03:29:27.4432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36CZhUBruu/QaZTz8mO4KjO0rUeiyW82q8mxyJTkP+/rDql7olXHUihsnWhaZl/YULuV8BwppxW4r/KOy4GsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

New reference manuals show that there is actually a status bit for
the ADB400 handshake. Add a poll loop to wait for the ADB400 to
acknowledge our request.

[Peng Fan: i.MX8MM has blk ctl module, the handshake can only finish
 after setting blk ctl. The blk ctl driver will set the bus clk bit and
 the handshake will finish there. we just add a delay and suppose the
 handshake will finish after that.]

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 47 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index bcf1f338b0bf..c449cd0e1499 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -69,6 +69,9 @@
 
 #define GPC_PU_PWRHSK			0x1fc
 
+#define IMX8M_GPU_HSK_PWRDNACKN			BIT(26)
+#define IMX8M_VPU_HSK_PWRDNACKN			BIT(25)
+#define IMX8M_DISP_HSK_PWRDNACKN		BIT(24)
 #define IMX8M_GPU_HSK_PWRDNREQN			BIT(6)
 #define IMX8M_VPU_HSK_PWRDNREQN			BIT(5)
 #define IMX8M_DISP_HSK_PWRDNREQN		BIT(4)
@@ -112,7 +115,8 @@ struct imx_pgc_domain {
 	const struct {
 		u32 pxx;
 		u32 map;
-		u32 hsk;
+		u32 hskreq;
+		u32 hskack;
 	} bits;
 
 	const int voltage;
@@ -172,9 +176,23 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 			  GPC_PGC_CTRL_PCR);
 
 	/* request the ADB400 to power up */
-	if (domain->bits.hsk)
+	if (domain->bits.hskreq) {
 		regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
-				   domain->bits.hsk, domain->bits.hsk);
+				   domain->bits.hskreq, domain->bits.hskreq);
+
+		/*
+		 * ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
+		 *				  (reg_val & domain->bits.hskack), 0,
+		 *				  USEC_PER_MSEC);
+		 * Technically we need the commented code to wait handshake. But that needs
+		 * the BLK-CTL module BUS clk-en bit being set.
+		 *
+		 * There is a separate BLK-CTL module and we will have such a driver for it,
+		 * that driver will set the BUS clk-en bit and handshake will be triggered
+		 * automatically there. Just add a delay and suppose the handshake finish
+		 * after that.
+		 */
+	}
 
 	/* Disable reset clocks for all devices in the domain */
 	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
@@ -204,9 +222,19 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 	}
 
 	/* request the ADB400 to power down */
-	if (domain->bits.hsk)
+	if (domain->bits.hskreq) {
 		regmap_clear_bits(domain->regmap, GPC_PU_PWRHSK,
-				  domain->bits.hsk);
+				  domain->bits.hskreq);
+
+		ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK,
+					       reg_val,
+					       !(reg_val & domain->bits.hskack),
+					       0, USEC_PER_MSEC);
+		if (ret) {
+			dev_err(domain->dev, "failed to power down ADB400\n");
+			goto out_clk_disable;
+		}
+	}
 
 	/* enable power control */
 	regmap_update_bits(domain->regmap, GPC_PGC_CTRL(domain->pgc),
@@ -369,7 +397,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_GPU_SW_Pxx_REQ,
 			.map = IMX8M_GPU_A53_DOMAIN,
-			.hsk = IMX8M_GPU_HSK_PWRDNREQN,
+			.hskreq = IMX8M_GPU_HSK_PWRDNREQN,
+			.hskack = IMX8M_GPU_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_GPU,
 	},
@@ -381,7 +410,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_VPU_SW_Pxx_REQ,
 			.map = IMX8M_VPU_A53_DOMAIN,
-			.hsk = IMX8M_VPU_HSK_PWRDNREQN,
+			.hskreq = IMX8M_VPU_HSK_PWRDNREQN,
+			.hskack = IMX8M_VPU_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_VPU,
 	},
@@ -393,7 +423,8 @@ static const struct imx_pgc_domain imx8m_pgc_domains[] = {
 		.bits  = {
 			.pxx = IMX8M_DISP_SW_Pxx_REQ,
 			.map = IMX8M_DISP_A53_DOMAIN,
-			.hsk = IMX8M_DISP_HSK_PWRDNREQN,
+			.hskreq = IMX8M_DISP_HSK_PWRDNREQN,
+			.hskack = IMX8M_DISP_HSK_PWRDNACKN,
 		},
 		.pgc   = IMX8M_PGC_DISP,
 	},
-- 
2.30.0

