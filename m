Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC2432EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhJSHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:12:50 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:33856
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234345AbhJSHMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fz+5o1YbAfvCOmDiVQa7oiARgU3KA3XuusRAa8jQmYkpcRF3jsLg8veP7XkdQiKUCl3MpcAU5eKxvyYsuBD1qVzaDaLGlQgJT1WJQ6eua4tY/cCCK6weo+NGGvfgDjjYHrj+YNWQPVK6QGeldqEHagdDrxwJZwbqlGsYC6uDLcsnj5BsQM7GYQAYJxRA6XjZC/75F1XceuSnFxgCqaUKbrAqmaB67FlyV96IQQAkttRKE94LkCtDT7GxyaOMhkdocZiiHBzvnXgL8OqDdO8WxQtc8XUlGQzbfyzy/oP38/uR2ssUWb7sWqbBA1oGtTp4pgDL9WhXhez8pgAkYtkUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFU8aavBakBUntI5YQMP6Lz8EwrSf7WqzwbPBpCDsw0=;
 b=Qt6fpNhP8+5Ppb+5/K2wRkrbAU0NayXB5dpXGzvN/dtnk5z08YJLmoPKP/xRub9iPPf4e9Q9b3tcrurXd+2sGvIEVDGJviWT3xvz5rvHrOKC4S6CRGbFrTxBE4DYeuzVxbLTUfTiDo2qAsjAqMFIFLNSeW041EaF7TeTFLtp8AXQFDkf7EVv2Fli0cHtq9h9/9VARfO3FXRBCy9L2EsjayWxDQxA+ESQcSKxBWsZJ01e0Hx1UBiF51aL5c6S5+Z3aOGJtYvUAFM3Dt3RpE6m/QNuPRgHIREi9QQDtdpQHqklwYP9TpkWOTrg6WHePLgH8GbKd1nq2cgi53JA9LZ+YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFU8aavBakBUntI5YQMP6Lz8EwrSf7WqzwbPBpCDsw0=;
 b=eFw+d/fUas5xV42nwX6zYhtFtOycb5d8c5kdFRgxla4RnL1sig9l0hTusVw13u20GyGRpm14JjVQYuKsS4oDhI/OaOlSn58k3PD9eiRgZyklKy8j1rFxyUQe+IJ1cpSFzy4/54ljYGYRWmskkQ1+BlhScaJD7nbo+asonHsQfjc=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 CY4PR12MB1333.namprd12.prod.outlook.com (2603:10b6:903:41::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Tue, 19 Oct 2021 07:10:32 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::39) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 19 Oct 2021 07:10:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 07:10:32 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 02:10:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 00:10:31 -0700
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Tue, 19 Oct 2021 02:10:27 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/8] ASoC: amd: acp: Add I2S support on Renoir platform
Date:   Tue, 19 Oct 2021 12:39:32 +0530
Message-ID: <20211019070938.5076-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
References: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b47934b-f618-416b-001a-08d992cf8a30
X-MS-TrafficTypeDiagnostic: CY4PR12MB1333:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13338FD0A673F8D4C2A217AA82BD9@CY4PR12MB1333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DWnObsmJ1U2QoIEAd+oPlY+RP0sC+MqsT8I+oLCcsJ3UYYTzTzNx9BEcjZDoDKXDcDDEd3UgYtCPcCufiMWFER5FIpslUYewEM3Q/rr4pCXvBY0GOkqteoAcrJdrByyQbqJGLMS81rFdRcZA+7khjgG2nQSZbcR901WbkLRwkymjCtXtCMbdT0YHVl4XlbpVb2ZhtIHtfUjMe8Mnesws2ZZPwfRV3wQARkbezxERs9Oc5hj/2r2VUHg+la3pAvlfEvVwQHlpA6S+lyA+wPWwerR1M/2iW4YqyaZsiiLL547VCkuDy+Oxr+vyx3l9N1NPAdzPs/j/gY7u4tThgAR0Vgu6WFuyYyv+i8gzjZjFiYYf5R5tPQqY09velwMZe/WivyCoy8irqZBDM38O3w6/Xq1YQr/A2BbBrFyq5B8nfyD+NAkcwMX6eRpGHyEfxLj6kgQtCuqTWc1sasMr+TdRmHM88t2KyO7nCXKS5KF68BF5D4PKVjJN2nxnNTOK3WkRxLZ7Zeqm+m/JshcnONjMVLIrTMhC8ncTCcM3oFZTAPvg4YkUfyy1UedcXIsRNyadr6qCrjxdKU4FiVqiJRdcNC1MccXbSkX9xuBrDwfWT9Nc4g6cr78ACZIsjYwEsUFDoTKVU15IwBr3WIzCxIQr8s5lY28QvrfV2mGUVMqzPbw7wUzlhOmBXrQ5yNZ46Tmj8+x47h0D64Tv4PE8cbPbktqvTGnKxH4CBykPbwv4hyQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(110136005)(86362001)(70586007)(2616005)(83380400001)(70206006)(4326008)(36756003)(426003)(54906003)(2906002)(36860700001)(508600001)(6666004)(81166007)(8676002)(336012)(1076003)(82310400003)(7696005)(8936002)(26005)(47076005)(5660300002)(186003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 07:10:32.3133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b47934b-f618-416b-001a-08d992cf8a30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1333
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2S dai driver for Renoir platform and register with common
acp framework to support non dsp I2S use case on Renoir.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig      |   8 ++
 sound/soc/amd/acp/Makefile     |   5 ++
 sound/soc/amd/acp/acp-renoir.c | 141 +++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 sound/soc/amd/acp/acp-renoir.c

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 5d782d1fc654..e01822ff0694 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -17,3 +17,11 @@ config SND_SOC_AMD_ACP_I2S
 
 config SND_SOC_AMD_ACP_PCM
 	tristate
+
+config SND_AMD_ASOC_RENOIR
+	tristate "AMD ACP ASOC Renoir Support"
+	select SND_SOC_AMD_ACP_PCM
+	select SND_SOC_AMD_ACP_I2S
+	depends on X86 && PCI
+	help
+	  This option enables Renoir I2S support on AMD platform.
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index b2e12659d97b..42bff3515f24 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -8,5 +8,10 @@
 snd-acp-pcm-objs     := acp-platform.o
 snd-acp-i2s-objs     := acp-i2s.o
 
+#platform specific driver
+snd-acp-renoir-objs     := acp-renoir.o
+
 obj-$(CONFIG_SND_SOC_AMD_ACP_PCM) += snd-acp-pcm.o
 obj-$(CONFIG_SND_SOC_AMD_ACP_I2S) += snd-acp-i2s.o
+
+obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
new file mode 100644
index 000000000000..c7fbf71e4669
--- /dev/null
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license. When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2021 Advanced Micro Devices, Inc.
+//
+// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
+//
+
+/*
+ * Hardware interface for Renoir ACP block
+ */
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
+#include "amd.h"
+
+#define DRV_NAME "acp_asoc_renoir"
+
+static struct snd_soc_dai_driver acp_renoir_dai[] = {
+{
+	.name = "acp-i2s-sp",
+	.id = I2S_SP_INSTANCE,
+	.playback = {
+		.stream_name = "I2S SP Playback",
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+	.capture = {
+		.stream_name = "I2S SP Capture",
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &asoc_acp_cpu_dai_ops,
+	.probe = &asoc_acp_i2s_probe,
+},
+{
+	.name = "acp-i2s-bt",
+	.id = I2S_BT_INSTANCE,
+	.playback = {
+		.stream_name = "I2S BT Playback",
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 8,
+		.rate_min = 8000,
+		.rate_max = 96000,
+	},
+	.capture = {
+		.stream_name = "I2S BT Capture",
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S8 |
+			   SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 8000,
+		.rate_max = 48000,
+	},
+	.ops = &asoc_acp_cpu_dai_ops,
+	.probe = &asoc_acp_i2s_probe,
+},
+};
+
+static int renoir_audio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acp_dev_data *adata;
+	struct resource *res;
+
+	adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "acp_mem");
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENODEV;
+	}
+
+	adata->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!adata->acp_base)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "acp_dai_irq");
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+		return -ENODEV;
+	}
+
+	adata->i2s_irq = res->start;
+	adata->dev = dev;
+	adata->dai_driver = acp_renoir_dai;
+	adata->num_dai = ARRAY_SIZE(acp_renoir_dai);
+
+	dev_set_drvdata(dev, adata);
+	acp_platform_register(dev);
+
+	return 0;
+}
+
+static int renoir_audio_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	acp_platform_unregister(dev);
+	return 0;
+}
+
+static struct platform_driver renoir_driver = {
+	.probe = renoir_audio_probe,
+	.remove = renoir_audio_remove,
+	.driver = {
+		.name = "acp_asoc_renoir",
+	},
+};
+
+module_platform_driver(renoir_driver);
+
+MODULE_DESCRIPTION("AMD ACP Renoir Driver");
+MODULE_IMPORT_NS(SND_SOC_ACP_COMMON);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1

