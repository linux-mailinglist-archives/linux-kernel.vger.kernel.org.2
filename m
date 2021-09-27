Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993E44192E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhI0LPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:15:43 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:10074 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234007AbhI0LPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:15:40 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18R5p08O014446;
        Mon, 27 Sep 2021 06:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=y7FDb5tsXHdq5KfvuRAGv3XZydF32Fn7d9iLWYmZ9mE=;
 b=m3/7vRc3skf+138yjIZ4WLt8aDL5rOLq/QZUiBoz6owUA7FakoaX+xRLGF2pAUgVhDPK
 gDfBBbkJWHe/tth7b0UQ/CwL7ZoemPMJxfEJymuqXtcnFST8bqB8Tn3aGb1yQKIMzn+9
 oEPX+J8rf8cdc4E9OR0OI0DqcRIHoWsuvE0MhFuExo9UQQdL2DX43+RzN0qeWnePWO9f
 x/MfdKzIK6YXY/L8KfjrZK1qR/YWs4NGKBv5coYiCbDhhBUpLtFIkmR/VX8h+iwwkdFq
 47pyHhgFIrkL9pJ/AjXbCCuppD/w9Cddg/SHC78cdszz3qaI8T5u4jymNl/TGfGfQUhN +Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3batd20sdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Sep 2021 06:13:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 27 Sep
 2021 12:13:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 27 Sep 2021 12:13:10 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.205])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5D46FB12;
        Mon, 27 Sep 2021 11:13:07 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Add HP Volume Scale control
Date:   Mon, 27 Sep 2021 12:12:44 +0100
Message-ID: <20210927111244.17906-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: vwx83s-uSV4hpjsv5PhIO0FCcYcH7zgm
X-Proofpoint-GUID: vwx83s-uSV4hpjsv5PhIO0FCcYcH7zgm
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

cs42l42 has a configurable scaling of the maximum volume. Add an
ALSA control for this. Note that the datasheet name is "full scale
volume" but this conflicts with ALSA naming convention so the control
is named "HP Volume Scale".

Before this change the FULL_SCALE_VOLUME was set based on the value in
RLA_STAT, but as there isn't any load detection result this always set
the scaling to -6dB instead of the default 0dB.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index d5e1e5228b5f..78f8c89410b6 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -425,6 +425,14 @@ static SOC_ENUM_SINGLE_DECL(cs42l42_wnf3_freq_enum, CS42L42_ADC_WNF_HPF_CTL,
 			    CS42L42_ADC_WNF_CF_SHIFT,
 			    cs42l42_wnf3_freq_text);
 
+static const char * const cs42l42_full_scale_vol_text[] = {
+	"0dB", "-6dB"
+};
+
+static SOC_ENUM_SINGLE_DECL(cs42l42_full_scale_vol_enum, CS42L42_HP_CTL,
+			    CS42L42_HP_FULL_SCALE_VOL_SHIFT,
+			    cs42l42_full_scale_vol_text);
+
 static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 	/* ADC Volume and Filter Controls */
 	SOC_SINGLE("ADC Notch Switch", CS42L42_ADC_CTL,
@@ -450,6 +458,7 @@ static const struct snd_kcontrol_new cs42l42_snd_controls[] = {
 				CS42L42_DACB_INV_SHIFT, true, false),
 	SOC_SINGLE("DAC HPF Switch", CS42L42_DAC_CTL2,
 				CS42L42_DAC_HPF_EN_SHIFT, true, false),
+	SOC_ENUM("HP Volume Scale", cs42l42_full_scale_vol_enum),
 	SOC_DOUBLE_R_TLV("Mixer Volume", CS42L42_MIXER_CHA_VOL,
 			 CS42L42_MIXER_CHB_VOL, CS42L42_MIXER_CH_VOL_SHIFT,
 				0x3f, 1, mixer_tlv)
@@ -922,7 +931,6 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int regval;
-	u8 fullScaleVol;
 	int ret;
 
 	if (mute) {
@@ -993,20 +1001,11 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 		cs42l42->stream_use |= 1 << stream;
 
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			/* Read the headphone load */
-			regval = snd_soc_component_read(component, CS42L42_LOAD_DET_RCSTAT);
-			if (((regval & CS42L42_RLA_STAT_MASK) >> CS42L42_RLA_STAT_SHIFT) ==
-			    CS42L42_RLA_STAT_15_OHM) {
-				fullScaleVol = CS42L42_HP_FULL_SCALE_VOL_MASK;
-			} else {
-				fullScaleVol = 0;
-			}
-
-			/* Un-mute the headphone, set the full scale volume flag */
+			/* Un-mute the headphone */
 			snd_soc_component_update_bits(component, CS42L42_HP_CTL,
 						      CS42L42_HP_ANA_AMUTE_MASK |
-						      CS42L42_HP_ANA_BMUTE_MASK |
-						      CS42L42_HP_FULL_SCALE_VOL_MASK, fullScaleVol);
+						      CS42L42_HP_ANA_BMUTE_MASK,
+						      0);
 		}
 	}
 
-- 
2.25.1

