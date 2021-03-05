Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9554932F150
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhCERf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:35:26 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:45778 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229818AbhCERfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:35:09 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125HWLWc005729;
        Fri, 5 Mar 2021 11:34:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=V92//usCAgPrYcOQlrA51IEqEqfTTrguEF7VyWvOWj8=;
 b=gkZWdUaAi5RqmGM72BxLWkmlTJldzfOgdjhGViZgS/ID6F7UapeYANnR43tlvn3i7gBJ
 sle0dm23FF7gnC1qnz5deo7fbuy9yeJyS30uSwvnngiXRhZqwvDRx+h+1bUotZJVCYvK
 zVxEI/iuoNBb36ZZqS8Z22RgWRm1XZFJTKVCA1igIQITuYq7yNBVo4uc5W1UN18/wCmZ
 RGdg9HZTHXO8F9fp85iGInf+MAY0AKUIjbtogPxYZatx8NHJdg8jVk9AES0KM7GX1tn8
 aNg2w3qOPZjLzErFFLgfNTI5VopUAZZdzHIG+qkdTiPzkLSt6uM0ssn9cznwkyyy2d6I ZA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc70eyn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 11:34:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 5 Mar 2021
 17:34:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 5 Mar 2021 17:34:48 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C94E711D8;
        Fri,  5 Mar 2021 17:34:47 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v2 09/15] ASoC: cs42l42: Set clock source for both ways of stream
Date:   Fri, 5 Mar 2021 17:34:36 +0000
Message-ID: <20210305173442.195740-10-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
References: <20210305173442.195740-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enable/disable of clocks to cs42l42_mute_stream so the record
path also get clocks.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v2:
- Add missing cs42l42_private struct pointer

 sound/soc/codecs/cs42l42.c | 86 +++++++++++++++++++++-----------------
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index cad623e73d0fd..774d81a1de1d8 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -784,52 +784,63 @@ static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int cs42l42_mute(struct snd_soc_dai *dai, int mute, int direction)
+static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_component *component = dai->component;
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int regval;
 	u8 fullScaleVol;
 
 	if (mute) {
-		/* Mark SCLK as not present to turn on the internal
-		 * oscillator.
-		 */
-		snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
-						CS42L42_SCLK_PRESENT_MASK, 0);
-
-		snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
-				CS42L42_PLL_START_MASK,
-				0 << CS42L42_PLL_START_SHIFT);
-
 		/* Mute the headphone */
-		snd_soc_component_update_bits(component, CS42L42_HP_CTL,
-				CS42L42_HP_ANA_AMUTE_MASK |
-				CS42L42_HP_ANA_BMUTE_MASK,
-				CS42L42_HP_ANA_AMUTE_MASK |
-				CS42L42_HP_ANA_BMUTE_MASK);
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+			snd_soc_component_update_bits(component, CS42L42_HP_CTL,
+						      CS42L42_HP_ANA_AMUTE_MASK |
+						      CS42L42_HP_ANA_BMUTE_MASK,
+						      CS42L42_HP_ANA_AMUTE_MASK |
+						      CS42L42_HP_ANA_BMUTE_MASK);
+
+		cs42l42->stream_use &= ~(1 << stream);
+		if(!cs42l42->stream_use) {
+			/*
+			 * Switch to the internal oscillator.
+			 * SCLK must remain running until after this clock switch.
+			 * Without a source of clock the I2C bus doesn't work.
+			 */
+			snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
+						      CS42L42_SCLK_PRESENT_MASK, 0);
+			snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
+						      CS42L42_PLL_START_MASK, 0);
+		}
 	} else {
-		snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
-				CS42L42_PLL_START_MASK,
-				1 << CS42L42_PLL_START_SHIFT);
-		/* Read the headphone load */
-		regval = snd_soc_component_read(component, CS42L42_LOAD_DET_RCSTAT);
-		if (((regval & CS42L42_RLA_STAT_MASK) >>
-			CS42L42_RLA_STAT_SHIFT) == CS42L42_RLA_STAT_15_OHM) {
-			fullScaleVol = CS42L42_HP_FULL_SCALE_VOL_MASK;
-		} else {
-			fullScaleVol = 0;
+		if (!cs42l42->stream_use) {
+			/* SCLK must be running before codec unmute */
+			snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
+						      CS42L42_PLL_START_MASK, 1);
+
+			/* Mark SCLK as present, turn off internal oscillator */
+			snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
+						      CS42L42_SCLK_PRESENT_MASK,
+						      CS42L42_SCLK_PRESENT_MASK);
 		}
+		cs42l42->stream_use |= 1 << stream;
+
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* Read the headphone load */
+			regval = snd_soc_component_read(component, CS42L42_LOAD_DET_RCSTAT);
+			if (((regval & CS42L42_RLA_STAT_MASK) >> CS42L42_RLA_STAT_SHIFT) ==
+			    CS42L42_RLA_STAT_15_OHM) {
+				fullScaleVol = CS42L42_HP_FULL_SCALE_VOL_MASK;
+			} else {
+				fullScaleVol = 0;
+			}
 
-		/* Un-mute the headphone, set the full scale volume flag */
-		snd_soc_component_update_bits(component, CS42L42_HP_CTL,
-				CS42L42_HP_ANA_AMUTE_MASK |
-				CS42L42_HP_ANA_BMUTE_MASK |
-				CS42L42_HP_FULL_SCALE_VOL_MASK, fullScaleVol);
-
-		/* Mark SCLK as present, turn off internal oscillator */
-		snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
-				CS42L42_SCLK_PRESENT_MASK,
-				CS42L42_SCLK_PRESENT_MASK);
+			/* Un-mute the headphone, set the full scale volume flag */
+			snd_soc_component_update_bits(component, CS42L42_HP_CTL,
+						      CS42L42_HP_ANA_AMUTE_MASK |
+						      CS42L42_HP_ANA_BMUTE_MASK |
+						      CS42L42_HP_FULL_SCALE_VOL_MASK, fullScaleVol);
+		}
 	}
 
 	return 0;
@@ -844,8 +855,7 @@ static const struct snd_soc_dai_ops cs42l42_ops = {
 	.hw_params	= cs42l42_pcm_hw_params,
 	.set_fmt	= cs42l42_set_dai_fmt,
 	.set_sysclk	= cs42l42_set_sysclk,
-	.mute_stream	= cs42l42_mute,
-	.no_capture_mute = 1,
+	.mute_stream	= cs42l42_mute_stream,
 };
 
 static struct snd_soc_dai_driver cs42l42_dai = {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 4b448c102f538..3dcbfebc53b0f 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -768,6 +768,7 @@ struct  cs42l42_private {
 	u8 bias_thresholds[CS42L42_NUM_BIASES];
 	u8 hs_bias_ramp_rate;
 	u8 hs_bias_ramp_time;
+	u8 stream_use;
 };
 
 #endif /* __CS42L42_H__ */
-- 
2.30.1

