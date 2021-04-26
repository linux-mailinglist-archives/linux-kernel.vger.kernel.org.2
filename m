Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA1F36B62C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhDZPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:54:20 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:2782 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234076AbhDZPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:54:16 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QFkovM015913;
        Mon, 26 Apr 2021 10:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=AyJ383LMuzzoOC2UIQl15v5XJ1bR4CB5EDGQYT0g7zk=;
 b=SL73nYI/c/RgVTQttbKfQrrbgckolUb7yLox+k/EeKrDIsGmA5A6Kk2hAJOeCt3s1cpe
 FP9U26XXY+iem8uDIRa/Ig/NSPQAh284O1PVjn+TRb1wa2kqgHkfuY4/Z1bLbJA+MuVg
 xGpy1sUu46u4hoNOAUf0PjdnLvw9fxv/wvzoiCr7xHW05OshnbH6SFY6wfqeJpLxMc+L
 0B+nQ+3dC+lLcVSpW/3Xzb1cY17zg2uFV00kO1lP8fXAwF7Ch4q8T/YNIXXot/7Un+Zs
 2EsxRGojn6gBluKz5vVcfZbGn/BhfPVxK3gAduxYXnXi97Hy/nqAGIGvtU5kA3tvPyyM 8A== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 385u9a8gs6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Apr 2021 10:53:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 26 Apr
 2021 16:53:10 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Mon, 26 Apr 2021 16:53:10 +0100
Received: from mail1.cirrus.com (unknown [198.61.65.115])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0C59911D1;
        Mon, 26 Apr 2021 15:53:10 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs42l42: Use device_property API instead of of_property
Date:   Mon, 26 Apr 2021 16:53:02 +0100
Message-ID: <20210426155303.853236-2-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426155303.853236-1-tanureal@opensource.cirrus.com>
References: <20210426155303.853236-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _toS_BS2aQAs_9-GcdUErKhYDtJo4PPk
X-Proofpoint-GUID: _toS_BS2aQAs_9-GcdUErKhYDtJo4PPk
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Use the device_property APIs so that the code will work on devicetree
and ACPI systems.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 60 +++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2143957b95e6..bce541735437 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -20,10 +20,9 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <sound/core.h>
@@ -1637,17 +1636,15 @@ static const unsigned int threshold_defaults[] = {
 	CS42L42_HS_DET_LEVEL_1
 };

-static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
+static int cs42l42_handle_device_data(struct device *dev,
 					struct cs42l42_private *cs42l42)
 {
-	struct device_node *np = i2c_client->dev.of_node;
 	unsigned int val;
-	unsigned int thresholds[CS42L42_NUM_BIASES];
+	u32 thresholds[CS42L42_NUM_BIASES];
 	int ret;
 	int i;

-	ret = of_property_read_u32(np, "cirrus,ts-inv", &val);
-
+	ret = device_property_read_u32(dev, "cirrus,ts-inv", &val);
 	if (!ret) {
 		switch (val) {
 		case CS42L42_TS_INV_EN:
@@ -1655,7 +1652,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			cs42l42->ts_inv = val;
 			break;
 		default:
-			dev_err(&i2c_client->dev,
+			dev_err(dev,
 				"Wrong cirrus,ts-inv DT value %d\n",
 				val);
 			cs42l42->ts_inv = CS42L42_TS_INV_DIS;
@@ -1668,8 +1665,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			CS42L42_TS_INV_MASK,
 			(cs42l42->ts_inv << CS42L42_TS_INV_SHIFT));

-	ret = of_property_read_u32(np, "cirrus,ts-dbnc-rise", &val);
-
+	ret = device_property_read_u32(dev, "cirrus,ts-dbnc-rise", &val);
 	if (!ret) {
 		switch (val) {
 		case CS42L42_TS_DBNCE_0:
@@ -1683,7 +1679,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			cs42l42->ts_dbnc_rise = val;
 			break;
 		default:
-			dev_err(&i2c_client->dev,
+			dev_err(dev,
 				"Wrong cirrus,ts-dbnc-rise DT value %d\n",
 				val);
 			cs42l42->ts_dbnc_rise = CS42L42_TS_DBNCE_1000;
@@ -1697,8 +1693,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			(cs42l42->ts_dbnc_rise <<
 			CS42L42_TS_RISE_DBNCE_TIME_SHIFT));

-	ret = of_property_read_u32(np, "cirrus,ts-dbnc-fall", &val);
-
+	ret = device_property_read_u32(dev, "cirrus,ts-dbnc-fall", &val);
 	if (!ret) {
 		switch (val) {
 		case CS42L42_TS_DBNCE_0:
@@ -1712,7 +1707,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			cs42l42->ts_dbnc_fall = val;
 			break;
 		default:
-			dev_err(&i2c_client->dev,
+			dev_err(dev,
 				"Wrong cirrus,ts-dbnc-fall DT value %d\n",
 				val);
 			cs42l42->ts_dbnc_fall = CS42L42_TS_DBNCE_0;
@@ -1726,13 +1721,12 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			(cs42l42->ts_dbnc_fall <<
 			CS42L42_TS_FALL_DBNCE_TIME_SHIFT));

-	ret = of_property_read_u32(np, "cirrus,btn-det-init-dbnce", &val);
-
+	ret = device_property_read_u32(dev, "cirrus,btn-det-init-dbnce", &val);
 	if (!ret) {
 		if (val <= CS42L42_BTN_DET_INIT_DBNCE_MAX)
 			cs42l42->btn_det_init_dbnce = val;
 		else {
-			dev_err(&i2c_client->dev,
+			dev_err(dev,
 				"Wrong cirrus,btn-det-init-dbnce DT value %d\n",
 				val);
 			cs42l42->btn_det_init_dbnce =
@@ -1743,14 +1737,13 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			CS42L42_BTN_DET_INIT_DBNCE_DEFAULT;
 	}

-	ret = of_property_read_u32(np, "cirrus,btn-det-event-dbnce", &val);
-
+	ret = device_property_read_u32(dev, "cirrus,btn-det-event-dbnce", &val);
 	if (!ret) {
 		if (val <= CS42L42_BTN_DET_EVENT_DBNCE_MAX)
 			cs42l42->btn_det_event_dbnce = val;
 		else {
-			dev_err(&i2c_client->dev,
-			"Wrong cirrus,btn-det-event-dbnce DT value %d\n", val);
+			dev_err(dev,
+				"Wrong cirrus,btn-det-event-dbnce DT value %d\n", val);
 			cs42l42->btn_det_event_dbnce =
 				CS42L42_BTN_DET_EVENT_DBNCE_DEFAULT;
 		}
@@ -1759,19 +1752,17 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			CS42L42_BTN_DET_EVENT_DBNCE_DEFAULT;
 	}

-	ret = of_property_read_u32_array(np, "cirrus,bias-lvls",
-				   (u32 *)thresholds, CS42L42_NUM_BIASES);
-
+	ret = device_property_read_u32_array(dev, "cirrus,bias-lvls",
+					     thresholds, ARRAY_SIZE(thresholds));
 	if (!ret) {
 		for (i = 0; i < CS42L42_NUM_BIASES; i++) {
 			if (thresholds[i] <= CS42L42_HS_DET_LEVEL_MAX)
 				cs42l42->bias_thresholds[i] = thresholds[i];
 			else {
-				dev_err(&i2c_client->dev,
-				"Wrong cirrus,bias-lvls[%d] DT value %d\n", i,
+				dev_err(dev,
+					"Wrong cirrus,bias-lvls[%d] DT value %d\n", i,
 					thresholds[i]);
-				cs42l42->bias_thresholds[i] =
-					threshold_defaults[i];
+				cs42l42->bias_thresholds[i] = threshold_defaults[i];
 			}
 		}
 	} else {
@@ -1779,8 +1770,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			cs42l42->bias_thresholds[i] = threshold_defaults[i];
 	}

-	ret = of_property_read_u32(np, "cirrus,hs-bias-ramp-rate", &val);
-
+	ret = device_property_read_u32(dev, "cirrus,hs-bias-ramp-rate", &val);
 	if (!ret) {
 		switch (val) {
 		case CS42L42_HSBIAS_RAMP_FAST_RISE_SLOW_FALL:
@@ -1800,7 +1790,7 @@ static int cs42l42_handle_device_data(struct i2c_client *i2c_client,
 			cs42l42->hs_bias_ramp_time = CS42L42_HSBIAS_RAMP_TIME3;
 			break;
 		default:
-			dev_err(&i2c_client->dev,
+			dev_err(dev,
 				"Wrong cirrus,hs-bias-ramp-rate DT value %d\n",
 				val);
 			cs42l42->hs_bias_ramp_rate = CS42L42_HSBIAS_RAMP_SLOW;
@@ -1930,11 +1920,9 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 			(1 << CS42L42_ADC_PDN_SHIFT) |
 			(0 << CS42L42_PDN_ALL_SHIFT));

-	if (i2c_client->dev.of_node) {
-		ret = cs42l42_handle_device_data(i2c_client, cs42l42);
-		if (ret != 0)
-			goto err_disable;
-	}
+	ret = cs42l42_handle_device_data(&i2c_client->dev, cs42l42);
+	if (ret != 0)
+		goto err_disable;

 	/* Setup headset detection */
 	cs42l42_setup_hs_type_detect(cs42l42);
--
2.31.1

