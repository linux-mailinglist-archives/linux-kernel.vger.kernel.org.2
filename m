Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F357D32ABC4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837249AbhCBUnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:43:15 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:60060 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1574687AbhCBRv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:27 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H1q3O022910;
        Tue, 2 Mar 2021 11:05:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=JpuBubu/c8c50GVx5442WTK+yTA2jobKEEDjjn3AfQA=;
 b=QIUIJDm64RSOoSAesc6uF4NH+5NS5lbfwWgD8DCU6n/jK2ffP2XtYv/Znzk5k6A3sN4K
 J6ezyOXCWeakiyv2s3sqHv7CYx5kq8+8xr/2z+M9jozH1nrCXM4+293Qwq3LD2x1Xqsr
 s0OU7RNw0C9pFnkac5ratTTIBtcB8GSScPTrCqoY4SjEloV9FBRouRlD3duGkrPlxvEc
 R+EqjEX4yPqoZC5tyJ3KIiiGCp7eWhO+VOOKQWPoaLPRGMriwSFbiKEvyS6lY4IeOllk
 aDSHQ8EtCMxaww/hKfzZNYmS2sEfBsdlLfNF89sdfX5/cbzA1+fPWaHORrmh6dcGJBU4 tw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 11:05:04 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:05:01 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:05:01 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2689B11D5;
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
Subject: [PATCH 08/15] ASoC: cs42l42: Fix channel width support
Date:   Tue, 2 Mar 2021 17:04:47 +0000
Message-ID: <20210302170454.39679-9-tanureal@opensource.cirrus.com>
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

Remove the hard coded 32 bits width and replace with the correct width
calculated by params_width.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 47 ++++++++++++++++++--------------------
 sound/soc/codecs/cs42l42.h |  1 -
 2 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 670f28f09ae01..6022b6f9c6d27 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -632,24 +632,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					CS42L42_CLK_OASRC_SEL_MASK,
 					CS42L42_CLK_OASRC_SEL_12 <<
 					CS42L42_CLK_OASRC_SEL_SHIFT);
-			/* channel 1 on low LRCLK, 32 bit */
-			snd_soc_component_update_bits(component,
-					CS42L42_ASP_RX_DAI0_CH1_AP_RES,
-					CS42L42_ASP_RX_CH_AP_MASK |
-					CS42L42_ASP_RX_CH_RES_MASK,
-					(CS42L42_ASP_RX_CH_AP_LOW <<
-					CS42L42_ASP_RX_CH_AP_SHIFT) |
-					(CS42L42_ASP_RX_CH_RES_32 <<
-					CS42L42_ASP_RX_CH_RES_SHIFT));
-			/* Channel 2 on high LRCLK, 32 bit */
-			snd_soc_component_update_bits(component,
-					CS42L42_ASP_RX_DAI0_CH2_AP_RES,
-					CS42L42_ASP_RX_CH_AP_MASK |
-					CS42L42_ASP_RX_CH_RES_MASK,
-					(CS42L42_ASP_RX_CH_AP_HI <<
-					CS42L42_ASP_RX_CH_AP_SHIFT) |
-					(CS42L42_ASP_RX_CH_RES_32 <<
-					CS42L42_ASP_RX_CH_RES_SHIFT));
 			if (pll_ratio_table[i].mclk_src_sel == 0) {
 				/* Pass the clock straight through */
 				snd_soc_component_update_bits(component,
@@ -765,14 +747,29 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
-	int retval;
+	unsigned int width = (params_width(params) / 8) - 1;
+	unsigned int val = 0;
 
 	cs42l42->srate = params_rate(params);
-	cs42l42->swidth = params_width(params);
 
-	retval = cs42l42_pll_config(component);
+	switch(substream->stream) {
+	case SNDRV_PCM_STREAM_PLAYBACK:
+		val |= width << CS42L42_ASP_RX_CH_RES_SHIFT;
+		/* channel 1 on low LRCLK */
+		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_CH1_AP_RES,
+							 CS42L42_ASP_RX_CH_AP_MASK |
+							 CS42L42_ASP_RX_CH_RES_MASK, val);
+		/* Channel 2 on high LRCLK */
+		val |= CS42L42_ASP_RX_CH_AP_HI << CS42L42_ASP_RX_CH_AP_SHIFT;
+		snd_soc_component_update_bits(component, CS42L42_ASP_RX_DAI0_CH2_AP_RES,
+							 CS42L42_ASP_RX_CH_AP_MASK |
+							 CS42L42_ASP_RX_CH_RES_MASK, val);
+		break;
+	default:
+		break;
+	};
 
-	return retval;
+	return cs42l42_pll_config(component);
 }
 
 static int cs42l42_set_sysclk(struct snd_soc_dai *dai,
@@ -847,9 +844,9 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
-#define CS42L42_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE | \
-			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE | \
-			SNDRV_PCM_FMTBIT_S32_LE)
+#define CS42L42_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE )
 
 
 static const struct snd_soc_dai_ops cs42l42_ops = {
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 59e6eccb8d731..3dcbfebc53b0f 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -758,7 +758,6 @@ struct  cs42l42_private {
 	struct completion pdn_done;
 	u32 sclk;
 	u32 srate;
-	u32 swidth;
 	u8 plug_state;
 	u8 hs_type;
 	u8 ts_inv;
-- 
2.30.1

