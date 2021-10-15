Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C13C42F3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhJONjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:37 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:31212 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239979AbhJONii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:38 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2t3023483;
        Fri, 15 Oct 2021 08:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=i+3Uz83fu6Tsr2zoWjKonYaF4sUZax+MDZBMEuGJlWg=;
 b=mApZYqHJixhPSRm/eiA68tUo7+SGi9PX1czGfEsrcsUUlHAF99CIvsv6Wp+YakQ2w7iU
 GDxHhE0z+MGdValgziauCJLodABvzGj5IptDwSwyz1UhYIPZzEf+fL0JcBYjWLzFu2uZ
 lp6uesSauWV4LSoptGvo5Yfoiudy3+zvfKmha6qnP7DKl+cuB5VokwY4+RkMCjVYJauh
 vGYHSdam3Tf83yFLk+yDzjQSkJIeF1z+4IslpgZSIj/QcR5LsEU6L7sTsiw/LXMdsQoy
 fpdYjP0GON5S+D3mQdTQEA1aEWxJVVTtUtixJz5VfsdeYi4b8jOCqwCedQV4/m//LiR2 VQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:24 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 856B946D;
        Fri, 15 Oct 2021 13:36:24 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 10/16] ASoC: cs42l42: Don't claim to support 192k
Date:   Fri, 15 Oct 2021 14:36:13 +0100
Message-ID: <20211015133619.4698-11-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: h4tELPdJfIrHtMQS6nK-vE9fKXl8UTAG
X-Proofpoint-GUID: h4tELPdJfIrHtMQS6nK-vE9fKXl8UTAG
X-Proofpoint-Spam-Reason: safe
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
index 174f738e9e5a..c18f42cc1044 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -802,7 +802,7 @@ static int cs42l42_dai_startup(struct snd_pcm_substream *substream, struct snd_s
 	/* Machine driver has not set a SCLK, limit bottom end to 44.1 kHz */
 	return snd_pcm_hw_constraint_minmax(substream->runtime,
 					    SNDRV_PCM_HW_PARAM_RATE,
-					    44100, 192000);
+					    44100, 96000);
 }
 
 static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
@@ -998,14 +998,14 @@ static struct snd_soc_dai_driver cs42l42_dai = {
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

