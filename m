Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC52E32ABC9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839944AbhCBUo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:44:29 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48262 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1347768AbhCBRym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:54:42 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122H1q3S022910;
        Tue, 2 Mar 2021 11:05:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ooarnE2nUSCDeXk59FI8XH/GTKr4wdSqYy9xhrQFVEw=;
 b=B6aJaQHAv/FPhyGDEvJ/05/q+s86+9ZMBq1oZyTw3Fe8AHZeVNuySEVRGgu1caI8xQGu
 U/ZILiVFx4ag5KjVNmyM5WnjdLtCn84aFEqlVsWL8r1e8pT0bhNAD5i3PvBkZTgFObMu
 CRJyT8wHgn7s5r5RTEQZwPwv7bg9NZTE1wyIop7/g1hfvpLx5F/YK5b6vOoWUxQS9Cin
 nO2bZ/JyZAAHMrD8qgUGwpdWLcgxkaKzlccctrWIOcJ1SNy85Q1k5bcdjtjwbM0YGm6x
 za9+QHOLWepEgu+cC7PoVfVZvlshpZj89YYo1bOlRgJydKgtPLJY5u7mlKScwm1sf3QT Vw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36ymc6usg9-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Mar 2021 11:05:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 2 Mar 2021
 17:05:03 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 2 Mar 2021 17:05:03 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D07C411D0;
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
Subject: [PATCH 14/15] ASoC: cs42l42: Wait for PLL to lock before switching to it
Date:   Tue, 2 Mar 2021 17:04:53 +0000
Message-ID: <20210302170454.39679-15-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
References: <20210302170454.39679-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=952 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

The PLL should have locked before using it to supply MCLK.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 12 +++++++++++-
 sound/soc/codecs/cs42l42.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 68b5a450623d3..96f4e98ceaa0b 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -830,6 +830,7 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
 	unsigned int regval;
 	u8 fullScaleVol;
+	int ret;
 
 	if (mute) {
 		/* Mute the headphone */
@@ -855,9 +856,18 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 	} else {
 		if (!cs42l42->stream_use) {
 			/* SCLK must be running before codec unmute */
-			if ((cs42l42->bclk < 11289600) && (cs42l42->sclk < 11289600))
+			if ((cs42l42->bclk < 11289600) && (cs42l42->sclk < 11289600)) {
 				snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 							      CS42L42_PLL_START_MASK, 1);
+				ret = regmap_read_poll_timeout(cs42l42->regmap,
+							       CS42L42_PLL_LOCK_STATUS,
+							       regval,
+							       (regval & 1),
+							       CS42L42_PLL_LOCK_POLL_US,
+							       CS42L42_PLL_LOCK_TIMEOUT_US);
+				if (ret < 0)
+					dev_warn(component->dev, "PLL failed to lock: %d\n", ret);
+			}
 
 			/* Mark SCLK as present, turn off internal oscillator */
 			regmap_multi_reg_write(cs42l42->regmap, cs42l42_to_sclk_seq,
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index a0c87f2326e69..7a5048dfade20 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -756,6 +756,8 @@
 #define CS42L42_NUM_SUPPLIES	5
 #define CS42L42_BOOT_TIME_US	3000
 #define CS42L42_CLOCK_SWITCH_DELAY_US 150
+#define CS42L42_PLL_LOCK_POLL_US	250
+#define CS42L42_PLL_LOCK_TIMEOUT_US	1250
 
 static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
 	"VA",
-- 
2.30.1

