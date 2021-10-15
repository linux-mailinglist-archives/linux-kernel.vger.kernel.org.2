Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21DF42F3A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhJONjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:04 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:39888 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239906AbhJONig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:36 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FCfErL009690;
        Fri, 15 Oct 2021 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=mIklA0ahLiJHhtti22wmtbw7urwvSdXiIps9G9njPks=;
 b=MR1AJibc9ABZYWJuo+xoQJhG1T9V9oKU9+5afhCk2zm2M9h3nKxjW4ieVE0Q3OGm8fR6
 LrX0+2m+KFw8EmhnmgyYtz5SQ1WnWOFS23M+afSUSARBbpsNoZ/w6FVJzbcMactuvv2E
 QQuCUgQJQCiP6T7de9T+4kgY9Obw2Kl/PZunbFtq6ZUmOxWcqqEcoyUmfWMpIm025pDW
 YOcmPLfgs8At9yjMaukSDKNIHnurghWc2wumvlTWl9MFE74YWmgOYhRpK9OKFpcGG++f
 HE07L5zphAz//OOkYAtJOYPR5qIKSBfrEzzAL+rl2hAMlUSLquUwb23UdrhTj7gHdu12 5w== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:24 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:22 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9503FB2F;
        Fri, 15 Oct 2021 13:36:22 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 03/16] ASoC: cs42l42: Correct some register default values
Date:   Fri, 15 Oct 2021 14:36:06 +0100
Message-ID: <20211015133619.4698-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Q9W2ffRrChfZKcxDCuBfaso0Q_lVsP92
X-Proofpoint-GUID: Q9W2ffRrChfZKcxDCuBfaso0Q_lVsP92
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some registers had wrong default values in cs42l42_reg_defaults[].

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
---
 sound/soc/codecs/cs42l42.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index c52393301294..a5c460f2ec8c 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -93,7 +93,7 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_ASP_RX_INT_MASK,		0x1F },
 	{ CS42L42_ASP_TX_INT_MASK,		0x0F },
 	{ CS42L42_CODEC_INT_MASK,		0x03 },
-	{ CS42L42_SRCPL_INT_MASK,		0xFF },
+	{ CS42L42_SRCPL_INT_MASK,		0x7F },
 	{ CS42L42_VPMON_INT_MASK,		0x01 },
 	{ CS42L42_PLL_LOCK_INT_MASK,		0x01 },
 	{ CS42L42_TSRS_PLUG_INT_MASK,		0x0F },
@@ -130,7 +130,7 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_MIXER_CHA_VOL,		0x3F },
 	{ CS42L42_MIXER_ADC_VOL,		0x3F },
 	{ CS42L42_MIXER_CHB_VOL,		0x3F },
-	{ CS42L42_EQ_COEF_IN0,			0x22 },
+	{ CS42L42_EQ_COEF_IN0,			0x00 },
 	{ CS42L42_EQ_COEF_IN1,			0x00 },
 	{ CS42L42_EQ_COEF_IN2,			0x00 },
 	{ CS42L42_EQ_COEF_IN3,			0x00 },
-- 
2.11.0

