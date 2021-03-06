Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA55832FC93
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 20:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCFTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 14:12:23 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36558 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231295AbhCFTMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 14:12:13 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 126J6uDE011401;
        Sat, 6 Mar 2021 13:11:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=3HgnxVvrRXhheoZxvMeQUCw4PPK/FQ6NyyptcZuGuzM=;
 b=nzMFbimDotVSAx94MFhmChZG0DWI4vx1c698eWyhVBmZHPjwwSPevaIpMJTJFmdY+Wqr
 eJXY52p2qysmZ2jyEx5TN/0wP6M7FY/rmIRa4vTc9RARQzgASg17PG2UTLInPAKEYoDi
 eg9Jv6dcaXuXl0GZ7C4ZG3UHm0A0El437PDT0VN4EEaLnh9XPRxXjCPJ+metoU+NdT4e
 WC0g22TRTjybyxnwOKqIiVHcGvR5zP8DuKMv3ZwEeGP7pZq7l7JEiI21YBHwgl6rxe4B
 ZaGuQ6PGs6FFxJFzpF8HygeA46UTC2LZwHCQ9RRcaJIabOCPRGPGy1bcDs7RJ29KaSjc Wg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3748198cxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 06 Mar 2021 13:11:25 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 6 Mar 2021
 18:56:21 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Sat, 6 Mar 2021 18:56:21 +0000
Received: from mail1.cirrus.com (unknown [198.61.64.35])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6751D11CB;
        Sat,  6 Mar 2021 18:56:15 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 01/15] ASoC: cs42l42: Fix Bitclock polarity inversion
Date:   Sat, 6 Mar 2021 18:55:39 +0000
Message-ID: <20210306185553.62053-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
References: <20210306185553.62053-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=972 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103060119
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver was setting bit clock polarity opposite to intended polarity.
Also simplify the code by grouping ADC and DAC clock configurations into
a single field.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
Changes in v3:
- No changes

Changes in v2:
- No changes

 sound/soc/codecs/cs42l42.c | 20 ++++++++------------
 sound/soc/codecs/cs42l42.h | 11 ++++++-----
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 210fcbedf2413..df0d5fec0287a 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -797,27 +797,23 @@ static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* Bitclock/frame inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
+		asp_cfg_val |= CS42L42_ASP_SCPOL_NOR << CS42L42_ASP_SCPOL_SHIFT;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		asp_cfg_val |= CS42L42_ASP_POL_INV <<
-				CS42L42_ASP_LCPOL_IN_SHIFT;
+		asp_cfg_val |= CS42L42_ASP_SCPOL_NOR << CS42L42_ASP_SCPOL_SHIFT;
+		asp_cfg_val |= CS42L42_ASP_LCPOL_INV << CS42L42_ASP_LCPOL_SHIFT;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		asp_cfg_val |= CS42L42_ASP_POL_INV <<
-				CS42L42_ASP_SCPOL_IN_DAC_SHIFT;
 		break;
 	case SND_SOC_DAIFMT_IB_IF:
-		asp_cfg_val |= CS42L42_ASP_POL_INV <<
-				CS42L42_ASP_LCPOL_IN_SHIFT;
-		asp_cfg_val |= CS42L42_ASP_POL_INV <<
-				CS42L42_ASP_SCPOL_IN_DAC_SHIFT;
+		asp_cfg_val |= CS42L42_ASP_LCPOL_INV << CS42L42_ASP_LCPOL_SHIFT;
 		break;
 	}
 
-	snd_soc_component_update_bits(component, CS42L42_ASP_CLK_CFG,
-				CS42L42_ASP_MODE_MASK |
-				CS42L42_ASP_SCPOL_IN_DAC_MASK |
-				CS42L42_ASP_LCPOL_IN_MASK, asp_cfg_val);
+	snd_soc_component_update_bits(component, CS42L42_ASP_CLK_CFG, CS42L42_ASP_MODE_MASK |
+								      CS42L42_ASP_SCPOL_MASK |
+								      CS42L42_ASP_LCPOL_MASK,
+								      asp_cfg_val);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 9e3cc528dcff0..1f0d67c95a9ad 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -258,11 +258,12 @@
 #define CS42L42_ASP_SLAVE_MODE		0x00
 #define CS42L42_ASP_MODE_SHIFT		4
 #define CS42L42_ASP_MODE_MASK		(1 << CS42L42_ASP_MODE_SHIFT)
-#define CS42L42_ASP_SCPOL_IN_DAC_SHIFT	2
-#define CS42L42_ASP_SCPOL_IN_DAC_MASK	(1 << CS42L42_ASP_SCPOL_IN_DAC_SHIFT)
-#define CS42L42_ASP_LCPOL_IN_SHIFT	0
-#define CS42L42_ASP_LCPOL_IN_MASK	(1 << CS42L42_ASP_LCPOL_IN_SHIFT)
-#define CS42L42_ASP_POL_INV		1
+#define CS42L42_ASP_SCPOL_SHIFT		2
+#define CS42L42_ASP_SCPOL_MASK		(3 << CS42L42_ASP_SCPOL_SHIFT)
+#define CS42L42_ASP_SCPOL_NOR		3
+#define CS42L42_ASP_LCPOL_SHIFT		0
+#define CS42L42_ASP_LCPOL_MASK		(3 << CS42L42_ASP_LCPOL_SHIFT)
+#define CS42L42_ASP_LCPOL_INV		3
 
 #define CS42L42_ASP_FRM_CFG		(CS42L42_PAGE_12 + 0x08)
 #define CS42L42_ASP_STP_SHIFT		4
-- 
2.30.1

