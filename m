Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC742F3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhJONkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:40:00 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48534 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240042AbhJONio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:44 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t6023483;
        Fri, 15 Oct 2021 08:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=DtmrbVEDj8YC1fje3yFmaYOH8ysvv0F8w7e6MfV9Rzo=;
 b=P5yZcoTopoTZIGDoVrYaezTgfodH76Zbl/yUr7YbcxiDfURmmXQaohBtOR5Au31RbmNM
 LaeSLKdZT4T702rjHY/KBJlZMMSj5q2bubg621zlZCFHMV5wCIeUwjZmjNZY/dkJa3FZ
 lGB2rcDku6ZZt+YsZTEanRDs68efRH+B5TyVBjOTc25L7amuWh/JtgQNtltA3LoLfiPC
 Nn5IHfF+V2RgN8Vfr+Iy9B36hkqo64gJtj+Kuq8Ci+WXhxu1XRyl8NuNYyLTvOVV0ke9
 /rFH060OOxvRMGF6MzydEz3JpHNzd0AUa1atAF3n8fuir6N5Af4F+9gernTPiGma4FhC Sg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:29 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:25 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:25 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5970111DC;
        Fri, 15 Oct 2021 13:36:25 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 13/16] ASoC: cs42l42: Set correct SRC MCLK
Date:   Fri, 15 Oct 2021 14:36:16 +0100
Message-ID: <20211015133619.4698-14-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ttAWipDQqKL27igCEkVf4C_OTk-ubBdC
X-Proofpoint-GUID: ttAWipDQqKL27igCEkVf4C_OTk-ubBdC
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet the SRC MCLK must be as near as possible to
(125 * sample rate). This means it should be ~6MHz for rates up to 48k
and ~12MHz for rates above that. As per datasheet table 4-21.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 58 ++++++++++++++++++++++++++++++++--------------
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 54b4bc391ee9..05b8ae62b20d 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -668,22 +668,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					CS42L42_FSYNC_PULSE_WIDTH_MASK,
 					CS42L42_FRAC1_VAL(fsync - 1) <<
 					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
-			/* Set the sample rates (96k or lower) */
-			snd_soc_component_update_bits(component, CS42L42_FS_RATE_EN,
-					CS42L42_FS_EN_MASK,
-					(CS42L42_FS_EN_IASRC_96K |
-					CS42L42_FS_EN_OASRC_96K) <<
-					CS42L42_FS_EN_SHIFT);
-			/* Set the input/output internal MCLK clock ~12 MHz */
-			snd_soc_component_update_bits(component, CS42L42_IN_ASRC_CLK,
-					CS42L42_CLK_IASRC_SEL_MASK,
-					CS42L42_CLK_IASRC_SEL_12 <<
-					CS42L42_CLK_IASRC_SEL_SHIFT);
-			snd_soc_component_update_bits(component,
-					CS42L42_OUT_ASRC_CLK,
-					CS42L42_CLK_OASRC_SEL_MASK,
-					CS42L42_CLK_OASRC_SEL_12 <<
-					CS42L42_CLK_OASRC_SEL_SHIFT);
 			if (pll_ratio_table[i].mclk_src_sel == 0) {
 				/* Pass the clock straight through */
 				snd_soc_component_update_bits(component,
@@ -746,6 +730,39 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 	return -EINVAL;
 }
 
+static void cs42l42_src_config(struct snd_soc_component *component, unsigned int sample_rate)
+{
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+	unsigned int fs;
+
+	/* Don't reconfigure if there is an audio stream running */
+	if (cs42l42->stream_use)
+		return;
+
+	/* SRC MCLK must be as close as possible to 125 * sample rate */
+	if (sample_rate <= 48000)
+		fs = CS42L42_CLK_IASRC_SEL_6;
+	else
+		fs = CS42L42_CLK_IASRC_SEL_12;
+
+	/* Set the sample rates (96k or lower) */
+	snd_soc_component_update_bits(component,
+				      CS42L42_FS_RATE_EN,
+				      CS42L42_FS_EN_MASK,
+				      (CS42L42_FS_EN_IASRC_96K |
+				       CS42L42_FS_EN_OASRC_96K) <<
+				      CS42L42_FS_EN_SHIFT);
+
+	snd_soc_component_update_bits(component,
+				      CS42L42_IN_ASRC_CLK,
+				      CS42L42_CLK_IASRC_SEL_MASK,
+				      fs << CS42L42_CLK_IASRC_SEL_SHIFT);
+	snd_soc_component_update_bits(component,
+				      CS42L42_OUT_ASRC_CLK,
+				      CS42L42_CLK_OASRC_SEL_MASK,
+				      fs << CS42L42_CLK_OASRC_SEL_SHIFT);
+}
+
 static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = codec_dai->component;
@@ -836,6 +853,7 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int width = (params_width(params) / 8) - 1;
 	unsigned int val = 0;
+	int ret;
 
 	cs42l42->srate = params_rate(params);
 	cs42l42->bclk = snd_soc_params_to_bclk(params);
@@ -889,7 +907,13 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	return cs42l42_pll_config(component);
+	ret = cs42l42_pll_config(component);
+	if (ret)
+		return ret;
+
+	cs42l42_src_config(component, params_rate(params));
+
+	return 0;
 }
 
 static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 024760300937..46074624d300 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -347,6 +347,7 @@
 #define CS42L42_IN_ASRC_CLK		(CS42L42_PAGE_12 + 0x0A)
 #define CS42L42_CLK_IASRC_SEL_SHIFT	0
 #define CS42L42_CLK_IASRC_SEL_MASK	(1 << CS42L42_CLK_IASRC_SEL_SHIFT)
+#define CS42L42_CLK_IASRC_SEL_6		0
 #define CS42L42_CLK_IASRC_SEL_12	1
 
 #define CS42L42_OUT_ASRC_CLK		(CS42L42_PAGE_12 + 0x0B)
-- 
2.11.0

