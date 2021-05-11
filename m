Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74A837A9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhEKOyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:54:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:19188 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231646AbhEKOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:54:13 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BEc74r018397;
        Tue, 11 May 2021 09:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=NGFQs4szDE7qpAzxSbblEOb/9ia2exDjAz1v7aEEdnY=;
 b=j7Xl3mkW8TkFDL7we0DuuUtGE0GlN+ViV2kOPVDic7fLrh5cv0gfyUq82w/TKKvywonI
 61/C3wgaVkErznLSikM+24myRCIbqVeZvHR7gcP7h6nDBMKX5++4u9t7iuH+TE7go532
 pUDv8w3n5taWUGPVR5M8QDty9CUW7Uur9RmkdZbEC85AAyMF2SK+tJuc+rkE0pyVZ7kU
 n7UsEfaJXhmUn/HuwURiMgJiM3hCO1s2qQBl2CyV3LuDQCz8bQbouftlKLsJdaNlb5XB
 isHNvvNSsQXZCluuv1ryYCginWjmdtTvYD0XDmmHQJZreEGtJTXg8tZLABkEPR+/BpUA ug== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 38f2d4sq24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 09:52:22 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 11 May
 2021 15:52:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 11 May 2021 15:52:21 +0100
Received: from vitaly-Inspiron-5415.ad.cirrus.com (unknown [198.90.238.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1446111D1;
        Tue, 11 May 2021 14:52:21 +0000 (UTC)
From:   Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: cs42l42: make HSBIAS_SENSE_EN optional
Date:   Tue, 11 May 2021 15:52:20 +0100
Message-ID: <20210511145220.125760-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _eqetRXTYpnFJQSTAm09hny6f8R1puwn
X-Proofpoint-ORIG-GUID: _eqetRXTYpnFJQSTAm09hny6f8R1puwn
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSBIAS_SENSE_EN configures HSBIAS output current sense through
the external 2.21-k resistor. HSBIAS_SENSE is hardware feature to reduce
the potential pop noise during the headset plug out slowly. But on some
platforms ESD voltage will affect it causing test to fail, especially
with CTIA headset type. For different hardware setups, a designer might
want to tweak default behavior.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 Documentation/devicetree/bindings/sound/cs42l42.txt | 7 +++++++
 sound/soc/codecs/cs42l42.c                          | 7 ++++++-
 sound/soc/codecs/cs42l42.h                          | 1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cs42l42.txt b/Documentation/devicetree/bindings/sound/cs42l42.txt
index 7dfaa2ab906f..5d416fdaf023 100644
--- a/Documentation/devicetree/bindings/sound/cs42l42.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l42.txt
@@ -81,6 +81,13 @@ Optional properties:
   < x1 x2 x3 x4 >
   Default = < 15 8 4 1>
 
+  - cirrus,hs-bias-sense-disable: This is boolean property. If present the
+  HSBIAS sense is disabled. Configures HSBIAS output current sense through
+  the external 2.21-k resistor. HSBIAS_SENSE is hardware feature to reduce
+  the potential pop noise during the headset plug out slowly. But on some
+  platforms ESD voltage will affect it causing test to fail, especially
+  with CTIA headset type. For different hardware setups, a designer might
+  want to tweak default behavior.
 
 Example:
 
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index d7fb6b38fd7c..5087c5b781f8 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1033,7 +1033,7 @@ static void cs42l42_process_hs_type_detect(struct cs42l42_private *cs42l42)
 			CS42L42_AUTO_HSBIAS_HIZ_MASK |
 			CS42L42_TIP_SENSE_EN_MASK |
 			CS42L42_HSBIAS_SENSE_TRIP_MASK,
-			(1 << CS42L42_HSBIAS_SENSE_EN_SHIFT) |
+			(cs42l42->hs_bias_sense_en << CS42L42_HSBIAS_SENSE_EN_SHIFT) |
 			(1 << CS42L42_AUTO_HSBIAS_HIZ_SHIFT) |
 			(0 << CS42L42_TIP_SENSE_EN_SHIFT) |
 			(3 << CS42L42_HSBIAS_SENSE_TRIP_SHIFT));
@@ -1808,6 +1808,11 @@ static int cs42l42_handle_device_data(struct device *dev,
 			(cs42l42->hs_bias_ramp_rate <<
 			CS42L42_HSBIAS_RAMP_SHIFT));
 
+	if (device_property_read_bool(dev, "cirrus,hs-bias-sense-disable"))
+		cs42l42->hs_bias_sense_en = 0;
+	else
+		cs42l42->hs_bias_sense_en = 1;
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 2e0d3836bd7e..24f7be228d5f 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -787,6 +787,7 @@ struct  cs42l42_private {
 	u8 bias_thresholds[CS42L42_NUM_BIASES];
 	u8 hs_bias_ramp_rate;
 	u8 hs_bias_ramp_time;
+	u8 hs_bias_sense_en;
 	u8 stream_use;
 };
 
-- 
2.25.1

