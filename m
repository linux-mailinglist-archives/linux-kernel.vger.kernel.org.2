Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD583CECD9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381764AbhGSRio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:44 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:29196
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351336AbhGSPzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:55:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQWM/vPiG/gdJoSkHuGQJL/n6OBpJees+qVyu9+50gAY4V+e6QSj3lW0333tuocnrfnJd0EBjUVOAORcAc9g/EoNReg+kj+bqbA61NncYGVkLgcEzeML5gc7xlYbNKce5OhZmm+BvKbgt1gsf5zFCJSGcMARYtlJmXvY7aX0vQe+K+UeV98qZDrnPTliM1Ih3o2MDOhSmNnvoUYslZdfTobuk4hfdKu+4Vgy4ifChVdIbOp73KA1GWmuLFB1xLkc1elZcCqor9pGCDQGnaq/QxbgktllHAlW5inzNsyCs3yYgw+BnoBI8Ex+manIkySJEUV+Hat7fEZIKpSsQE2iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lljWRm+TtuqWEDD4r9IXuRrFTizOWIwsoTzgvjq67kU=;
 b=h8TNFHjpepnFAzBFFdFCd1QUrpKt48r72LQQpp1mxZ82LKGvC+OJn1clGO6cLjUwCoNE1JVyDqPag/FB9nhUUsj/0u72bOKf/0tL3ybtA7Cx/QCxzxJ9u7HKvJVt4qFG5t5XvstCaRwcCdpU/yUVsYlUYN4hGr3adhaD0wD790ZLqUtZjEzK7BF5SNqE2eeo+cPhC4J8sNHK9Jt5tpFXpg7qTwwJulR+ixfnplBpIwa7aTZVLHmiP0JkGHqIhy6u2hYbrUBKql99nn0WuWclK4Xby6ABOy8q9GmsiDQ5T5CTxZPzZMBOgAKwpwcp+q9l7Ns5lorNU7CFfs4Vm07ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lljWRm+TtuqWEDD4r9IXuRrFTizOWIwsoTzgvjq67kU=;
 b=GyqiPJlZmnmoRnUujZydS4Vi6M1Dm0uwf9J47uIJiKVAk6mo6YdmbTchse3BP1N3daAWqoZkarU1yo5ye6uaWrEWFrBEy4c6dO8lTTI5+V/z+4yTRhHFkmKWV5w4RkWCFoZXyuc33GJRuqixRivzgUVY+0S53cmajLeTiMsd8hg=
Received: from DM5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:4:15::11) by
 MWHPR12MB1632.namprd12.prod.outlook.com (2603:10b6:301:10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Mon, 19 Jul 2021 16:35:35 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::ed) by DM5PR16CA0025.outlook.office365.com
 (2603:10b6:4:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 16:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 16:35:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:35:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:35:34 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 11:35:25 -0500
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
Subject: [PATCH V3 05/12] ASoC: amd: add ACP5x PCM platform driver
Date:   Mon, 19 Jul 2021 22:21:33 +0530
Message-ID: <20210719165140.16143-6-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719165140.16143-1-vijendar.mukunda@amd.com>
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7957f9eb-e352-4d53-0b17-08d94ad33bcf
X-MS-TrafficTypeDiagnostic: MWHPR12MB1632:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1632EA75F8C43DF2346C4E0F97E19@MWHPR12MB1632.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/+bzAW3gN5wqMbuCm5UsMmKS8743IgTl9MvOz86Wt7JpLI3fqeROqjUuRJ2LpNDUkGpaH65i+c6Efc8HxZdY42nHO3UrdPF+6iNsLyUsXdn61uWNyDicutCzSPbuqWdEvbeJqZrwQ/FNRjjR/zUE74PFRCMA6T8tTbR9ol9/JoowB61kZz/lMJnbBsZuxSokFBgcASm2AaFgqvgLc+sjBVwZT+tVt334bw9B59OFblk0xY7MEfrY/LXClbwGymH7sMmPs77sLeDLF8fAsqEGgdG8MI/03vklsBiIc1G1nipBFiws9xDLM+aPo8EInurHmlj6U0ML3QwOJqyjfxE9+BdGLgsV9pjTgUIvLAJnvvGkeAu+vm6l3nd/6M0hdbNn1EsJia6ISObduKxmEQUlW0c51k7OCbuEv8X0xpSpnllEEhABr/8fx0x76ZjwdbEzeir6ih3MveaARjF5E5IeNgL1r2v4cR5L1z9zdwi4d5ClVkige0vrl3a4SMqApN+bQpipKJ5f/QHqMyKg/aPA7pf1ldIFNhKixsGUXtSa29IUigaKZ4I0dM3WCu5k8ThYC1IIVBiyq3ssVws19SAmIiiHmxGh5FktIFnJYS9pCB9FANz1Di3OZuRZV1OBahc01cPEJh8HOS/YFSnUiH2qyqiRyx2WF64alfL/3iTIQ/FQIX/f9+EGebErA6Cqd1Imv+YysCL1LVRpVVDeb05AGC4Om1c5ciwlTgVJfb1+OjvNZ0NgHToExP4MaeNkaAq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36756003)(316002)(2616005)(81166007)(336012)(110136005)(86362001)(44832011)(356005)(26005)(82310400003)(47076005)(36860700001)(5660300002)(4326008)(8936002)(2906002)(54906003)(508600001)(83380400001)(426003)(6666004)(70586007)(8676002)(1076003)(186003)(70206006)(7696005)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:35:35.0575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7957f9eb-e352-4d53-0b17-08d94ad33bcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1632
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCM platform driver binds to the platform device created by
ACP5x PCI device. PCM driver registers ALSA DMA components
with ASoC framework.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 73 +++++++++++++++++++++++++++
 sound/soc/amd/vangogh/acp5x.h         |  4 ++
 2 files changed, 77 insertions(+)
 create mode 100644 sound/soc/amd/vangogh/acp5x-pcm-dma.c

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
new file mode 100644
index 000000000000..2ff11bb88305
--- /dev/null
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -0,0 +1,73 @@
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
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "acp5x.h"
+
+#define DRV_NAME "acp5x_i2s_dma"
+
+static const struct snd_soc_component_driver acp5x_i2s_component = {
+	.name		= DRV_NAME,
+};
+
+static int acp5x_audio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct i2s_dev_data *adata;
+	int status;
+
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "platform_data not retrieved\n");
+		return -ENODEV;
+	}
+	irqflags = *((unsigned int *)(pdev->dev.platform_data));
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+			return -ENODEV;
+	}
+
+	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	adata->acp5x_base = devm_ioremap(&pdev->dev, res->start,
+					 resource_size(res));
+	if (!adata->acp5x_base)
+		return -ENOMEM;
+	dev_set_drvdata(&pdev->dev, adata);
+	status = devm_snd_soc_register_component(&pdev->dev,
+						 &acp5x_i2s_component,
+						 NULL, 0);
+	if (status) {
+		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static struct platform_driver acp5x_dma_driver = {
+	.probe = acp5x_audio_probe,
+	.driver = {
+		.name = "acp5x_i2s_dma",
+	},
+};
+
+module_platform_driver(acp5x_dma_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD ACP 5.x PCM Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index bbf29fd2b12f..d2853738eb17 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -32,6 +32,10 @@
 #define I2S_MODE 0x00
 #define ACP5x_I2S_MODE 0x00
 
+struct i2s_dev_data {
+	void __iomem *acp5x_base;
+};
+
 /* common header file uses exact offset rather than relative
  * offset which requires substraction logic from base_addr
  * for accessing ACP5x MMIO space registers
-- 
2.17.1

