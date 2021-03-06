Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D432FCA3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCFTOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:14:10 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:5848 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231384AbhCFTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:13:50 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126J6uDM011401;
        Sat, 6 Mar 2021 13:13:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=GhCZ2IdCR0m7XygpXNZIE3zrPdmkyVmrVraAQi3LVEY=;
 b=mr8s3b9a4B/nwiuG5nv/XNguSoxpoQv2ejbKaTAH3UTlBKpGDzeqTuGwbeZdCsyD0jO2
 QvuPB1mSKtQISx2N0KRTWUdAU2m8We59osOKFTMC7hIIvAdOHac7YbtC6EiJmkPEjMB3
 hZwpPnwqVxVkjDbNCh77Kny2YyMEdwVT7zkh9rMRM+pIk5TKV/AugBX0TKmF65fvKHnN
 EdwseuOLWhtNdHVnso46ccWU9QBS7+SPNFOOKNUiG9lyjPtwg/2uIws7XsIpsbBqCMVT
 MTxxE2pACrwW+K8WWK0BF2Qjed6J5PL9ohEi+S72faJULJvSNKPQ7413ehOZ7EOe6Qy8 FA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748198d06-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 13:13:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:28 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:28 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 730CD11D7;
        Sat,  6 Mar 2021 18:56:28 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 10/15] ASoC: cs42l42: Add Capture Support
Date:   Sat, 6 Mar 2021 18:55:48 +0000
Message-ID: <20210306185553.62053-11-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
References: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103060119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for capture path on headseat pins

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v3:
- No changes

Changes in v2:
- No changes

 sound/soc/codecs/cs42l42.c | 39 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/cs42l42.h | 12 ++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2dca55dfa46d7..b5084681aaab2 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -472,6 +472,18 @@ static const struct snd_soc_dapm_widget cs42l42_dapm_widgets[] = {
 
 	/* Playback Requirements */
 	SND_SOC_DAPM_SUPPLY("ASP DAI0", CS42L42_PWR_CTL1, CS42L42_ASP_DAI_PDN_SHIFT, 1, NULL, 0),
+
+	/* Capture Path */
+	SND_SOC_DAPM_INPUT("HS"),
+	SND_SOC_DAPM_ADC("ADC", NULL, CS42L42_PWR_CTL1, CS42L42_ADC_PDN_SHIFT, 1),
+	SND_SOC_DAPM_AIF_OUT("SDOUT1", NULL, 0, CS42L42_ASP_TX_CH_EN, CS42L42_ASP_TX0_CH1_SHIFT, 0),
+	SND_SOC_DAPM_AIF_OUT("SDOUT2", NULL, 1, CS42L42_ASP_TX_CH_EN, CS42L42_ASP_TX0_CH2_SHIFT, 0),
+
+	/* Capture Requirements */
+	SND_SOC_DAPM_SUPPLY("ASP DAO0", CS42L42_PWR_CTL1, CS42L42_ASP_DAO_PDN_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("ASP TX EN", CS42L42_ASP_TX_SZ_EN, CS42L42_ASP_TX_EN_SHIFT, 0, NULL, 0),
+
+	/* Playback/Capture Requirements */
 	SND_SOC_DAPM_SUPPLY("SCLK", CS42L42_ASP_CLK_CFG, CS42L42_ASP_SCLK_EN_SHIFT, 0, NULL, 0),
 };
 
@@ -489,6 +501,21 @@ static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
 	{"SDIN2", NULL, "ASP DAI0"},
 	{"SDIN1", NULL, "SCLK"},
 	{"SDIN2", NULL, "SCLK"},
+
+	/* Capture Path */
+	{"ADC", NULL, "HS"},
+	{ "SDOUT1", NULL, "ADC" },
+	{ "SDOUT2", NULL, "ADC" },
+	{ "Capture", NULL, "SDOUT1" },
+	{ "Capture", NULL, "SDOUT2" },
+
+	/* Capture Requirements */
+	{ "SDOUT1", NULL, "ASP DAO0" },
+	{ "SDOUT2", NULL, "ASP DAO0" },
+	{ "SDOUT1", NULL, "SCLK" },
+	{ "SDOUT2", NULL, "SCLK" },
+	{ "SDOUT1", NULL, "ASP TX EN" },
+	{ "SDOUT2", NULL, "ASP TX EN" },
 };
 
 static int cs42l42_component_probe(struct snd_soc_component *component)
@@ -748,12 +775,24 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+	unsigned int channels = params_channels(params);
 	unsigned int width = (params_width(params) / 8) - 1;
 	unsigned int val = 0;
 
 	cs42l42->srate = params_rate(params);
 
 	switch(substream->stream) {
+	case SNDRV_PCM_STREAM_CAPTURE:
+		if (channels == 2) {
+			val |= CS42L42_ASP_TX_CH2_AP_MASK;
+			val |= width << CS42L42_ASP_TX_CH2_RES_SHIFT;
+		}
+		val |= width << CS42L42_ASP_TX_CH1_RES_SHIFT;
+
+		snd_soc_component_update_bits(component, CS42L42_ASP_TX_CH_AP_RES,
+				CS42L42_ASP_TX_CH1_AP_MASK | CS42L42_ASP_TX_CH2_AP_MASK |
+				CS42L42_ASP_TX_CH2_RES_MASK | CS42L42_ASP_TX_CH1_RES_MASK, val);
+		break;
 	case SNDRV_PCM_STREAM_PLAYBACK:
 		val |= width << CS42L42_ASP_RX_CH_RES_SHIFT;
 		/* channel 1 on low LRCLK */
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 3dcbfebc53b0f..c373259ed46f7 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -683,8 +683,20 @@
 
 /* Page 0x29 Serial Port TX Registers */
 #define CS42L42_ASP_TX_SZ_EN		(CS42L42_PAGE_29 + 0x01)
+#define CS42L42_ASP_TX_EN_SHIFT		0
 #define CS42L42_ASP_TX_CH_EN		(CS42L42_PAGE_29 + 0x02)
+#define CS42L42_ASP_TX0_CH2_SHIFT	1
+#define CS42L42_ASP_TX0_CH1_SHIFT	0
+
 #define CS42L42_ASP_TX_CH_AP_RES	(CS42L42_PAGE_29 + 0x03)
+#define CS42L42_ASP_TX_CH1_AP_SHIFT	7
+#define CS42L42_ASP_TX_CH1_AP_MASK	(1 << CS42L42_ASP_TX_CH1_AP_SHIFT)
+#define CS42L42_ASP_TX_CH2_AP_SHIFT	6
+#define CS42L42_ASP_TX_CH2_AP_MASK	(1 << CS42L42_ASP_TX_CH2_AP_SHIFT)
+#define CS42L42_ASP_TX_CH2_RES_SHIFT	2
+#define CS42L42_ASP_TX_CH2_RES_MASK	(3 << CS42L42_ASP_TX_CH2_RES_SHIFT)
+#define CS42L42_ASP_TX_CH1_RES_SHIFT	0
+#define CS42L42_ASP_TX_CH1_RES_MASK	(3 << CS42L42_ASP_TX_CH1_RES_SHIFT)
 #define CS42L42_ASP_TX_CH1_BIT_MSB	(CS42L42_PAGE_29 + 0x04)
 #define CS42L42_ASP_TX_CH1_BIT_LSB	(CS42L42_PAGE_29 + 0x05)
 #define CS42L42_ASP_TX_HIZ_DLY_CFG	(CS42L42_PAGE_29 + 0x06)
-- 
2.30.1

