Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1821E32AAF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581991AbhCBUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:01:37 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:40958 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243322AbhCBRb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:31:57 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H1q3F022910;
        Tue, 2 Mar 2021 11:05:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=e2RECNMESkrDR5w6gXpZcLquzVmBbLFtXHzKAUc6vXI=;
 b=p3wrZp/P+iLRo52aSh/R/ZKEHiCFEMRyNnxl2KK17U21j+FoA5qNH77xyxCKF5VnRtqV
 1/2HQyaqu1wWTm3FaCuNCvkgxbTIwUDtoMOBCpdFEcV3vLS52n4qmOVnRWIlzgYBOBiI
 64aJkb7aT/6ybhR6Dilmf+vfE70C6zUFAmpbnVCc/MylDZlzcGNa0CJC+/jbBQVoDVLm
 IYG7QJ1ZANrBNiydj9v1dNWyh1xiTNV648cgATvwKViKNlRPBo+ezn8zoQl/ib7O9xv8
 4BRuBGEUDVGNAXWckx/gX1dCqmj6p7j2xJbicrah9yEMRg1OYYaKp5VbEAqkHfsjNyzw IQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 11:05:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:04:59 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:04:59 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2517411D5;
        Tue,  2 Mar 2021 17:04:59 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/15] ASoC: cs42l42: Don't enable/disable regulator at Bias Level
Date:   Tue, 2 Mar 2021 17:04:40 +0000
Message-ID: <20210302170454.39679-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=910 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_ops already enable/disable the codec if not in use

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 210fcbedf2413..caae05b1729e9 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -511,43 +511,6 @@ static const struct snd_soc_dapm_route cs42l42_audio_map[] = {
 	{"HP", NULL, "HPDRV"}
 };
 
-static int cs42l42_set_bias_level(struct snd_soc_component *component,
-					enum snd_soc_bias_level level)
-{
-	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	switch (level) {
-	case SND_SOC_BIAS_ON:
-		break;
-	case SND_SOC_BIAS_PREPARE:
-		break;
-	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
-			regcache_cache_only(cs42l42->regmap, false);
-			regcache_sync(cs42l42->regmap);
-			ret = regulator_bulk_enable(
-						ARRAY_SIZE(cs42l42->supplies),
-						cs42l42->supplies);
-			if (ret != 0) {
-				dev_err(component->dev,
-					"Failed to enable regulators: %d\n",
-					ret);
-				return ret;
-			}
-		}
-		break;
-	case SND_SOC_BIAS_OFF:
-
-		regcache_cache_only(cs42l42->regmap, true);
-		regulator_bulk_disable(ARRAY_SIZE(cs42l42->supplies),
-						    cs42l42->supplies);
-		break;
-	}
-
-	return 0;
-}
-
 static int cs42l42_component_probe(struct snd_soc_component *component)
 {
 	struct cs42l42_private *cs42l42 =
@@ -560,7 +523,6 @@ static int cs42l42_component_probe(struct snd_soc_component *component)
 
 static const struct snd_soc_component_driver soc_component_dev_cs42l42 = {
 	.probe			= cs42l42_component_probe,
-	.set_bias_level		= cs42l42_set_bias_level,
 	.dapm_widgets		= cs42l42_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(cs42l42_dapm_widgets),
 	.dapm_routes		= cs42l42_audio_map,
-- 
2.30.1

