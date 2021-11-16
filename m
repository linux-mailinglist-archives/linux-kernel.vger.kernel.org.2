Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5904537CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 17:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhKPQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 11:42:15 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:38424 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233055AbhKPQmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 11:42:09 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7FClZ005416;
        Tue, 16 Nov 2021 10:39:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=Oy3saM2UmplLoigbbp0tgQUHw4B/9OgUQ+Nm+9/Z7yg=;
 b=TMJe97G5JB1HOo4aohWmAgiVXD87B3oIKByXTTN42gK5wdKwscUFYmfWjeG472b3Hnqn
 LauMQ6l3Vt8VkA/T9vZWQwlfPuTubPfokokWdprkgzxCaTDSIPybBJsmaMmOKvbhdBZU
 hOGdBQIf7Ch3VNXhubj1pjy1BqOD0e7TehCKzcodNbdtf+YrPquuA0XZ2Qove3UhaOhG
 8n0BOvodfY6fj6nCppBCMHX0IltW/XUj2QqlZC5EspNC9QxOSMC/Ia+252PkYeN8wSHy
 WgElHo1ZRL40iqj26HXu4AWE/5AcGkgWGzWWerISqzHWnEQ1ivME85+tusG/gLyuRN0x Lg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3cbdjgt3vp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Nov 2021 10:39:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:39:04 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 16 Nov 2021 16:39:04 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.41])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4592E11DB;
        Tue, 16 Nov 2021 16:39:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/4] ASoC: cs42l42: Remove redundant writes to DETECT_MODE
Date:   Tue, 16 Nov 2021 16:38:58 +0000
Message-ID: <20211116163901.45390-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211116163901.45390-1-rf@opensource.cirrus.com>
References: <20211116163901.45390-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hYN4e2qHBENLJWN5pcR6eQXNib1JVcoy
X-Proofpoint-GUID: hYN4e2qHBENLJWN5pcR6eQXNib1JVcoy
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple places where DETECT_MODE is included in a register
write, but in every case it is written as 0. Removing these redundant
writes makes the code less cluttered and also makes it obvious that
DETECT_MODE is never changed.

A single initialization to 0 is added to cs42l42_setup_hs_type_detect().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 56804a3f285e..92bdc3a355ff 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1270,10 +1270,8 @@ static void cs42l42_process_hs_type_detect(struct cs42l42_private *cs42l42)
 		/* Turn on level detect circuitry */
 		regmap_update_bits(cs42l42->regmap,
 			CS42L42_MISC_DET_CTL,
-			CS42L42_DETECT_MODE_MASK |
 			CS42L42_HSBIAS_CTL_MASK |
 			CS42L42_PDN_MIC_LVL_DET_MASK,
-			(0 << CS42L42_DETECT_MODE_SHIFT) |
 			(3 << CS42L42_HSBIAS_CTL_SHIFT) |
 			(0 << CS42L42_PDN_MIC_LVL_DET_SHIFT));
 
@@ -1300,10 +1298,8 @@ static void cs42l42_process_hs_type_detect(struct cs42l42_private *cs42l42)
 		/* Make sure button detect and HS bias circuits are off */
 		regmap_update_bits(cs42l42->regmap,
 			CS42L42_MISC_DET_CTL,
-			CS42L42_DETECT_MODE_MASK |
 			CS42L42_HSBIAS_CTL_MASK |
 			CS42L42_PDN_MIC_LVL_DET_MASK,
-			(0 << CS42L42_DETECT_MODE_SHIFT) |
 			(1 << CS42L42_HSBIAS_CTL_SHIFT) |
 			(1 << CS42L42_PDN_MIC_LVL_DET_SHIFT));
 	}
@@ -1351,10 +1347,8 @@ static void cs42l42_init_hs_type_detect(struct cs42l42_private *cs42l42)
 	/* Make sure button detect and HS bias circuits are off */
 	regmap_update_bits(cs42l42->regmap,
 				CS42L42_MISC_DET_CTL,
-				CS42L42_DETECT_MODE_MASK |
 				CS42L42_HSBIAS_CTL_MASK |
 				CS42L42_PDN_MIC_LVL_DET_MASK,
-				(0 << CS42L42_DETECT_MODE_SHIFT) |
 				(1 << CS42L42_HSBIAS_CTL_SHIFT) |
 				(1 << CS42L42_PDN_MIC_LVL_DET_SHIFT));
 
@@ -1398,10 +1392,8 @@ static void cs42l42_init_hs_type_detect(struct cs42l42_private *cs42l42)
 	/* Power up HS bias to 2.7V */
 	regmap_update_bits(cs42l42->regmap,
 				CS42L42_MISC_DET_CTL,
-				CS42L42_DETECT_MODE_MASK |
 				CS42L42_HSBIAS_CTL_MASK |
 				CS42L42_PDN_MIC_LVL_DET_MASK,
-				(0 << CS42L42_DETECT_MODE_SHIFT) |
 				(3 << CS42L42_HSBIAS_CTL_SHIFT) |
 				(1 << CS42L42_PDN_MIC_LVL_DET_SHIFT));
 
@@ -1448,10 +1440,8 @@ static void cs42l42_cancel_hs_type_detect(struct cs42l42_private *cs42l42)
 	/* Ground HS bias */
 	regmap_update_bits(cs42l42->regmap,
 				CS42L42_MISC_DET_CTL,
-				CS42L42_DETECT_MODE_MASK |
 				CS42L42_HSBIAS_CTL_MASK |
 				CS42L42_PDN_MIC_LVL_DET_MASK,
-				(0 << CS42L42_DETECT_MODE_SHIFT) |
 				(1 << CS42L42_HSBIAS_CTL_SHIFT) |
 				(1 << CS42L42_PDN_MIC_LVL_DET_SHIFT));
 
@@ -1829,6 +1819,9 @@ static void cs42l42_setup_hs_type_detect(struct cs42l42_private *cs42l42)
 
 	cs42l42->hs_type = CS42L42_PLUG_INVALID;
 
+	regmap_update_bits(cs42l42->regmap, CS42L42_MISC_DET_CTL,
+			   CS42L42_DETECT_MODE_MASK, 0);
+
 	/* Latch analog controls to VP power domain */
 	regmap_update_bits(cs42l42->regmap, CS42L42_MIC_DET_CTL1,
 			CS42L42_LATCH_TO_VP_MASK |
-- 
2.11.0

