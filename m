Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D303CECCD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381268AbhGSRhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 13:37:53 -0400
Received: from mail-dm6nam08on2076.outbound.protection.outlook.com ([40.107.102.76]:58976
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348973AbhGSP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 11:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INAv05iudmG1duWjiMQr6ktbF/aldHnOv5h7LMbGtLitOiC3lrEpYU6OK+G1WMUt4JnEhZpAAc6XOHMA9CnceB4gAlBLFWIyxlomKEYDbOh8qCbCEj/sTupcLVb/H+iTZzUU6oZZ7QYBL6605EiEhJKVLB3syBd4nhvH5w5r/w0yHBWXRZPL6A8U3yNzSFdPRCF9/q1vIIkucNf4OnGievKAgPSp0K5WAb18IlylOjT61U6Zfxs2afN7YhvwJ/Mah46jnvTF9JEvkifu07rLW+D+TMoPBweSALD4PqY0MvdtKlDKTf/Y7GFMVGAvUhlulzJVWGC73zg/qypWINmS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZEF2JRkAVbKFJI/YNtTTk3UBubzBxXN/w5gaswdT9g=;
 b=KhhUP6bCDIUwSJqMPIJudQEt7fz5OiLxxetRVLBmYmHumlcxucdJKeWsoKhQxkYc7+2SRIYaVkTVa3ogmbYEUee7PJ838Ih2r6NZzMTiohwa0d7LSWz+yiPhh3l8aMWeh5vIYjmyhUuhKo/T1ROzUGHQJLdfKS64i21UEOn18aB+WwJuw5yBbNeQ0Ce3J58IL6I4z2RgFCfRcZhQATnJn3AqoFKiQpa0/MlP8IppH8i+GHAJfz9mvFteyVAGvfEykjVji28kp7KmtDrAbIxU8DALQ5Uuo51wWTdJMoqALO40nyY/NquGkmWTBDIA26aIToEK9583qGXVMQvwPKAcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZEF2JRkAVbKFJI/YNtTTk3UBubzBxXN/w5gaswdT9g=;
 b=lMvADkTTg0fBXDbcy6lDeCrFu6ZCRXblDxL/jtjevRrsPU75t0MNxFWFtq452vmCvCAZhyKHi83Xa+q19SswTdcAUjUorrN8tYIrwpDrwlIM2EsMSk7r3hR4AbRDyrC3muR5yi4WBkqizh4VPBpCITmyebz6lV2EGP1OekuLYGo=
Received: from DM6PR06CA0102.namprd06.prod.outlook.com (2603:10b6:5:336::35)
 by BN9PR12MB5066.namprd12.prod.outlook.com (2603:10b6:408:133::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Mon, 19 Jul
 2021 16:37:08 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::95) by DM6PR06CA0102.outlook.office365.com
 (2603:10b6:5:336::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Mon, 19 Jul 2021 16:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 16:37:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:37:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 11:37:06 -0500
Received: from LinuxHost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 19 Jul 2021 11:36:57 -0500
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
Subject: [PATCH V3 11/12] ASoC: amd: add vangogh i2s dma driver pm ops
Date:   Mon, 19 Jul 2021 22:21:39 +0530
Message-ID: <20210719165140.16143-12-vijendar.mukunda@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210719165140.16143-1-vijendar.mukunda@amd.com>
References: <20210719165140.16143-1-vijendar.mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 900ae299-cefb-44e5-c50f-08d94ad372f1
X-MS-TrafficTypeDiagnostic: BN9PR12MB5066:
X-Microsoft-Antispam-PRVS: <BN9PR12MB506662A08F6A6D787CEE839597E19@BN9PR12MB5066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HI6tHzYcs9BmUJkjhGb4UF/M81WT5q4X20+Zxf79+kZUniwCY+hRh92tkb2puzs2UAEXqJo4fe9qkVWPXkRFHJ19vh9JXc+xiOFlP1E4WcZkD5Ej5k6Azzjcg/rkOVmZPkxIuSBny1mUCoF82XbsFDPOcmn+y4YX8PozwcPK5vKrQwwT5R0qoRyepbbl7W3y3x4VyJMT099PTHAlkcgrdtNdgt7rFqBwebxH7KvwFFqlGw5fTqE4Il2QK4pZ+PmeAKjqZQydlvJBuSh5nk8DKapMOGl0zb5jFJPl9uajKNT8bcdSjkkm3sxwwKsi0IR+nvFOYsz7q/DzUL7eRCk+pCnQ1JiBzJSvldNin9kRhkLLM81EMK6AyWp6DyFjFLnwMVnsU+Ok0jZfesCi15lrGkMPHosVPfYcpmd5Rmz1QHjSVsZarmpp7mVWtmiiaNCAhw4REgd04yigVOK2EWMMmG728xOM2MP+wYHSSVIZWE8yHx8fpUaDDvbCm66RgQxMVgKwO08dIcApsSgqlk7nbuP2tlZl0ta0XKv3qXwfeXWQqHpT1smtTb96msa77ePnjVUbnGVkPX+mDd+M9fF2SsPcepaLDa8FYyM1DNWQajPOH8cypOm8B1+zCllhfngJpJRzCnPMWy1SrntrYwG8lhSL95q/JSG+WlbFZER5JKjXvmqGQ0x6SMetouHNgZi6EQZKoAunmbKk74ZcdM4IScKb85342uP0ZMcCPy9yxa4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(81166007)(47076005)(26005)(82740400003)(4326008)(70206006)(2906002)(70586007)(110136005)(186003)(316002)(478600001)(86362001)(54906003)(82310400003)(8936002)(2616005)(8676002)(1076003)(356005)(5660300002)(44832011)(426003)(36860700001)(336012)(7696005)(6666004)(36756003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 16:37:07.5638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 900ae299-cefb-44e5-c50f-08d94ad372f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vangogh i2s dma driver pm ops

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 90 +++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index a2bd53dc86b9..260b6ae0fb2f 100644
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
@@ -417,13 +418,102 @@ static int acp5x_audio_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "ACP5x I2S IRQ request failed\n");
 		return -ENODEV;
 	}
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
 	return 0;
 }
 
+static int acp5x_audio_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
+static int acp5x_pcm_resume(struct device *dev)
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
+static int acp5x_pcm_suspend(struct device *dev)
+{
+	struct i2s_dev_data *adata;
+
+	adata = dev_get_drvdata(dev);
+	acp_writel(0, adata->acp5x_base + ACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+static int acp5x_pcm_runtime_resume(struct device *dev)
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

