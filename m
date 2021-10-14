Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C3E42D362
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJNHUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:20:08 -0400
Received: from mail-dm6nam08on2064.outbound.protection.outlook.com ([40.107.102.64]:15871
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230082AbhJNHUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:20:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/84RAWZhQ115XYLuy6wNHTQKnBmVN0CJaFb1jVheeJlWrh3gVTk+3lVyH1vEOlXuHQ7hvBqDomy3DS4FeeHEPnuSrBej/sX45qDBDiwn4BPflA30L9iN3bJu4ut649G/rRGVBDZRPmRQAfjQ3goH0fDMO8DYZKLDSTqs4EV/iaKcHPUaCbuBPGOWALIC5t030RdO2fdxNv9LFULXQgYkYXjNgll67Ud5SJf1d6gf2V5LKVxTNw9b7V2CV+uXEcnitTZcGZmHaQulWpUz24caHuLCFfmafMEYVVXyzkgBOwpYzvzynVygZeUXr+pQs2b06SCczAvlbRfgLRcujItpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOMZNelpWH97PJ78cIM1DIEaNJQaydddLJoznWNgG1k=;
 b=CHrAC429xu/N8VKjzi1gPbz4IewOH+ylRicTULXqTSlZKjvdHS4RejmLMQjFdp7eUBEeLQPB9qJcxUA3w6DiuSFfeUrUJYixUU4nwrg9NpdiF6TTa/GY/gb7E/09kPa9GyoV1un5w1tmkIz6Rqr8oF5aF7EKXI1d8wy4HVQl+UNzVZozItnYeU99bz1X8qOKtRZrMeBDq8OC6Hmzxe2bRsK/oViyXghf18cF3NlF+XNxdZpUYyf8VtEoSM00Ya2NF/ThsK8qVSRgiXqy1wJJwSWBxD/jq+HwYcuQSnTTGdAuWqprPWVga9XF1etZjbHsUxs/nS7pfCto7hgBA+N48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOMZNelpWH97PJ78cIM1DIEaNJQaydddLJoznWNgG1k=;
 b=DkBhO3jvSQ8nxxw73De9CcQ231LLQVG6NuvE0pMGkfN6RBl+zX2Eog/gyn78JVxwGJ053Ywjz+DmbL3ryW5P4i3DgWAdCgEMRk358lqp5n9vlJN88Ux/JtfMDizTydOK3yTydpOteZJuF6OUzr12TRmt0aMe3DCslXQVvLalOIk=
Received: from BN9P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::12)
 by BN8PR12MB3185.namprd12.prod.outlook.com (2603:10b6:408:9a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Thu, 14 Oct
 2021 07:18:00 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::85) by BN9P222CA0007.outlook.office365.com
 (2603:10b6:408:10c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 14 Oct 2021 07:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 07:17:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 02:17:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 00:17:58 -0700
Received: from vijendar-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Thu, 14 Oct 2021 02:17:55 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <wtli@nuvoton.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/3] ASoC: amd: add vangogh machine driver
Date:   Thu, 14 Oct 2021 12:47:09 +0530
Message-ID: <20211014071714.836410-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014071714.836410-1-Vijendar.Mukunda@amd.com>
References: <20211014071714.836410-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dc8c57b-c2a6-4440-a93a-08d98ee2c0dd
X-MS-TrafficTypeDiagnostic: BN8PR12MB3185:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3185C7A37C8B2A00F3B4B93097B89@BN8PR12MB3185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oss/B6Z3sS7uCQQ40jRR6u7H4e5KSngTaeVdCB4SLqRhIehEmV4JIvAZIBJeg3bsjJ10TtxlBSp4WfuL5zyhKk+WheupYIDk/LDwEvPubGF4fRbU8hRsdzC6mok3mCnuFlHpU2jp0CQ86vM5qa0N4P/OjPRtZihdLR6aZTI9KWv9xnCdGy4+oo+Xf7YBLj2SxJcSL4NKtiq2eN3e7oLr3UJPdSvVzW8MW1uYht1QV0LPTcT6XT4XkI3TzUDQIB99ZmucfNrA9aXYlSewvmwcd8TYlyvwbByTtp7ZsN5jj19IpBIksIjS5tjTJ2Kck3PlqEvJ5oB+i+1zIgSZiZ2WP/+iKdSTtq8QCX2jTLkcZEqQ7ZzJxl4czLwPv0RN7exydiyWpJXIjJmWDD7CtnaCJPUCl8T2H5my1mPGInZ+bZuqIxillkzC9fadPuX4O0IaHkpHpNTxjhm638W8cYSBw3QpWzIoiynpauB1QcGK8arV95CGmQ5Qnx3HeTYTejlDBwyauWRyoEmA/aWGa2xJDlnASM6QSxFh4jg5WZtVxXGs3kYzoILyWADzoTet7DvEWojKwwW+zCSe4NOZ5rIewsL/lp+Ki//oj9GZr0RTbOlCHbfX7X6sEwxP7qYYiZ/kOfUXxD5uCjC/JwGnUxsDTInwejquNbsskIfBlmapUR+vYIYs1Pov/tfdJxJlOMuIrOBl8cUIFNDkYAT9KEBxYSs6FLLwY0vqGlnyS9AHi18=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(70206006)(81166007)(110136005)(54906003)(82310400003)(336012)(508600001)(1076003)(7696005)(8676002)(316002)(356005)(70586007)(5660300002)(86362001)(4326008)(8936002)(2906002)(83380400001)(6666004)(30864003)(2616005)(47076005)(36860700001)(426003)(36756003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 07:17:59.8711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc8c57b-c2a6-4440-a93a-08d98ee2c0dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3185
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vangogh machine driver using NAU8821 & CS35L41 Codecs.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
changes since v1:
    - add DMI info check in machine driver probe
    - renamed machine driver file as "acp5x-mach.c"

 sound/soc/amd/vangogh/acp5x-mach.c | 386 +++++++++++++++++++++++++++++
 1 file changed, 386 insertions(+)
 create mode 100644 sound/soc/amd/vangogh/acp5x-mach.c

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
new file mode 100644
index 000000000000..14cf325e4b23
--- /dev/null
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Machine driver for AMD Vangogh platform using NAU8821 & CS35L41
+ * codecs.
+ *
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ */
+
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#include <sound/jack.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/acpi.h>
+#include <linux/dmi.h>
+
+#include "../../codecs/nau8821.h"
+#include "../../codecs/cs35l41.h"
+
+#include "acp5x.h"
+
+#define DRV_NAME "acp5x_mach"
+#define DUAL_CHANNEL		2
+#define ACP5X_NUVOTON_CODEC_DAI	"nau8821-hifi"
+#define VG_JUPITER 1
+
+static unsigned long acp5x_machine_id;
+static struct snd_soc_jack vg_headset;
+
+static struct snd_soc_jack_pin acp5x_nau8821_jack_pins[] = {
+	{
+		.pin	= "Headphone",
+		.mask	= SND_JACK_HEADPHONE,
+	},
+	{
+		.pin	= "Headset Mic",
+		.mask	= SND_JACK_MICROPHONE,
+	},
+};
+
+static int acp5x_8821_init(struct snd_soc_pcm_runtime *rtd)
+{
+	int ret;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_component *component =
+					asoc_rtd_to_codec(rtd, 0)->component;
+
+	/*
+	 * Headset buttons map to the google Reference headset.
+	 * These can be configured by userspace.
+	 */
+	ret = snd_soc_card_jack_new(card, "Headset Jack",
+				    SND_JACK_HEADSET | SND_JACK_BTN_0,
+				    &vg_headset, acp5x_nau8821_jack_pins,
+				    ARRAY_SIZE(acp5x_nau8821_jack_pins));
+	if (ret) {
+		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
+		return ret;
+	}
+
+	snd_jack_set_key(vg_headset.jack, SND_JACK_BTN_0, KEY_MEDIA);
+	nau8821_enable_jack_detect(component, &vg_headset);
+	return ret;
+}
+
+static int acp5x_cs35l41_init(struct snd_soc_pcm_runtime *rtd)
+{
+	return 0;
+}
+
+static const unsigned int rates[] = {
+	48000,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list  = rates,
+	.mask = 0,
+};
+
+static const unsigned int channels[] = {
+	2,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int acp5x_8821_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->play_i2s_instance = I2S_SP_INSTANCE;
+	machine->cap_i2s_instance = I2S_SP_INSTANCE;
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+	return 0;
+}
+
+static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai =
+			snd_soc_card_get_codec_dai(card,
+						   ACP5X_NUVOTON_CODEC_DAI);
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_FLL_BLK, 0,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		dev_err(card->dev, "can't set FS clock %d\n", ret);
+	ret = snd_soc_dai_set_pll(codec_dai, 0, 0, snd_soc_params_to_bclk(params),
+				  params_rate(params) * 256);
+	if (ret < 0)
+		dev_err(card->dev, "can't set FLL: %d\n", ret);
+
+	return ret;
+}
+
+static int acp5x_cs35l41_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(card);
+
+	machine->play_i2s_instance = I2S_HS_INSTANCE;
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+	return 0;
+}
+
+static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai;
+	int ret, i;
+	unsigned int num_codecs = rtd->num_codecs;
+	unsigned int bclk_val;
+
+	for (i = 0; i < num_codecs; i++) {
+		codec_dai = asoc_rtd_to_codec(rtd, i);
+		if ((strcmp(codec_dai->name, "spi-VLV1776:00") == 0) ||
+		    (strcmp(codec_dai->name, "spi-VLV1776:01") == 0)) {
+			switch (params_rate(params)) {
+			case 48000:
+				bclk_val = 1536000;
+				break;
+			default:
+				dev_err(card->dev, "Invalid Samplerate:0x%x\n",
+					params_rate(params));
+				return -EINVAL;
+			}
+			ret = snd_soc_component_set_sysclk(codec_dai->component,
+							   0, 0, bclk_val, SND_SOC_CLOCK_IN);
+			if (ret < 0) {
+				dev_err(card->dev, "failed to set sysclk for CS35l41 dai\n");
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_ops acp5x_8821_ops = {
+	.startup = acp5x_8821_startup,
+	.hw_params = acp5x_nau8821_hw_params,
+};
+
+static const struct snd_soc_ops acp5x_cs35l41_play_ops = {
+	.startup = acp5x_cs35l41_startup,
+	.hw_params = acp5x_cs35l41_hw_params,
+};
+
+static struct snd_soc_codec_conf cs35l41_conf[] = {
+	{
+		.dlc = COMP_CODEC_CONF("spi-VLV1776:00"),
+		.name_prefix = "Left",
+	},
+	{
+		.dlc = COMP_CODEC_CONF("spi-VLV1776:01"),
+		.name_prefix = "Right",
+	},
+};
+
+SND_SOC_DAILINK_DEF(acp5x_i2s,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.0")));
+
+SND_SOC_DAILINK_DEF(acp5x_bt,
+		    DAILINK_COMP_ARRAY(COMP_CPU("acp5x_i2s_playcap.1")));
+
+SND_SOC_DAILINK_DEF(nau8821,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("i2c-NVTN2020:00",
+						  "nau8821-hifi")));
+
+SND_SOC_DAILINK_DEF(cs35l41,
+		    DAILINK_COMP_ARRAY(COMP_CODEC("spi-VLV1776:00", "cs35l41-pcm"),
+				       COMP_CODEC("spi-VLV1776:01", "cs35l41-pcm")));
+
+SND_SOC_DAILINK_DEF(platform,
+		    DAILINK_COMP_ARRAY(COMP_PLATFORM("acp5x_i2s_dma.0")));
+
+static struct snd_soc_dai_link acp5x_dai[] = {
+	{
+		.name = "acp5x-8825-play",
+		.stream_name = "Playback/Capture",
+		.dai_fmt = SND_SOC_DAIFMT_I2S  | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &acp5x_8821_ops,
+		.init = acp5x_8821_init,
+		SND_SOC_DAILINK_REG(acp5x_i2s, nau8821, platform),
+	},
+	{
+		.name = "acp5x-CS35L41-Stereo",
+		.stream_name = "CS35L41 Stereo Playback",
+		.dai_fmt = SND_SOC_DAIFMT_I2S  | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		.playback_only = 1,
+		.ops = &acp5x_cs35l41_play_ops,
+		.init = acp5x_cs35l41_init,
+		SND_SOC_DAILINK_REG(acp5x_bt, cs35l41, platform),
+	},
+};
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *k, int  event)
+{
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+	int ret = 0;
+
+	codec_dai = snd_soc_card_get_codec_dai(card, ACP5X_NUVOTON_CODEC_DAI);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found\n");
+		return -EIO;
+	}
+
+	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		ret = snd_soc_dai_set_sysclk(codec_dai, NAU8821_CLK_INTERNAL,
+					     0, SND_SOC_CLOCK_IN);
+		if (ret < 0) {
+			dev_err(card->dev, "set sysclk err = %d\n", ret);
+			return -EIO;
+		}
+	}
+	return ret;
+}
+
+static const struct snd_kcontrol_new acp5x_8821_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Int Mic"),
+};
+
+static const struct snd_soc_dapm_widget acp5x_8821_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			    platform_clock_control, SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route acp5x_8821_audio_route[] = {
+	/* HP jack connectors - unknown if we have jack detection */
+	{ "Headphone", NULL, "HPOL" },
+	{ "Headphone", NULL, "HPOR" },
+	{ "MICL", NULL, "Headset Mic" },
+	{ "MICR", NULL, "Headset Mic" },
+	{ "DMIC", NULL, "Int Mic" },
+
+	{ "Headphone", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
+	{ "Int Mic", NULL, "Platform Clock" },
+};
+
+static struct snd_soc_card acp5x_card = {
+	.name = "acp5x",
+	.owner = THIS_MODULE,
+	.dai_link = acp5x_dai,
+	.num_links = ARRAY_SIZE(acp5x_dai),
+	.dapm_widgets = acp5x_8821_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(acp5x_8821_widgets),
+	.dapm_routes = acp5x_8821_audio_route,
+	.num_dapm_routes = ARRAY_SIZE(acp5x_8821_audio_route),
+	.codec_conf = cs35l41_conf,
+	.num_configs = ARRAY_SIZE(cs35l41_conf),
+	.controls = acp5x_8821_controls,
+	.num_controls = ARRAY_SIZE(acp5x_8821_controls),
+};
+
+
+static int acp5x_vg_quirk_cb(const struct dmi_system_id *id)
+{
+	acp5x_machine_id = VG_JUPITER;
+	return 1;
+}
+
+static const struct dmi_system_id acp5x_vg_quirk_table[] = {
+	{
+		.callback = acp5x_vg_quirk_cb,
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "Valve"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
+		}
+	},
+	{}
+};
+
+static int acp5x_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct acp5x_platform_info *machine;
+	struct snd_soc_card *card;
+
+	machine = devm_kzalloc(&pdev->dev, sizeof(struct acp5x_platform_info),
+			       GFP_KERNEL);
+	if (!machine)
+		return -ENOMEM;
+
+	dmi_check_system(acp5x_vg_quirk_table);
+	switch(acp5x_machine_id) {
+	case VG_JUPITER:
+		card = &acp5x_card;
+		acp5x_card.dev = &pdev->dev;
+		break;
+	default:
+		return -ENODEV;
+	}
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, machine);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret) {
+		return dev_err_probe(&pdev->dev, ret,
+				     "snd_soc_register_card(%s) failed\n",
+				     acp5x_card.name);
+	}
+	return 0;
+}
+
+static struct platform_driver acp5x_mach_driver = {
+	.driver = {
+		.name = "acp5x_mach",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = acp5x_probe,
+};
+
+module_platform_driver(acp5x_mach_driver);
+
+MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
+MODULE_DESCRIPTION("NAU8821 & CS35L41 audio support");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.25.1

