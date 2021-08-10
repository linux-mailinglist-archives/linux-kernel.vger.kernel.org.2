Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA563E7C81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243261AbhHJPkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:40:17 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:5692 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243430AbhHJPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17AAlVv7027584;
        Tue, 10 Aug 2021 10:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=M4NVOiS+8e9dy3UcC2jfG2nQmNP23NGdaJLXRG3jAcM=;
 b=C0nIKYR8/f4l+EHOD5RSKesPlt7abjCcqV/KimekgtyhGlWfySYb1WY9K1dRIx/ce3K/
 qSdUBeFrluF2cwB1AooDyqvlPxXeNWf/ZxAiYq7wNCJej3vFcL3D6iWzxj2JEGEvrWu+
 vRzaW2v6jzErS9QpNOp7yX8+M98z/uRuYS4XwLmXM7xgaM1h+3V57Bpr7WIDozwGKzMw
 62wn+TBv1feseqxoMb9J4IWwCfN1WWCJSERM85nVIxcR2JYfhGUpTGCsnG0U2L9Y9481
 6Wq8ACQzKrgFwqSYb9rwrA1oJZN+POqRwmLFX1zxnEk1y/5AzhliaC9c/QPKGlleLx11 /Q== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3abr0u0e2c-1
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 02E5845D;
        Tue, 10 Aug 2021 15:38:02 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 02/12] ASoC: cs42l42: Don't claim to support 192k
Date:   Tue, 10 Aug 2021 16:37:49 +0100
Message-ID: <20210810153759.24333-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810153759.24333-1-rf@opensource.cirrus.com>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Upagjle_tQt1edBaNOp6RJgsr7x6hArl
X-Proofpoint-GUID: Upagjle_tQt1edBaNOp6RJgsr7x6hArl
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently only supports configuring for sample rates <= 96k
and it isn't possible to setup a configuration that will support all
sample rates up to 192k.

For sample rates up to 96k MCLK is in the 12MHz group.
However, although 192k only requires an I2S clock in the 12MHz group,
the cs42l42 audio path is not natively 192k so the audio must be
resampled. But for 192k the SRC requires a 24MHz MCLK.

It is not possible to switch MCLK between 12MHz and 24MHz groups
on-the-fly. The 12MHz group supports all sample rates up to 96k.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 3c1609865440..a43cdfb6223b 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -819,7 +819,7 @@ static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_s
 	/* Machine driver has not set a SCLK, limit bottom end to 44.1 kHz */
 	return snd_pcm_hw_constraint_minmax(substream->runtime,
 					    SNDRV_PCM_HW_PARAM_RATE,
-					    44100, 192000);
+					    44100, 96000);
 }
 
 static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
@@ -1026,14 +1026,14 @@ static struct snd_soc_dai_driver cs42l42_dai = {
 			.stream_name = "Playback",
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_192000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
 			.formats = CS42L42_FORMATS,
 		},
 		.capture = {
 			.stream_name = "Capture",
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_8000_192000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
 			.formats = CS42L42_FORMATS,
 		},
 		.symmetric_rate = 1,
-- 
2.11.0

