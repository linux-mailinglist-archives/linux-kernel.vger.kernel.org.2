Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A8742F3A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbhJONjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:12 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38006 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239900AbhJONig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F4c2sx023483;
        Fri, 15 Oct 2021 08:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=5CUM0Kld1tqcGicVvfKYh/DrTNh8/7H4cHyTX8EpzVQ=;
 b=UBlfRUv0R0q85QeDeUtR4AQdMRI4gMDKJsNRxUqToA+iHQyHNoF+K4QG+fmJvAvvubox
 bwVtGHpcpCb/cmW4MID2uXbKlOTqsIUjSab/Xnv5Em9RCNxjvCi99EhsdE+diEyOxkcH
 PGzI8y09MzUyCR1yrLZyKeAYqG3SCw3Rt60POwBJjGXmlRu6CPa7bgy5NTy1t/Qe5nrs
 doU6OzSEwSeSJbf8sOctH3coRkMYyBIlXNk1wHFpm0pJ7pPeWCeyfR44BWO0ZBtv1468
 2kNxKulLaQKbBmxugURqRXHXxETjaT84fBrJ83+136Vf5eVAjqMiniPk1WZxmAWrL3L7 Pg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:22 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5027A11D2;
        Fri, 15 Oct 2021 13:36:22 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 02/16] ASoC: cs42l42: Always configure both ASP TX channels
Date:   Fri, 15 Oct 2021 14:36:05 +0100
Message-ID: <20211015133619.4698-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M8xPAyg2K-EqFPMtZl0eRO8il4XIaDP9
X-Proofpoint-GUID: M8xPAyg2K-EqFPMtZl0eRO8il4XIaDP9
X-Proofpoint-Spam-Reason: safe
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
index 26f6a3510a03..c52393301294 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -861,11 +861,10 @@ static int cs42l42_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	switch (substream->stream) {
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

