Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8177632FCA0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhCFTOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:14:07 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13462 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231382AbhCFTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:13:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126J6uDL011401;
        Sat, 6 Mar 2021 13:13:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=nakO/zX5na1E3iem2Q706KFktRjuUW8s7Qj0ntSinT4=;
 b=mkgkfX5Ujya5GEZ8wiZcS/tmT0fv8m25dYPc9QWTq2NPUmhrLg+QWXYjJ4BXK7b6FKRI
 8el2kwwF5qhU/2RrcPZZkkQYoTiXUv7NPPBQSFBJ/nREZCHmTunIrLchcrivveVJAZCW
 +OrftnOBlwETL2apFMfpmoCrnr2RXB8gIfeCM/ccTwB34icsiBs+R7nXn/phed+Ydfd8
 3r7z0NnEh+kZ6Wj3ew8FsB5Fo/LQW5hW9QdP5iobrI80jZEtxNVr8uWIUGjnJ9vdl4r5
 Vz8tVIZ8MvbWpezdlXytXAqmvGKyg/nx1qV8+8bhPNWQtEToWM/KXlSZIhDtqLcHh1fD jg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748198d06-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 13:13:33 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:28 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:28 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2D4B511CF;
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
Subject: [PATCH v3 09/15] ASoC: cs42l42: Set clock source for both ways of stream
Date:   Sat, 6 Mar 2021 18:55:47 +0000
Message-ID: <20210306185553.62053-10-tanureal@opensource.cirrus.com>
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

Move the enable/disable of clocks to cs42l42_mute_stream so the record
path also get clocks.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v3:
- No changes

Changes in v2:
- Add missing cs42l42_private struct pointer

 sound/soc/codecs/cs42l42.c | 86 +++++++++++++++++++++-----------------
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 0b5c8e4afff07..2dca55dfa46d7 100644
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

