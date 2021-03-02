Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDD32ABC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350733AbhCBUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:39:39 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:65146 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1574686AbhCBRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H1q3N022910;
        Tue, 2 Mar 2021 11:05:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=vFotJFunbO6grlMdLvKjcHA1rEucWzbu+dMncghehHQ=;
 b=LeNyu/y82tnwn91HR+p65t84kz8ghYsXNv5VfFu0s6N3DbEPriW4nHKv27udAHpVbY8N
 vYAp4R57kTBGNJ2IqYNliuGNwRHZzj2ZR5Felyvv8f9Q5umF7mmUXFRl1OX7e8Bi7BpD
 UC0sAKRsRDaexH12Fh9DKHcFON626MEtDD9avO91zfLxS80REDX8jg3WubgdY6v2woMw
 xlJuPoEnD9rF4UaUAJWBT6pB/ZQ26xjTUuDTPJJH+5y6pSDk1r4WMLty/j0xaQSk9/0Q
 iUeEZ+EtWE7tidJDJnn+eBfPVlXwAhz5+RyJYz7b8wUs/KexI2Cb5j2bK5EpUdM0vQfh 0A== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg7-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 11:05:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:05:02 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:05:02 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EF84B11CB;
        Tue,  2 Mar 2021 17:05:01 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/15] ASoC: cs42l42: Use bclk from hw_params if set_sysclk was not called
Date:   Tue, 2 Mar 2021 17:04:50 +0000
Message-ID: <20210302170454.39679-12-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading the source clock from snd_soc_params_to_bclk
so the machine driver is not required to call cs42l42_set_sysclk

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 17 +++++++++++++----
 sound/soc/codecs/cs42l42.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 8345f52ec9d58..7898a2d52a3b7 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -556,10 +556,16 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
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
@@ -579,12 +585,12 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
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
@@ -756,6 +762,7 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 	unsigned int val = 0;
 
 	cs42l42->srate = params_rate(params);
+	cs42l42->bclk = snd_soc_params_to_bclk(params);
 
 	switch(substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
@@ -888,6 +895,8 @@ static struct snd_soc_dai_driver cs42l42_dai = {
 			.rates = SNDRV_PCM_RATE_8000_192000,
 			.formats = CS42L42_FORMATS,
 		},
+		.symmetric_rate = 1,
+		.symmetric_sample_bits = 1,
 		.ops = &cs42l42_ops,
 };
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 267c2b616e57d..1df9577e367c1 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -772,6 +772,7 @@ struct  cs42l42_private {
 	struct completion pdn_done;
 	struct snd_soc_jack jack;
 	int irq;
+	int bclk;
 	u32 sclk;
 	u32 srate;
 	u8 plug_state;
-- 
2.30.1

