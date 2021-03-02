Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF432ABDB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446982AbhCBUuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:50:35 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:15600 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1574619AbhCBRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H1q3Q022910;
        Tue, 2 Mar 2021 11:05:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=vCHWy3Exa6te6tewneVXoR9NeyrAMjtx7WMnGrouN1E=;
 b=WcJqpTRGPpz+7aAGYrLOBxcAImcAmbP3I4xPxXyhYKxWeeyR1fUKm+Bf4miCKNEYM+FV
 sST7W5dnXvgXvy1ZpWe3ad5UFJaZ9dXqG6cR+OgntmF/l8aRS0/IgT+JGtblnhoW0sl9
 c4C3/0ewPMaCJoGYn6lgYL+nmTIoTTmimiihc+b2fNjZPiySCe7hNeEdaajg633BISAH
 NDqz3rMj3QLSayfe5Csbh/jMt35DQK9RC01aGND9/gFCIHFNN9DPnSTg61SozqWzLHqm
 Lh8/+KVwtk+48C0CONq6g0N8rO8qjoTRzMWEkM49Hb0LOxmKtkPVpgmxZUPNjRbatRnu EQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 11:05:05 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:05:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:05:02 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3EBA811D8;
        Tue,  2 Mar 2021 17:05:02 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/15] ASoC: cs42l42: Wait at least 150us after writing SCLK_PRESENT
Date:   Tue, 2 Mar 2021 17:04:51 +0000
Message-ID: <20210302170454.39679-13-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=936 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

There must be a delay of at least 150us after writing SCLK_PRESENT
before issuing another I2C write.

This is done using struct reg_sequence because it can specify a delay
after the write and the whole sequence is written atomically.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 28 +++++++++++++++++++++++-----
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 7898a2d52a3b7..5755f8baddbcf 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -517,6 +517,24 @@ static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
 	{ "SDOUT2", NULL, "ASP TX EN" },
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
@@ -809,6 +827,7 @@ static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
 static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 {
 	struct snd_soc_component *component = dai->component;
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int regval;
 	u8 fullScaleVol;
 
@@ -828,8 +847,8 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
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
@@ -840,9 +859,8 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
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
index 1df9577e367c1..a0c87f2326e69 100644
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

