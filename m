Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5163FEDCF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbhIBMds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:33:48 -0400
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:13189
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237217AbhIBMdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:33:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXu5XcD5J7IttsqQpicWzzFLY3Y0ZWcF1ZAgHZ3StETOk7gwPg/XixoEulEChvOLAhry/XbT6QrcA4djZWhwn2h83soLGlufm1sTSxPZ26iAwrcMgbR1fg+6AyJPl7G7X6Ssyx+SO7DrxQwLIAk4vh+ogbsUt5Yr6u9fQwpjsXh9gOdWVolO/3TYxGXwOdJAAHl58eJHMEuHB/U9Fz6pgn77hk8vR/wOMFISSKTZ5Gs9qf9lXOxvDSU95DUoh0SLolGteQA4l07C4iyBQuEDWV4wQBMwUWc6hDmZsn/dd4ghQ0oHeVXFOfH4xTK9JcZQLlAgSkJejZfuA166TtwvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bV5mCKm+WS6WbGUVy6IBh8RnnX50rVvdUVbxn7wyGNU=;
 b=hL2AmUOB2wiq4pji5OmzxWWJB+KxxPyGUsWnRY6Kh+zp+PHP/1YA5j3BmAXmvGhBrjepjReBVzHvbDU1J4QRvewgugAYxJZ+6e0Y80z6IbpLt+S1Z8SB1wSiPPU2UyOuCyraY9NNLK4u7qoSWSHdj15XmajqoQh7dgBboUrVGKHgUbmLyQwK+7v1njR68gss43lxMQbyqyFwraYhdCtYZ73RYf/cLSOp7rS8WsaYD14pE+H+woyU044yF6zfEcoRWopCeWKLl72glFo8yvAxGcxx74wFzAseYVKAMYW7Fp/nvBkOHHb13hd7r/gbh63LEP36tDWfNcL2A4Ym52t1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV5mCKm+WS6WbGUVy6IBh8RnnX50rVvdUVbxn7wyGNU=;
 b=exE9AIlV3wUUpieYGYGiLuFX8FycNJlwlQB9Km0gsXNzOQ+HAIm+OhFalo37pIV3+/QFgEsV3ZBQV+RUurjAOp17EJNaR56aU24CyKeUWKW0qE2QYaTGrDW3OfCZ3llJHcxSHo7nVWjCj9QibvnO9+39Nh2Rz6jtMdxDJLNod2Q=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Thu, 2 Sep
 2021 12:32:41 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28%7]) with mapi id 15.20.4457.026; Thu, 2 Sep 2021
 12:32:41 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, peter.ujfalusi@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        s-anna@ti.com, Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
Date:   Thu,  2 Sep 2021 15:32:15 +0300
Message-Id: <20210902123216.787025-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
References: <20210902123216.787025-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0902CA0011.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::21) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5708:8600:3b00:218a:73cd:7fff) by AM4PR0902CA0011.eurprd09.prod.outlook.com (2603:10a6:200:9b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Thu, 2 Sep 2021 12:32:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e2803f5-0a5f-4754-81a9-08d96e0dc1ef
X-MS-TrafficTypeDiagnostic: VI1PR04MB7053:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB7053F854E42397C784162DC2B8CE9@VI1PR04MB7053.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxvPd/NSoXnAFuEmB4iE6Ybbp7YASE65TaKcUyFK5TuTqWsabHB98ICAvn3PZuRdi6WPovB2Lwxb3FZO4LYayeU6y0JJJKs6pBxfq2us9Th0ieg4xOukBMBBxovJ+p/ZtT2OvqRZrDZDGVIzXmkCuuHwV8dTCRtzQwOLZxVJqVZHsvQ1fJkfrJMY3PVl9rycVEcnu7cr+55YOj8AmIzMq1DBSwIW3l1bZs1EJAnGBDr/Rn5/dpvl/ov0n98t8GotZOmCGbZS7XftWN3Z5evM/FdRQ6AWOKxf4s6Ps8NsKDSD3iLaU3ai2Lqv2LLBE/HH2kSg3XePAWjAMY09yRjlsEFRJ1fo07E2b2+jWAWx6pCTKbIySznTQJJXdNogPB+2VZ+hehew+2KsQzleYIM3kWwYDCztGt3s6lsbR5BRNmD7ZL6LCoPLwiTZ+WWe68qbLH/2HL8fvbCi6vcaNDuPWyR41/RHVeT9jXPBID+q5dj/5cpC5Kn/5i1bGv67+ecwBHbYlPTaHlLOXZ50P0jROOhihaYGAUv164KR+QOFiKrZUbQ52TSyZv/wWM+IXGMEvDWFmhXyJl3lFtjepOR2drmU2mDrgxSfmx8qE3zJO3w8xohFZaov7oYG9wfbc2+u4jqzp5l5KJ6njQrcOMj1yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(44832011)(478600001)(6506007)(66476007)(66556008)(66946007)(5660300002)(2616005)(8936002)(4326008)(38100700002)(8676002)(6512007)(7416002)(1076003)(6486002)(6666004)(86362001)(83380400001)(2906002)(52116002)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0zgERe7Mkzypge0JpW9FicLZpPEgZsEXQEnHc+n4ev08HEhsVmiICnpiIB6F?=
 =?us-ascii?Q?NEhYYdG+zr60pa873p1QZ7SkF3BdxionmK8eol6W1Burt5SGAqlPOwvRQ34E?=
 =?us-ascii?Q?Fhqbaw3/PBAyMnnWCTyj0sfh5PwM5SsrP6BPCbRhJrLEJQX8GGtUHwpLqIdX?=
 =?us-ascii?Q?Eq5cg03MWieFvPU17uu1G5ONDpSgRQKQ0+mzApXtxvah3VXanUmzih82uyMg?=
 =?us-ascii?Q?bQT6V/Xo8dKU9Fer52ZGkv+/gtAgQcYXsAbwrh7B2g5ffNesOvZ0w1/LK8wR?=
 =?us-ascii?Q?l7klanw/Vcs+PaMcwjf3tFRFM+lh7/KxMlDV3QjU8Z7/dyQuSuVFJw+ZHPJR?=
 =?us-ascii?Q?zKXD+lVpVYcA+P+Tleg2fCpOG00KWbU7gunaYxBiW/38Jbeeyec7Tc2TVSZP?=
 =?us-ascii?Q?9W+iWT69Z7REUamyT/AFsPkUs7QX3qZvLk5hlagTAFGsxH+op/i9BDC9hw//?=
 =?us-ascii?Q?Bw1pzx3jQxaJiJbfW9moF+lhQNH5cZJHLnbY7L4vOz8jbxEqkWijOLvWMxSJ?=
 =?us-ascii?Q?5u0TusdpGuNSdWLx4rfKqTB7wgqJVbe33v/UVcYpNOjFkpqQTTBSSJO9ZkKv?=
 =?us-ascii?Q?flNsVq1tQx0ai30j1NJSk6A6OJ0swpBSb6fOgXJqGxMndw2KqAhj3vD69Yaa?=
 =?us-ascii?Q?bMtBvKh88ZWvzrvOyTNb9SCMLVQ5joyynQSdkSpRBwFZl4xwpybd0ad7DLfq?=
 =?us-ascii?Q?xL5pxElE02ZKc4QSb2A0gRMvpFWuy2Q8MFfd58GWp2CwJm7g/Zf/MHIatZXl?=
 =?us-ascii?Q?vg0JozPWFfz+z5ezvenBpuiYC9xIbbNDogJPUON+WRAO6MD0Qu1ifUVNCgt9?=
 =?us-ascii?Q?X4jKxhZIZ9ksbiA17skJExsGePPmuVzUG5xmE/EDudg0aM4NL4Mh0yv2tDdx?=
 =?us-ascii?Q?oTWVYsOssqKcEFFtVp0mpMmQU7q7ub/qu6xFi9xTHwpJfGs/mP5ZsMTnpcTB?=
 =?us-ascii?Q?TESgf9fTHuhMT7gYbAFA9YZgj2uB71DcXd4qGlxiA79Z1PMDBdg7VhnoxLMK?=
 =?us-ascii?Q?d5LJJV+XfNs0yGp4V7IY1DtUQ4YKUXRsXFsbHjfIZ5EtfKwQOFXhfFiyQ51n?=
 =?us-ascii?Q?JRySJ4PbPPnAdBqB032lERvTPaekm8hPOFx9QU91OHHfU64d7g4eAXkxVSsL?=
 =?us-ascii?Q?VpXuCco94YxEagUhYKgxmGBZNQTnAuTv3X00YV0Dq+e4JlmniXK22jqco5Th?=
 =?us-ascii?Q?+YkRWDoXr+IzN0M4vEfr5VkKS/vhbHUYdOJjnWe5AN/3K8l7gguv6uPnE49O?=
 =?us-ascii?Q?jDga7ExI7IQEH1MQLY+XPWiwOqUU3DLiB1eZUDHtqfJPcZPV6HDvMLFPNaoQ?=
 =?us-ascii?Q?V4MTXvHepf53krci0g81Bhoywq/rea88NlUrLs1H+MKrfxLyTF02hCDb12a7?=
 =?us-ascii?Q?VMJwHaF0PgPtfc46S4GJGd3iaFyW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2803f5-0a5f-4754-81a9-08d96e0dc1ef
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 12:32:41.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CAizTaxfuRZGxeCaaaVhvXHQbZnXkmr/C0d0cyXDlgJ5CoW5HKhAabPeL77lgoo49Yf7F1q30ZNQWthJrRCsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

There are two types of clocks:
	* DSP IP clocks
	* DAI clocks

This clocks are necessary in order to power up DSP and DAIs.

We choose to enable DAI clocks here because of the way i.MX8/i.MX8X
design handles resources (including clocks).

All clocks are managed by a separate core (named SCU) which communicates
with Linux managed ARM core via a well known API.

We parse and enable the clocks in probe function and disable them in
remove function.

Future patches will introduce Power Management support so that we
disable clocks while DSP is not used or system enters power save.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/imx/imx-common.c | 77 ++++++++++++++++++++++++++++++++++
 sound/soc/sof/imx/imx-common.h | 16 +++++++
 sound/soc/sof/imx/imx8.c       | 32 ++++++++++++++
 sound/soc/sof/imx/imx8m.c      | 33 +++++++++++++++
 4 files changed, 158 insertions(+)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 8826ef94f04a..20bcfab7b653 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -74,4 +74,81 @@ void imx8_dump(struct snd_sof_dev *sdev, u32 flags)
 }
 EXPORT_SYMBOL(imx8_dump);
 
+int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
+{
+	int i;
+
+	clks->dsp_clks = devm_kcalloc(sdev->dev, clks->num_dsp_clks,
+				      sizeof(*clks->dsp_clks), GFP_KERNEL);
+	if (!clks->dsp_clks)
+		return -ENOMEM;
+
+	clks->dai_clks = devm_kcalloc(sdev->dev, clks->num_dai_clks,
+				      sizeof(*clks->dai_clks), GFP_KERNEL);
+	if (!clks->dai_clks)
+		return -ENOMEM;
+
+	for (i = 0; i < clks->num_dsp_clks; i++) {
+		clks->dsp_clks[i] = devm_clk_get(sdev->dev, clks->dsp_clks_names[i]);
+		if (IS_ERR(clks->dsp_clks[i])) {
+			dev_err(sdev->dev, "Failed to get clk %s\n", clks->dsp_clks_names[i]);
+			return PTR_ERR(clks->dsp_clks[i]);
+		}
+	}
+
+	for (i = 0; i < clks->num_dai_clks; i++)
+		clks->dai_clks[i] = devm_clk_get_optional(sdev->dev, clks->dai_clks_names[i]);
+
+	return 0;
+}
+EXPORT_SYMBOL(imx8_parse_clocks);
+
+int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
+{
+	int i, j, ret;
+
+	for (i = 0; i < clks->num_dsp_clks; i++) {
+		ret = clk_prepare_enable(clks->dsp_clks[i]);
+		if (ret < 0) {
+			dev_err(sdev->dev, "Failed to enable clk %s\n",
+				clks->dsp_clks_names[i]);
+			goto err_dsp_clks;
+		}
+	}
+
+	for (j = 0; j < clks->num_dai_clks; j++) {
+		ret = clk_prepare_enable(clks->dai_clks[j]);
+		if (ret < 0) {
+			dev_err(sdev->dev, "Failed to enable clk %s\n",
+				clks->dai_clks_names[j]);
+			goto err_dai_clks;
+		}
+	}
+
+	return 0;
+
+err_dai_clks:
+	while (--j >= 0)
+		clk_disable_unprepare(clks->dai_clks[j]);
+
+err_dsp_clks:
+	while (--i >= 0)
+		clk_disable_unprepare(clks->dsp_clks[i]);
+
+	return ret;
+}
+EXPORT_SYMBOL(imx8_enable_clocks);
+
+void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
+{
+	int i;
+
+	for (i = 0; i < clks->num_dsp_clks; i++)
+		clk_disable_unprepare(clks->dsp_clks[i]);
+
+	for (i = 0; i < clks->num_dai_clks; i++)
+		clk_disable_unprepare(clks->dai_clks[i]);
+}
+EXPORT_SYMBOL(imx8_disable_clocks);
+
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/imx/imx-common.h b/sound/soc/sof/imx/imx-common.h
index 1cc7d6704182..a9bd16d61e8f 100644
--- a/sound/soc/sof/imx/imx-common.h
+++ b/sound/soc/sof/imx/imx-common.h
@@ -3,6 +3,8 @@
 #ifndef __IMX_COMMON_H__
 #define __IMX_COMMON_H__
 
+#include <linux/clk.h>
+
 #define EXCEPT_MAX_HDR_SIZE	0x400
 #define IMX8_STACK_DUMP_SIZE 32
 
@@ -13,4 +15,18 @@ void imx8_get_registers(struct snd_sof_dev *sdev,
 
 void imx8_dump(struct snd_sof_dev *sdev, u32 flags);
 
+struct imx_clocks {
+	const char **dsp_clks_names;
+	struct clk **dsp_clks;
+	int num_dsp_clks;
+
+	const char **dai_clks_names;
+	struct clk **dai_clks;
+	int num_dai_clks;
+};
+
+int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
+int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
+void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
+
 #endif
diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index fc1720c211a3..2937300200b2 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -41,6 +41,20 @@
 #define MBOX_OFFSET	0x800000
 #define MBOX_SIZE	0x1000
 
+#define IMX8_DSP_CLK_NUM	3
+static const char *imx8_dsp_clks_names[IMX8_DSP_CLK_NUM] = {
+	/* DSP clocks */
+	"ipg", "ocram", "core",
+};
+
+#define IMX8_DAI_CLK_NUM	9
+static const char *imx8_dai_clks_names[IMX8_DAI_CLK_NUM] = {
+	/* ESAI0 clocks */
+	"esai0_core", "esai0_extal", "esai0_fsys", "esai0_spba",
+	/* SAI1 clocks */
+	"sai1_bus", "sai1_mclk0", "sai1_mclk1", "sai1_mclk2", "sai1_mclk3",
+};
+
 struct imx8_priv {
 	struct device *dev;
 	struct snd_sof_dev *sdev;
@@ -57,6 +71,7 @@ struct imx8_priv {
 	struct device **pd_dev;
 	struct device_link **link;
 
+	struct imx_clocks *clks;
 };
 
 static void imx8_get_reply(struct snd_sof_dev *sdev)
@@ -223,6 +238,10 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
 	sdev->num_cores = 1;
 	sdev->pdata->hw_pdata = priv;
 	priv->dev = sdev->dev;
@@ -336,6 +355,18 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
 
+	/* init clocks info */
+	priv->clks->dsp_clks_names =  imx8_dsp_clks_names;
+	priv->clks->num_dsp_clks = IMX8_DSP_CLK_NUM;
+	priv->clks->dai_clks_names = imx8_dai_clks_names;
+	priv->clks->num_dai_clks = IMX8_DAI_CLK_NUM;
+
+	ret = imx8_parse_clocks(sdev, priv->clks);
+	if (ret < 0)
+		goto exit_pdev_unregister;
+
+	imx8_enable_clocks(sdev, priv->clks);
+
 	return 0;
 
 exit_pdev_unregister:
@@ -354,6 +385,7 @@ static int imx8_remove(struct snd_sof_dev *sdev)
 	struct imx8_priv *priv = sdev->pdata->hw_pdata;
 	int i;
 
+	imx8_disable_clocks(sdev, priv->clks);
 	platform_device_unregister(priv->ipc_dev);
 
 	for (i = 0; i < priv->num_domains; i++) {
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 30624fafc632..482c25ab15ce 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -23,6 +23,20 @@
 #define MBOX_OFFSET	0x800000
 #define MBOX_SIZE	0x1000
 
+#define IMX8M_DSP_CLK_NUM	3
+static const char *imx8m_dsp_clks_names[IMX8M_DSP_CLK_NUM] = {
+	/* DSP clocks */
+	"ipg", "ocram", "core",
+};
+
+#define IMX8M_DAI_CLK_NUM	6
+static const char *imx8m_dai_clks_names[IMX8M_DAI_CLK_NUM] = {
+	/* SAI3 clocks */
+	"sai3_bus", "sai3_mclk0", "sai3_mclk1", "sai3_mclk2", "sai3_mclk3",
+	/* DMA3 clocks */
+	"sdma3_root",
+};
+
 struct imx8m_priv {
 	struct device *dev;
 	struct snd_sof_dev *sdev;
@@ -30,6 +44,8 @@ struct imx8m_priv {
 	/* DSP IPC handler */
 	struct imx_dsp_ipc *dsp_ipc;
 	struct platform_device *ipc_dev;
+
+	struct imx_clocks *clks;
 };
 
 static void imx8m_get_reply(struct snd_sof_dev *sdev)
@@ -143,6 +159,10 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
 	sdev->num_cores = 1;
 	sdev->pdata->hw_pdata = priv;
 	priv->dev = sdev->dev;
@@ -211,6 +231,18 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
 
+	/* init clocks info */
+	priv->clks->dsp_clks_names = imx8m_dsp_clks_names;
+	priv->clks->num_dsp_clks = IMX8M_DSP_CLK_NUM;
+	priv->clks->dai_clks_names = imx8m_dai_clks_names;
+	priv->clks->num_dai_clks = IMX8M_DAI_CLK_NUM;
+
+	ret = imx8_parse_clocks(sdev, priv->clks);
+	if (ret < 0)
+		goto exit_pdev_unregister;
+
+	imx8_enable_clocks(sdev, priv->clks);
+
 	return 0;
 
 exit_pdev_unregister:
@@ -222,6 +254,7 @@ static int imx8m_remove(struct snd_sof_dev *sdev)
 {
 	struct imx8m_priv *priv = sdev->pdata->hw_pdata;
 
+	imx8_disable_clocks(sdev, priv->clks);
 	platform_device_unregister(priv->ipc_dev);
 
 	return 0;
-- 
2.27.0

