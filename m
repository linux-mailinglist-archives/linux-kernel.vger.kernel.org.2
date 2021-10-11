Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA47942864C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhJKFlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:41:12 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:61408
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233732AbhJKFlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7upO487lgulz7wbT8P3NMAwxNAiLWwVBXTXP1bR9O04/PFJBJJ5sXMjSo9quWo7QOPtaopKCiHba1YzCQdsKeh/JonrkzCSASIT2me18KTNYgGqm0t6JUaUEN6yX6jZmYZkSUHepF7kWZ/vR3TLgblTAtjipYYPDNTSpGtWOgs1XtxSKQCAHRfpblpX22xHerT+N8sixlHhW8FkcKEi7akLYPFTj9wM5LsQ6bdrYUeU0UIN0dLFhhNvtr32YKAaQ7yToVJ/lP7UT2SqQQlBfBOapDJHBcvCPsdINVoA7jRuRcYl1HCubw4HUfKj46ZLag7q/4KAwtFrbkv/QEUl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD7AmQRaOH7b12a1/4ruSuM2VuXVXIKtTO126TURZDI=;
 b=exRpXUW9D+gK7ticnpuzcCxvdxwZuFpY5mM6rNJaFs+UNg7gKeFR6v3Pod52Dx3l2qmWggiTbs5IyrW79I8pe4JDc9eALw8znt5b0hBgXC2iLkOx7/678XE2uI7LYZRJz0IzvSr+2j+nwS1KWTRXKFu7vIEw2LkRC9g2jvlhzd5jtYwblngPZRJ+/aYFZu6vfp6kvyn/ZDImSQ8xNTK5hBXElv+GrrCdR0kVC2efkZKdAmz6RKKfan585ZjERqRPueciDfnuFyRBEJ4rqibmM1tsK92UfbDQeTOGvfKi9f55u57b4Vibdlu4oA/SdMA3JpzHIl1Bot976XvRm0Lkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD7AmQRaOH7b12a1/4ruSuM2VuXVXIKtTO126TURZDI=;
 b=sINpf8oswO5FcnIY4jKhf2OXpgfXeXeK+Cf4KvLc7oSTqKDwWiFaEboqNcwYHCKzcBQskPyvMZpqthjDEMdxA7eCQhTiMZh2nMP1j/384uUPLjEDahJgOHg5ERXi2TCQxaDSWICgiD0OuTpzyggXNgKM3jkR5g8Z3uuCzjJGpJI=
Received: from MW4PR04CA0255.namprd04.prod.outlook.com (2603:10b6:303:88::20)
 by BN6PR12MB1458.namprd12.prod.outlook.com (2603:10b6:405:d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 05:39:05 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::92) by MW4PR04CA0255.outlook.office365.com
 (2603:10b6:303:88::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Mon, 11 Oct 2021 05:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 05:39:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:39:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 10 Oct
 2021 22:39:00 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 11 Oct 2021 00:38:56 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
        <Richard.Gong@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/13] ASoC: amd: add acp6x pdm platform driver
Date:   Mon, 11 Oct 2021 11:26:13 +0530
Message-ID: <20211011055621.13240-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be4c2996-d801-4dcc-ccc4-08d98c79700f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1458:
X-Microsoft-Antispam-PRVS: <BN6PR12MB14582B0F84DE6FF3E63DC07697B59@BN6PR12MB1458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:38;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKQsoEvImZdiGKoJ66ZoE/ns6RGy7mFtX351AYC1FckGauQY6T5pFnJeWL45ojFoxnGHECNGeNQupqO3Tf4n3SM21B/LisZu1X4hGg4o2taiSBb2vj2yN89wnaU6je1x/v0Iznhuho2gAZ/nfhFsvOPgtHPgHWasgGM8E8bjYRZCQm3OA9vuFTz/2shGbm60a2bbS1TRXmudgn5kVs3WT7gT8v4TqrQcNoCk90yt8IgMXHyctS2yR4ps61gSpDDybvnnhH5bz8ml+gfoLKcb+2uKH7vUEli6yamjIyplIUH2JduC4OEScuxqaZXtZjS7NPfTrRY5al0dY+a4W8DcDhaoM3wD/jQ+1SGJvdqyRj0XBwK/84o/e09cwJAzR7sSYYKZIBDCogg5mRNJLGHhhiAfHNTtOXJiw1FNEWz0ZFchoI1cyX6fOtgKDs3SLhtFDMbDA93AsbfpjeLH25BF57hrZFObU1PuzwKf26H1TZeb2k2b8CaCKwyzAVd4wHsWK42VObF4SREJ4CdLVTHKdqj3zWvOy2rTxwv6biMz8v6l/cPRmgyYBYtiXJShXonORmkCsIgtkFh4etcnM0ol0mfz6x5YiqpHWwpk4ZlmFH267MaoKgRMLw+dQ5mo4YN83ljwE2Dz6c4QEekfMPg8sHUjdizpl6nL7N+zqo5GGrbvEYJDoHOd1+xcjs91H2P6emlGutAqfnoo1uzOgCmKPoC/szDC6rcu9LHtavL1rAx037EZIByFkvHIxSshJBDjzbCYbaRtfLZ6d+9grbSXtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(8676002)(82310400003)(81166007)(6666004)(5660300002)(186003)(316002)(36860700001)(508600001)(86362001)(426003)(110136005)(70206006)(36756003)(2906002)(70586007)(26005)(2616005)(356005)(47076005)(1076003)(4326008)(54906003)(8936002)(7696005)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 05:39:04.7111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4c2996-d801-4dcc-ccc4-08d98c79700f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1458
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PDM platform driver binds to the platform device created by
ACP6x PCI device. PDM driver registers ALSA DMA and CPU DAI
components with ASoC framework.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/yc/acp6x-pdm-dma.c | 80 ++++++++++++++++++++++++++++++++
 sound/soc/amd/yc/acp6x.h         |  5 ++
 2 files changed, 85 insertions(+)
 create mode 100644 sound/soc/amd/yc/acp6x-pdm-dma.c

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
new file mode 100644
index 000000000000..e1a25268bc5c
--- /dev/null
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ALSA SoC Yellow Carp PDM Driver
+//
+//Copyright 2021 Advanced Micro Devices, Inc.
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dai.h>
+
+#include "acp6x.h"
+
+#define DRV_NAME "acp_yc_pdm_dma"
+
+static struct snd_soc_dai_driver acp6x_pdm_dai_driver = {
+	.capture = {
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S32_LE,
+		.channels_min = 2,
+		.channels_max = 2,
+		.rate_min = 48000,
+		.rate_max = 48000,
+	},
+};
+
+static const struct snd_soc_component_driver acp6x_pdm_component = {
+	.name		= DRV_NAME,
+};
+
+static int acp6x_pdm_audio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct pdm_dev_data *adata;
+	int status;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
+		return -ENODEV;
+	}
+
+	adata = devm_kzalloc(&pdev->dev, sizeof(*adata), GFP_KERNEL);
+	if (!adata)
+		return -ENOMEM;
+
+	adata->acp6x_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!adata->acp6x_base)
+		return -ENOMEM;
+
+	adata->capture_stream = NULL;
+
+	dev_set_drvdata(&pdev->dev, adata);
+	status = devm_snd_soc_register_component(&pdev->dev,
+						 &acp6x_pdm_component,
+						 &acp6x_pdm_dai_driver, 1);
+	if (status) {
+		dev_err(&pdev->dev, "Fail to register acp pdm dai\n");
+
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static struct platform_driver acp6x_pdm_dma_driver = {
+	.probe = acp6x_pdm_audio_probe,
+	.driver = {
+		.name = "acp_yc_pdm_dma",
+	},
+};
+
+module_platform_driver(acp6x_pdm_dma_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("AMD ACP6x YC PDM Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
index 63bdea3188ea..d6b2c70ce9c8 100644
--- a/sound/soc/amd/yc/acp6x.h
+++ b/sound/soc/amd/yc/acp6x.h
@@ -45,6 +45,11 @@ enum acp_config {
 	ACP_CONFIG_15,
 };
 
+struct pdm_dev_data {
+	void __iomem *acp6x_base;
+	struct snd_pcm_substream *capture_stream;
+};
+
 static inline u32 acp6x_readl(void __iomem *base_addr)
 {
 	return readl(base_addr - ACP6x_PHY_BASE_ADDRESS);
-- 
2.25.1

