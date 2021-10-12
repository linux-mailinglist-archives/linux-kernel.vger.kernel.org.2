Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61A429E88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhJLHZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:25:41 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:1026
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233720AbhJLHZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:25:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFXlX5XG1syRBWO0fVMNnN3c9TBuL6CcpwPiMIi3FF45abz6XP7weCxwYHUth8fvG1oQX3Ae8f/xCCFKigqLeNITFP7qs2Q+zgghwvZrwwrPj5zQf/M4wDiOydjCGP0qCiMHJ7SFPrYOBMKh+ZYTrHUHXR/VGeOpR2TuruIpIzi1q+xU8tNNH72iloe2fj/qZWn2hCrIOU8OZiKTmhIBvwTgVwxW4/T9vCPslC9OAlcThuSHLI4WuAu3stPg8RTGi6zVkFagP/JTJ8Znw8y418TtX3b0hTXmZLvyWo39S/3LSGq2SvleHThEyF3ADDyVmBAP1+WeAn3zAXIg0efMnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWHVfB0CwTRd6x4hVQ6S96nP2UxmmVzfSebx79R39rs=;
 b=ALJ7GqJr1dkjDvVUHPIJefOjYyuF51vXoRjJ2ulhn4AgYM+BFD6+/KGnA3VEXSnKL0kv60SLC7/86GtnAAwBpz6ONg0OTLpFn+DCNtvuzlXzXtfy6njWWdwIwvWNykRmHRv35W5Skapk3I30Yj3h/QIP8Yphiko0JDiqnxi6k4kgP6MWctXQRNfwCj6wkAiaWlElwZWsKqx6VU9ByNMXOZvDsUCLxtkBw9x/w4xXnYTFuwDBn7kBnJTuVnrktyjNRkkHdBlaCcZuYhQgwQy351p4Az48mk4Gx+wQcjmhc+AeCqG3oxfjvRvwBxp404tA1LUAtVE/4zx2/LXvDIwsSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWHVfB0CwTRd6x4hVQ6S96nP2UxmmVzfSebx79R39rs=;
 b=kG2n2GhcOso8zsxC5r9DBO2tSZvoB2Y/SPFAqRMreEl6mNhq1TFM3/5zRQer0oZI07N1uejp7HonJkPw0lYvmIn0xyO+raiIEu6TqCOsN1FT/L3RtcAUfU1NNk8+lw1uX0N1MeYpEk6p/Qfap/xTwjTuJZV95XXUqBUBXcviKoE=
Received: from DM6PR17CA0011.namprd17.prod.outlook.com (2603:10b6:5:1b3::24)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 12 Oct
 2021 07:23:35 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::71) by DM6PR17CA0011.outlook.office365.com
 (2603:10b6:5:1b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend
 Transport; Tue, 12 Oct 2021 07:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 07:23:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 02:23:33 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Tue, 12 Oct 2021 02:23:29 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Alexander.Deucher@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 8/8] ASoC: amd: acp: Add support for RT5682-VS codec
Date:   Tue, 12 Oct 2021 12:49:39 +0530
Message-ID: <20211012071939.97002-9-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012071939.97002-1-AjitKumar.Pandey@amd.com>
References: <20211012071939.97002-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ead86c96-3d7b-4321-bc35-08d98d5133c0
X-MS-TrafficTypeDiagnostic: CH0PR12MB5217:
X-Microsoft-Antispam-PRVS: <CH0PR12MB521774E0A689238AEF412F0482B69@CH0PR12MB5217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:200;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/e+Ey9cd8prIgmJPnAETUxhQ2QEWFPbA7WqfvLRhGW4vkfgFu4wo2SfoAQUbRSqPo/S3qG6P51VeBqJeY+8ifKxaqABvdWW7Pc0nUseIR9q6poqzRMXg0v07wANrXBYrNkkKZFI337hKWnpAHkKL1ANRD+flUly5xGAl6iC3UpRjtGMzUBIHIPWv3RpNmMBBTE66vALB88VqfyIezm15+jd6h+nt7njRTNx3pHtFPGtJV/VcnAfa/NUPFVbLdQWp2p/wf66ccUZ5S7AKfVoDrtmFw1MSQr+tYX1JIM4ZJUREDcARznQQN/hT8CM9IWI5PjYGijkhFJ9qUX0k8Z5WS568HyvEA/5g/nWwiT/qTV3D5dXY8+PVEgx5EvzpuuPdoiqSdEnKJK1s5Lo5o/XY08tKbshCCxzpiilVIq/O49Eaa2FeZDCLX2XVFKSB5KBHqpbcUpMOvoADHQEDu/rODnLXuLICx7Xg45+p30K07fUMvJW/PkogwkkR1gJtkUizYi08tsvCmeQa1NwXfxVUJQgn4X+xaNIjPbyb2HnptJkHFYTAPOVDTKR7tfhbBhQnFGbUJMDmZB192xnDATbT8x/PeRR9f8Sr+GHVUMgCzrH7tcdfIQ6mWtqctvsphlcsgESW2jaLZGwCc9IyjXeN3OTJlyoa+Ja/cMqo9vapPnhWqRfJq5zkf02FsQeb37rkNDQhBvkT9gW2/7XfFe8ZwCzlMG0V0Po0XPHGVLHMkU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(36756003)(508600001)(356005)(4326008)(70206006)(6666004)(70586007)(1076003)(186003)(26005)(8936002)(8676002)(316002)(7696005)(5660300002)(110136005)(54906003)(2906002)(336012)(2616005)(82310400003)(36860700001)(426003)(47076005)(86362001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 07:23:34.9022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ead86c96-3d7b-4321-bc35-08d98d5133c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newer variants primary codec is rt5682vs. Add support for newer
codec variants in generic machine driver module and define driver
data to register SOF sound card.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig           |  1 +
 sound/soc/amd/acp/acp-mach-common.c | 96 +++++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |  1 +
 sound/soc/amd/acp/acp-sof-mach.c    | 14 +++++
 4 files changed, 112 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index ef4208c3e7b7..98ec18791d35 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -33,6 +33,7 @@ config SND_SOC_AMD_MACH_COMMON
 	select SND_SOC_DMIC
 	select SND_SOC_RT1019
 	select SND_SOC_MAX98357A
+	select SND_SOC_RT5682S
 	depends on X86 && PCI && I2C
 	help
 	  This option enables common Machine driver module for ACP.
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index b9d77d761cca..cecf7e5a44e2 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -23,6 +23,7 @@
 
 #include "../../codecs/rt5682.h"
 #include "../../codecs/rt1019.h"
+#include "../../codecs/rt5682s.h"
 #include "acp-mach.h"
 
 #define PCO_PLAT_CLK 48000000
@@ -182,6 +183,89 @@ static const struct snd_soc_ops acp_card_rt5682_ops = {
 	.shutdown = acp_card_shutdown,
 };
 
+/* Define RT5682S CODEC component*/
+SND_SOC_DAILINK_DEF(rt5682s,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-RTL5682:00", "rt5682s-aif1")));
+
+static const struct snd_soc_dapm_route rt5682s_map[] = {
+	{ "Headphone Jack", NULL, "HPOL" },
+	{ "Headphone Jack", NULL, "HPOR" },
+	{ "IN1P", NULL, "Headset Mic" },
+};
+
+static int acp_card_rt5682s_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	struct snd_soc_component *component = codec_dai->component;
+	int ret;
+
+	dev_info(rtd->dev, "codec dai name = %s\n", codec_dai->name);
+
+	if (drvdata->hs_codec_id != RT5682S)
+		return -EINVAL;
+
+	ret =  snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				   | SND_SOC_DAIFMT_CBP_CFP);
+	if (ret < 0) {
+		dev_err(rtd->card->dev, "Failed to set dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_pll(codec_dai, RT5682S_PLL2, RT5682S_PLL_S_MCLK,
+				  PCO_PLAT_CLK, RT5682_PLL_FREQ);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set codec PLL: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682S_SCLK_S_PLL2,
+				     RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set codec SYSCLK: %d\n", ret);
+		return ret;
+	}
+
+	/* Set tdm/i2s1 master bclk ratio */
+	ret = snd_soc_dai_set_bclk_ratio(codec_dai, 64);
+	if (ret < 0) {
+		dev_err(rtd->dev, "Failed to set rt5682 tdm bclk ratio: %d\n", ret);
+		return ret;
+	}
+
+	drvdata->wclk = clk_get(component->dev, "rt5682-dai-wclk");
+	drvdata->bclk = clk_get(component->dev, "rt5682-dai-bclk");
+
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+				    SND_JACK_HEADSET | SND_JACK_LINEOUT |
+				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				    SND_JACK_BTN_2 | SND_JACK_BTN_3,
+				    &pco_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "HP jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(pco_jack.jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
+	ret = snd_soc_component_set_jack(component, &pco_jack, NULL);
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack call-back failed: %d\n", ret);
+		return ret;
+	}
+
+	return snd_soc_dapm_add_routes(&rtd->card->dapm, rt5682s_map, ARRAY_SIZE(rt5682s_map));
+}
+
+static const struct snd_soc_ops acp_card_rt5682s_ops = {
+	.startup = acp_card_hs_startup,
+	.shutdown = acp_card_shutdown,
+};
+
 /* Declare RT1019 codec components */
 SND_SOC_DAILINK_DEF(rt1019,
 	DAILINK_COMP_ARRAY(COMP_CODEC("i2c-10EC1019:01", "rt1019-aif"),
@@ -370,6 +454,12 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			links[i].init = acp_card_rt5682_init;
 			links[i].ops = &acp_card_rt5682_ops;
 		}
+		if (drv_data->hs_codec_id == RT5682S) {
+			links[i].codecs = rt5682s;
+			links[i].num_codecs = ARRAY_SIZE(rt5682s);
+			links[i].init = acp_card_rt5682s_init;
+			links[i].ops = &acp_card_rt5682s_ops;
+		}
 		i++;
 	}
 
@@ -462,6 +552,12 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 			links[i].init = acp_card_rt5682_init;
 			links[i].ops = &acp_card_rt5682_ops;
 		}
+		if (drv_data->hs_codec_id == RT5682S) {
+			links[i].codecs = rt5682s;
+			links[i].num_codecs = ARRAY_SIZE(rt5682s);
+			links[i].init = acp_card_rt5682s_init;
+			links[i].ops = &acp_card_rt5682s_ops;
+		}
 		i++;
 	}
 
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index b6a43d1b9ad4..5dc47cfbff10 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -36,6 +36,7 @@ enum codec_endpoints {
 	RT5682,
 	RT1019,
 	MAX98360A,
+	RT5682S,
 };
 
 struct acp_card_drvdata {
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index f7103beedf32..854eb7214cea 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -38,6 +38,15 @@ static struct acp_card_drvdata sof_rt5682_max_data = {
 	.dmic_codec_id = DMIC,
 };
 
+static struct acp_card_drvdata sof_rt5682s_max_data = {
+	.hs_cpu_id = I2S_SP,
+	.amp_cpu_id = I2S_SP,
+	.dmic_cpu_id = DMIC,
+	.hs_codec_id = RT5682S,
+	.amp_codec_id = MAX98360A,
+	.dmic_codec_id = DMIC,
+};
+
 static const struct snd_kcontrol_new acp_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -98,6 +107,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "rt5682-max",
 		.driver_data = (kernel_ulong_t)&sof_rt5682_max_data
 	},
+	{
+		.name = "rt5682s-max",
+		.driver_data = (kernel_ulong_t)&sof_rt5682s_max_data
+	},
 	{ }
 };
 static struct platform_driver acp_asoc_audio = {
@@ -114,4 +127,5 @@ MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
 MODULE_DESCRIPTION("ACP chrome SOF audio support");
 MODULE_ALIAS("platform:rt5682-rt1019");
 MODULE_ALIAS("platform:rt5682-max");
+MODULE_ALIAS("platform:rt5682s-max");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

