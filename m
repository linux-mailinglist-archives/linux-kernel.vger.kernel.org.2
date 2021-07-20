Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB83CFF52
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhGTPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:45:39 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:16833
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237233AbhGTPk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNQqPnSd8KLSZu/libCI1yXairH5p5tOjn1QRk1Bnm27wFulnAi0H5Ih5ira+zK94TPnNulGSAo8tf2XSUfmflBW6zbyv1iYSVb2+BUJPU9xz6zuraPjWytP0aW/L2gZ4OWp3H61w4+UXcheBXQgUASnNyUdBqagJFk6LBRrUtd9PDf2pnOmOOndC9AKOpKbNbo1WuDfza9OSbfgwwHaM6uzUOh6MetEKWRFqWW82ztkthPNj8iMJgrTS8pjmhhla1u6D4MFYp3PG7heuEa7u3Py9vN/F0PFOHmuidtusCx1HP0sSti5Dbp+GrERXPHEzwZKAwD+m8iB2rE/ulHRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u503hGVKxSWEtPSf5nUdRdzX/q1scFh97TSSssSXsqo=;
 b=A4kTbA4yOjZblB/jz5abtM46YOMyCwIcZHe8haC19yEt8qdTHJQYWCmrlrxk6rUHcX7GiVNq0NYfh+k07dkx/jN1QqEBkvytBS2Fp+lYnU4LELFBwOXXkvACqiqJVdvl0WROevduJBK0zdaGUChSiwdo75eqJhDn3OjJ0+n+YCz4YXcWywYa7b6oolSFxxuvLcYGAX2ZjPBB0LTYcqlCI45ZvaYxpHYYt8fkepJbmjujreUddg+hkWeZyM7c6L6SvtMfr4mL1TfFqlwajoJcpBET32vuUS/CWCow18dIUAxP12g1lKwdd2IgpjKpzA9ndeL0ZluE5rdFoP+eN/NCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u503hGVKxSWEtPSf5nUdRdzX/q1scFh97TSSssSXsqo=;
 b=4NDsuvNKr96zy1aCzt1AKgzWhrYQaP4lTsQY2jKayePmMTpO91qGgQnKME33ho5YIpMGu7XD7Zq+pN0hUzvwFS5MO7/LHF04nMuudV8iepkfVGkT0oUVeRz7953IjkHrYlSvXLrI8uFR0BOYBsqUb9dt+4e9XffWAPy1dAEm1YQ=
Received: from MW4PR04CA0384.namprd04.prod.outlook.com (2603:10b6:303:81::29)
 by CH2PR12MB3718.namprd12.prod.outlook.com (2603:10b6:610:2e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 16:21:02 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::96) by MW4PR04CA0384.outlook.office365.com
 (2603:10b6:303:81::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Tue, 20 Jul 2021 16:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 16:21:02 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 11:21:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 09:21:00 -0700
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 11:20:57 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma driver
Date:   Tue, 20 Jul 2021 22:07:26 +0530
Message-ID: <20210720163732.23003-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
References: <20210720163732.23003-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b3ac1da-d098-4cca-9149-08d94b9a5de7
X-MS-TrafficTypeDiagnostic: CH2PR12MB3718:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3718D2FCCE28C49C9656282797E29@CH2PR12MB3718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:45;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p44Mj2iXyN0MRjuHqsuZgoBkfQy9PEW9wv0xuOQ/aSZx+56DhOCfb42grt9NxrYzaQ6dlebLpb4/1pO13E7NrNbZMlTEnC+6pIivwYdiAttSqJ7UA2jH4qAcopbT8+ntCRQ0ySkC3WyMmmmywKhkbWl76nYoodp4rJNwx/z8lcQaJo81BeAAZQ6JPmmKt1bRQF5o2c0QwfK8jNXS/GA8hhNGusFT+Ie60NWy+/RTR/VbTa1tUQCz5F1CFWlfSuuuBsxjggB7X8Vasrd2t5LUl3iC5may82L15WCyw/gUOQXVrqKHzQp27yLKSyjnMO+1tUhtblc9WgmZAgQLQfULLsVoNIqDZTzdN2CBClnjOhWNNPqHHhTKqK4da8O3MIjFbOxKkS8NtYsnIn4qrp+aoVeq9EQ0PZbqx44VP95MhwvzT1Az1aHtefHv6JGTDiKXT+DGju85+9U7/yMZyfHsftsM/1tgZASMhLXiT7mdApCtuNV67gcB/OQMq1bFSAvm/MUrGVu9k++z073VLlH1M1/Y6dWACkSs6WD3lipeA6w+tukBpVb04MwWovkXCNb0Q0GIidiYoeKdROasdDtnH5vBj0iu3Bu88SluPk2So9UdbWHawsp7aBC6n5QPMj3tg/PHv2aXFxAJJdH1xkW+DUvPT8s+YDhCCsHZh1cTbGe9b3QbfQrIQD9NyHsOBSKBbnkkaLoDgoa1XqdntcjE0XUwN9EDmosZuAAGzWOUliI/S6/6NcXBy/cbFtCoA1gZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(5660300002)(316002)(2906002)(82310400003)(356005)(186003)(54906003)(36860700001)(8936002)(7696005)(26005)(86362001)(83380400001)(4326008)(110136005)(508600001)(426003)(1076003)(8676002)(47076005)(6666004)(70206006)(36756003)(336012)(2616005)(70586007)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 16:21:02.0300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3ac1da-d098-4cca-9149-08d94b9a5de7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3718
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever audio data equal to the I2S FIFO watermark level are
produced/consumed, interrupt is generated.
Acknowledge the interrupt.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 61 ++++++++++++++++++++++++++-
 sound/soc/amd/vangogh/acp5x.h         |  9 ++++
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 7d397acb3632..4bc32183297b 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -21,10 +21,55 @@ static const struct snd_soc_component_driver acp5x_i2s_component = {
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
+	if ((val & BIT(I2S_TX_THRESHOLD)) && vg_i2s_data->i2ssp_play_stream) {
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
+	if ((val & BIT(I2S_RX_THRESHOLD)) && vg_i2s_data->i2ssp_capture_stream) {
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
@@ -47,12 +92,26 @@ static int acp5x_audio_probe(struct platform_device *pdev)
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
 						 NULL, 0);
-	if (status)
+	if (status) {
 		dev_err(&pdev->dev, "Fail to register acp i2s component\n");
+		return status;
+	}
+	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
+				  irqflags, "ACP5x_I2S_IRQ", adata);
+	if (status)
+		dev_err(&pdev->dev, "ACP5x I2S IRQ request failed\n");
 
 	return status;
 }
diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index e450fb32d680..a0d898e47bb8 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -32,9 +32,18 @@
 #define I2S_MODE 0
 #define ACP5x_I2S_MODE 1
 #define ACP5x_RES 4
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

