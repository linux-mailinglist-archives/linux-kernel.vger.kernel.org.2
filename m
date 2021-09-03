Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2376140018F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbhICOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:55:01 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:11191
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349217AbhICOy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGgQ/eni/Chg89iOjOI4P/EW+1F1iXKcyrd9LnEVQS/qgJ37KkuWysm1gcHp9GhuEG6J0lyC3W8Grj2pPRk63594SzAwW6wjeQ4Ajw85aG7RuMOq/D2vWDhg2iGvKIkONE5/z+lsRFgLx9K4pKXrokR8DbEqCT2o5/8jExvm2HXpWmMyhalrU1CGUR4kck9IAz3lEF0Lr44fNCwBXkEBz3qFq7ExSDiP9mIx1nyhfS7nuRxc4qwCL0XD/DuOLwpkeH+aSvg20h3cTG75N7wEVCnVmu+wBQxrpk1Y5VPjwzmhYxGqzEItkVdiHjdoKMO9E76BUs3Cdf+38E7TPfuvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lxkVM+lIDeGVZ9KQ2SdnVmjtkLWXupqDq2NlzIAS/rY=;
 b=I3dfqy+I5Ph0eBl0QxiDaD5E6WEmkITPeYqEySijZdRglhuMocI3AFsBmRlEljvkdDIwKOjBeD5pVoG6JnHB9PeFd0cqYH90GJ7ZNJvuHMRRxNsKvYpc/fnilHTP/gd5ODjh0Ax+Y+l9tr3R6Z16/3xGAi000wG3TMSn4ZV6AzjDvff+/3pxxpdx9O8TUka9U3DcSflnGWW54oabaG2uQhk5/a0z6JRkybEpfbFpGAMVtIBDxhGJRNBAgEvAcBXvCtOK3HVpjWu7zeOlIKISPZ62FVM8k3jtz2D8hYx24ZpCp3C2sfYWMY8evr/Q5f7Mq2lqhjbRxBDY8PxO1Oq8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxkVM+lIDeGVZ9KQ2SdnVmjtkLWXupqDq2NlzIAS/rY=;
 b=PbKZLmxNn/r6KW1geUoFJeagI7AHsgWPAT8+NNkf1K5FnkwAonpsTeaOaQvhhkP0XSDxDpxs0hakI+C/1bSe3OgKFH3hxzZ76YOgtJWgqA9Q3jibPpMir7I1o3bqyGyiAZjCdziwx6x8cYwWEF+bNJa+2YGizxFOM+CfM2ZyGdI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR0401MB2654.eurprd04.prod.outlook.com (2603:10a6:800:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Fri, 3 Sep
 2021 14:53:55 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::499b:ba92:db2e:3f28%7]) with mapi id 15.20.4457.026; Fri, 3 Sep 2021
 14:53:55 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
Cc:     devicetree@vger.kernel.org, shawnguo@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peter.ujfalusi@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, s-anna@ti.com,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/2] ASoC: SOF: imx: Add code to manage DSP related clocks
Date:   Fri,  3 Sep 2021 17:53:39 +0300
Message-Id: <20210903145340.225511-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0200.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::24) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5708:8600:fd8d:b9e7:97b5:dd4a) by VI1PR07CA0200.eurprd07.prod.outlook.com (2603:10a6:802:3f::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Fri, 3 Sep 2021 14:53:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5272852-651b-4dad-c925-08d96eeaa71e
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2654:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2654562AA244FAF9E21C786EB8CF9@VI1PR0401MB2654.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /JcwRlRHY9A+/xyXBPbAhIbn/7JLnyjfmQGM0A+SqohBrQQHeouP9co2vg2KvRu76MBV7hwhGoK6xWH9zn114s+Dc7rAi1gCtT+t0CQKNoVtrAh6xguzOUPNutvJS0S7q0WAiuBsghTXRGzsChvOJ3JRK4o2LvVS7iX0bniktQ5Gmxqxz3PvRt2nRWPSN9M9jw7JnpPzCZ0ayAVFUxq6XRGhC/WOdAKJcYSSMDOf78UVDwRi0TytNdyO8UXrQqvQMs/gbfjtNRclfpRGQqbACY+hDLYZqeifaCRiYJPi7my4nO8AIAIYFalvZzj9Zw4+f6obinAQdEk+9HuLbyfVYlgOPUtzSvOZBVG3TNOh7SLEAcKvYE6U2iuRb6/fKf5lmdDcHEbtNAqZOeIiae48UmY3F5TCYfDHAM6gnQegE8rPbftWSwpQHXp49FNBVo2dNtbXycfVMs9mi51TK5oSJ1CTsxCbhp3gyYFzip6G1zAVIPTOyJBqt/MLvkGlBocabTJp0MInkUAWHdudL8avcOp1KFjEP8M6fZ63QxStnwqU4TVstkJT/60m6w8MhSn11J47hkmJWPdzAodNN6C15/ERDO9/MxLqiUnymCS8NHsuJpejJ/dVgZNWAKrn958QlGrpS3xUvs0zrWFjkKBWng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(38100700002)(66946007)(44832011)(52116002)(6506007)(86362001)(8676002)(6666004)(5660300002)(316002)(2906002)(66556008)(4326008)(6512007)(6486002)(66476007)(508600001)(2616005)(1076003)(83380400001)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AWs9qUU7i44nvULr7my5KJGwO3tBjZUvcgpJX4MiQai7/+f0zy2f7GAUEwyW?=
 =?us-ascii?Q?TtIOucUWLelssUHI+OZcKwSTVAtBsPFvj4ObuNYXupKDb5GB5KCDQt+ACfg1?=
 =?us-ascii?Q?hUEHrBOwDX8se4SUEUFitxsCESk8zMuGXDHuHxogfnAiPQFNNyJJqcpZBtj7?=
 =?us-ascii?Q?Gx8Upr5fuF4IunDNcz12Y2XJmm3ro3PwSdrSahUWPofxDyWvdJWHhpmeX/VY?=
 =?us-ascii?Q?0EtsDMBydQSkE0XejpFwSZH+KmqEb/SYZQO6xCVHNESk2Hgn9VWrkocXMinK?=
 =?us-ascii?Q?xfFRJbvq8HKCKILnX/R4UIm6K1pyVOneAlFl3uKlVEWQqDqX9bQr0NlITrY4?=
 =?us-ascii?Q?GGm7eJDoRHX+iE6iZdxtYioFVo2Vs2AIzhOiRxmwcFdbhnep3+DYBCErWCB3?=
 =?us-ascii?Q?KzHksyougRpVH2zHd5P8FIJq05G2Ex4n/f7YRRQw0PBCpLbQUMWRjhpWzF0r?=
 =?us-ascii?Q?2ebgc8ycSzywZXEsGVPVX/5UK+KkhWFhB44EAINdqd8i90f2qJJFi2RSmkii?=
 =?us-ascii?Q?9N9oj9+f1XQ9H6bDn/pO9FCYL4Txnu5bzNgytiATMHPpN8+0S9o45SIeCsQe?=
 =?us-ascii?Q?yPjHfTycT8LdTjNkQr+JIiqqC0Nze3lezgjFy5ZYHmPygx+g0v2D8C7IODkX?=
 =?us-ascii?Q?9E5WcKWkQQpAL+6VQ6pA3L6xcYVkE9NSmxpI0EvT/8uq/OVomYd1MBvkbmcN?=
 =?us-ascii?Q?JCyh6PhqnkD/q39WOewjZQHZbA2F8UdSDG1T0vSPfx3xK9+RluouZN2U5lWD?=
 =?us-ascii?Q?5xzdEGGruQCJ/3m5gfyWdVvekoDJFw3Zs7mA2hdg37+PpE5oZyxKuKaUhlyB?=
 =?us-ascii?Q?HYpFfCMsARYCjyo5EhlXls2jPRlclWgyQU96fOVYn2tuveRY5a7k4TPM1/1l?=
 =?us-ascii?Q?zgmIdUS5vMDgp6qelyRO8LVwgHojtFeiWJjgOIUM1BxAwCrkMUmcQx172Dzm?=
 =?us-ascii?Q?SxPNp2k8bmBk8b3lt03+UtVhfLA3GhuwcfHegtE5ztQtxVlHZf7T1APsTqaH?=
 =?us-ascii?Q?1u4Ezz0fD1JXMuRlbFRERwmEMsZjeGApCEhzJ2hVHzU+ECOaWB6VTnwCECsA?=
 =?us-ascii?Q?m9h6T7W7/AL1th2HtPzt7hu/tOQ+GMknOjVd1tquLMkN8ybHw2QlfYvJGEbO?=
 =?us-ascii?Q?9IzoSX14EpMhYrbdhRuw9/UmnNj/zd4zNie9vwXTSQX7DEQrbUHohR6WJt/Z?=
 =?us-ascii?Q?5GvSJ6V1St8g5KvETPiH335BmjO1dR1g5Na6ShYkpX0Wo5jdsBMh6wyS/B0U?=
 =?us-ascii?Q?3rYg9XVvRSyLw5YmnFn0FNrse5OxfeRAYqo/r/v89XiUM/8sXRQ5PJUoCZdi?=
 =?us-ascii?Q?ioRb3gQ6EM3vTgwmrNXtvoXCQA8f20yY5gJfHQdDySQudFkaKjSTGMhPJI+8?=
 =?us-ascii?Q?UwKJ4spWJ93KqdCXgHscWhDkwR1N?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5272852-651b-4dad-c925-08d96eeaa71e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 14:53:55.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySxkXKfZG7lZOa2bZKT+zQyJA2QB7rmhgfC5OWCiKWaKxqCMPOo+6m+/4KQtE+gvcO4oJRDeHUr0Du09lTM5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2654
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
 sound/soc/sof/imx/imx-common.c | 44 ++++++++++++++++++++++++++++++++++
 sound/soc/sof/imx/imx-common.h | 13 ++++++++++
 sound/soc/sof/imx/imx8.c       | 37 ++++++++++++++++++++++++++++
 sound/soc/sof/imx/imx8m.c      | 34 ++++++++++++++++++++++++++
 4 files changed, 128 insertions(+)

diff --git a/sound/soc/sof/imx/imx-common.c b/sound/soc/sof/imx/imx-common.c
index 8826ef94f04a..f9d650ad3846 100644
--- a/sound/soc/sof/imx/imx-common.c
+++ b/sound/soc/sof/imx/imx-common.c
@@ -74,4 +74,48 @@ void imx8_dump(struct snd_sof_dev *sdev, u32 flags)
 }
 EXPORT_SYMBOL(imx8_dump);
 
+int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
+{
+	int ret;
+
+	ret = devm_clk_bulk_get(sdev->dev, clks->num_dsp_clks, clks->dsp_clks);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to request DSP clocks\n");
+		return ret;
+	}
+
+	ret = devm_clk_bulk_get_optional(sdev->dev, clks->num_dai_clks, clks->dai_clks);
+	if (ret) {
+		dev_err(sdev->dev, "Failed to request DAI clks\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx8_parse_clocks);
+
+int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
+{
+	int ret;
+
+	ret = clk_bulk_prepare_enable(clks->num_dsp_clks, clks->dsp_clks);
+	if (ret)
+		return ret;
+	ret = clk_bulk_prepare_enable(clks->num_dai_clks, clks->dai_clks);
+	if (ret) {
+		clk_bulk_disable_unprepare(clks->num_dsp_clks, clks->dsp_clks);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx8_enable_clocks);
+
+void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks)
+{
+	clk_bulk_disable_unprepare(clks->num_dsp_clks, clks->dsp_clks);
+	clk_bulk_disable_unprepare(clks->num_dai_clks, clks->dai_clks);
+}
+EXPORT_SYMBOL(imx8_disable_clocks);
+
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/imx/imx-common.h b/sound/soc/sof/imx/imx-common.h
index 1cc7d6704182..54fba9fcd861 100644
--- a/sound/soc/sof/imx/imx-common.h
+++ b/sound/soc/sof/imx/imx-common.h
@@ -3,6 +3,8 @@
 #ifndef __IMX_COMMON_H__
 #define __IMX_COMMON_H__
 
+#include <linux/clk.h>
+
 #define EXCEPT_MAX_HDR_SIZE	0x400
 #define IMX8_STACK_DUMP_SIZE 32
 
@@ -13,4 +15,15 @@ void imx8_get_registers(struct snd_sof_dev *sdev,
 
 void imx8_dump(struct snd_sof_dev *sdev, u32 flags);
 
+struct imx_clocks {
+	struct clk_bulk_data *dsp_clks;
+	int num_dsp_clks;
+	struct clk_bulk_data *dai_clks;
+	int num_dai_clks;
+};
+
+int imx8_parse_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
+int imx8_enable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
+void imx8_disable_clocks(struct snd_sof_dev *sdev, struct imx_clocks *clks);
+
 #endif
diff --git a/sound/soc/sof/imx/imx8.c b/sound/soc/sof/imx/imx8.c
index fc1720c211a3..5370d34edd61 100644
--- a/sound/soc/sof/imx/imx8.c
+++ b/sound/soc/sof/imx/imx8.c
@@ -41,6 +41,25 @@
 #define MBOX_OFFSET	0x800000
 #define MBOX_SIZE	0x1000
 
+/* DSP clocks */
+struct clk_bulk_data imx8_dsp_clks[] = {
+	{ .id = "ipg" },
+	{ .id = "ocram" },
+	{ .id = "core" },
+};
+
+/* DAI clocks */
+struct clk_bulk_data imx8_dai_clks[] = {
+	{ .id = "esai0_core" },
+	{ .id = "esai0_extal" },
+	{ .id = "esai0_spba" },
+	{ .id = "sai1_bus" },
+	{ .id = "sai1_mclk0" },
+	{ .id = "sai1_mclk1" },
+	{ .id = "sai1_mclk2" },
+	{ .id = "sai1_mclk3" },
+};
+
 struct imx8_priv {
 	struct device *dev;
 	struct snd_sof_dev *sdev;
@@ -57,6 +76,7 @@ struct imx8_priv {
 	struct device **pd_dev;
 	struct device_link **link;
 
+	struct imx_clocks *clks;
 };
 
 static void imx8_get_reply(struct snd_sof_dev *sdev)
@@ -223,6 +243,10 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
 	sdev->num_cores = 1;
 	sdev->pdata->hw_pdata = priv;
 	priv->dev = sdev->dev;
@@ -336,6 +360,18 @@ static int imx8_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
 
+	/* init clocks info */
+	priv->clks->dsp_clks = imx8_dsp_clks;
+	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8_dsp_clks);
+	priv->clks->dai_clks = imx8_dai_clks;
+	priv->clks->num_dai_clks = ARRAY_SIZE(imx8_dai_clks);
+
+	ret = imx8_parse_clocks(sdev, priv->clks);
+	if (ret < 0)
+		goto exit_pdev_unregister;
+
+	imx8_enable_clocks(sdev, priv->clks);
+
 	return 0;
 
 exit_pdev_unregister:
@@ -354,6 +390,7 @@ static int imx8_remove(struct snd_sof_dev *sdev)
 	struct imx8_priv *priv = sdev->pdata->hw_pdata;
 	int i;
 
+	imx8_disable_clocks(sdev, priv->clks);
 	platform_device_unregister(priv->ipc_dev);
 
 	for (i = 0; i < priv->num_domains; i++) {
diff --git a/sound/soc/sof/imx/imx8m.c b/sound/soc/sof/imx/imx8m.c
index 30624fafc632..fea1b72bebaa 100644
--- a/sound/soc/sof/imx/imx8m.c
+++ b/sound/soc/sof/imx/imx8m.c
@@ -23,6 +23,21 @@
 #define MBOX_OFFSET	0x800000
 #define MBOX_SIZE	0x1000
 
+struct clk_bulk_data imx8m_dsp_clks[] = {
+	{ .id = "ipg" },
+	{ .id = "ocram" },
+	{ .id = "core" },
+};
+
+struct clk_bulk_data imx8m_dai_clks[] = {
+	{ .id = "sai3_bus" },
+	{ .id = "sai3_mclk0" },
+	{ .id = "sai3_mclk1" },
+	{ .id = "sai3_mclk2" },
+	{ .id = "sai3_mclk3" },
+	{ .id = "sdma3_root" },
+};
+
 struct imx8m_priv {
 	struct device *dev;
 	struct snd_sof_dev *sdev;
@@ -30,6 +45,8 @@ struct imx8m_priv {
 	/* DSP IPC handler */
 	struct imx_dsp_ipc *dsp_ipc;
 	struct platform_device *ipc_dev;
+
+	struct imx_clocks *clks;
 };
 
 static void imx8m_get_reply(struct snd_sof_dev *sdev)
@@ -143,6 +160,10 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->clks = devm_kzalloc(&pdev->dev, sizeof(*priv->clks), GFP_KERNEL);
+	if (!priv->clks)
+		return -ENOMEM;
+
 	sdev->num_cores = 1;
 	sdev->pdata->hw_pdata = priv;
 	priv->dev = sdev->dev;
@@ -211,6 +232,18 @@ static int imx8m_probe(struct snd_sof_dev *sdev)
 	/* set default mailbox offset for FW ready message */
 	sdev->dsp_box.offset = MBOX_OFFSET;
 
+	/* init clocks info */
+	priv->clks->dsp_clks = imx8m_dsp_clks;
+	priv->clks->num_dsp_clks = ARRAY_SIZE(imx8m_dsp_clks);
+	priv->clks->dai_clks = imx8m_dai_clks;
+	priv->clks->num_dai_clks = ARRAY_SIZE(imx8m_dai_clks);
+
+	ret = imx8_parse_clocks(sdev, priv->clks);
+	if (ret < 0)
+		goto exit_pdev_unregister;
+
+	imx8_enable_clocks(sdev, priv->clks);
+
 	return 0;
 
 exit_pdev_unregister:
@@ -222,6 +255,7 @@ static int imx8m_remove(struct snd_sof_dev *sdev)
 {
 	struct imx8m_priv *priv = sdev->pdata->hw_pdata;
 
+	imx8_disable_clocks(sdev, priv->clks);
 	platform_device_unregister(priv->ipc_dev);
 
 	return 0;
-- 
2.27.0

