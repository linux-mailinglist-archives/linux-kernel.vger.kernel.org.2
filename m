Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC006454404
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbhKQJpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:45:16 -0500
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:57665
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235408AbhKQJmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:42:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDL06reMvwPmpLCc7ttZMjddOJhP0fErWugCtlid9GXQuxBAu7OKShAmsP50JeOr2yzevWP+isOVuKzyQHXU7hCikrXQnnI1fY7CKPB9sAwyzOw7LXFPOGS+cKJLoJsN+HIPIQLrscsMLVNJhbktvz2dJQDaaEW56k3JVXUiY2PFcyssE1/8q1oUWiQTijegfZLn0TyNBBxSKr26jnYw5a4r83IfP2gf0sz6ln4qnSH0E6Yj7htEwqDaZXIZ3m5MBKloFHKQMW3ykWBrX2a9pCVqk8PrqUz5bHqDU2bCyMjHm2+AEup9hJqVQ9LV00fGvlvYcICy0UZ+eVN1dHAZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCMUzfA8hdjBrmOIn6d07q9GBomDcmPvFrEtSFmZKi8=;
 b=IOOEBpIv3rlawz5Ahp/epHPPEJQG5z7/ku3tfJl3OqvCLKgCLpV+CtZHaRfjJ8Lvj7keDzuGtGQMYwaoC/F7Fw9+A9iqWJd4lZ3bUIylLIfh4ZfdrXRIi1P2xpAYF1Fy4zwKCxYK2H3baFOh6fROgcG1cUrZYaSJ+cAfEri5eXpI3B+jE9g4vJ0hy+XOg5WzbEP3a0GmKnvpUEii0yFQskUM4BdiQCknhsOMuOLDZ1PlEMdVa/BqNIfKpeLtZW2WnDlhKQlvWXodimW0OjyJht99+EL5WwWOQjYTCcetXzVaBw9ivLiEKxJ04hXuV5hfdmXsTZms2CPzYyv5hopkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCMUzfA8hdjBrmOIn6d07q9GBomDcmPvFrEtSFmZKi8=;
 b=ZIUr+axod62nb9Vj3/GT8PBdBZ27vCqgvmP4/vlzCUkcN5RczFeGWXiEAkWa9vdJ3nCjsFK70TragNCOF5k747lIhAXdY538jGwkrTt9GwdhjY5In2fBirm5qZS4i9EQBDZZPmhQt89CFb+Z8c8kjYIsQ2QIM8YOnJJECGez92g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB3039.eurprd04.prod.outlook.com (2603:10a6:802:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Wed, 17 Nov
 2021 09:38:44 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::85af:f8be:aa99:ba5f%3]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 09:38:43 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com, daniel.baluta@gmail.com,
        AjitKumar.Pandey@amd.com, Balakishore.pati@amd.com,
        vsreddy@amd.com, Julian.Schroeder@amd.com,
        vishnuvardhanrao.ravulapati@amd.com, linux-kernel@vger.kernel.org,
        yc.hung@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 20/21] ASoC: SOF: mediatek: Add mt8195 dsp clock support
Date:   Wed, 17 Nov 2021 11:37:33 +0200
Message-Id: <20211117093734.17407-21-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR03CA0060.eurprd03.prod.outlook.com
 (2603:10a6:207:5::18) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2a02:2f08:5706:b700:22bb:b216:ffff:73e1) by AM3PR03CA0060.eurprd03.prod.outlook.com (2603:10a6:207:5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19 via Frontend Transport; Wed, 17 Nov 2021 09:38:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af85c6e4-8dd3-4a59-47fc-08d9a9ae0b4d
X-MS-TrafficTypeDiagnostic: VI1PR04MB3039:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3039CC8EAE4A9352EF293455B89A9@VI1PR04MB3039.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vf9cR5bvxy4YqGq7FLz7fFE8IKnVKP0oixBHSrT1FcnvPAUB3hA0HkScWeYwDyWuYdFsaDKJZqXPyemSmUXP3Q9FROQb4O5FNC71V9No5PhSwM5+SfI4DZOyLOK4D3ju8wB91Nd55wK34vmDe/ZsIedr9sixWMjShhWXlGH5ZH4en6ppwsK/UGj0kbTuJUSbGNrGjUim0sH5tcV8LbE8YCNrQD3S5P9GI5dUJ4WkCnWw5ujjJyPtbDjrUtkYqV52wRZpXKeAypk52/a+kzAJlmfRL7VYk/nEoPhDFJD7hO1NfhWhhjOXyFdCBzmm28CjBanIQhtqA0Y3xnFuv1Ul7S3MxCsKSfuUXb8H21Bz7iNAH/0gzMlpiNLYRLikstwi5aEmfgWqYLZly8jfgdd5TNh2cQ3bR6+tZOsdrpzLa8/QWmd17IJcEQyOB2siUG9Oy3/3O9HTzGOjiZWuSiy8KFfqABL7BShASKt2S/4dbAO2zd5y0/qEdHZLzFjkgVEfDOMomujOD+7vgSjN82SBrMkHhcPjWo9R67AWq54HzbmaZRvIWAwCOuXUhBvSyhxy+/+gnehWIleCYI9w8fEDvSTpK3CuCqsQgpEeN+sQ4FlplyEvHPdbW770BWxrBgVuNcjeJ2dnj0xDx1S2WF422A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(186003)(6666004)(44832011)(52116002)(6486002)(5660300002)(66556008)(6512007)(6506007)(4326008)(7416002)(2616005)(8936002)(8676002)(1076003)(2906002)(66946007)(83380400001)(508600001)(86362001)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HkQCWTb1TPo7sV0UoG6PFOWuDW/ez0niabgu3fTExD5GVnGdrAavKr6fnAzm?=
 =?us-ascii?Q?esziV6eqziFgaxXMYBHR+1ffsFHBByGel+r2jCbIlDVlBk/d2fjRN+1qhbH3?=
 =?us-ascii?Q?lNVz4rkLACdxZsqjos5QkZwSHjiZ3VsRADJkUgBpSt4Ep7jQ5yy0cedf1Lzg?=
 =?us-ascii?Q?jKfj3xaVRu5zPRycP6GLuC1qS4KdOBIGOp5+bm7/NdlT7WLX6IWau6eWZLzN?=
 =?us-ascii?Q?KNoauoILdyqK7NzdcdEE2QFsT1TG6yXwJ66DiPlvsLUTkYnMUCIlD9hkMHzN?=
 =?us-ascii?Q?mDPRjVXx3KTEOLjF6s1oZLqYmmvWb4e5rgdTsjqihFONB7hpG2M8HLc/xdCY?=
 =?us-ascii?Q?iSyfck3Rwrw54/zMvnjX2Q0VeoZd2D2ont0mQBwWUnv1EqDnd56QKZQjk6U+?=
 =?us-ascii?Q?dFzV2gdxO5RwSRP2ks9q/JjAqqMKvidOSCK++Y7ZwNQUMO4P2X5eBjW4caN2?=
 =?us-ascii?Q?rbJHcTFgCJAO82oAxREEvDfB6y8KjsKGQ/vyUXGfzvPV+TdyAfkSDdC3Dp4d?=
 =?us-ascii?Q?2un7ToB13biwS9pKA0ZTjrbMtQirFKcPJ9ZEdCPx8FuS1SC2W8FuoHZIfR5p?=
 =?us-ascii?Q?27+/GdJkZDsVrmMfise0oCBCcOJ8ojvPcOhrzaOoEe4xyuXzsqRCBehLpseD?=
 =?us-ascii?Q?9wR4tX9Jt3NQ58pf8bbCUvRVm91ezXnAnuYYq80RHJvQ/Ff7pX+wwpGn7ZzL?=
 =?us-ascii?Q?B9oOgYjxy/85biujw9zZsxzVKZCjdkXdrB33Ly48HQjlqqsSAlWK041zZD5I?=
 =?us-ascii?Q?ype5EJyCSC/OuzCyfcVGcXxN+m6EgO1A0dreYCU8QMV1wzxKenoSUWVaxZu/?=
 =?us-ascii?Q?UzA136sj+pLQcmlTR0EjbSv+ywiBZkFs25HEhzzP5atMuY9RsfKfoP8Fdyum?=
 =?us-ascii?Q?GzEgJZzw7n8gsTb87C6+BEpvQgcqy3fSEElDK4n24IGH9zR2GR1f7CvzzQi/?=
 =?us-ascii?Q?PpGTCWf99AYsr9j/GUyUsr0qbjpOet4nhSC0PURDCd2yZa0FWWQZ9JZunT50?=
 =?us-ascii?Q?Ee/xhjE/WJm266dms3Z8XjV5hs5uqkC74y7IEUXBqFQTMA+7Qi4AJEF+rwKP?=
 =?us-ascii?Q?BXye3opCLVVkdIgXsNJhj9HgSEaSLWI8qnHzuGGKHqi7MxFgoyc8CURPEIGy?=
 =?us-ascii?Q?Ep2Z47yQoM7WA3zq+8TISxkEvG8dq2B603A453Gp1e+vFfpYXevP2rJF+7mV?=
 =?us-ascii?Q?37/4V4jCYwGGiVKQa2QO+EoJde7d/loWjftaDWU1agC1nYJ+s5mF/Jl3G6bP?=
 =?us-ascii?Q?WWuSDJZGoaaxyrThbsr7s9B7ol8sM9b24k0al5cUTdwpPPElxOBuw9CSiuug?=
 =?us-ascii?Q?RQiBmEHvSrcI8Cjwztka9ic62xpcHk+n9ZKHlziT68liAX800VgIkv5fGFvx?=
 =?us-ascii?Q?PqZvqNH3PSPUJa3NCGFScv83fkOMRMJHh0K5B9ALcwuJTDnLEQYT9KLSGvkw?=
 =?us-ascii?Q?0EK9OYghju/bstc5s2kY17jCRIabKobW5HAXhgxcfTV85SroCSIP9YZk2dl8?=
 =?us-ascii?Q?7pGVHp8BDejCZn0VQNDHwPB7x2HiW5DUfW+/nSL2gjwRGOJ+60c5ad0gcFX+?=
 =?us-ascii?Q?cexd655DnYb9h13B7d2Amoghz5mvc13U7AkSC34wif+it39o2RojXkXTeYdG?=
 =?us-ascii?Q?4mubv1dqmxAtdyOfq7Wmrg2+U/pbHJjd6dVZj2+O9u2Qip5ZjoS7AMLwhlYU?=
 =?us-ascii?Q?qRfgthERvDxTE4pZ7YgEe15X/Rg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af85c6e4-8dd3-4a59-47fc-08d9a9ae0b4d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 09:38:43.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYj1lP1wOV3QvpC0rDMhZVf5KRZdCAywRRB5JmvqvqLQ9bukkSuIgjaWOIo4grYHMQPzYT6AK1WMBXCdZM0jPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YC Hung <yc.hung@mediatek.com>

Add adsp clock on/off support on mt8195 platform.

Signed-off-by: YC Hung <yc.hung@mediatek.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/mediatek/adsp_helper.h       |   2 +-
 sound/soc/sof/mediatek/mt8195/Makefile     |   2 +-
 sound/soc/sof/mediatek/mt8195/mt8195-clk.c | 158 +++++++++++++++++++++
 sound/soc/sof/mediatek/mt8195/mt8195-clk.h |  28 ++++
 sound/soc/sof/mediatek/mt8195/mt8195.c     |  22 ++-
 5 files changed, 208 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8195/mt8195-clk.h

diff --git a/sound/soc/sof/mediatek/adsp_helper.h b/sound/soc/sof/mediatek/adsp_helper.h
index 346953dd22db..6734e2c0c6b1 100644
--- a/sound/soc/sof/mediatek/adsp_helper.h
+++ b/sound/soc/sof/mediatek/adsp_helper.h
@@ -39,7 +39,7 @@ struct adsp_priv {
 	struct mbox_controller *adsp_mbox;
 
 	struct mtk_adsp_chip_info *adsp;
-
+	struct clk **clk;
 	u32 (*ap2adsp_addr)(u32 addr, void *data);
 	u32 (*adsp2ap_addr)(u32 addr, void *data);
 
diff --git a/sound/soc/sof/mediatek/mt8195/Makefile b/sound/soc/sof/mediatek/mt8195/Makefile
index 66cdc0e7bf3c..afc4f21fccc5 100644
--- a/sound/soc/sof/mediatek/mt8195/Makefile
+++ b/sound/soc/sof/mediatek/mt8195/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
-snd-sof-mt8195-objs := mt8195.o mt8195-loader.o
+snd-sof-mt8195-objs := mt8195.o mt8195-clk.o mt8195-loader.o
 obj-$(CONFIG_SND_SOC_SOF_MT8195) += snd-sof-mt8195.o
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-clk.c b/sound/soc/sof/mediatek/mt8195/mt8195-clk.c
new file mode 100644
index 000000000000..6bcb4b9b00fb
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// Copyright(c) 2021 Mediatek Corporation. All rights reserved.
+//
+// Author: YC Hung <yc.hung@mediatek.com>
+//
+// Hardware interface for mt8195 DSP clock
+
+#include <linux/clk.h>
+#include <linux/pm_runtime.h>
+#include <linux/io.h>
+#include "mt8195.h"
+#include "mt8195-clk.h"
+#include "../adsp_helper.h"
+#include "../../sof-audio.h"
+
+static const char *adsp_clks[ADSP_CLK_MAX] = {
+	[CLK_TOP_ADSP] = "adsp_sel",
+	[CLK_TOP_CLK26M] = "clk26m_ck",
+	[CLK_TOP_AUDIO_LOCAL_BUS] = "audio_local_bus",
+	[CLK_TOP_MAINPLL_D7_D2] = "mainpll_d7_d2",
+	[CLK_SCP_ADSP_AUDIODSP] = "scp_adsp_audiodsp",
+	[CLK_TOP_AUDIO_H] = "audio_h",
+};
+
+int mt8195_adsp_init_clock(struct snd_sof_dev *sdev)
+{
+	struct device *dev = sdev->dev;
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	int i;
+
+	priv->clk = devm_kcalloc(dev, ADSP_CLK_MAX, sizeof(*priv->clk), GFP_KERNEL);
+
+	if (!priv->clk)
+		return -ENOMEM;
+
+	for (i = 0; i < ADSP_CLK_MAX; i++) {
+		priv->clk[i] = devm_clk_get(dev, adsp_clks[i]);
+		if (IS_ERR(priv->clk[i]))
+			return PTR_ERR(priv->clk[i]);
+	}
+
+	return 0;
+}
+
+static int adsp_enable_all_clock(struct snd_sof_dev *sdev)
+{
+	struct device *dev = sdev->dev;
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(mainpll_d7_d2) fail %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_ADSP]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(adsp_sel) fail %d\n",
+			__func__, ret);
+		goto disable_mainpll_d7_d2_clk;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(audio_local_bus) fail %d\n",
+			__func__, ret);
+		goto disable_dsp_sel_clk;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_SCP_ADSP_AUDIODSP]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(scp_adsp_audiodsp) fail %d\n",
+			__func__, ret);
+		goto disable_audio_local_bus_clk;
+	}
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_AUDIO_H]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(audio_h) fail %d\n",
+			__func__, ret);
+		goto disable_scp_adsp_audiodsp_clk;
+	}
+
+	return 0;
+
+disable_scp_adsp_audiodsp_clk:
+	clk_disable_unprepare(priv->clk[CLK_SCP_ADSP_AUDIODSP]);
+disable_audio_local_bus_clk:
+	clk_disable_unprepare(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS]);
+disable_dsp_sel_clk:
+	clk_disable_unprepare(priv->clk[CLK_TOP_ADSP]);
+disable_mainpll_d7_d2_clk:
+	clk_disable_unprepare(priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+
+	return ret;
+}
+
+static void adsp_disable_all_clock(struct snd_sof_dev *sdev)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	clk_disable_unprepare(priv->clk[CLK_TOP_AUDIO_H]);
+	clk_disable_unprepare(priv->clk[CLK_SCP_ADSP_AUDIODSP]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_ADSP]);
+	clk_disable_unprepare(priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+}
+
+static int adsp_default_clk_init(struct snd_sof_dev *sdev, bool enable)
+{
+	struct device *dev = sdev->dev;
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	int ret;
+
+	dev_dbg(dev, "%s: %s\n", __func__, enable ? "on" : "off");
+
+	if (enable) {
+		ret = clk_set_parent(priv->clk[CLK_TOP_ADSP],
+				     priv->clk[CLK_TOP_CLK26M]);
+		if (ret) {
+			dev_err(dev, "failed to set dsp_sel to clk26m: %d\n", ret);
+			return ret;
+		}
+
+		ret = clk_set_parent(priv->clk[CLK_TOP_AUDIO_LOCAL_BUS],
+				     priv->clk[CLK_TOP_MAINPLL_D7_D2]);
+		if (ret) {
+			dev_err(dev, "set audio_local_bus failed %d\n", ret);
+			return ret;
+		}
+
+		ret = adsp_enable_all_clock(sdev);
+		if (ret) {
+			dev_err(dev, "failed to adsp_enable_clock: %d\n", ret);
+			return ret;
+		}
+	} else {
+		adsp_disable_all_clock(sdev);
+	}
+
+	return 0;
+}
+
+int adsp_clock_on(struct snd_sof_dev *sdev)
+{
+	/* Open ADSP clock */
+	return adsp_default_clk_init(sdev, 1);
+}
+
+int adsp_clock_off(struct snd_sof_dev *sdev)
+{
+	/* Close ADSP clock */
+	return adsp_default_clk_init(sdev, 0);
+}
+
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195-clk.h b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
new file mode 100644
index 000000000000..9cc0573d5cd2
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8195/mt8195-clk.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2021 MediaTek Corporation. All rights reserved.
+ *
+ *  Header file for the mt8195 DSP clock  definition
+ */
+
+#ifndef __MT8195_CLK_H
+#define __MT8195_CLK_H
+
+struct snd_sof_dev;
+
+/*DSP clock*/
+enum adsp_clk_id {
+	CLK_TOP_ADSP,
+	CLK_TOP_CLK26M,
+	CLK_TOP_AUDIO_LOCAL_BUS,
+	CLK_TOP_MAINPLL_D7_D2,
+	CLK_SCP_ADSP_AUDIODSP,
+	CLK_TOP_AUDIO_H,
+	ADSP_CLK_MAX
+};
+
+int mt8195_adsp_init_clock(struct snd_sof_dev *sdev);
+int adsp_clock_on(struct snd_sof_dev *sdev);
+int adsp_clock_off(struct snd_sof_dev *sdev);
+#endif
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 99075598a35a..5bfae9379ac8 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -25,6 +25,7 @@
 #include "../adsp_helper.h"
 #include "../mediatek-ops.h"
 #include "mt8195.h"
+#include "mt8195-clk.h"
 
 static int platform_parse_resource(struct platform_device *pdev, void *data)
 {
@@ -231,10 +232,22 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 	if (ret)
 		return ret;
 
+	ret = mt8195_adsp_init_clock(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "mt8195_adsp_init_clock failed\n");
+		return -EINVAL;
+	}
+
+	ret = adsp_clock_on(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "adsp_clock_on fail!\n");
+		return -EINVAL;
+	}
+
 	ret = adsp_sram_power_on(sdev->dev, true);
 	if (ret) {
 		dev_err(sdev->dev, "adsp_sram_power_on fail!\n");
-		return ret;
+		goto exit_clk_disable;
 	}
 
 	ret = adsp_memory_remap_init(&pdev->dev, priv->adsp);
@@ -282,6 +295,8 @@ static int mt8195_dsp_probe(struct snd_sof_dev *sdev)
 
 err_adsp_sram_power_off:
 	adsp_sram_power_on(&pdev->dev, false);
+exit_clk_disable:
+	adsp_clock_off(sdev);
 
 	return ret;
 }
@@ -290,7 +305,10 @@ static int mt8195_dsp_remove(struct snd_sof_dev *sdev)
 {
 	struct platform_device *pdev = container_of(sdev->dev, struct platform_device, dev);
 
-	return adsp_sram_power_on(&pdev->dev, false);
+	adsp_sram_power_on(&pdev->dev, false);
+	adsp_clock_off(sdev);
+
+	return 0;
 }
 
 /* on mt8195 there is 1 to 1 match between type and BAR idx */
-- 
2.27.0

