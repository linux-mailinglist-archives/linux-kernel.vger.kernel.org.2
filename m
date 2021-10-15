Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A7042F3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhJONjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:39:15 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48768 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239953AbhJONih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:38:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FCfErM009690;
        Fri, 15 Oct 2021 08:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=dzQo95A00QtC5PZqcJQ7VCfKoMr/qtiEjfJl9QyDCVQ=;
 b=cKyrsZmay+g3onmVI6nzMpfCfThSARao4p+0nuT+91x+xnVrHSJVyU5f78qz1NGpKK7i
 Js2oGyZuUbrr2st7bCtj6LrLHepYLw3Pn09kM2ERHc8OGHlt1xNRVWN35VuW40VfzLfH
 OYDVyAajUZ1nsbFrRy5SJrKJjdVBQtuYZQIoDGCK/7UC3fepBsRXFCly7h+IDCkuOyM9
 8yEDnJlJG0Dt7X7XqDAUo9sihk1hc1kC2FYQdk5onbqP0V0IYiTQr73W7wtmZC60Qwni
 xUhKuX+YNCiZAnyeM/zTVIR5UYvSGg7qlBLL6auaEsQMULbCQrmbaRaevJptPdZ5UCtR Ew== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3bq1gagp5w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Oct 2021 08:36:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 15 Oct
 2021 14:36:23 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Fri, 15 Oct 2021 14:36:23 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.254])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DB5E946D;
        Fri, 15 Oct 2021 13:36:22 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 04/16] ASoC: cs42l42: Don't set defaults for volatile registers
Date:   Fri, 15 Oct 2021 14:36:07 +0100
Message-ID: <20211015133619.4698-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211015133619.4698-1-rf@opensource.cirrus.com>
References: <20211015133619.4698-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VVTmusYFh5SH1dCBqv6VaAiTwwP83VPM
X-Proofpoint-GUID: VVTmusYFh5SH1dCBqv6VaAiTwwP83VPM
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Volatile registers don't need a default value.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 2c394ca79604 ("ASoC: Add support for CS42L42 codec")
---
 sound/soc/codecs/cs42l42.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a5c460f2ec8c..c4efdc8f5d24 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -41,7 +41,6 @@
 static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_FRZ_CTL,			0x00 },
 	{ CS42L42_SRC_CTL,			0x10 },
-	{ CS42L42_MCLK_STATUS,			0x02 },
 	{ CS42L42_MCLK_CTL,			0x02 },
 	{ CS42L42_SFTRAMP_RATE,			0xA4 },
 	{ CS42L42_I2C_DEBOUNCE,			0x88 },
@@ -57,11 +56,9 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_RSENSE_CTL3,			0x1B },
 	{ CS42L42_TSENSE_CTL,			0x1B },
 	{ CS42L42_TSRS_INT_DISABLE,		0x00 },
-	{ CS42L42_TRSENSE_STATUS,		0x00 },
 	{ CS42L42_HSDET_CTL1,			0x77 },
 	{ CS42L42_HSDET_CTL2,			0x00 },
 	{ CS42L42_HS_SWITCH_CTL,		0xF3 },
-	{ CS42L42_HS_DET_STATUS,		0x00 },
 	{ CS42L42_HS_CLAMP_DISABLE,		0x00 },
 	{ CS42L42_MCLK_SRC_SEL,			0x00 },
 	{ CS42L42_SPDIF_CLK_CFG,		0x00 },
@@ -75,18 +72,6 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_IN_ASRC_CLK,			0x00 },
 	{ CS42L42_OUT_ASRC_CLK,			0x00 },
 	{ CS42L42_PLL_DIV_CFG1,			0x00 },
-	{ CS42L42_ADC_OVFL_STATUS,		0x00 },
-	{ CS42L42_MIXER_STATUS,			0x00 },
-	{ CS42L42_SRC_STATUS,			0x00 },
-	{ CS42L42_ASP_RX_STATUS,		0x00 },
-	{ CS42L42_ASP_TX_STATUS,		0x00 },
-	{ CS42L42_CODEC_STATUS,			0x00 },
-	{ CS42L42_DET_INT_STATUS1,		0x00 },
-	{ CS42L42_DET_INT_STATUS2,		0x00 },
-	{ CS42L42_SRCPL_INT_STATUS,		0x00 },
-	{ CS42L42_VPMON_STATUS,			0x00 },
-	{ CS42L42_PLL_LOCK_STATUS,		0x00 },
-	{ CS42L42_TSRS_PLUG_STATUS,		0x00 },
 	{ CS42L42_ADC_OVFL_INT_MASK,		0x01 },
 	{ CS42L42_MIXER_INT_MASK,		0x0F },
 	{ CS42L42_SRC_INT_MASK,			0x0F },
@@ -105,8 +90,6 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_PLL_CTL3,			0x10 },
 	{ CS42L42_PLL_CAL_RATIO,		0x80 },
 	{ CS42L42_PLL_CTL4,			0x03 },
-	{ CS42L42_LOAD_DET_RCSTAT,		0x00 },
-	{ CS42L42_LOAD_DET_DONE,		0x00 },
 	{ CS42L42_LOAD_DET_EN,			0x00 },
 	{ CS42L42_HSBIAS_SC_AUTOCTL,		0x03 },
 	{ CS42L42_WAKE_CTL,			0xC0 },
@@ -115,8 +98,6 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_MISC_DET_CTL,			0x03 },
 	{ CS42L42_MIC_DET_CTL1,			0x1F },
 	{ CS42L42_MIC_DET_CTL2,			0x2F },
-	{ CS42L42_DET_STATUS1,			0x00 },
-	{ CS42L42_DET_STATUS2,			0x00 },
 	{ CS42L42_DET_INT1_MASK,		0xE0 },
 	{ CS42L42_DET_INT2_MASK,		0xFF },
 	{ CS42L42_HS_BIAS_CTL,			0xC2 },
@@ -182,7 +163,6 @@ static const struct reg_default cs42l42_reg_defaults[] = {
 	{ CS42L42_ASP_RX_DAI1_CH2_AP_RES,	0x03 },
 	{ CS42L42_ASP_RX_DAI1_CH2_BIT_MSB,	0x00 },
 	{ CS42L42_ASP_RX_DAI1_CH2_BIT_LSB,	0x00 },
-	{ CS42L42_SUB_REVID,			0x03 },
 };
 
 static bool cs42l42_readable_register(struct device *dev, unsigned int reg)
-- 
2.11.0

