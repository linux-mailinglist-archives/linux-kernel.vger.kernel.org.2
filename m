Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB44C32FC99
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhCFTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:13:59 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:64870 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231360AbhCFTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:13:45 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126JCNcg017698;
        Sat, 6 Mar 2021 13:13:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=D0L/2V284lBlYPp+kHSQexXxL3YGhWhj1b/e97X3Pf4=;
 b=LlNdB25vtWVZ4mWh3McSg4c/jVU30xpOTrNUWOELVNM+tY4taTVflQcCBlWnu1KQtPlt
 kMA4EZmmMSrDf382Amyat+iptJl/6lgby0U/HRmnHY/EO0lIZk2R/QFyBFL9HdFppSrY
 v3a9lzF8s4+ddV3ViiReOWHZcmcAMPjdJ7GblHBpnZGSDs5rkOhd5KOS9YNEM7ApTbLX
 rAK7lLUNqQlnoZcAbRLeVg2OhU73OjAU1+q4EUPkIg7WVSFb40t+qb9x3W3OyVjkibCI
 T7Wqvn8E4PSU7RDkJa1AuvZlYnTKO9cAO0Q1zQfGVUhb5AzRzmsn7uLL5rRyCqEoZpDi Ag== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748198d08-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 13:13:35 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:29 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:29 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 56BFC11CF;
        Sat,  6 Mar 2021 18:56:29 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 13/15] ASoC: cs42l42: Wait at least 150us after writing SCLK_PRESENT
Date:   Sat, 6 Mar 2021 18:55:51 +0000
Message-ID: <20210306185553.62053-14-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
References: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=863 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103060119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

There must be a delay of at least 150us after writing SCLK_PRESENT
before issuing another I2C write.

This is done using struct reg_sequence because it can specify a delay
after the write and the whole sequence is written atomically.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v3:
- No changes

Changes in v2:
- struct cs42l42_private add by this patch was wrong and moved to the
correct patch
- Lucas signed-off added

 sound/soc/codecs/cs42l42.c | 27 ++++++++++++++++++++++-----
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 68b7ed71ad542..08718fd10fb9b 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -549,6 +549,24 @@ static const struct snd_soc_component_driver soc_component_dev_cs42l42 = {
 	.non_legacy_dai_naming	= 1,
 };
 
+/* Switch to SCLK. Atomic delay after the write to allow the switch to complete. */
+static const struct reg_sequence cs42l42_to_sclk_seq[] = {
+	{
+		.reg = CS42L42_OSC_SWITCH,
+		.def = CS42L42_SCLK_PRESENT_MASK,
+		.delay_us = CS42L42_CLOCK_SWITCH_DELAY_US,
+	},
+};
+
+/* Switch to OSC. Atomic delay after the write to allow the switch to complete. */
+static const struct reg_sequence cs42l42_to_osc_seq[] = {
+	{
+		.reg = CS42L42_OSC_SWITCH,
+		.def = 0,
+		.delay_us = CS42L42_CLOCK_SWITCH_DELAY_US,
+	},
+};
+
 struct cs42l42_pll_params {
 	u32 sclk;
 	u8 mclk_div;
@@ -861,8 +879,8 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 			 * SCLK must remain running until after this clock switch.
 			 * Without a source of clock the I2C bus doesn't work.
 			 */
-			snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
-						      CS42L42_SCLK_PRESENT_MASK, 0);
+			regmap_multi_reg_write(cs42l42->regmap, cs42l42_to_osc_seq,
+					       ARRAY_SIZE(cs42l42_to_osc_seq));
 			snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 						      CS42L42_PLL_START_MASK, 0);
 		}
@@ -873,9 +891,8 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 						      CS42L42_PLL_START_MASK, 1);
 
 			/* Mark SCLK as present, turn off internal oscillator */
-			snd_soc_component_update_bits(component, CS42L42_OSC_SWITCH,
-						      CS42L42_SCLK_PRESENT_MASK,
-						      CS42L42_SCLK_PRESENT_MASK);
+			regmap_multi_reg_write(cs42l42->regmap, cs42l42_to_sclk_seq,
+					       ARRAY_SIZE(cs42l42_to_sclk_seq));
 		}
 		cs42l42->stream_use |= 1 << stream;
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 429c6833fc811..214cee762709d 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -755,6 +755,7 @@
 
 #define CS42L42_NUM_SUPPLIES	5
 #define CS42L42_BOOT_TIME_US	3000
+#define CS42L42_CLOCK_SWITCH_DELAY_US 150
 
 static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
 	"VA",
-- 
2.30.1

