Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C83E193B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhHEQLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:11:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7138 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231654AbhHEQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:11:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175EPV3W027692;
        Thu, 5 Aug 2021 11:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=PeQp4wAnIMZqw5MsxPEzSfQRQuBOXoms0dnVTKaTwcA=;
 b=VZ8pogQhNlCG7kkhPYeddri98Sha2h+GUKQV9V1M0tXz8yxmGFlJBenPs2u783Rpxdtg
 S0tMBmsa/h/lApZ7hCj4/FWY4SOwCMB/R1ySWqWcCyjk5gvErv0y95Th68D3VYXiDNcx
 bGVOOwdBOkW8VvBVcdp6BuH1wrFTSlXU8RbBI7p8OdKUxOAF8RNYJRt34p6ON7H1h1qh
 GWIw5QHK/5g/TzASp8Voa0HY+g/3Z8cQ7GP18NYbN7JuHpUwSiJ40uvH/yhRrRG9jzYh
 DTEOeJkoQEFMp+66SNRgvF3MMY3/4/sMe5q1SrZZ8o+fc2EDByXJnX08l+014xk/60/2 /g== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a8c61rku6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Aug 2021 11:11:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 17:11:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 5 Aug 2021 17:11:14 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.37])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0BA5E46E;
        Thu,  5 Aug 2021 16:11:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/8] ASoC: cs42l42: Fix LRCLK frame start edge
Date:   Thu, 5 Aug 2021 17:11:05 +0100
Message-ID: <20210805161111.10410-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: EJoAcN1mOFoVAMaB-_GP5EWzItAQDOfk
X-Proofpoint-ORIG-GUID: EJoAcN1mOFoVAMaB-_GP5EWzItAQDOfk
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=896 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An I2S frame starts on the falling edge of LRCLK so ASP_STP must
be 0.

At the same time, move other format settings in the same register
from cs42l42_pll_config() to cs42l42_set_dai_fmt() where you'd
expect to find them, and merge into a single write.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
---
 sound/soc/codecs/cs42l42.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index c96549fe6ab2..02486329a570 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -667,15 +667,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					CS42L42_FSYNC_PULSE_WIDTH_MASK,
 					CS42L42_FRAC1_VAL(fsync - 1) <<
 					CS42L42_FSYNC_PULSE_WIDTH_SHIFT);
-			snd_soc_component_update_bits(component,
-					CS42L42_ASP_FRM_CFG,
-					CS42L42_ASP_5050_MASK,
-					CS42L42_ASP_5050_MASK);
-			/* Set the frame delay to 1.0 SCLK clocks */
-			snd_soc_component_update_bits(component, CS42L42_ASP_FRM_CFG,
-					CS42L42_ASP_FSD_MASK,
-					CS42L42_ASP_FSD_1_0 <<
-					CS42L42_ASP_FSD_SHIFT);
 			/* Set the sample rates (96k or lower) */
 			snd_soc_component_update_bits(component, CS42L42_FS_RATE_EN,
 					CS42L42_FS_EN_MASK,
@@ -775,6 +766,18 @@ static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
+		/*
+		 * 5050 mode, frame starts on falling edge of LRCLK,
+		 * frame delayed by 1.0 SCLKs
+		 */
+		snd_soc_component_update_bits(component,
+					      CS42L42_ASP_FRM_CFG,
+					      CS42L42_ASP_STP_MASK |
+					      CS42L42_ASP_5050_MASK |
+					      CS42L42_ASP_FSD_MASK,
+					      CS42L42_ASP_5050_MASK |
+					      (CS42L42_ASP_FSD_1_0 <<
+						CS42L42_ASP_FSD_SHIFT));
 		break;
 	default:
 		return -EINVAL;
-- 
2.11.0

