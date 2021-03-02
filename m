Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD3E32ABC3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837216AbhCBUmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:42:12 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:65178 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1574631AbhCBRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H1q3K022910;
        Tue, 2 Mar 2021 11:05:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uEj5ZIOlpg1j1E+0wNPoMN6JX9ZzpCiLBva1l5WJfi0=;
 b=LgqRDF7oP0vY9IddZ4OOK3xwpsATiNz5htV3JAu70ewNljcCFVwcFZBTOrT35xVX47DM
 XCIXFJ1GDj2FRMM50+UgnredR9Tvf8i/Ud+6u8piwBlYNzZkC2E+phWWVz+m0zZw4tCR
 XeApij4CgVvRoBoEbkzW/UuYKMWzE/c3BN0M+XH9l7g06IF9fQPMQAJWcR++fVpVP8ZK
 pC9HdbmuDZbiNnQ4uS1Cq7hlbMBJdMxgKdjdAD8uZuch3gdG4bvFJkSoz+C+87F2syio
 MaoY/BzNuT31q5tihogCaCFOgXVMSixysZF/qAd47Gt3UcawizpvJq2oBBwqIVZt3jAi IA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg9-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 11:05:03 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:05:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:05:00 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8DB4411D6;
        Tue,  2 Mar 2021 17:05:00 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/15] ASoC: cs42l42: Provide finer control on playback path
Date:   Tue, 2 Mar 2021 17:04:45 +0000
Message-ID: <20210302170454.39679-7-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=773 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing cs42l42_hpdrv_evt that enables the entire chain and replace by
a set of widgets that can better define the codec

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 65 +++++++++++++-------------------------
 sound/soc/codecs/cs42l42.h |  8 ++---
 2 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 834b702fe4297..663a6a8104171 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -461,54 +461,33 @@ static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 				0x3e, 1, mixer_tlv)
 };
 
-static int cs42l42_hpdrv_evt(struct snd_soc_dapm_widget *w,
-				struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-
-	if (event & SND_SOC_DAPM_POST_PMU) {
-		/* Enable the channels */
-		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_EN,
-				CS42L42_ASP_RX0_CH_EN_MASK,
-				(CS42L42_ASP_RX0_CH1_EN |
-				CS42L42_ASP_RX0_CH2_EN) <<
-				CS42L42_ASP_RX0_CH_EN_SHIFT);
-
-		/* Power up */
-		snd_soc_component_update_bits(component, CS42L42_PWR_CTL1,
-			CS42L42_ASP_DAI_PDN_MASK | CS42L42_MIXER_PDN_MASK |
-				CS42L42_HP_PDN_MASK, 0);
-	} else if (event & SND_SOC_DAPM_PRE_PMD) {
-		/* Disable the channels */
-		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_EN,
-				CS42L42_ASP_RX0_CH_EN_MASK, 0);
-
-		/* Power down */
-		snd_soc_component_update_bits(component, CS42L42_PWR_CTL1,
-			CS42L42_ASP_DAI_PDN_MASK | CS42L42_MIXER_PDN_MASK |
-				CS42L42_HP_PDN_MASK,
-			CS42L42_ASP_DAI_PDN_MASK | CS42L42_MIXER_PDN_MASK |
-				CS42L42_HP_PDN_MASK);
-	} else {
-		dev_err(component->dev, "Invalid event 0x%x\n", event);
-	}
-	return 0;
-}
-
 static const struct snd_soc_dapm_widget cs42l42_dapm_widgets[] = {
+	/* Playback Path */
 	SND_SOC_DAPM_OUTPUT("HP"),
-	SND_SOC_DAPM_AIF_IN("SDIN", NULL, 0, CS42L42_ASP_CLK_CFG,
-					CS42L42_ASP_SCLK_EN_SHIFT, false),
-	SND_SOC_DAPM_OUT_DRV_E("HPDRV", SND_SOC_NOPM, 0,
-					0, NULL, 0, cs42l42_hpdrv_evt,
-					SND_SOC_DAPM_POST_PMU |
-					SND_SOC_DAPM_PRE_PMD)
+	SND_SOC_DAPM_DAC("DAC", NULL, CS42L42_PWR_CTL1, CS42L42_HP_PDN_SHIFT, 1),
+	SND_SOC_DAPM_MIXER("MIXER", CS42L42_PWR_CTL1, CS42L42_MIXER_PDN_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_AIF_IN("SDIN1", NULL, 0, CS42L42_ASP_RX_DAI0_EN, CS42L42_ASP_RX0_CH1_SHIFT, 0),
+	SND_SOC_DAPM_AIF_IN("SDIN2", NULL, 1, CS42L42_ASP_RX_DAI0_EN, CS42L42_ASP_RX0_CH2_SHIFT, 0),
+
+	/* Playback Requirements */
+	SND_SOC_DAPM_SUPPLY("ASP DAI0", CS42L42_PWR_CTL1, CS42L42_ASP_DAI_PDN_SHIFT, 1, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("SCLK", CS42L42_ASP_CLK_CFG, CS42L42_ASP_SCLK_EN_SHIFT, 0, NULL, 0),
 };
 
 static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
-	{"SDIN", NULL, "Playback"},
-	{"HPDRV", NULL, "SDIN"},
-	{"HP", NULL, "HPDRV"}
+	/* Playback Path */
+	{"HP", NULL, "DAC"},
+	{"DAC", NULL, "MIXER"},
+	{"MIXER", NULL, "SDIN1"},
+	{"MIXER", NULL, "SDIN2"},
+	{"SDIN1", NULL, "Playback"},
+	{"SDIN2", NULL, "Playback"},
+
+	/* Playback Requirements */
+	{"SDIN1", NULL, "ASP DAI0"},
+	{"SDIN2", NULL, "ASP DAI0"},
+	{"SDIN1", NULL, "SCLK"},
+	{"SDIN2", NULL, "SCLK"},
 };
 
 static int cs42l42_component_probe(struct snd_soc_component *component)
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 2bd370b184e1d..e17a0c0aeb4a0 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -695,10 +695,10 @@
 #define CS42L42_ASP_RX_DAI0_EN		(CS42L42_PAGE_2A + 0x01)
 #define CS42L42_ASP_RX0_CH_EN_SHIFT	2
 #define CS42L42_ASP_RX0_CH_EN_MASK	(0xf << CS42L42_ASP_RX0_CH_EN_SHIFT)
-#define CS42L42_ASP_RX0_CH1_EN		1
-#define CS42L42_ASP_RX0_CH2_EN		2
-#define CS42L42_ASP_RX0_CH3_EN		4
-#define CS42L42_ASP_RX0_CH4_EN		8
+#define CS42L42_ASP_RX0_CH1_SHIFT	2
+#define CS42L42_ASP_RX0_CH2_SHIFT	3
+#define CS42L42_ASP_RX0_CH3_SHIFT	4
+#define CS42L42_ASP_RX0_CH4_SHIFT	5
 
 #define CS42L42_ASP_RX_DAI0_CH1_AP_RES	(CS42L42_PAGE_2A + 0x02)
 #define CS42L42_ASP_RX_DAI0_CH1_BIT_MSB	(CS42L42_PAGE_2A + 0x03)
-- 
2.30.1

