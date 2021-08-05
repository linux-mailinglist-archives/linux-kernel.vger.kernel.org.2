Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05963E1939
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhHEQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:11:49 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:61044 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231699AbhHEQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:11:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175EPV3V027692;
        Thu, 5 Aug 2021 11:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=vCMiMKEoQoT9e4PyNQhrHRqJbFjPpEaQ/Av0RBhrd/M=;
 b=SMW8D6Dk6Un0zKpq2JDhFlpeKax36StYwgHMZYY2PaVWgJgWUtjNap2uN6xRJQX8Vz0b
 8slMh/hZuAWUbmTjOgr93YL6lyEHp0ECLwx1e7l3acvgsEy6Gd7DNJnf95YPIV4WRu+M
 lAZm8RmqKRsE3fj/1Ie61KImb3BJvA6MSPVulvgI9jajbUtTDZ617nhprQh4PfqU1AUQ
 hE1/uk/dZPieU8k93R39hVHLq01jl7MFCZz0fk1fT1tropGr5ROTmbZlz7gkt/9MW6Q2
 0eRGaike+HAtFEROWwGEN/zrdGJhlbt1Z0aMSpoTviu3iRHt8KYhrlKyflkMrrlWf0Up tg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a8c61rku5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Aug 2021 11:11:15 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 17:11:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 5 Aug 2021 17:11:13 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.37])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 399002BA;
        Thu,  5 Aug 2021 16:11:13 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/8] ASoC: cs42l42: PLL must be running when changing MCLK_SRC_SEL
Date:   Thu, 5 Aug 2021 17:11:04 +0100
Message-ID: <20210805161111.10410-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q7Oxb2S5r5Ot3KbUw0pfdmIACOq2Yfx8
X-Proofpoint-ORIG-GUID: q7Oxb2S5r5Ot3KbUw0pfdmIACOq2Yfx8
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both SCLK and PLL clocks must be running to drive the glitch-free mux
behind MCLK_SRC_SEL and complete the switchover.

This patch moves the writing of MCLK_SRC_SEL to when the PLL is started
and stopped, so that it only transitions while the PLL is running.
The unconditional write MCLK_SRC_SEL=0 in cs42l42_mute_stream() is safe
because if the PLL is not running MCLK_SRC_SEL is already 0.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 43fc357199f9 ("ASoC: cs42l42: Set clock source for both ways of stream")
---
 sound/soc/codecs/cs42l42.c | 25 ++++++++++++++++++-------
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a00dc3c65549..c96549fe6ab2 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -619,6 +619,8 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 
 	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
 		if (pll_ratio_table[i].sclk == clk) {
+			cs42l42->pll_config = i;
+
 			/* Configure the internal sample rate */
 			snd_soc_component_update_bits(component, CS42L42_MCLK_CTL,
 					CS42L42_INTERNAL_FS_MASK,
@@ -627,14 +629,9 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					(pll_ratio_table[i].mclk_int !=
 					24000000)) <<
 					CS42L42_INTERNAL_FS_SHIFT);
-			/* Set the MCLK src (PLL or SCLK) and the divide
-			 * ratio
-			 */
+
 			snd_soc_component_update_bits(component, CS42L42_MCLK_SRC_SEL,
-					CS42L42_MCLK_SRC_SEL_MASK |
 					CS42L42_MCLKDIV_MASK,
-					(pll_ratio_table[i].mclk_src_sel
-					<< CS42L42_MCLK_SRC_SEL_SHIFT) |
 					(pll_ratio_table[i].mclk_div <<
 					CS42L42_MCLKDIV_SHIFT));
 			/* Set up the LRCLK */
@@ -892,13 +889,21 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 			 */
 			regmap_multi_reg_write(cs42l42->regmap, cs42l42_to_osc_seq,
 					       ARRAY_SIZE(cs42l42_to_osc_seq));
+
+			/* Must disconnect PLL before stopping it */
+			snd_soc_component_update_bits(component,
+						      CS42L42_MCLK_SRC_SEL,
+						      CS42L42_MCLK_SRC_SEL_MASK,
+						      0);
+			usleep_range(100, 200);
+
 			snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 						      CS42L42_PLL_START_MASK, 0);
 		}
 	} else {
 		if (!cs42l42->stream_use) {
 			/* SCLK must be running before codec unmute */
-			if ((cs42l42->bclk < 11289600) && (cs42l42->sclk < 11289600)) {
+			if (pll_ratio_table[cs42l42->pll_config].mclk_src_sel) {
 				snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 							      CS42L42_PLL_START_MASK, 1);
 
@@ -919,6 +924,12 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 							       CS42L42_PLL_LOCK_TIMEOUT_US);
 				if (ret < 0)
 					dev_warn(component->dev, "PLL failed to lock: %d\n", ret);
+
+				/* PLL must be running to drive glitchless switch logic */
+				snd_soc_component_update_bits(component,
+							      CS42L42_MCLK_SRC_SEL,
+							      CS42L42_MCLK_SRC_SEL_MASK,
+							      CS42L42_MCLK_SRC_SEL_MASK);
 			}
 
 			/* Mark SCLK as present, turn off internal oscillator */
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 206b3c81d3e0..b92c17be7f58 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -775,6 +775,7 @@ struct  cs42l42_private {
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
 	struct snd_soc_jack *jack;
+	int pll_config;
 	int bclk;
 	u32 sclk;
 	u32 srate;
-- 
2.11.0

