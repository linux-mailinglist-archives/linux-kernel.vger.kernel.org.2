Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2143CECD8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381695AbhGSRil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:38:41 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:32079
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351360AbhGSPzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO24ArL3vF6WxNINlHm8ivjXUWX+aaAUHykbL9KWGUhkVvvuZ2ICz/F0VEOo8x9CN4FimBVjdeYqj31uDj60jgLdHs9/TuOw47OKW98qrIzkhQjiGOeILkzWul9TL0D58hEoUEyBi+EjP9+iswN7b3o9Vu3Bs1drffIvjxKTNgW3G+3JpgjvB1qmM6ChI2/IsU6aIyuUXWssC+PdV9Hdx3IiayiKDcE/7qQMJ2nQnC/20kRnNBlTWEhj/KeCI3oNlKZIdOBHb2/9yFyepq7wXIwbevGjio9lBLM42FiF40zHJdop6Jtur9butx07dIB9+j6EplweMqn0SjBymk133Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I7qTPyqne9xeCxqxwzH/JlVcKX2CwomKSXRizo0UlI=;
 b=Zi+S9B/REvI6n8vat14mv+wZYH2f6ihSroPpI9MMLdR9WrymSCc2LnvjjP3szTvDVCViStUaCCmDXmEyEI9uTHGmkaQdfO2Aek0IFjwdNFl5C8C8QPP0BwSSNVH9Ee3o+xtivRgM1LNbsWLmqLep0NBpAew8VKFPUKXmd755AkT/UrkSZ4Gd59LXS8PmQsbev0isK+FXDUSOyfgCM6EgNdVXqz+QF95i5WMjp+myCZqtKpSVdOcufUlKtRTAKlGAz9luVq2xUJD1Y74ycwFHtAbLAwY2rPCXosX4Zc+BNq3PUYBkbdBc9X4qYNdyUyYSkscwYeLXnG6NHdzhVVKdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I7qTPyqne9xeCxqxwzH/JlVcKX2CwomKSXRizo0UlI=;
 b=ZNSU26zF0EkLgHQFzaOHLlT+3ui6T5/klshF10LHb//dk0pLvqCFSjEHkTG8LuT/IUobceJFC/h+6bfbJpyImbqwwZcAX/4swUL6jq1q+tW8D50UAZ9b8PFCAXt9MnKhagYXuEmoXzyVblCe8EpZkb4Z5+aSzFcet4wCvCoWvNE=
Received: from DM3PR14CA0131.namprd14.prod.outlook.com (2603:10b6:0:53::15) by
 MW2PR12MB2553.namprd12.prod.outlook.com (2603:10b6:907:9::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 16:35:51 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::d1) by DM3PR14CA0131.outlook.office365.com
 (2603:10b6:0:53::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 16:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 16:35:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:35:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 09:35:50 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 11:35:41 -0500
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
Subject: [PATCH V3 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma driver
Date:   Mon, 19 Jul 2021 22:21:34 +0530
Message-ID: <20210719165140.16143-7-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719165140.16143-1-vijendar.mukunda@amd.com>
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a010330e-f024-43fa-6ff6-08d94ad345a7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2553:
X-Microsoft-Antispam-PRVS: <MW2PR12MB255393881499D2632082571097E19@MW2PR12MB2553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:45;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ir7EAJRxuEelkvgo7Mxtt5PgLsgdRXY1NZT+Ymmkf+yneDcrZEhS3xfcTGH+DVtNZbQ75FTtLxxNw7h1GygOXVA9xf7Mem1kSQ+5CtZ0+Mw8kWsLP7kRXODcjmfzce+2fipjikJs6zIToFnw5n7pkSjLwXwzuselTufuOEi00yjWazZXQ1ioZZkHSkT+YZBVrSdrTDNpOYPSDJNsH2a1GB8I2aryfd65zbBQ3k+a502ffZ6s063QVrryPNwn/sBRJ6EFm/K05fKA/2E2BmpwKLP8QZAJIz8gIUAVDBYYJj6f9eDQvdS+PWIspGxVCoxAFhx+S/CeoSL5nqX8GCVEwEHfiCMvRI81NXX+FXx3j9ouZKa6yDjGyKpkjZ7kyg4oeNvQ3IYtkLyBUy+Rfi7fnw2PQyg4QEOGUFLP0jI1j5XHhUacA87ha1ol0vIbbna6pTOgVYZJb/U4ACWVFEkYwgDWW8+xurWQInvicPH+lKo2nd6vTI7peCTBnz73vr2SiGLmW7MVikELU6vEceUBZWcIPpCA+olB7+zbAKeFLh74GFqP4DrDMozVulwIB1UW2u5OSmeUeN4jdyAEi8Se2vf9hH4pW/XOQkDJLtgscE1KX3eSC/jgeETW5FNoW9LGCAo/76+7MAqXO06LIRtj8QP1Cb88guCB6ZyXMyJLvJcjKtjhXOIzpXSp09GP2vm8vXukmSo9zFbH/zW6Ine970jVZ22VL6e5jUI+QxQP+30U8N7FO273FFIBmigDSWtJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(110136005)(70586007)(70206006)(54906003)(478600001)(26005)(8936002)(6666004)(7696005)(186003)(86362001)(8676002)(336012)(356005)(5660300002)(1076003)(44832011)(2616005)(426003)(316002)(4326008)(36756003)(82310400003)(2906002)(81166007)(47076005)(82740400003)(83380400001)(36860700001)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:35:51.5682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a010330e-f024-43fa-6ff6-08d94ad345a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2553
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever audio data equal to the I2S FIFO watermark level are
produced/consumed, interrupt is generated.
Acknowledge the interrupt.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 61 +++++++++++++++++++++++++++
 sound/soc/amd/vangogh/acp5x.h         |  9 ++++
 2 files changed, 70 insertions(+)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 2ff11bb88305..76a965a8ec3c 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -21,10 +21,57 @@ static const struct snd_soc_component_driver acp5x_i2s_component = {
 	.name		= DRV_NAME,
 };
 
+static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
+{
+	struct i2s_dev_data *vg_i2s_data;
+	u16 irq_flag;
+	u32 val;
+
+	vg_i2s_data = dev_id;
+	if (!vg_i2s_data)
+		return IRQ_NONE;
+
+	irq_flag = 0;
+	val = acp_readl(vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
+	if ((val & BIT(HS_TX_THRESHOLD)) && vg_i2s_data->play_stream) {
+		acp_writel(BIT(HS_TX_THRESHOLD), vg_i2s_data->acp5x_base +
+			   ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->play_stream);
+		irq_flag = 1;
+	}
+	if ((val & BIT(I2S_TX_THRESHOLD)) &&
+	    vg_i2s_data->i2ssp_play_stream) {
+		acp_writel(BIT(I2S_TX_THRESHOLD),
+			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_play_stream);
+		irq_flag = 1;
+	}
+
+	if ((val & BIT(HS_RX_THRESHOLD)) && vg_i2s_data->capture_stream) {
+		acp_writel(BIT(HS_RX_THRESHOLD), vg_i2s_data->acp5x_base +
+			   ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->capture_stream);
+		irq_flag = 1;
+	}
+	if ((val & BIT(I2S_RX_THRESHOLD)) &&
+	    vg_i2s_data->i2ssp_capture_stream) {
+		acp_writel(BIT(I2S_RX_THRESHOLD),
+			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_capture_stream);
+		irq_flag = 1;
+	}
+
+	if (irq_flag)
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
@@ -47,6 +94,14 @@ static int acp5x_audio_probe(struct platform_device *pdev)
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
@@ -55,6 +110,12 @@ static int acp5x_audio_probe(struct platform_device *pdev)
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
index d2853738eb17..18df2b5a4283 100644
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
 
 /* common header file uses exact offset rather than relative
-- 
2.17.1

