Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C933E1935
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhHEQLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:11:39 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:12318 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231635AbhHEQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:11:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 175EPV3X027692;
        Thu, 5 Aug 2021 11:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=9n4MQ4cgjLOjTdPjHDB4jOE43dm1yfzx6dKWNtTmoOI=;
 b=JW/Sjb2VoXDiSzzYyUH1SAj5pjQ3fByRAojWP+hkzn8LKn0/1Rze7vvzbt71zDXMJCDc
 irlgct7ejumDy6JBPnzZsCj6uQyZNdDHNJeE06Mpq5vgkdVTGhFwMKOJ4Lfq9b1Efonq
 vA/aJAXWU4hoeAqbxFAm/aK8i4z4shvBnRQKudLwJkUsPfgELOLMBtkKez6YJWQ8TXDj
 Ek5miOZ8DpJARak+Y97yJfG+MOpbX5pTspIhbzwMIEm7JjAf8mi8EREtgrHe1Vnzbd3T
 wLzzsSkQRjnZQD8p+v/RcI/ehUPFzrBiKLZDWIHNOyM8VsIxAsn3cLPGeoWQ/YQB/Eo9 5w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3a8c61rku5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Aug 2021 11:11:16 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 5 Aug
 2021 17:11:14 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Thu, 5 Aug 2021 17:11:14 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.37])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 59B2C2BA;
        Thu,  5 Aug 2021 16:11:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/8] ASoC: cs42l42: Constrain sample rate to prevent illegal SCLK
Date:   Thu, 5 Aug 2021 17:11:06 +0100
Message-ID: <20210805161111.10410-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210805161111.10410-1-rf@opensource.cirrus.com>
References: <20210805161111.10410-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wbr-28dwTxKO9hO-xRyAcLLBAAfjY7Bt
X-Proofpoint-ORIG-GUID: wbr-28dwTxKO9hO-xRyAcLLBAAfjY7Bt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=941 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lowest valid SCLK corresponds to 44.1 kHz at 16-bit. Sample
rates less than this would produce SCLK below the minimum when using
a normal I2S frame. A constraint must be applied to prevent this.

The constraint is not applied if the machine driver sets SCLK, to
allow setups where the host generates additional bits per LRCLK
phase to increase the SCLK frequency. In these cases the machine
driver would always have to inform this driver of the actual SCLK,
and it must select a legal SCLK.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 02486329a570..29e0c8dc8466 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -807,6 +807,25 @@ static int cs42l42_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct cs42l42_private *cs42l42 = snd_soc_component_get_drvdata(component);
+
+	/*
+	 * Sample rates < 44.1 kHz would produce an out-of-range SCLK with
+	 * a standard I2S frame. If the machine driver sets SCLK it must be
+	 * legal.
+	 */
+	if (cs42l42->sclk)
+		return 0;
+
+	/* Machine driver has not set a SCLK, limit bottom end to 44.1 kHz */
+	return snd_pcm_hw_constraint_minmax(substream->runtime,
+					    SNDRV_PCM_HW_PARAM_RATE,
+					    44100, 192000);
+}
+
 static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -966,8 +985,8 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 			 SNDRV_PCM_FMTBIT_S24_LE |\
 			 SNDRV_PCM_FMTBIT_S32_LE )
 
-
 static const struct snd_soc_dai_ops cs42l42_ops = {
+	.startup	= cs42l42_dai_startup,
 	.hw_params	= cs42l42_pcm_hw_params,
 	.set_fmt	= cs42l42_set_dai_fmt,
 	.set_sysclk	= cs42l42_set_sysclk,
-- 
2.11.0

