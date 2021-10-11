Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825D428655
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhJKFln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:41:43 -0400
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:7777
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229986AbhJKFll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:41:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnHpg1ACeberqQM4j+LHQImdJ3SKmyA679O1+IEOv6S6sXLyhuDTsE3rHGjfz5b4EmyKhs4NnwKCSY3iA6e5v26nJi0UZOFX3h+UrhqI84+e6d+KcnfGf0RO+fmXf5ZWCHTTu2UGBNwmIzKwadRQnSPdhMhiVbeul3J+5xGQ20xCyPOmwfE+xPD6r1eBOucFUakNQ+0BUHPJXrFfSM3ThPiMUfHiuUb+1D4zIL7t1+HD9gQ4SVminH1m2mlvq0nyMBYiEK54QjjL/7y5bOuvFVz/tSzqM24mLhbQgT0v0clDmsGIvN3EWdP0w9H6yUJ3PuQr4Bqdf3Cp2hnCBWzRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfyDwpLyXYu4yJ9W8sHlUm9uWO68UVCr++PmGdj7oIg=;
 b=EtE0fF3mTrl9pUb9voYrn+mUg9096Oskg3h1YVqtyGVwxK8bVExGK+UGl4Wg8CvvsVwcWUQv3NuLDKpP8IRRvU19zAAc2tJgY4WNxyzYNhJDCFno1ryydM1Mya4jc7LkK4dFT6xTkLBkdPRuY1/bH2IStBQZ0Cqj+oozWuFUrB7sKVyBi6slGk5/CYgMCa+NF8v0iVdzBN3rLNn+uLvhhe9FYlR5mhg6IIPNAaOqlWmHfYZxz7dSaulXf7l2FkOmglJ4REzGFooDHZ+XXpH2sMtQFwivJzr+b5fgIO3fzzYeVnF+W9W5FycBUsoaICGAjaBJAZ2BWptS3VSiNwCdDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfyDwpLyXYu4yJ9W8sHlUm9uWO68UVCr++PmGdj7oIg=;
 b=FfsVjmW2rEx77s9CdHqVKKAXg1ciK+uNhxzFUdtzamNiiQe+d3il/C7Y4LikyOzBONYgMD1q36uaA5pJTqVbCGL91yio/6lc+xKoFrwIAyQOcWS8ZlPOQxjnmWWgM/vnWw3BGMZantuJWqHwPLWHjsiHakJ+p/JWWICnuuuYTuU=
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Mon, 11 Oct
 2021 05:39:37 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::3e) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Mon, 11 Oct 2021 05:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 05:39:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:39:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 00:39:35 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Mon, 11 Oct 2021 00:39:32 -0500
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
Subject: [PATCH 09/13] ASoC: amd: add acp6x pdm driver pm ops
Date:   Mon, 11 Oct 2021 11:26:17 +0530
Message-ID: <20211011055621.13240-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a02093a-b128-4f78-410e-08d98c798331
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB175477B5F751D06FB6D48AFC97B59@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQhDbrHr5Sn9b6xuGqifsvqaXKur9xqkwDV/VQbpCaKNn5ei+BiTmE5UnQLjriSUmpzmRl1qlFY3186XcCSEqWtyNMtxnd10573MbmCzI9xHuq9jkGi7FQhRsclMHYseKFeW6s+oLpfS54R9SK38cv6jxMrnj7BbAwgbIJmha6HqaVA1BqWf+6/8DvQKl5ZtH8zIuVbzMhcpP1q7vGCqPMEb8F5o+yuXKFTGshYPYbCv1pm0Uwkj4imgUEz8n2TmTY+PwEbZStvhCoBEWBHP/ragtlFKkM1U/gkWqrB+VuQedpWdgjNz2vKz9Au9JDDIRlkbGDFPQwEKiPPO0lVdH64SB8I2l2tkb+0LQBemVRHKZP2pt+H0Dm85z+Mlkd2SsFL7uTvPr2AvJIwL7J27qVGeHQQM6BnE85YyJFXx3A/n+XqJgddpEIQKGRKFzEAUGwzD8FKvhMCQcGAfPLEjrcM6PkH2k6vCnPamjStiJxx5CUzc8PsYkPDdJP2lHaoV28a8p6BRtUD0huXEduBUoLB2Q5UID7ug/FxNsHwQCdW6SQhtL5f1f24+kU0B/umVGZeFfSwSIQ8MIxKFAsklETjNiy/2schdxCYsQdkTBbI4aG0DOHu4dULT1TVY2VYbijiPgQ5Gl0mxCJ4Dj6gkXCSwSqISoRieZ++F9lYU/ackjFrR9TY7FpD+tASI0qXBccXeHjDVbXypq8NiK6GDtToFw++oiIVJFX6WXE3022w7U8PntvJl+SFqHdhnZnc1Zo1CJhIk04x23DsAhPXxgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(7696005)(36860700001)(508600001)(8936002)(8676002)(186003)(356005)(81166007)(1076003)(26005)(70586007)(86362001)(36756003)(4326008)(54906003)(336012)(2906002)(110136005)(83380400001)(6666004)(47076005)(2616005)(82310400003)(70206006)(316002)(5660300002)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 05:39:36.8053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a02093a-b128-4f78-410e-08d98c798331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add acp6x pdm driver pm ops.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/yc/acp6x-pdm-dma.c | 57 ++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index 3da74b1896e1..a37df4d051e5 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -11,6 +11,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+#include <linux/pm_runtime.h>
 
 #include "acp6x.h"
 
@@ -372,13 +373,69 @@ static int acp6x_pdm_audio_probe(struct platform_device *pdev)
 
 		return -ENODEV;
 	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
 	return 0;
 }
 
+static int acp6x_pdm_audio_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static int __maybe_unused acp6x_pdm_resume(struct device *dev)
+{
+	struct pdm_dev_data *adata;
+	struct snd_pcm_runtime *runtime;
+	struct pdm_stream_instance *rtd;
+	u32 period_bytes, buffer_len;
+
+	adata = dev_get_drvdata(dev);
+	if (adata->capture_stream && adata->capture_stream->runtime) {
+		runtime = adata->capture_stream->runtime;
+		rtd = runtime->private_data;
+		period_bytes = frames_to_bytes(runtime, runtime->period_size);
+		buffer_len = frames_to_bytes(runtime, runtime->buffer_size);
+		acp6x_config_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
+		acp6x_init_pdm_ring_buffer(PDM_MEM_WINDOW_START, buffer_len,
+					   period_bytes, adata->acp6x_base);
+	}
+	acp6x_enable_pdm_interrupts(adata->acp6x_base);
+	return 0;
+}
+
+static int __maybe_unused acp6x_pdm_suspend(struct device *dev)
+{
+	struct pdm_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	acp6x_disable_pdm_interrupts(adata->acp6x_base);
+	return 0;
+}
+
+static int __maybe_unused acp6x_pdm_runtime_resume(struct device *dev)
+{
+	struct pdm_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	acp6x_enable_pdm_interrupts(adata->acp6x_base);
+	return 0;
+}
+
+static const struct dev_pm_ops acp6x_pdm_pm_ops = {
+	SET_RUNTIME_PM_OPS(acp6x_pdm_suspend, acp6x_pdm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(acp6x_pdm_suspend, acp6x_pdm_resume)
+};
+
 static struct platform_driver acp6x_pdm_dma_driver = {
 	.probe = acp6x_pdm_audio_probe,
+	.remove = acp6x_pdm_audio_remove,
 	.driver = {
 		.name = "acp_yc_pdm_dma",
+		.pm = &acp6x_pdm_pm_ops,
 	},
 };
 
-- 
2.25.1

