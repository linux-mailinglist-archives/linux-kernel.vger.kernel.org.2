Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455413E7C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243299AbhHJPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 11:39:51 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:18070 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243421AbhHJPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:38:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17AAlVvC027584;
        Tue, 10 Aug 2021 10:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7oKv+9b6tshIPwOXOVGxZ4H9DYz9zjTTyb8Hv227VWM=;
 b=d6GswugVG8Y/2zCsrPn6rGbHeZM9p6Qzrp8SroVK+9L8SGbT4i7EP6wjtb/PMmegHGcu
 KSexYSYQxzm8y9JrHDQeut0zbZG0zokRTqI6HZc4BcXnruDmZKgiqmS7Id0FQ1gjn6Jz
 izLbn37s4mp2BbCV/2c8z6M3lCMcOesYCRzHbCZgWa4tHuejG2F50RDo1z/TqF8TZnTE
 vjR3TWj64i6JaiACzRGasVtX3qKtjDPE3aBbyJnYzDIO13QPICnqNzfVx7h/UOe5na0o
 NGW2ysSIrNVeBN2nyHd4AVRsFUWfTwexh1HXIXvBa6J4QbrgGPlv46+slLYBjMPXDJ/I xg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3abr0u0e2c-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 10 Aug 2021 10:38:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 16:38:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 10 Aug 2021 16:38:05 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.221])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3347D45D;
        Tue, 10 Aug 2021 15:38:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 10/12] ASoC: cs42l42: Remove redundant pll_divout member
Date:   Tue, 10 Aug 2021 16:37:57 +0100
Message-ID: <20210810153759.24333-11-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810153759.24333-1-rf@opensource.cirrus.com>
References: <20210810153759.24333-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7cpweXGc8ToqzY8PMprF_eCd7hTDr19G
X-Proofpoint-GUID: 7cpweXGc8ToqzY8PMprF_eCd7hTDr19G
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108100099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that struct cs42l42_private has pll_config, the current PLL
configuration can be looked up directly in pll_ratio_table. This
makes the pll_divout member of cs42l42_private redundant since it
was only a copy of the value from pll_ratio_table.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 9 +++------
 sound/soc/codecs/cs42l42.h | 1 -
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 93a8fa290cb6..5c1a587af89e 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -725,10 +725,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
 					CS42L42_PLL_DIVOUT_MASK,
 					(pll_ratio_table[i].pll_divout * pll_ratio_table[i].n)
 					<< CS42L42_PLL_DIVOUT_SHIFT);
-				if (pll_ratio_table[i].n != 1)
-					cs42l42->pll_divout = pll_ratio_table[i].pll_divout;
-				else
-					cs42l42->pll_divout = 0;
 				snd_soc_component_update_bits(component,
 					CS42L42_PLL_CAL_RATIO,
 					CS42L42_PLL_CAL_RATIO_MASK,
@@ -994,12 +990,13 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
 				snd_soc_component_update_bits(component, CS42L42_PLL_CTL1,
 							      CS42L42_PLL_START_MASK, 1);
 
-				if (cs42l42->pll_divout) {
+				if (pll_ratio_table[cs42l42->pll_config].n > 1) {
 					usleep_range(CS42L42_PLL_DIVOUT_TIME_US,
 						     CS42L42_PLL_DIVOUT_TIME_US * 2);
+					regval = pll_ratio_table[cs42l42->pll_config].pll_divout;
 					snd_soc_component_update_bits(component, CS42L42_PLL_CTL3,
 								      CS42L42_PLL_DIVOUT_MASK,
-								      cs42l42->pll_divout <<
+								      regval <<
 								      CS42L42_PLL_DIVOUT_SHIFT);
 				}
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index a1e6d443b489..b10796d755ae 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -783,7 +783,6 @@ struct  cs42l42_private {
 	int bclk;
 	u32 sclk;
 	u32 srate;
-	u8 pll_divout;
 	u8 plug_state;
 	u8 hs_type;
 	u8 ts_inv;
-- 
2.11.0

