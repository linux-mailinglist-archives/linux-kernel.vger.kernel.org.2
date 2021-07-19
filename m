Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112313CECCC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381251AbhGSRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:37:49 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:34740
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348873AbhGSP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyUeut1V4n/AyCx+1KpY+GQ0bO0YFZqAQ+T/naNuPn3o9iJaqvNsXawXaxx84IIZsSv/57pOtD2ee7o9OkVoZOoeqmJ9ueSRmRoHLq7eVpb92pHviQlCWqgeXqdtJH9QA6KMP8xl9HGk4QoUUMF3oI8maoTqK//Plg3yxx9wBnzU9Slc04YU/kTKepKB9mRh5XP59jVmmfYPGMVEhU1dgbEd5WzuGs16/y9/Iviw2Glg9eKBduHUQVQmTJK2G+mM6B0u5nnys4lzFbgfa/vYTfGyw7KftLdi2arOoe85i9fq/iC5vLtt7Au0dHzBDc1s+5NzEgg1mBHewix1zHsocg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZObopLkWupT74c0200RM9GP6BMvRZmQxozZF7X8PMM=;
 b=hRwGhRDhNpzO51BtJrxjxuYmJ/a5qvEAXjQMkYeEPfaQPvtan6ZsFP0UkABCwP04u40+VpIk1IYQc8tn5KH9772grhfH8Bfe+uWz81pYnmdY3Qbo4S23PFUnuLwlWrILPYOAWACRWu3fU9397McHQ88SzhKKec6rSmPKgLB2GzZmBmsjlW8kwiSo2LBa620fudCJ7/5AUIbQ2AciKbZSnNC4tYR3qxOCie1YWsKtzQ0JiaBlOm0DnPNWjNKO3kPws0vWO2tjCj3j4gJrF4jNvPm+uCkoDfD3xz3zNhi83LzCCSItodfrUt2vDDwz4ZWaT80qPwliK9FO6R6KMCKqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZObopLkWupT74c0200RM9GP6BMvRZmQxozZF7X8PMM=;
 b=4fxP+waX530hGpCNn3RhUYjgDwjlLGYpGKt1YMtzYIZz+aRZ8lRiu7Q7g7kNnnJcnl3kNgfXybnW//bPqOTn4mURuaqGF9aJWb7L1kIDo7TyyprjXgK4OkQcLffAPw154xelj4w6xpPy4SjfGCIgLrk8qp1iDRlo0hPgK+3Of6M=
Received: from DM6PR18CA0013.namprd18.prod.outlook.com (2603:10b6:5:15b::26)
 by DM6PR12MB2683.namprd12.prod.outlook.com (2603:10b6:5:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 16:36:25 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::ec) by DM6PR18CA0013.outlook.office365.com
 (2603:10b6:5:15b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 16:36:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 16:36:24 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:36:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 09:36:23 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 11:36:15 -0500
From:   Vijendar Mukunda <vijendar.mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 08/12] ASoC: amd: add vangogh i2s controller driver
Date:   Mon, 19 Jul 2021 22:21:36 +0530
Message-ID: <20210719165140.16143-9-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719165140.16143-1-vijendar.mukunda@amd.com>
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2fe4a41-d0b4-4511-3e78-08d94ad35978
X-MS-TrafficTypeDiagnostic: DM6PR12MB2683:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26839602C7ED3A6796F40EEA97E19@DM6PR12MB2683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBHTDnie1E03TUViElMs0u/E4neRoJbQ2Gvcon7hnqnOeL0Hbeewd3vJaYKORpUlR/jDb9z+6z0Ykdj6XaQLcdeeRfyiyw6VSHCMuz0rIdIfwQalEkRtLQkwNevmM7TLQXzKh8hXOaeCeUtCTJsjdb0Bl3DKcZWWABi2Z6b4wl2kqwsQsC9PAn/FW6hmz+rLjKPKm7+vs4MwNKs0kzzHuZRQhRqVzyEaNUqoGnARrbNvZOoZDiXMPSZSdC5VZ9vZUMeFhh0lVjHEO9kAyQVQJHNcW2PzyUJOc2KJDx/j/c3djohZajFsMxBAJYzXHK7rfujlNrSaWkF5rbXSNSjc9zyD0ZWpNB/a+N8miAm7qz2j5M7Q1vlAKMkob9/2fPGVSlDcSX/1BJbhf/xk5+MhNCPtJ7ZYoKJXNUwsAWvoDfWjSh5q3VFakJO7p2eWdWQKJVsSXnJWvgzioi5P9TB+azauEP6NbmyKt7XOy2ZkxhWK259ZN6TcCzWAqZylzTzQptSVaDvUPwrCzSHw4fFI060CSoFmhOTEVMV9ngNcG7BPKyH1rPzBa5vADsCl8kgyomdQvj5tT/jD6chj9Fh38hjzS+mdgJgymW2iBTchlgZQMQ8Jb/ief2jJ5Z56JiZlXinKp6BgxBqTUs8Qkp2H72KcmHvCbPinfUC2sMd77DMchrxauzbaSg/nuKg8Fkljs8ZBxRs1lhSYmcH6Dp1viWEJH2IhYFU+nrSJHdZbWtQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(426003)(356005)(2616005)(7696005)(86362001)(82740400003)(8936002)(336012)(1076003)(36756003)(36860700001)(110136005)(54906003)(81166007)(82310400003)(316002)(478600001)(44832011)(4326008)(2906002)(186003)(6666004)(70206006)(70586007)(47076005)(26005)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:36:24.8153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fe4a41-d0b4-4511-3e78-08d94ad35978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2683
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vangogh I2S controller driver to support two I2S controller
instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-i2s.c | 90 +++++++++++++++++++++++++++++++
 sound/soc/amd/vangogh/acp5x.h     |  4 ++
 2 files changed, 94 insertions(+)
 create mode 100644 sound/soc/amd/vangogh/acp5x-i2s.c

diff --git a/sound/soc/amd/vangogh/acp5x-i2s.c b/sound/soc/amd/vangogh/acp5x-i2s.c
new file mode 100644
index 000000000000..93fd0372df29
--- /dev/null
+++ b/sound/soc/amd/vangogh/acp5x-i2s.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ALSA SoC PCM Driver
+//
+// Copyright (C) 2021 Advanced Micro Devices, Inc. All rights reserved.
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <linux/dma-mapping.h>
+
+#include "acp5x.h"
+
+#define DRV_NAME "acp5x_i2s_playcap"
+
+static const struct snd_soc_component_driver acp5x_dai_component = {
+	.name = "acp5x-i2s",
+};
+
+static struct snd_soc_dai_driver acp5x_i2s_dai = {
+	.playback = {
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+	.capture = {
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+};
+
+static int acp5x_dai_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct i2s_dev_data *adata;
+	int ret;
+
+	adata = devm_kzalloc(&pdev->dev, sizeof(struct i2s_dev_data),
+			     GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENOMEM;
+	}
+	adata->acp5x_base = devm_ioremap(&pdev->dev, res->start,
+					 resource_size(res));
+	if (IS_ERR(adata->acp5x_base))
+		return PTR_ERR(adata->acp5x_base);
+
+	adata->master_mode = I2S_MASTER_MODE_ENABLE;
+	dev_set_drvdata(&pdev->dev, adata);
+	ret = devm_snd_soc_register_component(&pdev->dev,
+					      &acp5x_dai_component,
+					      &acp5x_i2s_dai, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static struct platform_driver acp5x_dai_driver = {
+	.probe = acp5x_dai_probe,
+	.driver = {
+		.name = "acp5x_i2s_playcap",
+	},
+};
+
+module_platform_driver(acp5x_dai_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD ACP5.x CPU DAI Driver");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index b7bd5cb1906d..fbd5cdf44cb8 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -70,7 +70,11 @@
 #define DMA_SIZE 0x40
 #define FRM_LEN 0x100
 
+#define I2S_MASTER_MODE_ENABLE 0x01
+#define I2S_MASTER_MODE_DISABLE 0x00
+
 struct i2s_dev_data {
+	bool master_mode;
 	unsigned int i2s_irq;
 	void __iomem *acp5x_base;
 	struct snd_pcm_substream *play_stream;
-- 
2.17.1

