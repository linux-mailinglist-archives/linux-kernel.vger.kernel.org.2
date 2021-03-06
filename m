Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F318D32FCA1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhCFTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:14:08 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60692 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231381AbhCFTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:13:49 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126JCNcf017698;
        Sat, 6 Mar 2021 13:13:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=wPSDKxGxlPyJi/idIuSZPJ+4etMy5RzWXBgwugWh+Iw=;
 b=We6H5cywIxKaZhqYgl73PUsdJE64yFMCHrHmdkAafU4CIa/Poym1DmaVhk6ez1fixrTG
 jsIqS4TUUhYwjZ2sNH+T0atdpE5udkl/OVduOABwi3hrj4KKSxlJqay7nkryi8QXb2b7
 MzaXhjNAb/HrtclRxlxGdZqF+MM1f4rAn4mEBGpbMuKQuAJrglGrFBV+XOLUoytNcIc1
 m1GZqLBm0AEQOMhVWBlUGJenLtvHtFuvuIobMRQc2zwW9ZCe64EeLDj/JpsYPGdMTR4d
 ajwzht2ik0x4vycs7ZK8uohCArUTdyixXA4ej0vgpOTRAmbtvC0grWty4yzq29CLWjvS +g== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748198d08-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 13:13:34 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:29 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:29 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 10ED711CB;
        Sat,  6 Mar 2021 18:56:29 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 12/15] ASoC: cs42l42: Use bclk from hw_params if set_sysclk was not called
Date:   Sat, 6 Mar 2021 18:55:50 +0000
Message-ID: <20210306185553.62053-13-tanureal@opensource.cirrus.com>
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

Add support for reading the source clock from snd_soc_params_to_bclk
so the machine driver is not required to call cs42l42_set_sysclk

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v3:
- No changes

Changes in v2:
- No changes

 sound/soc/codecs/cs42l42.c | 17 +++++++++++++----
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 594bf22521037..68b7ed71ad542 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -588,10 +588,16 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 {
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	int i;
+	u32 clk;
 	u32 fsync;
 
+	if (!cs42l42->sclk)
+		clk = cs42l42->bclk;
+	else
+		clk = cs42l42->sclk;
+
 	for (i = 0; i < ARRAY_SIZE(pll_ratio_table); i++) {
-		if (pll_ratio_table[i].sclk == cs42l42->sclk) {
+		if (pll_ratio_table[i].sclk == clk) {
 			/* Configure the internal sample rate */
 			snd_soc_component_update_bits(component, CS42L42_MCLK_CTL,
 					CS42L42_INTERNAL_FS_MASK,
@@ -611,12 +617,12 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					(pll_ratio_table[i].mclk_div <<
 					CS42L42_MCLKDIV_SHIFT));
 			/* Set up the LRCLK */
-			fsync = cs42l42->sclk / cs42l42->srate;
-			if (((fsync * cs42l42->srate) != cs42l42->sclk)
+			fsync = clk / cs42l42->srate;
+			if (((fsync * cs42l42->srate) != clk)
 				|| ((fsync % 2) != 0)) {
 				dev_err(component->dev,
 					"Unsupported sclk %d/sample rate %d\n",
-					cs42l42->sclk,
+					clk,
 					cs42l42->srate);
 				return -EINVAL;
 			}
@@ -788,6 +794,7 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	unsigned int val = 0;
 
 	cs42l42->srate = params_rate(params);
+	cs42l42->bclk = snd_soc_params_to_bclk(params);
 
 	switch(substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
@@ -921,6 +928,8 @@ static struct snd_soc_dai_driver cs42l42_dai = {
 			.rates = SNDRV_PCM_RATE_8000_192000,
 			.formats = CS42L42_FORMATS,
 		},
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
 		.ops = &cs42l42_ops,
 };
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index e12828877a20d..429c6833fc811 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -771,6 +771,7 @@ struct  cs42l42_private {
 	struct gpio_desc *reset_gpio;
 	struct completion pdn_done;
 	struct snd_soc_jack jack;
+	int bclk;
 	u32 sclk;
 	u32 srate;
 	u8 plug_state;
-- 
2.30.1

