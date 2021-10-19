Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B839432F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhJSHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:14:22 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:56172
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234459AbhJSHOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:14:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+ARX6M5sEuogNvITIEtpeYMKHMR4n98/4b5hvywZQ8rsPTMT3D15BETtiLdcgareiOXO+EFbp2B+wviFcbrkgbrGNbJJ1Y8bSu8hpPWr6ETLDVxTR4qLqT5jSMv8X1hEn1ynvWKkGX74CUdiVsScqK2IyAFZkdeWNqiNHUMaXBUl1ilDVY0NGJdBLYqPUYWKnXwhHnhYN9gaYlewwJnC4oHY5DLOGWgULOhF/puwL0yHL2k/t1Ce2gier7BrkU+Rwgux58f4Mgt9EvsY2VTefh846mm0xVfOQi3A2/+OMPDu1o0v20JjF4Vcb8BHucRGjs/VIFN571qgHm7M7tjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftGyyL3PecV/TPBE3PD9zqfydQGmDNfhecaBwh4KBG8=;
 b=nhjSid45hKoASdSMQxNGhbJcbZHko6egxgTJXUi3HDCnMf83m31ZAwOzq1p7t4zuDAh5TYCXDvP4YTno7naYYsetYcmGiLeDjN4KBIR6oqFoXcKl+Bk86BM2RXwpvP5BJRuB6M75mqPO5T6iYuuF6ItkR6ymrO7jMUNkMpu1mMkPO7MPf5ZpcjQg1Aj2HwRXhoDtbybORr2YfgBpAZv5JX51OvFLwsQI3CMTKqfkTLxzar5BK2yo+QTg4A8THWskFnBmAVLx5+xtkSlB3j6bG3WGyag+c5jnDurQHKQI6hvFhwTCZYPZy8SGTl3mMcYtoK2DBoVPaSpiXyDWEMIGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftGyyL3PecV/TPBE3PD9zqfydQGmDNfhecaBwh4KBG8=;
 b=44G40rdbzow96vAbqoB9QNvj5Qiip7VgfpTUbM1rqEq2qJ7S1OvhIGw2H77YNKnTFng9SE/r2o6c3juYbDWymhxlHiVGKj+xsICgQP8w9o0ZRphSFFTXA1Oiw4bBxvUdR461PJ6sZYakKVg6SRM54GVj1TXIDR+0+EeM/pUsyvg=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Tue, 19 Oct
 2021 07:12:04 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::5f) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 19 Oct 2021 07:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 07:12:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 02:12:03 -0500
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Tue, 19 Oct 2021 02:11:59 -0500
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/8] ASoC: amd: acp: Add support for Maxim amplifier codec
Date:   Tue, 19 Oct 2021 12:39:37 +0530
Message-ID: <20211019070938.5076-8-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
References: <20211019070938.5076-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2549875-08c9-49a7-e093-08d992cfc122
X-MS-TrafficTypeDiagnostic: BL1PR12MB5157:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5157F9B8EC4E61D4C34D0BB082BD9@BL1PR12MB5157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c05ji7p3CwjQac1tKtLGFVDUjQ3c4bin4UnMWrN/d1Q7O7L3qVdAcIV+pQM9U0ILgw+7F2IymxaLzM3y4pIhM7dGP7bjw2VIXl09duqGncNBfsA0tOFTNDA3PTS7PrevM/uMx/6jhuj2Mt23+vzkzWqVvd+PNLdr5Y9RVRa3Bp0BKixlM0oZKtb0ccCi8vy4IQkXAzkZS157orqYG8NA6Wn0Z7KFhHFv0P0ez39i4FlObz3cRn2rcg2m6YxghriFKaXPGe7uNoJMFxNrGQ5ebxdlt+QO0DiMwhJdz1E0Ae9lzdqv+k09laJy5yY6xLEvezXK7bkE0Y2qummxRkBtrZo/1bIBjzhXeimFIIovJHVRJz9xAMtzf4HoL2oddyr/ISv+MzALCGERhcCvJVZKA/6aBYW5Tk/G3sgahRw/ACXQYfBrsN7jyFvUMXAZ7KlG3wXSXCxeXMYcA1bmETx6NcWPP9AZk1ErBOX4qSCAwJCEdRDdC+a2UGKdvJTSaz1opxLrOe1pzm5WD18YryWEwzmeO9OQdJ/Ta06ikYGfJYPbLPcABFRMUK1YboMPN8cQhljPzEcGpPG1Iu7IlZ41PqOSwOFTyI2ftTgrJLHZm11VkQhqM86xogYRH5Ef2Py/Mo1aZ15C765pRRYksKkG9BFadND24ubgc/EaC1AAJz+Csfs7xfGsWjpffVhIF75iXmSD/Lmk2m/VqlOOIlk0wT4oXB2wJco9R6gP6CHaXyw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(36756003)(8676002)(81166007)(47076005)(82310400003)(316002)(5660300002)(2616005)(508600001)(26005)(6666004)(110136005)(70586007)(186003)(356005)(4326008)(7696005)(336012)(2906002)(54906003)(8936002)(1076003)(426003)(86362001)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 07:12:04.5011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2549875-08c9-49a7-e093-08d992cfc122
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newer chrome boards we have max98360a as an amplifier codec.
Add support for max98360a in generic machine driver and configure
driver data to enable SOF sound card support on newer boards .

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
---
 sound/soc/amd/acp/Kconfig           |  1 +
 sound/soc/amd/acp/acp-mach-common.c | 37 +++++++++++++++++++++++++++++
 sound/soc/amd/acp/acp-mach.h        |  1 +
 sound/soc/amd/acp/acp-sof-mach.c    | 14 +++++++++++
 4 files changed, 53 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index f03af79de592..ef4208c3e7b7 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -32,6 +32,7 @@ config SND_SOC_AMD_MACH_COMMON
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_DMIC
 	select SND_SOC_RT1019
+	select SND_SOC_MAX98357A
 	depends on X86 && PCI && I2C
 	help
 	  This option enables common Machine driver module for ACP.
diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 76300dc6ad4e..24d1075eb62e 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -274,6 +274,31 @@ static const struct snd_soc_ops acp_card_rt1019_ops = {
 	.hw_params = acp_card_rt1019_hw_params,
 };
 
+/* Declare Maxim codec components */
+SND_SOC_DAILINK_DEF(max98360a,
+	DAILINK_COMP_ARRAY(COMP_CODEC("MX98360A:00", "HiFi")));
+
+static const struct snd_soc_dapm_route max98360a_map[] = {
+	{"Spk", NULL, "Speaker"},
+};
+
+static int acp_card_maxim_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct acp_card_drvdata *drvdata = card->drvdata;
+
+	if (drvdata->amp_codec_id != MAX98360A)
+		return -EINVAL;
+
+	return snd_soc_dapm_add_routes(&rtd->card->dapm, max98360a_map,
+				       ARRAY_SIZE(max98360a_map));
+}
+
+static const struct snd_soc_ops acp_card_maxim_ops = {
+	.startup = acp_card_amp_startup,
+	.shutdown = acp_card_shutdown,
+};
+
 /* Declare DMIC codec components */
 SND_SOC_DAILINK_DEF(dmic_codec,
 		DAILINK_COMP_ARRAY(COMP_CODEC("dmic-codec", "dmic-hifi")));
@@ -371,6 +396,12 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 			card->codec_conf = rt1019_conf;
 			card->num_configs = ARRAY_SIZE(rt1019_conf);
 		}
+		if (drv_data->amp_codec_id == MAX98360A) {
+			links[i].codecs = max98360a;
+			links[i].num_codecs = ARRAY_SIZE(max98360a);
+			links[i].ops = &acp_card_maxim_ops;
+			links[i].init = acp_card_maxim_init;
+		}
 		i++;
 	}
 
@@ -455,6 +486,12 @@ int acp_legacy_dai_links_create(struct snd_soc_card *card)
 			card->codec_conf = rt1019_conf;
 			card->num_configs = ARRAY_SIZE(rt1019_conf);
 		}
+		if (drv_data->amp_codec_id == MAX98360A) {
+			links[i].codecs = max98360a;
+			links[i].num_codecs = ARRAY_SIZE(max98360a);
+			links[i].ops = &acp_card_maxim_ops;
+			links[i].init = acp_card_maxim_init;
+		}
 	}
 
 	card->dai_link = links;
diff --git a/sound/soc/amd/acp/acp-mach.h b/sound/soc/amd/acp/acp-mach.h
index 464fb7eb802d..b6a43d1b9ad4 100644
--- a/sound/soc/amd/acp/acp-mach.h
+++ b/sound/soc/amd/acp/acp-mach.h
@@ -35,6 +35,7 @@ enum codec_endpoints {
 	DUMMY = 0,
 	RT5682,
 	RT1019,
+	MAX98360A,
 };
 
 struct acp_card_drvdata {
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index e143aa24afb3..f7103beedf32 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -29,6 +29,15 @@ static struct acp_card_drvdata sof_rt5682_rt1019_data = {
 	.dmic_codec_id = DMIC,
 };
 
+static struct acp_card_drvdata sof_rt5682_max_data = {
+	.hs_cpu_id = I2S_SP,
+	.amp_cpu_id = I2S_SP,
+	.dmic_cpu_id = DMIC,
+	.hs_codec_id = RT5682,
+	.amp_codec_id = MAX98360A,
+	.dmic_codec_id = DMIC,
+};
+
 static const struct snd_kcontrol_new acp_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -85,6 +94,10 @@ static const struct platform_device_id board_ids[] = {
 		.name = "rt5682-rt1019",
 		.driver_data = (kernel_ulong_t)&sof_rt5682_rt1019_data
 	},
+	{
+		.name = "rt5682-max",
+		.driver_data = (kernel_ulong_t)&sof_rt5682_max_data
+	},
 	{ }
 };
 static struct platform_driver acp_asoc_audio = {
@@ -100,4 +113,5 @@ module_platform_driver(acp_asoc_audio);
 MODULE_IMPORT_NS(SND_SOC_AMD_MACH);
 MODULE_DESCRIPTION("ACP chrome SOF audio support");
 MODULE_ALIAS("platform:rt5682-rt1019");
+MODULE_ALIAS("platform:rt5682-max");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

