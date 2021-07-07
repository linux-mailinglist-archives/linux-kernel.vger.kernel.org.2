Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1519B3BE2B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGGFnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:43:40 -0400
Received: from mail-bn8nam12on2086.outbound.protection.outlook.com ([40.107.237.86]:1280
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230120AbhGGFnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:43:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXchzmfBGTlvOwiAjH+cfhfgVwqQEC5UfRFV8mmnkY8JUNV41Lst0DCxWnIY+ac1nOVEhS6L9oLXfh+/r2KRsFLYSLAk9whelwvQV/43ubyeeLRbI0+CDuOedoyYOlHEZ5FDekDd7R7OjyKvBzOCg6VZdasao0QxLjL3cRPWPSzPvPqoN/fcVNEpJD9uNxwzELtAnoFGQ2lhyNEpyv4zcHGYTB+a7aSDA44AkYiimf5kGJRI+OrplS9LRGhpK2nGtoHVaID9P1+rAkCS4QbA1JKafe9GIIOFe1uRWKuKskqygSNv7j6GLBCbDOnVzrIstoeMoiu1dVSEm9Gd0PmZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MApu1/JhC7v9MUlb6wlrLqFZ66aZ8DUS13IcCc6omMg=;
 b=B+zGMJ0dTTJQKeNMKBAISSqMTMAZmoKc6QFjs5TBAStsPFNGc4JGO87A0iZcFw42CUiwlFMElEUL7M+QG23T0GBNR0l+M/Sn5AbCsTNuYpeps5F1DPN5P/XwVCMyMcQ3zd51qf0nRjmjNikK/SwAjrHM3HhB9LnuRWDPltTkfoSLngN0HInUk4A+PPBlmpt786OlwCSXOgQ/o7FtaZ5HIrp12gczOSuFuAzMVtUNxYOCFaov9NC/Es2V84SvsUoUT1AF5JXS29vyf5N2WGXILy+B726y+8+prVGceSfGMQip7HdhAfk+X04LsugZfKc/Bf3paHM102vYJOZ7kurzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MApu1/JhC7v9MUlb6wlrLqFZ66aZ8DUS13IcCc6omMg=;
 b=mSF5mIsAFVCvIk/foiihpG7IpLlZtgdkSWRyVsFHJ4CfYTSYxEgI67qkQdENqoWZLcllarC1gLNPgnMN8vuODYnbq7NEOZybKdxQD/e+HXm+6AnHT9Uu9nLM9IV6Z6Iechvx53PfEuyRyvgWEY6cbeYg/0l5/ZUqlWOURmgUFEM=
Received: from MWHPR1201CA0024.namprd12.prod.outlook.com
 (2603:10b6:301:4a::34) by CH2PR12MB3831.namprd12.prod.outlook.com
 (2603:10b6:610:29::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 7 Jul
 2021 05:40:57 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::c6) by MWHPR1201CA0024.outlook.office365.com
 (2603:10b6:301:4a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 05:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 05:40:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 00:40:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 6 Jul 2021
 22:40:55 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 7 Jul 2021 00:40:46 -0500
From:   Vijendar Mukunda <vijendar.mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Vijendar Mukunda" <vijendar.mukunda@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma driver
Date:   Wed, 7 Jul 2021 11:26:17 +0530
Message-ID: <20210707055623.27371-7-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707055623.27371-1-vijendar.mukunda@amd.com>
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dd014c6-8fe5-48a8-739a-08d94109cb1e
X-MS-TrafficTypeDiagnostic: CH2PR12MB3831:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3831EED9EAF49CFAF2DE6DB9971A9@CH2PR12MB3831.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:45;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zOx5SCzdjvjo9z8K+hyOSTYCUFecLLu6W8MdAN30N2purwmbZs7e8KYaS8H1AB3KDGdNNIxQqTTSpA5DgJKjgvn9PC3aeB33JNvbg7AXeTIv9crvvWizi6hF0oSdjOKX8fj3AtkJwS21dFT6TCL47pjxJ1dfz7gyZEyfATj6XdNPQxeC3F3Gz4jYmAAsCCCeWj8BVFlORRq68r8hDDeuPuiqqVY42iY2Zn2XEFfg4M3yhYszUw2wy8aSyTRzsxdn1OXe1cWhppkWTvl/ph8vU96AgMm/iDsDVCBe6quhSW43qEXwSXu1/c8PEBdyGwBlYBCAP69Mv/EvZr5FuU9Bmts4wAwB1XvpSVZaaINCmZ6SldJVBQf6prZbn9u9b3hAKHipBXX/h5d9cCgsgnoEnUN0AJskuA4m1DyOh9WK9gP+E8zUYI7PjnoSLHzkqGlkdQ+pE1GzWA/h9zwHPTleupzDZFutORcVg030qoS9ie6PK9xC9YBY0zgeSiBmv82RingMgoLn9PVbBdcz158ZPFtjnnWfN7zQIPWkW8SQeABHOgns4NbtmvL/2QMmf4hPsW4MRqGkrsjVHBZQ9+slWwtjOWTQVKGGiZEzFWUrmmIyC78NwzcZMeKzJ7Lh3NgxyYBm3QfbEKdeqQzvNp2fFn9SiXeW6D1gifAUWiJLulJOUjWJqUvkY4A7by/z4VF7WRdgFf0d1XhKYiajr/ZnejHyEh+cuHISeiTa07+pDfuo7ucFN7gItbTbdcEYtWr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(26005)(426003)(6666004)(54906003)(36860700001)(2616005)(316002)(82310400003)(110136005)(36756003)(2906002)(4326008)(8936002)(44832011)(7696005)(478600001)(82740400003)(70586007)(70206006)(47076005)(336012)(1076003)(8676002)(86362001)(356005)(81166007)(83380400001)(186003)(5660300002)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 05:40:56.6168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd014c6-8fe5-48a8-739a-08d94109cb1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever audio data equal to the I2S FIFO watermark level are
produced/consumed, interrupt is generated.
Acknowledge the interrupt.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 62 +++++++++++++++++++++++++++
 sound/soc/amd/vangogh/acp5x.h         |  9 ++++
 2 files changed, 71 insertions(+)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index efcf01eb89ae..d79712587d30 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -21,10 +21,58 @@ static const struct snd_soc_component_driver acp5x_i2s_component = {
 	.name		= DRV_NAME,
 };
 
+static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
+{
+	struct i2s_dev_data *vg_i2s_data;
+	u16 play_flag, cap_flag;
+	u32 val;
+
+	vg_i2s_data = dev_id;
+	if (!vg_i2s_data)
+		return IRQ_NONE;
+
+	play_flag = 0;
+	cap_flag = 0;
+	val = acp_readl(vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
+	if ((val & BIT(HS_TX_THRESHOLD)) && vg_i2s_data->play_stream) {
+		acp_writel(BIT(HS_TX_THRESHOLD), vg_i2s_data->acp5x_base +
+			   ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->play_stream);
+		play_flag = 1;
+	}
+	if ((val & BIT(I2S_TX_THRESHOLD)) &&
+	    vg_i2s_data->i2ssp_play_stream) {
+		acp_writel(BIT(I2S_TX_THRESHOLD),
+			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_play_stream);
+		play_flag = 1;
+	}
+
+	if ((val & BIT(HS_RX_THRESHOLD)) && vg_i2s_data->capture_stream) {
+		acp_writel(BIT(HS_RX_THRESHOLD), vg_i2s_data->acp5x_base +
+			   ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->capture_stream);
+		cap_flag = 1;
+	}
+	if ((val & BIT(I2S_RX_THRESHOLD)) &&
+	    vg_i2s_data->i2ssp_capture_stream) {
+		acp_writel(BIT(I2S_RX_THRESHOLD),
+			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_capture_stream);
+		cap_flag = 1;
+	}
+
+	if (play_flag | cap_flag)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static int acp5x_audio_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct i2s_dev_data *adata;
+	unsigned int irqflags;
 	int status;
 
 	if (!pdev->dev.platform_data) {
@@ -47,6 +95,14 @@ static int acp5x_audio_probe(struct platform_device *pdev)
 					 resource_size(res));
 	if (!adata->acp5x_base)
 		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+		return -ENODEV;
+	}
+
+	adata->i2s_irq = res->start;
 	dev_set_drvdata(&pdev->dev, adata);
 	status = devm_snd_soc_register_component(&pdev->dev,
 						 &acp5x_i2s_component,
@@ -55,6 +111,12 @@ static int acp5x_audio_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
 		return -ENODEV;
 	}
+	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
+				  irqflags, "ACP5x_I2S_IRQ", adata);
+	if (status) {
+		dev_err(&pdev->dev, "ACP5x I2S IRQ request failed\n");
+		return -ENODEV;
+	}
 	return 0;
 }
 
diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index eca642614b4f..44662e54bd34 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -31,9 +31,18 @@
 #define ACP5x_HS_TDM_REG_END	0x1242824
 #define I2S_MODE 0x00
 #define ACP5x_I2S_MODE 0x00
+#define	I2S_RX_THRESHOLD 27
+#define	I2S_TX_THRESHOLD 28
+#define	HS_TX_THRESHOLD 24
+#define	HS_RX_THRESHOLD 23
 
 struct i2s_dev_data {
+	unsigned int i2s_irq;
 	void __iomem *acp5x_base;
+	struct snd_pcm_substream *play_stream;
+	struct snd_pcm_substream *capture_stream;
+	struct snd_pcm_substream *i2ssp_play_stream;
+	struct snd_pcm_substream *i2ssp_capture_stream;
 };
 
 static inline u32 acp_readl(void __iomem *base_addr)
-- 
2.17.1

