Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6603CFF48
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhGTPo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:44:56 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:26593
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237317AbhGTPkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:40:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P940TQDOjBIxtQ9r0JHW6bRpobN8I1abGo7+K3Rk4odqBNfE5r+FGNlzHU69SZGnXbqggakt6G8wh5AqN5OETYjVAbXLs8OzgxJYGVPmPILvkiqHDaJ0aOeW0A05OUNRqeYOEIOWffVP1T092t5jCSEcUWnc9ojE0B5mnjNDSdJRCIbT1s3jxEjJKISlQdJ9TZsuO+zRkZa1fnO8Aj6OP6xupoIoMsJCiE8H87cx5Fy1Wr5Wcqitrp51zPqL0/4lGJmMDsZ15iJanOsQC+ftqMI5MmxKtkjYQ1R5WK/+dvEbzJDKGuBjaUY79mLrxujL4iGraS3SJ12VoaGCwfL5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG6KcD+mdjzGtNUGOAjy00ESLHlnDLyIRS8d/XmXQH4=;
 b=iyVzo6P4L7tR3vyavuNmiMk2KTY7QShShjJ5UHDgnToqDNMNWln/o3JICMDHfWELiJUJ6rrLSrFHIcXdR7DD4sI8AtZ/lbKfY18a01OIthJ87BA6kiZ+IecqBiI1IIUD2eqyIHdejy457y5qxXZswsKWgolbN2cym8ghYFr0kobfmLrwtL2iKeEhs3C4c3NtKVJ9+ZhQ1nhcGgJTcaLDLG5Dz2i9bTM+/sqHFkR8vnNIgKbf90Bzm4nM/Qg/LmXuvKfoIVs1KYnrtjcGr2YX+Slij142rleqIz3AdU47JzfM7KI29Yoc8rTH0gVMyDD6iHexQ7hiVS65KGAWK8XZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG6KcD+mdjzGtNUGOAjy00ESLHlnDLyIRS8d/XmXQH4=;
 b=daVYTwiRlrerJwA2DYVG0m7m0YYS2Oa2miqTZiUrrCIntplWLnpe2B0COWNZh2gQEThU8PugZlb1CXn+bHubqQUeBulWipPWw0tMjVO6hjRzrMCzV4ZMWf/WSUqx0hdqHzcam/yA5xwYmDejRPuxqFHm/oPXOeWguzzbV46y4RE=
Received: from MWHPR15CA0027.namprd15.prod.outlook.com (2603:10b6:300:ad::13)
 by MWHPR1201MB0015.namprd12.prod.outlook.com (2603:10b6:300:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Tue, 20 Jul
 2021 16:21:26 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::bc) by MWHPR15CA0027.outlook.office365.com
 (2603:10b6:300:ad::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 16:21:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 16:21:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 11:21:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 11:21:25 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 11:21:22 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/12] ASoC: amd: add vangogh i2s controller driver
Date:   Tue, 20 Jul 2021 22:07:28 +0530
Message-ID: <20210720163732.23003-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d99c11fc-03fc-441c-5311-08d94b9a6c93
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0015:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB001546798341BE164BADCA7A97E29@MWHPR1201MB0015.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:14;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RmRTSByPzHFYDDHWlyIl96lkGdjyE/AdCf10VcmWsMrMeVyg6Gwb+f71+ZOagjt1l0qoD3nyY2n7wsDn+xd+kBvZ9o60nw1M2RhRclqIIjGHFGtIdHFosJT/4q82dgLfUmvbBT8/6JPyM1L22GfhJ2Jjeh+T6Wu/LlHjIQ5MJqBldyDs57R9tpJSkAzmENDrR/RZoZkCmZo2xykJtYWR9G+TSZHcMUqsuVY9uYUk6wK5/9z/U9oFxED8zNgZTF1mSS+VX/zP1mghUKQHrO8014RrRh4N8mxKYDiYn7Uak8sDr0Zn7lTJ4bIaNwZI6Rpe8aGU+7qsUQmo1E8t3X87hox6fGRfuAC/AtWHV9jyV3XFL1DBQhpSOeziDOLyhI6Hp+Lu9FT/QLKkk3SdoOEQah4B0gh6Lim7mFIbkEMIC0+BZlhDuqkz1rWysnbUtiUqVMD/rlT8259ii19s01DiFMvaKWHMjc6AsRzhNzPUc8bBbmvPsMll2qNw9fiHJZLkSXC+R9GLpqPcjz652eutMZuQNxpEe9Yu/F9gOlVcfNca5X7Lw0WDafLcrL085HfglNhj+5UL5yc/u93lH+IXqhKmHPwFUQUECAm6MJKUZqJ0pYLxEWhbyuVZuOl3ES/vAypuECJ9NGD0dqbFdhyEzgkwh29vGgKZBK9DaUxR+jtd4JzYnjOGoMD+S/hDinBZ1zTLim+Zr/kS6xrrGGC0RLCqFKsFHK3M9kpRdOyytK4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966006)(36840700001)(8676002)(8936002)(7696005)(186003)(54906003)(36756003)(26005)(5660300002)(70586007)(81166007)(110136005)(2906002)(316002)(356005)(1076003)(86362001)(82740400003)(4326008)(70206006)(47076005)(82310400003)(336012)(2616005)(426003)(478600001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 16:21:26.6548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d99c11fc-03fc-441c-5311-08d94b9a6c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0015
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vangogh I2S controller driver to support two I2S controller
instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-i2s.c | 88 +++++++++++++++++++++++++++++++
 sound/soc/amd/vangogh/acp5x.h     |  4 ++
 2 files changed, 92 insertions(+)
 create mode 100644 sound/soc/amd/vangogh/acp5x-i2s.c

diff --git a/sound/soc/amd/vangogh/acp5x-i2s.c b/sound/soc/amd/vangogh/acp5x-i2s.c
new file mode 100644
index 000000000000..30b651035042
--- /dev/null
+++ b/sound/soc/amd/vangogh/acp5x-i2s.c
@@ -0,0 +1,88 @@
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
+	if (ret)
+		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
+	return ret;
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
index 929be9905e8e..2300e63534e7 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -71,7 +71,11 @@
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

