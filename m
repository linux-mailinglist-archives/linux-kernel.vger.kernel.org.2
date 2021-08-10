Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659C83E7C79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbhHJPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:39:21 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:8150 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243401AbhHJPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17AAlVv8027584;
        Tue, 10 Aug 2021 10:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=1G77KCqb3qWR6iff9g2FFP7dpQlFTfAw5xgISoV0nQY=;
 b=LHdV+355zYmiva9Ul4lIZvbLpNuVUvPesjI9z8jCA9YjIGMyPfd8bCD5wTDrQRx9HkoA
 UwQdi2BtEaU0vSih7IL77r3TrBljOv2u34qnR+T/IHniJeeuZbmm6DcQDxBuQ/e9UXmy
 Hp0QUNSSXhxdVg6w9rzioqmMs4g823lkQlLkn9fEypztLLav6cdMVoQ3flrQxaSci9p7
 qlINOpe+pYLAhctkZMg0B1J6cp3TfSVVeQXoZHOYYaWNTwqkGOVtPuCPQDnUEtXlQiRe
 GS0JpQBZIdWFH0xDy/Fj8qNNuQ6+XpJk3AyogHBGfU7eMds5qcKDBIj3QNyZ7z0HYAf0 UA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3abr0u0e2c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 10:38:05 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 10 Aug 2021 16:38:03 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 48FDC2A9;
        Tue, 10 Aug 2021 15:38:03 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 03/12] ASoC: cs42l42: Always configure both ASP TX channels
Date:   Tue, 10 Aug 2021 16:37:50 +0100
Message-ID: <20210810153759.24333-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810153759.24333-1-rf@opensource.cirrus.com>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mRZ0SOKAFpoU2utyZac-bWhJmNwCOkq5
X-Proofpoint-GUID: mRZ0SOKAFpoU2utyZac-bWhJmNwCOkq5
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An I2S frame always has two slots (left and right) even when sending
mono. The right channel (channel 2) of ASP TX will always have the
same bit width as the left channel and will always be on the high
phase of LRCLK.

The previous implementation always passed the field masks for both
channels to snd_soc_component_update_bits() but for mono the written value
only contained the settings for channel 1. The result was that for mono
channel 2 was set to 8-bit (which is an invalid configuration) with both
channels on the low phase of LRCLK.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 585e7079de0e ("ASoC: cs42l42: Add Capture Support")
---
 sound/soc/codecs/cs42l42.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a43cdfb6223b..5dc3a30272a4 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -848,11 +848,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	switch(substream->stream) {
 	case SNDRV_PCM_STREAM_CAPTURE:
-		if (channels == 2) {
-			val |= CS42L42_ASP_TX_CH2_AP_MASK;
-			val |= width << CS42L42_ASP_TX_CH2_RES_SHIFT;
-		}
-		val |= width << CS42L42_ASP_TX_CH1_RES_SHIFT;
+		/* channel 2 on high LRCLK */
+		val = CS42L42_ASP_TX_CH2_AP_MASK |
+		      (width << CS42L42_ASP_TX_CH2_RES_SHIFT) |
+		      (width << CS42L42_ASP_TX_CH1_RES_SHIFT);
 
 		snd_soc_component_update_bits(component, CS42L42_ASP_TX_CH_AP_RES,
 				CS42L42_ASP_TX_CH1_AP_MASK | CS42L42_ASP_TX_CH2_AP_MASK |
-- 
2.11.0

