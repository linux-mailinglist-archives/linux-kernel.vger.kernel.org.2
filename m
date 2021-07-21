Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718EE3D157C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhGURIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:08:51 -0400
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:25393
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231254AbhGURIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:08:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+ns743ZeKRvwgJN+0YTShossQM6hdJqBfU+6QKvEomkuIxtYrdnrFEbdjevQfbILFcM1pmrzavunBU94GYLi2eXCip1UVvukeyIA5ZzG3fs7mO12jQoDzkujxNvfZs+Sr/IeeJnhKWPQzgpb0aAnCRK6/sCYDV3jxFW3WjUseCJTHExw6onHePtFE+mAfFAznEEw97yotyt9NXPRxAQ8BZzgMgGAxEh6UXmhLYEZvhuJNUCJT9WvJgD6KNFlG/6qAK1jKO36rwBDALrHcfLIhrS1E65zVHjTPH9W7lOqKEVncukzSl6gj1dpmSVNpVQWtZtJnOzv9u5kyp8BxAxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5v7tYWv6F310EGGkyiS6cKsnggg3ufhP05f6wGnJSw=;
 b=Jtm2NJV1vKn28nODTcdUQiyC+O3VFxNdMHCptmMRyeRFA4ZE9ZcKgbp0un0BNxXDFR33tJB1cbLx6+rA/WxQAx4ypLTQ3yuFyeTGLA9AXLmcVQcuNOYLnSG6+0lIrL5Na567vs1WWpT3QEpKLUDZtpn7gU+kkUOs9EQl+MKD06zNIz8QQ/88xYtWOU7yfQ1msXM9rp9dhcIIsPKoITPEGLNWQ0k2/PUuBDfPAxO1quER5lBYxzB9WZUBml2SXB1qHEtckB023hrMvpIpId50S7D9Iz2R0PqecRNsZAK3QQx5DGUJ/Zp7mm4wLPC5oydylFQGErvwrrDke6q0KWwvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5v7tYWv6F310EGGkyiS6cKsnggg3ufhP05f6wGnJSw=;
 b=nOaxqfO8zNJsDNmZU4q1feZhWGUdAry2kqnCijRP3HTpta7h/NICuaFEw8cT9+PVt+XKklP5Oc7Rn9lILkY9V+WKQb23q+XXlELponrfTQE0Vff6pwZtVKDtTnZG9k+aleIR3gQJFyNKWcL9LVnOyqV/+N3HQyfjXAiT6hsb2hA=
Received: from BN6PR14CA0015.namprd14.prod.outlook.com (2603:10b6:404:79::25)
 by DM5PR12MB1418.namprd12.prod.outlook.com (2603:10b6:3:7a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 17:49:24 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::d5) by BN6PR14CA0015.outlook.office365.com
 (2603:10b6:404:79::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 17:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 17:49:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Jul
 2021 12:49:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 21 Jul
 2021 12:49:23 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 21 Jul 2021 12:49:19 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <pierre-louis.bossart@linux.intel.com>,
        <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <krisman@collabora.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 11/12] ASoC: amd: add vangogh i2s dma driver pm ops
Date:   Wed, 21 Jul 2021 23:34:27 +0530
Message-ID: <20210721180430.11571-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210721180430.11571-1-Vijendar.Mukunda@amd.com>
References: <20210721180430.11571-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c1a54f-2470-44f6-dce3-08d94c6fe0ab
X-MS-TrafficTypeDiagnostic: DM5PR12MB1418:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1418355307BBD138D21C919C97E39@DM5PR12MB1418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuML+UhssTLDHj45jLxWOtqgpNYqepyi6NdrWc435y/q9TZXhHGuzR9+J+/HfeOG7c3Tp9xYxAjUySXw3NxQ3+D0d8ky/FCjEkw+qKmXB/ReDqIiQXetzK0kKWZzkl0c0quIp3iCz5ieO2RGkIkqv3gi9SkBzR4d/Au5ahTHCGTdQQIGmp9+x8WbUG6W2r4TrPep+dH68LW3KFG/VJsCwgP48vTq8IHR5a2bDx1Jvodn7+2PvhaVODDbgtGbyMJsKwysj/P4iZ5VnW5uWTUU19CZxK31Efn5OtIGtS1/tXT3R5K82HV1mjbydN7oeCWKIQ2wnifXbcWjcsn3sA4wpq7iy8s9NE5Fd52yVBL0YnfFYaOAZrMkWYwpoZZhhY9C0O5pHmiRXLJ5N1sClTbKMeGC5W+AGY8c7iOo8iGlZNZtaiox5TPow3/mu6RhufNKuiWpu+U3IFmrrXsSri2+nAwA9ooGu4ucaqaxoTZy2r3j+Yvx4uoxTJfwqTYy185g2yMmLA6S5xFwR3St5FV3F61/VL4D3xRkw//rvoo1KqVMfP3hKfDjNmqlIZ+AqPFUgd01czHZVnahxrj4orkh/00F7cP1Zm/eCYzCFaH18lTycd9OnaydRnkI4mFDAWzR3Ps5EGo92UhF6+F8JrFQpEYoRZb64WpBwcHD86ULjMdXVJHdZEs935d6FMTrL7Ee+KDhbbaAwwuBkuX2X6i5KHfQKcqNrdxRNzl3x1ESRTw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(110136005)(47076005)(70206006)(2906002)(86362001)(26005)(70586007)(7696005)(54906003)(36756003)(186003)(36860700001)(1076003)(508600001)(8676002)(426003)(6666004)(316002)(5660300002)(8936002)(81166007)(82310400003)(336012)(2616005)(4326008)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 17:49:24.3546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c1a54f-2470-44f6-dce3-08d94c6fe0ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1418
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vangogh i2s dma driver pm ops

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 96 ++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 6296b353c7f1..9f8eb72ac834 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/pm_runtime.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -412,16 +413,107 @@ static int acp5x_audio_probe(struct platform_device *pdev)
 	}
 	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
 				  irqflags, "ACP5x_I2S_IRQ", adata);
-	if (status)
+	if (status) {
 		dev_err(&pdev->dev, "ACP5x I2S IRQ request failed\n");
+		return status;
+	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
+	return 0;
+}
 
-	return status;
+static int acp5x_audio_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
 }
 
+static int __maybe_unused acp5x_pcm_resume(struct device *dev)
+{
+	struct i2s_dev_data *adata;
+	u32 val, reg_val, frmt_val;
+
+	reg_val = 0;
+	frmt_val = 0;
+	adata = dev_get_drvdata(dev);
+
+	if (adata->play_stream && adata->play_stream->runtime) {
+		struct i2s_stream_instance *rtd =
+			adata->play_stream->runtime->private_data;
+		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
+		switch (rtd->i2s_instance) {
+		case I2S_HS_INSTANCE:
+			reg_val = ACP_HSTDM_ITER;
+			frmt_val = ACP_HSTDM_TXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = ACP_I2STDM_ITER;
+			frmt_val = ACP_I2STDM_TXFRMT;
+		}
+		acp_writel((rtd->xfer_resolution  << 3),
+			   rtd->acp5x_base + reg_val);
+	}
+
+	if (adata->capture_stream && adata->capture_stream->runtime) {
+		struct i2s_stream_instance *rtd =
+			adata->capture_stream->runtime->private_data;
+		config_acp5x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
+		switch (rtd->i2s_instance) {
+		case I2S_HS_INSTANCE:
+			reg_val = ACP_HSTDM_IRER;
+			frmt_val = ACP_HSTDM_RXFRMT;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			reg_val = ACP_I2STDM_IRER;
+			frmt_val = ACP_I2STDM_RXFRMT;
+		}
+		acp_writel((rtd->xfer_resolution  << 3),
+			   rtd->acp5x_base + reg_val);
+	}
+	if (adata->tdm_mode == TDM_ENABLE) {
+		acp_writel(adata->tdm_fmt, adata->acp5x_base + frmt_val);
+		val = acp_readl(adata->acp5x_base + reg_val);
+		acp_writel(val | 0x2, adata->acp5x_base + reg_val);
+	}
+	acp_writel(1, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static int __maybe_unused acp5x_pcm_suspend(struct device *dev)
+{
+	struct i2s_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	acp_writel(0, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static int __maybe_unused acp5x_pcm_runtime_resume(struct device *dev)
+{
+	struct i2s_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	acp_writel(1, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static const struct dev_pm_ops acp5x_pm_ops = {
+	SET_RUNTIME_PM_OPS(acp5x_pcm_suspend,
+			   acp5x_pcm_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(acp5x_pcm_suspend, acp5x_pcm_resume)
+};
+
 static struct platform_driver acp5x_dma_driver = {
 	.probe = acp5x_audio_probe,
+	.remove = acp5x_audio_remove,
 	.driver = {
 		.name = "acp5x_i2s_dma",
+		.pm = &acp5x_pm_ops,
 	},
 };
 
-- 
2.17.1

