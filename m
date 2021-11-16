Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61304453764
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhKPQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:30:16 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:50922 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232376AbhKPQaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:30:02 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7FCki005416;
        Tue, 16 Nov 2021 10:27:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ObYlyY35mrZ2j4brNyTBAcoYXoMTcTAqrHnnuwZZOKU=;
 b=FRDpcuuh7Ab+y90RB6NoV2Pzk2mJPjlRn5P2ExVuO/8LngxRG9mCBKlpImYLJ84Y0340
 YTGVFaJPaNc8i/jPppbAf8DZGeNJiU3EDNF3NKx+IS/4/qm5ZdVr3HsszDT4pUhQ/rtw
 X++So6no3aRP11TmZGdpFesvqC8sOnvTZgvjl7UmDJFVDVEgYipe1QOmsdR5d1CsmxEY
 +rKqkmG8AZwXE9EPZQiJ8iK/MqwWfjEWQMaf9mDA03Z1KbvJefsQs2r+8dNmtsIi8Xhs
 rweYvpXUC6ZMXwPFmVk7DH2uxsleF+cUqXg7cJ1lCQdPyrqx3ZqcWZNWNMGOLFhEiOgR qg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt3be-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:27:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:26:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:26:58 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 26A2811DB;
        Tue, 16 Nov 2021 16:26:58 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 4/4] ASoC: cs42l42: Remove redundant pll_divout member
Date:   Tue, 16 Nov 2021 16:26:52 +0000
Message-ID: <20211116162652.45225-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116162652.45225-1-rf@opensource.cirrus.com>
References: <20211116162652.45225-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8Qg-uD-MuvEcyGcM2u1TK5tvl-Lna8Ip
X-Proofpoint-GUID: 8Qg-uD-MuvEcyGcM2u1TK5tvl-Lna8Ip
X-Proofpoint-Spam-Reason: safe
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
index 8efcee3e60d3..0c4303547fd8 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -734,10 +734,6 @@ static int cs42l42_pll_config(struct snd_soc_component *component)
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
@@ -1004,12 +1000,13 @@ static int cs42l42_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
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
index c8b3267a318b..75ade987d0db 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -845,7 +845,6 @@ struct  cs42l42_private {
 	int bclk;
 	u32 sclk;
 	u32 srate;
-	u8 pll_divout;
 	u8 plug_state;
 	u8 hs_type;
 	u8 ts_inv;
-- 
2.11.0

